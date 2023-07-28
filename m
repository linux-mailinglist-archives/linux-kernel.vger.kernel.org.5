Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A30B7665E4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbjG1H54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbjG1H5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:57:47 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F188F3A85
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:57:44 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9cbaee7a9so12800421fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690531062; x=1691135862;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j0egf4lvYdcuItu5sen9yx+hMceloBrv5HDtWkj+EBQ=;
        b=dS3PNhWJYTk9cprQeaGLT67v18rkYMVG8OD1eutt+f164WQIPznvCQMs7Si18TZqga
         41LKjZwbhGquP/773V+3Vgg+t5yUvegeP4iKWSKuv2M+Hf++5IGdh6BZruuA+Tal36xD
         6M6l1dohtyWMfZdJpQsIdrhHjoYPlkg71FMgddsgM2IVxZa7wMjQAPJO7REo247krxQ9
         BhS8nE+gdvHKQleh2noz0hKehulWCCFpLKNZCZVlkGPHyE/O7/D1kqPveRZMDz/vE8uw
         xfsNZ9h9/JbSN4iosvgAdkXzl3uZe3stDsJlYoq2UW3aJIRXtF/93v31NK9c9JAkRucj
         sT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690531062; x=1691135862;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0egf4lvYdcuItu5sen9yx+hMceloBrv5HDtWkj+EBQ=;
        b=IsIve9oqMa0QP6Y1MLn4C0xpSmzvYYlniAACHGix2SsVULT5Qv5OTyemtgjFLWxDd9
         rg1we9sXkJI4FOAqf0uvhKtqNRqE+uJYISGJ3iBvhIjn7/fXEmk9c53GeGQWEkXSQwwR
         IYGMXv1g/uB/UD5PTs1vzW5N6K/3z8GPGJPf8EqoDLOi82Q/3ykYp/yEoEzaJ/s2YG5S
         2rTQS6NLvtUxeAG5T/lALA7lpmX9SuwwhCaYyXeoB96Siq3tRAlMfKasxrmlp6BJV7Xh
         AFJ6uLOTLJF7VKkIe6A6fehK04ovvy7tPvXb7eMLMNhGawyu5q/mg4iYiVXT4A++b58m
         vE6A==
X-Gm-Message-State: ABy/qLYGvlJDOtRHf45TrI5ok7VkP+uwQ3hc929VQ2Yf6t69U/nQqWwH
        FsURq1XO7w6Ki9rfvDKeL0thEQ==
X-Google-Smtp-Source: APBJJlExEQ4pj7ugLoNByUG8EtzPoAPNQAMl1O8D7AkLZ3lHhZRhnffSaaDkTHoh4VybbisqyXWvzw==
X-Received: by 2002:a2e:8052:0:b0:2b7:2066:10e1 with SMTP id p18-20020a2e8052000000b002b7206610e1mr1073206ljg.0.1690531062110;
        Fri, 28 Jul 2023 00:57:42 -0700 (PDT)
Received: from [192.168.1.101] (abxi112.neoplus.adsl.tpnet.pl. [83.9.2.112])
        by smtp.gmail.com with ESMTPSA id b9-20020a2e9889000000b002b9b90474c7sm812128ljj.129.2023.07.28.00.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 00:57:41 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 28 Jul 2023 09:57:38 +0200
Subject: [PATCH v3] clk: qcom: reset: Use the correct type of sleep/delay
 based on length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-qcom_reset-v3-1-5958facd5db2@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPF0w2QC/4WNywrCMBQFf0Wy9kpepK0r/0NE0uTaBmpSkxqU0
 n837c6NLufAmZlJwugwkeNuJhGzSy74AmK/I6bXvkNwtjDhlAtacQVTGJ2Bhwn3a8SEE0hZV42
 hoq6MIuXW6oTQRu1NX47+OQxlHCPe3GvrnC+Fe5emEN9bNrN1/VHIDCg03KKyAqWpzGlwXsdwC
 LEjqy3zfwYODKRWyFpmqRTNl2FZlg8k00lNCAEAAA==
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690531060; l=1668;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=KmWdb1cFJ5NCkxYQVBMw/8dqUkNhoXKd6PZJInnl0sk=;
 b=5ex5l4lNbpCLd6R/8kOSv9yzeJmaFT0DCt2kcnOoNuiA0y2TM42MwY7xpad/DVo/0JpqjJo5P
 ADVi7622fQhClBiG34qwptIDGxNnP2l+BEjaVBhjtu5DNOwN4gIIkff
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the fsleep() helper that (based on the length of the delay, see: [1])
chooses the correct sleep/delay functions.

[1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt

Fixes: 2cb8a39b6781 ("clk: qcom: reset: Allow specifying custom reset delay")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Let the toggle include a bigger delay and make sure it's using the
correct function to achieve that.
---
Changes in v3:
- Improve the commit message
- Link to v2: https://lore.kernel.org/r/20230726-topic-qcom_reset-v2-1-4a6e1b1d0439@linaro.org

Changes in v2:
- Drop the "allow bigger delay" until there's a user
- Use fsleep instead of open-coding effectively the same
- Fix the fixes tag
- Link to v1: https://lore.kernel.org/r/20230726-topic-qcom_reset-v1-0-92de6d3e4c7c@linaro.org
---
 drivers/clk/qcom/reset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
index 0e914ec7aeae..e45e32804d2c 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -16,7 +16,8 @@ static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
 	struct qcom_reset_controller *rst = to_qcom_reset_controller(rcdev);
 
 	rcdev->ops->assert(rcdev, id);
-	udelay(rst->reset_map[id].udelay ?: 1); /* use 1 us as default */
+	fsleep(rst->reset_map[id].udelay ?: 1); /* use 1 us as default */
+
 	rcdev->ops->deassert(rcdev, id);
 	return 0;
 }

---
base-commit: 451cc82bd11eb6a374f4dbcfc1cf007eafea91ab
change-id: 20230726-topic-qcom_reset-44879c0387c6

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

