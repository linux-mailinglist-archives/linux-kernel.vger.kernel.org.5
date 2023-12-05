Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0A3805045
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344862AbjLEKgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbjLEKgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:36:00 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55EEFA;
        Tue,  5 Dec 2023 02:36:05 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9f413d6b2so33422001fa.1;
        Tue, 05 Dec 2023 02:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701772564; x=1702377364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4aEtBuTh0UC9CrFmY+V3IFx8owY/yY3vgzi9PmzSa0=;
        b=AAUDwXA5Vn5b2YgoYr1vhdX4/ruUKqMQ9z99m1JaH+80iapLCXGjmE89Qq3zq1DfBt
         IoCOHzlVwVuPsaHqoxhoBf+bz0TONTg74PcgEAsd8zOvL15YNu4Cl+LW/3ddlX8ak2Mp
         wLsBekjU6wqp5sNn8RHoJxvXn8rcMFcdl2SoE1DBljG1gZQGNkS5YzIAUaNcg+exw+Cb
         8lzEkkdCM8fYoM8Te9n4ZrQxwEuNi5amQ0amQluYfm1iOiUiPn+qy6J2OwvWPsiqlzE4
         SYcYQNRRs2HDffs28uaphVQJMMjqNogoAvU2TO+fMgwixb89X8ZMO32q7tLARz960XOK
         /M5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701772564; x=1702377364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4aEtBuTh0UC9CrFmY+V3IFx8owY/yY3vgzi9PmzSa0=;
        b=s8DkiuDCHP4yiUwai+qSMy5tjK6gYiM5aOTSb8DMZBHJW8L+my0UkPcLFcwTmmRaNO
         Lk7iYTKF86gF6QBI6tKkd0L2bT3rmR7KlO0AWc5E4xTgMVXelKcmyw+kYpXH85bQ2LL+
         qcHiqIMl+eTtLFu79dowmbts1NiECbPUGkEFB+R4Ju2G+xKP3wYGD9YotWrWRndpsziw
         3JWRJpqPoyIfWwhqSkz3z/0qpVvXCDKGmESrKrGIO37zQECn+mUww/X8cw1CVjxXBoDd
         GgmI6sNOYcO+x1UvnkSwJ6u8WSjU9bdpGXXolJLRB4Ks0jrGGbHse7F/Jw/yBQpVGou2
         SR8A==
X-Gm-Message-State: AOJu0YwvnjCyn46xnE8WbTF81oFLDNF0u6udXvoIVY7IYoa68VFOaznJ
        R+4a/w17WaWeJrf0NNDGatE=
X-Google-Smtp-Source: AGHT+IFZKr4mte8mEyBn5TUCZn71LfadvBGTszjO/emPzCHL8qpyDtiAvPGC3HEYzGHAFjI4CXkWeA==
X-Received: by 2002:a2e:b24d:0:b0:2c0:17bc:124e with SMTP id n13-20020a2eb24d000000b002c017bc124emr2510299ljm.38.1701772563975;
        Tue, 05 Dec 2023 02:36:03 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id h20-20020a2e5314000000b002c9bb53ee68sm849784ljb.136.2023.12.05.02.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:36:03 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 01/16] net: pcs: xpcs: Drop sentinel entry from 2500basex ifaces list
Date:   Tue,  5 Dec 2023 13:35:22 +0300
Message-ID: <20231205103559.9605-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231205103559.9605-1-fancer.lancer@gmail.com>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
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

There are currently two methods (xpcs_find_compat() and
xpcs_get_interfaces()) defined in the driver which loop over the available
interfaces. All of them rely on the xpcs_compat.num_interfaces field value
to get the number of interfaces. That field is initialized with the
ARRAY_SIZE(xpcs_*_interfaces) macro function call. Thus the interface
arrays are supposed to be filled with actual interface IDs and there is no
need in the dummy terminating ID placed at the end of the arrays. Let's
drop the redundant PHY_INTERFACE_MODE_MAX entry from the
xpcs_2500basex_interfaces list and the redundant
PHY_INTERFACE_MODE_MAX-based conditional statement from the
xpcs_get_interfaces() method then.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/pcs/pcs-xpcs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 31f0beba638a..dc7c374da495 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -130,7 +130,6 @@ static const phy_interface_t xpcs_1000basex_interfaces[] = {
 
 static const phy_interface_t xpcs_2500basex_interfaces[] = {
 	PHY_INTERFACE_MODE_2500BASEX,
-	PHY_INTERFACE_MODE_MAX,
 };
 
 enum {
@@ -636,8 +635,7 @@ void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
 		const struct xpcs_compat *compat = &xpcs->id->compat[i];
 
 		for (j = 0; j < compat->num_interfaces; j++)
-			if (compat->interface[j] < PHY_INTERFACE_MODE_MAX)
-				__set_bit(compat->interface[j], interfaces);
+			__set_bit(compat->interface[j], interfaces);
 	}
 }
 EXPORT_SYMBOL_GPL(xpcs_get_interfaces);
-- 
2.42.1

