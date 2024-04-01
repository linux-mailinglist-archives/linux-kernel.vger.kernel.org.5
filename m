Return-Path: <linux-kernel+bounces-127113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C608946D2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B08C1F223D6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAB055E72;
	Mon,  1 Apr 2024 21:55:53 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB3456B9C;
	Mon,  1 Apr 2024 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008553; cv=none; b=R0bg1hFdzBvdwvGltUQO1DJBcZoXnXdkwMBUGYahUw3ZUysqDXXYw2M9GYK8U+1VnUl0I7pN54hYl4KXQN8rl+IfEnWvHddNJxYwmolQJBuKecVaGYFoum9VwxdlzokALXZdiV7VjbX+WC6X6qP7PQvbTryOkmDBQCtZUGvRY3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008553; c=relaxed/simple;
	bh=X6cpgVcs2FJiescebraCebWKxwbpU3WG1GDvvn1zkXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzH7ob+sqwMsw+rQ3UaAY/5omWOylrwASZanq1+0i8XaiQehWj/9pi+GRf2FL4Va8uRK2wkzbkzNQToCPodChTXRng+kxSlmiF3tSwZC1OPARJSA1RsswtXu6109oOnGMWaA/Zio7CKJAeiPrZeFSvqp2iPtsW+DLq2/onrf80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaf.versanet.de ([83.135.90.175] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rrPct-0008FL-3v; Mon, 01 Apr 2024 23:55:35 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Folker Schwesinger <dev@folker-schwesinger.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Ruehl <chris.ruehl@gtsys.com.hk>,
	Vinod Koul <vkoul@kernel.org>,
	Yogesh Hegde <yogi.kernel@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Christopher Obbard <chris.obbard@collabora.com>,
	linux-kernel@vger.kernel.org,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 0/2] Enable internal strobe pulldown on Radxa ROCK 4 SBCs
Date: Mon,  1 Apr 2024 23:55:30 +0200
Message-Id: <171200852042.1394042.15662763470622443255.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327192641.14220-1-dev@folker-schwesinger.de>
References: <20240327192641.14220-1-dev@folker-schwesinger.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 27 Mar 2024 20:26:36 +0100, Folker Schwesinger wrote:
> Various RK3399 boards, including the ROCK Pi 4 series showed instabilities
> with some eMMC modules when operating in HS400 mode [1]. Later, a missing
> pull-down resistor on the eMMC strobe line was identified as the root
> cause of these instabilities [2].
> 
> This series enables the internal pull-down on the eMMC PHY strobe line
> for all ROCK 4 series boards as they all lack an external strobe
> pull-down resistor.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: Add enable-strobe-pulldown to emmc phy on ROCK Pi 4
      commit: f720dd9b8b6d8b2160beda789429d5489ce8a099
[2/2] arm64: dts: rockchip: Add enable-strobe-pulldown to emmc phy on ROCK 4C+
      commit: c1b1f340dd7db11f273e426e110697551c9f501f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

