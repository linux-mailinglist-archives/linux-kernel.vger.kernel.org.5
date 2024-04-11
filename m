Return-Path: <linux-kernel+bounces-139908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804E98A0909
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A9D1F21CB8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B64913DBB3;
	Thu, 11 Apr 2024 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWQrz9kB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFB563D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818911; cv=none; b=iuijlgGn8iY7qNBqJ0QABbrvcn29YqEfu5Q7clfCUFG1n2IvySQKO6mYCdjtkqO+HEv6dke9ZVD9AnAir/1hUZEt92L77uNIlAmGKsB2Du7f7v+2lugc4f368B29BDBXKzvAJaBj8r8VvqD9hLAzFEVDL7m6axgk9qi0o+XqQg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818911; c=relaxed/simple;
	bh=yP+2bMKzR+Q52taRcsGCGwHq9rY89WdoiGeJkDZ1NSw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mm/kbf6J//ttpcfQX37iaV7ApvsVoXd6gbSpbLUjaii9/w1S6N8walV5Z8JsUe10rWAr1IGmmuZwf0aMcK0lupzdHrZBOoFdNSeUqqkPqySmzczKPcX4knKYC9fLgddnzJuQ1RnKNS1ZXG8E1VmOC6KDju2wY246d9FDb9/0eCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DWQrz9kB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712818908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ivstmx9lR/obUjl+Y2PdWfRdGzPaR7pZ5qY2XCvju8=;
	b=DWQrz9kBHWN/OUm/49lPXV+WYGRegWnflRer6bgwG+etGNGdwZqfGIyI0t3BVQ4mXHMR1b
	6g6YmUAqhcIgx7ghbWiMpVJ+7Plm+CSJoYyiUixdtnmJvYoPnBnKkcfNiod8+NmzTU6lfV
	yZcRtbX0eD4n1mFWzuwl5fv3Lw5De3c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-Hs_XkY-qM12NYngvIkDCMg-1; Thu, 11 Apr 2024 03:01:46 -0400
X-MC-Unique: Hs_XkY-qM12NYngvIkDCMg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41637639f0eso21150065e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712818905; x=1713423705;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ivstmx9lR/obUjl+Y2PdWfRdGzPaR7pZ5qY2XCvju8=;
        b=pqA2i1OkEHFPWZX7EkF/Y8DznTrWnicAGqWzi3ghpxSyUuWgY/iIeLj3kV/IJIie3P
         VtxZ9mNaHs/jJpYKQhBFrVf0uBn1Z0AKJcvMNfm/qEYVbKVXd0+eyAL03T+lXALkeqek
         uRWmZhyH9yA5Y+EI1GFH2bnVGxTqGWHZ6IjeHSTn4B6IxR6PeVv3O87w0Ve4TW2haTDq
         5XVixagky0ydjTHo744noLTckAgRS7r6zMSZWeQw+DChenswEeGrSoDkaxQcmNzirtnl
         BoQdFxHWiB4HSwBb0enURbweX3SDLwrYC76EmSaaIPU17bJaA8kDKq+TZSG/mGxb2/sn
         3TYw==
X-Forwarded-Encrypted: i=1; AJvYcCUmKY7HjL1kIwmFrWhBI/64pMtlVAWj2FRDz4T6f1/0T0OSnhkA/MHxlFNsJD+bCUvZTPKMk79OZ4Xq8y9fL5NNWU4qEdenVQkHD/rX
X-Gm-Message-State: AOJu0Ywc6fjvE22PBBlBOBPGe53ppm997ILpusk+e+HMumh/9I9YTNsP
	smsnGLcULI9aJOyc1au01Krjb4HBAvRqQyyamKz4TrjQiHMgeoTZp8y7eKfBvT76BrV3Q6El0Zi
	ZPVjN7/VggX4yXO2vjldFvHURf+sEes9WejgP4/MjNYZKp19yLi5NjOU3KT5Snw==
X-Received: by 2002:a05:600c:54e5:b0:416:b8c9:e77a with SMTP id jb5-20020a05600c54e500b00416b8c9e77amr3276987wmb.16.1712818905307;
        Thu, 11 Apr 2024 00:01:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIkX7ovyX/jiCzOShkI4BouYlXk6bpRc4za/eMedbIqDSmMiPTFzIq94d6S3ns+OF27vZRFQ==
X-Received: by 2002:a05:600c:54e5:b0:416:b8c9:e77a with SMTP id jb5-20020a05600c54e500b00416b8c9e77amr3276968wmb.16.1712818904963;
        Thu, 11 Apr 2024 00:01:44 -0700 (PDT)
Received: from localhost (63.pool85-54-53.dynamic.orange.es. [85.54.53.63])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d4808000000b0034599eca6c9sm1038697wrq.41.2024.04.11.00.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 00:01:44 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: neil.armstrong@linaro.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Russell King <linux@armlinux.org.uk>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH RESEND] drm/armada: drop unneeded MODULE_ALIAS
In-Reply-To: <7c612f63-fd7d-4f5a-ace6-05b2bc29f3eb@linaro.org>
References: <20240410082218.46525-1-krzysztof.kozlowski@linaro.org>
 <7c612f63-fd7d-4f5a-ace6-05b2bc29f3eb@linaro.org>
Date: Thu, 11 Apr 2024 09:01:43 +0200
Message-ID: <874jc8s7qg.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Neil Armstrong <neil.armstrong@linaro.org> writes:

Hello Neal,

> On 10/04/2024 10:22, Krzysztof Kozlowski wrote:
>> The MODULE_DEVICE_TABLE already creates proper alias for platform
>> driver.  Having another MODULE_ALIAS causes the alias to be duplicated.
>> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> 
>> ---
>> 
>> Resent third time
>> https://lore.kernel.org/all/20220407202443.23000-1-krzysztof.kozlowski@linaro.org/
>> 
>> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/gpu/drm/armada/armada_drv.c | 1 -
>>   1 file changed, 1 deletion(-)
>> 
>> diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
>> index e51ecc4f7ef4..f48e2cf8de43 100644
>> --- a/drivers/gpu/drm/armada/armada_drv.c
>> +++ b/drivers/gpu/drm/armada/armada_drv.c
>> @@ -283,4 +283,3 @@ module_exit(armada_drm_exit);
>>   MODULE_AUTHOR("Russell King <rmk+kernel@armlinux.org.uk>");
>>   MODULE_DESCRIPTION("Armada DRM Driver");
>>   MODULE_LICENSE("GPL");
>> -MODULE_ALIAS("platform:armada-drm");
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>
> I think we'll need maxime or thomas ack to apply this via drm-misc-next
>

I don't think you need an explicit ack for them to commit it:

https://drm.pages.freedesktop.org/maintainer-tools/committer-drm-misc.html#merge-criteria

BTW, the patch looks good to me as well.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


