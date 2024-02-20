Return-Path: <linux-kernel+bounces-72816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD6085B8FE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A29B25DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686DF612C4;
	Tue, 20 Feb 2024 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HvHzJBqL"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCF460DFD
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424750; cv=none; b=cJ3zLvQYAEDB28lHchBTRl7hCSKfyutA5LkyuvDWePOyZqpyaM9CukEFJRuHGE2O9idkjW745zERnbgokL8CjwLirdOHbC/qXQ7uovpXHYdLEcPRHMOsv6jDyAHWjoV5XjPGFdZ1V8pbeqAtZSNbYy4yRo9UrzaPQhwvtD/1Q7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424750; c=relaxed/simple;
	bh=5ktclNbn2mEDXmqYAQYhA6bcJLKSeTx1A+GxurIEYMw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fjBEH6j0TkNRvqWft18Srkz8aCfmQ961O7RHG0T00GwtScbNnsBZbSvRzVCDB0o7yib/RWpCGiERXSSl3+Dc4i/5vZF3a47ScBx3hj8X1VDGqM03ivPweCUaDWGKzR3nBWyPiOwnT98dOiI9jYtTlFUlyJP1X8XKeYOR3qDkHmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HvHzJBqL; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d220e39907so52074921fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708424747; x=1709029547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djjvs/Usd09U05nC8p2eL3fflYkuMgnwDD4B9hrTwJI=;
        b=HvHzJBqLP1oInkzpBfWLDEU3r1SZ1dx4JPqdFnc72c+joZTFZAuKGnTjXgAnkQR7XV
         yR3Lyomi+uA5YbmFwjZXgCdM0KizaEQZ90AaFEYZqiGdZrWxkdL80oQObzSlQJzxmjV9
         8EX86NybAmA7hbyT4oftmiH9A71CmNZav1qiGIzWcEK4qYFovI2WupCUAAZeOdDNC+2x
         9jbpqWs+uXpcCwie9+XQgNBev3ouf7gK4/eXcbLPJ2C6jBpF4RnBBEdVzbq07b07zGqW
         2GbN2kEuW8GRi++DzS3CW0GIQx1cU14Lvk5dut8N3n3Ny4zHRIrRnB/gTrLO9SUlenYh
         HZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708424747; x=1709029547;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djjvs/Usd09U05nC8p2eL3fflYkuMgnwDD4B9hrTwJI=;
        b=qrR4MxHS8pZDFBO8vSo1X89nxCzx02Yommc5RiNqusxvnUqPLm3HA714aEojM3kRgR
         Dmru/JHE26hG7qPjG8W6GPk6GZqLPAW8ZNshQhTq6A4wxo9aWVEdjTnasqStfBf9kn6N
         +YcmYpbuDhGXhQSVHScxbmg4RnMiC4mWRvJwfSqHMuxRX4d4mahPDlf47w8SEMJrXrQn
         B+HUylXX4N+501a5cCCCoO/8osy9GSei12Zho4MhcTOVCemS58GAAZdW96ElGvMTnp7R
         I8BQplWMaJo42lOZf8y7t6//dbW1XyEJ6PSm5We0U63YS6vwo27pzax25VkEtCeNI3r5
         LuwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWSlKIaXm2NGuHojstTPYj2myHZuzD4dJbaiHHlfHfATgIN4E7PqP+kwzwPRY2MwabxrwrgID3/USdqwUUNRz0lhsAEAVwTt0eheW7
X-Gm-Message-State: AOJu0Yx2IEWZ/CEcALfT2t3gaQv2WipgHqawsVjr0x7bVr6mJ/5lzhch
	lntd/YfHYZGIki8HfYH6uYBPkekT8PSs9hqLN8aXY1bUCf7iY8BNsYae7mm4Du4=
X-Google-Smtp-Source: AGHT+IHx1YYP44dRDHsO0C5F7uarbJ+O3QPbQ0mRFH68guy+79lu+WX2haXFFwA4mOASYsRHEDAnjQ==
X-Received: by 2002:a05:651c:454:b0:2d2:438a:11ec with SMTP id g20-20020a05651c045400b002d2438a11ecmr2878652ljg.2.1708424747273;
        Tue, 20 Feb 2024 02:25:47 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id q4-20020a5d5744000000b0033b47ee01f1sm13009716wrw.49.2024.02.20.02.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 02:25:46 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
In-Reply-To: <cover.1708340114.git.u.kleine-koenig@pengutronix.de>
References: <cover.1708340114.git.u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/4] w1: Convert to platform remove callback returning
 void
Message-Id: <170842474594.51528.5868628696022611171.b4-ty@linaro.org>
Date: Tue, 20 Feb 2024 11:25:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4


On Mon, 19 Feb 2024 11:59:26 +0100, Uwe Kleine-König wrote:
> this series converts all drivers below drivers/w1 to struct
> platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
> Provide a remove callback that returns no value") for an extended
> explanation and the eventual goal.
> 
> All four conversations are trivial, because their .remove() callbacks
> returned zero unconditionally.
> 
> [...]

Applied, thanks!

[1/4] w1: mxc_w1: Convert to platform remove callback returning void
      https://git.kernel.org/krzk/linux-w1/c/63724bbfb1e6b5e202f9393da4b25d4e7a46f5ec
[2/4] w1: omap_hdq: Convert to platform remove callback returning void
      https://git.kernel.org/krzk/linux-w1/c/aa68465cf3d39996b291fb2080946c2e4d7cc100
[3/4] w1: sgi_w1: Convert to platform remove callback returning void
      https://git.kernel.org/krzk/linux-w1/c/d7516044f167b219dae13010e6ff790e3fc96ef5
[4/4] w1: w1-gpio: Convert to platform remove callback returning void
      https://git.kernel.org/krzk/linux-w1/c/d97d263132a69a0bda54efce3df04e55fa6341f7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


