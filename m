Return-Path: <linux-kernel+bounces-114182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6C58888F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290AC2875C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DBC24AE94;
	Sun, 24 Mar 2024 23:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOUyccBv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172D2137752;
	Sun, 24 Mar 2024 23:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321519; cv=none; b=XeeVYDxH/ljKgsHglqNbu37myZe4KVRLZu2XZnZ+YcMwPIu56r2+b17eBH1YJsYJWNZ8lWDXWBQCTDd9jFM+8YUUyL+EXU5T7qSyZOZJ/0sbm6EuybinxR18+jufDprj17LJvDsmlAYLCNuUHr4Lm76tShuZEaSIC+rL+pxv72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321519; c=relaxed/simple;
	bh=NWPrkaaaSy9kKYxmurUP9GafqEG7VJh8Z50d+eN03o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mt950TA1cernzW4eyG7+IPN/fYaBhLa8bLDx9pB7pCLxYAwVEFT7IeOtaaVhjFIeGKcKdaNB1gvcXUw0D58jNlr4xWDth8REliG6vznJD8VHmM1/K/Ps5j83fgX5pixcYb+hVTNE1RVhuE7a25rNtX5lo0Ic3B/hn5yDkWXqoV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOUyccBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A7BC433F1;
	Sun, 24 Mar 2024 23:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321517;
	bh=NWPrkaaaSy9kKYxmurUP9GafqEG7VJh8Z50d+eN03o8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tOUyccBv/eqIXQOkY6cpHm4pGaJjTWyvlNaRoaj5lv4bFFMhcpho0Va1SFOPcKDA3
	 Z92wmN5DQQMMDrlne3G8CzyMkUr1ygxBn+natT8j1/v0hWQ669pJNO7FAd4+mYepuO
	 dunL/iJemjI1Okki4acgDP38tZI0v9aYiyYi6j3vgTNYwlSOEnf3rsdaBraRuVYeay
	 b6o0M48nSSDZcMDr7vew0Kt3AJsylnV2if5/XOBu5R/Fvg4FhsOg/cYaAEtRx1R+Zt
	 p1YKuAwaJS9lSFx5d2B7T2Yjb0+uZnVfJlkt2ZfO8JDj0PFFbZ48d8jHgGM23eJ2/h
	 xSI2beqt1VYmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hsin-Te Yuan <yuanhsinte@google.com>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 244/638] arm64: dts: mt8195-cherry-tomato: change watchdog reset boot flow
Date: Sun, 24 Mar 2024 18:54:41 -0400
Message-ID: <20240324230116.1348576-245-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Hsin-Te Yuan <yuanhsinte@google.com>

[ Upstream commit ef569d5db50e7edd709e482157769a5b3c367e22 ]

The external output reset signal was originally disabled and sent from
firmware. However, an unfixed bug in the firmware on tomato prevents
the signal from being sent, causing the device to fail to boot. To fix
this, enable external output reset signal to allow the device to reboot
normally.

Fixes: 5eb2e303ec6b ("arm64: dts: mediatek: Introduce MT8195 Cherry platform's Tomato")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20240124-send-upstream-v3-1-5097c9862a73@chromium.org
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
index 2d5e8f371b6de..a82d716f10d44 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
@@ -23,3 +23,7 @@ &sound {
 &ts_10 {
 	status = "okay";
 };
+
+&watchdog {
+	/delete-property/ mediatek,disable-extrst;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
index 2586c32ce6e6f..2fe20e0dad836 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
@@ -43,3 +43,7 @@ &sound {
 &ts_10 {
 	status = "okay";
 };
+
+&watchdog {
+	/delete-property/ mediatek,disable-extrst;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
index f54f9477b99da..dd294ca98194c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
@@ -44,3 +44,7 @@ &sound {
 &ts_10 {
 	status = "okay";
 };
+
+&watchdog {
+	/delete-property/ mediatek,disable-extrst;
+};
-- 
2.43.0


