Return-Path: <linux-kernel+bounces-113148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3D08881D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB7E1F21959
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652D2129E98;
	Sun, 24 Mar 2024 22:39:13 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406C016F297;
	Sun, 24 Mar 2024 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319952; cv=none; b=d8o2XHBvDst5sTHGrYwJBqfCz+/tugn8hgWJMMLmsTW5afcq3Jfpk3h0k+TK/UQ/vvyLs9+Iu9qWCkTiQvHjeJod4Y1li4FcUi1WAevjc7nbtkncXB9TJHXiWMommMypbThSxzUhPziIDukhM9ptPAqt/gHcjANboLIgLPGal4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319952; c=relaxed/simple;
	bh=dl81kezFbD0gMLV+aBPpClKA/DNxqzzvwUNVY61FOl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEulZ0a+mOHWPzOG6uHf3y0ZGFRdVnRzTNUp/U4bHLoCSBFoIGkoPD06gTSi70/VqTKO7D6siaDE2So10EpiFj/z3mcXS/MjOgxKJnK9aMzoUPopjF5XicM8aeTTUP47iOocDv1cRKY6ftmgVmN5SIw9up8Gh3QZd7jA4SBP39g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9e.versanet.de ([83.135.90.158] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1roWUV-0007sn-00; Sun, 24 Mar 2024 23:38:59 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dsimic@manjaro.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix the i2c address of es8316 on Cool Pi CM5
Date: Sun, 24 Mar 2024 23:38:51 +0100
Message-Id: <171131986744.918919.780341855295080644.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324112833.2181961-1-andyshrk@163.com>
References: <20240324112833.2181961-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 24 Mar 2024 19:28:33 +0800, Andy Yan wrote:
> According to the hardware design, the i2c address of audio codec es8316
> on Cool Pi CM5 is 0x10.
> 
> This fix the read/write error like bellow:
> es8316 7-0011: ASoC: error at soc_component_write_no_lock on es8316.7-0011 for register: [0x0000000c] -6
> es8316 7-0011: ASoC: error at soc_component_write_no_lock on es8316.7-0011 for register: [0x00000003] -6
> es8316 7-0011: ASoC: error at soc_component_read_no_lock on es8316.7-0011 for register: [0x00000016] -6
> es8316 7-0011: ASoC: error at soc_component_read_no_lock on es8316.7-0011 for register: [0x00000016] -6
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Fix the i2c address of es8316 on Cool Pi CM5
      commit: 64da060dd4eb625646970d7c96a16de617412ec5

I've also adapted the node-name accordingly.
I.e. audio-codec@10 to reflect the fixed address.

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

