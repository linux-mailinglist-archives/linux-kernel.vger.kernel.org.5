Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3973E7F1429
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjKTNQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjKTNQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:16:10 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCF7F7;
        Mon, 20 Nov 2023 05:16:04 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32faea0fa1fso2521630f8f.1;
        Mon, 20 Nov 2023 05:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700486163; x=1701090963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X7rYESumyoHA+3OjYLlWpPoNiAXnvgYxNGxcQD7theY=;
        b=LjntltSiwd5fVAQ+LoTCzOqNscxspe91SWRZ15AIYLYTarZ9KKOe66h5ohaI0AwNgm
         ZGUuBpIkQlzTecwW+y/3ClbfrAGsWQZ9nl1vUgDIEPOyvxMnWbiIletrXrrOzS1eFUwD
         SRcpd6ayU6kkqH80vzxVqQjf1roD5m5kz0YBMq9jn0pRwh3gnSa0BmjX9+f+kxqcU1Sr
         KOlWtpWu0MLrPl5IyqEvfnFonuGKJjDhsapb/mfxMWNp2LFJWYP+2m5hRJh+4eM4CQ+x
         CKDvfln2cjSk49CXdoqsoOl07AXmW1zt2oMa/2IYR5p2g8+uRadIz/dlEpz7O2CYZ8tN
         9R3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700486163; x=1701090963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7rYESumyoHA+3OjYLlWpPoNiAXnvgYxNGxcQD7theY=;
        b=OzvdXfB45xgYZeSmwWD5nfxMlUVyiKWRJHLtlsbHyAm2VO5R6L1f4z2H+h1wypzY6j
         52LLvmVx+c4c1tzScNjbg6tl+ITbCEjIXfbtCyIqMwAOuoSs30liHIiNzc3bkWUBK5PQ
         u3fJNz7F6t67HawdPyPbfQbfE5rtbRAkHXhTrrvHV+GnDmet7I5EOhC860ZkRPWGyfcW
         MRuCaUsjg+RYI0LKwDZTTvD0OUbchWpbf62IdXJ9aMyewnb3RqB5hnxcmgtSxBjmRnA8
         wiMRV4DvymZtbgEcKU4S6GIwPyEUKsdA/iTD4ThL5pUFJ6uSRpM1LG3y7j95G/GqlFqk
         WFxg==
X-Gm-Message-State: AOJu0YzS9fpsxN/52jizAuC5drjbOdQhL9jO9mA53ZdJOqQYgzvabhie
        +bXMQd6LnUfY23TTa+kg2CM=
X-Google-Smtp-Source: AGHT+IG6s1Jds+Zuru44pKEyKGL05CUjKqyizG986Dljc4Lv0QX6uapDHZLi4cDI1GqwQMM4JsVB1g==
X-Received: by 2002:adf:d1ca:0:b0:331:6a14:b8d5 with SMTP id b10-20020adfd1ca000000b003316a14b8d5mr7650035wrd.29.1700486162654;
        Mon, 20 Nov 2023 05:16:02 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id x11-20020adff0cb000000b00332cb4697ebsm1263592wro.55.2023.11.20.05.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 05:16:02 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH] net: phy: correctly check soft_reset ret ONLY if defined for PHY
Date:   Mon, 20 Nov 2023 14:15:40 +0100
Message-Id: <20231120131540.9442-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
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

soft_reset call for phy_init_hw had multiple revision across the years
and the implementation goes back to 2014. Originally was a simple call
to write the generic PHY reset BIT, it was then moved to a dedicated
function. It was then added the option for PHY driver to define their
own special way to reset the PHY. Till this change, checking for ret was
correct as it was always filled by either the generic reset or the
custom implementation. This changed tho with commit 6e2d85ec0559 ("net:
phy: Stop with excessive soft reset"), as the generic reset call to PHY
was dropped but the ret check was never made entirely optional and
dependent whether soft_reset was defined for the PHY driver or not.

Luckly nothing was ever added before the soft_reset call so the ret
check (in the case where a PHY didn't had soft_reset defined) although
wrong, never caused problems as ret was init 0 at the start of
phy_init_hw.

To prevent any kind of problem and to make the function cleaner and more
robust, correctly move the ret check if the soft_reset section making it
optional and needed only with the function defined.

Fixes: 6e2d85ec0559 ("net: phy: Stop with excessive soft reset")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy_device.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2ce74593d6e4..478126f6b5bc 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1235,14 +1235,13 @@ int phy_init_hw(struct phy_device *phydev)
 
 	if (phydev->drv->soft_reset) {
 		ret = phydev->drv->soft_reset(phydev);
+		if (ret < 0)
+			return ret;
+
 		/* see comment in genphy_soft_reset for an explanation */
-		if (!ret)
-			phydev->suspended = 0;
+		phydev->suspended = 0;
 	}
 
-	if (ret < 0)
-		return ret;
-
 	ret = phy_scan_fixups(phydev);
 	if (ret < 0)
 		return ret;
-- 
2.40.1

