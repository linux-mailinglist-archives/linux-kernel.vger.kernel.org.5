Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCD47AE892
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbjIZJC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbjIZJCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:02:54 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FB0EB;
        Tue, 26 Sep 2023 02:02:47 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bfea381255so140196771fa.3;
        Tue, 26 Sep 2023 02:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695718965; x=1696323765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nn++ZRiERD42GEM7/3lgly/PCrOOcDZOlQaX2n06sSk=;
        b=l/W1LAZxMjdVji1v8V4ueA5istrnZF1Gd54XP504T6tfsYBv1JKBW85aJKcsYnxB6b
         pIKAtjXtbOh/GGc/ysyGZk7GZQu+ktSZaitviBzn6a2qhSV8lpNkCWp+saIwqb83YHe9
         Ym8vna87TUn+cy8Q92t+xhGfBF7KdO11vpz6fqt6y891tpP5LWrs5WHEWjp8Swmy9Dw6
         5lAqEdqJvmmHtQUX/J8bgcJqXKDbP5VMAlJxUvAZzvR+7PsdTwnN1tia/X7lTI9mknPv
         vWr+VriSdmCNNL/iNRUYgrqPRHjpvoz90aStFHEw8b2cIZe6SDP4oToOxdP/7sLpcTSk
         KmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695718965; x=1696323765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nn++ZRiERD42GEM7/3lgly/PCrOOcDZOlQaX2n06sSk=;
        b=PmIWtwKy3josOWG7kxP0ZT3hDvBXZ1JR/Qjs2jBr5Ha64r3mE5f/itgpb6M4lLzw2O
         V2aZ7xQVREJUkTGoG9sOG060DGNSftT6cfya4xS+K5tCz3oiClliFnUq2DkLYlhZlkN7
         vxMJ4Yn98H1MXtRfMvlAtLinzLtqRBwlPsI63tRhzKq79we2Y7Ibb8c7qDEBPJScwOQA
         o4fleNait9XiTvG2V1239+aibJ4ttG9ap+aaouwZqkj6gTVzIQqpMo4uh2ZYUAX+xBzr
         2HvUB56g4lxQkJ2y5VLM/7ot4fjwzoCuReL93o4U+1/TEX2d5MbW7CqThbDcC0jgi1YK
         mu4g==
X-Gm-Message-State: AOJu0Yz/28KgPSFfLQf6358KXh8KM6XEHQLQCACwRGy8YMeQt7zCXwt8
        iL0RE4ivMhoIm1Pa2qnr8BysLR1dsk+l8/cr
X-Google-Smtp-Source: AGHT+IEL1RytRunJJQIuk8sJXlSUkD9Ph4F+yAbkA9UsAYJSjuzgheJ8o41wTB1PWuGCk70/2AkANQ==
X-Received: by 2002:a2e:9644:0:b0:2b6:cff1:cd1c with SMTP id z4-20020a2e9644000000b002b6cff1cd1cmr7636370ljh.34.1695718964918;
        Tue, 26 Sep 2023 02:02:44 -0700 (PDT)
Received: from skhimich.dev.yadro.com ([185.15.172.210])
        by smtp.gmail.com with ESMTPSA id l12-20020a2e99cc000000b002bcedacd726sm2604353ljj.25.2023.09.26.02.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 02:02:44 -0700 (PDT)
From:   Sergey Khimich <serghox@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jyan Chou <jyanchou@realtek.com>
Subject: [PATCH v2 1/2] mmc: cqhci: Add cqhci_set_tran_desc() callback
Date:   Tue, 26 Sep 2023 12:02:41 +0300
Message-Id: <20230926090242.105020-2-serghox@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230926090242.105020-1-serghox@gmail.com>
References: <20230926090242.105020-1-serghox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Khimich <serghox@gmail.com>

There are could be specific limitations for some mmc
controllers for preparing and setting cqhci transfer
descriptors. So add callback to allow implement
driver specific function.

Signed-off-by: Sergey Khimich <serghox@gmail.com>
---
 drivers/mmc/host/cqhci-core.c | 5 +++++
 drivers/mmc/host/cqhci.h      | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index b3d7d6d8d654..22be6b0b32ca 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -516,6 +516,11 @@ static int cqhci_prep_tran_desc(struct mmc_request *mrq,
 
 	desc = get_trans_desc(cq_host, tag);
 
+	if (cq_host->ops->prep_tran_desc) {
+		cq_host->ops->prep_tran_desc(data, cq_host, desc, sg_count);
+		return 0;
+	}
+
 	for_each_sg(data->sg, sg, sg_count, i) {
 		addr = sg_dma_address(sg);
 		len = sg_dma_len(sg);
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index 1a12e40a02e6..c473d8994ca4 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -293,6 +293,9 @@ struct cqhci_host_ops {
 	int (*program_key)(struct cqhci_host *cq_host,
 			   const union cqhci_crypto_cfg_entry *cfg, int slot);
 #endif
+	void (*prep_tran_desc)(struct mmc_data *data, struct cqhci_host *cq_host,
+			       u8 *desc, int sg_count);
+
 };
 
 static inline void cqhci_writel(struct cqhci_host *host, u32 val, int reg)
-- 
2.30.2

