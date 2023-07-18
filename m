Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1865C7581AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjGRQHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjGRQHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:07:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A982F1;
        Tue, 18 Jul 2023 09:07:04 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fd32e611e0so5217118e87.0;
        Tue, 18 Jul 2023 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689696422; x=1692288422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WRSmD7p8kvsp7xa4uhAT4iCZu90Kz42k/8LjgP9Kbk=;
        b=MQUxkW5qHcrfmo1oCPvFyde/h/ABI8+EysvW9hs1WZ2Lu0PPMp9ZXeW73kiWnupMBb
         CSxXmS0Mi2P2x1BrSsYvpDd7rTT/KuCy7VtjPhLgoupzK++Gq28fAiblgYA7022di4FF
         V1+Uucnha7RyIyTJhk0dNSbc+j+et6sBqdkPCyLHhWNK7UabQcnVYLId75Kln+cD0CrD
         vOIux3FIwac61j4RJIwrI2YR6b84DEGLcSJ+jsOP2a9XLFFwl8yc6our8w46Kh7ppngL
         p64YTfukK5o+M7J1or/l0oteaim6X+uHA4oTBRS6yCFOORVY/TZIQ475JWPij1gmoB/i
         CFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689696422; x=1692288422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WRSmD7p8kvsp7xa4uhAT4iCZu90Kz42k/8LjgP9Kbk=;
        b=djOZqA70jFz56hnZe8SN1yqTS9z2j96xsBpY6eCAjH/W5OCMhDvjKG+ZFTKyaRtrS6
         Rfrcalw8shb+yZJdQgDmo1omN8gbD/EqIqbAImz2G1L+IJ7BomVTXxI/ByevCscblNyc
         6B/YfRvG72Q4FrVpmcjXgCJHcR3hUd02e1Dgkmu58KX7MNHWGyuLC7u/ayvjUB4hiP2J
         zeUOuYj1qlX3qtuiZrm1Y5oS2KJGPw7jB4gOOu5PtkbGf03UrZRnRsDRPjQbNikjimWf
         mCb73mQTWIbHmZvVxbEC6aeWPpEWHNcx+6EYpgOGpF8ec8gtrkj98eLKWGh/F6Nb7cK1
         EuOA==
X-Gm-Message-State: ABy/qLZv7Uj24vKtEf813VBBVBFBkjXObf/3f8UAYQbThfRLmNNuZIOX
        9o6PMgLB8Xa0QM0PuFjVF80=
X-Google-Smtp-Source: APBJJlGfSw2ZUglSZJ6Wez+cgAdXqbVCaZGFDRFK6PO594dT9Unip9e1T3kGWlhz+2ufMy435M9gsw==
X-Received: by 2002:a05:6512:3d2a:b0:4fb:7d09:ec75 with SMTP id d42-20020a0565123d2a00b004fb7d09ec75mr5949884lfv.4.1689696422069;
        Tue, 18 Jul 2023 09:07:02 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id t14-20020ac24c0e000000b004f86aef886asm502295lfq.54.2023.07.18.09.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 09:07:01 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] nvmem: core: export nvmem device size
Date:   Tue, 18 Jul 2023 18:06:51 +0200
Message-Id: <20230718160652.26756-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230718160652.26756-1-zajec5@gmail.com>
References: <20230718160652.26756-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

Export the size of the nvmem device. NVMEM layout drivers might need it
and might not have access to the device which is registering the NVMEM
device.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/nvmem/core.c           | 13 +++++++++++++
 include/linux/nvmem-consumer.h |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index a0c9153cda28..57ccd4422e01 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -2224,6 +2224,19 @@ const char *nvmem_dev_name(struct nvmem_device *nvmem)
 }
 EXPORT_SYMBOL_GPL(nvmem_dev_name);
 
+/**
+ * nvmem_device_size() - Get the size of a given nvmem device.
+ *
+ * @nvmem: nvmem device.
+ *
+ * Return: size of the nvmem device.
+ */
+size_t nvmem_device_size(struct nvmem_device *nvmem)
+{
+	return nvmem->size;
+}
+EXPORT_SYMBOL_GPL(nvmem_device_size);
+
 static int __init nvmem_init(void)
 {
 	return bus_register(&nvmem_bus_type);
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index fa030d93b768..3270ad81e140 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -77,6 +77,7 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
 			   struct nvmem_cell_info *info, void *buf);
 int nvmem_device_cell_write(struct nvmem_device *nvmem,
 			    struct nvmem_cell_info *info, void *buf);
+size_t nvmem_device_size(struct nvmem_device *nvmem);
 
 const char *nvmem_dev_name(struct nvmem_device *nvmem);
 
@@ -206,6 +207,11 @@ static inline int nvmem_device_write(struct nvmem_device *nvmem,
 	return -EOPNOTSUPP;
 }
 
+static inline size_t nvmem_device_size(struct nvmem_device *nvmem)
+{
+	return 0;
+}
+
 static inline const char *nvmem_dev_name(struct nvmem_device *nvmem)
 {
 	return NULL;
-- 
2.35.3

