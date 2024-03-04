Return-Path: <linux-kernel+bounces-90970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECA18707CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E4AB2706B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BA35FB9C;
	Mon,  4 Mar 2024 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9O4iaS+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B63CF40
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571453; cv=none; b=DGy3eO85sFZJMBQpDNXtdvNFAZcJcMyBdyqaRglwpPaxF3I2/OI9HW+JqJXWQHIYA9kctR8z0+bD3R/5aQHl1rviysmM1OErTWExdRrM4rW/bhR548mq1qpOoqdh0fhcyJ60r4bg9dNkW28542R+nxTqG4nRFxkSFRjjj06n/Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571453; c=relaxed/simple;
	bh=9OxuSXlUAAkHSjgdNxhAWnJy3LIVqOW1+hdGG3ZGS5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1mAQHGH+FOI80zGItvKf759he+NuRhs7+qrnpQBTHaczEgFT3kTrL1PJAFjEgRDD0k5lbfcyZ75xhe0iAfoe/uEHgpDVhxOC3DckaC+RUxc/LXI1TkvO1bUeaIO/0ApoPOtSOo6oJKZjxMcIMuquLV8wJHCyLRtADbNlii+aUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9O4iaS+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709571451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlBk3gVwDcJKKsrS4jsAo8rmbEynrWIssEK39CmSxmA=;
	b=a9O4iaS+A52SAuzt7fiTSyqHwoVV8xOogIl3C7pfZsFRcq6Xsd+W+uovby/nb5kfCHXluI
	DQL7jjR4ICh7IhGKBP05skBjjOwhIurLNlpz5vnFNbaBI1/DO+TELRYV3GOH+t2gU0nu2W
	rVYFlOSJ4g/mNQ1A3TDfr2lMYx1/pNk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-g-wUgb95Oj6Q6g0iEIQ-qQ-1; Mon, 04 Mar 2024 11:57:29 -0500
X-MC-Unique: g-wUgb95Oj6Q6g0iEIQ-qQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-51345bb1d1fso1038213e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 08:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709571448; x=1710176248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AlBk3gVwDcJKKsrS4jsAo8rmbEynrWIssEK39CmSxmA=;
        b=qEzmnJYEZZj4hcM9VlBTGhbwF0fqOyIimJw5lRhOAr0JZ/DE3dzennD9Q91pIDUOvC
         Gv4wS45fYrGmdWuwGdE2Vog8EcpSnB82yEwf4dOmWPRoxQ8vjV1imChPDKz+JYXua7Uk
         aXrF+ON592ahga+7kAnD+O5sI3lg2/R2toCe5uirryCTvR7gNUmVmqsxFJ+z+AxUBynm
         8TD/r1Zh5OpeDBmhN0nuP/MAFqYXVcLdGPBY/prvFD83OzD8/DscAWilI3ZmRQ82BACM
         3qnRbzWs4mzzxjS2m8nCZdN5Tmpyy0SrreFGu6RfHNLFbP2GJ2/aaDqactOdWY9VpzCJ
         PF8A==
X-Forwarded-Encrypted: i=1; AJvYcCUD5cSpfQbtz32or/GkGeiP2oodv3qb5a6l4mRR+MwiqSo3E+EGOHBJYXUngHwm2JzN4Y7gdpc/SiPQMht5j6EGimFf8MMKxeIHnMTq
X-Gm-Message-State: AOJu0YwftpVvNysu7o0vgy2Z3HJRFWkzEhAG+rncWkc8r2eCxGq2o6Ex
	/X0bY/rhYS3GYUxXvX5XwSROAc4TEEWeARTgNrcNKyOvuP1uMTpp6oN8l1ad35VmdLWWu4Rqd92
	A0PE5ZIqfw5e4xLo7WmbvXABWBhgXoAkznw8cge4VtzEtF7L1d86lLVbMba+mkg==
X-Received: by 2002:a05:6512:31ce:b0:513:3d35:bef6 with SMTP id j14-20020a05651231ce00b005133d35bef6mr5404872lfe.51.1709571448414;
        Mon, 04 Mar 2024 08:57:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3gKm69xEtdhrx5ahjwFzQ4tyocLGE2enIJx1LHgL7epBS9Ks4QKBoBonvlnMcFFZnGyHzTA==
X-Received: by 2002:a05:6512:31ce:b0:513:3d35:bef6 with SMTP id j14-20020a05651231ce00b005133d35bef6mr5404860lfe.51.1709571448060;
        Mon, 04 Mar 2024 08:57:28 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id wr8-20020a170907700800b00a4553c6d52csm1218221ejb.35.2024.03.04.08.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 08:57:27 -0800 (PST)
Message-ID: <c0fb0480-5078-40eb-b1eb-dc5a7859f399@redhat.com>
Date: Mon, 4 Mar 2024 17:57:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd/pmf: Fix missing error code in
 amd_pmf_init_smart_pc()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, dan.carpenter@linaro.org
References: <20240226144011.2100804-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240226144011.2100804-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/26/24 15:40, Harshit Mogalapalli wrote:
> On the error path, assign -ENOMEM to ret when memory allocation of
> "dev->prev_data" fails.
> 
> Fixes: e70961505808 ("platform/x86/amd/pmf: Fixup error handling for amd_pmf_init_smart_pc()")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thank you for your patch/series, I've applied this patch
(series) to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in the pdx86 review-hans branch once I've
pushed my local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans




> ---
> This is based on static analysis with smatch, only compile tested
> ---
>  drivers/platform/x86/amd/pmf/tee-if.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
> index 8527dca9cf56..dcbe8f85e122 100644
> --- a/drivers/platform/x86/amd/pmf/tee-if.c
> +++ b/drivers/platform/x86/amd/pmf/tee-if.c
> @@ -458,8 +458,10 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
>  	amd_pmf_hex_dump_pb(dev);
>  
>  	dev->prev_data = kzalloc(sizeof(*dev->prev_data), GFP_KERNEL);
> -	if (!dev->prev_data)
> +	if (!dev->prev_data) {
> +		ret = -ENOMEM;
>  		goto error;
> +	}
>  
>  	ret = amd_pmf_start_policy_engine(dev);
>  	if (ret)


