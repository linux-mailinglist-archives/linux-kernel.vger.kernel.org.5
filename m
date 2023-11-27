Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963AC7F9DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjK0Kld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjK0Kla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:41:30 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0497A113
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:41:36 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50baa1ca01cso2338708e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1701081694; x=1701686494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKjdRgLrUCqiZ/8TfWkcZK9DEDOrOby/F2DvMdG0zJo=;
        b=R9lHQTMi4ZgR+K9FugU2LsSbOl/GWgS1qUowGRx2RQkxwidbUCjgxLQbqWH5jhaYPh
         MDjCZZN7xMoSKTpnBkoDFycsxJQ3w3omnbsBf1PowZ4qRi8rJK4c3CqsU2O58A1/DDLC
         3LRovJGZUYcnJCW4vjAd6qOZQIhVkAOCno9v6BSqWfZ9FpHukpJER0DgTiWALbUdWZDU
         VEnYS9kRsb4VS/+LHsickC9oyzgewv772dqGOzsl0uPZUjHpd01jhCX5Vndex7pz8QT0
         KubNSSXWEzHZT4BJdrkdtIE2uXnKmqWc+p16fcg926ilxkCuH2ZeaOVB6HCsQxy7uhUk
         S5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701081694; x=1701686494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKjdRgLrUCqiZ/8TfWkcZK9DEDOrOby/F2DvMdG0zJo=;
        b=inHYcmnmKct6+lQ88U/Fxh1nGx14U8vt5NkmYxfYs0xqCtg5giY8UOu9jI1KtmDjFr
         XXpVkcB2F7R7x9CkA9vlpG4td68FSni2Ujc58E3xIOrHl8AhhpQ1675ASh3TqwmqYrFH
         MyuuW/SUe5QZjS56RWef0ZRSZt2ncYSxLQq8YmUgaN1tTKD8fwBg95FQp6Z9okiuKwog
         kW4BTwz5cSmpbseeEJHlNI062QOurm5CRDpJf4GQH6cCkSyukdengwZaRqxu+gmWg7RD
         PLE05TbMdHS4p1iIFWM8dvuQfuJRER634gyAzWVvHYefkH8+gGSWDbvE0ofyZ22guIWQ
         P1ew==
X-Gm-Message-State: AOJu0YyXZurdN3lNk208epTsf6RHlWphLFO9SHVf2Fq8yUprGijRJhCo
        1bdrsLH0zc6VzjOAc5v2lngpPPGsCQOu3vF1UEI=
X-Google-Smtp-Source: AGHT+IGpNy1Ibi0FzBM2TdCbpskcep8VoY2/zMQZle6Qf1fQQIRpXPQUsG+Ui6vhUO22lNXw/l/Duw==
X-Received: by 2002:ac2:4c4b:0:b0:507:a9e1:5a3b with SMTP id o11-20020ac24c4b000000b00507a9e15a3bmr5493090lfk.0.1701081694278;
        Mon, 27 Nov 2023 02:41:34 -0800 (PST)
Received: from localhost.localdomain ([185.117.107.42])
        by smtp.gmail.com with ESMTPSA id l6-20020a19c206000000b004fe1f1c0ee4sm1432070lfc.82.2023.11.27.02.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 02:41:33 -0800 (PST)
From:   =?UTF-8?q?Ram=C3=B3n=20N=2ERodriguez?= 
        <ramon.nordin.rodriguez@ferroamp.se>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ram=C3=B3n=20N=2ERodriguez?= 
        <ramon.nordin.rodriguez@ferroamp.se>
Subject: [PATCH 1/3] net: microchip_t1s: refactor reset functionality
Date:   Mon, 27 Nov 2023 11:40:43 +0100
Message-ID: <20231127104045.96722-2-ramon.nordin.rodriguez@ferroamp.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramón Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>

This commit moves the reset functionality for lan867x from the revb1
init function to a separate function. The intention with this minor
refactor is to prepare for adding support for lan867x rev C1.

Signed-off-by: Ramón Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
---
 drivers/net/phy/microchip_t1s.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 534ca7d1b061..ace2bf35a18a 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -213,7 +213,7 @@ static int lan865x_revb0_config_init(struct phy_device *phydev)
 	return lan865x_setup_cfgparam(phydev);
 }
 
-static int lan867x_revb1_config_init(struct phy_device *phydev)
+static int lan867x_wait_for_reset_complete(struct phy_device *phydev)
 {
 	int err;
 
@@ -234,6 +234,16 @@ static int lan867x_revb1_config_init(struct phy_device *phydev)
 			return -ENODEV;
 		}
 	}
+	return 0;
+}
+
+static int lan867x_revb1_config_init(struct phy_device *phydev)
+{
+	int err;
+
+	err = lan867x_wait_for_reset_complete(phydev);
+	if (err)
+		return err;
 
 	/* Reference to AN1699
 	 * https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/SupportingCollateral/AN-LAN8670-1-2-config-60001699.pdf
-- 
2.40.1

