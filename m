Return-Path: <linux-kernel+bounces-59690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D57284FA78
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DCA91F2260B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9F77B3D4;
	Fri,  9 Feb 2024 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHwCJupY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49C1364D2
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498176; cv=none; b=HmW9z2wHdk3urmqJLVB/aMXSKUVHmZrorBlvNUi+WyQpSXcsr2VHQ6Av5vwWiJ9weBkSHsHx9jdsUjDqm86rtFe/COObMe4YPFPdOetxc/aadi5eERZT+I6leU/0D8psH6WII5oX315Flsmx3je087ziRdh0ZsRGBugIPcLxcPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498176; c=relaxed/simple;
	bh=HV4+Vvjfg7zEh12UhMMs9hnFdl+LJe31OtHo4omL6w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsPanJ6P0IJZ9A/ilRe5H1MdiOFEickWy6quN8OZm7gQNAOM5BJ4cmumN0TysJLDsxrvbh8VEjL08QIivryUCqwSbFjdAXf1mkFX6uQOV1OLQ/uBCPmKqhQ22O6aI3VKAD3OG1KHQqz5EjClLBMuaBVNKG79X0iHT+0CsSXwhx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHwCJupY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130E1C433F1;
	Fri,  9 Feb 2024 17:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707498176;
	bh=HV4+Vvjfg7zEh12UhMMs9hnFdl+LJe31OtHo4omL6w8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pHwCJupYpd7Blvl75suI0jfQmiSuuXMLt9V4RYiILd5j3qhEemGZWtsZ+uSsM5d1R
	 5+Y2CJL1iZvH0nrdrj74FwumEVTaIkaxDLjeC22ggw99AB30xlms5VrdSmuz0psju7
	 f+5XfZ950hiB6GCywVxTO19u9Og7dJdkp5+LhBy1oxf1RuvdD07bSfpQ67RtuUctrA
	 E2anDHDgTz4SI87IcjNs0X0pqxR1tFlmePffVTXuoMSRPFMtsX6fkCzttv/X05yvbh
	 47tFEhdUeaA/9VRLvRB0eJnwEAezMpZscxafJ1ZXe9jvs3qho4eHEpv/MiXK7jIA9K
	 cINmRgcFF08Ww==
Date: Fri, 9 Feb 2024 17:02:51 +0000
From: Will Deacon <will@kernel.org>
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Workaround AmpereOneX errata AC04_MESH_1
 (incorrect child count)
Message-ID: <20240209170251.GA25069@willie-the-truck>
References: <20240205194655.1567434-1-ilkka@os.amperecomputing.com>
 <dd862d7a-11bd-482a-b248-60d4616fb6ef@arm.com>
 <8bf2275a-dea7-1817-731a-7d47d3b01d13@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bf2275a-dea7-1817-731a-7d47d3b01d13@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Feb 06, 2024 at 01:04:27PM -0800, Ilkka Koskinen wrote:
> On Tue, 6 Feb 2024, Robin Murphy wrote:
> > On 2024-02-05 7:46 pm, Ilkka Koskinen wrote:
> > diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> > index c584165b13ba..7e3aa7e2345f 100644
> > --- a/drivers/perf/arm-cmn.c
> > +++ b/drivers/perf/arm-cmn.c
> > @@ -2305,6 +2305,17 @@ static int arm_cmn_discover(struct arm_cmn *cmn,
> > unsigned int rgn_offset)
> > 				dev_dbg(cmn->dev, "ignoring external node %llx\n", reg);
> > 				continue;
> > 			}
> > +			/*
> > +			 * AmpereOneX erratum AC04_MESH_1 makes some XPs report a bogus
> > +			 * child count larger than the number of valid child pointers.
> > +			 * A child offset of 0 can only occur on CMN-600; otherwise it
> > +			 * would imply the root node being its own grandchild, which
> > +			 * we can safely dismiss in general.
> > +			 */
> > +			if (reg == 0 && cmn->part != PART_CMN600) {
> > +				dev_dbg(cmn->dev, "bogus child pointer?\n");
> > +				continue;
> > +			}
> >  			arm_cmn_init_node_info(cmn, reg & CMN_CHILD_NODE_ADDR, dn);
> > 
> 
> Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Mind sending that out as a proper patch that I can pick up, please?

Cheers,

Will

