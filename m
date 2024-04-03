Return-Path: <linux-kernel+bounces-130709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65947897BE0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04371F25F26
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1FF15698B;
	Wed,  3 Apr 2024 23:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="wjnAgY7D"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8278A156242;
	Wed,  3 Apr 2024 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712185768; cv=none; b=Pf1CM7O8bqsgUKujaiOMrWGL6F7xr3C6leTfqbpNj7Q7UjJOSLWi7kY1LvCmYrmucCpRlo6QdHNJ4wL1gjgZuFHXwxIfIYVWr9jwUgMPlFdUUQZZjzNNcDN0pkfWjpxEMN/QWsdC8qI/vE3OndnytcyUn5dOY00+k8nAetEJXvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712185768; c=relaxed/simple;
	bh=JZaWqQe7qrNbxm00OG1kS0UmQaJfbXU4V+FHQI8UPkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPMLij3NeLeEzubPrDLvxSiq3XJ3YvRMWmL/NBlv56X4FoCeyZCGUAJ3sj/N3OCbK/rNlBUBVbBPmqT+yvOMMPK0iSEsE8ciJ7+VqZJ9s8XJio95oDbjwcSgMyAVQCP8r6mI0UEid3lGSLD6l9UOqOkD8zrppTHpdWOLHf8fE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=wjnAgY7D; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V90nK18LBz6Cnk95;
	Wed,  3 Apr 2024 23:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712185760; x=1714777761; bh=2iktK6EUqVrZltsHFkD8iQNl
	AoVI85pdNh4NREaFQQk=; b=wjnAgY7DJk3eQXExyR6DTTtNWIrOEQzEVZZdTr2s
	LL/yv4n4CccIVSbw9qZvw5TVwBKV89u/eOhyjdmq+AX0yqdhbPXP9P7pUXql/3hk
	p3S/yYmLN9h7lC7r35RNx6gLfn6CgtaTv1iL0SHLHX5+NyzbwxtTJ7ERwOY54GIv
	mLjV6v2/hOrvV1nHYzwM74OhzhFHz/W7L0mspWPoNEVxNxNNs2K4mS58U+mck2Kx
	XstsgagdajwpgE6YxNAciIB9tNUOXdm1jBZs4hb+6bOR6epOiYs8pDmgYSnVpwhD
	a4Ms7a25LUr+PrjYXJOeXSowGdWX+FFRz2xbIaVekqswkw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id z13YD-kBBspr; Wed,  3 Apr 2024 23:09:20 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V90nB3PMYz6Cnk94;
	Wed,  3 Apr 2024 23:09:18 +0000 (UTC)
Message-ID: <13a50e06-2b35-4cc6-a3ea-d6e070195db7@acm.org>
Date: Wed, 3 Apr 2024 16:09:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: lpfc: Fix a possible null pointer dereference
To: Huai-Yuan Liu <qq810974084@gmail.com>, james.smart@broadcom.com,
 dick.kennedy@broadcom.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@outlook.com
References: <20240403014006.969441-1-qq810974084@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240403014006.969441-1-qq810974084@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/2/24 6:40 PM, Huai-Yuan Liu wrote:
> In function lpfc_xcvr_data_show, the memory allocation with kmalloc might
> fail, thereby making rdp_context a null pointer. In the following context
> and functions that use this pointer, there are dereferencing operations,
> leading to null pointer dereference.
> 
> To fix this issue, a null pointer check should be added. If it is null,
> write error message and jump to 'out_free_rdp'.
> 
> Fixes: 479b0917e447 ("scsi: lpfc: Create a sysfs entry called lpfc_xcvr_data for transceiver info")
> Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
> ---
>   drivers/scsi/lpfc/lpfc_attr.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
> index b1c9107d3408..b11e5114b7f2 100644
> --- a/drivers/scsi/lpfc/lpfc_attr.c
> +++ b/drivers/scsi/lpfc/lpfc_attr.c
> @@ -1904,6 +1904,11 @@ lpfc_xcvr_data_show(struct device *dev, struct device_attribute *attr,
>   
>   	/* Get transceiver information */
>   	rdp_context = kmalloc(sizeof(*rdp_context), GFP_KERNEL);
> +	if (!rdp_context) {
> +		len = scnprintf(buf, PAGE_SIZE - len,
> +				"ERROR: Not enough memory\n");
> +		goto out_free_rdp;
> +	}
>   

Has this patch been verified with checkpatch? Checkpatch should have
reported the following for the above patch:

   Possible unnecessary 'out of memory' message

Thanks,

Bart.

