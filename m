Return-Path: <linux-kernel+bounces-151290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6A08AAC82
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406292840A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21CF7FBC2;
	Fri, 19 Apr 2024 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o52V/NHw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EDB7D3E6;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521377; cv=none; b=pdyxIRCAzwC3q0E5JP3B6NnoaIZDjqZ0pWbvLIcHaAjXtxBXwkIBnsEQ+/OKy30WNhuVCBu7nznu+Ce+ZV2MoyxDen2KW9anNOHetxZm8sEUhQgwb/yobbYc+olS7+9FXM16WOJ0qoAjjeVss02VAaZ6z7K5IKLu8zMmt67r+rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521377; c=relaxed/simple;
	bh=z4CnLGKrUD1pUXLNlD1qUSpXMrxsT8sEfZkE95NlMB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eNZinR0N/X8nsvtys9Dtn/5hR10Csddqzph43OQ4MFO5WaJG/Wpkm/guZuYqcTeLaYwPZFkX2BAEGdTQQ87Xp+9T0fVUu9KE3gBFEeA4tXKaIHtASn2kanRBYeARDqFzzrZg3zvTAO/ixVLmertgx3DZkKPCqHPTcbF93AyZZMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o52V/NHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77082C2BD11;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713521377;
	bh=z4CnLGKrUD1pUXLNlD1qUSpXMrxsT8sEfZkE95NlMB0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=o52V/NHwnruO3z3kJzNA49N2fZRIq4YlI/ultA6zQEl0QwnYJ4hEe1oxhvSLK8KUV
	 12c2vjVuUD6jqa9ktQPM6JbnECI670JMc0PX5MLKV5uoivrKx6SAMwkmzG5SY1Za00
	 YLldBadS8Z3gZhkD+ZmUfV30v35DMFzM0r1+wWJjhtoPLxsOB1zzAwx0nnZSlVh1Jr
	 TjxyPlIhxKQVYNCyZCAqW+EfejBTQptnKEPmMhj3VVqXxArt2MTL8A0Th3TDUer96L
	 09EewhsD9ZC8YOVQqQtTfyM1+1AgsjPy0jiYnAVfwkHHDThksWL26D0nMUO9RQu++a
	 TELIKt/aO0RDw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D6BC04FFE;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 19 Apr 2024 13:09:24 +0300
Subject: [PATCH net-next 01/13] net: dsa: mt7530: disable EEE abilities on
 failure on MT7531 and MT7988
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240419-for-netnext-mt7530-improvements-4-v1-1-6d852ca79b1d@arinc9.com>
References: <20240419-for-netnext-mt7530-improvements-4-v1-0-6d852ca79b1d@arinc9.com>
In-Reply-To: <20240419-for-netnext-mt7530-improvements-4-v1-0-6d852ca79b1d@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>, 
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713521374; l=3406;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=1dA5Tqo1oiLbTJdCrnbheqEyfiDY3WFrwARn+Ftc72o=;
 b=UO3hPYTxBJo1mK0GV+DML+3WC507lLVCAZaSDKCUa50HDDTamo4u6Lug3dOxyYxfuxU7+S0nj
 JyMPdPBjZ7ZDNOx2QVMov1G6N7F5CIQ2nMMXrw5qavBN57Jh1EiFU3l
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The MT7531_FORCE_EEE1G and MT7531_FORCE_EEE100 bits let the
PMCR_FORCE_EEE1G and PMCR_FORCE_EEE100 bits determine the 1G/100 EEE
abilities of the MAC. If MT7531_FORCE_EEE1G and MT7531_FORCE_EEE100 are
unset, the abilities are left to be determined by PHY auto polling.

The commit 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features")
made it so that the PMCR_FORCE_EEE1G and PMCR_FORCE_EEE100 bits are set on
mt753x_phylink_mac_link_up(). But it did not set the MT7531_FORCE_EEE1G and
MT7531_FORCE_EEE100 bits. Because of this, the EEE abilities will be
determined by PHY auto polling, regardless of the result of phy_init_eee().

Define these bits and add them to the MT7531_FORCE_MODE mask which is set
in mt7531_setup_common(). With this, there won't be any EEE abilities set
when phy_init_eee() returns a negative value.

Thanks to Russell for explaining when phy_init_eee() could return a
negative value below.

Looking at phy_init_eee(), it could return a negative value when:

1. phydev->drv is NULL
2. if genphy_c45_eee_is_active() returns negative
3. if genphy_c45_eee_is_active() returns zero, it returns -EPROTONOSUPPORT
4. if phy_set_bits_mmd() fails (e.g. communication error with the PHY)

If we then look at genphy_c45_eee_is_active(), then:

genphy_c45_read_eee_adv() and genphy_c45_read_eee_lpa() propagate their
non-zero return values, otherwise this function returns zero or positive
integer.

If we then look at genphy_c45_read_eee_adv(), then a failure of
phy_read_mmd() would cause a negative value to be returned.

Looking at genphy_c45_read_eee_lpa(), the same is true.

So, it can be summarised as:

- phydev->drv is NULL
- there is a communication error accessing the PHY
- EEE is not active

otherwise, it returns zero on success.

If one wishes to determine whether an error occurred vs EEE not being
supported through negotiation for the negotiated speed, if it returns
-EPROTONOSUPPORT in the latter case. Other error codes mean either the
driver has been unloaded or communication error.

In conclusion, determining the EEE abilities by PHY auto polling shouldn't
result in having any EEE abilities enabled, when one of the last two
situations in the summary happens. And it seems that if phydev->drv is
NULL, there would be bigger problems with the device than a broken link. So
this is not a bugfix.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 94932c3dbde9..f7c5355c1642 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -328,11 +328,15 @@ enum mt7530_vlan_port_acc_frm {
 #define  MT7531_FORCE_DPX		BIT(29)
 #define  MT7531_FORCE_RX_FC		BIT(28)
 #define  MT7531_FORCE_TX_FC		BIT(27)
+#define  MT7531_FORCE_EEE100		BIT(26)
+#define  MT7531_FORCE_EEE1G		BIT(25)
 #define  MT7531_FORCE_MODE		(MT7531_FORCE_LNK | \
 					 MT7531_FORCE_SPD | \
 					 MT7531_FORCE_DPX | \
 					 MT7531_FORCE_RX_FC | \
-					 MT7531_FORCE_TX_FC)
+					 MT7531_FORCE_TX_FC | \
+					 MT7531_FORCE_EEE100 | \
+					 MT7531_FORCE_EEE1G)
 #define  PMCR_LINK_SETTINGS_MASK	(PMCR_TX_EN | PMCR_FORCE_SPEED_1000 | \
 					 PMCR_RX_EN | PMCR_FORCE_SPEED_100 | \
 					 PMCR_TX_FC_EN | PMCR_RX_FC_EN | \

-- 
2.40.1



