Return-Path: <linux-kernel+bounces-33725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A439836DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95FE0286EBC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748F53E473;
	Mon, 22 Jan 2024 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWyy2bYK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B581E3D962;
	Mon, 22 Jan 2024 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942252; cv=none; b=YG90NTH4cIAfD12dE6vtN8ATswIy7yb2oMwMmR1XfG6RFRlr2O3mZKe13Wdvcc+LHUAU75MiGNzVeFAAH567NjWElO/uAClEvDIXbNRBBiGeNuyMeAcBIhEQAyPbBYsLnMT6c5RCdAtd/ox4b4HvpGtbmy7Iwms6yjZ7z+09T0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942252; c=relaxed/simple;
	bh=+bB1PovhDMEo3TwLJkit0WLf/1rP/pbwEtJbQCjHpL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hECdPJSW4jIWGupYed8eACe5bQVgZlp+P8knhx6EBYw1aqYyw6S9Tl6SZ+OBOjF1P2n51vO7oQGA2NsHxHMrQQBPIqD3Gc43soJHjJ0otqVXNZ0C5dirjOoQ/xN3fqcLMcMy/6xQVWpZNrkqx8nOHLh49Ob3y6rSqUMlHluiSRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWyy2bYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473EDC433F1;
	Mon, 22 Jan 2024 16:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705942252;
	bh=+bB1PovhDMEo3TwLJkit0WLf/1rP/pbwEtJbQCjHpL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rWyy2bYKk1m7E5oo7lRG12UXFBp0dQYKRE3U+A0tBxlphR4yQV2/P4BqftWjwP22c
	 puYbvHbN4zy8mzkHE0RnkHtt9QwGMsI5ifMWUqqFlIuRmnWH4rUdqoCRlppBElnSS0
	 aR8wqAt0i8xB8jyWZ0CcJVtbDxl6n078cKQWoEp5xMMpvQbocAo1odZS/DMn64nHBu
	 hCKcmobd6veUyFLtYCexbvpH2yMC18AiyjSBx3s3N0FhUBWtlbhxbLdXI2uKLyf8B1
	 NreGz4jAjbQLNHuFs71v15V0GfXduQjAkfsQfnjCSoqQRIrG9v0McljMUkXdD5XJ7c
	 iM48v4lieUHlw==
From: Conor Dooley <conor@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	William Qiu <william.qiu@starfivetech.com>
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Hal Feng <hal.feng@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?utf-8?q?Emil_Renner_Berthing_=3Ckernel=40esmil=2Edk=3E=2C_Rob_Herring_?=@web.codeaurora.org,
	=?utf-8?q?=3Crobh+dt=40kernel=2Eorg=3E=2C_Thierry_Reding_=3Cthierry=2Eredin?=@web.codeaurora.org,
	=?utf-8?q?g=40gmail=2Ecom=3E=2C_Philipp_Zabel_=3Cp=2Ezabel=40pengutronix=2E?=@web.codeaurora.org,
	=?utf-8?q?de=3E=2C_Krzysztof_Kozlowski_=3Ckrzysztof=2Ekozlowski+dt=40linaro?=@web.codeaurora.org,
	=?utf-8?q?=2Eorg=3E=2C_Conor_Dooley_=3Cconor+dt=40kernel=2Eorg=3E=2C_Uwe_Kl?=@web.codeaurora.org,
	=?utf-8?q?eine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40pengutronix=2Ede=3E=2C_Hal?=@web.codeaurora.org,
	=?utf-8?q?_Feng_=3Chal=2Efeng=40starfivetech=2Ecom=3E=2C_Paul_Walmsley_=3Cp?=@web.codeaurora.org,
	=?utf-8?q?aul=2Ewalmsley=40sifive=2Ecom=3E=2C_Palmer_Dabbelt_=3Cpalmer=40da?=@web.codeaurora.org,
	=?utf-8?q?bbelt=2Ecom=3E=2C_Albert_Ou_=3Caou=40eecs=2Eberkeley=2Eedu=3E?=@web.codeaurora.org
Subject: Re: (subset) [PATCH v10 0/4] StarFive's Pulse Width Modulation driver support
Date: Mon, 22 Jan 2024 16:50:25 +0000
Message-ID: <20240122-twitter-scroll-75416c5bbd27@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222094548.54103-1-william.qiu@starfivetech.com>
References: <20231222094548.54103-1-william.qiu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=886; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=U5aoRofgZ8k5FULkpvol3351Ekn65QH83qMdqdxrcpo=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnr5lyIuKvztKtyh0bUbQX3q2IfYxjX3XVzk91Wltgt8 2npA8nzHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiIqiDDP/O1rm78cby6Cslf TPv+Bf28knuKST25f+H8+nS1Mqd5tYwMZ57MPD1v0dKrlpG8PBdaDJfb3Tn4dhrrkVTeH0/ObXi jxAQA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Fri, 22 Dec 2023 17:45:44 +0800, William Qiu wrote:
> This patchset adds initial rudimentary support for the StarFive
> Pulse Width Modulation controller driver. And this driver will
> be used in StarFive's VisionFive 2 board.The first patch add
> Documentations for the device and Patch 2 adds device probe for
> the module.
> 
> Changes v9->v10:
> - Rebased to v6.7rc6.
> - Dropped unuseful dependency.
> - Added error handling.
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/4] dt-bindings: pwm: Add bindings for OpenCores PWM Controller
      https://git.kernel.org/conor/c/2529085831b0
[3/4] riscv: dts: starfive: jh7100: Add PWM node and pins configuration
      https://git.kernel.org/conor/c/26c3112c10f8
[4/4] riscv: dts: starfive: jh7110: Add PWM node and pins configuration
      https://git.kernel.org/conor/c/92df97487208

Thanks,
Conor.

