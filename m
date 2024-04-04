Return-Path: <linux-kernel+bounces-131875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113CA898D0B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BD9CB22074
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C5112DD9B;
	Thu,  4 Apr 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzEfgWlg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2312AAE7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712250708; cv=none; b=tcJ6le90FjmZt39l26OBBQuNt4CFoaXIsR9b+TRNbrtNIhlSGY1IDFvQ6go3Xj5L62V76eU63z/u1wsWbalK1odkYbX6aIdmIObdNDKadg7Tkhj0pU0lV5rVhGPDrEB3XANT54Xo2TgdGH7zFhN93+4Q4lY+68kEkd/VNR2RLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712250708; c=relaxed/simple;
	bh=ZrgcSHpGCQoN5N8qPeV22f/8t4IZfslpGaFuTJpFcPs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a2jWzV1fijAqGkV4MO5lqcgusbscchiAVEzi94qr5v7l9rrY9d5h05GWRkh1xAyMX76yJF+VFunq/wAHaEQOb6Fwvp2iFG9DkNfW19BrwbJT1njzCeQTvBD5/FWnJUhHyCJocyeMCrS9Amj78yHh1mA4rDJ8GyoV8xPsgRcE1W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzEfgWlg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F892C43390;
	Thu,  4 Apr 2024 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712250708;
	bh=ZrgcSHpGCQoN5N8qPeV22f/8t4IZfslpGaFuTJpFcPs=;
	h=From:Subject:Date:To:Cc:From;
	b=uzEfgWlgw47Pq+WsM1VOxwvSuyt0pJTWNoqjrd4BhETKLVlcSN+huDAOmmty31nfE
	 v+p21gVdWW7STTzbLJm863X0GzdbTeNcOOD5Va3B5FV17Qtwdcn2DZQbm4ioVp1pzr
	 jzZfgV1e7j17UmrDtsUdk/GhGw906OPegsPFDHlIR7CpcZxcU4V0HkI/EE49+ANzyk
	 EFbbEJzOwU+saG2TIYMJcJ/p7ZCWD2ArYw+HFBBDCEvuJhphiplk934/FQMAASHLqk
	 WhFYMOCsVxZ6lavqHue8Jfwv7A5CJKeoDA87yf1L1RjDGX2rKV0gJwqdxTIPp1Invi
	 fqBh+WE+JuaqQ==
Received: by jupiter.universe (Postfix, from userid 1000)
	id F1B8A4800CD; Thu,  4 Apr 2024 19:11:45 +0200 (CEST)
From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 0/3] RK3588 PCIe bifurcation fixes
Date: Thu, 04 Apr 2024 19:11:25 +0200
Message-Id: <20240404-rk3588-pcie-bifurcation-fixes-v1-0-9907136eeafd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD3fDmYC/x2MSwqDQBAFryK9tsHPmKhXERfj+EwaQaXHBEG8u
 428VfGoOilCBZHa5CTFX6Ksi0GeJhS+fvmAZTSmIitcZmOdy6queQsCHmT6afC7OTzJgcjunaN
 5DY0b4ckam+I5LNH113UDK9I+oG8AAAA=
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Michal Tomek <mtdev79b@gmail.com>, 
 linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=929; i=sre@kernel.org;
 h=from:subject:message-id; bh=ZrgcSHpGCQoN5N8qPeV22f/8t4IZfslpGaFuTJpFcPs=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGYO30sVW9U7eD3x3exYnO0IKAUJ4oUHm/4pp
 6N85UZ8gM4H44kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJmDt9LAAoJENju1/PI
 O/qabL8QAIylHe4eCyMwjHtR4I6P2Ktf16wYoPbP/bWu1iODtubvwdPhGy4g1BZVpXRMiYAOnLC
 ZdGk2Z9OEw5FDYCCAZ60Ab6y4Veib9dufSE/CSgIlGWdB0BVdAG7tvLtayt+o8yIsxzaZi0yues
 7CuIpoCTkYApBzpH8Fn+AlBZdFXsqMo37OImSXYeoKOXwOckOKh3WifsWaUOH0EBvexx5vZcG3j
 fLMWKEn5nrKt6EqW031cxhpXFyleWDoT3L9gGBMkZj203KGoEVo7tobP68sYLKc9v2kAum57BS7
 0jRpdt+trxn9VguzfbBhhgyh3GWG2kVFIkaTiY21tuZ4XdGC67COjmt4rZlVqfqdUk+ZVCLEKey
 jWTqvdObTtEzOwOTrPDSXr1tFCK8FjoKGN9evawN5cfUG+CsZ9MKEmTUN/V+2Mar0tL2UUkyGLS
 lSMR6LdZUcSfaxo63l2q/sUV49t+fSRqGzzaOTX97piSXY+hgdvMpJUM5AiOYbIlkVgqLjmBiLu
 dGdfTY67N6qksrrqfsjDpbKxE3uZpVn7GiKVt3W9Bl8QSSvC10aGPKxhu4oefi4vKbIQ9QYpLWB
 RcEAO5YmZlXxA/B9pdL/4bQxrwxpq6wTpjz/kBGlR1ekWCww1bwdNZzEo6vJIJShDXomPvvzgKS
 PH/kHjld61ob5QZWV4iw4IA==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

So far the RK3588 boards supported upstream do not make use of
bifurcation, so it went unnoticed that this feature is broken.
Michal Tomek tried getting a CM3588 running and noticed some
problems. These patches fix the bifurcation problems on CM3588
and also work fine on Rock 5B and EVB1.

---
Michal Tomek (1):
      phy: rockchip-snps-pcie3: fix bifurcation on rk3588

Sebastian Reichel (2):
      phy: rockchip-snps-pcie3: fix clearing PHP_GRF_PCIESEL_CON bits
      phy: rockchip: naneng-combphy: Fix mux on rk3588

 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 36 ++++++++++++++++++++--
 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c     | 31 ++++++++-----------
 2 files changed, 46 insertions(+), 21 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240404-rk3588-pcie-bifurcation-fixes-471e96b94dea

Best regards,
-- 
Sebastian Reichel <sre@kernel.org>


