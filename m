Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828A276835A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 03:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjG3B35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 21:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjG3B3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 21:29:54 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C69F2D47;
        Sat, 29 Jul 2023 18:29:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9922d6f003cso529230466b.0;
        Sat, 29 Jul 2023 18:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690680592; x=1691285392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9OgITT2yiqZUUNG1U4xDDumpCjudK5Ub6jXVaWbbuKI=;
        b=lZMgU3gjYlD/diNHnqBRZUPy+ReTapzTL8Hv9c4ilG8HeXJNSg2rFnNGnV3ZzAGg7w
         IL8+AAVY4nLIBHOo+upAu+tEy1C1iCWvP8NhXcjU9iY/k+l1v5XEyXY2U+bBD9Bk0gkS
         tHIjW2ktEvoAN7ly0mxkm4JLak3mt6oZKjYDyy2hxzfzhn+SunbC9syqdmYOD4kAIQ30
         rq+4qDFtBRZryd194tNihVvhhQUg6CIN+6X5AMaLfovokf5ZtROyHVa7sTZe8/9PvEY8
         gBWTjKrD1Eo9nqbpMzlZFiqzeTUHGVOL+EWw/+cLY0/v395htQ1L5LajaG3ZwHFskWl8
         ettw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690680592; x=1691285392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9OgITT2yiqZUUNG1U4xDDumpCjudK5Ub6jXVaWbbuKI=;
        b=GhFGqYaJ2uCgtwYpUHRC8oBGw1MXSS1AWtpF6uKgCCW2UHxuI4HjEJ04hsuZWCGbyz
         Xm76tudXy650ivnAU9hHgXTluJLSWCgoHi+573NtxuYr5cfQUfVoB6594W0sq1vk4kS7
         B0DIPpUOp+4i5HNQ9vcsIloRgzSWLXZM984BxeSdh7NR2IEKMe8SOQ7W66wH8f3JIjYZ
         sWPqIVd9Og9Yc6Q04bd8RlRFcbF9IMHHsBX0hB2wLGdonkVQa/sabkXKL7QkTjExSQ6W
         UWH2/UCO02Mm+Y1vQOndUbwuGyt3wjApRFri8lkna9GkRrp+5O7NH43gsSMnpik5O0tY
         Y1BQ==
X-Gm-Message-State: ABy/qLYvP9TtIymqmfNBlU82MWVIzxoXDXMFlkHucFS3c7DT/m8JwsUc
        398jN7QQGuJ4XgFSRsSQJgg=
X-Google-Smtp-Source: APBJJlFTQMGWBtK8SuCFhD9DwEnEvBYfJNamT3jZ0CGl1sRmkV+QglVHxqdJsDKKHLYXGG7Mx8AM1g==
X-Received: by 2002:a17:906:8a5c:b0:991:37d2:c9f0 with SMTP id gx28-20020a1709068a5c00b0099137d2c9f0mr3658931ejc.68.1690680591709;
        Sat, 29 Jul 2023 18:29:51 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id ks18-20020a170906f85200b00977ca5de275sm4046161ejb.13.2023.07.29.18.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 18:29:51 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 372F827C005B;
        Sat, 29 Jul 2023 21:29:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 29 Jul 2023 21:29:48 -0400
X-ME-Sender: <xms:C73FZCjd1OzcPshkXyhfzlGtbXscSIZUflf29nOOqolxvVL_FsEYiQ>
    <xme:C73FZDA2Ku6UiqpVDJU9tqMyoHnOx6IJQuSqLIudNjP9qjmOUvxlobYVulPIB29ek
    3yHOdECIhnJKzQZIg>
X-ME-Received: <xmr:C73FZKGKSODL6II2amX88RzH6aYc5TKJ25wIzn0oV1Mei0sBwBgojyrEZ3QZqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieelgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfevffeiueejhfeuiefggeeuheeg
    gefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:C73FZLQYv1rvVB-NR3DyRikDqvRXMA48V6iUKNYMDC31FqUsHNI1xQ>
    <xmx:C73FZPwAw22H0KpBB_Xk6qZ3QsEBivpSMG6MF2IiKHSo54FeerL3rQ>
    <xmx:C73FZJ5vIOB-4p2g7ilMd7lNHwqI-Fd43W0tfujEp3Uv7ORQLc74zQ>
    <xmx:DL3FZKIIPb0tmIV6k3_9nFUtKZHnkm6NjvsOqthZdbD-AQ2VEMApLg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Jul 2023 21:29:47 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Fox Chen <foxhlchen@gmail.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Andreas Hindborg <nmi@metaspace.dk>
Subject: [PATCH 1/3] rust: allocator: Prevent mis-aligned allocation
Date:   Sat, 29 Jul 2023 18:29:02 -0700
Message-ID: <20230730012905.643822-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730012905.643822-1-boqun.feng@gmail.com>
References: <20230730012905.643822-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the rust allocator simply passes the size of the type Layout
to krealloc(), and in theory the alignment requirement from the type
Layout may be larger than the guarantee provided by SLAB, which means
the allocated object is mis-aligned.

Fix this by adjusting the allocation size to the nearest power of two,
which SLAB always guarantees a size-aligned allocation. And because Rust
guarantees that the original size must be a multiple of alignment and
the alignment must be a power of two, then the alignment requirement is
satisfied.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Co-developed-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
Signed-off-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Cc: stable@vger.kernel.org # v6.1+
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/allocator.rs        | 74 ++++++++++++++++++++++++++-------
 2 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3e601ce2548d..058954961bfc 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -13,5 +13,6 @@
 #include <linux/sched.h>
 
 /* `bindgen` gets confused at certain things. */
+const size_t BINDINGS_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
 const gfp_t BINDINGS___GFP_ZERO = __GFP_ZERO;
diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
index 397a3dd57a9b..fae11d1fdba7 100644
--- a/rust/kernel/allocator.rs
+++ b/rust/kernel/allocator.rs
@@ -9,6 +9,36 @@
 
 struct KernelAllocator;
 
+/// Calls `krealloc` with a proper size to alloc a new object aligned to `new_layout`'s alignment.
+///
+/// # Safety
+///
+/// - `ptr` can be either null or a pointer which has been allocated by this allocator.
+/// - `new_layout` must have a non-zero size.
+unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: bindings::gfp_t) -> *mut u8 {
+    // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
+    let layout = new_layout.pad_to_align();
+
+    let mut size = layout.size();
+
+    if layout.align() > bindings::BINDINGS_ARCH_SLAB_MINALIGN {
+        // The alignment requirement exceeds the slab guarantee, thus try to enlarge the size
+        // to use the "power-of-two" size/alignment guarantee (see comments in `kmalloc()` for
+        // more information).
+        //
+        // Note that `layout.size()` (after padding) is guaranteed to be a multiple of
+        // `layout.align()`, so `next_power_of_two` gives enough alignment guarantee.
+        size = size.next_power_of_two();
+    }
+
+    // SAFETY:
+    // - `ptr` is either null or a pointer returned from a previous `k{re}alloc()` by the
+    //   function safety requirement.
+    // - `size` is greater than 0 since it's either a `layout.size()` (which cannot be zero
+    //    according to the function safety requirement) or a result from `next_power_of_two()`.
+    unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, flags) as *mut u8 }
+}
+
 unsafe impl GlobalAlloc for KernelAllocator {
     unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
         // `krealloc()` is used instead of `kmalloc()` because the latter is
@@ -30,10 +60,20 @@ unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
 // to extract the object file that has them from the archive. For the moment,
 // let's generate them ourselves instead.
 //
+// Note: Although these are *safe* functions, but they are only generated at
+// `GlobalAlloc` callsites, hence we assume the parameters obey the same
+// `GlobalAlloc` function safety requirements: size and align should form a
+// valid layout, and size is greater than 0.
+//
 // Note that `#[no_mangle]` implies exported too, nowadays.
 #[no_mangle]
-fn __rust_alloc(size: usize, _align: usize) -> *mut u8 {
-    unsafe { bindings::krealloc(core::ptr::null(), size, bindings::GFP_KERNEL) as *mut u8 }
+fn __rust_alloc(size: usize, align: usize) -> *mut u8 {
+    // SAFETY: See assumption above.
+    let layout = unsafe { Layout::from_size_align_unchecked(size, align) };
+
+    // SAFETY: `ptr::null_mut()` is null, per assumption above the size of `layout` is greater
+    // than 0.
+    unsafe { krealloc_aligned(ptr::null_mut(), layout, bindings::GFP_KERNEL) }
 }
 
 #[no_mangle]
@@ -42,23 +82,27 @@ fn __rust_dealloc(ptr: *mut u8, _size: usize, _align: usize) {
 }
 
 #[no_mangle]
-fn __rust_realloc(ptr: *mut u8, _old_size: usize, _align: usize, new_size: usize) -> *mut u8 {
-    unsafe {
-        bindings::krealloc(
-            ptr as *const core::ffi::c_void,
-            new_size,
-            bindings::GFP_KERNEL,
-        ) as *mut u8
-    }
+fn __rust_realloc(ptr: *mut u8, _old_size: usize, align: usize, new_size: usize) -> *mut u8 {
+    // SAFETY: See assumption above.
+    let new_layout = unsafe { Layout::from_size_align_unchecked(new_size, align) };
+
+    // SAFETY: Per assumption above, `ptr` is allocated by `__rust_*` before, and the size of
+    // `new_layout` is greater than 0.
+    unsafe { krealloc_aligned(ptr, new_layout, bindings::GFP_KERNEL) }
 }
 
 #[no_mangle]
-fn __rust_alloc_zeroed(size: usize, _align: usize) -> *mut u8 {
+fn __rust_alloc_zeroed(size: usize, align: usize) -> *mut u8 {
+    // SAFETY: See assumption above.
+    let layout = unsafe { Layout::from_size_align_unchecked(size, align) };
+
+    // SAFETY: `ptr::null_mut()` is null, per assumption above the size of `layout` is greater
+    // than 0.
     unsafe {
-        bindings::krealloc(
-            core::ptr::null(),
-            size,
+        krealloc_aligned(
+            ptr::null_mut(),
+            layout,
             bindings::GFP_KERNEL | bindings::__GFP_ZERO,
-        ) as *mut u8
+        )
     }
 }
-- 
2.41.0

