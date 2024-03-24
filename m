Return-Path: <linux-kernel+bounces-113109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68299888186
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949E01C21A3A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D27158D79;
	Sun, 24 Mar 2024 22:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mN3FhzuT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F36158D61;
	Sun, 24 Mar 2024 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319917; cv=none; b=f0l87rY7BRUSkRaM+yWW2WKueZx5YDQWBzX7K58FkFlmQMhUz4r6zvK1Q6kFFKPfs9IGuGj0dgp99SSLS68RkOczCsvHxyE2g/gd+38UFE8NnVYpLt4eMrEwdVvEsoEWtytREtHLzCPFJufgRTQzU+QvqbjnV2lW/X2SniHKqxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319917; c=relaxed/simple;
	bh=NWPrkaaaSy9kKYxmurUP9GafqEG7VJh8Z50d+eN03o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAc4dywXo9g1jstQa55sxq/ZorNL+vwCeCODnOQRZts4W8C1g6V8Us17uwWRuSclylqQubdwFcAS4COqfN95QrQDtfPFxDRXyy31CAUB+lSpVhbMWFmBhS9hfldNb1UM5ksNSBDbpU5+q/j6WtNalm5WD8HO0nisqIohYM6eXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mN3FhzuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C60C433F1;
	Sun, 24 Mar 2024 22:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319916;
	bh=NWPrkaaaSy9kKYxmurUP9GafqEG7VJh8Z50d+eN03o8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mN3FhzuTHqJvmoO4r2pWKNmJ9zVblJNM9BAnZm9Uk/vqfN7t9upk/+FHAo970mG6i
	 Moed8CffcAktcI4MB3xDlfKZtwX+LiYsS+0TGtQbP7EGg54OFT5W5216NhApcmlv95
	 lTuMMD7DloN3sOPk4gGAdwV0D4j9OcCOgw0DuGGNNz3Wrj7LklilY04qN3ueMGsrfz
	 nix8H4FLy6j0kDQ2Kbwq2Ud2vq6ZyCPaETOhlzuZcjggXP4fQUZ+ne76HGpKXpUvXq
	 46opjab65jxRP9ETkLUpY975V3iF3b52ap9CtoAg9hk4umiLVcfKte0UPPZGD1ll5J
	 +si3qkSWhN9Og==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hsin-Te Yuan <yuanhsinte@google.com>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 222/715] arm64: dts: mt8195-cherry-tomato: change watchdog reset boot flow
Date: Sun, 24 Mar 2024 18:26:41 -0400
Message-ID: <20240324223455.1342824-223-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


