Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AA17B516B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbjJBLdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbjJBLdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:33:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E11C4;
        Mon,  2 Oct 2023 04:33:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50337b43ee6so26053528e87.3;
        Mon, 02 Oct 2023 04:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696246386; x=1696851186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9FNeO5w1b2IfrE+lWZ3hCtWJrIUEHfJtg3Wgmhd99w=;
        b=Jr8Yg1m3fGHsYeS6pObwTT1lPnJd7Ef9GqhB2bxMxvgF/JycH//S295QF+aU/M2wPC
         X/9fezLWnsqGT1e8EPvOBYX5bDQjzwOb/YspNkcbDucUoqVujFhuKU5v879rEeJ0C73Z
         AbER8UcIVCjvPCapd9I7ePPIpmyzqXnCPI/pB40aroinpAhlEaoNBZ5de6/mODp+PIfo
         zjTkZuTZ2UNSa08cUMzkYP1/lTzF6oAIbzroxEfEMDX3OYshOkgw6xHGZC54RjqPYwLf
         plH5MZMW7dTVVArP4Vozfapxy1pR7+DQfNEi9UgMxRgL/eayIw8SJw7chlk3PvDBT53P
         afww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696246386; x=1696851186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9FNeO5w1b2IfrE+lWZ3hCtWJrIUEHfJtg3Wgmhd99w=;
        b=Jb4s7yxTLb7zzgn6gp4Kesc8SvDo8+IHfPDIEg9Hj/zuYv69EqrHAa/rRUzjq/ITV9
         5dNK5Ly2uv6+nvrNpUhwB28d6X92r0shDC/E7PejxwCzMagsumz6BGU8DpSAEOXNkgb3
         OHTnca8sMQQJnDb6wmgvc+Y7mjtTtxHQtl10mrMEbXEiAYIxCgaSttT7P3PNZmoKJJN0
         uOGd0fZ6Q4u2nRqSH7p2AH1zVNANeqxkHrr67rH8fzbGtTaWASrhKFllKkWM2QGVF/Rt
         j9WP/LNWw6CnP+BmIh483QsJg0spKMmNqeFaIjMkJDwjA51/E2FSJqOV8oZNT49z+eMq
         0ibw==
X-Gm-Message-State: AOJu0YxVkKyh72/ZG97LpWCjrhkgxz3Kd19VBLUY57nxQadFQkCMPFkE
        stOedaH3tq3KmPdbJFyQdryRAH4zgCO8DRlypq0=
X-Google-Smtp-Source: AGHT+IHc7Y5oaSzpiZOzB5sOHxNylhxFGlc0IsfkMQ9xF9x0VJRZfe9lhfpwn+Wp4r0B2DgBCE8ytw==
X-Received: by 2002:a05:6512:b86:b0:501:a5de:afed with SMTP id b6-20020a0565120b8600b00501a5deafedmr12193166lfv.37.1696246386060;
        Mon, 02 Oct 2023 04:33:06 -0700 (PDT)
Received: from skhimich.dev.yadro.com ([185.15.172.210])
        by smtp.gmail.com with ESMTPSA id i26-20020ac2523a000000b005041cc98273sm4715055lfl.300.2023.10.02.04.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 04:33:05 -0700 (PDT)
From:   Sergey Khimich <serghox@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jyan Chou <jyanchou@realtek.com>
Subject: [PATCH v3 1/2] mmc: cqhci: Add cqhci_set_tran_desc() callback
Date:   Mon,  2 Oct 2023 14:33:00 +0300
Message-Id: <20231002113301.1531717-2-serghox@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231002113301.1531717-1-serghox@gmail.com>
References: <20231002113301.1531717-1-serghox@gmail.com>
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

From: Sergey Khimich <serghox@gmail.com>

There are could be specific limitations for some mmc
controllers for preparing and setting cqhci transfer
descriptors. So add callback to allow implement
driver specific function.

Signed-off-by: Sergey Khimich <serghox@gmail.com>
---
 drivers/mmc/host/cqhci-core.c | 5 +++++
 drivers/mmc/host/cqhci.h      | 4 ++++
 2 files changed, 9 insertions(+)

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
index 1a12e40a02e6..868822292ce6 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -217,6 +217,7 @@ struct cqhci_host_ops;
 struct mmc_host;
 struct mmc_request;
 struct cqhci_slot;
+struct mmc_data;
 
 struct cqhci_host {
 	const struct cqhci_host_ops *ops;
@@ -293,6 +294,9 @@ struct cqhci_host_ops {
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

