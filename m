Return-Path: <linux-kernel+bounces-113116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AED2888196
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8FD1C21A97
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE04815AAC0;
	Sun, 24 Mar 2024 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTxnZVee"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C38015AAA6;
	Sun, 24 Mar 2024 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319924; cv=none; b=oFDoAwauAw8TfDLQyudrPGAp6bPiUL+N79HP7YGR9XdwLqwVWDVXBwsXSDrUPH47FARaQwKnu3zV/UH4gWvB3tmqb1R2c6aDh+92J2chuYSakGDxybMuV/Ir+G2r3+Co/Upnmx/17SiR+oTRWbCHknxti1kmpE5tkktfoIkY5NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319924; c=relaxed/simple;
	bh=hqBbDuRgdmrUloL1U9utTYvFeiQt+JTbYKGUkQT9D1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWrr2oDh8bMNyP5A4p5jxq33ysfIJBVC3fNLJmVLCSkGaUZ1Q6J/nXQNfDaWGA9c27uwhz8+4wP0QZuu8i2Mp50s8wjvzkmEQFYnSY8j9Co6CI0hjel8/2kj9YVVePp6X1JjG9o8n40NLDr6b+xG4sMAwCuQ+HqSQajMINXI9o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTxnZVee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E08AC433A6;
	Sun, 24 Mar 2024 22:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319923;
	bh=hqBbDuRgdmrUloL1U9utTYvFeiQt+JTbYKGUkQT9D1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTxnZVeecO+VLUQRBhVUW/N6SbzpAGEgI09N9wU3L/wxfC1d+MrnBh+mYTrcKbN8L
	 Q7ZW5u7uoqg829o3KU4I3vXJZGhh0IzYm5vM1GoeWhgvjaUYE7QNCoUvCgYx/lRf4j
	 344J2qTp8wmkKgAAV9LBO0ajceT98imkzZYCjb63ZDdrSEoZKoOBsmfBOhQNaJPb4z
	 tFNzoD5c9LO0fjZ6pTVk1KFO8wB90y2IZ+zedSAt7nmUFrsVW6TPnFSvpwP2Yn3p1V
	 wMEN5WbnlhqMa4eKXd3hw96NjQnE6sULwOqids8Y5o8B2q4d2sivwcuiewseWcuaXt
	 oPxHB5TSAggwA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jai Luthra <j-luthra@ti.com>,
	Vaishnav Achath <vaishnav.a@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 229/715] arm64: dts: ti: k3-am62p: Fix memory ranges for DMSS
Date: Sun, 24 Mar 2024 18:26:48 -0400
Message-ID: <20240324223455.1342824-230-sashal@kernel.org>
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
index 84ffe7b9dcaf3..4f22b5d9fb9f0 100644
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


