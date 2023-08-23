Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6424F78595B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbjHWN3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236009AbjHWN3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:29:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E23910D1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a1681fa868so681660866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797300; x=1693402100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aU/jN/gUmDvHcV1DoQ8MQToLmzhYPjxk4jpbikZ/Pkk=;
        b=mcqE2esP88tNqVvCw8RQu1jZY/eVNvIC+ASFgId3W7vxxxbEzROVQCmBoKGAdfIgLj
         y5jZ0amVqh1THiEhjcWJttuDEbdvZmwXdENgWFR1fDh1wvqDRCRs8wX+D0gX4dG8bhl4
         o32q62EpCmaQWcNyFgr8RaQFm+2oRMzBMoPBeCAFl18R3q1f+yaxnKoye+bIbaiJY7sq
         Jno98rK81/Pnf7InY2bfEiS0xGVUgKN30F+tEMFNfVBY4MVNUNnkDCNYhTp2sZEP4l+5
         xriNcRESHzLOmaXUmi+whY2A9+0Qt0iupdSFDROlmOS1i3M4J3BowdAQ8mhMS/rvK2y8
         wg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797300; x=1693402100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU/jN/gUmDvHcV1DoQ8MQToLmzhYPjxk4jpbikZ/Pkk=;
        b=AOVKRHT7cMmtyVw0MiPSxCqoYUtb/KzxZs73VH/gqgplF5mhmLHuxg5Vx1E+8ETbk6
         BsomC3q80/Bqcb18yI9Nb44SCE5a6DS5cNNOTqEcNb78j9xLGyPZ2JcZJ+ojUWgpxt0w
         HSZtdamoEEf7ogrt/wu+Oycct1yuBICZ38hB7IpWRQN6aA8dOfEKx6ASJGXZ+HU0oawJ
         MqPJzAfqY+TJdch7v2gCbOVPMiylbDqxffMqCQNtRBviPkBQGbeP8ZLU05osglnerkT3
         fjei7Y9O9HkkQVFi7lCerplHwW0aytIwl6ClZF5PvxLBJ5VQRHaS1wTH/QkLP6jW80sg
         8ymg==
X-Gm-Message-State: AOJu0Yx5y3GFWlf3Jv14DnU4IGWhR491zBEWzMX4IoHon5mNGj/eD8LS
        Kn8e31j6w1sRdywrxvBFR6JMlg==
X-Google-Smtp-Source: AGHT+IHC6QYukbYBnpHVQP3coxh3hZKuxiWneph63xKnNc774/tspDC9dHugVPjmbMXzvE/dWHgdPw==
X-Received: by 2002:a17:906:8b:b0:99e:4c6:f145 with SMTP id 11-20020a170906008b00b0099e04c6f145mr11073651ejc.68.1692797300614;
        Wed, 23 Aug 2023 06:28:20 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:28:20 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 22/22] nvmem: core: Notify when a new layout is registered
Date:   Wed, 23 Aug 2023 14:27:44 +0100
Message-Id: <20230823132744.350618-23-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=uwi4xazrhs3L1yA5RUevG4/xy0JpSYqaa1pU9VIbPWI=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glKdAHK0B/K1h0fCXhTE7NQsMLZ+ldAgsRV9 TL7qu0MRFiJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJSgAKCRB6of1ZxzRV N7K7CACRwzDbLG1ru0oUDAv4xageX3EV0H6jqrIj+MbGST6+z7SZ9pfU/x/jf4uPbWqZRBZd/gv S57EyoUmFrbikRncriDq8cBhu0VcvEPPra66FMIO2qVwQ6D1s5Aw6aJCHGzLhN7px52OT25bqK1 tuc7tSpwXNaF2Lf2R2PjyNo9Z1V7C04zbrHJX1DvqWYz0xjtmvoE5X86X/K/IRhrERPEe3PjVFh 4U7OXdLnU76hwU9QmqnsWvpzh0Iyl619ejVnzdWga0nLMhJupl2H1H/pFVcajFuei1zHKQQHGoL bEVHE26LZZvtdPcoHr3IFH7AGSndX6HSUC8iuXsjJXvA8Eu5
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

Tell listeners a new layout was introduced and is now available.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 4 ++++
 include/linux/nvmem-consumer.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 12d05aea0b41..eaf6a3fe8ca6 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -771,12 +771,16 @@ int __nvmem_layout_register(struct nvmem_layout *layout, struct module *owner)
 	list_add(&layout->node, &nvmem_layouts);
 	spin_unlock(&nvmem_layout_lock);
 
+	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_LAYOUT_ADD, layout);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__nvmem_layout_register);
 
 void nvmem_layout_unregister(struct nvmem_layout *layout)
 {
+	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_LAYOUT_REMOVE, layout);
+
 	spin_lock(&nvmem_layout_lock);
 	list_del(&layout->node);
 	spin_unlock(&nvmem_layout_lock);
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 27373024856d..4523e4e83319 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -43,6 +43,8 @@ enum {
 	NVMEM_REMOVE,
 	NVMEM_CELL_ADD,
 	NVMEM_CELL_REMOVE,
+	NVMEM_LAYOUT_ADD,
+	NVMEM_LAYOUT_REMOVE,
 };
 
 #if IS_ENABLED(CONFIG_NVMEM)
-- 
2.25.1

