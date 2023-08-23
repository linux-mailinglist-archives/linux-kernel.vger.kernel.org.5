Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F01785959
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbjHWN3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbjHWN3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:29:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F304010C1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-977e0fbd742so711504566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797299; x=1693402099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIvDC1RQQDdB76emFuds/bRYMDd6MDnA3Z/g/2DlsAI=;
        b=lGDs7kLv4Kfe8ii2b0Dj1LtrzBn8Ir6ToUd2Yh4wI0W/xCbdVrhnmT7CWjD1FvfyG9
         Xb063v/ErJTsYBaJ6tdMAv3weg/q+ekcH0xvMwfeaOnizGBKkRiXtztszrUSby3sD4+A
         O6wYlg7yFdq3P5pzMGI5sgrLxjNai49ve6jDWrDWAw0o+1ACGTqZOTKP4hE6EYYvSGI3
         KCCjsIk6p2OZtEUwjL0L5TuVecB8hBE3+ABe0wIX47TUNMGlRO/gW60b/ysg83cgqNZH
         0HmsA41C3hlxYe1Yy4oDxu9gzPNQdTtjhbZKJp1uPK9J1GMWee2q+o1+ZccOdl9MKP4v
         qBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797299; x=1693402099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIvDC1RQQDdB76emFuds/bRYMDd6MDnA3Z/g/2DlsAI=;
        b=LO15FJXufZFLoRmsLR1+7ukhd6YeA5RDIIH9sOCq+hai0ygjAC6QXOmB+MVVGLNxEf
         99g8S2Z8nsMeDHojtCTHDwMW7h9aQYw0zq8HH/c0dg1TamdsI1WsR7XdOEgZEJnyeyPs
         UZm1jEjX7vDcsQOVvnMgPxiZMR0scFr9GaPvEqrTxP+3XyP/vE743C1DxSwlLrCxav7C
         SPnViJkv4/0EdH9Jy8wXRaVwGUvAE5KOIph9r2RS3z2mVheZxvctuN41oUcs3TPj7TVP
         EHJrTlD0aQLQ61GE5RSb67YfnkdJnwbCm7TIX0y9Hfk214o4jbT4cIK+17S2iuo2kDtg
         jtQQ==
X-Gm-Message-State: AOJu0YwNNWKIy62MEpS/oeUgDssfacZ+vS3SDrwF6XG2QD3OZ2VQOUAo
        gKns7Z6R4UZ9uUCknNjvZOEhCA==
X-Google-Smtp-Source: AGHT+IEyl5QNmU+IDBlS7NwM7BMrRpIvaSS2hp6aPckvMO3tc+mlC8k3gJcWNmCZ7LvbT1eIOmEIPg==
X-Received: by 2002:a17:906:9be3:b0:993:d75b:63ea with SMTP id de35-20020a1709069be300b00993d75b63eamr10350922ejc.16.1692797299687;
        Wed, 23 Aug 2023 06:28:19 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:28:18 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 21/22] nvmem: core: Do not open-code existing functions
Date:   Wed, 23 Aug 2023 14:27:43 +0100
Message-Id: <20230823132744.350618-22-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=952; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=vco5aA3gxE/siVz4GE3hjfmbsR8BAexpxsK1E2G+ZEo=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glKLW0DHOxk5WDEAePV3zp/DgG6uvB81yUcb Z/HiCvhGQiJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJSgAKCRB6of1ZxzRV NzO3B/9CoSCOB20SbqjDijORfnC+dlG5Devd/uw7XQOBEB2wHQuhtpUck0sgs4EhzYuPvgsiyLL ehgerHxpw2ororNfcZJ/Eq6VMdQKR/Pf1W2s+HdCyTM/tqAiNz9YQif2ZXa/2HPFquuLL9aXFlX x/7cjVBhvdtectN9OjgJZA8rU7wcwDX3C0OFK7p2GEuoOIegf5q1KSY6Zcc/J8mEkqvlhWetKpT TDCr5VJD+FDMtoiHOA02ic4+khKxifQ3GoPqBUWZ1XapcLYNGOmINpaM3NoqN+wC5Bk9fOcQcXL IaRF4K+zmK5xy2p9BL3vjAeoChwsh6UYe3wqEifZtR5ScPkD
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Use of_nvmem_layout_get_container() instead of hardcoding it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index bc7ea001a446..12d05aea0b41 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -785,10 +785,10 @@ EXPORT_SYMBOL_GPL(nvmem_layout_unregister);
 
 static struct nvmem_layout *nvmem_layout_get(struct nvmem_device *nvmem)
 {
-	struct device_node *layout_np, *np = nvmem->dev.of_node;
+	struct device_node *layout_np;
 	struct nvmem_layout *l, *layout = ERR_PTR(-EPROBE_DEFER);
 
-	layout_np = of_get_child_by_name(np, "nvmem-layout");
+	layout_np = of_nvmem_layout_get_container(nvmem);
 	if (!layout_np)
 		return NULL;
 
-- 
2.25.1

