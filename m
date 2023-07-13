Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2ED752847
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbjGMQ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbjGMQ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBF02D40
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689265689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWVveJ30j+awpC6r3B537VP9iS5QEq83jfrgh734Zoc=;
        b=cIJif7q8EEYMJQi8b2sniU7ZABGeoH5QphxSg1h+D3iv67tv+1VtQU1ZDbUnVtfLGy6tv5
        zxbHIkO9zINCuI98tekU+xp9dyu6XpzRUGSn8OU35Hd5H2gMMFKHFgL4skhlJmXP41BkWG
        W4LjWFBgDa/aLKvJ3A1kLcZGgIVoWik=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-q2m5ndA5NH6fTIsR1_sJyA-1; Thu, 13 Jul 2023 12:28:08 -0400
X-MC-Unique: q2m5ndA5NH6fTIsR1_sJyA-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-56364632e59so1382607eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689265688; x=1691857688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWVveJ30j+awpC6r3B537VP9iS5QEq83jfrgh734Zoc=;
        b=jKf3kKFeoi1PXjgIgEjnNM+8wuwnrZbsETR9XBxp5FZdaddQmDA7hLv25TX9BdBG9S
         uaVU6Xg3MO6nyyys/z/8u2xf1G/IOhqXcWGEqiVm21+gnEleTOI4aX+A+lvaDXGnBHhp
         LH+G8FHF7kY3L0IIadylsCvlhqBbzXDILwOVU76DK/EO2rX9Ap4qgM7K+Wk+dCTYXvOy
         7fmwqqusQK+/UR/jOEaBy0K38mS9to19prwQWfCfZb8oHYAA3AFf1qdlWUOiZns5rRID
         Al45woA2PStWQQmeiQRQZHHB7d4MREcxyYZyQi7rpVaPcRquV2/0ZFZVeNVXhuCFDiGh
         KiYA==
X-Gm-Message-State: ABy/qLZ5O6Oxz4u143yLCPJHu+JsPP2GBSfOyBGIU9jJokJa14Y3U/jd
        PN7tOg5TvJbRXpgG0nPNGNzvein5IoyyZlbv7d/91z3kh/Kfb5+Bel91yrOwYksBtKKqVBtOchv
        LxnwVWKMP96MS7tAMg45KK4M=
X-Received: by 2002:a05:6358:5e0c:b0:12b:ed77:8b66 with SMTP id q12-20020a0563585e0c00b0012bed778b66mr2046491rwn.7.1689265687774;
        Thu, 13 Jul 2023 09:28:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEYJq50pG1mqKAGjMEGWllFZXoPDQDA26oc7CbIG+2WUGSjQlqgGXpb/reRGfhmQCOyognUtA==
X-Received: by 2002:a05:6358:5e0c:b0:12b:ed77:8b66 with SMTP id q12-20020a0563585e0c00b0012bed778b66mr2046469rwn.7.1689265687405;
        Thu, 13 Jul 2023 09:28:07 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-24-242.cust.vodafonedsl.it. [2.34.24.242])
        by smtp.gmail.com with ESMTPSA id u17-20020a0cf1d1000000b00637873ff0f3sm3206582qvl.15.2023.07.13.09.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:28:07 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v9 4/4] fpga: add configuration for the FPGA KUnit test suites.
Date:   Thu, 13 Jul 2023 18:27:31 +0200
Message-ID: <20230713162731.211669-5-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713162731.211669-1-marpagan@redhat.com>
References: <20230713162731.211669-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add configuration for the KUnit test suites for the core components
of the FPGA subsystem.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/Kconfig            |  2 ++
 drivers/fpga/Makefile           |  3 +++
 drivers/fpga/tests/.kunitconfig |  5 +++++
 drivers/fpga/tests/Kconfig      | 11 +++++++++++
 drivers/fpga/tests/Makefile     |  6 ++++++
 5 files changed, 27 insertions(+)
 create mode 100644 drivers/fpga/tests/.kunitconfig
 create mode 100644 drivers/fpga/tests/Kconfig
 create mode 100644 drivers/fpga/tests/Makefile

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 0a00763b9f28..2f689ac4ba3a 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -276,4 +276,6 @@ config FPGA_MGR_LATTICE_SYSCONFIG_SPI
 	  FPGA manager driver support for Lattice FPGAs programming over slave
 	  SPI sysCONFIG interface.
 
+source "drivers/fpga/tests/Kconfig"
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 72e554b4d2f7..352a2612623e 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -55,3 +55,6 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
+
+# KUnit tests
+obj-$(CONFIG_FPGA_KUNIT_TESTS)		+= tests/
diff --git a/drivers/fpga/tests/.kunitconfig b/drivers/fpga/tests/.kunitconfig
new file mode 100644
index 000000000000..a1c2a2974c39
--- /dev/null
+++ b/drivers/fpga/tests/.kunitconfig
@@ -0,0 +1,5 @@
+CONFIG_KUNIT=y
+CONFIG_FPGA=y
+CONFIG_FPGA_REGION=y
+CONFIG_FPGA_BRIDGE=y
+CONFIG_FPGA_KUNIT_TESTS=y
diff --git a/drivers/fpga/tests/Kconfig b/drivers/fpga/tests/Kconfig
new file mode 100644
index 000000000000..e4a64815f16d
--- /dev/null
+++ b/drivers/fpga/tests/Kconfig
@@ -0,0 +1,11 @@
+config FPGA_KUNIT_TESTS
+	tristate "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
+	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT=y
+	default KUNIT_ALL_TESTS
+        help
+          This builds unit tests for the FPGA subsystem
+
+          For more information on KUnit and unit tests in general,
+          please refer to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+          If unsure, say N.
diff --git a/drivers/fpga/tests/Makefile b/drivers/fpga/tests/Makefile
new file mode 100644
index 000000000000..bb78215c645c
--- /dev/null
+++ b/drivers/fpga/tests/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for KUnit test suites for the FPGA subsystem
+#
+
+obj-$(CONFIG_FPGA_KUNIT_TESTS) += fpga-mgr-test.o fpga-bridge-test.o fpga-region-test.o
-- 
2.41.0

