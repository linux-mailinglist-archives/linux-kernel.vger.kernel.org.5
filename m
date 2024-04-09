Return-Path: <linux-kernel+bounces-137396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC8289E175
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997E81C2281F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AD3155A3D;
	Tue,  9 Apr 2024 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="HL1a5/OJ"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A093153BD2;
	Tue,  9 Apr 2024 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683334; cv=none; b=Qgx76LMlMRgCMjNXfHjLnC4zE2ipxxq0xQpKtWHizviB4zebj/QnjwpP6LT6UyVc7puryI0nH2gA59Xol6H6l9bfyAf4v3c6//PtdzqYQNVGtbkxv7c//cxU/i3nRXuErf/ajJVzxcIJwf7QqWcsKjUIcJIFoZQOsFWocu+rnmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683334; c=relaxed/simple;
	bh=FV8T5ZxL0VBdZ1fdF5/j1pGUzTmlXKhQ8ugt2RX6Zg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RAgwIviN48LiUN2otqfii1p1Gns7wbDc+D2b8dYSDsoLksdYRp9aJPAJeI3lDtvm+j1/MaUQQJMDQKT+/9VC9VfR4dFHtsaVYI+XuelT5RDWVNyEoQawcYQgcdC9ln5UjJEPaPiY5MlY207wWrRsLWhOBWsijUGWq//sfKNeS+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=HL1a5/OJ; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VDXnp0mvzz6Cnk8s;
	Tue,  9 Apr 2024 17:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712683320; x=1715275321; bh=BmiyWVLUgBdQ3Xc8G+8c67Tu
	AAXUVgBLzSiNGT/ygcg=; b=HL1a5/OJfAWe2ZSrZjpdwgD0xChks8N0+uSfVYeK
	PbBlFE7LKjx4z7MkRPw11p50qXiK2/rZKN+9uUNnfDiDtrlVdgkNehUd4NP+I04q
	TdNVQA9swVyvKDg1/avtelf6Ad2tHSD8xgc03XfLkeSVG/WQQiY5GJJzDECvdjrG
	frfzkz6SkHBZFgs8IHHba7dg3MHbNel8OYwZsssRwL+f5okoj45ehVv19ILeeTmS
	WgxUwaOhCNoInn85Uw4Bd2lpQeHC9/flBEj8PY0yzC4L4euz/e6ZNZFogX0L+m+B
	ETjuqZxaVdlrsSPiytR6W1Vebf6tPZpF8Xx04Pv2hL5wqA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TdnRVpxAjYXN; Tue,  9 Apr 2024 17:22:00 +0000 (UTC)
Received: from [100.125.77.89] (unknown [104.132.0.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VDXng36pdz6Cnk8m;
	Tue,  9 Apr 2024 17:21:59 +0000 (UTC)
Message-ID: <7b22b4b5-ddf9-42e3-9603-4f2422c31333@acm.org>
Date: Tue, 9 Apr 2024 10:21:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: ufs: core: changing the status to check inflight
Content-Language: en-US
To: SEO HOYOUNG <hy50.seo@samsung.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
 kwangwon.min@samsung.com, kwmad.kim@samsung.com, sh425.lee@samsung.com,
 quic_nguyenb@quicinc.com, cpgs@samsung.com, h10.kim@samsung.com
References: <CGME20240409062901epcas2p3eb8f13336c2dbf978db1ce980a75b3cb@epcas2p3.samsung.com>
 <20240409063254.145363-1-hy50.seo@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240409063254.145363-1-hy50.seo@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 23:32, SEO HOYOUNG wrote:
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 21429eec1b82..c940f52d9003 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -3082,16 +3082,7 @@ static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
>    */
>   bool ufshcd_cmd_inflight(struct scsi_cmnd *cmd)
>   {
> -	struct request *rq;
> -
> -	if (!cmd)
> -		return false;
> -
> -	rq = scsi_cmd_to_rq(cmd);
> -	if (!blk_mq_request_started(rq))
> -		return false;
> -
> -	return true;
> +	return cmd && (blk_mq_rq_state(scsi_cmd_to_rq(cmd)) == MQ_RQ_IN_FLIGHT);
>   }

There are superfluous parentheses in the above return statement. It is
unusual in Linux kernel code to surround equality tests with
parentheses.

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

