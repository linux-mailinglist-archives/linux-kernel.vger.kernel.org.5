Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8987A63A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjISMsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjISMsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:48:07 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907EB1AE;
        Tue, 19 Sep 2023 05:47:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40473f1fe9fso58139935e9.2;
        Tue, 19 Sep 2023 05:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695127668; x=1695732468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EYMn3AygfH8oGBjI8Ur4iGu9uPt05ofKGfO+WLaXkrM=;
        b=L/iad2IRVX509Px19agdcHde7sjbtQGgOFxK+jQ52yC4qAXPD8vUdfkldFOe0EQTiy
         AIc0vj0hSmLvaQXOHdgmtfpMoxNCyAHLSsOx3t4ZctHCvJFewnS7HXuExVHryVtynZcY
         uQkgFe7Cxyyn6pMU469UgE9Uc9SL0g/HaixQsl88sbq5qPC77o9vCvfv7UoDA4wsm1+Z
         1lp+lUWyaAgmrU0slEAZB56KW3kROKy1LJXq/2TRjB7QDXpjwccc6AupUnBljLEbXQeu
         DUOBx5HE2Xmx1RR70JgGo7OodmHHR4dBHQK0icAJb+m68ONXTIIU3xMWmIJrohkxCzhY
         YmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695127668; x=1695732468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYMn3AygfH8oGBjI8Ur4iGu9uPt05ofKGfO+WLaXkrM=;
        b=pbO0SOjQB7nNLRhbp7yHNO4ykeAWcmC/Yor3VGjCRhEDWNQXGFnncO1mlMonRtzLN9
         0x7wYhqytrBpWE9+dJOyyVwk1mTM+rLoRcSgTD9N/C+TLSZS9Q6WNOmCaVNSA8sI1SOv
         ii+wq4XjB5jKaNyvUp5JYC2LRaM+gX3pQCQS39i5wPlZz5VBe8avvnAI+qAk+0Mn5Lxu
         Jr4ztC/CT2fseYnP8H1iAIGP9aofh13qrouNotuFlQs/ZLebta+m2fI4hvg4F+azlYcW
         ogJojE3vb7xIX9vZ7kTYq7X2htyIruYJvMcW252S5WXBuVwoDlBIIQ59IUGPn+O6xGs0
         8tfQ==
X-Gm-Message-State: AOJu0YwqMZEMqmYx6BAEizkuAefD6P5hZHSFwFiUopBu0xK0YwqdKAS9
        FfD5y9SZWx1s1SQZm97EsnQ=
X-Google-Smtp-Source: AGHT+IFFLv4b2C7HsdyjEfltwwEIrgPAxLeeDaHSmpGS2utHdrzYz29f+sPi/XN+F8zXdL+j9pKLWg==
X-Received: by 2002:a05:600c:218f:b0:401:bf56:8bb2 with SMTP id e15-20020a05600c218f00b00401bf568bb2mr10765901wme.10.1695127667596;
        Tue, 19 Sep 2023 05:47:47 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id m10-20020a7bce0a000000b003fee53feab5sm15265738wmc.10.2023.09.19.05.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 05:47:47 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH] net: sfp: add quirk for Fiberstone GPON-ONU-34-20BI
Date:   Tue, 19 Sep 2023 14:47:20 +0200
Message-Id: <20230919124720.8210-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fiberstone GPON-ONU-34-20B can operate at 2500base-X, but report 1.2GBd
NRZ in their EEPROM.

The module also require the ignore tx fault fixup similar to Huawei MA5671A
as it gets disabled on error messages with serial redirection enabled.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/sfp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 4ecfac227865..a50038a45250 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -452,6 +452,11 @@ static const struct sfp_quirk sfp_quirks[] = {
 	// Rollball protocol to talk to the PHY.
 	SFP_QUIRK_F("FS", "SFP-10G-T", sfp_fixup_fs_10gt),
 
+	// Fiberstore GPON-ONU-34-20BI can operate at 2500base-X, but report 1.2GBd
+	// NRZ in their EEPROM
+	SFP_QUIRK("FS", "GPON-ONU-34-20BI", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_tx_fault),
+
 	SFP_QUIRK_F("HALNy", "HL-GSFP", sfp_fixup_halny_gsfp),
 
 	// HG MXPD-483II-F 2.5G supports 2500Base-X, but incorrectly reports
-- 
2.40.1

