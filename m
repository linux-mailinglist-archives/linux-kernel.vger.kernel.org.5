Return-Path: <linux-kernel+bounces-133483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7658189A45E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16FCC1F2108A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3C217279B;
	Fri,  5 Apr 2024 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="hGoBIkun"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1491A1EB36;
	Fri,  5 Apr 2024 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712342635; cv=none; b=FiR6yHUT3ucg0h5/XSFVQdZkt7oHkPUqQKW2AxN1hCiVaqo2xzIG8Bo4qi4Rpvu+YMuahQWSiKtLqSOjynWdcmrgxFptSfTmwwaGWlGVpnoKu99njbHKlnELVl8KICeYlw8sFRwqMuSAi3ARiiRFlhhBEevqqY8BDZZ7sJt+xw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712342635; c=relaxed/simple;
	bh=ZEC1qMsL2GXr2LN1cOLgyDd0sOBWxyJv/iuho8smCfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KfRsmM+3D2i6CuUO6PeYZ3HM8/OzqE4Z/zDN533Jo798vmBCctZaisfYNHwwcEsxT92INRLfhozfp39WD1dBHbkpXiL1XdChGj75LAXgA5TUme+OmJ1Hb7dMb0HBHh1pTAH+BWnyne1TweQjKdXfAqe//2p+Rl+J4LIk+HbMj7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=hGoBIkun; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VB6lX1bTlz6ChQsS;
	Fri,  5 Apr 2024 18:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712342497; x=1714934498; bh=VNC7WePIHudWvJ0AAT9LZu0v
	6qRSozA1WrVYvu0F6II=; b=hGoBIkunSTVoGIkPld3Aw27ohCl1CyzhZ/kiGQH4
	NBK/EOhy7WJgdJRDY37TbiJWLu4ordrIJrk0KgoozgD+oyo9/OE0F0K2xTDGt6IK
	WxeUC2qVXW18x0+J21Dkn9hbXrMDjElDiyRaCunipep5sFaJBGk1g+yfJevNq/Wm
	LEBwmMyP3TK/eSRGzXQtAdqzD5PKcdMJF8z+CH8MwIigJ+KP8RSYfGqRRj2gWJy/
	5zecRrtx0YxQaOgFWGROMwC4oasM5eGyLO9xgPCv7KRfGVWpIDC5jEdweZnKfiqp
	MWgyuqRneOsuatsnJqkjozSjZXuOSStLlhwvT4JcI+c5vA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id frwn6AeDHquf; Fri,  5 Apr 2024 18:41:37 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VB6lM6wGRz6ChQs1;
	Fri,  5 Apr 2024 18:41:35 +0000 (UTC)
Message-ID: <a70f1a3d-1ec9-496b-9b93-5d4b06b4f967@acm.org>
Date: Fri, 5 Apr 2024 11:41:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] scsi: ufs: core: changing the status to check inflight
Content-Language: en-US
To: SEO HOYOUNG <hy50.seo@samsung.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
 kwangwon.min@samsung.com, kwmad.kim@samsung.com, sh425.lee@samsung.com,
 quic_nguyenb@quicinc.com, cpgs@samsung.com, h10.kim@samsung.com
References: <CGME20240405071217epcas2p470124e9f6e9066cb5cdc7f78557042e3@epcas2p4.samsung.com>
 <20240405071601.84337-1-hy50.seo@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240405071601.84337-1-hy50.seo@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/5/24 00:16, SEO HOYOUNG wrote:
> According to below the patch applied, lrbp->cmd do not will NULL
> after call release_scsi_cmd()
> So check the rq->state unconditionally even if it is completed normally
> in ufshcd_cmd_inflight()
> 
> If occurred abort status and tm_cmd timeout, will run err_handler
> for re-init UFS.
> Then err_handler will check pending request for clearing cmd.
> At that time, check if the state of rq is not MQ_RQ_IDLE.
> In other words, check if it is MQ_RQ_COMPLETE or MQ_RQ_IN_FLIGHT.
> If rq->state is MQ_RQ_COMPLETE, it is already completed in the block,
> so there is no need to process the queue.

The above description does not explain the motivation for this patch
very well. How about the following description?

"ufshcd_cmd_inflight() is used to check whether or not a command is
in progress. Make it skip commands that have already completed by
changing the !blk_mq_request_started(rq) check into blk_mq_rq_state(rq) 
!= MQ_RQ_IN_FLIGHT. We cannot rely on lrbp->cmd since lrbp->cmd is not
cleared when a command completes."

> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 21429eec1b82..3f47ea584cb1 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -3088,7 +3088,7 @@ bool ufshcd_cmd_inflight(struct scsi_cmnd *cmd)
>   		return false;
>   
>   	rq = scsi_cmd_to_rq(cmd);
> -	if (!blk_mq_request_started(rq))
> +	if (blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT)
>   		return false;
>   
>   	return true;

Please convert the two return statements into a single return statement,
e.g. as follows:

	return cmd &&
	    blk_mq_rq_state(scsi_cmd_to_rq(cmd)) == MQ_RQ_IN_FLIGHT;

Thanks,

Bart.

