Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB297D7453
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjJYTaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjJYTaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:30:22 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7CC137;
        Wed, 25 Oct 2023 12:30:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-408382da7f0so872525e9.0;
        Wed, 25 Oct 2023 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698262219; x=1698867019; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=38LmIm3WWmTeISnemF0NvIfw6jlThfIqPKHIQvM/85M=;
        b=UwC6+ZBbztlonU7HOQN2OKVdPdQ+KflQa+q14nuZITX8ph4kLsU2gNBLnwN+sUv/dy
         19Zp+zXAFOxkLrYX3NUMrxHBEWWl78eQXcNoxxTnDq7EL05cNyJOUqHmLJoefFHTXO6o
         9+EmOs2VEJNReBkwfgpViNRx8wZ2Fyivzj4EG60ohF6c0ZKQxpO99Y56bAG+3N/unc0P
         4sCprr5QFS/75tUL8N5xOl6ZV2zFKhkCLlrMjTmZ8pF1CwXsN3elfwPu+cmSHr/7hCMF
         +aSbxVM7NiFXXAagQMno9VoTigmcLIriKd0aUCkfifrG2ybazacv/eDgn1xagUWA5BDb
         A4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698262219; x=1698867019;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38LmIm3WWmTeISnemF0NvIfw6jlThfIqPKHIQvM/85M=;
        b=VTmNdGOPvtePaEoHOb5Sb92Gc17IJct3XudkzZyO5NG4UPua/qmjSZa6j/uN2uZDb+
         ApOFlr8tORACX4fKQ6VQh3LBbiPf0ztjZal+EvjwFhwqAAy6HDj4MRvQiaTPN/9vMkKb
         qXJ4ILqDk1700m1X7WACrN3XXcWc+VV2TjMtlH4LC/rHwNPBJpIEk5gHkvOw7L/yoBEK
         zQ0f/+eUNMqsavyoljfR3PK0mFbuJRfdSH5IjZ2sGaIRWK/tQtSuoMKxOctr93axLa/E
         lklMz74O3nH+fD5LPinR1KHpoXjH4EVE7HcRLr55JEpTjsPt7c73LJq+9HTz/HYKA9xM
         wClg==
X-Gm-Message-State: AOJu0YwwX2xOcwNIihGCYTIm0+/VItP/teUoFFpSUh1MY+YbbeDxl/qz
        zVjwFn2YZqFkGhhreI/pb2c=
X-Google-Smtp-Source: AGHT+IGwti76O2zJQVpT+QX8wGpjB9FrDEpoR6HJyduUUaglRCBVfwBNMsGyJVMwrl0TNVfqURn9QA==
X-Received: by 2002:adf:e742:0:b0:32d:bbed:a08e with SMTP id c2-20020adfe742000000b0032dbbeda08emr13973322wrn.70.1698262218948;
        Wed, 25 Oct 2023 12:30:18 -0700 (PDT)
Received: from localhost ([2001:171b:c9bb:4130:c056:27ff:fec4:81cb])
        by smtp.gmail.com with ESMTPSA id g18-20020adfa492000000b003232380ffd5sm12702536wrb.106.2023.10.25.12.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 12:30:18 -0700 (PDT)
Received: from localhost (localhost [local])
        by localhost (OpenSMTPD) with ESMTPA id 258966bb;
        Wed, 25 Oct 2023 19:30:16 +0000 (UTC)
Date:   Wed, 25 Oct 2023 21:30:16 +0200
From:   David Lazar <dlazar@gmail.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: [PATCH] platform/x86: Add s2idle quirk for more Lenovo laptops
Message-ID: <ZTlsyOaFucF2pWrL@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When suspending to idle and resuming on some Lenovo laptops using the
Mendocino APU, multiple NVME IOMMU page faults occur, showing up in
dmesg as repeated errors:

nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000b
address=0xb6674000 flags=0x0000]

The system is unstable afterwards.

Applying the s2idle quirk introduced by commit 455cd867b85b5
("platform/x86: thinkpad_acpi: Add a s2idle resume quirk for a number of
laptops") allows these systems to work with the IOMMU enabled and s2idle
resume to work.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218024
Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: David Lazar <dlazar@gmail.com>
---
 drivers/platform/x86/amd/pmc/pmc-quirks.c | 73 +++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index ad702463a65d..6bbffb081053 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -111,6 +111,79 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21A1"),
 		}
 	},
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=218024 */
+	{
+		.ident = "V14 G4 AMN",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82YT"),
+		}
+	},
+	{
+		.ident = "V14 G4 AMN",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83GE"),
+		}
+	},
+	{
+		.ident = "V15 G4 AMN",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82YU"),
+		}
+	},
+	{
+		.ident = "V15 G4 AMN",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83CQ"),
+		}
+	},
+	{
+		.ident = "IdeaPad 1 14AMN7",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82VF"),
+		}
+	},
+	{
+		.ident = "IdeaPad 1 15AMN7",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82VG"),
+		}
+	},
+	{
+		.ident = "IdeaPad 1 15AMN7",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82X5"),
+		}
+	},
+	{
+		.ident = "IdeaPad Slim 3 14AMN8",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82XN"),
+		}
+	},
+	{
+		.ident = "IdeaPad Slim 3 15AMN8",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82XQ"),
+		}
+	},
 	/* https://gitlab.freedesktop.org/drm/amd/-/issues/2684 */
 	{
 		.ident = "HP Laptop 15s-eq2xxx",
-- 
2.39.2

