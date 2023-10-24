Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207F47D53B6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343623AbjJXOO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343518AbjJXOOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:14:25 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5712DC4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:14:23 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b512dd7d5bso454747b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698156862; x=1698761662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=scCY6Z97zhmNP1gAoFGdRujC/I+uoKWN9MG2mo0gcTs=;
        b=iQh0FwQlMa87RELBXsNWCfDI3b2MGNPOe73mEkNZpz9fz2kQp+lJVOjgkfGZ9t8ve0
         rE21QNzM9UIS+7IdD84dW9d9cMgMrNFAJMk/Zv6a4NicM9T+K8bED20twNghv6azdzoB
         f2oLvj7bzm+g5GMafulru3VPe7B55rMGOmyNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698156862; x=1698761662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=scCY6Z97zhmNP1gAoFGdRujC/I+uoKWN9MG2mo0gcTs=;
        b=GQUSKBMK42k2j1q9RyjdhrDlMCoqSS1uHLJkOjSkYHhC1mfox5JmkbdwKPIwIvqCFw
         rDRGCcbTsQt9vorjbUfJcED4EVFU3w2Bvzj9fBy2STNh2G6TlhqDOpHzfnGw2B7kugYP
         fVVYVRSe7nmQS0wE5FlV6Z9e/jihIN9vve65Q1MJf3VLtpLDgR6EdE49rgtMnytaOj5V
         +vOEkYhQv/Eg1WYkGB581MKTEWJYU2USJZcI248Xnv8knZbeO2FbY5EVaaY+fYLz6omG
         2SCahsEKB9QNwI9zahUXzyXif30IPnNMNv7LEHVe9K+79yJS3eYBOXwEmV2uIQ6JACM5
         xD6w==
X-Gm-Message-State: AOJu0YwjKamcYGHuFPx+ThLryOVbThJ80Z4kroqNoMelww7YUOgDYUCL
        7CObt2XXmitelvTGdsuSyH4T2dW/VnVycTbe2W4=
X-Google-Smtp-Source: AGHT+IGpC/t6xxkJj/reT4dvsvDu+Vx92dgL9E2tM2g9pdt3DgoDM4cfSf2pbaCWkKKxb14LJz1dpg==
X-Received: by 2002:a05:6808:152a:b0:3b2:e48d:97bd with SMTP id u42-20020a056808152a00b003b2e48d97bdmr16779320oiw.23.1698156862206;
        Tue, 24 Oct 2023 07:14:22 -0700 (PDT)
Received: from jdenose34.roam.corp.google.com (99-137-158-190.lightspeed.cicril.sbcglobal.net. [99.137.158.190])
        by smtp.gmail.com with ESMTPSA id bx20-20020a0568081b1400b003af60f06629sm1948590oib.6.2023.10.24.07.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 07:14:21 -0700 (PDT)
From:   Jonathan Denose <jdenose@chromium.org>
X-Google-Original-From: Jonathan Denose <jdenose@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-acpi@vger.kernel.org, Jonathan Denose <jdenose@google.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] ACPI: EC: Add quirk for HP 250 G7 Notebook PC
Date:   Tue, 24 Oct 2023 09:13:36 -0500
Message-ID: <20231024091336.1.Ie25ddf26b761bf185b7152c6a9884977f0ce73f9@changeid>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added GPE quirk entry for HP 250 G7 Notebook PC. This change
allows the lid switch to be identified as the lid switch and not
a keyboard button. With the lid switch properly identified, the
device triggers suspend correctly on lid close.

Signed-off-by: Jonathan Denose <jdenose@google.com>
---

 drivers/acpi/ec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index c95d0edb0be9e..a59c11df73754 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1924,6 +1924,16 @@ static const struct dmi_system_id ec_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Gaming Laptop 15-dk1xxx"),
 		},
 	},
+	{
+		/*
+		 * HP 250 G7 Notebook PC
+		 */
+		.callback = ec_honor_dsdt_gpe,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP 250 G7 Notebook PC"),
+		},
+	},
 	{
 		/*
 		 * Samsung hardware
-- 
2.42.0.758.gaed0368e0e-goog

