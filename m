Return-Path: <linux-kernel+bounces-135697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA95489C9E4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC151F20F18
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A89142906;
	Mon,  8 Apr 2024 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/PVPAYQ"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3801442F5;
	Mon,  8 Apr 2024 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594433; cv=none; b=HFyOXVSLv8rpYHQqAmbWMQG01obEc6kp2YU2Bv8TZIkYHMVJZVxMgas4hAJd/6SsmxSTz5DyyGY/Hebwj7mj/Sakt2EKTr506HP1QuvcGkpKgpIVO3flsxYilR6hIZ01trFc0azCgG3+zciEZiRzwuCHnnUOiZBPDQKhpgvknNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594433; c=relaxed/simple;
	bh=KNLg88FDFZziI3Q4rRsKevIbI9E2kVu8ALwI04NKQBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9TMHlGgnKz9SiDht55UVc4dHSBnPQwjgO6H3mobuXdfItjb859yG5elfsL2gjZClpGa3u2sg36Kpy68q7U9KXfpFzQB+Ov9QIF+wABKGCcfNkdSYyyBgYftKy/1NBDy4R6KYMVOE8efMq8gLWBU4C/Mp21I+OWv5ZZaqj/Bbrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/PVPAYQ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-789f1b59a28so291451385a.3;
        Mon, 08 Apr 2024 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712594431; x=1713199231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3b4yBHuf1ruxqd60hNeXDRSgZ49Thrf7aM7f8JfkjY=;
        b=V/PVPAYQ8n9OpJyMiIavWKsPfjQHOtSswBAsjekQhvQ/BaQCOHsxG374wOsxyq/dk5
         c5pTo8HDxHVQvu3pzkxebSueSbIX8QyWjYTK3GU5r7scIq03wBzaa7tnFSWjgwbwsX9a
         H5lN/ng8fdzj1ayqyGSrGa9MgTKfN1a4kxJFBe/NCOVkOkfZoN8PQGq3ytcGNzdDEtgt
         TBVMXIUDAXoJkabaZxNjnyFGzwr401xzxqxpQSmAfolMYY9dQzYUOLGO7W+7ZILvjcSg
         Vvwf832XWTgzfS/69i8CJ9oILGxeyTJK/08C8L+Zahc+PBlxqaQSu9/+4q7th86kqP1N
         J1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712594431; x=1713199231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3b4yBHuf1ruxqd60hNeXDRSgZ49Thrf7aM7f8JfkjY=;
        b=h2wvX1WHqJe1OvY/wUjawOBv+jfMaYb/5RL7iFfHRBARozW/UfUGUsbo0/KM4lStVg
         kzeQ+xOmgvalOLFdxgF8vrkH/ZaGuECqFoPlD9Fb4H7SoRATC7IUD63QckYDjbcc0BXx
         I8v0phhdTUQDgnQ82RlJm7BCZdOfz1wWvrHTcM9jjZZESZfjj0530k9tdOuyFwe2mwsv
         rnCKp8a6xysyUzWiLwKrTz3s3K5QOAQZn2OjkkGSsOhyhdvl0zF1BaEV3bHRhk15/j3C
         KYyMbNtFH/mr3pF/Pk8oMmHK/HYlyScp2GDTqw/tYAZ/SSdSu0Iby9E+t/xD2RSmsJYq
         d0lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFQWV+U4pdPf79OJnxXXPB1VxDDyJZJl+2WysLdjnk0O1gMboqpMi221onQriYQri0P1q9FCvIRWKaG1cG8L6WXw+xqfIjUZtsj81DCU+H9ukBKy7cwfJlKzuQKXlSOOSJbqonfBWUOen1Un8ND4Sel/hNq1NfpCaR1BIThAwW5C63Rw==
X-Gm-Message-State: AOJu0YyxDw7GbyzNizBqvr5xXNWxrf18kNt97ddnOMtZd1zbWplhboNe
	UsAfEvc9SLGlszBEjEp1zIA9O1ZE++kQEH0Dd3Y5ZpdDWUf2Bd/xGCV4xvzN0N02ww==
X-Google-Smtp-Source: AGHT+IFT2EEhMHS/nWXwbSrY+4dCwBEruz70IkDtMjsBcli1YmKK3OsF+Yso3JOinJ3eojPPPTTUkw==
X-Received: by 2002:a05:620a:b84:b0:78b:e8a2:cc51 with SMTP id k4-20020a05620a0b8400b0078be8a2cc51mr9012910qkh.56.1712594431078;
        Mon, 08 Apr 2024 09:40:31 -0700 (PDT)
Received: from [10.76.84.174] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id c27-20020a05620a11bb00b0078d6574d609sm1240380qkk.52.2024.04.08.09.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 09:40:30 -0700 (PDT)
Message-ID: <05ef3e35-1ce0-48c4-9517-e8c1280cf96d@gmail.com>
Date: Mon, 8 Apr 2024 19:40:26 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] iio: adc: ad7173: fix buffers enablement for ad7176-2
To: Jonathan Cameron <jic23@kernel.org>,
 Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
 <20240401-ad4111-v1-2-34618a9cc502@analog.com>
 <20240406155646.694f710b@jic23-huawei>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <20240406155646.694f710b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/04/2024 17:56, Jonathan Cameron wrote:
> On Mon, 01 Apr 2024 18:32:20 +0300
> Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> 
>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>
>> AD7176-2 does not feature input buffers, enable buffers only on
>>  supported models.
>>
>> Fixes: cff259bf7274 ("iio: adc: ad7173: fix buffers enablement for ad7176-2")
>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> How bad is this?  If you can find out if writing those bits does anything
> harmful (they are reserved and datasheet says should be written 0 I think)
> That will help people decide whether to backport the fix?

The bits are marked as read-only and there does not seem to be any effect on the ADC.
So drop this one?

