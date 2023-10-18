Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E456C7CDBE1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344618AbjJRMgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344665AbjJRMgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:36:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F189C11F;
        Wed, 18 Oct 2023 05:36:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32da9ef390fso3012224f8f.2;
        Wed, 18 Oct 2023 05:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697632562; x=1698237362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSAhxNCccBDPfEaHOYwSm94ZHYVqbuNn4mUPNvHQg0g=;
        b=HRes/2YiTD/uUbcLg4k8Tv4561atzXBInB7AZP92YRg6EWqWDzBalxtxIfGev6s9mb
         Pin9Srw0Lr7HNsEDgrOvfYgINPUfED+0qT6synRHfUs7JXw0So1QZQXGHs8K5U5Bdg0Y
         zH+Wg1eP+HfcfMTF1d/yvf8ZzEBBMG9QwxP3eYM6uT62Zs1GF8/phfC5XgL9gVI1oOFY
         b7l7uAeIi6aKRbHaLx++T+jIvb3BcdLIjIa4eHr64kwEQ5PS/R852A5WIPk0NFet1Qbt
         roDMqPmIZEx4dA+s54dJpb1OuoNCBvbVvI8x//KWqsSwSgpl12RtNLS7MQWLj8M60qGC
         HnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632562; x=1698237362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSAhxNCccBDPfEaHOYwSm94ZHYVqbuNn4mUPNvHQg0g=;
        b=H8AunwHZJRFF6Lq/pWUvZsBUWUmccIojlEBPFmT2EjFSMnLQDTeLCh/OJy0RezRCwR
         m34HwWSgiR1Y8L/N0jFkstji+ZNmK99qlKqG5pYzgE5G3ctSBAsCPbdsEYkt35q9Z7zu
         iuvuJe2WEGbLzvXuW0CP/QMzpT5lMToOhl8lNEp7PB+MOA1qRYDOsAqvvmtI/ivJvLqj
         9lCaiAM9EHrOR/wrMPwse6BnBa3bfco+9eQ25Y9JQWI4R6mdpi5+b/tgsqDgEyklynB0
         9Fi6A6wr87wATB3hYT29MPDrd06Defi/1WRCPp6D2YGJjpo0pgbb89AydJCoRAZrahvF
         7UbQ==
X-Gm-Message-State: AOJu0YwKw0wtOYqWG088s1bv+SMpobyG6NylvJ0NFGo5R090Q96WuJ2+
        oKV1eOpfjJAQ4jkDakVMibs=
X-Google-Smtp-Source: AGHT+IFEKMKg55GmM1zKHZcYfYfsUWrXoXfEZKLoyDe07dO2uoRsG8MlML19lGyIoctSD/nE3A+OCg==
X-Received: by 2002:a5d:680d:0:b0:32c:d0e0:3e70 with SMTP id w13-20020a5d680d000000b0032cd0e03e70mr4069642wru.56.1697632562231;
        Wed, 18 Oct 2023 05:36:02 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id q28-20020adfab1c000000b003248a490e3asm2048211wrc.39.2023.10.18.05.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:36:01 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v4 4/4] net: stmmac: increase TX coalesce timer to 5ms
Date:   Wed, 18 Oct 2023 14:35:50 +0200
Message-Id: <20231018123550.27110-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018123550.27110-1-ansuelsmth@gmail.com>
References: <20231018123550.27110-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8fce33317023 ("net: stmmac: Rework coalesce timer and fix
multi-queue races") decreased the TX coalesce timer from 40ms to 1ms.

This caused some performance regression on some target (regression was
reported at least on ipq806x) in the order of 600mbps dropping from
gigabit handling to only 200mbps.

The problem was identified in the TX timer getting armed too much time.
While this was fixed and improved in another commit, performance can be
improved even further by increasing the timer delay a bit moving from
1ms to 5ms.

The value is a good balance between battery saving by prevending too
much interrupt to be generated and permitting good performance for
internet oriented devices.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 1e996c29043d..e3f650e88f82 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -293,7 +293,7 @@ struct stmmac_safety_stats {
 #define MIN_DMA_RIWT		0x10
 #define DEF_DMA_RIWT		0xa0
 /* Tx coalesce parameters */
-#define STMMAC_COAL_TX_TIMER	1000
+#define STMMAC_COAL_TX_TIMER	5000
 #define STMMAC_MAX_COAL_TX_TICK	100000
 #define STMMAC_TX_MAX_FRAMES	256
 #define STMMAC_TX_FRAMES	25
-- 
2.40.1

