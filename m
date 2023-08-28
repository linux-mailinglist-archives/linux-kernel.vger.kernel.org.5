Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634C078ADBA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjH1KuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjH1Kto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:49:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE25F1B5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:49:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7475f45d31so3662265276.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693219757; x=1693824557;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v7MHrwaqRQcEpiQUM63plXyMym72xBHnTiBqMbx7wZw=;
        b=AMPWN1b/UHqT75qKL7kIoe84TxjmLd12ffSET1Hw3zrmkOFwbRpVrKJO0Cmu7vKTqw
         jfM29FhtKEndG/pyh+fyXScGgQ140AUwIHMKysjW4X30MuZL6l1pHcgbC8sMj6pGTcQg
         2Ri1T9Ff9aeccFLlJ7RFWqFTXHKVbYFBdd+Z/df0DE/2fxuDdKIYf27868XQW/VMM1TO
         zbX6u8EEd7oD6xVBxHDRTMcxMHou4uyuSZBG7YFDP7dVo5k0nGnqDwM3WA9RLTHJp56j
         4lJ4E+8lhveVrs7QXiPHz6Sord4FCuGSmK8HAEvJRIQb9QAYu1p22PwiEw3zNHdwAPIp
         DUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693219757; x=1693824557;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7MHrwaqRQcEpiQUM63plXyMym72xBHnTiBqMbx7wZw=;
        b=WG7ZgwUMuTssVYZcHZhdH6/F4RFdU5iR791cQsR26T1fcnH/I4ZYqP4ZkONIEHZol6
         9yy+7BYAO8yeS0LaZPF60rtbAg1Cf2vjqU/PEqJE7AUWZSIouTwXaVKUVdOBy9ehfMeU
         1Wz6jynx5h1yywG3N+qz3ER3O8d5ewE9NsPqvBSkdm8vodgATZl1ZYkiATY0xp35Fhts
         Q4gHVgl6wguM/5qHI3N6L7caFEDpc4KTT6Vds//D5yuDuNJELf3JQ1MSyyEXPGJPtsW3
         vjs0JnRM1MfncBOCoPeAqrgXV+4WfIZTSWcgC83V4BAlCYuxmyrMOq1TSJj0G6w9OfTS
         pKCg==
X-Gm-Message-State: AOJu0Yzvl91CcGRzqr4MdbbZcncwDDbVF7DluKaJYh7uquoi/LghTmdW
        Qi51tIOqqXIKua3o/Pj8U+CuvJq4QXxjXUc=
X-Google-Smtp-Source: AGHT+IG68V4CQ3Yh0kd1RgiLluj29FsB8LO+ZlUEBBe9LgdPfKf4r19liQXmPNdRsJc4iZq4rzAmSeqTtzQT/Do=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a25:d6c7:0:b0:d4b:df05:3500 with SMTP id
 n190-20020a25d6c7000000b00d4bdf053500mr875605ybg.11.1693219756887; Mon, 28
 Aug 2023 03:49:16 -0700 (PDT)
Date:   Mon, 28 Aug 2023 10:48:06 +0000
In-Reply-To: <20230828104807.1581592-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230828104807.1581592-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230828104807.1581592-7-aliceryhl@google.com>
Subject: [PATCH v4 6/7] rust: workqueue: add `try_spawn` helper method
From:   Alice Ryhl <aliceryhl@google.com>
To:     rust-for-linux@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Andreas Hindborg <nmi@metaspace.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a convenience method that lets you spawn a closure for
execution on a workqueue. This will be the most convenient way to use
workqueues, but it is fallible because it needs to allocate memory.

Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
---
v3 -> v4:
 * Use new `new_work!` macro.

 rust/kernel/workqueue.rs | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index c1334c48b96b..40ccc53f6e93 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -29,6 +29,7 @@
 //! C header: [`include/linux/workqueue.h`](../../../../include/linux/workqueue.h)
 
 use crate::{bindings, prelude::*, sync::Arc, sync::LockClassKey, types::Opaque};
+use alloc::alloc::AllocError;
 use alloc::boxed::Box;
 use core::marker::PhantomData;
 use core::pin::Pin;
@@ -96,6 +97,44 @@ pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::EnqueueOutput
             })
         }
     }
+
+    /// Tries to spawn the given function or closure as a work item.
+    ///
+    /// This method can fail because it allocates memory to store the work item.
+    pub fn try_spawn<T: 'static + Send + FnOnce()>(&self, func: T) -> Result<(), AllocError> {
+        let init = pin_init!(ClosureWork {
+            work <- new_work!("Queue::try_spawn"),
+            func: Some(func),
+        });
+
+        self.enqueue(Box::pin_init(init).map_err(|_| AllocError)?);
+        Ok(())
+    }
+}
+
+/// A helper type used in `try_spawn`.
+#[pin_data]
+struct ClosureWork<T> {
+    #[pin]
+    work: Work<ClosureWork<T>>,
+    func: Option<T>,
+}
+
+impl<T> ClosureWork<T> {
+    fn project(self: Pin<&mut Self>) -> &mut Option<T> {
+        // SAFETY: The `func` field is not structurally pinned.
+        unsafe { &mut self.get_unchecked_mut().func }
+    }
+}
+
+impl<T: FnOnce()> WorkItem for ClosureWork<T> {
+    type Pointer = Pin<Box<Self>>;
+
+    fn run(mut this: Pin<Box<Self>>) {
+        if let Some(func) = this.as_mut().project().take() {
+            (func)()
+        }
+    }
 }
 
 /// A raw work item.
@@ -365,6 +404,10 @@ unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_typ
     )*};
 }
 
+impl_has_work! {
+    impl<T> HasWork<Self> for ClosureWork<T> { self.work }
+}
+
 unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Arc<T>
 where
     T: WorkItem<ID, Pointer = Self>,
-- 
2.42.0.rc1.204.g551eb34607-goog

