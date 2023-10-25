Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A34F7D725F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjJYReo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbjJYRej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:34:39 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4F81A1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:34:36 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7781b176131so2620085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1698255276; x=1698860076; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8q3c/7X52Wy7zcVfwBQDMcvzN37WhwhruTnBhrCjMh0=;
        b=SoTEINqvzx+GuifFgcfdj1hTPJqfasoh623EQENWEvFhYugLkQvCgM+jUjrKxTabs0
         3CESrxFw4mmHdA0EsWydq2vgrsBcHxismEfRY3ylRclwk01zTsbsPsXipBYk2FT+y7Xa
         E+QkR5vIjmEdMd4gRBncu7p3XWVGVd45z/IOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698255276; x=1698860076;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8q3c/7X52Wy7zcVfwBQDMcvzN37WhwhruTnBhrCjMh0=;
        b=j9t4I4q7CB6ovl/Atqldt01V7g6U75kM7YrW8fMyHWd/qpcKANourAsQW1jkYm1PR8
         vy8xrOOl5h/ovSCaVZ6oFL3Ra4oLHNXJil7Ulh4evb8/8SQbzR0qJAKcCG8Up0h/Uo8O
         UlpTFtssYgKGE1+UUUQ0sdBCYHtQe6qiJsopBDhRaEvDM0372ydMSoGA9Nvm7hCGEuhs
         hSk4y3FSV1JFkOxikFuLPZ+mIeClfPMvCoRPVNOPT7UzKPxpT+rpLDtwomnJ3W5j6egr
         IFRVaMqCaqDEt2toxR0bG9RyhH6w6mz84GTtavep/iaGKBWXV0pGBEdKIcC+vb8uRKF7
         ZZgQ==
X-Gm-Message-State: AOJu0Yxa6VrGqbRHEGuOq/lrPTELxjqDHh/pclPcBZL+jc7vlPGRqGZs
        pwbYwZsH7DL/c4iyj2oAsdMPTg==
X-Google-Smtp-Source: AGHT+IGPGGduNorc5Zru7sVUkApuBtefzcmppO5LF+rUA+P2lmGkGG/tn6kg3TC9a+SlMaFkuAF7hg==
X-Received: by 2002:a05:620a:2947:b0:76f:1318:d7d1 with SMTP id n7-20020a05620a294700b0076f1318d7d1mr17479300qkp.75.1698255275882;
        Wed, 25 Oct 2023 10:34:35 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bp37-20020a05620a45a500b00767dcf6f4adsm4332384qkb.51.2023.10.25.10.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 10:34:35 -0700 (PDT)
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
Subject: [PATCH net-next 1/5] net: ethtool: Make RXNFC walking code accept a callback
Date:   Wed, 25 Oct 2023 10:32:56 -0700
Message-Id: <20231025173300.1776832-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025173300.1776832-1-florian.fainelli@broadcom.com>
References: <20231025173300.1776832-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007a8a5706088dde34"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007a8a5706088dde34
Content-Transfer-Encoding: 8bit

In preparation for iterating over RXNFC rules for a different purpose,
factor the generic code that already does that by allowing a callback to
be specified. The body of ethtool_get_max_rxnfc_channel() now accepts a
callback as an argument and is renamed to __ethtool_for_each_rxnfc().

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 net/ethtool/common.c | 54 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index b4419fb6df6a..143dae872fb2 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -536,12 +536,24 @@ static int ethtool_get_rxnfc_rule_count(struct net_device *dev)
 	return info.rule_cnt;
 }
 
-int ethtool_get_max_rxnfc_channel(struct net_device *dev, u64 *max)
+/**
+ * __ethtool_for_each_rxnfc: Iterate over each RXNFC rule installed
+ * @dev: network device
+ * @cb: callback to analyze an %ethtool_rxnfc rule
+ * @priv: private pointer passed to the callback
+ *
+ * @cb is supposed to return the following:
+ *   < 0 on error
+ *   == 0 to continue
+ *   > 0 to stop iterating
+ */
+static int __ethtool_for_each_rxnfc(struct net_device *dev,
+				    int (*cb)(struct ethtool_rxnfc *info,
+					      void *priv), void *priv)
 {
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct ethtool_rxnfc *info;
 	int err, i, rule_cnt;
-	u64 max_ring = 0;
 
 	if (!ops->get_rxnfc)
 		return -EOPNOTSUPP;
@@ -570,16 +582,14 @@ int ethtool_get_max_rxnfc_channel(struct net_device *dev, u64 *max)
 		if (err)
 			goto err_free_info;
 
-		if (rule_info.fs.ring_cookie != RX_CLS_FLOW_DISC &&
-		    rule_info.fs.ring_cookie != RX_CLS_FLOW_WAKE &&
-		    !(rule_info.flow_type & FLOW_RSS) &&
-		    !ethtool_get_flow_spec_ring_vf(rule_info.fs.ring_cookie))
-			max_ring =
-				max_t(u64, max_ring, rule_info.fs.ring_cookie);
+		err = cb(&rule_info, priv);
+		if (err < 0)
+			goto err_free_info;
+		if (err > 0)
+			break;
 	}
 
 	kvfree(info);
-	*max = max_ring;
 	return 0;
 
 err_free_info:
@@ -587,6 +597,32 @@ int ethtool_get_max_rxnfc_channel(struct net_device *dev, u64 *max)
 	return err;
 }
 
+static int __ethtool_get_max_rxnfc_channel(struct ethtool_rxnfc *rule_info,
+					   void *priv)
+{
+	u64 *max_ring = priv;
+
+	if (rule_info->fs.ring_cookie != RX_CLS_FLOW_DISC &&
+	    rule_info->fs.ring_cookie != RX_CLS_FLOW_WAKE &&
+	    !(rule_info->flow_type & FLOW_RSS) &&
+	    !ethtool_get_flow_spec_ring_vf(rule_info->fs.ring_cookie))
+		*max_ring =
+			max_t(u64, *max_ring, rule_info->fs.ring_cookie);
+
+	return 0;
+}
+
+int ethtool_get_max_rxnfc_channel(struct net_device *dev, u64 *max)
+{
+	u64 max_ring = 0;
+	int ret;
+
+	ret = __ethtool_for_each_rxnfc(dev, __ethtool_get_max_rxnfc_channel,
+				       &max_ring);
+	*max = max_ring;
+	return ret;
+}
+
 int ethtool_get_max_rxfh_channel(struct net_device *dev, u32 *max)
 {
 	u32 dev_size, current_max = 0;
-- 
2.34.1


--0000000000007a8a5706088dde34
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
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPW+NGWz2PbDhpbg
d5ic9lnX8WIxE7RI8owpAR3u9gaBMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMTAyNTE3MzQzNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAaiRleeUXfJAiMTs7qq01iUcJY5+NZ+CqO
D4pK+ll8jPwWsY/ZDUdGc0Ud3zmvm6tqA3oHm+f/OzPxFMetZ66a96wrAkDdHNGw77RI1YJYmcJN
7B27va8g7JOHZEQcQ7+fP38Ryo4YIkj+mn1RomBOqXG4GR922RyhGudOugQ6LlcUFnqoyVisQoZw
KZDe4Nc3ObTLJ1/JC/p4D0Z9PgHaePXxl2xNt3bOk946mllxSaZOzeP5d6kJHIxc0888/eyh5VCi
qyLjZ7g15XSbeoViGDl3YQvoa/484f+Y5ejq+N7XIiT2eOwqi1VwbYiKJJt3H3KwV9pHM1mr4IK5
gKLS
--0000000000007a8a5706088dde34--
