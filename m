Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3233D7E111B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 22:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjKDVMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 17:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjKDVMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 17:12:44 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D4DD6F;
        Sat,  4 Nov 2023 14:12:40 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9fe0a598d8so3169852276.2;
        Sat, 04 Nov 2023 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699132359; x=1699737159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmmxzjjUwK3b8vn2y9x/jblHXMC3dRiI5YQuelEgEu4=;
        b=Q+vCr0sO6IDgdSXv4wYYodmhCp7JkvqjikNWiahuPEZC/1eDVj49GmSs7wTxElEC04
         cVLmGyeMnnu3iByPRRJmk/f4lkgdVRaZLAm+fp3eENvPCkKNMoAz0NnsAjszF6Ctzm6f
         RpJMUTvKlxshI9gpknKtF+RAphwYq8Xmkj3KgSDD3RZVn0GTFlu9DkEOxSxCaGtJfkPC
         POGZeL+jLpn6IZFxk/VGSI7z0B6FCHzFJnMWGWr8GEM7TFOLf7yAoZ0vYoRolcoHDXKq
         uJyzh/WvbGFbLYXYWkvw+4+k49PNKTxxajEdsa7M5wPWbeUB6qbvCMvDEtpFU3MYThKK
         ykJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699132359; x=1699737159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmmxzjjUwK3b8vn2y9x/jblHXMC3dRiI5YQuelEgEu4=;
        b=ojskqdPwEsM/iiUHyiGtQhPdHg5YZ8iSU63qcZJkCdbwfOqjL18ik0R6YeSBSD12jZ
         a+4XNygX5EUx9TF01vN0qSPEGn3EAIfUuyDRz0Yg+nyDO55kZQDnprkiQM0ZxRVbJ9cC
         DwIGPKn/L1vvzQo/jWpcWanO8pSt91Pon4dg9dmXZvKKrE5TCJ5ShLUttHVSB4yiShdr
         JDhbY8BbDJG6Xu/AD9MpmrFwfHog1gtr/ltP7QZMRqTlr5e0GSxqviTZMyldHT5IL1Uk
         acUBTOGIsD571vTQnG8TFlo9y/BegWfajl+/LGjxv7/9rJVNE9EkblhkIIQyuaCFGAkh
         Kc9g==
X-Gm-Message-State: AOJu0YwcNebG8QbCSITy6rPcsFiiM9StiElGodZRxpDc0UFhAstcfvt4
        p3Z2zDyqdKsp8iOyyrg/CdA=
X-Google-Smtp-Source: AGHT+IHp/sOSSBPGc9xRlPjZZ6gFxe6O8jR7w37AYO5PXaa4PLmh0wW/fqWzJ0TWrDwqXjz9SUudGg==
X-Received: by 2002:a25:da48:0:b0:d84:e7a6:fc09 with SMTP id n69-20020a25da48000000b00d84e7a6fc09mr24125639ybf.17.1699132359603;
        Sat, 04 Nov 2023 14:12:39 -0700 (PDT)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id t14-20020a25838e000000b00d9cc49edae9sm2094731ybk.63.2023.11.04.14.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 14:12:39 -0700 (PDT)
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        linux-usb@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH v3 2/2] samples: rust: Add USB sample bindings
Date:   Sat,  4 Nov 2023 18:11:59 -0300
Message-ID: <20231104211213.225891-3-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231104211213.225891-1-yakoyoku@gmail.com>
References: <20231104211213.225891-1-yakoyoku@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a demonstration of the capabilities of doing bindings with
subsystems that may or may not be statically linked.

Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
v2 -> v3:
- Generate bindings for USB.
v1 -> v2:
- Added this patch.

 drivers/usb/core/Kconfig        |  7 +++++++
 drivers/usb/core/Makefile       |  3 +++
 drivers/usb/core/usb.rs         | 13 +++++++++++++
 rust/bindings/bindings_helper.h |  1 +
 samples/rust/Kconfig            | 10 ++++++++++
 samples/rust/Makefile           |  3 +++
 samples/rust/rust_usb_simple.rs | 22 ++++++++++++++++++++++
 7 files changed, 59 insertions(+)
 create mode 100644 drivers/usb/core/usb.rs
 create mode 100644 samples/rust/rust_usb_simple.rs

diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index 351ede4b5de2..4b5604282129 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -116,3 +116,10 @@ config USB_AUTOSUSPEND_DELAY
 	  The default value Linux has always had is 2 seconds.  Change
 	  this value if you want a different delay and cannot modify
 	  the command line or module parameter.
+
+config USB_RUST
+	bool "Rust USB bindings"
+	depends on USB && RUST
+	default n
+	help
+	  Enables Rust bindings for USB.
diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
index 7d338e9c0657..00e116913591 100644
--- a/drivers/usb/core/Makefile
+++ b/drivers/usb/core/Makefile
@@ -11,6 +11,7 @@ usbcore-y += phy.o port.o
 usbcore-$(CONFIG_OF)		+= of.o
 usbcore-$(CONFIG_USB_PCI)		+= hcd-pci.o
 usbcore-$(CONFIG_ACPI)		+= usb-acpi.o
+usbcore-$(CONFIG_USB_RUST)		+= libusb.rlib
 
 ifdef CONFIG_USB_ONBOARD_HUB
 usbcore-y			+= ../misc/onboard_usb_hub_pdevs.o
@@ -18,4 +19,6 @@ endif
 
 obj-$(CONFIG_USB)		+= usbcore.o
 
+rust-libs			:= ./usb
+
 obj-$(CONFIG_USB_LEDS_TRIGGER_USBPORT)	+= ledtrig-usbport.o
diff --git a/drivers/usb/core/usb.rs b/drivers/usb/core/usb.rs
new file mode 100644
index 000000000000..3f7ad02153f5
--- /dev/null
+++ b/drivers/usb/core/usb.rs
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! USB devices and drivers.
+//!
+//! C header: [`include/linux/usb.h`](../../../../include/linux/usb.h)
+
+use kernel::bindings;
+
+/// Check if USB is disabled.
+pub fn disabled() -> bool {
+    // SAFETY: FFI call.
+    unsafe { bindings::usb_disabled() != 0 }
+}
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index c41eaab4ddb2..845cdd856981 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,6 +10,7 @@
 #include <linux/errname.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
+#include <linux/usb.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/workqueue.h>
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index b0f74a81c8f9..12116f6fb526 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -30,6 +30,16 @@ config SAMPLE_RUST_PRINT
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_USB_SIMPLE
+	tristate "USB simple device driver"
+	help
+	  This option builds the Rust USB simple driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_usb_simple.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_HOSTPROGS
 	bool "Host programs"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 03086dabbea4..f1ab58a9ecdd 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -2,5 +2,8 @@
 
 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
 obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
+obj-$(CONFIG_SAMPLE_RUST_USB_SIMPLE)		+= rust_usb_simple.o
+
+rust-libs					:= ../../drivers/usb/core/usb
 
 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/rust_usb_simple.rs b/samples/rust/rust_usb_simple.rs
new file mode 100644
index 000000000000..3523f81d5eb8
--- /dev/null
+++ b/samples/rust/rust_usb_simple.rs
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust USB sample.
+
+use kernel::prelude::*;
+
+module! {
+    type: UsbSimple,
+    name: "rust_usb_simple",
+    author: "Martin Rodriguez Reboredo",
+    description: "Rust USB sample",
+    license: "GPL v2",
+}
+
+struct UsbSimple;
+
+impl kernel::Module for UsbSimple {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        pr_info!("usb enabled: {}", !usb::disabled());
+        Ok(UsbSimple)
+    }
+}
-- 
2.42.1

