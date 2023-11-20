Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A837F2023
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjKTWUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjKTWUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:20:12 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1AD12A;
        Mon, 20 Nov 2023 14:20:08 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b26d700a1so2531985e9.0;
        Mon, 20 Nov 2023 14:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700518806; x=1701123606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+WAcz7z2EchyAwpWIM7/dxS2+rVeXdmwsl1o0TskhuM=;
        b=bSkcjujVEc+Hy/rmqa/TY6sKbAeO2Dv9mO9+cjLo0Js6D8Kca4I0+KYddHK1E+/d4x
         f/ILLqlo4EqzWyqrWSKOTyYr6+A9tqf3fueGrYVTKWluwxrUat/XGSSGruybzJUSvH0g
         YCpZNJW1A/8vi18WkABgokoXHU5l49W2Wzqxwmpgi+I5fN/2teMqmWG9mzpJPutQK+4/
         KMHfTwH9CX74uOIojxMbF0ftNWVw3oZL96NrE4Jls6oU6PVB8ioxOTt4LVFRdZeYSVSl
         PeNXM9yXEczt5KoL6wj1OFBFWgNm3JIF+xbqALh7hlv0IFeeKm1A3dY4jvFCV6DZrKZe
         LWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700518806; x=1701123606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WAcz7z2EchyAwpWIM7/dxS2+rVeXdmwsl1o0TskhuM=;
        b=BMv6KvGnZwnvsctvDQw3mJbUqFWzVZ4j09fyOmXBoqw78Ljg/KEA/8TYS9lxc0/z4Q
         hlCKcWzJYyjjC4uQkWAbg5Igd83/qGPfp4JER6Rgy9e/T4FXSs7cfkl0sU0KQGeXhbqt
         IbjVP4oknPOpJewimStCv5ipYO/yXNGxmrSj4INxeQyIDoyuPTBKdnyAuULt+22GhD9L
         9tivD8slOaS81SnVRHlOtLc2gw3uX76AQxuOEemjmnq+dukwIXPj4bgdb+x7C0d9lSya
         3g4FQpQ0FUdSlnm7nfsTewnW4X1rlwDMUgsDUGKCkpMVJZ4+yA65nABdQsAIE6iRwMfS
         mU+A==
X-Gm-Message-State: AOJu0YxnojhRK0tit5aMzLnikdHLFQ7nmh+Dpis3HrWKNNwLtawmpwMO
        SnBJinrEnrdsBOhTbjGa12w=
X-Google-Smtp-Source: AGHT+IGmCnUatVvq0MESDezOL9cHV1WEG+GyZwirREnYHbta0QT4AB+/RYdJnjboU7QZylGq0kI/gg==
X-Received: by 2002:a5d:688e:0:b0:317:6ea5:ab71 with SMTP id h14-20020a5d688e000000b003176ea5ab71mr5078027wru.30.1700518806281;
        Mon, 20 Nov 2023 14:20:06 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id f18-20020adfdb52000000b00332cbda1970sm1739089wrj.30.2023.11.20.14.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 14:20:05 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
Subject: [net-next PATCH] net: phy: aquantia: make mailbox interface4 lsw addr mask more specific
Date:   Mon, 20 Nov 2023 20:35:04 +0100
Message-Id: <20231120193504.5922-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems some arch (s390) require a more specific mask for FIELD_PREP
and doesn't like using GENMASK(15, 2) for u16 values.

Fix the compilation error by adding the additional mask for the BITS
that the PHY ignore and AND the passed addr with the real mask that the
PHY will parse for the mailbox interface 4 addr to make sure extra
values are correctly removed.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311210414.sEJZjlcD-lkp@intel.com/
Fixes: e93984ebc1c8 ("net: phy: aquantia: add firmware load support")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/aquantia/aquantia.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index 9ed38972abdb..7685bfaf0b07 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -30,7 +30,10 @@
 #define VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR(x)	FIELD_PREP(VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR_MASK, (u16)((x) >> 16))
 #define VEND1_GLOBAL_MAILBOX_INTERFACE4			0x0203
 #define VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR_MASK	GENMASK(15, 2)
-#define VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR(x)	FIELD_PREP(VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR_MASK, (u16)(x))
+#define VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR_DONT_CARE_MASK	GENMASK(1, 0)
+#define VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR(x)	FIELD_PREP(VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR_MASK | \
+								   VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR_DONT_CARE_MASK, \
+								   (u16)((x) & VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR_MASK))
 
 #define VEND1_GLOBAL_MAILBOX_INTERFACE5			0x0204
 #define VEND1_GLOBAL_MAILBOX_INTERFACE5_MSW_DATA_MASK	GENMASK(15, 0)
-- 
2.40.1

