Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF88378B863
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjH1T2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjH1T1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:27:31 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D9ACD8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:27:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401d2e11dacso1808535e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693250826; x=1693855626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=713tM2MtTN06BKtmpTKPtHYKAypTeU06f4AnOlNhYD4=;
        b=CSqa+pEoDUW2H0ZlraiWwUc3xrWOrJ1YaHmkjhFa1p/azSB734HWr7cU7e+myIPnxY
         qDsDy9RJtc6PWOZi806K/E6XsRbqhVy78B/oFwKTyW+g05lo+dhP4G62hGqrlQ641ZRU
         P8VP6sbAPFh7XXebDCKtOJ70udNb6SwiNfDapAw4WM4QHiBs1L6MYTO4T/+WXxLsQzk0
         zIDoQGuZovksV9kVbawJ4xMgU2RlWI4uFaqB0yceUpKqZgcbSbYm5R1v8e88gGNG0KjH
         a5g9KaWoA3XNQ1D9zdItbOL4waj9PwpuPKgLNZQMhF8maGHr7j0ai4dCzdIUHby5GJf2
         Rccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693250826; x=1693855626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=713tM2MtTN06BKtmpTKPtHYKAypTeU06f4AnOlNhYD4=;
        b=gTf1wAF/4WGenaCzv/ptfQgVaC2Tji+LUE5kE9D8rft0U4yh7gA+JbfpNarwZrGE1a
         jMCzZQ/kmkqpk1oR6w+SwE3Ih5rog6b+E/VrXIgCF6A0i4yvuFhjML1hvVD9sGY92jkP
         z9fwWYJQLoymrLsUf8r9y7TGiENscW9G92TLxy95awG9ylGZv8zxMJgKev2OgqfBtL1J
         Cskr+g4cmaAy0G1KE+GSVWtE0j9G9b+dzex3BYwUlimjF4rRQBlVht4MNvIvu9P8mXfL
         8MHbKPs1r/YWVvH6DD7e7e2TxTlATr4MIVSosG5r7vOdRghDuTlc/+SBxKXc3t3dJO92
         np2w==
X-Gm-Message-State: AOJu0YzHIuWsXMFUsuIVfCiBwsoh+KaMTqoA6xL58yDYVpdTw94S2Zr7
        kCs9ILsN/fQF55lVOS+lGQz9oQ==
X-Google-Smtp-Source: AGHT+IFP03AKHAfr/hAQD0gGF3wtYUFTciEZ8PKvTMJRFIBUMmxXBs7iwRUVJNseZQVqoKpOwBLzaw==
X-Received: by 2002:adf:e682:0:b0:319:8c99:989a with SMTP id r2-20020adfe682000000b003198c99989amr369735wrm.8.1693250825898;
        Mon, 28 Aug 2023 12:27:05 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8bd:7f16:d368:115f])
        by smtp.gmail.com with ESMTPSA id i20-20020a5d5234000000b003141f96ed36sm11435319wra.0.2023.08.28.12.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 12:27:05 -0700 (PDT)
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 03/11] firmware: qcom-scm: atomically assign and read the global __scm pointer
Date:   Mon, 28 Aug 2023 21:24:59 +0200
Message-Id: <20230828192507.117334-4-bartosz.golaszewski@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking for the availability of SCM bridge can happen from any context.
It's only by chance that we haven't run into concurrency issues but with
the upcoming SHM Bridge driver that will be initiated at the same
initcall level, we need to assure the assignment and readback of the
__scm pointer is atomic.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom_scm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 980fcfa20b9f..422de70faff8 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1331,7 +1331,7 @@ static int qcom_scm_find_dload_address(struct device *dev, u64 *addr)
  */
 bool qcom_scm_is_available(void)
 {
-	return !!__scm;
+	return !!READ_ONCE(__scm);
 }
 EXPORT_SYMBOL(qcom_scm_is_available);
 
@@ -1477,8 +1477,8 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	__scm = scm;
-	__scm->dev = &pdev->dev;
+	scm->dev = &pdev->dev;
+	WRITE_ONCE(__scm, scm);
 
 	init_completion(&__scm->waitq_comp);
 
-- 
2.39.2

