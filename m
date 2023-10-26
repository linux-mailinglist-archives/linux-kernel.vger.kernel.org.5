Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436C07D7A10
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjJZBU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZBUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:20:25 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B42CC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:20:20 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ca72f8ff3aso2646695ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698283220; x=1698888020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PmRrkZ15lkbJoZUemYsPfR2kJiWVaXMup1NLxDeednM=;
        b=jIJrdTux+uz7WLmrWCrSQRzufI7eTaoEmfq/fWQmNdbMd6d+oP7Ol7sRKRpZ7mnrlj
         aXmweBwZ93QaFNiLTLiGsFPYnnpTLzV3DFaPIn3pKnNwbiAbWMgt4FNh2lXIn6anfaum
         Ktj2uNwuEiMR56TV5no5ZjNWvLMlOE2alXjbFyPpYQe91nNjTTYBQhJ2A/OunF/3sksF
         zz80CIT1ET3ZQ+zmKNvqiowPxOSCbkSBvebcCJmiwK+W0daTnsIQcAht3P3tRBif9NxP
         zjBJ5+lVLz5vAxN9qIx8igqBbVa8+UPAUGXJ8rBHQItsVlVUvneuC3XWoa/yOMfsOgrA
         RPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698283220; x=1698888020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmRrkZ15lkbJoZUemYsPfR2kJiWVaXMup1NLxDeednM=;
        b=VhYKPjRAD2I1rKhbxLVV2fmC802cglzVkzupGJM+HTFjqBsW5OHK5ir03VC5bjXo2d
         LECQbq1IvUzMBsZal2USOpQm7hlVF9DrHYoynhYJeqT+/8XLn4fFVoejeaAlVXj2TwUi
         qWj1iOJFuoQIgijUa09JRq70tHMW09GVc0kSgm3NqGhKpEydl2ED8vxQkfC7eAqfvGIE
         mi7c/lt0q7trQ+DJ1nYU2H3O6YNKb/2Lq6J1I9KPspvclwIon8CkJCTpP+tdcpy3Zij5
         LJYKcdnKU3PlnPRAFL+KHykTCX9nCkCu2LsmlWx8KTZ7IPqD9ZdQe7NUStYG9jkiNSNU
         uuKg==
X-Gm-Message-State: AOJu0YyHhq5ulmFQbobVsmUk/E2kwZXlQdokvZJPCbVBcj3JGPLVGKwX
        OtSl+xySmuClRttzczrDxkY=
X-Google-Smtp-Source: AGHT+IHH9nUNlfNW4sc+uxwQ9e6vxbK8ETxv+grb9f43DKtYOdLJ/LFZS9Vkvy6sbRddhqDBh1xjHA==
X-Received: by 2002:a17:902:cf4f:b0:1ca:64f:35ff with SMTP id e15-20020a170902cf4f00b001ca064f35ffmr14180050plg.48.1698283220020;
        Wed, 25 Oct 2023 18:20:20 -0700 (PDT)
Received: from localhost (211-75-139-217.hinet-ip.hinet.net. [211.75.139.217])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902ed8c00b001c60c8d6b4asm9884343plj.149.2023.10.25.18.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 18:20:19 -0700 (PDT)
Sender: AceLan Kao <acelan@gmail.com>
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] mtd: spi-nor: Improve reporting for software reset failures
Date:   Thu, 26 Oct 2023 09:20:17 +0800
Message-Id: <20231026012017.518610-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>

When the software reset command isn't supported, we now report it
as an informational message(dev_info) instead of a warning(dev_warn).
This adjustment helps avoid unnecessary alarm and confusion regarding
software reset capabilities.

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
v2. only lower the priority for the not supported failure
v3. replace ENOTSUPP with EOPNOTSUPP and check the first command only
v4. move the version information below the '---' line
---
 drivers/mtd/spi-nor/core.c | 5 ++++-
 drivers/spi/spi-mem.c      | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 1b0c6770c14e..42e52af76289 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3252,7 +3252,10 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
 
 	ret = spi_mem_exec_op(nor->spimem, &op);
 	if (ret) {
-		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
+		if (ret == -EOPNOTSUPP)
+			dev_info(nor->dev, "Software reset enable command doesn't support: %d\n", ret);
+		else
+			dev_warn(nor->dev, "Software reset failed: %d\n", ret);
 		return;
 	}
 
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index edd7430d4c05..93b77ac0b798 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -323,7 +323,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		return ret;
 
 	if (!spi_mem_internal_supports_op(mem, op))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (ctlr->mem_ops && ctlr->mem_ops->exec_op && !spi_get_csgpiod(mem->spi, 0)) {
 		ret = spi_mem_access_start(mem);
-- 
2.34.1

