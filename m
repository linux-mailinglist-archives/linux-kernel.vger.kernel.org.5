Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F8F7FF11E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345777AbjK3OEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345566AbjK3OEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:04:44 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFC81B3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:04:50 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54c0bca218dso746385a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701353088; x=1701957888; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pGKbsrS8HFlOmn4rDPKznNWz+NWrUs797K33kLKZj4I=;
        b=k67bzIRAKeF4Q1Xc0xXT5FUCD2g8OHQtUR4k6qN9sixZdoBKa5/7GsHUw1D26H1ZKy
         Z2aF8LcyGuk6GJYBA2ZX/zoBvg5LPelKSMiznzfc0srPzJowpNT6F59bPQGTy/JHSxER
         3JGUaogz2OjJY6jxYUvbjaHS28l0NpPVR5/CTFcj8s6M1jYmO+IQe4DnEz2RFI3BUHTD
         zUuBcriCwwCbwqE0yDhoJo9u5kYxpA4xykbBUHFfkqEUuJHuSw6+nynw5/+yEd0u4Z+j
         5OEV1ajr4xaf+WK7LT0g2Z1i3t1N1+0rEbi7Dx405RJAb2ghvhKtCeFBpHA/tGqRMdSw
         QaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701353088; x=1701957888;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGKbsrS8HFlOmn4rDPKznNWz+NWrUs797K33kLKZj4I=;
        b=sp/kh1b8pb65UYl4cCQsXYZ/ASECaARs4XlUvE9FrjqkQeIa/ErIK0yitWcuOqsAmQ
         Ev6XIiOPqgAwNy1N/OapKpEnnXdgxJE5zUoQrYv1o7A/kIi4KN2U4XfaioOjhacHeH5d
         QAld+4m9LWVpHY/bh3v+2hSTsJwnceX/Z5rWv0NfT3/acxRBFMxnJdzxSPzVm4FnUniP
         ufPiEVZaM1fxsBmiYrIsEc47HFtZRb40HW/aNSgT8GwRT2fYEZHRS5MNJ/obQqMlw0lp
         ZdUHNX3DW9Z9uDt4q/LvQ7hDv6iwBIorLIboqAYahP4a1JKd0njOe/NWyyu98dCgq3Cx
         R3+w==
X-Gm-Message-State: AOJu0Yw8XJr0t1pV9CASlgY4IWQFzADE8OxcGEuKQFRrNE3pw3uQD6zY
        dFION6j7Eq1WH6etvLWqcIemOg==
X-Google-Smtp-Source: AGHT+IGngvHRwAbsjuw12JjGFczh5cjo82vLwrx0SzdSAuri3G83AegT+iTn/fzD3P1bdPfCNyaktA==
X-Received: by 2002:a05:6402:2047:b0:54a:f3df:5814 with SMTP id bc7-20020a056402204700b0054af3df5814mr14049790edb.25.1701353088536;
        Thu, 30 Nov 2023 06:04:48 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id bo19-20020a0564020b3300b00548a0e8c316sm571184edb.20.2023.11.30.06.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:04:47 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 30 Nov 2023 15:04:45 +0100
Subject: [PATCH] interconnect: qcom: sm8250: Enable sync_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-topic-8250icc_syncstate-v1-1-7ce78ba6e04c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHyWaGUC/x2N0QqDMAwAf0XyvEBbJ7r9yhCpMZsBqdJ0wyH++
 8Ie7+C4A5SzsMK9OiDzR1TWZOAvFdAc04tRJmMILtTe1w7LuglhFxonRIN+E2mJhbEN3Li2i9O
 VbmD1GJVxzDHRbH16L4vJLfNT9v/u0Z/nD5NLJFp+AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701353086; l=1003;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=VOLasUkRPJfMaQ++a/e0LfA4FM1YxoUkJbWWFQdBDJ0=;
 b=MYnLohakk1PKPabBjSwyIgFqoYS/wngoxLn9E8TuXTfUjRYj3C20OJDj7bPu94HMlr9bdD4BR
 BfSViwtJvJNCtl0C5C9GXo6vH8hmH34C2gYZ2rTV4lFhU2nDL5mk/8A
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

Add the generic icc sync_state callback to ensure interconnect votes
are taken into account, instead of being pegged at maximum values.

Fixes: b95b668eaaa2 ("interconnect: qcom: icc-rpmh: Add BCMs to commit list in pre_aggregate")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm8250.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index 83aeb3eedc19..02d40eea0d69 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -1995,6 +1995,7 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sm8250",
 		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qnoc_driver);

---
base-commit: 1f5c003694fab4b1ba6cbdcc417488b975c088d0
change-id: 20231130-topic-8250icc_syncstate-72e5078ad4c9

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

