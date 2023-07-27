Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2477659C6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjG0RPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjG0RPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:15:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B7F3A98
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:14:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so2155261e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690478093; x=1691082893;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iSpTHH/r1JxU23dgkFFzwt7+DPhsvuwAB7Ss8YvVGLg=;
        b=qv+50epRJW2m0RTQy24stBR7Ea6w4jVRUZlsjKhN/t5rJRrulcqqJzDeLkWfL/8N1X
         Cl86IJZG5FGTz6SXAIncvYXWm6Fm8DbuUSk/5ojAr4dJ/0c5YPKN2I6D7Iy5w+stYGGA
         Skqu66Q4X7EmBIQ5811GQNsamCAzKoDbW0XUAePqr506lMRvMD49+YE16ZJv6pIeTpyP
         KYyXjBdWoJrZeZf/IQSRMqXdNzmuc1/PQnQ/E+8NFnZwR2+Mj8JkbdPchwB+Hxt/Frnn
         DLH/CdihVw0vlyWRR+SLWw+wqP5VzgNaaiE6ojbWk4sF4N346J3LLACw8rnAafKh2Cnc
         bqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690478094; x=1691082894;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iSpTHH/r1JxU23dgkFFzwt7+DPhsvuwAB7Ss8YvVGLg=;
        b=As18HAuPUL7Ukx6xkYg8Niw5nMKhfcrUh4/cMr4JMJx/AKUPEDSW9neTbYcSAqAlef
         9R07KJj60qLM3VNqKQyhnkbVcuvflMqHzePtls8x0g5DLQZKV1eKKhpOgDl48yV+WR3W
         oUFkzAQRBsQWGUnBTa6qGdJH8SkSVzh6myJ+QI1zGAcUfJSqgcSLBKtZbt96P0VWzSVD
         G0xdOEFmNfuiZdx1E1MTJtNow/M4ZrMCYwT36wmDBZkbMOqMRAZbBBGbTDUbonlGnscg
         Mp66ydkrsSyklnRvT6HVWrEo94cTrwTGX0zM2vu0bkIqKe5Syky2kAUznEC8LoF1QNp1
         lbLg==
X-Gm-Message-State: ABy/qLZOlEj8Vp1rRML7Z8PFZMEqYjozQGZ8cXf603GkcXf2WYaRBOc/
        zg/8010OrSHnkyzwIsDM9L9r9g==
X-Google-Smtp-Source: APBJJlFu9VD0E0i2KH9s/aAi/qiNd2Vbshj9rmBQFUbqvoo6crNI0X2M5zMLVxEuNt4ntJsMxvXN0g==
X-Received: by 2002:a05:6512:31c8:b0:4fb:79b5:5512 with SMTP id j8-20020a05651231c800b004fb79b55512mr2543259lfe.66.1690478093616;
        Thu, 27 Jul 2023 10:14:53 -0700 (PDT)
Received: from [192.168.1.101] (abxi99.neoplus.adsl.tpnet.pl. [83.9.2.99])
        by smtp.gmail.com with ESMTPSA id w3-20020ac25983000000b004fb745fd22fsm396321lfn.32.2023.07.27.10.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:14:53 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 27 Jul 2023 19:14:52 +0200
Subject: [PATCH v2] clk: qcom: reset: Use the correct type of sleep/delay
 based on length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-qcom_reset-v2-1-4a6e1b1d0439@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAumwmQC/32NQQ6CMBAAv2J6dk0phIIn/2GIKcsKm2CLWyQaw
 t+tPMDjTDKZVUUSpqjOh1UJLRw5+ATmeFA4ON8TcJdYGW1ybU0Jc5gY4YnhcROKNENRVLZGnVc
 WS5Wy1kWCVpzHIYX+NY5JTkJ3fu+fa5N44DgH+ezbJfvZP4clAw216ajscirQ4mVk7yScgvSq2
 bbtC7Upw0XGAAAA
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690478092; l=1491;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xqeqeSVrD0FBd4SOIFWeQ28YnpPrZTJ5YRxUYScajcU=;
 b=9sr4XmOp/nvWERoHxxSOCtWnpIp7SRhiQaK9RL70JkydIWtsE/EDWgOxa94U8MeYcBjq8s8gf
 OtpNeD7j0kWCvQVcTDzKi+WnZU6s51PcElo3QvVSYPF9YTxz86PEvdT
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the length of the delay (see: [1]), use the correct sleep/delay
functions.

[1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt

Fixes: 2cb8a39b6781 ("clk: qcom: reset: Allow specifying custom reset delay")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Let the toggle include a bigger delay and make sure it's using the
correct function to achieve that.
---
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

