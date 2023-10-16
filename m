Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141CB7CA12A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjJPIC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPICX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:02:23 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36529DC;
        Mon, 16 Oct 2023 01:02:19 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50435ad51bbso5317898e87.2;
        Mon, 16 Oct 2023 01:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697443337; x=1698048137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtLS9Nj2nFZBWPhUvEtRP9PYRoru3Ywsw6HKjKsybKc=;
        b=c0IZT4D8Nsxv62ZEZlgu2DEtSvWccOrCZFGl5xEN5f3Zf6/A3QZtj1WLO9HAQPcyn7
         lVoy6gz6uyWT+wiWKYRkoEqtTy7r5sCJX3bd45pwpb2f9pZ3GoQkO5R89WMIplbM8KHz
         KnyAh24OhQJ8/Qd7VI17JBaHRITSHl6kqjoHzlD6umbYj0/ewPlYHCOlWyHkh/DGUDtq
         vArVJN00Q5RKyXIaLzI6VY/QTvH/HvHy7rX10KULcRzrG3fVN5EeqkkIHhmP9Q5GmfrN
         WwO9qdiHr0jhPbpmtlXfh5XtSgi51z16aTYoBIU3LMsRgZMk7DZGJyYH5CcZGXFKcQiA
         qJ7w==
X-Gm-Message-State: AOJu0Yw/3APZs4kQoqub3dP3Q00Ve4ryvSdnyroZru67MC+CYlmocv6P
        nnrZL7c8v92q9J4Q/MFXrYAFX6Pe+5cR1jLH
X-Google-Smtp-Source: AGHT+IEJgVTIkDdKS8wbwl9GR9zgveQ3KCzOuWUyYvLzmOvka53rPoTXp7pcFySPS7cbYgXGyHt08g==
X-Received: by 2002:a05:6512:33d0:b0:507:a1df:1408 with SMTP id d16-20020a05651233d000b00507a1df1408mr4684169lfg.55.1697443337286;
        Mon, 16 Oct 2023 01:02:17 -0700 (PDT)
Received: from cizrna.home (cst-prg-37-192.cust.vodafone.cz. [46.135.37.192])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c419600b00407460234f9sm6395535wmh.21.2023.10.16.01.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 01:02:16 -0700 (PDT)
From:   Tomeu Vizoso <tomeu@tomeuvizoso.net>
To:     linux-kernel@vger.kernel.org
Cc:     Da Xue <da@libre.computer>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/2] pmdomain: amlogic: Fix mask for the second NNA mem PD domain
Date:   Mon, 16 Oct 2023 10:02:04 +0200
Message-ID: <20231016080205.41982-2-tomeu@tomeuvizoso.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016080205.41982-1-tomeu@tomeuvizoso.net>
References: <20231016080205.41982-1-tomeu@tomeuvizoso.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this change, the NPU hangs when the 8th NN core is used.

It matches what the out-of-tree driver does.

Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
 drivers/pmdomain/amlogic/meson-ee-pwrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/amlogic/meson-ee-pwrc.c b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
index cfb796d40d9d..0dd71cd814c5 100644
--- a/drivers/pmdomain/amlogic/meson-ee-pwrc.c
+++ b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
@@ -228,7 +228,7 @@ static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_audio[] = {
 
 static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_nna[] = {
 	{ G12A_HHI_NANOQ_MEM_PD_REG0, GENMASK(31, 0) },
-	{ G12A_HHI_NANOQ_MEM_PD_REG1, GENMASK(23, 0) },
+	{ G12A_HHI_NANOQ_MEM_PD_REG1, GENMASK(31, 0) },
 };
 
 #define VPU_PD(__name, __top_pd, __mem, __is_pwr_off, __resets, __clks)	\
-- 
2.41.0

