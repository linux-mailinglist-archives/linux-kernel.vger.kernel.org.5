Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416B17710BB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjHERDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjHERDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:03:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA634207;
        Sat,  5 Aug 2023 10:03:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E04CC60C53;
        Sat,  5 Aug 2023 17:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34D28C433C9;
        Sat,  5 Aug 2023 17:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691254995;
        bh=Y4mHarr0ZZUb0Inhoaa/1/0OOxOmFxEbSYdOG/lOxso=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=mS/qhA5UwQNdxDt7otxYDZYCIZJ5FJhK7zz4OcH2X/39molSJMje8g3uckIIPhCjz
         CdyiCOLeoFuwiPaFjA334dijlNLORAgO2x2Zr1V5djCtRAFmosqe151U5mq4sMsLbU
         VyYD2hI6pATlRXHolLMGXTZTtcwqntkObK184S5MQyDbcrFFanfoVNFlW0+75PD/cw
         tJrxhl0bi1YnCNLyzglGmNAC2cB0BmEhgGLPYJX6AAP1xuFfZi3iT0S6WQMIgkfQ1G
         0Gi78RxWQ83D1OUpmQQ7EfbzQAgvpsCd3j3EvZtN4UzlTbHiK2toR8giR9DXo//Lyn
         EfW6TG2rq/ozw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 0B097C001DB;
        Sat,  5 Aug 2023 17:03:15 +0000 (UTC)
From:   Xilin Wu via B4 Relay <devnull+wuxilin123.gmail.com@kernel.org>
Date:   Sun, 06 Aug 2023 01:03:10 +0800
Subject: [PATCH 1/3] soc: qcom: pmic_glink: enable UCSI for SM8350
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230806-xiaomi-star-v1-1-0c384e8b5737@gmail.com>
References: <20230806-xiaomi-star-v1-0-0c384e8b5737@gmail.com>
In-Reply-To: <20230806-xiaomi-star-v1-0-0c384e8b5737@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        Xilin Wu <wuxilin123@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691254992; l=945;
 i=wuxilin123@gmail.com; s=20230805; h=from:subject:message-id;
 bh=8u609EldV83Ng5xHetZEgLHYVtSc2Twgv9QEReU9uOo=;
 b=gsGA5YgCuKsodrhbBj9DozdJ3dezWB+wNSeHDs4vuXg/1iDz3If3T9MEGLjOYnONT98+zXGQu
 cucu8altUPYB7h5cnsfWqbahzyPamNH7oBbmO8wuJCUpSEpenxxxQQV
X-Developer-Key: i=wuxilin123@gmail.com; a=ed25519;
 pk=OZIrHT2qWm7yEdp5fsVR7GsFx1wxciIii20H06Ud088=
X-Endpoint-Received: by B4 Relay for wuxilin123@gmail.com/20230805 with auth_id=73
X-Original-From: Xilin Wu <wuxilin123@gmail.com>
Reply-To: <wuxilin123@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xilin Wu <wuxilin123@gmail.com>

UCSI is supported on SM8350. Allow it to enable USB role switch and
altmode notifications on SM8350.

Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
---
 drivers/soc/qcom/pmic_glink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index c87056769ebd..0f8ac55ec2ac 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -347,6 +347,7 @@ static const unsigned long pmic_glink_sm8550_client_mask = BIT(PMIC_GLINK_CLIENT
 							   BIT(PMIC_GLINK_CLIENT_UCSI);
 
 static const struct of_device_id pmic_glink_of_match[] = {
+	{ .compatible = "qcom,sm8350-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
 	{ .compatible = "qcom,sm8450-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
 	{ .compatible = "qcom,sm8550-pmic-glink", .data = &pmic_glink_sm8550_client_mask },
 	{ .compatible = "qcom,pmic-glink" },

-- 
2.41.0

