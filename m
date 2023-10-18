Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9FA7CE5AF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344732AbjJRR7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345008AbjJRR7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:59:02 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5AC1737
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:58:37 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b2ea7cc821so523603b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697651916; x=1698256716; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ni32Abx0yRy76R3i0DIIAMCfH+yO0dn6TUk5YC/lbtM=;
        b=Cj7f+UE0xC39LEu0UIpRX1SHzeJW8RxsQfGxnvMWUe4ux5dZhogxwC471pU8mPIWeE
         ST2WdxV9BxbOsZbExhvl1TVepIh7Ezw1gXSdvo7XB4NyxMkkrcNR+95gfB1T+WdpLu0v
         TsZ7ycQ3Jb9gc/rmSPPFFSk65rtyo8oKQoZoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697651916; x=1698256716;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ni32Abx0yRy76R3i0DIIAMCfH+yO0dn6TUk5YC/lbtM=;
        b=XNYXd1IsRN1TbF9xNqfybaoURXc/21w7r6QaB35y8fM1lK6y1BCpaeylLRJY/5w/+k
         3axjjPA4lfGmnt52ffTrx1elxuL7AB4qmvjqd2AWnSSdaOe6cF+TM3+hrC3tcoIg6Uuw
         h6Gtp0A3YI75E0h3GVdS/nhVpBc+0H1MLReFlvxeduJFkOGKWHY8yIF/WYAy5i7qi2Um
         cg5JKi9YzKB/IXW/X5ecPJ/YcrBnSWurG5YhiUZeikiJo/zjAKslNWEWpD7+2Eae9P8x
         jIegU/L974d8vVY74zVRx4KBm0mR/mU5iXxAFWRVwO2+TV3w/tysTYZ8FyhAcHHUOafZ
         edCw==
X-Gm-Message-State: AOJu0YzY0J7DnpFj04UiVnM4NV0Banf5DMqnTGWLBW1YY9z4WJ8CZqrI
        xRT1QVFXriw8bPEa1mRPk/6CJw==
X-Google-Smtp-Source: AGHT+IHS4jOZY3ngZQELQ2gtIGZD1WYKsXyFAyFSWkktZH44++8H3ceoRuq4ZPkp9ys3Fcof/Drr4g==
X-Received: by 2002:a05:6808:1a22:b0:3ab:84f0:b49d with SMTP id bk34-20020a0568081a2200b003ab84f0b49dmr7088609oib.3.1697651916524;
        Wed, 18 Oct 2023 10:58:36 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k15-20020a0cfa4f000000b00655d711180dsm133330qvo.17.2023.10.18.10.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:58:35 -0700 (PDT)
From:   Florian Fainelli <florian.fainelli@broadcom.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH net-next v6 2/2] net: dsa: Rename IFLA_DSA_MASTER to IFLA_DSA_CONDUIT
Date:   Wed, 18 Oct 2023 10:58:20 -0700
Message-Id: <20231018175820.455893-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018175820.455893-1-florian.fainelli@broadcom.com>
References: <20231018175820.455893-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000074a2f50608016321"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000074a2f50608016321
Content-Transfer-Encoding: 8bit

This preserves the existing IFLA_DSA_MASTER which is part of the uAPI
and creates an alias named IFLA_DSA_CONDUIT.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 Documentation/networking/dsa/configuration.rst |  4 ++--
 include/uapi/linux/if_link.h                   |  4 +++-
 net/dsa/netlink.c                              | 10 +++++-----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/dsa/configuration.rst b/Documentation/networking/dsa/configuration.rst
index e6c9719874b0..6cc4ded3cc23 100644
--- a/Documentation/networking/dsa/configuration.rst
+++ b/Documentation/networking/dsa/configuration.rst
@@ -393,7 +393,7 @@ description which has an ``ethernet`` property. It is up to the user to
 configure the system for the switch to use other conduits.
 
 DSA uses the ``rtnl_link_ops`` mechanism (with a "dsa" ``kind``) to allow
-changing the DSA conduit of a user port. The ``IFLA_DSA_MASTER`` u32 netlink
+changing the DSA conduit of a user port. The ``IFLA_DSA_CONDUIT`` u32 netlink
 attribute contains the ifindex of the conduit device that handles each user
 device. The DSA conduit must be a valid candidate based on firmware node
 information, or a LAG interface which contains only slaves which are valid
@@ -435,7 +435,7 @@ Using iproute2, the following manipulations are possible:
         dsa master bond0
 
 Notice that in the case of CPU ports under a LAG, the use of the
-``IFLA_DSA_MASTER`` netlink attribute is not strictly needed, but rather, DSA
+``IFLA_DSA_CONDUIT`` netlink attribute is not strictly needed, but rather, DSA
 reacts to the ``IFLA_MASTER`` attribute change of its present conduit (``eth0``)
 and migrates all user ports to the new upper of ``eth0``, ``bond0``. Similarly,
 when ``bond0`` is destroyed using ``RTM_DELLINK``, DSA migrates the user ports
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 9f8a3da0f14f..f4191be137a4 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1394,7 +1394,9 @@ enum {
 
 enum {
 	IFLA_DSA_UNSPEC,
-	IFLA_DSA_MASTER,
+	IFLA_DSA_CONDUIT,
+	/* Deprecated, use IFLA_DSA_CONDUIT instead */
+	IFLA_DSA_MASTER = IFLA_DSA_CONDUIT,
 	__IFLA_DSA_MAX,
 };
 
diff --git a/net/dsa/netlink.c b/net/dsa/netlink.c
index f56f90a25b99..1332e56349e5 100644
--- a/net/dsa/netlink.c
+++ b/net/dsa/netlink.c
@@ -8,7 +8,7 @@
 #include "user.h"
 
 static const struct nla_policy dsa_policy[IFLA_DSA_MAX + 1] = {
-	[IFLA_DSA_MASTER]	= { .type = NLA_U32 },
+	[IFLA_DSA_CONDUIT]	= { .type = NLA_U32 },
 };
 
 static int dsa_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -20,8 +20,8 @@ static int dsa_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (!data)
 		return 0;
 
-	if (data[IFLA_DSA_MASTER]) {
-		u32 ifindex = nla_get_u32(data[IFLA_DSA_MASTER]);
+	if (data[IFLA_DSA_CONDUIT]) {
+		u32 ifindex = nla_get_u32(data[IFLA_DSA_CONDUIT]);
 		struct net_device *conduit;
 
 		conduit = __dev_get_by_index(dev_net(dev), ifindex);
@@ -38,7 +38,7 @@ static int dsa_changelink(struct net_device *dev, struct nlattr *tb[],
 
 static size_t dsa_get_size(const struct net_device *dev)
 {
-	return nla_total_size(sizeof(u32)) +	/* IFLA_DSA_MASTER  */
+	return nla_total_size(sizeof(u32)) +	/* IFLA_DSA_CONDUIT  */
 	       0;
 }
 
@@ -46,7 +46,7 @@ static int dsa_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct net_device *conduit = dsa_user_to_conduit(dev);
 
-	if (nla_put_u32(skb, IFLA_DSA_MASTER, conduit->ifindex))
+	if (nla_put_u32(skb, IFLA_DSA_CONDUIT, conduit->ifindex))
 		return -EMSGSIZE;
 
 	return 0;
-- 
2.34.1


--00000000000074a2f50608016321
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
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIsVfxopAiT+JKHK
i5h3TjPqnyyfdQ3oG7PiqvlG/M7xMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMTAxODE3NTgzNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDkM3lWVJxjU0XuGbS8htmCdRtQXFWc5GEk
wJwSDvkkBQFc8xxh72HdiIr1zz7dRduCCrSBpvvAGEIzx6rzGWkQzEuXp6Uc0JAa7uNs2PrDFlld
K0hjFtEg6vtjAmL378vTZCYsEaFQtB9J/4wFNo8Lk5AprJDSSVGV6rKb+XhZ6ebgiD0YdMOnbtyA
T4aupo3bjd8uOKqxqt+dXVcoHabSIKDZT+dFnWyUD4U3hzs8jsxHQ8oZvW7u6Lk7c6xNIEUjVEcE
SUMM9XUSEV33GcR3PIyGBCHYcoTGR6r8NrH1SBqgG6gyZlCdjSOtjLGr+IXoV0vfE474i39ZwbJ2
x7tV
--00000000000074a2f50608016321--
