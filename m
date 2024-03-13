Return-Path: <linux-kernel+bounces-101408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D531587A6C0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D73E1F2372E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2516447F7A;
	Wed, 13 Mar 2024 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="YMyqvaV/"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F49D45BE7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327973; cv=none; b=RABZFX8ufqnTk+ErqptEG/tMu63hmqkpi9xoEQyxLScdj/FmS3BEKvllhwA2SfEpafy76kJJle1yu313V3IlYkE5EeyaMpw6k83mJlx843dTW1ECyrKQTBJYoV4y7pnFYuoohbKU3t3Io5uiI/kUQVZvi4Q8N6ICMgofmVBJ7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327973; c=relaxed/simple;
	bh=5GbuDkx/t3ca+1vsJKcxunbH6qs63waeRLqj2MYB5Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7QUBt2vsTPEqJz1VmBYC52oGvbKRcPl54MGpYKHezxNgSBhaknQb2+KH+B2wwPEubWM0Cskw0FGQPQI5R86ChuOjQIeaad1rbbgkgPkpIf2e6V6hKVo/Fc/uVWVNMjSW1359rqT9jVnKalhCH4BRNdT/sy4yCjeBrWQ6Rx/saQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=YMyqvaV/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5683576ea18so6719347a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710327969; x=1710932769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02J+9loqch2JUjY1j89Pn56oCFWFFh5txriQBAftH6E=;
        b=YMyqvaV/Iv9S0jEpsLdgxswKxB8JYgX1XANbrdRmBZIkCsi7b/mfoyCumU2FVpomz5
         5IWzMZe3mC/DS/PypAX6TzxtaTySW7iqx1kPleAixDW0fatBuNQhsCUMYXPQdJwGUmgi
         uFIgme1Y0OGg8tBpUXH19FGsUREWvxfYm1FWjLoZJlF1l0WYU2TVuFfTeG9gtBqU/6iK
         Xl8JwkH55K5tuNS9rUaJ/KtRRxGX60bQ5TYktSkivhHKBY7z0zMb2IXjWLPIp36dLM6l
         2KRH24Ftb0GpmY6Ia450eF5yOzwsVsvqsq3PsSN0iScRyNSnsPLo9gM+xoXSuzWe0Ncm
         h9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710327969; x=1710932769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02J+9loqch2JUjY1j89Pn56oCFWFFh5txriQBAftH6E=;
        b=CC+fB4T8Q8+7FXUiz/YB5O50iruJ+sbRUk3/ux7k4XwwMQWEA6GrLy+C4OSVzRUNCH
         yybtTrz/8H8hT9I7spUpxDujgirmU3sMnFSw3thBtgFpgTkJeoDh3rQFCVB+ZQ94NF2Q
         APXAYFVmm+qtYZfVG2qE4yKlbkEXZ6DqpTxwDhLXh4SURu1PrPzcv/LtPS/JPEx4CiYy
         3j9Wc8FZZgTaJ/54MxCCPwiJhpQwfK9NGMpmlbuDCVpsStceBjSSLHlpbyIU0CqZf4pp
         ZCAUTJGWYGWCvT2vyIA2pSAtGbcyQaxTmqqzVuk55QVLpL/gThwQ9y7x9G1Thvp5NQnO
         WLjg==
X-Forwarded-Encrypted: i=1; AJvYcCWPMRsqFUOKpXv6loKEo85GlkCIxw4o7h9ZiAYAVWho5Lsyvb1LOPJpBhxQ7P4m9BtQnj5HmU5v2JfzOu3i/hYfOMq7IK+VisM74iFy
X-Gm-Message-State: AOJu0YwlIVfgb52O7eZoETIgMfU8HQXbrHCZE48yyvTxFfeq9arL4eWb
	g+lpuVWhYXWYne6AF19vodkoI0PXiwI0Zlwmid3jNTr/axZdV4FoPl7jzcXtYLE=
X-Google-Smtp-Source: AGHT+IEcThuL3vIoWtwKtXW9tSmz7xjNlpNKF5lpt2rzWBNXagbGz7lsNNxPgXrvJ1Nn9AxFGjtUgA==
X-Received: by 2002:a17:907:972a:b0:a45:f4c2:38d7 with SMTP id jg42-20020a170907972a00b00a45f4c238d7mr8536226ejc.18.1710327969457;
        Wed, 13 Mar 2024 04:06:09 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id jx15-20020a170907760f00b00a466591eaebsm55134ejc.194.2024.03.13.04.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 04:06:09 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yexuan Yang <1182282462@bupt.edu.cn>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: [RFC PATCH 2/5] rust: block: introduce `kernel::block::bio` module
Date: Wed, 13 Mar 2024 12:05:09 +0100
Message-ID: <20240313110515.70088-3-nmi@metaspace.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313110515.70088-1-nmi@metaspace.dk>
References: <20240313110515.70088-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Add abstractions for working with `struct bio`.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/kernel/block.rs            |   1 +
 rust/kernel/block/bio.rs        | 112 +++++++++++++
 rust/kernel/block/bio/vec.rs    | 279 ++++++++++++++++++++++++++++++++
 rust/kernel/block/mq/request.rs |  22 +++
 4 files changed, 414 insertions(+)
 create mode 100644 rust/kernel/block/bio.rs
 create mode 100644 rust/kernel/block/bio/vec.rs

diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
index 4c93317a568a..1797859551fd 100644
--- a/rust/kernel/block.rs
+++ b/rust/kernel/block.rs
@@ -2,4 +2,5 @@
 
 //! Types for working with the block layer
 
+pub mod bio;
 pub mod mq;
diff --git a/rust/kernel/block/bio.rs b/rust/kernel/block/bio.rs
new file mode 100644
index 000000000000..0d4336cbe9c1
--- /dev/null
+++ b/rust/kernel/block/bio.rs
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Types for working with the bio layer.
+//!
+//! C header: [`include/linux/blk_types.h`](../../include/linux/blk_types.h)
+
+use core::fmt;
+use core::ptr::NonNull;
+
+mod vec;
+
+pub use vec::BioSegmentIterator;
+pub use vec::Segment;
+
+use crate::types::Opaque;
+
+/// A block device IO descriptor (`struct bio`)
+///
+/// # Invariants
+///
+/// Instances of this type is always reference counted. A call to
+/// `bindings::bio_get()` ensures that the instance is valid for read at least
+/// until a matching call to `bindings :bio_put()`.
+#[repr(transparent)]
+pub struct Bio(Opaque<bindings::bio>);
+
+impl Bio {
+    /// Returns an iterator over segments in this `Bio`. Does not consider
+    /// segments of other bios in this bio chain.
+    #[inline(always)]
+    pub fn segment_iter(&self) -> BioSegmentIterator<'_> {
+        BioSegmentIterator::new(self)
+    }
+
+    /// Get slice referencing the `bio_vec` array of this bio
+    #[inline(always)]
+    fn io_vec(&self) -> &[bindings::bio_vec] {
+        let this = self.0.get();
+
+        // SAFETY: By the type invariant of `Bio` and existence of `&self`,
+        // `this` is valid for read.
+        let io_vec = unsafe { (*this).bi_io_vec };
+
+        // SAFETY: By the type invariant of `Bio` and existence of `&self`,
+        // `this` is valid for read.
+        let length = unsafe { (*this).bi_vcnt };
+
+        // SAFETY: By C API contract, `io_vec` points to `length` consecutive
+        // and properly initialized `bio_vec` values. The array is properly
+        // aligned because it is #[repr(C)]. By C API contract and safety
+        // requirement of `from_raw()`, the elements of the `io_vec` array are
+        // not modified for the duration of the lifetime of `&self`
+        unsafe { core::slice::from_raw_parts(io_vec, length as usize) }
+    }
+
+    /// Return a copy of the `bvec_iter` for this `Bio`. This iterator always
+    /// indexes to a valid `bio_vec` entry.
+    #[inline(always)]
+    fn raw_iter(&self) -> bindings::bvec_iter {
+        // SAFETY: By the type invariant of `Bio` and existence of `&self`,
+        // `self` is valid for read.
+        unsafe { (*self.0.get()).bi_iter }
+    }
+
+    /// Get the next `Bio` in the chain
+    #[inline(always)]
+    fn next(&self) -> Option<&Self> {
+        // SAFETY: By the type invariant of `Bio` and existence of `&self`,
+        // `self` is valid for read.
+        let next = unsafe { (*self.0.get()).bi_next };
+        // SAFETY: By C API contract `bi_next` has nonzero reference count if it
+        // is not null, for at least the duration of the lifetime of &self.
+        unsafe { Self::from_raw(next) }
+    }
+
+    /// Create an instance of `Bio` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// If `ptr` is not null, caller must ensure positive refcount for the
+    /// pointee and immutability for the duration of the returned lifetime.
+    #[inline(always)]
+    pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::bio) -> Option<&'a Self> {
+        Some(
+            // SAFETY: by the safety requirement of this funciton, `ptr` is
+            // valid for read for the duration of the returned lifetime
+            unsafe { &*NonNull::new(ptr)?.as_ptr().cast::<Bio>() },
+        )
+    }
+}
+
+impl core::fmt::Display for Bio {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        write!(f, "Bio({:?})", self.0.get())
+    }
+}
+
+/// An iterator over `Bio`
+pub struct BioIterator<'a> {
+    pub(crate) bio: Option<&'a Bio>,
+}
+
+impl<'a> core::iter::Iterator for BioIterator<'a> {
+    type Item = &'a Bio;
+
+    #[inline(always)]
+    fn next(&mut self) -> Option<&'a Bio> {
+        let current = self.bio.take()?;
+        self.bio = current.next();
+        Some(current)
+    }
+}
diff --git a/rust/kernel/block/bio/vec.rs b/rust/kernel/block/bio/vec.rs
new file mode 100644
index 000000000000..b61380807f38
--- /dev/null
+++ b/rust/kernel/block/bio/vec.rs
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Types for working with `struct bio_vec` IO vectors
+//!
+//! C header: [`include/linux/bvec.h`](../../include/linux/bvec.h)
+
+use super::Bio;
+use crate::error::Result;
+use crate::folio::UniqueFolio;
+use crate::page::Page;
+use core::fmt;
+use core::mem::ManuallyDrop;
+
+/// A wrapper around a `strutct bio_vec` - a contiguous range of physical memory addresses
+///
+/// # Invariants
+///
+/// `bio_vec` must always be initialized and valid for read and write
+pub struct Segment<'a> {
+    bio_vec: bindings::bio_vec,
+    _marker: core::marker::PhantomData<&'a ()>,
+}
+
+impl Segment<'_> {
+    /// Get he lenght of the segment in bytes
+    #[inline(always)]
+    pub fn len(&self) -> usize {
+        self.bio_vec.bv_len as usize
+    }
+
+    /// Returns true if the length of the segment is 0
+    #[inline(always)]
+    pub fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Get the offset field of the `bio_vec`
+    #[inline(always)]
+    pub fn offset(&self) -> usize {
+        self.bio_vec.bv_offset as usize
+    }
+
+    /// Copy data of this segment into `folio`.
+    ///
+    /// Note: Disregards `self.offset()`
+    #[inline(always)]
+    pub fn copy_to_folio(&self, dst_folio: &mut UniqueFolio) -> Result {
+        // SAFETY: self.bio_vec is valid and thus bv_page must be a valid
+        // pointer to a `struct page`. We do not own the page, but we prevent
+        // drop by wrapping the `Page` in `ManuallyDrop`.
+        let src_page = ManuallyDrop::new(unsafe { Page::from_raw(self.bio_vec.bv_page) });
+
+        src_page.with_slice_into_page(|src| {
+            dst_folio.with_slice_into_page_mut(0, |dst| {
+                dst.copy_from_slice(src);
+                Ok(())
+            })
+        })
+    }
+
+    /// Copy data to the page of this segment from `src`.
+    ///
+    /// Note: Disregards `self.offset()`
+    pub fn copy_from_folio(&mut self, src_folio: &UniqueFolio) -> Result {
+        // SAFETY: self.bio_vec is valid and thus bv_page must be a valid
+        // pointer to a `struct page`. We do not own the page, but we prevent
+        // drop by wrapping the `Page` in `ManuallyDrop`.
+        let mut dst_page = ManuallyDrop::new(unsafe { Page::from_raw(self.bio_vec.bv_page) });
+
+        dst_page.with_slice_into_page_mut(|dst| {
+            src_folio.with_slice_into_page(0, |src| {
+                dst.copy_from_slice(src);
+                Ok(())
+            })
+        })
+    }
+}
+
+impl core::fmt::Display for Segment<'_> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        write!(
+            f,
+            "Segment {:?} len: {}",
+            self.bio_vec.bv_page, self.bio_vec.bv_len
+        )
+    }
+}
+
+/// An iterator over `Segment`
+///
+/// # Invariants
+///
+/// If `iter.bi_size` > 0, `iter` must always index a valid `bio_vec` in `bio.io_vec()`.
+pub struct BioSegmentIterator<'a> {
+    bio: &'a Bio,
+    iter: bindings::bvec_iter,
+}
+
+impl<'a> BioSegmentIterator<'a> {
+    /// Creeate a new segemnt iterator for iterating the segments of `bio`. The
+    /// iterator starts at the beginning of `bio`.
+    #[inline(always)]
+    pub(crate) fn new(bio: &'a Bio) -> BioSegmentIterator<'_> {
+        // SAFETY: `bio.raw_iter()` returns an index that indexes into a valid
+        // `bio_vec` in `bio.io_vec()`.
+        Self {
+            bio,
+            iter: bio.raw_iter(),
+        }
+    }
+
+    // The accessors in this implementation block are modelled after C side
+    // macros and static functions `bvec_iter_*` and `mp_bvec_iter_*` from
+    // bvec.h.
+
+    /// Construct a `bio_vec` from the current iterator state.
+    ///
+    /// This will return a `bio_vec`of size <= PAGE_SIZE
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that `self.iter.bi_size` > 0 before calling this
+    /// method.
+    unsafe fn io_vec(&self) -> bindings::bio_vec {
+        // SAFETY: By safety requirement of this function `self.iter.bi_size` is
+        // greater than 0.
+        unsafe {
+            bindings::bio_vec {
+                bv_page: self.page(),
+                bv_len: self.len(),
+                bv_offset: self.offset(),
+            }
+        }
+    }
+
+    /// Get the currently indexed `bio_vec` entry.
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that `self.iter.bi_size` > 0 before calling this
+    /// method.
+    #[inline(always)]
+    unsafe fn bvec(&self) -> &bindings::bio_vec {
+        // SAFETY: By the safety requirement of this function and the type
+        // invariant of `Self`, `self.iter.bi_idx` indexes into a valid
+        // `bio_vec`
+        unsafe { self.bio.io_vec().get_unchecked(self.iter.bi_idx as usize) }
+    }
+
+    /// Get the currently indexed page, indexing into pages of order > 0.
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that `self.iter.bi_size` > 0 before calling this
+    /// method.
+    #[inline(always)]
+    unsafe fn page(&self) -> *mut bindings::page {
+        // SAFETY: By C API contract, the following offset cannot exceed pages
+        // allocated to this bio.
+        unsafe { self.mp_page().add(self.mp_page_idx()) }
+    }
+
+    /// Get the remaining bytes in the current page. Never more than PAGE_SIZE.
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that `self.iter.bi_size` > 0 before calling this
+    /// method.
+    #[inline(always)]
+    unsafe fn len(&self) -> u32 {
+        // SAFETY: By safety requirement of this function `self.iter.bi_size` is
+        // greater than 0.
+        unsafe { self.mp_len().min((bindings::PAGE_SIZE as u32) - self.offset()) }
+    }
+
+    /// Get the offset from the last page boundary in the currently indexed
+    /// `bio_vec` entry. Never more than PAGE_SIZE.
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that `self.iter.bi_size` > 0 before calling this
+    /// method.
+    #[inline(always)]
+    unsafe fn offset(&self) -> u32 {
+        // SAFETY: By safety requirement of this function `self.iter.bi_size` is
+        // greater than 0.
+        unsafe { self.mp_offset() % (bindings::PAGE_SIZE as u32) }
+    }
+
+    /// Return the first page of the currently indexed `bio_vec` entry. This
+    /// might be a multi-page entry, meaning that page might have order > 0.
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that `self.iter.bi_size` > 0 before calling this
+    /// method.
+    #[inline(always)]
+    unsafe fn mp_page(&self) -> *mut bindings::page {
+        // SAFETY: By safety requirement of this function `self.iter.bi_size` is
+        // greater than 0.
+        unsafe { self.bvec().bv_page }
+    }
+
+    /// Get the offset in whole pages into the currently indexed `bio_vec`. This
+    /// can be more than 0 is the page has order > 0.
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that `self.iter.bi_size` > 0 before calling this
+    /// method.
+    #[inline(always)]
+    unsafe fn mp_page_idx(&self) -> usize {
+        // SAFETY: By safety requirement of this function `self.iter.bi_size` is
+        // greater than 0.
+        (unsafe { self.mp_offset() } / (bindings::PAGE_SIZE as u32)) as usize
+    }
+
+    /// Get the offset in the currently indexed `bio_vec` multi-page entry. This
+    /// can be more than `PAGE_SIZE` if the page has order > 0.
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that `self.iter.bi_size` > 0 before calling this
+    /// method.
+    #[inline(always)]
+    unsafe fn mp_offset(&self) -> u32 {
+        // SAFETY: By safety requirement of this function `self.iter.bi_size` is
+        // greater than 0.
+        unsafe { self.bvec().bv_offset + self.iter.bi_bvec_done }
+    }
+
+    /// Get the number of remaining bytes for the currently indexed `bio_vec`
+    /// entry. Can be more than PAGE_SIZE for `bio_vec` entries with pages of
+    /// order > 0.
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that `self.iter.bi_size` > 0 before calling this
+    /// method.
+    #[inline(always)]
+    unsafe fn mp_len(&self) -> u32 {
+        // SAFETY: By safety requirement of this function `self.iter.bi_size` is
+        // greater than 0.
+        self.iter
+            .bi_size
+            .min(unsafe { self.bvec().bv_len } - self.iter.bi_bvec_done)
+    }
+}
+
+impl<'a> core::iter::Iterator for BioSegmentIterator<'a> {
+    type Item = Segment<'a>;
+
+    #[inline(always)]
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.iter.bi_size == 0 {
+            return None;
+        }
+
+        // SAFETY: We checked that `self.iter.bi_size` > 0 above.
+        let bio_vec_ret = unsafe { self.io_vec() };
+
+        // SAFETY: By existence of reference `&bio`, `bio.0` contains a valid
+        // `struct bio`. By type invariant of `BioSegmentItarator` `self.iter`
+        // indexes into a valid `bio_vec` entry. By C API contracit, `bv_len`
+        // does not exceed the size of the bio.
+        unsafe {
+            bindings::bio_advance_iter_single(
+                self.bio.0.get(),
+                &mut self.iter as *mut bindings::bvec_iter,
+                bio_vec_ret.bv_len,
+            )
+        };
+
+        Some(Segment {
+            bio_vec: bio_vec_ret,
+            _marker: core::marker::PhantomData,
+        })
+    }
+}
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index b4dacac5e091..cccffde45981 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -12,6 +12,9 @@
 };
 use core::{ffi::c_void, marker::PhantomData, ops::Deref};
 
+use crate::block::bio::Bio;
+use crate::block::bio::BioIterator;
+
 /// A wrapper around a blk-mq `struct request`. This represents an IO request.
 ///
 /// # Invariants
@@ -84,6 +87,25 @@ pub fn complete(&self) {
         }
     }
 
+    /// Get a wrapper for the first Bio in this request
+    #[inline(always)]
+    pub fn bio(&self) -> Option<&Bio> {
+        // SAFETY: By type invariant of `Self`, `self.0` is valid and the deref
+        // is safe.
+        let ptr = unsafe { (*self.0.get()).bio };
+        // SAFETY: By C API contract, if `bio` is not null it will have a
+        // positive refcount at least for the duration of the lifetime of
+        // `&self`.
+        unsafe { Bio::from_raw(ptr) }
+    }
+
+    /// Get an iterator over all bio structurs in this request
+    #[inline(always)]
+    pub fn bio_iter(&self) -> BioIterator<'_> {
+        BioIterator { bio: self.bio() }
+    }
+
+    // TODO: Check if inline is still required for cross language LTO inlining into module
     /// Get the target sector for the request
     #[inline(always)]
     pub fn sector(&self) -> usize {
-- 
2.44.0


