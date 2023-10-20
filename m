Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A2E7D0DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377097AbjJTK4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377029AbjJTK4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:56:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DAD1BF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:56:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4083cd39188so5266025e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697799366; x=1698404166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s017N3BrJjBNK8mTEZrl4VDzs9lvd3L6fzapY0bnHq4=;
        b=bIvkIReWwYkdI6ePjDZg8qsHH+Cn7c2Boi90vg585ZNT5b6c1u2VMAA7k1lfGHEkrw
         mMrcmN5HG6fqx4WnOF7bB/9ekGSRVB6jcPvPGnty9L7eONq6XUos6+SrmDHLyJvMrOXr
         F2tY8L/1TfnBTp29aBzxIAYVdBSvwPDUDcT1TR0onXmHMBXZeFBjVZdKpudjIk5iJOBU
         FMhqvsaYxLw78ZQt13GsQdI7O4VQKZPfBuJ3bZ8wj0eeJ5pP8/EUEPjeAp24Fsizu8of
         Xqh62zi2W2F0eR6okQTxbOipQStrul/jexQHXx1O1o5xuCxc7ANyY2QeO5dD6vAxtYNy
         eBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697799366; x=1698404166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s017N3BrJjBNK8mTEZrl4VDzs9lvd3L6fzapY0bnHq4=;
        b=orUbGfjMf3ovCr2B8/S5zDRFLRPph2DXVOd+NTpP7wzJV8tKHbYJRmYKC2Rzsp7HBq
         oLcv9NykBYNO6jxwhMeOKpvnW38NbM9+vvyQir8Cs4sicpETBAvBJtGUMJ+ql6nfw3mW
         9FcyrSAGZj+AWFzhjUCB12kHFmPKqk+jzDV+2Zi2VdpWiv9OU9Cpfk8w9JJBkIK+EI+l
         yMOliemu3JhGaiySZgjSYTvkJuEccjeZutj/94BmuoiMRqER1ZHUzWS8CKwvBxx9zYMI
         G++Y7i6vciZ5Z3Vgn2epDZKRfYi/8TSh7xRM2KGYMUHWolA3kmL1qbztJwzYitOUqhPb
         vYZw==
X-Gm-Message-State: AOJu0YzjlNiuf1zqIw7QZk6ns2GuOKInlw7yxfo6A9cNJApmmf3ilbMA
        GKeo1Ot2qhgRw6WzlqarOvQS4c1SFVhjAm3EmQ4=
X-Google-Smtp-Source: AGHT+IE1Wooh/5tCSbf8CjhkPVDYNbDy9NbDsdkFap9IEltOXISDTtgc0mFAYumaaBF94N63rvuYiQ==
X-Received: by 2002:a05:600c:4ece:b0:408:3ab3:a05e with SMTP id g14-20020a05600c4ece00b004083ab3a05emr1195244wmq.38.1697799366002;
        Fri, 20 Oct 2023 03:56:06 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id x9-20020a05600c420900b004065e235417sm6578937wmh.21.2023.10.20.03.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:56:05 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/6] Revert "nvmem: add new config option"
Date:   Fri, 20 Oct 2023 11:55:43 +0100
Message-Id: <20231020105545.216052-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231020105545.216052-1-srinivas.kandagatla@linaro.org>
References: <20231020105545.216052-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This reverts commit 517f14d9cf3533d5ab4fded195ab6f80a92e378f.

It seems that "no_of_node" config option was added to help mtd's case.

DT nodes of MTD partitions (that are also NVMEM devices) may contain
subnodes that SHOULD NOT be treated as NVMEM fixed cells. To prevent
NVMEM core code from parsing them "no_of_node" was set to true and that
made for_each_child_of_node() in NVMEM a no-op.

With the introduction of "add_legacy_fixed_of_cells" config option
things got more explicit. MTD subsystem simply tells NVMEM when to look
for fixed cells and there is no need to hack "of_node" pointer anymore.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mtd/mtdcore.c          | 1 -
 drivers/nvmem/core.c           | 2 +-
 include/linux/nvmem-provider.h | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index fbf60d1364f0..74dd1b74008d 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -560,7 +560,6 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 	config.read_only = true;
 	config.root_only = true;
 	config.ignore_wp = true;
-	config.no_of_node = !of_device_is_compatible(node, "nvmem-cells");
 	config.priv = mtd;
 
 	mtd->nvmem = nvmem_register(&config);
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 2710943f53c4..bf42b7e826db 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -935,7 +935,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->nkeepout = config->nkeepout;
 	if (config->of_node)
 		nvmem->dev.of_node = config->of_node;
-	else if (!config->no_of_node)
+	else
 		nvmem->dev.of_node = config->dev->of_node;
 
 	switch (config->id) {
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 1b81adebdb8b..e3930835235b 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -89,7 +89,6 @@ struct nvmem_cell_info {
  * @read_only:	Device is read-only.
  * @root_only:	Device is accessibly to root only.
  * @of_node:	If given, this will be used instead of the parent's of_node.
- * @no_of_node:	Device should not use the parent's of_node even if it's !NULL.
  * @reg_read:	Callback to read data.
  * @reg_write:	Callback to write data.
  * @size:	Device size.
@@ -122,7 +121,6 @@ struct nvmem_config {
 	bool			ignore_wp;
 	struct nvmem_layout	*layout;
 	struct device_node	*of_node;
-	bool			no_of_node;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
 	int	size;
-- 
2.25.1

