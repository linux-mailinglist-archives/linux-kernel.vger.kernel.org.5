Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCC7811C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjLMSQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjLMSP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:15:57 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FF2106;
        Wed, 13 Dec 2023 10:16:03 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-33644eeb305so63492f8f.1;
        Wed, 13 Dec 2023 10:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702491362; x=1703096162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMG3yQ4EhHz7n1fTiev23HEWg/+c7EuzwQ2dfmF7Rmg=;
        b=XMoTufx+OeIPW34gfPpeVxDpRiIxjX4vlTTolc4V28F59I2Q1lrrv/hBTLObTvOBqd
         rIZpBfNa8J7nA9jbuqnwSLHD3O3RIIrGGxmhWvOpyqQInIcE/ZSxAFmiYsru3miamo63
         A0PmRTUB6V0rJBfAsz+beWABJ4IiUhZTwhZnU3oNfbgg0igibe+XRPW332/we0koy2Ql
         j72W5JG+E6YhV2HbK92xP6kb1JDAkAfR5ZlfzyeDSUP8YXhb7aAT5Zt8qjOUCVWuSbBk
         f0Q7IS3LVX5/Mrf7jtJ0nb7LUrA5PszIO9jXRuPFO5YOTXHmyR07DW8cknu8q/LqzyaZ
         x5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702491362; x=1703096162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMG3yQ4EhHz7n1fTiev23HEWg/+c7EuzwQ2dfmF7Rmg=;
        b=CfLQX9fd961rIGCAnoGkL/7VX/nQorguhp97L5xqQGDDF/JOlVVq7lU59ewPB3KHAU
         4Ujqkvvit2VJ39/uNOH/psdJQw5HpY1iY5gE0cQDxY6O+inNo/mFfFyy9/o2E+84zmlY
         YYqKx7laSjYewT9NR/xb7rVWrJnpYENn+Ks183KTkoMjDDKtPlMaVafHbF1BLtOZMzYv
         imvdVQd2gVInC25W9Y12egLW5xt3rIRiszlgSaN8lcHII/0SvH72ila2DZdu5DMuFyfK
         FkbhqWtvRbdhVZ2amYcEQwi08Qkr6wXVLz1Ot6hbGrGiIIIytkK6/cX2X/D4M4Day4pn
         qYLw==
X-Gm-Message-State: AOJu0YyyfNvbZlWlX+d6LyZZooDmMWrOViXwqRAGSxdKDhO1QUYbEaEh
        8BXMBxjMmgbJq3TDREv2u0k=
X-Google-Smtp-Source: AGHT+IGfvlJWy8A+tUbhwzhf34qHnlbjkRS8NLj7gu6M2pIDkvJTFnHhvzFE8wq1HoMSDUtbGj6dqw==
X-Received: by 2002:adf:fd49:0:b0:336:35ed:af18 with SMTP id h9-20020adffd49000000b0033635edaf18mr1385090wrs.17.1702491361917;
        Wed, 13 Dec 2023 10:16:01 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id e33-20020a5d5961000000b0033346fe9b9bsm13947762wri.83.2023.12.13.10.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:16:01 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Kees Cook <keescook@chromium.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next PATCH 2/2] net: phy: leds: use new define for link speed modes number
Date:   Wed, 13 Dec 2023 19:15:54 +0100
Message-Id: <20231213181554.4741-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213181554.4741-1-ansuelsmth@gmail.com>
References: <20231213181554.4741-1-ansuelsmth@gmail.com>
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

Use new define __LINK_SPEEDS_NUM for the speeds array instead of
declaring a big enough array of 50 elements to handle future link speed
modes.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy_led_triggers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_led_triggers.c b/drivers/net/phy/phy_led_triggers.c
index f550576eb9da..40cb0fa9ace0 100644
--- a/drivers/net/phy/phy_led_triggers.c
+++ b/drivers/net/phy/phy_led_triggers.c
@@ -84,7 +84,7 @@ static void phy_led_trigger_unregister(struct phy_led_trigger *plt)
 int phy_led_triggers_register(struct phy_device *phy)
 {
 	int i, err;
-	unsigned int speeds[50];
+	unsigned int speeds[__LINK_SPEEDS_NUM];
 
 	phy->phy_num_led_triggers = phy_supported_speeds(phy, speeds,
 							 ARRAY_SIZE(speeds));
-- 
2.40.1

