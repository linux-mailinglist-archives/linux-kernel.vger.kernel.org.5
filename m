Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C46A7853B2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbjHWJTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbjHWJQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:16:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4792D42
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:56:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c4923195dso695220266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692780995; x=1693385795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AslGWfxwSGfY+Fl1ndpwxP+06+6bcSEvPOtXVEc7gDY=;
        b=u0n54oQdFCRPlkryq7VzijjKhNcr54ieL7TViEd253esKAVYGLuWqjiU7wgRpXRIB4
         BRhp8uAqNCMpqj5s5/+JWzfvz28GNcgHxNqwgdOsti5LuVMd7AW+rEB/fVfmlt8unDhz
         sp2XkkBfaGUVC0af+9FGrr7bDbPV1EHh/U5qBDc8X0uWDl4upLVj6vcu3wTdHQn4xclm
         e7MY0lYcKmMuoQNLtSwVjM3mnrnH815gqqJxCp2LDJsrq1FFj7RHmbdomzy2oM1YJuGT
         6KX9OJAUE7hyddEFNmTgRS1m0oNwEHrbAcBQ287osSs/tkBcZTsEnT/JGq4RzOG4SfrQ
         hx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692780995; x=1693385795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AslGWfxwSGfY+Fl1ndpwxP+06+6bcSEvPOtXVEc7gDY=;
        b=jau+HwCoQKHxPCEF2qMyHLTXzil6bKYICCSeURDRVS1yT+z6BVDlsMBRIuAuzbyAnB
         UYTUyNnGnmqNMWECXSeph/zRx50C4sh0ffAQ+pgkLRMAn4803XCquJfW3A6Um7aOxFGH
         Tk1JldlGnGIyIOOe9kLF8xs9+M2q+N7GuKY7WByVx9+RW6G/3iGcXPOm5amKnafNhrKG
         OQn/hXGUMQSbOtRQsKTxQM1sH4lcfE2iuT7gPy9zCpTQfe1Ex4OGSf3cOGs7VdCPHbIr
         +JGjVyQIY+nMyNKApkJUO+n7x7LvvYuZi6xbH33oCUCc/OEuEj7uyW+xDZAoSXEc3vte
         4siQ==
X-Gm-Message-State: AOJu0Yz6cswlQg+zCDni/u0LCr+pVBN5JLerNx9zsEIBF6JeMxisMpzB
        A6rmlFMYFJ0Fr4r3N9VJzrnaCg==
X-Google-Smtp-Source: AGHT+IEHrFB+dDhCvQbbY4eTMmnC4imbCLJk4+OAcyB7Z4Z/qdStoEn0i8bid6tQ4NrAuMRxtpYB9g==
X-Received: by 2002:a17:906:8466:b0:9a1:f026:b4f1 with SMTP id hx6-20020a170906846600b009a1f026b4f1mr192364ejc.30.1692780995169;
        Wed, 23 Aug 2023 01:56:35 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id bs9-20020a170906d1c900b0099bcd1fa5b0sm9492255ejb.192.2023.08.23.01.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 01:56:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] net: dsa: use capital "OR" for multiple licenses in SPDX
Date:   Wed, 23 Aug 2023 10:56:32 +0200
Message-Id: <20230823085632.116725-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/process/license-rules.rst and checkpatch expect the SPDX
identifier syntax for multiple licenses to use capital "OR".  Correct it
to keep consistent format and avoid copy-paste issues.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/dsa/b53/b53_serdes.c                   | 2 +-
 drivers/net/dsa/b53/b53_serdes.h                   | 2 +-
 drivers/net/dsa/hirschmann/hellcreek.c             | 2 +-
 drivers/net/dsa/hirschmann/hellcreek.h             | 2 +-
 include/linux/platform_data/hirschmann-hellcreek.h | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_serdes.c b/drivers/net/dsa/b53/b53_serdes.c
index b0ccebcd3ffa..3f8a491ce885 100644
--- a/drivers/net/dsa/b53/b53_serdes.c
+++ b/drivers/net/dsa/b53/b53_serdes.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Northstar Plus switch SerDes/SGMII PHY main logic
  *
diff --git a/drivers/net/dsa/b53/b53_serdes.h b/drivers/net/dsa/b53/b53_serdes.h
index ef81f5da5f81..3d367c4df4d9 100644
--- a/drivers/net/dsa/b53/b53_serdes.h
+++ b/drivers/net/dsa/b53/b53_serdes.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Northstar Plus switch SerDes/SGMII PHY definitions
  *
diff --git a/drivers/net/dsa/hirschmann/hellcreek.c b/drivers/net/dsa/hirschmann/hellcreek.c
index 720f4e4ed0b0..11ef1d7ea229 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.c
+++ b/drivers/net/dsa/hirschmann/hellcreek.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * DSA driver for:
  * Hirschmann Hellcreek TSN switch.
diff --git a/drivers/net/dsa/hirschmann/hellcreek.h b/drivers/net/dsa/hirschmann/hellcreek.h
index 4a678f7d61ae..6874cb9dc361 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.h
+++ b/drivers/net/dsa/hirschmann/hellcreek.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
 /*
  * DSA driver for:
  * Hirschmann Hellcreek TSN switch.
diff --git a/include/linux/platform_data/hirschmann-hellcreek.h b/include/linux/platform_data/hirschmann-hellcreek.h
index 6a000df5541f..8748680e9e3c 100644
--- a/include/linux/platform_data/hirschmann-hellcreek.h
+++ b/include/linux/platform_data/hirschmann-hellcreek.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
 /*
  * Hirschmann Hellcreek TSN switch platform data.
  *
-- 
2.34.1

