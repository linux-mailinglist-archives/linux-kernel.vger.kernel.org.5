Return-Path: <linux-kernel+bounces-60025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65ED84FEC3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8139DB269F5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F3E2135C;
	Fri,  9 Feb 2024 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYj4WjuE"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C2E21344
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513941; cv=none; b=NXFlRKROmE2Vyu+r9VTkXrmJtCRJWuGJct6XRFx5clCbR3AaN8wsoidrNNXUGUdL9n7U+DAHFk+Vrapr+NSyrfKJkn5qHvqzMjqZtBkgamG9i8QFZSJW3hpHrhzwutvzIER71BJGi1dpmIXtlE4t2QgkL1FxiVko1E37uZjR7r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513941; c=relaxed/simple;
	bh=shpPP4H1LqEniF63b/p6ULTcARrDvaW1Ry7LGtBSNUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SevKuY1PIZkMGl8BfWcDKo5Iv6RNiVFXmZsE9oy34K82i+ecXVRTAKPlf+acJ/40KkldJ2nQbLpAxkgkoMaqdgoEqeI2YeDE5nVeadX79dVqQ3MbSNNoJybTiM99PPn2OtUpt9pbUZusfvCeEWisAtBBiVnnAIFdFQwkhaaeMtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYj4WjuE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e08c16715fso658428b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707513939; x=1708118739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=wH8JuFgY7Lb4/rW5r6a9o7mYn9SHt8MrowNVTWs9laU=;
        b=bYj4WjuEryGsYIzi2tLDgHnqosqP3ft7szL2BUempgbkk0MgQifitk52XuYaivu84C
         9aF+3OxjGMMwWBTbPJdKI3u7948ZgKaOvtmWdvw8jqiCAuyxjP0ftsN+efZDhtA134qY
         YXOjTq+CufYJouhZXiLpmqzNiIQh2644HS1zgobNqloX7NJee+9xpcseCTOEaGJPlNXv
         Lr9U6tMfqMkL6JgYCZ2Q5NAfjIUnsFZXHHKOtbuktNfo3GD3toZhvYKnYZ5fI5mndBDu
         DUMufmWn44ZKPM9qhdUZmCYCgPvZHRjDTH3t7STM2I+mtfSSSE//GjL7YTgxHgGqdSup
         pRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513939; x=1708118739;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wH8JuFgY7Lb4/rW5r6a9o7mYn9SHt8MrowNVTWs9laU=;
        b=BnfJ2e2bp5jXRdiY7MMImTShSsOdMxEjUT+q1DYmXm/KQKogWnOOxNk5uJ4370DMYK
         bjo5bg9RFNK8coW8HcXC24x4wapSXBvVmiL9MVzQKeSKjwcyaHWHA/ER9Ve3xxwr3ipE
         8RBVLIiWQ6jlP8oNYJcbo+bmED5I+u0Uv3HA8hZq9e6+Fj1YjUcPo2tQcXb0SjJ8ke5d
         cf8+dkhv7s3lQEczQ0DDLtZvzO3Jokyo3ufq9bstTJ67c35slvOC4RL3LmQ/06tPzhQh
         CNyUAUzamdJBSez3KX6VjzGEVmQjJmF103xBg/Dx+aHK8qhq7UxO6+nSQlWP8iXMkG1Y
         qKvQ==
X-Gm-Message-State: AOJu0YySE3xqnY9qrizkMHV7W0mosXPLjR3M20+5OlJEB24p699+2m57
	69rpukaqIVrev5EUeogAubAupbPbNdHOdkaM7eejrGr+Af98P6FabWudiP86
X-Google-Smtp-Source: AGHT+IEbq6NJiMAlF2DsotTurlptSor9yP/xN9HnRdWFRRb+HeY/ZKaXbR1M00OboodD8+wa/9PH9Q==
X-Received: by 2002:a05:6a20:30d4:b0:19e:9cc9:1bef with SMTP id 20-20020a056a2030d400b0019e9cc91befmr308376pzo.22.1707513939135;
        Fri, 09 Feb 2024 13:25:39 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a16-20020aa780d0000000b006e0825acbc3sm997932pfn.77.2024.02.09.13.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 13:25:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2c8c5fa4-b0f7-4ca5-b003-4b37cc036664@roeck-us.net>
Date: Fri, 9 Feb 2024 13:25:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regmap: kunit: Ensure that changed bytes are actually
 different
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20240209-regmap-kunit-random-change-v1-1-ad2d76757583@kernel.org>
 <ZcaFmYGClhpj82Xo@finisterre.sirena.org.uk>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZcaFmYGClhpj82Xo@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mark,

On 2/9/24 12:05, Mark Brown wrote:
> On Fri, Feb 09, 2024 at 08:02:27PM +0000, Mark Brown wrote:
>> During the cache sync test we verify that values we expect to have been
>> written only to the cache do not appear in the hardware. This works most
>> of the time but since we randomly generate both the original and new values
>> there is a low probability that these values may actually be the same.
>> Wrap get_random_bytes() to ensure that the values are different, it is
>> likely we will want a similar pattern for other tests in the future.
> 
> Sorry, works better if you actally check stuff in.  v2 coming.


I don't know how v2 looks like (I think some of the hw_buf index values are
wrong), but have a look at the diff below.

Guenter

---
diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 6fe259a2a73f..e73bdf01f118 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -1283,7 +1283,13 @@ static void raw_sync(struct kunit *test)

         hw_buf = (u16 *)data->vals;

-       get_changed_bytes(&hw_buf[6], &val[0], sizeof(val));
+       get_changed_bytes(&hw_buf[4], &val[0], sizeof(val));
+       // Let's cheat.
+       // Remember, the above code doesn't look into hw_buf[2..3],
+       // so anything might be in there, including the values from
+       // the val[] array.
+       hw_buf[2] = val[0];
+       hw_buf[3] = val[1];

         /* Do a regular write and a raw write in cache only mode */
         regcache_cache_only(map, true);
@@ -1331,7 +1337,7 @@ static void raw_sync(struct kunit *test)

         /* The values should now appear in the "hardware" */
         KUNIT_EXPECT_MEMEQ(test, &hw_buf[2], val, sizeof(val));
-       KUNIT_EXPECT_MEMEQ(test, &hw_buf[6], val, sizeof(u16));
+       KUNIT_EXPECT_MEMEQ(test, &hw_buf[4], val, sizeof(u16));

         regmap_exit(map);
  }


