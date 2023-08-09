Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35D8776B48
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjHIVyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjHIVyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:54:23 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11BA1FD2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:54:22 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9fa64db41so4630111fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 14:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1691618061; x=1692222861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OkMEyGGNHjpLY2UEkMN7YcqkjDj9e0LTmbSFlK+KoK0=;
        b=VQqAQACYQv8GjP6RmCx4yk0ArjFakRxwqfuCKdZKFFDcf4iW4s5YuusU2csrIqKWV+
         h2w1pNtooaKj51cJfgZXblhg8/xZBk8HSazCyLJuxGwlQfEYGU3flDibNizuJ6Q3JnZl
         O80qxZmB9NdR5xTfOeHoVDh+RqbtQYtVPq21Ymcidnb3zuIZ9SwUc6Ku2fgCPyLR1nMA
         jLFM17Ip9W/l7Wn1B8kCQ+Mzwd9boqsPVaaf/Kt8L8cos3E4wy9bh/Ec2QsCAHp6IpXJ
         D9ZUOmpXbE9r00jHVY51+eTUEgm3A5rzSav8h9OirPhtUdyHdqBgBHA18KE0R/ClCPTQ
         2lNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691618061; x=1692222861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OkMEyGGNHjpLY2UEkMN7YcqkjDj9e0LTmbSFlK+KoK0=;
        b=lpEN2VJNMFMJu0jMz1iTazvVPAjLuX6f3Wn+d6XWvzD3PTi+pkRjUdaIbU6+MvWSgP
         LCr25TLTjusoZi5kPVwOA+8SKx8DABRX+SbjiGVBwv3JpC/KgxVHjX8XbJdpqgo55M47
         FAUKKyc4puRJQ3pkCK7Q7QcfT0gA2N7usRbNQsIgtP9u1jnYVmXNuJSEu9HxJanyudGg
         ZysnkxuEmAlUKnVtsJR2ryQvxX0B3jTZgH2f5th8fjH9s0ZEdBP+37zHMhN7Yj1dx4R7
         ibgaGLDpGRQPGz4Ph0urVYgJ48wpqh+RFUALjtfusHXev2zHknor6Chk/kQVVgIIl4XM
         6lHQ==
X-Gm-Message-State: AOJu0YxBMugayTYxoqycgnHG/lgjGKn+AsNN1CdPsp6k757da01tmW/N
        H31qvgI2+JzBxKybQ88Wnhg60e/6nnnGB8y13D4JlpQhY6o=
X-Google-Smtp-Source: AGHT+IFLZ3XxvjmZxptWdKwKgWdhi9Xl+mBhFrej+tA4dJqxwRNQvSph1ArlQyTEWD7Vq+GK3SfMzQ==
X-Received: by 2002:a2e:700c:0:b0:2b9:4492:1226 with SMTP id l12-20020a2e700c000000b002b944921226mr402768ljc.11.1691618060835;
        Wed, 09 Aug 2023 14:54:20 -0700 (PDT)
Received: from bear.local ([69.165.74.129])
        by smtp.gmail.com with ESMTPSA id k3-20020a2e8883000000b002b6995f38a2sm6199lji.100.2023.08.09.14.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:54:19 -0700 (PDT)
From:   Luke Lu <luke.lu@libre.computer>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Da Xue <da@libre.computer>, Luke Lu <luke.lu@libre.computer>
Subject: [PATCH net v4] net: phy: meson-gxl: implement meson_gxl_phy_resume()
Date:   Wed,  9 Aug 2023 21:49:46 +0000
Message-Id: <20230809214946.18975-1-luke.lu@libre.computer>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Da Xue <da@libre.computer>

While testing the suspend/resume function, we found the ethernet
is broken if using internal PHY of Amlogic meson GXL SoC.
After system resume back, the ethernet is down, no carrier found.

	eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state
		DOWN group default qlen 1000

In this patch, we re-initialize the internal PHY to fix this problem.

	eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
		group default qlen 1000

Fixes: 7334b3e47aee ("net: phy: Add Meson GXL Internal PHY driver")
Signed-off-by: Da Xue <da@libre.computer>
Signed-off-by: Luke Lu <luke.lu@libre.computer>

---
Note, we don't Cc stable kernel tree in this patch intentionally, since
there will be a cherry-pick failure if apply this patch from kernel version
less than v6.2, it's not a logic failure but due to the changes too close.

Please check commit 69ff53e4a4c9 ("net: phy: meson-gxl: use MMD access dummy stubs for GXL, internal PHY")
We plan to slightly rework the patch, and send it to stable tree separately
once this patch is accepted into mainline.

v4:
 - refactor commit message to better explain the problem & fix
 - check return value of genphy_resume()
 - add 'net' annotation
 - add Fixes tag

v3: https://lore.kernel.org/netdev/20230808050016.1911447-1-da@libre.computer
 - fix missing parameter of genphy_resume()

v2: https://lore.kernel.org/netdev/20230804201903.1303713-1-da@libre.computer
 - call generic genphy_resume()

v1: https://lore.kernel.org/all/CACqvRUZRyXTVQyy9bUviQZ+_moLQBjPc6nin_NQC+CJ37yNnLw@mail.gmail.com
---
 drivers/net/phy/meson-gxl.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index bb9b33b6bce2..9ebe09b0cd8c 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -132,6 +132,21 @@ static int meson_gxl_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int meson_gxl_phy_resume(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_resume(phydev);
+	if (ret)
+		return ret;
+
+	ret = meson_gxl_config_init(phydev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 /* This function is provided to cope with the possible failures of this phy
  * during aneg process. When aneg fails, the PHY reports that aneg is done
  * but the value found in MII_LPA is wrong:
@@ -196,7 +211,7 @@ static struct phy_driver meson_gxl_phy[] = {
 		.config_intr	= smsc_phy_config_intr,
 		.handle_interrupt = smsc_phy_handle_interrupt,
 		.suspend        = genphy_suspend,
-		.resume         = genphy_resume,
+		.resume         = meson_gxl_phy_resume,
 		.read_mmd	= genphy_read_mmd_unsupported,
 		.write_mmd	= genphy_write_mmd_unsupported,
 	}, {
-- 
2.40.1

