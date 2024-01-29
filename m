Return-Path: <linux-kernel+bounces-42378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F21840085
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D30E0B21C78
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A3554BC9;
	Mon, 29 Jan 2024 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cN1NeFKr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3738754729
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706517587; cv=none; b=dejy7ODFPdXBBobw47jAd9r1/dzJGkiP8sRwfg6E8qZeU2r9YV2Hv5ImyAi4cWsY1le+sNHvPioM8vpyHct6BXhPAImCPBIfBEBEp8D/u+Nx+lN+XpuFWoMEFL57NYdamaB6hcwml4k0YX2R1WIsR5SEMw7+ky7FUUxzDZJV5B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706517587; c=relaxed/simple;
	bh=4yZ89r1Hsazz2TJ5Dgl6xuBfA2vUUCpLWcqAGNhN1M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbZR2LOUPBDYgs75SwiAXX7BFvbNIeA5sd31OhGasHldmCGdBvMc3WV9kFAOTF4AuEKjcT2h6CarBGb5YV0NThAnTS6zAMbYj2yCxIpA+WH8Qgl2FtD3OhSzRZQ81izlthgscKoYXe4BI2WR+XXhIqMboklHYM3m0sr8daELISY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cN1NeFKr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706517583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SO879PgboMkQ1Vjya3+F+gDiRM6F/d/6qw5VF+2GLTI=;
	b=cN1NeFKrnorQ3BDDZNteTISgdb3SikYnIOA1AcIvoh1UjGuaEO0t4WLQRtqGFzT/cgDr5H
	6S84g7Zd1eTYSwb1BRxA+Bu/lcxdJevbWSTwaOzm9mdL9wYzRR9ZAwWRXMMNoFDKrYU/7u
	fFfQ19gI8JkMHY+O7JWc8L6trWI/j6w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-JIdX7gafN36SFlziAENPaw-1; Mon, 29 Jan 2024 03:39:41 -0500
X-MC-Unique: JIdX7gafN36SFlziAENPaw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2fba67ec20so125366866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 00:39:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706517580; x=1707122380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SO879PgboMkQ1Vjya3+F+gDiRM6F/d/6qw5VF+2GLTI=;
        b=DrvPLqfKvPdSGW5aStP5sE4oER9KgrzTyciBrcp3+74SxTDa5/gsyHYqh9aPH4qnYt
         THEehHVqPPb8kjW770KkDJoHO8NW1KTeksIwJypVX3rqpPysdtFV9aS+GaiLJJojUULm
         6HYsNMM1qxtzU+Cgqn9TWqd+m0C7SQLE1DqPvB8JgT4mYoIjsTUSZAUvMSf89EvZTG9x
         IkTMSxniYalZ+abVfv7KXPTdO1c0Xc1dkiv3FXd+7hePehV04nAvMZu/Wy908SaRwRu1
         RpweLGaI6mlMmwGGfSGHnPZOOXx0pfbUBx7Cc8uKwrcnHoXPwyOD0Z/gYik6nEU4ol5I
         cW4w==
X-Gm-Message-State: AOJu0YxPcy1BJMgyHxq8sPFz8CG65XBzM1VF9xmHaHNLIr4Os6ia+LnK
	weCp73TD/IzsQ1HxQcuDOiypv91Yy3eStp4UVh6jR6tVWWIxL51aSnzArJGAX9aAKn002Y83deG
	S1Rj377dtViL7Yn711lw6l+EBBaGKYTbV0nyh3u+2sta2tEKn7ZcsNQb60Z6Pyg==
X-Received: by 2002:a17:906:398c:b0:a31:805b:4172 with SMTP id h12-20020a170906398c00b00a31805b4172mr3644570eje.9.1706517580468;
        Mon, 29 Jan 2024 00:39:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGr/OOLnIBJUikDcSEfxL6gQVOu//FnOkvwdqEx58htCO3kPCq7MVbE3yW/Y7UO2B5jcyOQAw==
X-Received: by 2002:a17:906:398c:b0:a31:805b:4172 with SMTP id h12-20020a170906398c00b00a31805b4172mr3644554eje.9.1706517580175;
        Mon, 29 Jan 2024 00:39:40 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id l26-20020a170906415a00b00a3590fb191csm1447881ejk.150.2024.01.29.00.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 00:39:38 -0800 (PST)
Message-ID: <846463ed-e43e-406d-ac5a-c2fbe79b348a@redhat.com>
Date: Mon, 29 Jan 2024 09:39:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] platform/x86/intel/ifs: Call release_firmware() when
 handling errors.
To: Pengfei Xu <pengfei.xu@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, markgross@kernel.org,
 Jithu Joseph <jithu.joseph@intel.com>, rostedt@goodmis.org,
 tony.luck@intel.com, LKML <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
 stable@vger.kernel.org, gregkh@linuxfoundation.org, heng.su@intel.com
References: <20240125082254.424859-1-ashok.raj@intel.com>
 <20240125082254.424859-2-ashok.raj@intel.com>
 <4e360838-36a9-41c0-a1d5-f369ed78cf04@redhat.com>
 <ZbchziXFXPvIWP4s@xpf.sh.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZbchziXFXPvIWP4s@xpf.sh.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/29/24 04:55, Pengfei Xu wrote:
> On 2024-01-26 at 20:15:46 +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 1/25/24 09:22, Ashok Raj wrote:
>>> From: Jithu Joseph <jithu.joseph@intel.com>
>>>
>>> Missing release_firmware() due to error handling blocked any future image
>>> loading.
>>>
>>> Fix the return code and release_fiwmare() to release the bad image.
>>>
>>> Fixes: 25a76dbb36dd ("platform/x86/intel/ifs: Validate image size")
>>> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
>>> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
>>> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>>> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
>>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>>
>> Thank you for your patch/series, I've applied this patch
>> (series) to my review-hans branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>>
>> Note it will show up in the pdx86 review-hans branch once I've
>> pushed my local branch there, which might take a while.
>>
>> I will include this patch in my next fixes pull-req to Linus
>> for the current kernel development cycle.
>>
> 
> FYR.
> 
> [ CC stable@vger.kernel.org ]
> Missed CC: Stable Tag.
> 
> This (follow-up) patch is now upstream into v6.7-rc1:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=25a76dbb36dd
> 
> Looks like linux-6.7.y needs the above fixed patch too.

If you want to see this patch in the stable series please
submit it, with a reference to the upstream commit, to
stable@vger.kernel.org yourself.

Regards,

Hans



>>> ---
>>>  drivers/platform/x86/intel/ifs/load.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
>>> index a1ee1a74fc3c..2cf3b4a8813f 100644
>>> --- a/drivers/platform/x86/intel/ifs/load.c
>>> +++ b/drivers/platform/x86/intel/ifs/load.c
>>> @@ -399,7 +399,8 @@ int ifs_load_firmware(struct device *dev)
>>>  	if (fw->size != expected_size) {
>>>  		dev_err(dev, "File size mismatch (expected %u, actual %zu). Corrupted IFS image.\n",
>>>  			expected_size, fw->size);
>>> -		return -EINVAL;
>>> +		ret = -EINVAL;
>>> +		goto release;
>>>  	}
>>>  
>>>  	ret = image_sanity_check(dev, (struct microcode_header_intel *)fw->data);
>>
> 


