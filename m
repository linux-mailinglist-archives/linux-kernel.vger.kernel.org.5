Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03CD7EF2E8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345808AbjKQMoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKQMoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:44:03 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1FFD4E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:44:00 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53e3b8f906fso2856075a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700225038; x=1700829838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kX+3yDbq4orl3F1IwroT1JgXwfqK8BBsS1e+lWobZFk=;
        b=m34NgWD8WoDg9sof7yjQKGHGQctIUJqn0STZgVZzNZUAv98PJ42GPQjymaT3KbHIUm
         p1NiBfCr+tXj9ddZauM4u6oqi2XeGqF74BkOl9CNnbCc5NAtv88KgAIVnZ/PYydNhARw
         1foyshWFc6va457Nqpq1OizG2CAJymMfsS2y8kY4wpu7wT30c/fHO1adYg4JTiuF7DRF
         R92FBh9ckwNq/PYP/qCoM1AH7nZ65jfdXqm299g6kNK46QJS3IHLTpKQ/32txfCdwRfU
         1CkXooCQdlj/n0QgKLyttfapcPgYblWPM3eVQnik9mX5l1io9urvj3GF2sSB7XE5+R0Y
         /Xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700225038; x=1700829838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kX+3yDbq4orl3F1IwroT1JgXwfqK8BBsS1e+lWobZFk=;
        b=cNvgtd2MBfvbXC4uN+81pJEV04H62ZqUtQ4KM5roE5ldGkzgGCGjSOQ7EJL709qAQY
         SDpCYSiNJVyjWXSn6S1UmcVxJMbzQeIUjyf9e6XA0oN/oSi92h8dT/vSsKvj8qtRqAQe
         M3wVMf19Ka30TOD6AnlDcQw+Nx1JBp4s7G0wSEDKnPE2n6cRUPJvYJAfNj0HRYiJqmP9
         Z/o722DRunTXEZ/InfivcOp9SnEtDYqCHXiAhADNnx02brXw7zHy5Oibf/3GNnB2VQ2Y
         fHHQKSHpzVS6ydsiIstxJUpHWqzfZMc8UXcnfGDVmuiL2UD8U8tB1lQDE+Eg/ZMyD29l
         j8iw==
X-Gm-Message-State: AOJu0YwnUnBNQaiUQ4IM2wEgyU+7yKf8MMlvdGYpaIUP/uZeg4wXc/X7
        iX4roYCLbJycgWSE+h8DrPzYMI2SMg4=
X-Google-Smtp-Source: AGHT+IH4SIi6HSZFNp8EGNEs+UR1fOzgICoABAVzD2kE9dET1mwCrSQgwPZC+hpNvPeD9gfWX2DPnQ==
X-Received: by 2002:a05:6402:138f:b0:53e:78ed:924d with SMTP id b15-20020a056402138f00b0053e78ed924dmr13540292edv.5.1700225037520;
        Fri, 17 Nov 2023 04:43:57 -0800 (PST)
Received: from localhost.lan (dsl51B7D2F9.fixip.t-online.hu. [81.183.210.249])
        by smtp.gmail.com with ESMTPSA id d1-20020a05640208c100b0052e1783ab25sm688548edz.70.2023.11.17.04.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 04:43:57 -0800 (PST)
From:   =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= 
        <zboszor@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com,
        =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= 
        <zboszor@gmail.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] egalax_ts_serial: Fix potential buffer overflow
Date:   Fri, 17 Nov 2023 13:43:52 +0100
Message-ID: <20231117124352.275294-1-zboszor@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update my old (defunct) email addresses in passing.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311171716.uIQY5rT4-lkp@intel.com/
Signed-off-by: Zoltán Böszörményi <zboszor@gmail.com>
---
 CREDITS                                      | 3 ++-
 drivers/input/touchscreen/egalax_ts_serial.c | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/CREDITS b/CREDITS
index f33a33fd2371..5efccb40d577 100644
--- a/CREDITS
+++ b/CREDITS
@@ -470,8 +470,9 @@ S: Montreal, Quebec
 S: Canada
 
 N: Zoltán Böszörményi
-E: zboszor@mail.externet.hu
+E: zboszor@gmail.com
 D: MTRR emulation with Cyrix style ARR registers, Athlon MTRR support
+D: eGalax serial touchscreen support
 
 N: John Boyd
 E: boyd@cis.ohio-state.edu
diff --git a/drivers/input/touchscreen/egalax_ts_serial.c b/drivers/input/touchscreen/egalax_ts_serial.c
index 375922d3a6d1..f8b56896a42f 100644
--- a/drivers/input/touchscreen/egalax_ts_serial.c
+++ b/drivers/input/touchscreen/egalax_ts_serial.c
@@ -2,7 +2,7 @@
 /*
  * EETI Egalax serial touchscreen driver
  *
- * Copyright (c) 2015 Zoltán Böszörményi <zboszor@pr.hu>
+ * Copyright (c) 2015 Zoltán Böszörményi <zboszor@gmail.com>
  *
  * based on the
  *
@@ -42,7 +42,7 @@ struct egalax {
 	struct serio *serio;
 	int idx;
 	u8 data[EGALAX_FORMAT_MAX_LENGTH];
-	char phys[32];
+	char phys[NAME_MAX];
 };
 
 static void egalax_process_data(struct egalax *egalax)
@@ -185,6 +185,6 @@ static struct serio_driver egalax_drv = {
 };
 module_serio_driver(egalax_drv);
 
-MODULE_AUTHOR("Zoltán Böszörményi <zboszor@pr.hu>");
+MODULE_AUTHOR("Zoltán Böszörményi <zboszor@gmail.com>");
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL v2");
-- 
2.42.0

