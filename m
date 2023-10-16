Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6217F7CB3A1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjJPUDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjJPUDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:03:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E06AEA;
        Mon, 16 Oct 2023 13:03:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E978C433C7;
        Mon, 16 Oct 2023 20:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697486612;
        bh=vuVQ78sxmBFgv5vVcwICGwoG+DfomOY79aR9/3vI29A=;
        h=From:To:Cc:Subject:Date:From;
        b=cwO1bGAOBBaJWckr/g3z6ld9vHdkYM/GFpFtTYy1BXz9nDUc3j7gCMXtTBd4QGUbc
         Nbs0+gL08VAudYHFrLgSY8Ljlz4VyW/Atrx3KFVVfi0aV6vHaiVsFO2E9dpyhjwS3A
         xtD1LoMvpr1/jW1ovt2JsbTHSM6V9dkFs3jQDkfRRO0/03T3BbBzeUAEPyn1+wEeJo
         7Rmhqt6nY/1ZcMoE4nnQecdQGtOinG6F46Zvi3OpXL1iLpcEtqovsiqicdlifLb+RG
         oY12HqEkcylvqhSO/2tdvHqJ3Udk5q5YgMAhoiWkPufBFbknBuRUykMIbVWS/CFcrz
         hphfzPzr6WXqg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Om Prakash Singh <quic_omprsing@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: qcom: add HW_RANDOM dependency
Date:   Mon, 16 Oct 2023 22:02:57 +0200
Message-Id: <20231016200324.757455-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The driver now calls into the hwrng subsystem and causes a link failure if that
is not reachable:

x86_64-linux-ld: vmlinux.o: in function `qcom_rng_probe':
qcom-rng.c:(.text+0xfefc7e): undefined reference to `devm_hwrng_register'

Add a Kconfig dependency as we have for the pure hw_random drivers. I see
that there are some other crypto drivers that instead use 'select HW_RANDOM',
but those seem to be mistakes as that may lead to circular dependencies,
and a simple driver should not force-enable an entire subsytem.

Fixes: f29cd5bb64c25 ("crypto: qcom-rng - Add hw_random interface support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index c761952f0dc6d..79c3bb9c99c3b 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -601,6 +601,7 @@ config CRYPTO_DEV_QCE_SW_MAX_LEN
 config CRYPTO_DEV_QCOM_RNG
 	tristate "Qualcomm Random Number Generator Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
+	depends on HW_RANDOM
 	select CRYPTO_RNG
 	help
 	  This driver provides support for the Random Number
-- 
2.39.2

