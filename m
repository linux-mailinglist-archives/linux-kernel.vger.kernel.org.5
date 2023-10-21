Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1E07D1C7A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjJUKUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjJUKUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:20:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02875D52;
        Sat, 21 Oct 2023 03:20:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85B1FC433C7;
        Sat, 21 Oct 2023 10:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697883645;
        bh=G1oBArnGygsP7oyeCAvlm7sMNzau2v8kxu5F3qI3xhQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=ks4fjY3oW9Tzqt/g6oeNIYwVCFCxAPJpQmCUG+71ntYBFlLgS2lpK+e5zPtjHkq9N
         SztvnAtUmvfx4oBNp8w89NgkmBr3XKnmDMlcweVctRjs5+nMUeLeGzRnt2JV4VQeyi
         U7C9m8bCzklCk8nlUJujCJ+PiruhubuN2jq68GEjFDP8aU6gltqyfhnkFt3C4ZpmsN
         nD/X5snTFATc5DGNhTHbqNIO6SpAyrh6GfpDOvPlnw6BN+10DxTT0NMWfGyuJvgnlV
         GJQ8Fc9kIItqUlXEun0TSJX8WIiixq4X3GxTqxsynvkQLjZhU/P0fe1GT2kIh4d4YB
         rjrEMSlbF6uZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 68E01C004C0;
        Sat, 21 Oct 2023 10:20:45 +0000 (UTC)
From:   Xilin Wu via B4 Relay <devnull+wuxilin123.gmail.com@kernel.org>
Date:   Sat, 21 Oct 2023 18:20:38 +0800
Subject: [PATCH v2 1/3] soc: qcom: pmic_glink: enable UCSI for SM8350
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231021-sakuramist-mi11u-v2-1-fa82c91ecaf0@gmail.com>
References: <20231021-sakuramist-mi11u-v2-0-fa82c91ecaf0@gmail.com>
In-Reply-To: <20231021-sakuramist-mi11u-v2-0-fa82c91ecaf0@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697883643; l=945;
 i=wuxilin123@gmail.com; s=20231021; h=from:subject:message-id;
 bh=ww4sODm0ahT+SQ9wq+84FM3R6cXdq4VaDdGF3LcSqxc=;
 b=9NUeGZkuoPItLn4fyrpx4XrJvrcXMpd4BsFYrPVAAUj7PWqYPFYiCWgh+l17lpMxZ7JzkugDT
 oJr0daynNexCCixJcBv5+7MBXMyfmPSV+2PZdA/NE9T26aRt0N/9yq0
X-Developer-Key: i=wuxilin123@gmail.com; a=ed25519;
 pk=edoFbrGewAWr5/CxptHll7XzvXBjYiN49RrEgipi1Cg=
X-Endpoint-Received: by B4 Relay for wuxilin123@gmail.com/20231021 with auth_id=89
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
index 914057331afd..1196e79e6fb3 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -341,6 +341,7 @@ static const unsigned long pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT
 							   BIT(PMIC_GLINK_CLIENT_UCSI);
 
 static const struct of_device_id pmic_glink_of_match[] = {
+	{ .compatible = "qcom,sm8350-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
 	{ .compatible = "qcom,sm8450-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
 	{ .compatible = "qcom,sm8550-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
 	{ .compatible = "qcom,pmic-glink" },

-- 
2.42.0

