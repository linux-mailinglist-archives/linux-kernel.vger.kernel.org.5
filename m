Return-Path: <linux-kernel+bounces-61904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A668B85182A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46BEDB2450A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184243CF57;
	Mon, 12 Feb 2024 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="QDAPGFOG"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38E93C486;
	Mon, 12 Feb 2024 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752031; cv=none; b=YBfGKNsW3+KFUxSe9/8K4rjjHthxwKeyE0VTSxVu6Y7XruA7toqxavm20elcjV3ASLRdGmVwbsTJmrkjR9LBHTrFVIusp/O753xEdpcxh3TeeWcBYzCpPVEd8JbjwAHPVrQub+JZm0vDgdBkNDmUY5R+XltVSV0eKnDOYoOjCa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752031; c=relaxed/simple;
	bh=MUhljBiclhV0V2vA5Xv3eSfj8tABtUDPWCxDhu338mY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eJFKzTeWrlM4KU8nk+8RKrKbNNuR1Lr+t9ojkWfhqF1qkBWm6okKwbNzAmnhMfNnNt7FSSSoF6aL/TWpSe3zzyw2wcZVN7nrzOWP+/AlXZtChqefWXyhje1FgMDj8OUdNuPzLTyH6H7rfAa0RKz73gSBwQY3mHTZNqy8nZtHo1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=QDAPGFOG; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1707751453;
	bh=oQZRF4F+VMaG/PnSRd+2qqxRcUHkMwMcRftkyRxLyiU=;
	h=From:To:Cc:Subject:Date:From;
	b=QDAPGFOGUDnlVz3BO72IhRUYgGrnYfQD5uonfWZtkNNE3Uzn73yfp3T0CSLyD/ZIe
	 pxK/ZzJmYyewYaCYddymNprnTvdUF6QsV+IHie3zbpqmdwWjJNUgqs7JZ4mzqCcou9
	 ujWxwEoMOQC7MmtDASvNymzst1A8hD0cU652TuE8=
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
	by uho.ysoft.cz (Postfix) with ESMTP id C54E3A05D4;
	Mon, 12 Feb 2024 16:24:13 +0100 (CET)
From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 1/2] ARM: dts: imx6dl-yapp4: Fix the QCA switch register address
Date: Mon, 12 Feb 2024 16:23:41 +0100
Message-Id: <1707751422-31517-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The switch address in the node name is in hex while the address in the reg
property is decimal which is wrong. Fix that and write the reg address
as a hexadecimal number.

Fixes: 15b43e497ffd ("ARM: dts: imx6dl-yapp4: Use correct pseudo PHY address for the switch")
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
index cfb0fc924b42..5763f8253d51 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
@@ -143,7 +143,7 @@
 
 		switch@10 {
 			compatible = "qca,qca8334";
-			reg = <10>;
+			reg = <0x10>;
 			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 
 			switch_ports: ports {
-- 
2.1.4


