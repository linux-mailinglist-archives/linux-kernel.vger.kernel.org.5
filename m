Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E39180A647
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574240AbjLHOyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574204AbjLHOyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:54:00 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C433593;
        Fri,  8 Dec 2023 06:52:10 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c0a074e71so22114895e9.1;
        Fri, 08 Dec 2023 06:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702047128; x=1702651928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfZOawQYQNHqU9ZIBqp6/PMD5jOFrh8dAxaGlSct1Og=;
        b=FRJoZFQsDPDD0RUzEkwDOo1X7mfxWnGks1qhHw6m8zGRfsWnFN54vxpkOUpoyARiae
         9ZENINeGoEkyoYX21VLSY95v8a3iNL87iALUCsvZLmCpMsRrSfl9VkL6qOy+ntYM1mbN
         1LikYqz9CZBy/SgmpNoKIXZ3uvWq4SHl5g/1ee6ROABbG0T4jk1QXGv3G4PcVRcI+jPz
         hQKF51jp37ZnSKRD/+HVxTE5tnywe21zJ3m0lZ5dH8T0gnFxKHFztGm4qHgIPLTxSSP9
         dO7KlsUlc3SYlQKcgS10zCvSHquUQuUxxBQFSgShiVCsOKS6nfIhvnVN+SJwAmvWHaOO
         J0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702047128; x=1702651928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfZOawQYQNHqU9ZIBqp6/PMD5jOFrh8dAxaGlSct1Og=;
        b=STFg5l4cMnX3jfxrU+GsZnGHsmb4zttimbKgwZvzMbEzhhit/RUQxh5LRo5fhJ1Wa6
         z3ZfWwuiAi2Yjrssyg6BlbOxgduPA1L3ebK68nTEwgKM6ZAc7+sVBwNQ7urUmVlNhpBa
         yvTCchWNMfZBzU9O6J2HIFh4/tf5yUDzGM/FaO+Qh0t2XFA9RWLRzpBkKeJj3mamOl4c
         FdRhJAyKFWSHkrVJ90e6Xieh0j5duVo3wS7HskozNIiWOO5Q+/HSLbgg9PPZJZVvjhZj
         751lm+n+bzVPYpEPT0AjyOVkDcr9PVD2z6GqnmQJ7Ox4sltrTUs3ub+aYptrs6hy7Uwl
         m4vA==
X-Gm-Message-State: AOJu0Yz7YW7CAU7zdb4ZzNOP16UV4G1E4eXOBxyswJr4hKP/rqYnM0Av
        tUZ9G18Alv2O7oTPGZfBCPc=
X-Google-Smtp-Source: AGHT+IE/SOjn5UV/UdZ/t8XCr1FucK2FELU5cjyGxsSmj7b+nLd+jsfDHCxefrHKjQ3MHBc4T0ySvg==
X-Received: by 2002:a05:600c:378d:b0:40c:2b29:1bbe with SMTP id o13-20020a05600c378d00b0040c2b291bbemr71535wmr.54.1702047128143;
        Fri, 08 Dec 2023 06:52:08 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id r9-20020a05600c458900b0040b3e79bad3sm3088264wmo.40.2023.12.08.06.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:52:07 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v4 01/13] net: phy: at803x: fix passing the wrong reference for config_intr
Date:   Fri,  8 Dec 2023 15:51:48 +0100
Message-Id: <20231208145200.25162-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208145200.25162-1-ansuelsmth@gmail.com>
References: <20231208145200.25162-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix passing the wrong reference for config_initr on passing the function
pointer, drop the wrong & from at803x_config_intr in the PHY struct.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/at803x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 37fb033e1c29..ef203b0807e5 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -2104,7 +2104,7 @@ static struct phy_driver at803x_driver[] = {
 	.write_page		= at803x_write_page,
 	.get_features		= at803x_get_features,
 	.read_status		= at803x_read_status,
-	.config_intr		= &at803x_config_intr,
+	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
 	.set_tunable		= at803x_set_tunable,
@@ -2134,7 +2134,7 @@ static struct phy_driver at803x_driver[] = {
 	.resume			= at803x_resume,
 	.flags			= PHY_POLL_CABLE_TEST,
 	/* PHY_BASIC_FEATURES */
-	.config_intr		= &at803x_config_intr,
+	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.cable_test_start	= at803x_cable_test_start,
 	.cable_test_get_status	= at803x_cable_test_get_status,
@@ -2150,7 +2150,7 @@ static struct phy_driver at803x_driver[] = {
 	.resume			= at803x_resume,
 	.flags			= PHY_POLL_CABLE_TEST,
 	/* PHY_BASIC_FEATURES */
-	.config_intr		= &at803x_config_intr,
+	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.cable_test_start	= at803x_cable_test_start,
 	.cable_test_get_status	= at803x_cable_test_get_status,
-- 
2.40.1

