Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEA07511F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjGLUm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjGLUmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:42:24 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD908C0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:42:22 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id JgfAqVIqQFZ5SJgfBq4nYd; Wed, 12 Jul 2023 22:42:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689194540;
        bh=v9j0m2cKfHRT+pm9joHgv4l8r7uaiOqt0NGOeHOYA8M=;
        h=From:To:Cc:Subject:Date;
        b=sa5XFfPaI2fZWc9fzGFbfzFz57NPBZt7bmu3cVXQNTnJ0tOv812lXxhxWpzLXRB6Z
         +GZyzSaUURGY6jEncLTqqkyI+Y+At6p3l2z/i8/PJp4icbGp5D6jVNv9vgmb2NNjM/
         it/DMR3K7AH20nBNYGqsYV0IEVFLALMopwSANLhFydgpkFA6RcoIOsjZn98lj6+hMa
         Owo2Wb9j6LcpcqBlbeRsfvo2ZsPGvHp+bf1p2HDRxruSAR87CqcQFMNBnURb+2p1Bj
         rRp/hJRJymKNul+fSK75UYrM8zqGLtI8rdX7qGlfakx1QaIorIzFrXmbQ3ZAP1d73o
         TqTiDX+rMQNtw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 12 Jul 2023 22:42:20 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     keescook@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] soc: qcom: smem: Use struct_size()
Date:   Wed, 12 Jul 2023 22:42:15 +0200
Message-Id: <f74328551cfab0262ba353f37d047ac74bf616e1.1689194490.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use struct_size() instead of hand-writing it, when allocating a structure
with a flex array.

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
It will also be helpful if the __counted_by() annotation is added with a
Coccinelle script such as:
   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=devel/counted_by&id=adc5b3cb48a049563dc673f348eab7b6beba8a9b
---
 drivers/soc/qcom/smem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index b0d59e815c3b..776096b2e965 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -1059,7 +1059,6 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	struct reserved_mem *rmem;
 	struct qcom_smem *smem;
 	unsigned long flags;
-	size_t array_size;
 	int num_regions;
 	int hwlock_id;
 	u32 version;
@@ -1071,8 +1070,8 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	if (of_property_present(pdev->dev.of_node, "qcom,rpm-msg-ram"))
 		num_regions++;
 
-	array_size = num_regions * sizeof(struct smem_region);
-	smem = devm_kzalloc(&pdev->dev, sizeof(*smem) + array_size, GFP_KERNEL);
+	smem = devm_kzalloc(&pdev->dev, struct_size(smem, regions, num_regions),
+			    GFP_KERNEL);
 	if (!smem)
 		return -ENOMEM;
 
-- 
2.34.1

