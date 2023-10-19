Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B6F7CF5BC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345272AbjJSKu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345222AbjJSKuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:50:25 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304D3119;
        Thu, 19 Oct 2023 03:50:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405361bb94eso81833215e9.0;
        Thu, 19 Oct 2023 03:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697712620; x=1698317420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0kA5AlKjrLizskj5uytfds0dpoLuHCNfkvCp+8e4rE=;
        b=NhTfeyNq0ANCusoMuwdibbve8VdP/9rx1Ppz6zIqotyPo+j9d+dky6ULL2ZEIpVEN+
         O6/C1TUnoIwMjdtH3ABcAa9WHQTovAnF+f5iRxwI/Kv4eldx+X6OBhtSDzjN6w5Iy+Uc
         JvHTPWGpcWXPLRXwmrYq1KokfaDnrh9+W69jliRIwFV+fj5ap3Kzafsr5i85zbWrXsr9
         ioc84lKyJDMXYBKESrjloSfhrL/ei/Ul8lvMgoPvZlN8O3ipbHnjZVVRmhdkSAatR7z0
         TprFUzIYT256Fy7KTAPZkJ6EDRvaknCbTvD7jHl0OTt+81g9qPs7RfKAmFy7I/1Jyzz0
         4PzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697712620; x=1698317420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0kA5AlKjrLizskj5uytfds0dpoLuHCNfkvCp+8e4rE=;
        b=AjaaVMOfn6rKYLysaJKRFKYB2ecHi2MRayZV2jBADWEgm5U88GQgBXItW1RB67eFDs
         2l3Vf6XKR69xLllYmSh2pwzItJQfHbqsH4fkuegfupNEz6kWgjvj5pCC8W4uUdeniko2
         KRYl6x8T2vrlJdSeRbJ+I0Mh5xEhw0bV/rJ+oftLNCjTaaTYuCgdpup4uU3n5AMuQm8N
         tWJxcNjNyAeIc7nWIsnekY5n48koVBp5Z7Z2bKUEnfbM/uNiF8rF6Okj1ycXVfFsWSzF
         FoWl7ETJhYu8LUtFeVnc9X2uAuN5k8X6PJrWG8EgfnoNHoYOaeFcRWx2tVH36EMD1wNB
         Wd4g==
X-Gm-Message-State: AOJu0YwKQ3xRCuXyb63wi2bf0YJKLRK+AwS08ICcjw8paULqoyf8AvIO
        D3rrqFYWZdsmcLSaCFJD8Tg=
X-Google-Smtp-Source: AGHT+IHnTzjDqtafD+rr14AC8TX2C8b9Bo2oq68JmVzYH4KrooCrDEsRWTEbUFWjMP4Of31W6XWQlA==
X-Received: by 2002:a05:600c:1f82:b0:401:c944:a4d6 with SMTP id je2-20020a05600c1f8200b00401c944a4d6mr1537035wmb.28.1697712620283;
        Thu, 19 Oct 2023 03:50:20 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id bh9-20020a05600c3d0900b003feae747ff2sm4129511wmb.35.2023.10.19.03.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:50:19 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v7 1/4] cpufreq: qcom-nvmem: drop pvs_ver for format a fuses
Date:   Thu, 19 Oct 2023 12:50:08 +0200
Message-Id: <20231019105011.7289-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231019105011.7289-1-ansuelsmth@gmail.com>
References: <20231019105011.7289-1-ansuelsmth@gmail.com>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

The fuses used on msm8960 / apq8064 / ipq806x families of devices do not
have the pvs version. Drop this argument from parsing function.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v7:
* Add this patch from reverted other series
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 7f9ff86cfc5f..c399b5014b49 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -78,7 +78,7 @@ static int qcom_cpufreq_simple_get_version(struct device *cpu_dev,
 }
 
 static void get_krait_bin_format_a(struct device *cpu_dev,
-					  int *speed, int *pvs, int *pvs_ver,
+					  int *speed, int *pvs,
 					  u8 *buf)
 {
 	u32 pte_efuse;
@@ -209,8 +209,7 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 
 	switch (len) {
 	case 4:
-		get_krait_bin_format_a(cpu_dev, &speed, &pvs, &pvs_ver,
-				       speedbin);
+		get_krait_bin_format_a(cpu_dev, &speed, &pvs, speedbin);
 		break;
 	case 8:
 		get_krait_bin_format_b(cpu_dev, &speed, &pvs, &pvs_ver,
-- 
2.40.1

