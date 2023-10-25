Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396E67D7267
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjJYRfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjJYRe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:34:58 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F9E186
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:34:46 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7789cc5c8ccso95103285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1698255285; x=1698860085; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Los5d3aYeepoj0yahcUu3goz1WiZGmQ5nSrf0YawsII=;
        b=M6RjsmmnqHJF9em3AdRB85OkM27TnPPISt9UtQr90PKZ1MuXKXwxQTQcQUdPpluE03
         boqF9C8qw8KoExZa0R/RIX8YyT7Vl9MIMaw4y3ZeyRASs6Lgj3NYcMey2JcyF+L4PkfW
         t87IBe9WAuY4O4gqtlv0KemVJFRs054GO266U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698255285; x=1698860085;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Los5d3aYeepoj0yahcUu3goz1WiZGmQ5nSrf0YawsII=;
        b=T4EhB3PUN6wwE7GK/8hoGP7FrUaoViXZPCnQ3QSse41BSUiB6RJ26/D3RSwZBfzDWt
         Pfr2B3aXkGFj6u+kPRunTuGrjiprXSQ00jbldm65iEN2XMZqhj0uFNLtroRFah1ifPIp
         39V0ZTo0EMqzDeq4crZpinpweLhZKVZkq/33RZsyCL9bJOF07lF+7z8Gsj9A/ccSrw8k
         4+H/GfIudcXiBfcGxQS8ZV88UZlbfSQG3gPOYQY17+El/VLE05Wh+L5fAjJyF6iA/DIm
         S/Vh6vIA3TCE38p2muUq0N2UmKsSVAfomia+MRDlm8GGriGuOokYcawPnSzLYeSX0LJa
         UK/w==
X-Gm-Message-State: AOJu0YwXE6Tf5IV70NaU/9ppL3EhO7Adr49bduUFCWGXhOGgPQSgmTxm
        5LjHsRn0KfHywLT8+Zu29OCfuA==
X-Google-Smtp-Source: AGHT+IFZ3v7uyHLlZyF+4u7hT906f65PCbZ4ddr1Z+093ZEiOkO0ZgKBiYz7kELbXCJvuF59/SDvmA==
X-Received: by 2002:a05:620a:394c:b0:777:5d4:bb4 with SMTP id qs12-20020a05620a394c00b0077705d40bb4mr435302qkn.3.1698255285167;
        Wed, 25 Oct 2023 10:34:45 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bp37-20020a05620a45a500b00767dcf6f4adsm4332384qkb.51.2023.10.25.10.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 10:34:44 -0700 (PDT)
From:   Florian Fainelli <florian.fainelli@broadcom.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Doug Berger <opendmb@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Gal Pressman <gal@nvidia.com>,
        Willem de Bruijn <willemb@google.com>,
        Daniil Tatianin <d-tatianin@yandex-team.ru>,
        Simon Horman <horms@kernel.org>,
        Justin Chen <justin.chen@broadcom.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Joe Damato <jdamato@fastly.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Jiri Pirko <jiri@resnulli.us>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 4/5] net: phy: broadcom: Add support for WAKE_FILTER
Date:   Wed, 25 Oct 2023 10:32:59 -0700
Message-Id: <20231025173300.1776832-5-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025173300.1776832-1-florian.fainelli@broadcom.com>
References: <20231025173300.1776832-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000085db406088ddf2e"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000085db406088ddf2e
Content-Transfer-Encoding: 8bit

Since the PHY is capable of matching any arbitrary Ethernet MAC
destination as a programmable wake-up pattern, add support for doing
that using the WAKE_FILTER and ethtool::rxnfc API. For instance, in
order to wake-up from the Ethernet MAC address corresponding to the IPv4
multicast IP address of 224.0.0.251 (e.g.: multicast DNS), one could do:

ethtool -N eth0 flow-type ether dst 01:00:5e:00:00:fb loc 0 action -2
ethtool -n eth0
Total 1 rules

Filter: 0
        Flow Type: Raw Ethernet
        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
        Dest MAC addr: 01:00:5E:00:00:FB mask: 00:00:00:00:00:00
        Ethertype: 0x0 mask: 0xFFFF
        Action: Wake-on-LAN
ethtool -s eth0 wol f

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/phy/bcm-phy-lib.c | 195 +++++++++++++++++++++++++++++++++-
 drivers/net/phy/bcm-phy-lib.h |   5 +
 drivers/net/phy/broadcom.c    |   2 +
 3 files changed, 201 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index 876f28fd8256..cfbeedc5ee81 100644
--- a/drivers/net/phy/bcm-phy-lib.c
+++ b/drivers/net/phy/bcm-phy-lib.c
@@ -827,7 +827,8 @@ EXPORT_SYMBOL_GPL(bcm_phy_cable_test_get_status_rdb);
 					 WAKE_MCAST | \
 					 WAKE_BCAST | \
 					 WAKE_MAGIC | \
-					 WAKE_MAGICSECURE)
+					 WAKE_MAGICSECURE | \
+					 WAKE_FILTER)
 
 int bcm_phy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
 {
@@ -881,6 +882,12 @@ int bcm_phy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
 	ctl &= ~BCM54XX_WOL_DIR_PKT_EN;
 	ctl &= ~(BCM54XX_WOL_SECKEY_OPT_MASK << BCM54XX_WOL_SECKEY_OPT_SHIFT);
 
+	/* For WAKE_FILTER, we have already programmed the desired MAC DA
+	 * and associated mask by the time we get there.
+	 */
+	if (wol->wolopts & WAKE_FILTER)
+		goto program_ctl;
+
 	/* When using WAKE_MAGIC, we program the magic pattern filter to match
 	 * the device's MAC address and we accept any MAC DA in the Ethernet
 	 * frame.
@@ -935,6 +942,7 @@ int bcm_phy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
 			return ret;
 	}
 
+program_ctl:
 	if (wol->wolopts & WAKE_MAGICSECURE) {
 		ctl |= BCM54XX_WOL_SECKEY_OPT_6B <<
 		       BCM54XX_WOL_SECKEY_OPT_SHIFT;
@@ -999,6 +1007,16 @@ void bcm_phy_get_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
 	if (!(ctl & BCM54XX_WOL_EN))
 		return;
 
+	ret = bcm_phy_read_exp(phydev, BCM54XX_WOL_SEC_KEY_8B);
+	if (ret < 0)
+		return;
+
+	/* Mutualy exclusive with other modes */
+	if (ret) {
+		wol->wolopts |= WAKE_FILTER;
+		return;
+	}
+
 	for (i = 0; i < sizeof(da) / 2; i++) {
 		ret = bcm_phy_read_exp(phydev,
 				       BCM54XX_WOL_MPD_DATA2(2 - i));
@@ -1066,6 +1084,181 @@ int bcm_phy_led_brightness_set(struct phy_device *phydev,
 }
 EXPORT_SYMBOL_GPL(bcm_phy_led_brightness_set);
 
+static int bcm_phy_get_rule(struct phy_device *phydev,
+			    struct ethtool_rxnfc *nfc,
+			    int loc)
+{
+	u8 da[ETH_ALEN];
+	unsigned int i;
+	int ret;
+
+	if (loc != 0)
+		return -EINVAL;
+
+	memset(nfc, 0, sizeof(*nfc));
+	nfc->flow_type = ETHER_FLOW;
+	nfc->fs.flow_type = ETHER_FLOW;
+
+	for (i = 0; i < sizeof(da) / 2; i++) {
+		ret = bcm_phy_read_exp(phydev,
+				       BCM54XX_WOL_MPD_DATA2(2 - i));
+		if (ret < 0)
+			return ret;
+
+		da[i * 2] = ret >> 8;
+		da[i * 2 + 1] = ret & 0xff;
+	}
+	ether_addr_copy(nfc->fs.h_u.ether_spec.h_dest, da);
+
+	for (i = 0; i < sizeof(da) / 2; i++) {
+		ret = bcm_phy_read_exp(phydev,
+				       BCM54XX_WOL_MASK(2 - i));
+		if (ret < 0)
+			return ret;
+
+		da[i * 2] = ~(ret >> 8);
+		da[i * 2 + 1] = ~(ret & 0xff);
+	}
+	ether_addr_copy(nfc->fs.m_u.ether_spec.h_dest, da);
+
+	ret = bcm_phy_read_exp(phydev, BCM54XX_WOL_INNER_PROTO);
+	if (ret < 0)
+		return ret;
+
+	nfc->fs.h_u.ether_spec.h_proto = be16_to_cpu(ret);
+
+	nfc->fs.ring_cookie = RX_CLS_FLOW_WAKE;
+	nfc->fs.location = 0;
+
+	return 0;
+}
+
+static int bcm_phy_set_rule(struct phy_device *phydev,
+			    struct ethtool_rxnfc *nfc)
+{
+	int ret = -EOPNOTSUPP;
+	unsigned int i;
+	__be16 h_proto;
+	const u8 *da;
+
+	/* We support only matching on the MAC DA with a custom mask and
+	 * optionally with a specific Ethernet type, reject anything else.
+	 */
+	if (nfc->fs.ring_cookie != RX_CLS_FLOW_WAKE ||
+	    (nfc->fs.location != 0 &&
+	     nfc->fs.location != RX_CLS_LOC_ANY &&
+	     nfc->fs.location != RX_CLS_LOC_FIRST) ||
+	    nfc->fs.flow_type != ETHER_FLOW ||
+	    !is_zero_ether_addr(nfc->fs.h_u.ether_spec.h_source) ||
+	    !is_zero_ether_addr(nfc->fs.m_u.ether_spec.h_source))
+		return ret;
+
+	ret = bcm_phy_read_exp(phydev, BCM54XX_WOL_SEC_KEY_8B);
+	if (ret < 0)
+		return ret;
+
+	if (ret)
+		return -EBUSY;
+
+	if (nfc->fs.location == RX_CLS_LOC_ANY ||
+	    nfc->fs.location == RX_CLS_LOC_FIRST)
+		nfc->fs.location = 0;
+
+	da = nfc->fs.h_u.ether_spec.h_dest;
+	for (i = 0; i < ETH_ALEN / 2; i++) {
+		ret = bcm_phy_write_exp(phydev,
+					BCM54XX_WOL_MPD_DATA2(2 - i),
+					da[i * 2] << 8 | da[i * 2 + 1]);
+		if (ret < 0)
+			return ret;
+	}
+
+	da = nfc->fs.m_u.ether_spec.h_dest;
+	for (i = 0; i < ETH_ALEN / 2; i++) {
+		ret = bcm_phy_write_exp(phydev,
+					BCM54XX_WOL_MASK(2 - i),
+					da[i * 2] << 8 | da[i * 2 + 1]);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Restore default inner protocol field unless overridden by the flow
+	 * specification.
+	 */
+	h_proto = be16_to_cpu(nfc->fs.h_u.ether_spec.h_proto);
+	if (!h_proto)
+		h_proto = ETH_P_8021Q;
+
+	ret = bcm_phy_write_exp(phydev, BCM54XX_WOL_INNER_PROTO,
+				h_proto);
+	if (ret)
+		return ret;
+
+	/* Use BCM54XX_WOL_SEC_KEY_8B as a scratch register to record
+	 * that we installed a filter rule.
+	 */
+	return bcm_phy_write_exp(phydev, BCM54XX_WOL_SEC_KEY_8B, 1);
+}
+
+int bcm_phy_get_rxnfc(struct phy_device *phydev,
+		      struct ethtool_rxnfc *cmd, u32 *rule_locs)
+{
+	int err = 0, rule_cnt = 0;
+
+	err = bcm_phy_read_exp(phydev, BCM54XX_WOL_SEC_KEY_8B);
+	if (err < 0)
+		return err;
+
+	rule_cnt = err;
+	err = 0;
+
+	switch (cmd->cmd) {
+	case ETHTOOL_GRXCLSRLCNT:
+		cmd->rule_cnt = rule_cnt;
+		cmd->data = 1 | RX_CLS_LOC_SPECIAL;
+		break;
+	case ETHTOOL_GRXCLSRULE:
+		err = bcm_phy_get_rule(phydev, cmd, cmd->fs.location);
+		break;
+	case ETHTOOL_GRXCLSRLALL:
+		if (rule_cnt)
+			rule_locs[0] = 0;
+		cmd->rule_cnt = rule_cnt;
+		cmd->data = 1;
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(bcm_phy_get_rxnfc);
+
+int bcm_phy_set_rxnfc(struct phy_device *phydev,
+		      struct ethtool_rxnfc *cmd)
+{
+	int err = 0;
+
+	switch (cmd->cmd) {
+	case ETHTOOL_SRXCLSRLINS:
+		err = bcm_phy_set_rule(phydev, cmd);
+		break;
+	case ETHTOOL_SRXCLSRLDEL:
+		if (cmd->fs.location != 0)
+			return err;
+
+		err = bcm_phy_write_exp(phydev, BCM54XX_WOL_SEC_KEY_8B, 0);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(bcm_phy_set_rxnfc);
+
 MODULE_DESCRIPTION("Broadcom PHY Library");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Broadcom Corporation");
diff --git a/drivers/net/phy/bcm-phy-lib.h b/drivers/net/phy/bcm-phy-lib.h
index b52189e45a84..7081edcec06b 100644
--- a/drivers/net/phy/bcm-phy-lib.h
+++ b/drivers/net/phy/bcm-phy-lib.h
@@ -121,4 +121,9 @@ irqreturn_t bcm_phy_wol_isr(int irq, void *dev_id);
 int bcm_phy_led_brightness_set(struct phy_device *phydev,
 			       u8 index, enum led_brightness value);
 
+int bcm_phy_get_rxnfc(struct phy_device *phydev,
+		      struct ethtool_rxnfc *nfc, u32 *rule_locs);
+int bcm_phy_set_rxnfc(struct phy_device *phydev,
+		      struct ethtool_rxnfc *nfc);
+
 #endif /* _LINUX_BCM_PHY_LIB_H */
diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 3a627105675a..6c2212bd2779 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -1107,6 +1107,8 @@ static struct phy_driver broadcom_drivers[] = {
 	.get_wol	= bcm54xx_phy_get_wol,
 	.set_wol	= bcm54xx_phy_set_wol,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
+	.get_rxnfc	= bcm_phy_get_rxnfc,
+	.set_rxnfc	= bcm_phy_set_rxnfc,
 }, {
 	.phy_id		= PHY_ID_BCM5461,
 	.phy_id_mask	= 0xfffffff0,
-- 
2.34.1


--000000000000085db406088ddf2e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINd6C1nIHIuCAHwl
c9SOte3HeCoJLThGBAwphtsrTUezMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMTAyNTE3MzQ0NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQD383I+/X+7esjXf97kwGC4Xx/omn+JPmZX
GjkAs/CVG9WdwQurog7tXJbJ7rKKELqS8tOf8SHQoAk0xxoFGZJzIYvGrW02WwM6ADqPkn3JD6Gi
xVs0vgr/S7VHOilMg/VdeSNggNO9HSFDIbsMBlgcrWGE4yKmI1tPEZWUm07/61hnilkVMVIeFbzs
pTfp5hCmCMP4p6tWJW0rvpcqeT1DjrStQNcpHgUQZmMJ2AL5pw9RCoPHPPTjKFHyF2kXcfGq38Wq
eN3IRHzIwGm9zOYoTcPYOe8P2AdjMc+3GlI0F2PSVUG09MQGPEvvObfZT6L9myt1fd0+hQZZw3Ec
5/7N
--000000000000085db406088ddf2e--
