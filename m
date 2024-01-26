Return-Path: <linux-kernel+bounces-40043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A5783D948
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF74292C30
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C29C14299;
	Fri, 26 Jan 2024 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uX9CbdA2"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AC41B946
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706268158; cv=none; b=N1nMawKxPAtvMU0D+sw34b31Yia/pWyaaB7j+WANPFJ2ztKTJHL9ETzx68tsKFUROUQatjrc5Cdq6+G8NyapCFKhGIphw98vAKpx7lR79pz7BZWONPKvtbkUlvleP4s3XQMa2Ds+Wfvdmh6EUYp/RTqb4BpmTmM8Mf6oQXpCY+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706268158; c=relaxed/simple;
	bh=mACbSjLNn43qQIDNya9zDgNcOnXMiY4Me7YFeN+xW90=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D65z56vuOzU8/HVkw1bqbykDlRoFkeASKgAsC7ib15wkuxF2Yt5NbsH+wty76+J4jhnYhp4o4vNyLiwMDrDiYJru7mELtzSDup1kpGCcUNtR2Dvjx8Ds242Fs5rJhR8oh4wG6Ghoj7Na+XjU2N7+dY4iv1A9kXRZECBQTrwjVYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uX9CbdA2; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cf4696b90fso2370451fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 03:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706268155; x=1706872955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xS+dLyse9Mmq2wfzYg8MWhXB6r8382gdva6ZXhQz530=;
        b=uX9CbdA2f154mzB9e9wWeSQGAr+C/EYKhIg7qMk4d6BFTcC1GOWguths8zg+WY3Hc0
         QAN9QA952fa8OThthu1tr7w6NfktlA3tJPRQgqw7xjZqqUflX1mnruHD083ADA3Gn6+Z
         O7wqzUOw/Mhy5nlxw/XDeqjQJ1SvmHXQUsypGmWrUHKFfhG9Nm3sUcPpapt6XOv8C8AG
         OMdbSHMO72169SlxrCuiIJnzV8wXEEy6BZW2zf8gbTTSnfk6oiVJke0po3U8JG2dLB79
         Rc22tSGhUsPf5kYAGrrvIykQBBFwqNhNDsbIksdecdCa/Ez8E9QmcahLddI5XAVvngtl
         /XCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706268155; x=1706872955;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xS+dLyse9Mmq2wfzYg8MWhXB6r8382gdva6ZXhQz530=;
        b=NBKZvRJRBzk47CxSWvvn6suA5EJ/MwZ0kvQzXGfKletM95P1ldSY8MTIa8pqQa9kBB
         6Bd+1dsU9dpnII0PqWDdZg3LZe7igk/Emm4tMWWSfuDLp8eaaAbqwb7M44CffHAEeIZ7
         YyC48/MB81JdmJ60kFnk1k2wlAKUlRhDWZ53qXRh9ZJH7QJqPCvhNN6v7x7EWFBRVo/f
         08aPoIH+jotWQ0iwmOy1G/JmK8tn174kMzYHZtR0LzYtKFkaOcxBD6QB+PD919uEYkaw
         sRcExezNe3Kjdcf68k5A5qvzBGYUfJn3dzlAzAeD9AqH4A2PyZ6sHIYCaVKVBgZtorwg
         D0ew==
X-Gm-Message-State: AOJu0Yzk/BdQVro62QMJwjfSoX1XsEY8KjYaXO7d2C+kOR39NtFXBtXa
	6UY0kflt+cTQEClChX2fAP2bsFfuBmQY/QANf66/Ia6o/d6oDIkqRh4/9ubxPu8=
X-Google-Smtp-Source: AGHT+IELkAMgyLeASnVJbzwF/GxPRN+LTezHRJs3Yv64SVBtFnuO5FEPoJYjpDpoE3SWJYzzKI2Wng==
X-Received: by 2002:a2e:b5b8:0:b0:2ce:d23:ec9a with SMTP id f24-20020a2eb5b8000000b002ce0d23ec9amr655114ljn.104.1706268154619;
        Fri, 26 Jan 2024 03:22:34 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id h1-20020a0564020e0100b0055d312732dbsm469202edh.5.2024.01.26.03.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 03:22:33 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 =?utf-8?q?=EF=BF=BDipraga?= <alsi@bang-olufsen.dk>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Cc: Rob Herring <robh@kernel.org>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20231004063712.3348978-3-alvin@pqrs.dk>
References: <20231004063712.3348978-1-alvin@pqrs.dk>
 <20231004063712.3348978-3-alvin@pqrs.dk>
Subject: Re: (subset) [PATCH v2 2/4] ARM: dts: dove-cubox: fix si5351 node
 names
Message-Id: <170626815309.51665.6755169978488848085.b4-ty@linaro.org>
Date: Fri, 26 Jan 2024 12:22:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4


On Wed, 04 Oct 2023 08:35:28 +0200, Alvin Šipraga wrote:
> Correct the device tree to conform with the bindings. The node name and
> index should be separated with an @.
> 
> 

Applied, thanks!

[2/4] ARM: dts: dove-cubox: fix si5351 node names
      https://git.kernel.org/krzk/linux-dt/c/2df26223650027602d017368f4e8dc1eff90404e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


