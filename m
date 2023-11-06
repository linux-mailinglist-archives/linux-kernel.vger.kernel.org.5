Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED867E2B9A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjKFSGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjKFSGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:06:04 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6724D47;
        Mon,  6 Nov 2023 10:06:01 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507bd644a96so6849374e87.3;
        Mon, 06 Nov 2023 10:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699293960; x=1699898760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jFJrO7z2AOZpVZxEtLlcen43+JRmpqTB2YOgHcrEaEs=;
        b=L1OkgSfkURZB1XucDnUvlS4QxpqzcFUk5rapX1YbHU0RmvX6OeKunAt3e9tpZdhaLN
         gAqFm8oAwVnwD161jxvSg+Ng+P3KS+UWHGvwVLwh8bmteVFU0+1aN/33S8RePzvvxURk
         lecBFX19eQ9LtCh6v6jVMUSRn0V6VkWdg9FGGSxFsSs6zMZFYB8L6DGt7lSUu+iD8/iW
         kN4688jdEQ/H3h31kNetvuA0Y3YnctOy1XCQ1XpdgRe3BfGC0UDkPwOPKdCgOp8HRgCm
         CpAU/wY0XaiGZc69a2NoY4uNZsa6/NwfRBofv1td+hTF5CDI2VNr0DfzX9vIKGzQnKEJ
         tZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699293960; x=1699898760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFJrO7z2AOZpVZxEtLlcen43+JRmpqTB2YOgHcrEaEs=;
        b=m3W0VcBwhaLgEUcUR4Cfbt0jlBpxR9lkN2PzbMdlYwXgdwLJrYXdiGRMrMEXR1RydR
         ISkGyvUaTjjFBa0e3+TcArRNJ9uicOOc4VLzqKiquxin8vQm10OESRX3fnKo+cVv175R
         QWaWxUQUH2nyLvzYggMt5Kntys2vzasWf40nDVs9Xww/6k+3SV6HceU5+zYpMuN3YjHH
         z9OqzegDf1v9O3P195kA575lpBoJtlRaX8SMon2hZGMrMFv7WKqG1R1qSrQ8o+Jdo4Nv
         lz4AE6KV3MYuns/LRM7r9Yl95tQEHD8XPqxUwwCSA2UtIrtTLj/wxqeyQMn+fRlx8C7n
         NCwg==
X-Gm-Message-State: AOJu0YxUm+8aFC5K5OXiP42Ie3XTH1hE9Z6WiRnf1sjAN3VE5t+96mIs
        xLHrfjH95eYDJugx4QUnduU=
X-Google-Smtp-Source: AGHT+IHkisUClwP06UenqkN/5I/6BzE/Tui8qauyREkxPjsuQGIt8lJc1uGELlGNoyCJCk4H9xdVeQ==
X-Received: by 2002:ac2:4d07:0:b0:502:ff3b:766f with SMTP id r7-20020ac24d07000000b00502ff3b766fmr19920812lfi.6.1699293959736;
        Mon, 06 Nov 2023 10:05:59 -0800 (PST)
Received: from mars.. ([2a02:168:6806:0:be30:bf77:9975:b433])
        by smtp.gmail.com with ESMTPSA id f9-20020a0560001b0900b0032db430fb9bsm217577wrz.68.2023.11.06.10.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 10:05:58 -0800 (PST)
From:   Klaus Kudielka <klaus.kudielka@gmail.com>
To:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Klaus Kudielka <klaus.kudielka@gmail.com>
Subject: [PATCH net] net: phylink: initialize carrier state at creation
Date:   Mon,  6 Nov 2023 19:05:06 +0100
Message-ID: <20231106180506.2665-1-klaus.kudielka@gmail.com>
X-Mailer: git-send-email 2.42.0
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

Background: Turris Omnia (Armada 385); eth2 (mvneta) connected to SFP bus;
SFP module is present, but no fiber connected, so definitely no carrier.

After booting, eth2 is down, but netdev LED trigger surprisingly reports
link active. Then, after "ip link set eth2 up", the link indicator goes
away - as I would have expected it from the beginning.

It turns out, that the default carrier state after netdev creation is
"carrier ok". Some ethernet drivers explicitly call netif_carrier_off
during probing, others (like mvneta) don't - which explains the current
behaviour: only when the device is brought up, phylink_start calls
netif_carrier_off.

Fix this for all drivers, by calling netif_carrier_off in phylink_create.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
---
 drivers/net/phy/phylink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 6712883498..a28da80bde 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1616,6 +1616,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 	pl->config = config;
 	if (config->type == PHYLINK_NETDEV) {
 		pl->netdev = to_net_dev(config->dev);
+		netif_carrier_off(pl->netdev);
 	} else if (config->type == PHYLINK_DEV) {
 		pl->dev = config->dev;
 	} else {
-- 
2.42.0

