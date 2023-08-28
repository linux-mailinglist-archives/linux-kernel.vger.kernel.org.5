Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A3D78ADB7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjH1KuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjH1Ktg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:49:36 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A68018B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:49:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-594e5e2e608so29328927b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693219749; x=1693824549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BorrAImMTABb8airVo2n4M+IWhza6B9m8B72c2I7bnc=;
        b=ZVr65IWuMuDz+VSStAp2mlRisUS2ja6h5TVTTR1ji4Xkh+9bmL91ZjH8VgN2w8LaEM
         KjKqoAv2exExmfAPJumi00HL0RRi8RgongOvndUyj4XzM9qdoez5qMH6xVbO4C4/HJCi
         q+QEuSlod0R8PM/avacBeLfg/7fYwnoTvRDiAm71ZKOCKzdEJFsWWfLe3xTXxLXzEHkt
         vGJ8NgWLxbeGJPjE8lAmnkuELtS523rJNiGy2Llmxq/qjbhIJ3HAGe3fPf0agKOEtLHy
         ABBM34aHiN8xK54rNT1/0myzkws2BKrh4hH8uMkMfrwAvrAPAoVrzbvX9KE8Vkv+8hN6
         JLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693219749; x=1693824549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BorrAImMTABb8airVo2n4M+IWhza6B9m8B72c2I7bnc=;
        b=OUsSMOakvUOisNr17UjesBmRZR8JpLFRP29aHAsWYBf+uAfxJIvim1EnpxMsFTUMXL
         X8OpSPub8eXNkW5qqjK8+6bb8OWsWjTheyfxTWfVVfqWOAEKXfRepiOmlaTh5gfJ9TOK
         VNGDjNlDKcWfk0Izlgr+/mw5o/udxwGaPUk/knidG9OWtfyADGeKn1zbCgHx0B77f5Px
         uw4PbmnH8aEnsfnyydAqo9d0FZemhM5VsxA87K/tstZQsQoaAq+p4pRRmu0mgN8IMtcl
         0Jqkd+8WYB7GDw6tUdJoiYVd0W6UH4/gLkfo+GKX3aLGChZyGsINHmq+JltXJ06QKfVa
         rYvA==
X-Gm-Message-State: AOJu0Ywe7WIvL/l2jbdMvI5L5Pqt2lXIzhkYjTKRmPuHBiSlHgWHfiYX
        ugAEiHfPlmDtqFGy1VtcNcFEDZZzeS+TL9Q=
X-Google-Smtp-Source: AGHT+IEAMgoHOoYGZ6vEg7ci/vFHdanR86AmFmfUcjSX2ixfcNpn+UlmAxB/P2cmfzNNFBCIKAJ65ZsIL4wQwR8=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a5b:68e:0:b0:d77:cd42:913a with SMTP id
 j14-20020a5b068e000000b00d77cd42913amr654954ybq.9.1693219749478; Mon, 28 Aug
 2023 03:49:09 -0700 (PDT)
Date:   Mon, 28 Aug 2023 10:48:03 +0000
In-Reply-To: <20230828104807.1581592-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230828104807.1581592-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230828104807.1581592-4-aliceryhl@google.com>
Subject: [PATCH v4 3/7] rust: workqueue: define built-in queues
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
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Andreas Hindborg <nmi@metaspace.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

We provide these methods because it lets us access these queues from
Rust without using unsafe code.

These methods return `&'static Queue`. References annotated with the
'static lifetime are used when the referent will stay alive forever.
That is ok for these queues because they are global variables and cannot
be destroyed.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
---
v3 -> v4:
 * No changes.

 rust/kernel/workqueue.rs | 71 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 19e5c50127af..6dbc5b9b3da9 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -107,3 +107,74 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
     where
         F: FnOnce(*mut bindings::work_struct) -> bool;
 }
+
+/// Returns the system work queue (`system_wq`).
+///
+/// It is the one used by `schedule[_delayed]_work[_on]()`. Multi-CPU multi-threaded. There are
+/// users which expect relatively short queue flush time.
+///
+/// Callers shouldn't queue work items which can run for too long.
+pub fn system() -> &'static Queue {
+    // SAFETY: `system_wq` is a C global, always available.
+    unsafe { Queue::from_raw(bindings::system_wq) }
+}
+
+/// Returns the system high-priority work queue (`system_highpri_wq`).
+///
+/// It is similar to the one returned by [`system`] but for work items which require higher
+/// scheduling priority.
+pub fn system_highpri() -> &'static Queue {
+    // SAFETY: `system_highpri_wq` is a C global, always available.
+    unsafe { Queue::from_raw(bindings::system_highpri_wq) }
+}
+
+/// Returns the system work queue for potentially long-running work items (`system_long_wq`).
+///
+/// It is similar to the one returned by [`system`] but may host long running work items. Queue
+/// flushing might take relatively long.
+pub fn system_long() -> &'static Queue {
+    // SAFETY: `system_long_wq` is a C global, always available.
+    unsafe { Queue::from_raw(bindings::system_long_wq) }
+}
+
+/// Returns the system unbound work queue (`system_unbound_wq`).
+///
+/// Workers are not bound to any specific CPU, not concurrency managed, and all queued work items
+/// are executed immediately as long as `max_active` limit is not reached and resources are
+/// available.
+pub fn system_unbound() -> &'static Queue {
+    // SAFETY: `system_unbound_wq` is a C global, always available.
+    unsafe { Queue::from_raw(bindings::system_unbound_wq) }
+}
+
+/// Returns the system freezable work queue (`system_freezable_wq`).
+///
+/// It is equivalent to the one returned by [`system`] except that it's freezable.
+///
+/// A freezable workqueue participates in the freeze phase of the system suspend operations. Work
+/// items on the workqueue are drained and no new work item starts execution until thawed.
+pub fn system_freezable() -> &'static Queue {
+    // SAFETY: `system_freezable_wq` is a C global, always available.
+    unsafe { Queue::from_raw(bindings::system_freezable_wq) }
+}
+
+/// Returns the system power-efficient work queue (`system_power_efficient_wq`).
+///
+/// It is inclined towards saving power and is converted to "unbound" variants if the
+/// `workqueue.power_efficient` kernel parameter is specified; otherwise, it is similar to the one
+/// returned by [`system`].
+pub fn system_power_efficient() -> &'static Queue {
+    // SAFETY: `system_power_efficient_wq` is a C global, always available.
+    unsafe { Queue::from_raw(bindings::system_power_efficient_wq) }
+}
+
+/// Returns the system freezable power-efficient work queue (`system_freezable_power_efficient_wq`).
+///
+/// It is similar to the one returned by [`system_power_efficient`] except that is freezable.
+///
+/// A freezable workqueue participates in the freeze phase of the system suspend operations. Work
+/// items on the workqueue are drained and no new work item starts execution until thawed.
+pub fn system_freezable_power_efficient() -> &'static Queue {
+    // SAFETY: `system_freezable_power_efficient_wq` is a C global, always available.
+    unsafe { Queue::from_raw(bindings::system_freezable_power_efficient_wq) }
+}
-- 
2.42.0.rc1.204.g551eb34607-goog

