Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454FA7DE5BB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344741AbjKASC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344629AbjKASC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:02:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A29109
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:02:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da3dd6a72a7so37047276.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698861738; x=1699466538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yccWDwXNSEplPRKvHpKQnUcNVcHf6PL+CKwkhXIxnDA=;
        b=3I2kxRdeBmgOaPOh6ks67zMG0Efb6AsWHbT2L+Hj5nP8Fwcoro0S7pMagc8TwwIUv3
         KXKymBIjCi+U50P244JW3hE3n6B62Z843BWiD0JYrhjj862XfEGTyqCIwFr09jlWU8pA
         QjwJj0kMNPx8SFWg3K5iZmDcqiGSNMSfqMqFbMstl+JIbY8IUL9k9+dwXEITuPY1gpz4
         HG9HU2M6rbH/d3d48KYKMTis3R8eVbIb8nipPzcI9PQAnIf6+bxsifEx9ArtYhFmaGd3
         1i/Ao0UPwZTWct8+fICPFsva/yNwLttU6yYJwYSRUhMnz7tL+jJ0mITCPOuRlbotINoj
         hyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861738; x=1699466538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yccWDwXNSEplPRKvHpKQnUcNVcHf6PL+CKwkhXIxnDA=;
        b=McZ1p7rFXRgYbxWr40AGqSYaBivqXE+zoZiyjgIIKFOJC078eCcmi1swsfgFTIvK3M
         11Uzg92xkWSIIrWUsM5d6Afk/PhFe7HKhnTSaoitnbmtcK2c8QJqaDS5tQat1SmEi0rq
         HY9tknAAADiPlauNjYlVpUrFH6AOEriGNFzsGK2qKrvsytTmJJGzbNvgkN8v6ZoM+/JK
         bOM36NRXfwQiKW9N7nmhEVUsTj1SxPAZzIYI0Q8ANQ2dvH6qXwHctMhEXlkyP6zxe97Z
         GqPquDH1A+mSiwIYyZ4wLn+8m4z6q0lupK1qCOG9LHA6PvOT/htWIAU2PPCcTVebBZVS
         XAug==
X-Gm-Message-State: AOJu0Yxyy6sJD6ZKFA8rWFZIiGbUME0LK/sBheluX2MaBs8EhDkYQ9ly
        zcEAd3RXSEGuul2+HsJeDFzTyv8BItrazmk=
X-Google-Smtp-Source: AGHT+IGsOeLOtqnoWXxk0cyVQV5wjyVE1WqpR4bJ+iZ0KnC/C8wa60VefDXitdSpRcUJ6zkaT16LhYv19QlqVUY=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1083:b0:da0:567d:f819 with SMTP
 id v3-20020a056902108300b00da0567df819mr389299ybu.10.1698861738397; Wed, 01
 Nov 2023 11:02:18 -0700 (PDT)
Date:   Wed, 01 Nov 2023 18:01:31 +0000
In-Reply-To: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
Mime-Version: 1.0
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231101-rust-binder-v1-1-08ba9197f637@google.com>
Subject: [PATCH RFC 01/20] rust_binder: define a Rust binder driver
From:   Alice Ryhl <aliceryhl@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Matt Gilbride <mattgilbride@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Matthew Maurer <mmaurer@google.com>,
        Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Define the Rust binder driver, and set up the helpers for making C types
accessible from Rust.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/Kconfig             | 11 +++++++++++
 drivers/android/Makefile            |  1 +
 drivers/android/rust_binder.rs      | 21 +++++++++++++++++++++
 include/uapi/linux/android/binder.h | 30 ++++++++++++++++--------------
 rust/bindings/bindings_helper.h     |  1 +
 5 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
index 07aa8ae0a058..fcfd25c9a016 100644
--- a/drivers/android/Kconfig
+++ b/drivers/android/Kconfig
@@ -13,6 +13,17 @@ config ANDROID_BINDER_IPC
 	  Android process, using Binder to identify, invoke and pass arguments
 	  between said processes.
 
+config ANDROID_BINDER_IPC_RUST
+	bool "Android Binder IPC Driver in Rust"
+	depends on MMU && RUST
+	help
+	  Binder is used in Android for both communication between processes,
+	  and remote method invocation.
+
+	  This means one Android process can call a method/routine in another
+	  Android process, using Binder to identify, invoke and pass arguments
+	  between said processes.
+
 config ANDROID_BINDERFS
 	bool "Android Binderfs filesystem"
 	depends on ANDROID_BINDER_IPC
diff --git a/drivers/android/Makefile b/drivers/android/Makefile
index c9d3d0c99c25..6348f75832ca 100644
--- a/drivers/android/Makefile
+++ b/drivers/android/Makefile
@@ -4,3 +4,4 @@ ccflags-y += -I$(src)			# needed for trace events
 obj-$(CONFIG_ANDROID_BINDERFS)		+= binderfs.o
 obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o
 obj-$(CONFIG_ANDROID_BINDER_IPC_SELFTEST) += binder_alloc_selftest.o
+obj-$(CONFIG_ANDROID_BINDER_IPC_RUST)	+= rust_binder.o
diff --git a/drivers/android/rust_binder.rs b/drivers/android/rust_binder.rs
new file mode 100644
index 000000000000..4b3d6676a9cf
--- /dev/null
+++ b/drivers/android/rust_binder.rs
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Binder -- the Android IPC mechanism.
+
+use kernel::prelude::*;
+
+module! {
+    type: BinderModule,
+    name: "rust_binder",
+    author: "Wedson Almeida Filho, Alice Ryhl",
+    description: "Android Binder",
+    license: "GPL",
+}
+
+struct BinderModule {}
+
+impl kernel::Module for BinderModule {
+    fn init(_module: &'static kernel::ThisModule) -> Result<Self> {
+        Ok(Self {})
+    }
+}
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index 5f636b5afcd7..d44a8118b2ed 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -251,20 +251,22 @@ struct binder_extended_error {
 	__s32	param;
 };
 
-#define BINDER_WRITE_READ		_IOWR('b', 1, struct binder_write_read)
-#define BINDER_SET_IDLE_TIMEOUT		_IOW('b', 3, __s64)
-#define BINDER_SET_MAX_THREADS		_IOW('b', 5, __u32)
-#define BINDER_SET_IDLE_PRIORITY	_IOW('b', 6, __s32)
-#define BINDER_SET_CONTEXT_MGR		_IOW('b', 7, __s32)
-#define BINDER_THREAD_EXIT		_IOW('b', 8, __s32)
-#define BINDER_VERSION			_IOWR('b', 9, struct binder_version)
-#define BINDER_GET_NODE_DEBUG_INFO	_IOWR('b', 11, struct binder_node_debug_info)
-#define BINDER_GET_NODE_INFO_FOR_REF	_IOWR('b', 12, struct binder_node_info_for_ref)
-#define BINDER_SET_CONTEXT_MGR_EXT	_IOW('b', 13, struct flat_binder_object)
-#define BINDER_FREEZE			_IOW('b', 14, struct binder_freeze_info)
-#define BINDER_GET_FROZEN_INFO		_IOWR('b', 15, struct binder_frozen_status_info)
-#define BINDER_ENABLE_ONEWAY_SPAM_DETECTION	_IOW('b', 16, __u32)
-#define BINDER_GET_EXTENDED_ERROR	_IOWR('b', 17, struct binder_extended_error)
+enum {
+	BINDER_WRITE_READ		= _IOWR('b', 1, struct binder_write_read),
+	BINDER_SET_IDLE_TIMEOUT		= _IOW('b', 3, __s64),
+	BINDER_SET_MAX_THREADS		= _IOW('b', 5, __u32),
+	BINDER_SET_IDLE_PRIORITY	= _IOW('b', 6, __s32),
+	BINDER_SET_CONTEXT_MGR		= _IOW('b', 7, __s32),
+	BINDER_THREAD_EXIT		= _IOW('b', 8, __s32),
+	BINDER_VERSION			= _IOWR('b', 9, struct binder_version),
+	BINDER_GET_NODE_DEBUG_INFO	= _IOWR('b', 11, struct binder_node_debug_info),
+	BINDER_GET_NODE_INFO_FOR_REF	= _IOWR('b', 12, struct binder_node_info_for_ref),
+	BINDER_SET_CONTEXT_MGR_EXT	= _IOW('b', 13, struct flat_binder_object),
+	BINDER_FREEZE			= _IOW('b', 14, struct binder_freeze_info),
+	BINDER_GET_FROZEN_INFO		= _IOWR('b', 15, struct binder_frozen_status_info),
+	BINDER_ENABLE_ONEWAY_SPAM_DETECTION	= _IOW('b', 16, __u32),
+	BINDER_GET_EXTENDED_ERROR	= _IOWR('b', 17, struct binder_extended_error),
+};
 
 /*
  * NOTE: Two special error codes you should check for when calling
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 14f84aeef62d..00a66666f00a 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -21,6 +21,7 @@
 #include <linux/sched.h>
 #include <linux/task_work.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/android/binder.h>
 
 /* `bindgen` gets confused at certain things. */
 const size_t BINDINGS_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;

-- 
2.42.0.820.g83a721a137-goog

