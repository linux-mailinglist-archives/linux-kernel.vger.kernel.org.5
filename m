Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288597D8C94
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 02:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345057AbjJ0Afl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 20:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJ0Afi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 20:35:38 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE123D4A;
        Thu, 26 Oct 2023 17:35:32 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so1483859b3a.2;
        Thu, 26 Oct 2023 17:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698366932; x=1698971732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jF6tp7iLgrDkXUoNDLA4js3d0RVuMKJhGaRJ7F1v1g=;
        b=EZREnKhczMikgbT0z44xR7RyqBYaeJdysrMiWp4E/AzcHAY1mo30kxuIAdY2GOJ6Z/
         8BYuJjYEURolltfJatDf7BgPbrkK92Zb2RIqv3IW3Cy0iIwjd69dcyBeRPAQ9fcrBE6e
         yYiohmjR66oOG48tbDpR/4poWJG9X6cJK5ISBHPqAygrd9GEY55W0HtdItHa724ORuwZ
         AY8PO84UROMjSfGyZYXXqwR00IUHJD34VUF9LBA0ZcwSzZNGmfIavV8vrWUlRL8pJs1y
         tT1iC4kaiOvWufVPe+U+jlcZqTP1l5NWtaSa1JIR1XR37fPUkzPTwVV8mCONlZxCqBMj
         U31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698366932; x=1698971732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jF6tp7iLgrDkXUoNDLA4js3d0RVuMKJhGaRJ7F1v1g=;
        b=nxxlJZun2r9YB13EQklrv3Cksh3ooLE40rgUv5jUzJncDUfrAAsXmqerS/6w9jNAAn
         cfYlrIUOJ4QcBwJup7kdaXmyamddhnLqmG7ss1cjKB9E2kqtmgfd197xLpdmCKae8WVd
         L6fWb89zfm0hJOyCSuT81aJaJ4a/Z8S0XX8DGFhUTc4+vdUBV3Pbd6esGN8Fsf1WxXPu
         Eh+hGyq/WWWu71NiY5Hgi9qQg2q1n4ON0PjrxKWz2UMRiBJLUapIcUDrCOb1i7xi+Hhe
         Ne6Mo8KoHJWMBFRV4fWB/zG+6Z3FdIk5UGdfeh4S8VTGGmJVnwcZK2fkCSJRtCc4MUY8
         mC7g==
X-Gm-Message-State: AOJu0YyjehWLaK4Q/d+AwAuuMyCODVe3+2hvWwpFCFhskaGRt1oeQjmW
        neKYqLoLIUet0epltmx9Cmg=
X-Google-Smtp-Source: AGHT+IFz6oXD38WsJde6gD+qt++j7ELzVs8PFzKfelLAn6P4nI1pgwfW5Erb2KpLlEdWx9jBthh3qA==
X-Received: by 2002:a05:6a00:1143:b0:6b2:69c:346a with SMTP id b3-20020a056a00114300b006b2069c346amr1231533pfm.19.1698366931881;
        Thu, 26 Oct 2023 17:35:31 -0700 (PDT)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id g21-20020aa78755000000b006be683108cesm183096pfo.213.2023.10.26.17.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 17:35:31 -0700 (PDT)
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
        linux-usb@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH v2 2/2] samples: rust: Add USB sample bindings
Date:   Thu, 26 Oct 2023 21:34:51 -0300
Message-ID: <20231027003504.146703-3-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231027003504.146703-1-yakoyoku@gmail.com>
References: <20231027003504.146703-1-yakoyoku@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a demonstration of the capabilities of doing bindings with
subsystems that may or may not be statically linked.

Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
 drivers/usb/core/Kconfig        |  7 +++++++
 drivers/usb/core/Makefile       |  3 +++
 drivers/usb/core/usb.rs         | 13 +++++++++++++
 samples/rust/Kconfig            | 10 ++++++++++
 samples/rust/Makefile           |  3 +++
 samples/rust/rust_usb_simple.rs | 22 ++++++++++++++++++++++
 6 files changed, 58 insertions(+)
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
2.42.0

