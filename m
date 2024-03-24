Return-Path: <linux-kernel+bounces-115650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B475A889D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4465D2A7552
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9572567E5;
	Mon, 25 Mar 2024 02:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxXFbDgR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C0B137767;
	Sun, 24 Mar 2024 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321522; cv=none; b=hIOGzpNGNZvohVOQXzgyI8a+3C02Br4WOjsNNz6WnG2cHp7P2bzPI/Qm8JJcnduwkX8b5ACxgsiPIiKU976Z56VZA/moH5PPJIFWzaVrp+N1oJt0ZS4VZhs89NZnAWxjCjcdIObAaeR00etUFG2XHURNNGAlTFnYVm10swhhb0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321522; c=relaxed/simple;
	bh=qgjDD4+v1GbaGVNaQ8KO5jjN0cQJtYQc3ceXmRvpMAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u38dsaaUyCVI3krKTKR9kbtQeadr3hl/UJMtIkaFd2bVWbx6eYXJ3UVWohL10cf6YSeN9WtBAtUvkPL4BRDiykp8STKw5eUcnkH/HX90oISD1ZJjyIhY2NPg/kZYJPGwUCsjfM07ErP+4ErUrljG4p48OMH/kghAlo94FkJ7OnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxXFbDgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EA7C43390;
	Sun, 24 Mar 2024 23:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321521;
	bh=qgjDD4+v1GbaGVNaQ8KO5jjN0cQJtYQc3ceXmRvpMAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CxXFbDgRudVaVnppYLjuLd6g9DKTdeTeSLLRHdCLjbz1v8K3rJI/T0SQIYr+kdyuP
	 ENPtIW8n7s1iQbsmlb7BOWPqSNaQ3gZwximoeMVD04Iv+QjvdVbHDTYZLHF4VkoycL
	 kMqhYWF0FA94EDTAkHkOCiykAGH1B26o2g18YOxmBU2714+Dmp44TcOP6XGuC5uFKv
	 0szWswsqQ9OHlowgweJqVuQ9ysN6q4f/bVjTiyRj+KmzeHgBp+bCUk5/r5WT2g6qxG
	 dT3pNVEzEOy4ciA6hU5JHKH4p/dmVVvBpAq783w2mkYa12a/qPJp8DV9WppP3Tg297
	 an0bHbAWRUKPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jai Luthra <j-luthra@ti.com>,
	Vaishnav Achath <vaishnav.a@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 248/638] arm64: dts: ti: k3-am62p: Fix memory ranges for DMSS
Date: Sun, 24 Mar 2024 18:54:45 -0400
Message-ID: <20240324230116.1348576-249-sashal@kernel.org>
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

From: Jai Luthra <j-luthra@ti.com>

[ Upstream commit 90a67583171f213711de662fab9f8d24a2d291a9 ]

The INTR module for DMASS1 (CSI specific DMASS) is outside the currently
available ranges, as it starts at 0x4e400000. So fix the ranges property
to enable programming the interrupts correctly.

Fixes: 29075cc09f43 ("arm64: dts: ti: Introduce AM62P5 family of SoCs")
Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Link: https://lore.kernel.org/r/20240220-am62p_csi-v2-1-3e71d9945571@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62p.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
index 294ab73ec98b7..dc0a8e94e9ace 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
@@ -71,7 +71,7 @@ cbass_main: bus@f0000 {
 			 <0x00 0x43600000 0x00 0x43600000 0x00 0x00010000>, /* SA3 sproxy data */
 			 <0x00 0x44043000 0x00 0x44043000 0x00 0x00000fe0>, /* TI SCI DEBUG */
 			 <0x00 0x44860000 0x00 0x44860000 0x00 0x00040000>, /* SA3 sproxy config */
-			 <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>, /* DMSS */
+			 <0x00 0x48000000 0x00 0x48000000 0x00 0x06408000>, /* DMSS */
 			 <0x00 0x60000000 0x00 0x60000000 0x00 0x08000000>, /* FSS0 DAT1 */
 			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00010000>, /* OCSRAM */
 			 <0x01 0x00000000 0x01 0x00000000 0x00 0x00310000>, /* A53 PERIPHBASE */
-- 
2.43.0


