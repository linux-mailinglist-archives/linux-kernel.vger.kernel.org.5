Return-Path: <linux-kernel+bounces-113032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915A08880EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497F8280F62
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0738913B296;
	Sun, 24 Mar 2024 22:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONO5Ddea"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4521313AA5A;
	Sun, 24 Mar 2024 22:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319842; cv=none; b=nFmtTwk2GDzFv0sxTmTZc9OS9FZS56TXw9/uoMAN4UyvYwXvsUa6cieOuQCaCMzxNaH94mVN6MsJ2GkzJq4ljq9kGWqSuFXCaF2SnO7uOiO7g97r0jtjBGKsx2Hlhzv7mOOBI5aJww+xv76TFPC/44BzEPxjY07grP3BQl6hiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319842; c=relaxed/simple;
	bh=9NcakU9G8bqt6hsTUXpyWlRCofJvXcdffxzku17p6/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0l/pe/I/hek8Cs2BxPKv2rbChtWMj9jkdV/PzihWCAGHb6FKvGA5OV4gACO/MvfNoW0UmI78jtaSRMf6XdY+zDIU/gVAe6co5yqSpgCZzJw3pVe9ZhlKfMzwXcTHgwU0Dt6mk6wON9/ZvZQVu7G9nu5R43z2uzkL6kUqN0zdqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONO5Ddea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B90FC43390;
	Sun, 24 Mar 2024 22:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319842;
	bh=9NcakU9G8bqt6hsTUXpyWlRCofJvXcdffxzku17p6/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ONO5Ddea/k17fUcg+sBZI96Vnb6DgH22tnMQgzTCf24plXkPwjEOVLnyE0gOv6Fxt
	 JVsqkA1VCaUIyeVhUGQuYN8RF+vNINQ2q2UhqIeFRIdUI/ATvGHSesSeAVP5cf2IG5
	 G9IucWkJBZ9NjlF2TmO3B+yVOOhLY2Q6g0eAQFTJZsMFYlSbTRmX+rrKuoFlo00j/b
	 VfS/MuKc0ZEt6XBnZL6hD15JvKUBe/7XfyeEgrEKZR5o9fML8PEBP3EUZLdIGlyaW0
	 SANR+Uovr0nv8pbNzo6Y6jHvRtOohcaixtFBjig2SXV89jJ1q0u+W6Ss6YX7fkt0HB
	 Bgn/nmPPigrcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manorit Chawdhry <m-chawdhry@ti.com>,
	Andrew Davis <afd@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 145/715] arm64: dts: ti: k3-j784s4: Fix power domain for VTM node
Date: Sun, 24 Mar 2024 18:25:24 -0400
Message-ID: <20240324223455.1342824-146-sashal@kernel.org>
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

From: Manorit Chawdhry <m-chawdhry@ti.com>

[ Upstream commit e4d252e6d29208aea56d4c04270523e306b1e3c2 ]

Fix the power domain device ID for wkup_vtm0 node.

Link: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j784s4/devices.html
Fixes: 64821fbf6738 ("arm64: dts: ti: j784s4: Add VTM node")
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
Reviewed-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20240201-b4-upstream-j721s2-fix-vtm-devid-v2-2-85fd568b77e3@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 3902a921d7e58..337122c3f4020 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -628,7 +628,7 @@ wkup_vtm0: temperature-sensor@42040000 {
 		compatible = "ti,j7200-vtm";
 		reg = <0x00 0x42040000 0x00 0x350>,
 		      <0x00 0x42050000 0x00 0x350>;
-		power-domains = <&k3_pds 154 TI_SCI_PD_SHARED>;
+		power-domains = <&k3_pds 243 TI_SCI_PD_SHARED>;
 		#thermal-sensor-cells = <1>;
 	};
 
-- 
2.43.0


