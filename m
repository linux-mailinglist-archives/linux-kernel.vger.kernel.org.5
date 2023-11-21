Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04F47F2FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjKUNxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUNxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:53:43 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E1ED72;
        Tue, 21 Nov 2023 05:53:39 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-332c82400a5so1376706f8f.0;
        Tue, 21 Nov 2023 05:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700574818; x=1701179618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d9v2mri0GlqJoBYwcjZqN/OD5vyWC0Ay18Him7NXwiw=;
        b=iA8kQSC+jFMGhCNyAN/8b4cdS0B6Fz69WfcrPoXi+pWvSy/+7pu11quFp5Xfr8AxIx
         316dh7wSA5YqtmHDMduWWqLQIovG2AfMGcjT+vhTKnCG7rlByz097uJik9b5RdNxc+pq
         j6rlG8pgBaSUIORDzZJ5eaNSrVAA27mPKNGnvS9K/Ff8laKFU4ik24XPkhR8x23YhDtw
         wN5F5zJxSAe+KR0YN4d7SKBCl4BWnCERo2hBzF+eJ4PfqXW8X8eqFveGPWbZurfDIqZF
         mTOJXRceZ+qROZ8/8sSfskBU5Gq5nAXU+i2hoyplKqEukLFnyahJFJOYlz8/42SZYOFf
         tj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700574818; x=1701179618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9v2mri0GlqJoBYwcjZqN/OD5vyWC0Ay18Him7NXwiw=;
        b=aqXXgd2KYf7hzMSob2eACpCmZG+cVtWpuSsipFQ/b3uapZBfEdJ5qMA5PQ4A7t7fWR
         nZD+WGxK6tJ5a7OUv7o/Ml7PjFqRz3ivylFBpWEIRNLAcaGN8FuMk4z+KbErSVzK54eW
         ljYfgxnyTOAJD6jleA+MeYszdhU4PrDQTYOJB3TnydXln8T3aS1RVI0+geEsOm+HwpEQ
         YLoABjFqigo4XmrCVTbVnqc7F0MFNY6RKPu2JLciwwTpfFLroRgcKVjYrXevqqVNh21r
         yQ26KHB6W5wTPfm8u/72u0jc8OF4b2U5P50uv8vLutoZN3QIfZCH35CCy0gKY17ZHi3T
         YIaQ==
X-Gm-Message-State: AOJu0Yw93OqkZhcmCA1HVByxecvhY0R86jpOxs8w2kEYpXbEnIxUm1WF
        5c5nBb4zjHsQZzz47ezfRnk=
X-Google-Smtp-Source: AGHT+IEvETv/u7EyA2zlFgBolEG3fdf+Q9YFSmkGv+7D6VSBeNBiPaGCAeab5oGQLKj+r6BC/3lgGA==
X-Received: by 2002:a5d:47af:0:b0:332:cae7:2ed4 with SMTP id 15-20020a5d47af000000b00332cae72ed4mr3402756wrb.29.1700574817401;
        Tue, 21 Nov 2023 05:53:37 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id v6-20020adfedc6000000b00326dd5486dcsm14406543wro.107.2023.11.21.05.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 05:53:36 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>
Subject: [net-next PATCH v2] net: phy: correctly check soft_reset ret ONLY if defined for PHY
Date:   Tue, 21 Nov 2023 14:53:32 +0100
Message-Id: <20231121135332.1455-1-ansuelsmth@gmail.com>
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

Introduced by commit 6e2d85ec0559 ("net: phy: Stop with excessive soft
reset").

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

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
Changes v2:
- Drop Fixes Tag
- Add Reviewed-by Tag
- Add Introduced by at the top of the commit description

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

