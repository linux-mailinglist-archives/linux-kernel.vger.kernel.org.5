Return-Path: <linux-kernel+bounces-166068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3095E8B9580
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0701C20F91
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E0B22EF2;
	Thu,  2 May 2024 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbZdTmuM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F71B2C190
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636014; cv=none; b=Cz41P+92Gs6qGN3jofZ+rYT6xBTdvyJATdDwuKaVQPsxQJwuVeGlm6c8dF+sftRMYLuOmNh0+I/lF+9OMdS0yAfYhwPN2TbQf8oZr/rJjdCau3s3tNxwduOHUzNADv3TkHtYX5/FuDKzdNZMBn5BkIXbDCIR/OZDosM+2KFj0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636014; c=relaxed/simple;
	bh=N95+O0jw+DKKcOQdQTjfPVq85yBnmLUJcQUgaLzBfvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xfun/dbbh2jxaw6AnE09cfpz+KhxY2WtUPcDBsZZsAwhHjYNkvLQUgmRLZSZ+9EDot2JOKvEJxX35vz3Wb7wC4Pz7engViE6CuPhqlb0NraJcdaEIW5zrd1RSjTyOR6nX6AtcUWVlae9/2Q9mvE/oKOiPDWt6WcUtwyaUqo0TAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbZdTmuM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714636010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KLfXyxdn+htGKj1W83h8kMfmozy37Oi55cUhUW9WKn8=;
	b=bbZdTmuM089ERPsUL7eKgnIjCUv4h2WPM5wUybpJa2AkmbmHLe7HyncreHwyFkHcFUG60Q
	5nCOwD6HwJwbzRYgJCsJKIt0PZkD6MbykkfK89czvOjgR3J03oFCGOgKrO7pQFFLHco41/
	mBqDFS9ZwuLxPy/5UrJ0GBIjA1P8nxQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-jBGH1rXJOZu0nhd1hjpDxg-1; Thu, 02 May 2024 03:46:48 -0400
X-MC-Unique: jBGH1rXJOZu0nhd1hjpDxg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2decc7026a9so69755211fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 00:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714636007; x=1715240807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLfXyxdn+htGKj1W83h8kMfmozy37Oi55cUhUW9WKn8=;
        b=TYGctM6zAr7e7fRo2je300NZrVGqDMWdkpofSIlyGL73OWaDOWWfP4qsCSu1q9NP+x
         BZu5YFEDpbOpG5IidjPJyEDc85FXpUceKmbFrFYJHaKK+iT4ArX46wAlpaBFYnsQcNpz
         yAyBw06FqTn4f18jZ6I8ODCxf2iRMhxuvGZHyQixqHbf1J4Qxz1Uo9dKahrUruCfAhEG
         0WkMH/xJWsSk0UFpYmlKU1wO3appj7rwwMpIxzSDp0dKTS4cCBSvy1tBMDnvyX2A0dh+
         sHhmNBff4UkUli643Vi1o0V8eNOXD+PaVUrOcJqskNzROgzoy3yGDBVUYcOZLMde2ZDP
         9+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWLUAIeILn96AzMDJqH45k2dfJh9wDwyjKkfiEGLnNSK0AKzexj5mkEm/TxAEE0CDngqOsa68EACMpalsinmvFsEhv1AnGytUeTo1xv
X-Gm-Message-State: AOJu0Yz4jowIbjT/kwpqqZufQ9spJ/qQA29j16UYH/5FODq3yLYv02Cj
	T1h/NpgtoXZpLDyjKiN0MzpBfafZ++yG14giTpejLGHEo7Mv6BN6rZ4T4WOB6vJZQmXNZyjZVIt
	FIKig2f96ve1k0YtBF/ZPBV37c26vDiglO3O5ra7iL+e2IBTBt1ngQfm5j7O5og==
X-Received: by 2002:a2e:a9a9:0:b0:2df:b63:a8 with SMTP id x41-20020a2ea9a9000000b002df0b6300a8mr1045309ljq.50.1714636007158;
        Thu, 02 May 2024 00:46:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPv1gqwEi7hn3q3bVgyzxoZH/WK6ToHFIzGURBsrAI0k8zW5swrTa2yO+i/Nbc/ha9gUBKUQ==
X-Received: by 2002:a2e:a9a9:0:b0:2df:b63:a8 with SMTP id x41-20020a2ea9a9000000b002df0b6300a8mr1045287ljq.50.1714636006638;
        Thu, 02 May 2024 00:46:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id j3-20020a05600c1c0300b004186f979543sm4785753wms.33.2024.05.02.00.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 00:46:46 -0700 (PDT)
Message-ID: <61eb03bc-b594-49ec-81c3-d91bf97e6704@redhat.com>
Date: Thu, 2 May 2024 09:46:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/fonts: Allow to select fonts for drm_panic
To: tzimmermann@suse.de, airlied@redhat.com, deller@gmx.de,
 geert@linux-m68k.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20240419132243.154466-1-jfalempe@redhat.com>
 <ZjDq_1t8iRf40dRa@phenom.ffwll.local>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <ZjDq_1t8iRf40dRa@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/04/2024 14:58, Daniel Vetter wrote:
> On Fri, Apr 19, 2024 at 03:20:19PM +0200, Jocelyn Falempe wrote:
>> drm_panic has been introduced recently, and uses the same fonts as
>> FRAMEBUFFER_CONSOLE.
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> lib/fonts/ doesn't seem to have a designated maintainer, so please push
> this through drm-misc.

Thanks for the review, I just merged it to drm-misc-next.

-- 

Jocelyn

> 
> Thanks, Sima
>> ---
>>   lib/fonts/Kconfig | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/lib/fonts/Kconfig b/lib/fonts/Kconfig
>> index 7e945fdcbf11..befcb463f738 100644
>> --- a/lib/fonts/Kconfig
>> +++ b/lib/fonts/Kconfig
>> @@ -10,7 +10,7 @@ if FONT_SUPPORT
>>   
>>   config FONTS
>>   	bool "Select compiled-in fonts"
>> -	depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE
>> +	depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE || DRM_PANIC
>>   	help
>>   	  Say Y here if you would like to use fonts other than the default
>>   	  your frame buffer console usually use.
>> @@ -23,7 +23,7 @@ config FONTS
>>   
>>   config FONT_8x8
>>   	bool "VGA 8x8 font" if FONTS
>> -	depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE
>> +	depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE || DRM_PANIC
>>   	default y if !SPARC && !FONTS
>>   	help
>>   	  This is the "high resolution" font for the VGA frame buffer (the one
>> @@ -46,7 +46,7 @@ config FONT_8x16
>>   
>>   config FONT_6x11
>>   	bool "Mac console 6x11 font (not supported by all drivers)" if FONTS
>> -	depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE
>> +	depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE || DRM_PANIC
>>   	default y if !SPARC && !FONTS && MAC
>>   	help
>>   	  Small console font with Macintosh-style high-half glyphs.  Some Mac
>> @@ -54,7 +54,7 @@ config FONT_6x11
>>   
>>   config FONT_7x14
>>   	bool "console 7x14 font (not supported by all drivers)" if FONTS
>> -	depends on FRAMEBUFFER_CONSOLE
>> +	depends on FRAMEBUFFER_CONSOLE || DRM_PANIC
>>   	help
>>   	  Console font with characters just a bit smaller than the default.
>>   	  If the standard 8x16 font is a little too big for you, say Y.
>> @@ -62,7 +62,7 @@ config FONT_7x14
>>   
>>   config FONT_PEARL_8x8
>>   	bool "Pearl (old m68k) console 8x8 font" if FONTS
>> -	depends on FRAMEBUFFER_CONSOLE
>> +	depends on FRAMEBUFFER_CONSOLE || DRM_PANIC
>>   	default y if !SPARC && !FONTS && AMIGA
>>   	help
>>   	  Small console font with PC-style control-character and high-half
>> @@ -70,7 +70,7 @@ config FONT_PEARL_8x8
>>   
>>   config FONT_ACORN_8x8
>>   	bool "Acorn console 8x8 font" if FONTS
>> -	depends on FRAMEBUFFER_CONSOLE
>> +	depends on FRAMEBUFFER_CONSOLE || DRM_PANIC
>>   	default y if !SPARC && !FONTS && ARM && ARCH_ACORN
>>   	help
>>   	  Small console font with PC-style control characters and high-half
>> @@ -90,7 +90,7 @@ config FONT_6x10
>>   
>>   config FONT_10x18
>>   	bool "console 10x18 font (not supported by all drivers)" if FONTS
>> -	depends on FRAMEBUFFER_CONSOLE
>> +	depends on FRAMEBUFFER_CONSOLE || DRM_PANIC
>>   	help
>>   	  This is a high resolution console font for machines with very
>>   	  big letters. It fits between the sun 12x22 and the normal 8x16 font.
>> @@ -105,7 +105,7 @@ config FONT_SUN8x16
>>   
>>   config FONT_SUN12x22
>>   	bool "Sparc console 12x22 font (not supported by all drivers)"
>> -	depends on FRAMEBUFFER_CONSOLE && (!SPARC && FONTS || SPARC)
>> +	depends on (FRAMEBUFFER_CONSOLE && (!SPARC && FONTS || SPARC)) || DRM_PANIC
>>   	help
>>   	  This is the high resolution console font for Sun machines with very
>>   	  big letters (like the letters used in the SPARC PROM). If the
>> @@ -113,7 +113,7 @@ config FONT_SUN12x22
>>   
>>   config FONT_TER16x32
>>   	bool "Terminus 16x32 font (not supported by all drivers)"
>> -	depends on FRAMEBUFFER_CONSOLE && (!SPARC && FONTS || SPARC)
>> +	depends on (FRAMEBUFFER_CONSOLE && (!SPARC && FONTS || SPARC)) || DRM_PANIC
>>   	help
>>   	  Terminus Font is a clean, fixed width bitmap font, designed
>>   	  for long (8 and more hours per day) work with computers.
>> @@ -122,7 +122,7 @@ config FONT_TER16x32
>>   
>>   config FONT_6x8
>>   	bool "OLED 6x8 font" if FONTS
>> -	depends on FRAMEBUFFER_CONSOLE
>> +	depends on FRAMEBUFFER_CONSOLE || DRM_PANIC
>>   	help
>>   	  This font is useful for small displays (OLED).
>>   
>>
>> base-commit: a35e92ef04c07bd473404b9b73d489aea19a60a8
>> -- 
>> 2.44.0
>>
> 


