Return-Path: <linux-kernel+bounces-116148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C448899A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F006929C979
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C116C3B1196;
	Mon, 25 Mar 2024 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMWQ0O80"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E4417A933;
	Sun, 24 Mar 2024 23:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323700; cv=none; b=W5f4YxpaHNpzEqcarUeJh13pwbgFBbVbpxYYvqzWvVz3zOkgjIWzS7KWZMF8Ulv6htlWXrOlsBM1f0fSPSskyvLq0O/ood2woKR5JgaU/mHdm6YBj6xUBsGrpudjKQHcGlTGfjdZbxv5WH9P+wCSSTqXu+zJaO0MIgdJWQpd+qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323700; c=relaxed/simple;
	bh=c0uLUG+mhovqbPr9q1gR4533lawj4gn8WwbkQdk8jMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxwpGwzS7dSBkD76a/21q0m2x97y34zQIXhq7z+qfKBGhEj3arP9AY+s3WjlfVEMKKUh7f2fCeIkbfDkyeGrhYNQF0Y3m0d6YsDvMXlJ6niUEgR20SBOO8vhxUsguYX+CFGFGQqxY/+3+h2v0lH9cCKfCXpgBN+MVsBrZ/+/NSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMWQ0O80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34E7C433F1;
	Sun, 24 Mar 2024 23:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323700;
	bh=c0uLUG+mhovqbPr9q1gR4533lawj4gn8WwbkQdk8jMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMWQ0O80/Tq+h9iCYYGJ8XBV1ulVlKo1HpAg2Q41GRXiID5tObNSNdz9JLppl0rMg
	 6C3iUVg8Q7ec5WsSfy5azd8ni3BgMSoh0BumchkIzzoqzgN8DIUTDx/g4oXsTrLjZs
	 eTZw2lBJPMWJxUvBCCKXLOizEZ9M7HGhTCUp1d0yB7ZlAwdYVkE100ki27gg/1kxCj
	 5+mVbdlqbs8wISk32hHStg93UHRHKH9e59dN7wVn+HloWg9hfN4xyFx5znebQC2PfF
	 bYMaJIjXKHbxGEMR1GFmI/jMHZdeVMLRAIFfSPf9i0HwJ/Z2dpLSB2bF6QKJjTl9ZW
	 76HsBb+qKFhqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 073/238] ARM: dts: imx6dl-yapp4: Move phy reset into switch node
Date: Sun, 24 Mar 2024 19:37:41 -0400
Message-ID: <20240324234027.1354210-74-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Michal Vokáč <michal.vokac@ysoft.com>

[ Upstream commit 7da7b84fee58c85a6075022023d31edea40e81a1 ]

Drop the phy-reset-duration and phy-reset-gpios deprecated properties and
move reset-gpios under the switch node.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Stable-dep-of: 023bd910d3ab ("ARM: dts: imx6dl-yapp4: Fix typo in the QCA switch register address")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index ebc0892e37c7a..f18da2b70fdc9 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -103,8 +103,6 @@ &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii-id";
-	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
-	phy-reset-duration = <20>;
 	phy-supply = <&sw2_reg>;
 	status = "okay";
 
@@ -128,6 +126,7 @@ phy_port3: phy@2 {
 		switch@10 {
 			compatible = "qca,qca8334";
 			reg = <10>;
+			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 
 			switch_ports: ports {
 				#address-cells = <1>;
-- 
2.43.0


