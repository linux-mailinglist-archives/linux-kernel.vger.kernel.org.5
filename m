Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1C07D8BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 00:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345019AbjJZWzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 18:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjJZWzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 18:55:45 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E100D40
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 15:55:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cac925732fso12126355ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 15:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1698360943; x=1698965743; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDPjzqN0olGBDf5Q5ZIPAo/gpgTzA9Si8eDxt4dySas=;
        b=CavR/FwurYeA85Aq6iodGp4jXhq5f5pmIUEfrXJtztjr50hkaF0ntc/MsJEd+SKh9f
         Ld8ZtRKKZiUpqCGNACh3VtGCwji4SfIMkqyLh5skMfmLSVkYebi+LNIip3deo1UpA0Kr
         nFQM0qe0lfxof3Gzg4BYWOJcTx7QUEp7cYj+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698360943; x=1698965743;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDPjzqN0olGBDf5Q5ZIPAo/gpgTzA9Si8eDxt4dySas=;
        b=cZUSypg8sEw4p8fznqocHYMmInOJe7i6lsOI5V3T6sgEkopQHdFHRd/2dc9WqTmcxI
         n5coEZVy18y8ATRrBF1vl/kyxp9LbH/F+M/93XfIi3301JVwyScPcLgo8iRsNsrNdYRC
         PGBr/qI1wpNAat3Bx5bwKtXVgaeU/3Xm0mdQH705qyqwtYr/bREIXrIC6dXDbfVD6eIm
         c1bxTuuoxBascyAUPqKkTDZn/c305u/xFE66rLoPbKvgOY5yXCB3oY2v/Fa688JIdknp
         Wp0WFZmIYF1ZLSyaLao1NYJ322FJu5IgrRlH3Mz5caro5Mf+mXWXB1TImpXOjg0HLnKX
         C2gw==
X-Gm-Message-State: AOJu0Yx8IAD2+dHC8bl5fT6eVDVsBRdJwkU2iXxU03KK0eSCmi01t9jn
        MhvMwCpBr32CLfQYkYZ7ZwDfMA==
X-Google-Smtp-Source: AGHT+IG5L2uwMX10PCEPHxC1xLkEHNpI+SjwHHdW+/Nnmg4qB1uiCpao4Wf4Hb4GtCmDHy35jo6mGQ==
X-Received: by 2002:a17:902:eb42:b0:1c9:c951:57f9 with SMTP id i2-20020a170902eb4200b001c9c95157f9mr884795pli.68.1698360943030;
        Thu, 26 Oct 2023 15:55:43 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902d4c100b001c9b5b63e36sm206295plg.32.2023.10.26.15.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 15:55:42 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/5] net: phy: Add pluming for ethtool_{get,set}_rxnfc
Date:   Thu, 26 Oct 2023 15:45:07 -0700
Message-Id: <20231026224509.112353-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026224509.112353-1-florian.fainelli@broadcom.com>
References: <20231026224509.112353-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000bb65000608a6781c"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000bb65000608a6781c
Content-Transfer-Encoding: 8bit

Ethernet MAC drivers supporting Wake-on-LAN using programmable filters
(WAKE_FILTER) typically configure such programmable filters using the
ethtool::set_rxnfc API and with a sepcial RX_CLS_FLOW_WAKE to indicate
the filter is also wake-up capable.

In order to offer the same functionality for capable Ethernet PHY
drivers, wire-up the ethtool::{get,set}_rxnfc APIs within the PHY
library.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/phy/phy.c | 19 +++++++++++++++++++
 include/linux/phy.h   |  8 ++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index a5fa077650e8..e2f2cc38ff31 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1740,3 +1740,22 @@ int phy_ethtool_nway_reset(struct net_device *ndev)
 	return ret;
 }
 EXPORT_SYMBOL(phy_ethtool_nway_reset);
+
+int phy_ethtool_get_rxnfc(struct phy_device *phydev,
+			  struct ethtool_rxnfc *nfc, u32 *rule_locs)
+{
+	if (phydev->drv && phydev->drv->get_rxnfc)
+		return phydev->drv->get_rxnfc(phydev, nfc, rule_locs);
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(phy_ethtool_get_rxnfc);
+
+int phy_ethtool_set_rxnfc(struct phy_device *phydev, struct ethtool_rxnfc *nfc)
+{
+	if (phydev->drv && phydev->drv->set_rxnfc)
+		return phydev->drv->set_rxnfc(phydev, nfc);
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(phy_ethtool_set_rxnfc);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3cc52826f18e..03e7c6352aef 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1077,6 +1077,10 @@ struct phy_driver {
 	int (*get_sqi)(struct phy_device *dev);
 	/** @get_sqi_max: Get the maximum signal quality indication */
 	int (*get_sqi_max)(struct phy_device *dev);
+	/* Used for WAKE_FILTER programming only */
+	int (*get_rxnfc)(struct phy_device *dev,
+			 struct ethtool_rxnfc *nfc, u32 *rule_locs);
+	int (*set_rxnfc)(struct phy_device *dev, struct ethtool_rxnfc *nfc);
 
 	/* PLCA RS interface */
 	/** @get_plca_cfg: Return the current PLCA configuration */
@@ -1989,6 +1993,10 @@ int phy_ethtool_set_plca_cfg(struct phy_device *phydev,
 			     struct netlink_ext_ack *extack);
 int phy_ethtool_get_plca_status(struct phy_device *phydev,
 				struct phy_plca_status *plca_st);
+int phy_ethtool_get_rxnfc(struct phy_device *phydev,
+			  struct ethtool_rxnfc *nfc, u32 *rule_locs);
+int phy_ethtool_set_rxnfc(struct phy_device *phydev,
+			  struct ethtool_rxnfc *nfc);
 
 int __phy_hwtstamp_get(struct phy_device *phydev,
 		       struct kernel_hwtstamp_config *config);
-- 
2.34.1


--000000000000bb65000608a6781c
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
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFq4DqNGgCW1Pvxe
JvBdn2YMihqXn7e+rZsCmFuFH05kMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMTAyNjIyNTU0M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCa+ckgPwav6JdaTU/5sxA/lutEKV21ykrx
ljUzUeRCjTV1T/FY6s7w4iU/H2qWHXVQ90HINPjVnzD28OgqEN93tjCWkALnh4uYikDet5OEjidv
o/9s4VFwzrrRxNswZCscXuBNwbNfV9wxoj+B1zuRnmpKIxyJd7KfGNJ+vR0H+fV9rNCCe0ZM85g5
Xu+X6YDHg7EdMPSL0PUTzEUcASPzWpDgCQZLCrvMEfvac6qG9BzD7wr8lrij+HnvZoc+h11ywYxj
58jtV5CEBhzBnUUlKeZq26n6Re7ZfrQgYjpKXXgaIgzLXec1xGXEFXIdiz2mAZU0OAcATXYJxc2o
JfRD
--000000000000bb65000608a6781c--
