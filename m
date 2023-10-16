Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212197CB185
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjJPRqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjJPRqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:46:36 -0400
Received: from smtprelay04.ispgateway.de (smtprelay04.ispgateway.de [80.67.31.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2B69F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:46:33 -0700 (PDT)
Received: from [92.206.139.21] (helo=note-book.lan)
        by smtprelay04.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1qsRfi-0005Km-0e;
        Mon, 16 Oct 2023 19:46:30 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Date:   Mon, 16 Oct 2023 19:45:53 +0200
Subject: [PATCH] crypto: qcom-rng - Add missing dependency on hw_random
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231016-qcom_rng-v1-1-1a7d7856651e@apitzsch.eu>
X-B4-Tracking: v=1; b=H4sIANB2LWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDA0Mz3cLk/Nz4orx03VQTs2SLRAszI4ukJCWg8oKi1LTMCrBR0bG1tQB
 CBxdjWgAAAA==
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.12.3
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should fix the undefined reference:

> /usr/bin/aarch64-alpine-linux-musl-ld: Unexpected GOT/PLT entries detected!
> /usr/bin/aarch64-alpine-linux-musl-ld: Unexpected run-time procedure linkages detected!
> /usr/bin/aarch64-alpine-linux-musl-ld: drivers/crypto/qcom-rng.o: in function `qcom_rng_probe':
> qcom-rng.c:(.text+0x130): undefined reference to `devm_hwrng_register'

Fixes: f29cd5bb64c2 ("crypto: qcom-rng - Add hw_random interface support")
Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 drivers/crypto/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index c761952f0dc6..79c3bb9c99c3 100644
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

---
base-commit: 4d0515b235dec789578d135a5db586b25c5870cb
change-id: 20231016-qcom_rng-e46c8a8628bb

Best regards,
-- 
André Apitzsch <git@apitzsch.eu>

