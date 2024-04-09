Return-Path: <linux-kernel+bounces-137692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3070C89E612
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3499B22BE6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F022158DC8;
	Tue,  9 Apr 2024 23:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RPjEU8sn"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2825158DB1;
	Tue,  9 Apr 2024 23:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705280; cv=none; b=rfGvuo8aD7IfxPH46mcZrfK3mYENEG8m8v4SSHm6am6iJTj8Yr+cD6SHl0CnVP2k2l1Ed8YmeOH5zdTb1iientcoQpLFwlPxdj2xGA1w8fQe7ghgQ9KqtrA3iVWx73KjI1h792q1YYmsdIszSYCIpiSQDwb7fT8xtuCQVUbsDKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705280; c=relaxed/simple;
	bh=9N1x6vVhyTE6Jp+O4+IgUFScstE7oh5a1d9B61+MizE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rvvnws7TVGVbWblaOZsrHd02Gwl8RZS5Ii+VQYJJ4FYvTqH6Vy6mykREct1MwXMe7dWmhrS1URM9lElUeXTbJpgMdNEXn1WK8TQWt8BePwbuMavko2b6tuNvdI70o3XZ3cJAsK6RYrTyjZJvb8M5dF41iFqVnOAWa1kDwqGBuJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RPjEU8sn; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VDhvx0WRzz6Cnk8s;
	Tue,  9 Apr 2024 23:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712705273; x=1715297274; bh=QUAKIGsvSxfZk359RZHOvv+y
	iXTmsMPY7rIXyiSGUfI=; b=RPjEU8sn4jRk9s1PiOSdiLJBBX21ZLWEne9E96VX
	sAaEBH40Y9p7ReuuDOVSUKeVHEaczGO8LCMmGJv9I8/1Y3L9iOtp8vtTh7P8NkjO
	ZGo6j93YOEdHmk4lMGo+zTRly9w0/0MV7ODtOnpTnblJUCVTW/xwnGFPQ8HHvhU5
	L6NrJ4xGg7h+NJ4IKpVcALaHfxPunHKg75wHUj7oJH9GuYuiSGRAl417/34q7X/6
	uYszys7WPjn0zkXIm1e86VB15TRKPTkDJd49ioPDkGfFIkShtNoH2ISrQuYu+FAR
	VhYVq+FnBK6ZwHH1umB1F/KLH2pLeopo3CbZY72I3vUP4w==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wQuuyXwLUbEW; Tue,  9 Apr 2024 23:27:53 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VDhvr5xWCz6Cnk8m;
	Tue,  9 Apr 2024 23:27:52 +0000 (UTC)
Message-ID: <37c51970-1408-4a71-926a-780c663e5572@acm.org>
Date: Tue, 9 Apr 2024 16:27:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] scsi: ufs: Remove support for old UFSHCI versions
To: Avri Altman <avri.altman@wdc.com>,
 "James E . J . Bottomley" <jejb@linux.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Bean Huo <beanhuo@micron.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240407060412.856-1-avri.altman@wdc.com>
 <20240407060412.856-2-avri.altman@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240407060412.856-2-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/6/24 11:04 PM, Avri Altman wrote:
> UFS spec version 2.1 was published more than 10 years ago. It is
> vanishingly unlikely that even there are out there platforms that uses
> earlier host controllers, let alone that those ancient platforms will
> ever run a V6.10 kernel.  To be extra cautious, leave out support for
> UFSHCI2.0 as well, and just remove support of host controllers prior
> to UFS2.0.
> 
> This patch removes some legacy tuning calls that no longer apply.
> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> Acked-by: Bean Huo <beanhuo@micron.com>
> ---
>   drivers/ufs/core/ufshcd.c   | 158 +++---------------------------------
>   drivers/ufs/host/ufs-qcom.c |   3 +-
>   include/ufs/ufshcd.h        |   2 -
>   include/ufs/ufshci.h        |  13 +--
>   4 files changed, 15 insertions(+), 161 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 62c8575f2c67..c72ef87ea867 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -748,8 +748,6 @@ static int ufshcd_wait_for_register(struct ufs_hba *hba, u32 reg, u32 mask,
>    */
>   static inline u32 ufshcd_get_intr_mask(struct ufs_hba *hba)
>   {
> -	if (hba->ufs_version == ufshci_version(1, 0))
> -		return INTERRUPT_MASK_ALL_VER_10;
>   	if (hba->ufs_version <= ufshci_version(2, 0))
>   		return INTERRUPT_MASK_ALL_VER_11;

Is the patch description in sync with the patch itself? The patch
description says that support for UFSHCI 2.0 is removed while the
above if-condition only evaluates to true for UFSHCI 2.0 and older
controllers.

Thanks,

Bart.


