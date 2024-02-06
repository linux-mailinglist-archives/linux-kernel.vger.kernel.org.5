Return-Path: <linux-kernel+bounces-54635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89E384B1CB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5271F2498F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F38E12DD86;
	Tue,  6 Feb 2024 10:00:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CA914265
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213625; cv=none; b=MICdledOrYlKh/G//fnPzu+tA8E2v9zJ42o0dgJvd1HdO4WYAyXvG5lR5a6BSHa2YbekRe9JSs3Z+vSEueOC/89lDigl1pehORbX/eU0vu0026rWZTyKIDZwo8+/liLOjtrj9IRAIxuEKIrGGTzUK2v5DjSXX/7R74k17p9wU7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213625; c=relaxed/simple;
	bh=x0IM0g07rijXhIpSmLDBsct0Y6ERlj/neCBrqrhvZcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APdSSJLudrsTuUG50n8A2qLlQz2vtSAqRNkoBRonWz5jth0UWXUunIZ0Y5AMv0cXHcJzvj0+fjVXw4WPLvx+G4US+t75LDHD46ckePY4rpJ9V0qGTVXMcc/9qb3fh2Emi2uBg4Ti6mziL/YS5S4+6/ow37AlSCs++MQIKQIHivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5C431FB;
	Tue,  6 Feb 2024 02:01:04 -0800 (PST)
Received: from [10.1.31.46] (010265703453.arm.com [10.1.31.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BFDD3F641;
	Tue,  6 Feb 2024 02:00:21 -0800 (PST)
Message-ID: <dd862d7a-11bd-482a-b248-60d4616fb6ef@arm.com>
Date: Tue, 6 Feb 2024 10:00:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/arm-cmn: Workaround AmpereOneX errata AC04_MESH_1
 (incorrect child count)
Content-Language: en-GB
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240205194655.1567434-1-ilkka@os.amperecomputing.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240205194655.1567434-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-05 7:46 pm, Ilkka Koskinen wrote:
> AmpereOneX mesh implementation has a bug in HN-P nodes that makes them
> report incorrect child count. The failing crosspoints report 8 children
> while they only have two.

Ooh, fun :)

> When the driver tries to access the inexistent child nodes, it believes it
> has reached an invalid node type and probing fails. The workaround is to
> ignore those incorrect child nodes and continue normally.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   drivers/perf/arm-cmn.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index c584165b13ba..97fed8ec3693 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -2168,6 +2168,23 @@ static enum cmn_node_type arm_cmn_subtype(enum cmn_node_type type)
>   	}
>   }
>   
> +static inline bool arm_cmn_is_ampereonex_bug(const struct arm_cmn *cmn,
> +					     struct arm_cmn_node *dn,
> +					     u16 child_count, int child)
> +{
> +	/*
> +	 * The bug occurs only when a crosspoint reports 8 children
> +	 * while it only has two HN-P child nodes.
> +	 */
> +	dn -= 2;
> +
> +	if (arm_cmn_model(cmn) == CMN650 && child_count == 8 &&
> +	    child == 2 && dn->type == CMN_TYPE_HNP)
> +		return true;
> +
> +	return false;
> +}
> +
>   static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>   {
>   	void __iomem *cfg_region;
> @@ -2292,6 +2309,14 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>   
>   		for (j = 0; j < child_count; j++) {
>   			reg = readq_relaxed(xp_region + child_poff + j * 8);
> +			if (reg == 0)
> +				if (arm_cmn_is_ampereonex_bug(cmn, dn, child_count, j))
> +					/*
> +					 * We know there are only two real children and the rest 6
> +					 * are inexistent. Thus, we can skip the rest of the loop
> +					 */
> +					break;
> +

TBH I don't see much harm in taking an even simpler approach, so I'd be
inclined to not bother being all that specific beyond documenting it,
something like the below:

Cheers,
Robin.

----->8-----

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index c584165b13ba..7e3aa7e2345f 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2305,6 +2305,17 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
  				dev_dbg(cmn->dev, "ignoring external node %llx\n", reg);
  				continue;
  			}
+			/*
+			 * AmpereOneX erratum AC04_MESH_1 makes some XPs report a bogus
+			 * child count larger than the number of valid child pointers.
+			 * A child offset of 0 can only occur on CMN-600; otherwise it
+			 * would imply the root node being its own grandchild, which
+			 * we can safely dismiss in general.
+			 */
+			if (reg == 0 && cmn->part != PART_CMN600) {
+				dev_dbg(cmn->dev, "bogus child pointer?\n");
+				continue;
+			}
  
  			arm_cmn_init_node_info(cmn, reg & CMN_CHILD_NODE_ADDR, dn);
  

