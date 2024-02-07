Return-Path: <linux-kernel+bounces-56264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9273184C810
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D806282420
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C45725576;
	Wed,  7 Feb 2024 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ozeq4FC7"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC5724B57
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299714; cv=none; b=Dcn1eSZJ1b+myhMLOQuds5Fp4jTkYRqXeRTARdmVMu7HijQ8sOyYUuBqArc+pXsiX4iQcukFIjxecjvJOVVPG7KUdJm3sJ2Pu5Uw1wF4W4Ib8fYDBGs4VgZxOoIejCm+rWcZvnvcORgASl8ZxENA24EQR1pmzdJT/OVXoErfGYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299714; c=relaxed/simple;
	bh=kaJT+HlW06iCWLlw7hsvOu6LhCgGH4HmAFtBgRxZjAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7cIUFKCUXfrcf4CzmOrNHgwMeJLNJHBkhgeMVYNEKmRV5pOUug6S3xf8DPHJ3mzdW12/hzn062U7PQiQ3b/wj3WkNZQILZeT8cjdJwwVHGnHvdBa65ogj0mcqGxXAhprL7lp84Tqh8cwNMSjYTgE1QMXRK8KDlBhw9OP43yIKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ozeq4FC7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33b18099411so317330f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707299710; x=1707904510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fsRZs51W2huLngb3aSHYllyqQl8VP5fXmWHfrrQr+1k=;
        b=ozeq4FC7PhWKHu+MScTibvQfeT2WT4NOSph2XBT9WO0yBvj7Woa0qOX4J+l0Bigqan
         pr2p0ZexUNj41DznwmnMANqUX98uGRI0aiRH+c9u4MpcfvmK0tO+RHNmBzy0b52JAkad
         gBMe0IvIrybTgy3tL+P6BT3Bth+jWBbq0+JphtpEtMUqpkGGmhjEAxIuTMVHYJs8zm0e
         xLxvsp++IgmpzGbewf9WNQH6bEucptiV6icikXrTHTj4UHZNBUGPgULBng2x5enqhey9
         4pZCO94M2tJ21obvYa+5rMdZrwAvVYt+Qh74RkeORVZfDiFuUzT6HZNdMg3PbcdHcloc
         sF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707299710; x=1707904510;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsRZs51W2huLngb3aSHYllyqQl8VP5fXmWHfrrQr+1k=;
        b=qM910PyOfKxALVx+PqMgTd1WSHaWUqTUvipYSd71BlcofPQl+7tFpESwi9g8pvQaSr
         +7ORTY9rNzI+h6efIdSjl9LE0AvLYuX+D2J84SMeCvRsukoLwKYKNyLuPF+tFLA3rPRX
         0TvlVoheGEdFgklbBkag7Cuwn6tvoiFoAkowf7V3ec6gXD5cQXVeTb8qffu4aQrOSXGV
         dV3TRBgyIB+LeXYoI0ogOLMgAStK6maIJM2ZGFFE91bIes1w6n7/3x6+3KJQJj/CF7MD
         0657geDG0d/T/EDojzB17TvslozGDZMwZb7ZfwfdX0QvmWMBdHD0KKZwWWHLhq8wJDY0
         uITg==
X-Gm-Message-State: AOJu0YwRTUqD4+8kv5m4k2P7IEtY9gZLXmpWNKLLObr2qZLrgJvxIAdI
	0rckkdIBNTwXlwJDabjLdCZxaFamKWib7ih739beYk4OgswoQwIrGwh3/5HKpEw=
X-Google-Smtp-Source: AGHT+IG7N3OfmAh54zPppxgxnipuAkjejir3UBYj6pe+R+53DlWxcD0lVN8Xy4HfG00GDYpT1e67lg==
X-Received: by 2002:adf:ce8c:0:b0:33b:136a:95a3 with SMTP id r12-20020adfce8c000000b0033b136a95a3mr2875503wrn.28.1707299709759;
        Wed, 07 Feb 2024 01:55:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWomvasDY2y1JGYC41yi3XjKUcCAy+WjDD4t4v3x0Py0iVpS7KfDv1ihzcoSIGyJDs9LYYnSaZ9fVzQIbMxYSQddfp8BcaLQPOmNuHTxP0Iq3nKxKzxCYdg5Amf2xeEnKy64aN9m8kBu/Y+G8fqpLaCgUrbByqQO5y14+C2vcwkn906lbapgjN3P9YUIbT0CwDgRn4OxG9kOMqi2wJLn5digJZ2gLiWgHsG+LSTfjqwUg32N2xvJHUSKhjyYbeycS6tsV13hPkwZlniyYYpr+1XW9zDtc2Jk6XvtZUPvYjgT1Ovve5EMo9BDAjQT2jSLISuzRUJ/qWitiGBJqvLZXczHzEPtiShAn8QqCcU56rFp3agu6i3oSNL9XqzAS1I2ntzuQAt078dz8WPVcmbJz8L2srFCMgE2eVFDg==
Received: from [10.101.1.8] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d4dc7000000b0033b51e2b9b8sm23808wru.23.2024.02.07.01.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 01:55:09 -0800 (PST)
Message-ID: <843e34a5-f175-4bda-a2f1-2ea3b56b68f5@baylibre.com>
Date: Wed, 7 Feb 2024 10:55:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] drm/mediatek: dsi: Use GENMASK() for register mask
 definitions
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 chunkuang.hu@kernel.org
Cc: fshao@chromium.org, p.zabel@pengutronix.de, airlied@gmail.com,
 daniel@ffwll.ch, matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20240206120748.136610-1-angelogioacchino.delregno@collabora.com>
 <20240206120748.136610-2-angelogioacchino.delregno@collabora.com>
 <f91db779-ad94-4c18-9a06-1029da4edaab@baylibre.com>
 <c1e2c380-21b5-47c1-b83b-f7f2b481df21@collabora.com>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <c1e2c380-21b5-47c1-b83b-f7f2b481df21@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 06/02/2024 16:53, AngeloGioacchino Del Regno wrote:
>>>   #define DSI_PSCTRL        0x1c
>>> -#define DSI_PS_WC            0x3fff
>>> -#define DSI_PS_SEL            (3 << 16)
>>> +#define DSI_PS_WC            GENMASK(14, 0)
>>> +#define DSI_PS_SEL            GENMASK(19, 16)
>>
>> 0011 0000 0000 0000 0000 => GENMASK(17, 16)
> 
> Alexandre, the reason for that is in the commit description :-P
> 
> "While at it, also fix the DSI_PS_SEL mask to include all bits instead
> of just a subset of them."

Oh sorry...

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

