Return-Path: <linux-kernel+bounces-124507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A736289190B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46FAA1F21B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85261420CA;
	Fri, 29 Mar 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpCGXMnL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BF01422C3;
	Fri, 29 Mar 2024 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715262; cv=none; b=MPT3jDW+fFaMVYdZ/BfE8bfjYRUsYnk/YUeidfLdvPURAjc/p+JtxqA2yTzPIktTVQPf1/Yk5Z3OODSP+oTHO8y2E8gmggc1jgjAhbSrEqFa9hh3f50kgcPQaWJ1+J/nlfzf59+stSkP0xAUtL3ceqTVHLryyInliSp3UA05jyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715262; c=relaxed/simple;
	bh=yHxgtU2OTtRiz2jnpK76bff4C6A+TYTVw1JRL8ZQwv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0OZ1K+yps02xjU1YxJthGEvuSuuD/fPhkoBsqUVGqH/5dtlNl7rOBAsVGueaIgBTglPbO7g0RAu/KqRtRFVlrPHvhoUH8qDxH02P8llTtiqjzrwup0geYEPUF7E/qyThwx9Be0aCvP3GOVOR6koewFbUlKCIuBBPO5s6AeH+BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpCGXMnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2171CC433C7;
	Fri, 29 Mar 2024 12:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715261;
	bh=yHxgtU2OTtRiz2jnpK76bff4C6A+TYTVw1JRL8ZQwv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dpCGXMnLRjp099+2Snbv8WY+qFy0T+XBGM5Ms/xcBrUzp1m4RqAt8yDa4c5WBN1YM
	 HQEYKV5isGTtyPWX1e0U1+7mDbhMn2HOLs5aMgx+UzohZjctdavUdvsoxT7pwFzt88
	 E37LC5ezbCKUdzOhNPSyq4B18jVfYzKzDdlgf+U4nQdJQ0SaLbqsyaOZvVpxTENX2o
	 1/0S+QBxymmYWHs/VY3Mw6wYZuJGnApACUWJHldPScPJx3jXXr/O9mT6SIPFqSXHTI
	 zGLRVsQF8EfEN5LdNrXkGFg5DZRyCUo6QfjShrvGma4erd/3VpWLMbjAu5Fb63EXT1
	 HlBTZlRMADQ+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Jonker <jbx6244@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	dsimic@manjaro.org,
	shironeko@tesaguri.club,
	jay.xu@rock-chips.com,
	jonas@kwiboo.se,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 26/68] arm64: dts: rockchip: fix rk3328 hdmi ports node
Date: Fri, 29 Mar 2024 08:25:22 -0400
Message-ID: <20240329122652.3082296-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit 1d00ba4700d1e0f88ae70d028d2e17e39078fa1c ]

Fix rk3328 hdmi ports node so that it matches the
rockchip,dw-hdmi.yaml binding.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://lore.kernel.org/r/e5dea3b7-bf84-4474-9530-cc2da3c41104@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 7b4c15c4a9c31..b6f045069ee2f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -744,11 +744,20 @@ hdmi: hdmi@ff3c0000 {
 		status = "disabled";
 
 		ports {
-			hdmi_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hdmi_in: port@0 {
+				reg = <0>;
+
 				hdmi_in_vop: endpoint {
 					remote-endpoint = <&vop_out_hdmi>;
 				};
 			};
+
+			hdmi_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};
 
-- 
2.43.0


