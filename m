Return-Path: <linux-kernel+bounces-40551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F310183E251
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98B9285FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D96A224C7;
	Fri, 26 Jan 2024 19:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BI21HUqX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114C9208BE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296553; cv=none; b=YDTs8P5RvegHRPaHAAimo97SDuZ6eqG0HYtIKfVMOUd634g7KW03tTREQNd21lAU//UUx6vHOZYiZznvtSZMiFD9e18E36OCet6KC3WNUevpub8WENQsStyO4JDIM2aNLGfZ3vUpceffnUDiT1kGJlxpxeSzmoLQnIwuHlZOr7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296553; c=relaxed/simple;
	bh=CPz6IphhHcCv1pvz7ku8eRTbqDnlf92LhPvbtfZZLds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tC7PucdDjl75yKtZxlOKyh1c4YambAfmJQL2u4WEv9QQT/Ipi2slnYG1Cv8ds2kWzOFelnBnIa9607mRRucQZaY+gh6Mlg+QawebMr5vHB6UjU6+YaeAZNl2JWKM0u1JTRuqc5ShD/4JQGYmmPJxYo2qFDumlVshXIytHDmkMkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BI21HUqX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706296550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2PCC1hEtHrtY1vayDgnlvhtp45fpLTLJLLB8DBarJHg=;
	b=BI21HUqXvDeYr1hqInn1EnCgqNx2DJvy+IbQkD9gvsAXCaeLqJWFzVt/OscJ8XytTrls9D
	YH+myDJ7f8ADjuL153yU+gyzbP6+AAT5hEtdZv9aLGloEsj/euieYsMNy9ooUX6Cg0sP93
	iDOmBd5XlFFCUi26bze6qXPGupZ4+Xw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-aTfduOJgNkuIKl59m3XSUg-1; Fri, 26 Jan 2024 14:15:48 -0500
X-MC-Unique: aTfduOJgNkuIKl59m3XSUg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-337d589ef4dso544979f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706296547; x=1706901347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2PCC1hEtHrtY1vayDgnlvhtp45fpLTLJLLB8DBarJHg=;
        b=Ua28+t1Iss5K00loNohFMZuwaJ+Id1FxeU3TQ0BLdgbOqyTYUJVYvOTfi010dEhV+B
         UW1O2ylfb9TJz6Ws2xQ/tVy16C8FRrU2zclXPEJ6seVXCCUI4THDCQt+ardnZIio7OYn
         vD47ULEufs32OO46ZwKEzDT8SNWKfbCsd6jSQz1fv/F3GcPNYUAzy4WGU6iBOtpSGPgu
         rWniKpGgFTQuHzbwzBhTHZDq/CIkA4S0DaWvREGrwAuAH7vnZhpTUrhe3FN6L088D97l
         N/K47eG1EHblWvAytzHBQJk0cj4jvLxuqAGkFFSan5v67kFHnKNpXPm/C1TQu48v0FLt
         zuIQ==
X-Gm-Message-State: AOJu0Yz4mwRIjMWCpKqdQg03MkB/mZ45q4Ww4tR3iD/YbEegGxa0dCnM
	zoTvNmXGGCz8MuEHNEsdFcBGlPBDErmaLECYwpuVj3UDzs3sCNxMy8/Q/7sxAF3f30F7tS0vdYp
	4ruAcstbdjPC45COmps4zb+9jH1SqFtjV5ODzhC5hminWD/+OHgxKd7T7sNiz7w==
X-Received: by 2002:a05:6000:d81:b0:336:b937:3d0e with SMTP id dv1-20020a0560000d8100b00336b9373d0emr113224wrb.14.1706296547563;
        Fri, 26 Jan 2024 11:15:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtf0pQMMiFvVdyAYQa5EQODP2uJgiUqjQsvHdNI8WvL3y7uNYPUhmayX4/5JI/UfbWKh5PrQ==
X-Received: by 2002:a05:6000:d81:b0:336:b937:3d0e with SMTP id dv1-20020a0560000d8100b00336b9373d0emr113217wrb.14.1706296547263;
        Fri, 26 Jan 2024 11:15:47 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id g17-20020a1709067c5100b00a34a45c8a37sm930564ejp.145.2024.01.26.11.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 11:15:46 -0800 (PST)
Message-ID: <4e360838-36a9-41c0-a1d5-f369ed78cf04@redhat.com>
Date: Fri, 26 Jan 2024 20:15:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] platform/x86/intel/ifs: Call release_firmware() when
 handling errors.
Content-Language: en-US, nl
To: Ashok Raj <ashok.raj@intel.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, markgross@kernel.org
Cc: Jithu Joseph <jithu.joseph@intel.com>, rostedt@goodmis.org,
 tony.luck@intel.com, LKML <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
 pengfei.xu@intel.com
References: <20240125082254.424859-1-ashok.raj@intel.com>
 <20240125082254.424859-2-ashok.raj@intel.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240125082254.424859-2-ashok.raj@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/25/24 09:22, Ashok Raj wrote:
> From: Jithu Joseph <jithu.joseph@intel.com>
> 
> Missing release_firmware() due to error handling blocked any future image
> loading.
> 
> Fix the return code and release_fiwmare() to release the bad image.
> 
> Fixes: 25a76dbb36dd ("platform/x86/intel/ifs: Validate image size")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

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
>  drivers/platform/x86/intel/ifs/load.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
> index a1ee1a74fc3c..2cf3b4a8813f 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -399,7 +399,8 @@ int ifs_load_firmware(struct device *dev)
>  	if (fw->size != expected_size) {
>  		dev_err(dev, "File size mismatch (expected %u, actual %zu). Corrupted IFS image.\n",
>  			expected_size, fw->size);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto release;
>  	}
>  
>  	ret = image_sanity_check(dev, (struct microcode_header_intel *)fw->data);


