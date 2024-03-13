Return-Path: <linux-kernel+bounces-102261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BE687AFE7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898371F2A3E8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5824A62A17;
	Wed, 13 Mar 2024 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzIFz13U"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017DB62A19
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350718; cv=none; b=EsoLCrcO4N/PVwHfH29yd96nvRQm2oyxOKCd9Z6rbehvChw75WAYrE6mB8oSn+fmF9QBzQHhs+53SQY/+w50nbJsq1V/jZsNpgb/g9EKSOlKMqEqRQnbXKMErq+kE5m6ycOKHoTs9aOpCZwzg6GTELm+cmBorndrJBzUugM3qY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350718; c=relaxed/simple;
	bh=Y5NMiXCNqiFRfPflfL5uuISKnOFiSCta4XR8Oj1+nV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jyb8lBfnX9LPxmCxLiq8TwPxp7DCU+kNkvAW7EQTSynS0smag1Qcbl5OYn2iMf2lV3e1ngAjcbXeHlRaRYxAzV0LcA6+rra6g/4GwMSyZA9Wb7/RSdwdJstN7T4dy+exb5Ld6SQ8iTylrsafltmUJerXwMz3sPENu0jU7VYXF+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzIFz13U; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-413eae3e60fso863615e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710350715; x=1710955515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWMI56CTn/B1wLp6f0Wjl+6QbA6cu6N5djRrOJhMpLY=;
        b=MzIFz13UCEVoAHBUsoYR540wFoEmadRS9j1u4YqOPZhEJ4ExOVXAbIAF1ekvw5Wfvo
         LbXvGmYPvXHDNCsti+Am57VvGMA/Rj/gcAEnKXE1cS7UDwFLhAdsiYRUnyjQqBVQYJi9
         OLmXbB6lzyUJd8nFZdNrZ2pmmJ+FLV9T32ll5DMguWKr25XJ9IlXG5hCP3owRfzO2q7E
         miOV0LpmxtnTOH7/SEkAAQKZD/NdYDyZuC9+KhA3T+hNqDLzFLpjBEIuuzQeIX4k+UoU
         ikIgBbeDU6FN/RbiSJOd5TwKXWfjOhRA5a9VZ61iuNI8dAXq/aOOYlhyr2SRNzsvz0aX
         1tRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710350715; x=1710955515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWMI56CTn/B1wLp6f0Wjl+6QbA6cu6N5djRrOJhMpLY=;
        b=KnaX2/g2CJAnb+SdOEka4ke1LKXqQ8SNx88OEJwGZgbfJ+hCfNkqfgC891xb/AiYNr
         afn5Q3ep+frynrNHtoJ+lE/wcGZAxudVEA64/D0Crj+Bkiam3Js9dH1Vt+pztf73Q8Fu
         qwjSUo/Kw0KQ9CftQ+tpNQaxu0l8yYMvGXI+gJbxnb4GlO27jUht84WOI/3KKZNPkL9X
         SAF8b/15SKq4QIs8ukheeNmDh1UjLVhq3yUbkNWivkpokHaq4BlAwbPnniJPkYhSD+A+
         PxJ4N4RDE5vPIrhT/XjvzWYH6bjoT5BSEzmgrmY//9PfhKV2BHaABE3b3JYZX+XKyuhP
         cNnA==
X-Forwarded-Encrypted: i=1; AJvYcCXEOTJU8pFSdFUYJ4YtDB9ZTsNNecGKooDq94IKKIepPgv2sz4OxX7W722xwoozF0/RHHW8sMw3HPAmN2yerwAF3TWSaThqm+Ichw7H
X-Gm-Message-State: AOJu0YwrlQA1PAovxtVfZGxmYGePk2+yHCeQFXSchF51rkmzKx8Ef+I7
	aG0EhuTqPDBK/k4sZbyYLKC144AV3bl9PwA6Fg2LYYQcO3maTwE9
X-Google-Smtp-Source: AGHT+IH97oa72lbT+W+7ZrB6GCBOnlh/O84pQQTmPaiJYnAt8o/mxhgSmXf9cmpsw5cu0296jg13Kg==
X-Received: by 2002:a05:600c:4f0c:b0:413:e531:5a47 with SMTP id l12-20020a05600c4f0c00b00413e5315a47mr495047wmq.4.1710350715199;
        Wed, 13 Mar 2024 10:25:15 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id fl21-20020a05600c0b9500b00413320f795fsm2924456wmb.35.2024.03.13.10.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:25:14 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: wens@csie.org, samuel@sholland.org, Kamil Kasperski <ressetkk@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Kamil Kasperski <ressetkk@gmail.com>
Subject: Re: [PATCH 0/3] dts: arm64: sunxi: add initial support for t95 tv box
Date: Wed, 13 Mar 2024 18:25:14 +0100
Message-ID: <13468418.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <20240311174750.6428-1-ressetkk@gmail.com>
References: <20240311174750.6428-1-ressetkk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Kamil!

Dne ponedeljek, 11. marec 2024 ob 18:47:47 CET je Kamil Kasperski napisal(a):
> T95 is a most commonly known for being a box with a pre-installed malware.
> It uses Allwinner H616 and comes with eMMC and DDR3 memory.
> This device comes with two versions - one with AXP305 PMIC and another with AXP313 PMIC.

I have this board and it always felt like a clone of X96 Mate, which is
already supported in kernel, except for broken sd card detection. Would it
make sense to unify those two boards and just overwrite or update parts here
that are not the same?

Best regards,
Jernej

> 
> Kamil Kasperski (3):
>   dt-bindings: vendor-prefixes: sunxi: add T95 to vendor-prefixes
>   dt-bindings: arm: sunxi: add t95 compatible string to list of known
>     boards
>   dts: arm64: sunxi: add initial support for T95 AXP313 tv box
> 
>  .../devicetree/bindings/arm/sunxi.yaml        |   5 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../dts/allwinner/sun50i-h616-t95-axp313.dts  | 138 ++++++++++++++++++
>  4 files changed, 146 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-t95-axp313.dts
> 
> 





