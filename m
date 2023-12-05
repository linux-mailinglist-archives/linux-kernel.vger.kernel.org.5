Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBFD80504F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345045AbjLEKgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbjLEKgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:36:05 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121CA109;
        Tue,  5 Dec 2023 02:36:11 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ca0c36f5beso20116271fa.1;
        Tue, 05 Dec 2023 02:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701772569; x=1702377369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7nbPSVfDOj9VhJDoGLXG/VirsAsAqdDlwTrxuDOen8=;
        b=Um9l6KsiWzdIdqGRfXcFgxTFV1AliRaRSqx53gU1RX2tj02PcC/7ZkohK/iHKAE+63
         vAeN6OJoV7WQckrYEwbFT+h6MmOXEj7TVy6zTd+6Ixdv7Cfdo7LiKYq/pNFGtGUJHKCP
         KvH1sRBaJihM4tS8ZZ+QEHTMSy6BnYczODzDste47NQpDcmpa5o2LmEX+Mzdfb41g5dS
         CdDDPiOFQbamvFyBYY2ERL7AomWem7bgNWJ8nQwO5a02bDld5PAxF/yz/RR6NuEnRZVL
         0qImgrX5CwFHMcWjGPDTDMsDW1Jn0r3IGZCRWQ2p05xcBp26cAdPcQd9GgjC17ikSMbi
         7rcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701772569; x=1702377369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7nbPSVfDOj9VhJDoGLXG/VirsAsAqdDlwTrxuDOen8=;
        b=IUIIRYxUC7Muy6ze4at2RJJ5RdukLqurQI66acg9WhRz96J+SKOvQG3WGxtxtteSs0
         N0lbWnl/cFUSFqi8Nrp4YQNrE6xiabJF2w5LTCNz8Px18Bt9velyYlzpEx9107GQ2A1j
         tn9atMJk66vVkl35sABRTA2DBliFZ6ZW/Au8WPzNuH6cuKV1DH5xzxao9y7v580fRE9z
         uzOS8HN4dxGffg7Vo/d/FzZpBgvbvPEgEOfZzp2kv2f3Ojb0t3r4HAJ55sT8jWIQ3BTX
         x+1CMDzzodg70nq4UivFmK50vlUu7ynPQK4F1PfaSeagtNn/3zvjcen6qq0YUN64PJwg
         pZOA==
X-Gm-Message-State: AOJu0Yxh8mGE2lFMwjEvg1u6QsoIUCn/SBhumJA5UjXXYIqJIoGv3MCJ
        JEv8H0bH+AtLD0mrxZ7DFYc=
X-Google-Smtp-Source: AGHT+IEbTWXqnS6pqxWsiTO7y9txYu3nwyDInKx5fND8GB0zHKszkEr00SZIdi7cH2zlataH173Zeg==
X-Received: by 2002:a2e:7c0a:0:b0:2c9:f564:b414 with SMTP id x10-20020a2e7c0a000000b002c9f564b414mr2095991ljc.24.1701772569144;
        Tue, 05 Dec 2023 02:36:09 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id s22-20020a2e98d6000000b002c9b899c449sm809872ljj.59.2023.12.05.02.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:36:08 -0800 (PST)
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
Subject: [PATCH net-next 04/16] net: pcs: xpcs: Explicitly return error on caps validation
Date:   Tue,  5 Dec 2023 13:35:25 +0300
Message-ID: <20231205103559.9605-5-fancer.lancer@gmail.com>
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

If an unsupported interface is requested to be validated then there is no
need in further capabilities and-ing since the local array will be left
initialized with zeros. Let's explicitly return EINVAL error in that case
in order to inform the caller about invalid link-state interface. In any
case the phylink_validate_mac_and_pcs() would terminate with error further
link-state validation so the suggested update won't change the validation
procedure semantics.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/pcs/pcs-xpcs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 92c47da61db4..46afeb5510c0 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -613,14 +613,15 @@ static int xpcs_validate(struct phylink_pcs *pcs, unsigned long *supported,
 
 	xpcs = phylink_pcs_to_xpcs(pcs);
 	compat = xpcs_find_compat(xpcs->id, state->interface);
+	if (!compat)
+		return -EINVAL;
 
 	/* Populate the supported link modes for this PHY interface type.
 	 * FIXME: what about the port modes and autoneg bit? This masks
 	 * all those away.
 	 */
-	if (compat)
-		for (i = 0; compat->supported[i] != __ETHTOOL_LINK_MODE_MASK_NBITS; i++)
-			set_bit(compat->supported[i], xpcs_supported);
+	for (i = 0; compat->supported[i] != __ETHTOOL_LINK_MODE_MASK_NBITS; i++)
+		set_bit(compat->supported[i], xpcs_supported);
 
 	linkmode_and(supported, supported, xpcs_supported);
 
-- 
2.42.1

