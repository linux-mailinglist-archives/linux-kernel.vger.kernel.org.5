Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FAF7A1B27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbjIOJr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjIOJr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:47:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAD23ABD;
        Fri, 15 Sep 2023 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694771100; x=1726307100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=28Q6FS8KH3B7iBp/MzaF66/guYlDU+uUua9Jud0/lCE=;
  b=d+SiNYew3NOfxT6auHt4JFVaFjAyaHhhAOTtFX+HMz+wI5f2GmRdC9rK
   rZ005imGoUYnKJp65OEBgydLVYoj+ET+bpyYRiASMlmcmJSg2Ecz+IWNa
   NNSVzaMbG1WyU0fynpDgpAo/BXm+L2P4ZvEhZjWil497ZcxHwDdEamm5i
   kuwZYqfr5JnsF5WZCx4nKrnoB/gU2fR9l+tU/gdGd7v1Dn7G+VJJUNLoJ
   oJMXFaWmT9C4x5kd5W0v30fZQYsTMoB5cdGdxDtXbeM+V1cu9q7gPE7Ni
   4xnv99DKDGil3rqNfLRzBN3+2cl5yYVqEEVbjrYGG4HUj7WHKnA40yRTt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="379128092"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="379128092"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 02:43:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="774245921"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="774245921"
Received: from srdoo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.38.99])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 02:43:46 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Matthew Howell <matthew.howell@sealevel.com>
Subject: [PATCH 2/2] tty: serial: 8250_exar: Does not use anything from 8250_pci
Date:   Fri, 15 Sep 2023 12:43:36 +0300
Message-Id: <20230915094336.13278-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230915094336.13278-1-ilpo.jarvinen@linux.intel.com>
References: <20230915094336.13278-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

8250_exar includes linux/8250_pci.h and depends on SERIAL_8250_PCI.
Neither is necessary so this patch removes the include and changes
the depends on to SERIAL_8250 && PCI (taken from SERIAL_8250_PCI).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Cc: Matthew Howell <matthew.howell@sealevel.com>

 drivers/tty/serial/8250/8250_exar.c | 1 -
 drivers/tty/serial/8250/Kconfig     | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 077c3ba3539e..2f9813429278 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -18,7 +18,6 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/tty.h>
-#include <linux/8250_pci.h>
 #include <linux/delay.h>
 
 #include <asm/byteorder.h>
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index ee17cf5c44c6..d91924cb9b21 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -148,7 +148,7 @@ config SERIAL_8250_PCI
 
 config SERIAL_8250_EXAR
 	tristate "8250/16550 Exar/Commtech PCI/PCIe device support"
-	depends on SERIAL_8250_PCI
+	depends on SERIAL_8250 && PCI
 	default SERIAL_8250
 	help
 	  This builds support for XR17C1xx, XR17V3xx and some Commtech
-- 
2.30.2

