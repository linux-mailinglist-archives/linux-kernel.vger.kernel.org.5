Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAF2793D70
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbjIFNJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjIFNJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:09:37 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8811CC7;
        Wed,  6 Sep 2023 06:09:33 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-58d40c2debeso37340257b3.2;
        Wed, 06 Sep 2023 06:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694005773; x=1694610573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CAyQb31ZOquKpS0Y725HKMrdQYsz3CUi+B2ONiW/IkI=;
        b=AtwBWYIPXPDSXXDZ399tmVWhueSsOGhVLbaq/3k86kfwSUNxUHTCUcQZMwCV/tC1vC
         H/KuZroMd1wHPUVlupVfDwx1KrmUhKfjo05K4ETJCSVy7a/FCqPcwRF+vQ96McmGfrmZ
         /1TqjFxka1BONKBnDmLythh4APj7fx3mLH0BP7LS2cOde5syE5xIphpGRoAoZjvLsSch
         uuG+TpbQX15RusZ06sxfEc87lOpRIiWpL9GnCkBdjFuVJhNHaqHkUJSfKXm2h1pWXNLh
         clfNVXvBGblLnlw5/rlIBe+sqE4FduAPPn71VKw8hJXEJHm9H2ZMf64Fo6VJMNlIQgeb
         M5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694005773; x=1694610573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAyQb31ZOquKpS0Y725HKMrdQYsz3CUi+B2ONiW/IkI=;
        b=IUBFqX+Fj79qEazHwCqrxPQhv6S+TTAhbVtiziv0xbOJAC0m9bsfz/k4YdQQyhijIU
         qyKXYYe4Nxnj80BqNBz8POvFjwF9WGSivXhTefD9rpSyGLNCeKpg13lbHCaFYr3SCqlS
         6hbzqIEiJT4Ren+4eENwTAXPMi7JarSJypQriMmwLN9K9Rs8YSZPgGWqoci1YXeFRHTg
         VuG25YXF747gSAHndikiCu5e2SSMUmq+4gO/mFV1PgJvNRIS+brwiuqACBSvnVRsCE/1
         zOWB3+VN0wEy25+5tN1tnXv6CbY/BJfDoOeNRQy4semh9ftBuc4g5X6WRD6U2zp18K+E
         sy8Q==
X-Gm-Message-State: AOJu0YyANO9r4cT7h3LIQe8MJml2gAPFZRbTgna3OOTVx2cdMkZuohdW
        sP+37KN/0lBSL5ShayklEx8=
X-Google-Smtp-Source: AGHT+IGMt2p4BJ+DQYadLbF1OoWkPAIPLEtqmRo5u3rXm7uy7TEm7oKoaIN6yHfsQo1sXJf0xGOVfg==
X-Received: by 2002:a0d:ca87:0:b0:589:fc81:952e with SMTP id m129-20020a0dca87000000b00589fc81952emr16525941ywd.7.1694005772873;
        Wed, 06 Sep 2023 06:09:32 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-58-71-148.us-east-2.compute.amazonaws.com. [13.58.71.148])
        by smtp.gmail.com with ESMTPSA id t198-20020a8178cf000000b00592548b2c47sm1204458ywc.80.2023.09.06.06.09.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Sep 2023 06:09:32 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     lenb@kernel.org, james.morse@arm.com
Cc:     rafael@kernel.org, xueshuai@linux.alibaba.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Schspa Shi <schspa@gmail.com>
Subject: [PATCH] ARM: SDEI: allow sdei initialization even no APCI support
Date:   Wed,  6 Sep 2023 21:09:00 +0800
Message-Id: <20230906130900.12218-1-schspa@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
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

The initialization of SDEI is forcibly bound by ACPI. This Patch allows to
continue to support the initialization of SDEI without starting ACPI.

Fixes: dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in apci_init()")
Cc: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/acpi/bus.c          | 1 +
 drivers/firmware/arm_sdei.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 2fc2b43a4ed3..d78615080502 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1368,6 +1368,7 @@ static int __init acpi_init(void)
 	int result;
 
 	if (acpi_disabled) {
+		acpi_ghes_init();
 		pr_info("Interpreter disabled.\n");
 		return -ENODEV;
 	}
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index f9040bd61081..5ab70107c8bf 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1081,6 +1081,10 @@ void __init sdei_init(void)
 	}
 }
 
+#ifndef CONFIG_ACPI
+subsys_initcall_sync(sdei_init);
+#endif
+
 int sdei_event_handler(struct pt_regs *regs,
 		       struct sdei_registered_event *arg)
 {
-- 
2.39.2 (Apple Git-143)

