Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB587F144B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjKTNWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjKTNWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:22:00 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6943519A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 05:21:37 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so52751881fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 05:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700486495; x=1701091295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4fo0VIV7uqzpyPDAWdX5Jk/6XQkZo9JW17PTbGLI2E=;
        b=iWKVhgP076gRs6u8mUnAthn3b+GbXzgyQq5/RZYt6OLIwMKauhpxdm78RN051Dmf7x
         QGJB+ouz5PCIozPqN17L2wBwF+Pp5HRyRj9XppfvUX0T3yqEKbSnOUT+12FEvC6+T2Dg
         c3qS+Sf73T49xawNZoLtGXnZuy7qVdsJEbZxk1/TctVOfXG5VWnDz1UTHGMXPHhks+Lz
         QG9m0rcCEIEtQ5Jwj9JD9JmS/59MihtOFZkvd4tIShke4r89BIiW18RnyedYTuC0zjHJ
         f+RfBGYfl4NVHz4elGxDsLZDa0Pp6xydLvQq51FAP36/iOSedfB+1Oudch0PBa9N61Ck
         HueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700486495; x=1701091295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4fo0VIV7uqzpyPDAWdX5Jk/6XQkZo9JW17PTbGLI2E=;
        b=AAoMwIZ09a3wT6FcPtAQCPwvgaf+TlqKHpLiLS4Guoc9Bg4yrZDuon2G+jA0WoQ112
         RWsw3PvNwIH65ZjJCZPe5rB6fKodHGBbCJp4vaT3ypotnhBV55VQKpfST+gVkB+6v+xD
         IggJJS7P6wf1KJS5K9dCfu12UBoUxG+VcUBg8PBocoELvtrWeGrSRy7DQprILkmdlwak
         TtTR506h6IimCTW1307+mmgXQd0KEqFJL1sVBpSTVIzFqXlABCD7ZprykE8YYTJ8oUQw
         lKw3K0RI7mXmKuAKHFuxjnO9DCWs54NHyZ3UCJxuwhWQy1z69GHw6oTdVHS9Pjz6m8H+
         ecRg==
X-Gm-Message-State: AOJu0YxMatabwANktF0Ppm3SZUp1OgcHI+oQI/7QRqjNiUACdqQFdjtt
        bz4Xn4Kwq//higoO038ZzmSmvQ==
X-Google-Smtp-Source: AGHT+IFXdb7gzI4IMHiMj9vg7v37YVPJ3yyM6zb9TaX7RJaZc8/c+c1k+S0o3wgmpurQ4luAiGdbmQ==
X-Received: by 2002:a2e:9e02:0:b0:2c8:7130:c6e5 with SMTP id e2-20020a2e9e02000000b002c87130c6e5mr4656583ljk.6.1700486495208;
        Mon, 20 Nov 2023 05:21:35 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:c590:a7ce:883:eba3])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c0b5200b004065e235417sm17329192wmr.21.2023.11.20.05.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 05:21:34 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH v5 11/12] firmware: qcom: scm: clarify the comment in qcom_scm_pas_init_image()
Date:   Mon, 20 Nov 2023 14:21:17 +0100
Message-Id: <20231120132118.30473-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231120132118.30473-1-brgl@bgdev.pl>
References: <20231120132118.30473-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The "memory protection" mechanism mentioned in the comment is the SHM
Bridge. This is also the reason why we do not convert this call to using
the TZ memory allocator.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
---
 drivers/firmware/qcom/qcom_scm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 839773270a21..7ba5cff6e4e7 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -563,9 +563,13 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 	struct qcom_scm_res res;
 
 	/*
-	 * During the scm call memory protection will be enabled for the meta
-	 * data blob, so make sure it's physically contiguous, 4K aligned and
-	 * non-cachable to avoid XPU violations.
+	 * During the SCM call the hypervisor will make the buffer containing
+	 * the program data into an SHM Bridge. This is why we exceptionally
+	 * must not use the TrustZone memory allocator here as - depending on
+	 * Kconfig - it may already use the SHM Bridge mechanism internally.
+	 *
+	 * If we pass a buffer that is already part of an SHM Bridge to this
+	 * call, it will fail.
 	 */
 	mdata_buf = dma_alloc_coherent(__scm->dev, size, &mdata_phys,
 				       GFP_KERNEL);
-- 
2.40.1

