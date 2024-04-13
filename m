Return-Path: <linux-kernel+bounces-143730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 095928A3CC1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A564D1F218DA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA04B446AF;
	Sat, 13 Apr 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwcX/NCf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BAC3D579;
	Sat, 13 Apr 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713013362; cv=none; b=dZtkM4QbkvcprPS1pHWyidDe3kG6mkkywiKzCPnlgPYymakmrfxb+hU26gjJwlGK4e9iilEoiLUDF03jBS8Ug0ks+Z9Jvl22OEEFYXQIpgjYZ0h6HRlC8VkBJtdDNqF0XOJBuokoRlBvIYZiXTmbrXoAKhIjOAauy6ou3dBv77Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713013362; c=relaxed/simple;
	bh=pVQjuPI57KbahrnQhg6dIo3ahNunEx71IV9EAyTo2nM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nm13z5laI21oo3Z7DYKrLwWZsAbm2Tvp5ZsaHOWIo6Y6OGgtpWX9wulnKOwt+dXzaibJ69e6il281Sb1ANeYXc4WO642supsXVHC/WXZFa/rD9T4GdLrdp26yG9LBW0zj+DnMTxp/zDCVMSaktc7BduElETyao/dXfUCanPadCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwcX/NCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93C67C2BD10;
	Sat, 13 Apr 2024 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713013361;
	bh=pVQjuPI57KbahrnQhg6dIo3ahNunEx71IV9EAyTo2nM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mwcX/NCf8qv2N83LoXBH8GorBBMYA4JC6D+71nb26IMJ+hioFHNMzDbKTNwfPHIeL
	 yZZJahmyYQqO4fB7voQM5XndMNeZZb3Y935NFJlvgNlhnQFXNddw+tXDJ9SJNQR0oM
	 tS5k3l2WO9D1iUlwd/ZqV283bwb8SwZbaFuIj4wWQNP3yzGQ89DUEceCWAyWmdI0HK
	 MBgalFRd55YDhyyClishmxV0IoGthYOFbVVrwIEvfIHO0S0ktQGpJ81F4ZOT13vm7f
	 u8S9FCcuCppVbBIKAtCy+Ouavdqdiyd1/mirBiE0nL/WY+8/TgufPB6v6dXE6NkgmZ
	 P2fJlZIC62KYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B694C04FFE;
	Sat, 13 Apr 2024 13:02:41 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Sat, 13 Apr 2024 16:01:39 +0300
Subject: [PATCH net 1/2] net: dsa: mt7530: fix mirroring frames received on
 local port
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240413-b4-for-net-mt7530-fix-mirroring-to-local-port-and-mt7988-v1-1-476deff8cc06@arinc9.com>
References: <20240413-b4-for-net-mt7530-fix-mirroring-to-local-port-and-mt7988-v1-0-476deff8cc06@arinc9.com>
In-Reply-To: <20240413-b4-for-net-mt7530-fix-mirroring-to-local-port-and-mt7988-v1-0-476deff8cc06@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Holger Stadali <hs@giax.de>, 
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com, 
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713013352; l=2274;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=16zG1ybHG9AjnsjIF0xkfp7UyTV+eA87bDmkriEzcpo=;
 b=KcNANl0mubqFS1YqweAnMdHpJB5HByJ1podyxKwJi3gKD5uCCVVgSrXMANiux9wInU0qIHBZo
 43BL6ZB0k3fAOxpJa8Qf5ES8aB/zvZrk5wlu/eyWfx2L9tbfs1d4OCn
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt
 with auth_id=115
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

This switch intellectual property provides a bit on the ARL global control
register which controls allowing mirroring frames which are received on the
local port (monitor port). This bit is unset after reset.

This ability must be enabled to fully support the port mirroring feature on
this switch intellectual property.

Therefore, this patch fixes the traffic not being reflected on a port,
which would be configured like below:

  tc qdisc add dev swp0 clsact

  tc filter add dev swp0 ingress matchall skip_sw \
  action mirred egress mirror dev swp0

As a side note, this configuration provides the hairpinning feature for a
single port.

Fixes: 37feab6076aa ("net: dsa: mt7530: add support for port mirroring")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 6 ++++++
 drivers/net/dsa/mt7530.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index c0d0bce0b594..b84e1845fa02 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2480,6 +2480,9 @@ mt7530_setup(struct dsa_switch *ds)
 			   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));
 	}
 
+	/* Allow mirroring frames received on the local port (monitor port). */
+	mt7530_set(priv, MT753X_AGC, LOCAL_EN);
+
 	/* Setup VLAN ID 0 for VLAN-unaware bridges */
 	ret = mt7530_setup_vlan0(priv);
 	if (ret)
@@ -2591,6 +2594,9 @@ mt7531_setup_common(struct dsa_switch *ds)
 			   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));
 	}
 
+	/* Allow mirroring frames received on the local port (monitor port). */
+	mt7530_set(priv, MT753X_AGC, LOCAL_EN);
+
 	/* Flush the FDB table */
 	ret = mt7530_fdb_cmd(priv, MT7530_FDB_FLUSH, NULL);
 	if (ret < 0)
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 585db03c0548..a08053390b28 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -32,6 +32,10 @@ enum mt753x_id {
 #define SYSC_REG_RSTCTRL		0x34
 #define  RESET_MCM			BIT(2)
 
+/* Register for ARL global control */
+#define MT753X_AGC			0xc
+#define  LOCAL_EN			BIT(7)
+
 /* Registers to mac forward control for unknown frames */
 #define MT7530_MFC			0x10
 #define  BC_FFP(x)			(((x) & 0xff) << 24)

-- 
2.40.1



