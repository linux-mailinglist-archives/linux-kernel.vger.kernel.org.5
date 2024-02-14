Return-Path: <linux-kernel+bounces-66036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEC78555AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2077C1C21ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385A91419AA;
	Wed, 14 Feb 2024 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFlHyR2U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C41126F3B;
	Wed, 14 Feb 2024 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707949331; cv=none; b=W+smALPMmikseEx8H6UgDId6Zn2id9El7qPVfsCxxdmvux+iWrJg/FOutE6eNp7XIZzizltaPWRrXfhllraxP60UEtTAyAOTcbiWLa7qQhEucdvCVeWgEsDjjJkUhzCqUE+XiD0q2ypcKH5gO5AAP++7LKvrAoVsw1WwoOz/t/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707949331; c=relaxed/simple;
	bh=haWbbEkw2NY+b1BhQhricbLDp7rvk1DgxpMz4z97Gsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AdGR+7ed+/dCH9tuFuDYau7Kk5BhUceS638UmV3LBNiAWHsPMungixTR0uspzPKmWLxcz6fEV9gjwFJyx+sP1VKfOtAaPw4F1XfBEf/KlJBld+pbue7EdvToY+RPnlhgD3pTdISt5ZkJaNAcU0kiTbbfjeGOTJatHJ/cgS1m6a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFlHyR2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D734AC433F1;
	Wed, 14 Feb 2024 22:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707949330;
	bh=haWbbEkw2NY+b1BhQhricbLDp7rvk1DgxpMz4z97Gsc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=YFlHyR2UhwrTMFFPuRlUOHVUVrFfr8+BxUcZ8Y3yg4Vb+mEBKXE0EQAulm1hZnSRi
	 gSm+mGbyjPIaqsGZ0NKuZBUmBerRv7hj7KoidbBqoxRnyHao1TRtyMtuIU6gfdEBT5
	 hs7gvrSqIkJp+hTorV/SQ31so4aoyyjxFX47HHcTjKrOLqILbUyDA2Y5pnbtrhmhwz
	 8giBYc7+jK2LikWvrfrkL4nV77C2suazVuB9UPMoT1rffFrsK68pR2NvFYJ3If3YZ6
	 Wl6/zdrLH8JPDTpJ2WUBUVp9+E03UWTS9jPNhqd33MwaoN8ADiX2EBL5Beh4SRXaou
	 kFDnMlzvvRuFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18DDC48BEB;
	Wed, 14 Feb 2024 22:22:10 +0000 (UTC)
From: Zachary Goldstein via B4 Relay
 <devnull+zachary.goldstein.concurrent-rt.com@kernel.org>
Date: Wed, 14 Feb 2024 17:21:54 -0500
Subject: [PATCH] arm64: ls1046ardb: Replace XGMII with 10GBASE-R phy mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20240214-ls1046-dts-use-10gbase-r-v1-1-8c2d68547393@concurrent-rt.com>
X-B4-Tracking: v=1; b=H4sIAAE9zWUC/x2MQQqDMBAAvyJ77sJuiIH0K+IhrZt0oVjJWhHEv
 xs8DXOYOcCkqhg8uwOqbGr6m5vwo4P3J81FUKfm4Mh5cuzxa0w+4LQa/k2QqbxSY0USipFzCn2
 O0PKlStb9Xg/jeV6yi7OvagAAAA==
To: Shawn Guo <shawnguo@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>, 
 Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Zachary Goldstein <zachary.goldstein@concurrent-rt.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707949330; l=1035;
 i=zachary.goldstein@concurrent-rt.com; s=20230809; h=from:subject:message-id;
 bh=BGRIPx+hnBEVvcJ92A45ST1Vx+ijHTH7otOABNKiaNE=;
 b=cnJjLYsULO9fgq8vCh9rD+0wuwb3Lt2hZFgIo9bcbpGw2f8YVDH07WSZL9LCktQlciB1AD9P7
 cU7g9eKBOCODnYsM5p+LfRiwjSZ2jE5iP2/N7RZAjkgqZx0LJiboJjh
X-Developer-Key: i=zachary.goldstein@concurrent-rt.com; a=ed25519;
 pk=GLF18lQ96tRolyWMpDtJzDQ9bi7+1+rMHript5TFdSg=
X-Endpoint-Received:
 by B4 Relay for zachary.goldstein@concurrent-rt.com/20230809 with auth_id=74
X-Original-From: Zachary Goldstein <zachary.goldstein@concurrent-rt.com>
Reply-To: <zachary.goldstein@concurrent-rt.com>

From: Zachary Goldstein <zachary.goldstein@concurrent-rt.com>

The AQR107 family does not support XGMII, but USXGMII and
10GBASE-R instead. Since ce64c1f77a9d ("net: phy: aquantia: add USXGMII
support and warn if XGMII mode is set") the kernel warns about XGMII
being used. The LS1046A SoC does not support USXGMII, so use 10GBASE-R
instead.

Signed-off-by: Zachary Goldstein <zachary.goldstein@concurrent-rt.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
index 07f6cc6e354a..d2066f733dc5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
@@ -149,7 +149,7 @@ ethernet@ea000 {
 
 	ethernet@f0000 { /* 10GEC1 */
 		phy-handle = <&aqr106_phy>;
-		phy-connection-type = "xgmii";
+		phy-connection-type = "10gbase-r";
 	};
 
 	ethernet@f2000 { /* 10GEC2 */

---
2.40.1
base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de


