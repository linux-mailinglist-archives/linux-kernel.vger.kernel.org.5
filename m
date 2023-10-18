Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8617CDC09
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjJRMk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjJRMkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:40:23 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387B6116
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:40:22 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b20a48522fso4385971b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697632821; x=1698237621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgXGiaZbK4m4HiMVh4BDyfHZ4ZNWdeAQabBtO14MLJk=;
        b=TVGXfpilDcoTQyjcyxM4vGOMfK6awfsLvj+WpPGp0FQp/Z+prg8AehGJc8slm2Lz3o
         gWXch3bUg2KcUuFeX1kSPtODJcrWVAhrOk6G6JG+C8rZIFd1is8O4zsFMOMYV7MlKf1O
         HNT4d6U/PqZIcM9kV3KEuxFF2xRXJJ9cRB5FvWpKC3194UjbUCO7XC++Oll8622+tNWO
         BkQh3bIR7KwR/G9M0a/UztF/zVzBQx6f/bFcLl8YhXreyl4t6LHBLzwhBId4m+0VGZuD
         hYA2VXs1h9oxJe5YZscAJlZ5skygD3yGeKN4SzJKhe9GqE3VJftNmPbk/SuEaH/Tjy2k
         hwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632821; x=1698237621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgXGiaZbK4m4HiMVh4BDyfHZ4ZNWdeAQabBtO14MLJk=;
        b=su7tf71Q+B+3AigrHBB7vNZj0UR/jlhUH3HV/qi1KeXUQ7hg/2VVr55cdUPQxTPtLx
         JZiyPojHZe5tpLvPKUdk11nH41w2XMk4Pch3TZ/Ssj5KQ03bv+QAQdTcHYWrz1KortPf
         YI94I5g/WpDjt2QuHae8ikRqqEkAYrukx6Lkoq2SPmhH+8EYfwYsmArAy2OhTdbCiht8
         5z/BsOXNvm57EDVQLFxy2iYdZJyfJ+cTGINWsBksyeFZ90sQfooBloMZ/Mq0gKHCfklD
         tpe3TItc+LpOWsTr8gPoa+EPMxN9gyWwU82i1KYUTvLChmmMTGsRD/Wl0WJSlCQY5NYx
         9a4g==
X-Gm-Message-State: AOJu0Yx0rsJMIE0tsOCXcxRbkRIosTBYV/LYsCjiX1kIv3DvygL4YF8N
        asc0ve329p76uWcx+WuLKemWVw==
X-Google-Smtp-Source: AGHT+IEOXc4ISTOwIN0PYiJxHemUpiZ9Jnc0yw5gquloNFV4Vfe1Ujo1EM5hhYV3wl/HOMx/JfHSfA==
X-Received: by 2002:a05:6a00:24d4:b0:692:b6e8:ce88 with SMTP id d20-20020a056a0024d400b00692b6e8ce88mr5494314pfv.17.1697632821422;
        Wed, 18 Oct 2023 05:40:21 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id w190-20020a6382c7000000b005891f3af36asm1599267pgd.87.2023.10.18.05.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:40:21 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v4 -next 2/4] RISC-V: ACPI: Update the return value of acpi_get_rhct()
Date:   Wed, 18 Oct 2023 18:10:05 +0530
Message-Id: <20231018124007.1306159-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231018124007.1306159-1-sunilvl@ventanamicro.com>
References: <20231018124007.1306159-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_get_rhct() currently returns pointer to acpi_table_header
structure. But since this is specific to RHCT, return pointer to
acpi_table_rhct structure itself.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/rhct.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/riscv/rhct.c b/drivers/acpi/riscv/rhct.c
index b280b3e9c7d9..489b0e93b1e5 100644
--- a/drivers/acpi/riscv/rhct.c
+++ b/drivers/acpi/riscv/rhct.c
@@ -9,7 +9,7 @@
 
 #include <linux/acpi.h>
 
-static struct acpi_table_header *acpi_get_rhct(void)
+static struct acpi_table_rhct *acpi_get_rhct(void)
 {
 	static struct acpi_table_header *rhct;
 	acpi_status status;
@@ -26,7 +26,7 @@ static struct acpi_table_header *acpi_get_rhct(void)
 		}
 	}
 
-	return rhct;
+	return (struct acpi_table_rhct *)rhct;
 }
 
 /*
@@ -48,7 +48,7 @@ int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const
 	BUG_ON(acpi_disabled);
 
 	if (!table) {
-		rhct = (struct acpi_table_rhct *)acpi_get_rhct();
+		rhct = acpi_get_rhct();
 		if (!rhct)
 			return -ENOENT;
 	} else {
-- 
2.39.2

