Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3CF78D232
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241770AbjH3CnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 22:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241805AbjH3Cm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:42:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698C1CDB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 19:42:47 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5008d16cc36so7936449e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 19:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693363365; x=1693968165; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OiIy8F6L7ofHL1ptg502Xg8wcS3TA92gvx+foZg8Y2E=;
        b=POhimt4vHMAIJCIBFLEb1gaQLPPKkcG+6DROI6EQfQCKgJMugjOeQM4bZjbIIFoQv9
         fqb2DEC4ULTAjPRDeu/hdRgeokNHvmmWDBKKhdBVgrJn0HmTZ2rVMPOqYgoIEdtCRFzp
         FLQoX4XVoFyxDNQrcNTcELM8QJuMa+VErFBf6ZhE4NA2hpaIccNksMvBFKbpFK9AI41v
         5vAPf54YBbR3LQqJvAmDdJ/FaM4tjTufACN1k3FUcXfN8FqS9iazUvBYBgQPxQICtk47
         oX7nNN+L157+wMJ4Rg0hO7VWLp9QihXlLwFenkUzWoGKmk7+O5IxWI8qpXIOpqdbWB3m
         guIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693363365; x=1693968165;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OiIy8F6L7ofHL1ptg502Xg8wcS3TA92gvx+foZg8Y2E=;
        b=BTqMl0h1GsccM2anTbdJyO6UYjuCmuNeicQwDxX5ZOwhnxd/NmRILOtRj1SzDVy+Uh
         E5u8whpgmOpIlofDKjnZvyuwEqEJ4BDQ4yalW0PupLN4USDMkSV618Zyxmsj9/6w9BYB
         hKotaSowKozmizCDqdBiOzial4+/wCPSHhk4QPM56HKWgtOppJRMN6lUlE16ovLSfwWU
         u7zZLEb7MhgzQ4jvwCvHCl9/jaNFx3aNn6x5crr94BtTBa3SC8zwj7hhWRYYcSq2ddgX
         pctRKBbGmc2HEL2slUQQr4lMU9g92PhVd2IEY+dPcZ9vdDlCbaW6VJm8Z2RAHQUvqPey
         gINA==
X-Gm-Message-State: AOJu0YytuHlop3Emc0S5gHEuTkvRTNyFtYaEpNE0wrFMjcKE03FwGHe+
        gSPcvQJHNnWStBD+UZWr/EfY7OqpxSUrb8lg7pYBDw==
X-Google-Smtp-Source: AGHT+IHJlne7AXmpC3d9S8VBBx+4T8acvjs81mUyn8un1kW7DZlwQSsBqftWyQaguWSq/BTQ1HA1Cw==
X-Received: by 2002:a05:6512:2828:b0:500:bf56:cca6 with SMTP id cf40-20020a056512282800b00500bf56cca6mr547246lfb.53.1693363365602;
        Tue, 29 Aug 2023 19:42:45 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id q5-20020ac24a65000000b0050089b26eb0sm2177233lfp.132.2023.08.29.19.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 19:42:45 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 30 Aug 2023 04:42:43 +0200
Subject: [PATCH] soc: qcom: socinfo: Add SM8550-adjacent PMICs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-topic-pm8550abcxyz-v1-1-3c3ef3d92d51@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKKs7mQC/x2NywrCMBAAf6Xs2YXYtbX6K8XDJq52oaYhUemD/
 ruLxxkYZoMiWaXAtdogy1eLTtHgeKggDByfgno3htrV5Dpy+J6SBkyvrmkc+zAvK56JTq0n9hd
 uwULPRdBnjmGwNH7G0WTK8tD5f+pv+/4D/ltsvHkAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693363364; l=934;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=yL5pMpqsq/wDLSjN/4nLs840nP+R9HvCdqWrdswhlGs=;
 b=gthOHJKYuuMWyRM8aV3TisXvUikkAmwEBFeFeVXRespVKXxh/SLsfoUotl+moPN8AAGxbTJzV
 jhg5JLWagtcAK0gBbQUNFnF/S4gqaiDZ9tqj9n6OugF9CQT4R04Gq/b
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the PMICs were missing, add some of them often coupled with
SM8550.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Please somebody double-check, this was sorta reverse-engineered..
---
 drivers/soc/qcom/socinfo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 497cfb720fcb..067d28924ca2 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -117,6 +117,12 @@ static const char *const pmic_models[] = {
 	[55] = "PM2250",
 	[58] = "PM8450",
 	[65] = "PM8010",
+	[69] = "PM8550VS",
+	[70] = "PM8550VE",
+	[71] = "PM8550B",
+	[72] = "PMR735D",
+	[73] = "PM8550",
+	[74] = "PMK8550",
 };
 
 struct socinfo_params {

---
base-commit: ae782d4e2bf53b0b642ae860794f7a39470f995a
change-id: 20230830-topic-pm8550abcxyz-73346b3ab9a6

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

