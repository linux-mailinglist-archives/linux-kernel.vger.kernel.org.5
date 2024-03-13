Return-Path: <linux-kernel+bounces-101405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A143687A6B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17471F2306A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7834C4502A;
	Wed, 13 Mar 2024 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="C8cxM58E"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6629B3EA73
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327967; cv=none; b=WpOAC/Gn1So1H3MVJrEPaSC4vIZ6/WCM5aa7AQtB7pam/TfKlKCo18gFyrQtbiiYoEVnnirXLsZAzEAqy/6ZCmOqMP8YgiUvDm+gemsNddgK2w4524WJq3bUnavo4g/t1qr7ajcfT/ZAyfpfy217SD1+4Lmj0JvgpXB1nVj3S1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327967; c=relaxed/simple;
	bh=1rhmU2NQyW+9Rdpg1mV7M0CtrPXezOlGfXhfyCqegsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8au22ulq0YgrltvXWa7iC7+cu5irbuDKc/kv3L51rB+T092N8TDB6cEM3kreGbd2YY0czaP/QYEk2mNSvUqEVPWlWGajdyExcD/l83qknUL/PmB4NRf0wlyY7+ci+D6vnNAVKR1qE7oSkHhRigFIusyy8NWZ8dIdP+aPHsDXlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=C8cxM58E; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5683089d4bbso6861056a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710327960; x=1710932760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sp/Ey74sP9Gtfb+86ib35pCPiq2qRX9gsOvaZhkhKKA=;
        b=C8cxM58ET92KJco+um6lej3AGihHDjjke0XvYfqbYBRO9Q7Ect1nNbYas8+ZKom3Xx
         sZnzk0paWMtBXycL+haJhnPEEzMquLt50qw+nKVDKqYNGSU8sLiTmSNdSFILhAf0w1qW
         xf2e7t8NxmdCQviwBXmcVrTQmPNjJ2vf5XLkaQZo7tFQ/0YGJPeKBFKNpA6h6qabFOAM
         Fqu9d0UWRNWUhNEi7jZnDAG+WDB/45nrmAQt14/AD2yw3W2LLfFbQNFJ6XfA/AXaL86H
         3sJpUkkna7Nk5/Bw+ViKIjxm+bon4LxBqDeceMMwMJTiRTxJEWhh/YVBZQNnyq4DHZup
         doKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710327960; x=1710932760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sp/Ey74sP9Gtfb+86ib35pCPiq2qRX9gsOvaZhkhKKA=;
        b=IO/Y3ho4BkhZoFCynhpiq2x6UpnfZ2VF6hY0d9WxNDvuTpvAEcQEue6r6X1GDYPeeK
         WytCSQwm1mwdMPhcfGmmI0T/B5ZLuzesTEBU1D2n0FRqpgLZcwjcquPRNGe9G+aEVzbn
         +GCC0dKYWdeaM1iVWA0+RpGVQ0y2UlI6fOEM78uRabGjBPXtWg1BJQutgBCw7QeIKKWc
         +v2DbGQju459SmtFTQpdGgSxVSRdfevy36PEnA77Z2uOEBPmyVFAGLkts8nvAR5lID2S
         l9HDw/uoNfRySoS7JWi7wcWc3PrfSQePvYT4/oJFUmXQ4kMfk5kaxrKJh/PK1aoV6taq
         2RXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXSQdlEnGMcKiuc3oZvP7mSdEMMyWa3OUuJgPG2KyIhoH1K9q14JFpWca8BHwOQh6fGjejeOZlfzmxUtGwoSBWZ2O5IM+FYyidrOJt
X-Gm-Message-State: AOJu0Yz4NWMdwOCc23W/vSATCp+1qa6qfTvwfTIEKtnJ1AayGKNDdvQJ
	gZmjLvCu8hStkggCH03pjCFKjmkSCkJI5okDzoRXGmaS8UXKVCIkJtZtqra2xkU=
X-Google-Smtp-Source: AGHT+IG7C2yM2s7J6HGytUSWEztMufd0QwrIXAkcdhYXn4o1QB2jm07z/FOgeJrXEorUA5uZtOgSXA==
X-Received: by 2002:a17:906:7f92:b0:a46:651f:8e7f with SMTP id f18-20020a1709067f9200b00a46651f8e7fmr223410ejr.38.1710327959719;
        Wed, 13 Mar 2024 04:05:59 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id n18-20020a1709061d1200b00a46478fbbbesm1376173ejh.153.2024.03.13.04.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 04:05:59 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
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
Subject: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
Date: Wed, 13 Mar 2024 12:05:08 +0100
Message-ID: <20240313110515.70088-2-nmi@metaspace.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313110515.70088-1-nmi@metaspace.dk>
References: <20240313110515.70088-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Add initial abstractions for working with blk-mq.

This patch is a maintained, refactored subset of code originally published by
Wedson Almeida Filho <wedsonaf@gmail.com> [1].

[1] https://github.com/wedsonaf/linux/tree/f2cfd2fe0e2ca4e90994f96afe268bbd4382a891/rust/kernel/blk/mq.rs

Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 block/blk-mq.c                     |   3 +-
 include/linux/blk-mq.h             |   1 +
 rust/bindings/bindings_helper.h    |   2 +
 rust/helpers.c                     |  45 ++++
 rust/kernel/block.rs               |   5 +
 rust/kernel/block/mq.rs            | 131 +++++++++++
 rust/kernel/block/mq/gen_disk.rs   | 174 +++++++++++++++
 rust/kernel/block/mq/operations.rs | 346 +++++++++++++++++++++++++++++
 rust/kernel/block/mq/raw_writer.rs |  60 +++++
 rust/kernel/block/mq/request.rs    | 182 +++++++++++++++
 rust/kernel/block/mq/tag_set.rs    | 117 ++++++++++
 rust/kernel/error.rs               |   5 +
 rust/kernel/lib.rs                 |   1 +
 13 files changed, 1071 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/block.rs
 create mode 100644 rust/kernel/block/mq.rs
 create mode 100644 rust/kernel/block/mq/gen_disk.rs
 create mode 100644 rust/kernel/block/mq/operations.rs
 create mode 100644 rust/kernel/block/mq/raw_writer.rs
 create mode 100644 rust/kernel/block/mq/request.rs
 create mode 100644 rust/kernel/block/mq/tag_set.rs

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2dc01551e27c..a531f664bee7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -702,7 +702,7 @@ static void blk_mq_finish_request(struct request *rq)
 	}
 }
 
-static void __blk_mq_free_request(struct request *rq)
+void __blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
@@ -722,6 +722,7 @@ static void __blk_mq_free_request(struct request *rq)
 	blk_mq_sched_restart(hctx);
 	blk_queue_exit(q);
 }
+EXPORT_SYMBOL_GPL(__blk_mq_free_request);
 
 void blk_mq_free_request(struct request *rq)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 7a8150a5f051..842bb88e6e78 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -703,6 +703,7 @@ int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
 		unsigned int set_flags);
 void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
 
+void __blk_mq_free_request(struct request *rq);
 void blk_mq_free_request(struct request *rq);
 int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
 		unsigned int poll_flags);
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index f8e54d398c19..df18acb229d9 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,8 @@
  */
 
 #include <kunit/test.h>
+#include <linux/blk_types.h>
+#include <linux/blk-mq.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/mdio.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index 66411845536e..017fa90366e6 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -21,6 +21,9 @@
  */
 
 #include <kunit/test-bug.h>
+#include <linux/bio.h>
+#include <linux/blk-mq.h>
+#include <linux/blkdev.h>
 #include <linux/bug.h>
 #include <linux/build_bug.h>
 #include <linux/cacheflush.h>
@@ -242,6 +245,30 @@ void *rust_helper_kmap_local_folio(struct folio *folio, size_t offset)
 }
 EXPORT_SYMBOL_GPL(rust_helper_kmap_local_folio);
 
+struct bio_vec rust_helper_req_bvec(struct request *rq)
+{
+	return req_bvec(rq);
+}
+EXPORT_SYMBOL_GPL(rust_helper_req_bvec);
+
+void *rust_helper_blk_mq_rq_to_pdu(struct request *rq)
+{
+	return blk_mq_rq_to_pdu(rq);
+}
+EXPORT_SYMBOL_GPL(rust_helper_blk_mq_rq_to_pdu);
+
+struct request *rust_helper_blk_mq_rq_from_pdu(void* pdu) {
+  return blk_mq_rq_from_pdu(pdu);
+}
+EXPORT_SYMBOL_GPL(rust_helper_blk_mq_rq_from_pdu);
+
+void rust_helper_bio_advance_iter_single(const struct bio *bio,
+                                         struct bvec_iter *iter,
+                                         unsigned int bytes) {
+  bio_advance_iter_single(bio, iter, bytes);
+}
+EXPORT_SYMBOL_GPL(rust_helper_bio_advance_iter_single);
+
 void *rust_helper_kmap(struct page *page)
 {
 	return kmap(page);
@@ -306,6 +333,24 @@ int rust_helper_xa_err(void *entry)
 }
 EXPORT_SYMBOL_GPL(rust_helper_xa_err);
 
+bool rust_helper_req_ref_inc_not_zero(struct request *req)
+{
+	return atomic_inc_not_zero(&req->ref);
+}
+EXPORT_SYMBOL_GPL(rust_helper_req_ref_inc_not_zero);
+
+bool rust_helper_req_ref_put_and_test(struct request *req)
+{
+	return atomic_dec_and_test(&req->ref);
+}
+EXPORT_SYMBOL_GPL(rust_helper_req_ref_put_and_test);
+
+void rust_helper_blk_mq_free_request_internal(struct request *req)
+{
+	__blk_mq_free_request(req);
+}
+EXPORT_SYMBOL_GPL(rust_helper_blk_mq_free_request_internal);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
new file mode 100644
index 000000000000..4c93317a568a
--- /dev/null
+++ b/rust/kernel/block.rs
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Types for working with the block layer
+
+pub mod mq;
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
new file mode 100644
index 000000000000..08de1cc114ff
--- /dev/null
+++ b/rust/kernel/block/mq.rs
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This module provides types for implementing block drivers that interface the
+//! blk-mq subsystem.
+//!
+//! To implement a block device driver, a Rust module must do the following:
+//!
+//! - Implement [`Operations`] for a type `T`
+//! - Create a [`TagSet<T>`]
+//! - Create a [`GenDisk<T>`], passing in the `TagSet` reference
+//! - Add the disk to the system by calling [`GenDisk::add`]
+//!
+//! The types available in this module that have direct C counterparts are:
+//!
+//! - The `TagSet` type that abstracts the C type `struct tag_set`.
+//! - The `GenDisk` type that abstracts the C type `struct gendisk`.
+//! - The `Request` type that abstracts the C type `struct request`.
+//!
+//! Many of the C types that this module abstracts allow a driver to carry
+//! private data, either embedded in the stuct directly, or as a C `void*`. In
+//! these abstractions, this data is typed. The types of the data is defined by
+//! associated types in `Operations`, see [`Operations::RequestData`] for an
+//! example.
+//!
+//! The kernel will interface with the block evice driver by calling the method
+//! implementations of the `Operations` trait.
+//!
+//! IO requests are passed to the driver as [`Request`] references. The
+//! `Request` type is a wrapper around the C `struct request`. The driver must
+//! mark start of request processing by calling [`Request::start`] and end of
+//! processing by calling one of the [`Request::end`], methods. Failure to do so
+//! can lead to IO failures.
+//!
+//! The `TagSet` is responsible for creating and maintaining a mapping between
+//! `Request`s and integer ids as well as carrying a pointer to the vtable
+//! generated by `Operations`. This mapping is useful for associating
+//! completions from hardware with the correct `Request` instance. The `TagSet`
+//! determines the maximum queue depth by setting the number of `Request`
+//! instances available to the driver, and it determines the number of queues to
+//! instantiate for the driver. If possible, a driver should allocate one queue
+//! per core, to keep queue data local to a core.
+//!
+//! One `TagSet` instance can be shared between multiple `GenDisk` instances.
+//! This can be useful when implementing drivers where one piece of hardware
+//! with one set of IO resources are represented to the user as multiple disks.
+//!
+//! One significant difference between block device drivers implemented with
+//! these Rust abstractions and drivers implemented in C, is that the Rust
+//! drivers have to own a reference count on the `Request` type when the IO is
+//! in flight. This is to ensure that the C `struct request` instances backing
+//! the Rust `Request` instances are live while the Rust driver holds a
+//! reference to the `Request`. In addition, the conversion of an ineger tag to
+//! a `Request` via the `TagSet` would not be sound without this bookkeeping.
+//!
+//! # ⚠ Note
+//!
+//! For Rust block device drivers, the point in time where a request
+//! is freed and made available for recycling is usualy at the point in time
+//! when the last `ARef<Request>` is dropped. For C drivers, this event usually
+//! occurs when `bindings::blk_mq_end_request` is called.
+//!
+//! # Example
+//!
+//! ```rust
+//! use kernel::{
+//!     block::mq::*,
+//!     new_mutex,
+//!     prelude::*,
+//!     sync::{Arc, Mutex},
+//!     types::{ARef, ForeignOwnable},
+//! };
+//!
+//! struct MyBlkDevice;
+//!
+//! #[vtable]
+//! impl Operations for MyBlkDevice {
+//!     type RequestData = ();
+//!     type RequestDataInit = impl PinInit<()>;
+//!     type QueueData = ();
+//!     type HwData = ();
+//!     type TagSetData = ();
+//!
+//!     fn new_request_data(
+//!         _tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed<'_>,
+//!     ) -> Self::RequestDataInit {
+//!         kernel::init::zeroed()
+//!     }
+//!
+//!     fn queue_rq(_hw_data: (), _queue_data: (), rq: ARef<Request<Self>>, _is_last: bool) -> Result {
+//!         rq.start();
+//!         rq.end_ok();
+//!         Ok(())
+//!     }
+//!
+//!     fn commit_rqs(
+//!         _hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>,
+//!         _queue_data: <Self::QueueData as ForeignOwnable>::Borrowed<'_>,
+//!     ) {
+//!     }
+//!
+//!     fn complete(rq: &Request<Self>) {
+//!         rq.end_ok();
+//!     }
+//!
+//!     fn init_hctx(
+//!         _tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed<'_>,
+//!         _hctx_idx: u32,
+//!     ) -> Result<Self::HwData> {
+//!         Ok(())
+//!     }
+//! }
+//!
+//! let tagset: Arc<TagSet<MyBlkDevice>> = Arc::pin_init(TagSet::try_new(1, (), 256, 1))?;
+//! let mut disk = GenDisk::try_new(tagset, ())?;
+//! disk.set_name(format_args!("myblk"))?;
+//! disk.set_capacity_sectors(4096);
+//! disk.add()?;
+//!
+//! # Ok::<(), kernel::error::Error>(())
+//! ```
+
+mod gen_disk;
+mod operations;
+mod raw_writer;
+mod request;
+mod tag_set;
+
+pub use gen_disk::GenDisk;
+pub use operations::Operations;
+pub use request::{Request, RequestDataRef};
+pub use tag_set::TagSet;
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
new file mode 100644
index 000000000000..b7845fc9e39f
--- /dev/null
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic disk abstraction.
+//!
+//! C header: [`include/linux/blkdev.h`](srctree/include/linux/blkdev.h)
+//! C header: [`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
+
+use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
+use crate::{
+    bindings, error::from_err_ptr, error::Result, sync::Arc, types::ForeignOwnable,
+    types::ScopeGuard,
+};
+use core::fmt::{self, Write};
+
+/// A generic block device
+///
+/// # Invariants
+///
+///  - `gendisk` must always point to an initialized and valid `struct gendisk`.
+pub struct GenDisk<T: Operations> {
+    _tagset: Arc<TagSet<T>>,
+    gendisk: *mut bindings::gendisk,
+}
+
+// SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `Arc` to a
+// `TagSet` It is safe to send this to other threads as long as T is Send.
+unsafe impl<T: Operations + Send> Send for GenDisk<T> {}
+
+impl<T: Operations> GenDisk<T> {
+    /// Try to create a new `GenDisk`
+    pub fn try_new(tagset: Arc<TagSet<T>>, queue_data: T::QueueData) -> Result<Self> {
+        let data = queue_data.into_foreign();
+        let recover_data = ScopeGuard::new(|| {
+            // SAFETY: T::QueueData was created by the call to `into_foreign()` above
+            unsafe { T::QueueData::from_foreign(data) };
+        });
+
+        let lock_class_key = crate::sync::LockClassKey::new();
+
+        // SAFETY: `tagset.raw_tag_set()` points to a valid and initialized tag set
+        let gendisk = from_err_ptr(unsafe {
+            bindings::__blk_mq_alloc_disk(
+                tagset.raw_tag_set(),
+                data.cast_mut(),
+                lock_class_key.as_ptr(),
+            )
+        })?;
+
+        const TABLE: bindings::block_device_operations = bindings::block_device_operations {
+            submit_bio: None,
+            open: None,
+            release: None,
+            ioctl: None,
+            compat_ioctl: None,
+            check_events: None,
+            unlock_native_capacity: None,
+            getgeo: None,
+            set_read_only: None,
+            swap_slot_free_notify: None,
+            report_zones: None,
+            devnode: None,
+            alternative_gpt_sector: None,
+            get_unique_id: None,
+            // TODO: Set to THIS_MODULE. Waiting for const_refs_to_static feature to be merged
+            // https://github.com/rust-lang/rust/issues/119618
+            owner: core::ptr::null_mut(),
+            pr_ops: core::ptr::null_mut(),
+            free_disk: None,
+            poll_bio: None,
+        };
+
+        // SAFETY: gendisk is a valid pointer as we initialized it above
+        unsafe { (*gendisk).fops = &TABLE };
+
+        recover_data.dismiss();
+        Ok(Self {
+            _tagset: tagset,
+            gendisk,
+        })
+    }
+
+    /// Set the name of the device
+    pub fn set_name(&mut self, args: fmt::Arguments<'_>) -> Result {
+        let mut raw_writer = RawWriter::from_array(
+            // SAFETY: By type invariant `self.gendisk` points to a valid and initialized instance
+            unsafe { &mut (*self.gendisk).disk_name },
+        );
+        raw_writer.write_fmt(args)?;
+        raw_writer.write_char('\0')?;
+        Ok(())
+    }
+
+    /// Register the device with the kernel. When this function return, the
+    /// device is accessible from VFS. The kernel may issue reads to the device
+    /// during registration to discover partition infomation.
+    pub fn add(&self) -> Result {
+        crate::error::to_result(
+            // SAFETY: By type invariant, `self.gendisk` points to a valid and
+            // initialized instance of `struct gendisk`
+            unsafe {
+                bindings::device_add_disk(
+                    core::ptr::null_mut(),
+                    self.gendisk,
+                    core::ptr::null_mut(),
+                )
+            },
+        )
+    }
+
+    /// Call to tell the block layer the capacity of the device in sectors (512B)
+    pub fn set_capacity_sectors(&self, sectors: u64) {
+        // SAFETY: By type invariant, `self.gendisk` points to a valid and
+        // initialized instance of `struct gendisk`
+        unsafe { bindings::set_capacity(self.gendisk, sectors) };
+    }
+
+    /// Set the logical block size of the device.
+    ///
+    /// This is the smallest unit the storage device can address. It is
+    /// typically 512 bytes.
+    pub fn set_queue_logical_block_size(&self, size: u32) {
+        // SAFETY: By type invariant, `self.gendisk` points to a valid and
+        // initialized instance of `struct gendisk`
+        unsafe { bindings::blk_queue_logical_block_size((*self.gendisk).queue, size) };
+    }
+
+    /// Set the physical block size of the device.
+    ///
+    /// This is the smallest unit a physical storage device can write
+    /// atomically. It is usually the same as the logical block size but may be
+    /// bigger. One example is SATA drives with 4KB sectors that expose a
+    /// 512-byte logical block size to the operating system.
+    pub fn set_queue_physical_block_size(&self, size: u32) {
+        // SAFETY: By type invariant, `self.gendisk` points to a valid and
+        // initialized instance of `struct gendisk`
+        unsafe { bindings::blk_queue_physical_block_size((*self.gendisk).queue, size) };
+    }
+
+    /// Set the rotational media attribute for the device
+    pub fn set_rotational(&self, rotational: bool) {
+        if !rotational {
+            // SAFETY: By type invariant, `self.gendisk` points to a valid and
+            // initialized instance of `struct gendisk`
+            unsafe {
+                bindings::blk_queue_flag_set(bindings::QUEUE_FLAG_NONROT, (*self.gendisk).queue)
+            };
+        } else {
+            // SAFETY: By type invariant, `self.gendisk` points to a valid and
+            // initialized instance of `struct gendisk`
+            unsafe {
+                bindings::blk_queue_flag_clear(bindings::QUEUE_FLAG_NONROT, (*self.gendisk).queue)
+            };
+        }
+    }
+}
+
+impl<T: Operations> Drop for GenDisk<T> {
+    fn drop(&mut self) {
+        // SAFETY: By type invariant of `Self`, `self.gendisk` points to a valid
+        // and initialized instance of `struct gendisk`. As such, `queuedata`
+        // was initialized by the initializer returned by `try_new` with a call
+        // to `ForeignOwnable::into_foreign`.
+        let queue_data = unsafe { (*(*self.gendisk).queue).queuedata };
+
+        // SAFETY: By type invariant, `self.gendisk` points to a valid and
+        // initialized instance of `struct gendisk`
+        unsafe { bindings::del_gendisk(self.gendisk) };
+
+        // SAFETY: `queue.queuedata` was created by `GenDisk::try_new()` with a
+        // call to `ForeignOwnable::into_pointer()` to create `queuedata`.
+        // `ForeignOwnable::from_foreign()` is only called here.
+        let _queue_data = unsafe { T::QueueData::from_foreign(queue_data) };
+    }
+}
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
new file mode 100644
index 000000000000..53c6ad663208
--- /dev/null
+++ b/rust/kernel/block/mq/operations.rs
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This module provides an interface for blk-mq drivers to implement.
+//!
+//! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
+
+use crate::{
+    bindings,
+    block::mq::Request,
+    error::{from_result, Result},
+    init::PinInit,
+    types::{ARef, ForeignOwnable},
+};
+use core::{marker::PhantomData, ptr::NonNull};
+
+use super::TagSet;
+
+/// Implement this trait to interface blk-mq as block devices
+#[macros::vtable]
+pub trait Operations: Sized {
+    /// Data associated with a request. This data is located next to the request
+    /// structure.
+    ///
+    /// To be able to handle accessing this data from interrupt context, this
+    /// data must be `Sync`.
+    type RequestData: Sized + Sync;
+
+    /// Initializer for `Self::RequestDta`. Used to initialize private data area
+    /// when requst structure is allocated.
+    type RequestDataInit: PinInit<Self::RequestData>;
+
+    /// Data associated with the `struct request_queue` that is allocated for
+    /// the `GenDisk` associated with this `Operations` implementation.
+    type QueueData: ForeignOwnable;
+
+    /// Data associated with a dispatch queue. This is stored as a pointer in
+    /// the C `struct blk_mq_hw_ctx` that represents a hardware queue.
+    type HwData: ForeignOwnable;
+
+    /// Data associated with a `TagSet`. This is stored as a pointer in `struct
+    /// blk_mq_tag_set`.
+    type TagSetData: ForeignOwnable;
+
+    /// Called by the kernel to get an initializer for a `Pin<&mut RequestData>`.
+    fn new_request_data(
+        //rq: ARef<Request<Self>>,
+        tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed<'_>,
+    ) -> Self::RequestDataInit;
+
+    /// Called by the kernel to queue a request with the driver. If `is_last` is
+    /// `false`, the driver is allowed to defer commiting the request.
+    fn queue_rq(
+        hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>,
+        queue_data: <Self::QueueData as ForeignOwnable>::Borrowed<'_>,
+        rq: ARef<Request<Self>>,
+        is_last: bool,
+    ) -> Result;
+
+    /// Called by the kernel to indicate that queued requests should be submitted
+    fn commit_rqs(
+        hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>,
+        queue_data: <Self::QueueData as ForeignOwnable>::Borrowed<'_>,
+    );
+
+    /// Called by the kernel when the request is completed
+    fn complete(_rq: &Request<Self>);
+
+    /// Called by the kernel to allocate and initialize a driver specific hardware context data
+    fn init_hctx(
+        tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed<'_>,
+        hctx_idx: u32,
+    ) -> Result<Self::HwData>;
+
+    /// Called by the kernel to poll the device for completed requests. Only
+    /// used for poll queues.
+    fn poll(_hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>) -> bool {
+        crate::build_error(crate::error::VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Called by the kernel to map submission queues to CPU cores.
+    fn map_queues(_tag_set: &TagSet<Self>) {
+        crate::build_error(crate::error::VTABLE_DEFAULT_ERROR)
+    }
+
+    // There is no need for exit_request() because `drop` will be called.
+}
+
+/// A vtable for blk-mq to interact with a block device driver.
+///
+/// A `bindings::blk_mq_opa` vtable is constructed from pointers to the `extern
+/// "C"` functions of this struct, exposed through the `OperationsVTable::VTABLE`.
+///
+/// For general documentation of these methods, see the kernel source
+/// documentation related to `struct blk_mq_operations` in
+/// [`include/linux/blk-mq.h`].
+///
+/// [`include/linux/blk-mq.h`]: srctree/include/linux/blk-mq.h
+pub(crate) struct OperationsVTable<T: Operations>(PhantomData<T>);
+
+impl<T: Operations> OperationsVTable<T> {
+    // # Safety
+    //
+    // - The caller of this function must ensure that `hctx` and `bd` are valid
+    //   and initialized. The pointees must outlive this function.
+    // - `hctx->driver_data` must be a pointer created by a call to
+    //   `Self::init_hctx_callback()` and the pointee must outlive this
+    //   function.
+    // - This function must not be called with a `hctx` for which
+    //   `Self::exit_hctx_callback()` has been called.
+    // - (*bd).rq must point to a valid `bindings:request` with a positive refcount in the `ref` field.
+    unsafe extern "C" fn queue_rq_callback(
+        hctx: *mut bindings::blk_mq_hw_ctx,
+        bd: *const bindings::blk_mq_queue_data,
+    ) -> bindings::blk_status_t {
+        // SAFETY: `bd` is valid as required by the safety requirement for this
+        // function.
+        let request_ptr = unsafe { (*bd).rq };
+
+        // SAFETY: By C API contract, the pointee of `request_ptr` is valid and has a refcount of 1
+        #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
+        let updated = unsafe { bindings::req_ref_inc_not_zero(request_ptr) };
+
+        #[cfg(CONFIG_DEBUG_MISC)]
+        if !updated {
+            crate::pr_err!("Request ref was zero at queue time\n");
+        }
+
+        let rq =
+            // SAFETY: We own a refcount that we took above. We pass that to
+            // `ARef`.
+            unsafe { ARef::from_raw(NonNull::new_unchecked(request_ptr.cast::<Request<T>>())) };
+
+        // SAFETY: The safety requirement for this function ensure that `hctx`
+        // is valid and that `driver_data` was produced by a call to
+        // `into_foreign` in `Self::init_hctx_callback`.
+        let hw_data = unsafe { T::HwData::borrow((*hctx).driver_data) };
+
+        // SAFETY: `hctx` is valid as required by this function.
+        let queue_data = unsafe { (*(*hctx).queue).queuedata };
+
+        // SAFETY: `queue.queuedata` was created by `GenDisk::try_new()` with a
+        // call to `ForeignOwnable::into_pointer()` to create `queuedata`.
+        // `ForeignOwnable::from_foreign()` is only called when the tagset is
+        // dropped, which happens after we are dropped.
+        let queue_data = unsafe { T::QueueData::borrow(queue_data) };
+
+        let ret = T::queue_rq(
+            hw_data,
+            queue_data,
+            rq,
+            // SAFETY: `bd` is valid as required by the safety requirement for this function.
+            unsafe { (*bd).last },
+        );
+        if let Err(e) = ret {
+            e.to_blk_status()
+        } else {
+            bindings::BLK_STS_OK as _
+        }
+    }
+
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure. The caller
+    /// must ensure that `hctx` is valid.
+    unsafe extern "C" fn commit_rqs_callback(hctx: *mut bindings::blk_mq_hw_ctx) {
+        // SAFETY: `driver_data` was installed by us in `init_hctx_callback` as
+        // the result of a call to `into_foreign`.
+        let hw_data = unsafe { T::HwData::borrow((*hctx).driver_data) };
+
+        // SAFETY: `hctx` is valid as required by this function.
+        let queue_data = unsafe { (*(*hctx).queue).queuedata };
+
+        // SAFETY: `queue.queuedata` was created by `GenDisk::try_new()` with a
+        // call to `ForeignOwnable::into_pointer()` to create `queuedata`.
+        // `ForeignOwnable::from_foreign()` is only called when the tagset is
+        // dropped, which happens after we are dropped.
+        let queue_data = unsafe { T::QueueData::borrow(queue_data) };
+        T::commit_rqs(hw_data, queue_data)
+    }
+
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure. `rq` must
+    /// point to a valid request that has been marked as completed. The pointee
+    /// of `rq` must be valid for write for the duration of this function.
+    unsafe extern "C" fn complete_callback(rq: *mut bindings::request) {
+        // SAFETY: By function safety requirement `rq`is valid for write for the
+        // lifetime of the returned `Request`.
+        T::complete(unsafe { Request::from_ptr_mut(rq) });
+    }
+
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure. `hctx` must
+    /// be a pointer to a valid and aligned `struct blk_mq_hw_ctx` that was
+    /// previously initialized by a call to `init_hctx_callback`.
+    unsafe extern "C" fn poll_callback(
+        hctx: *mut bindings::blk_mq_hw_ctx,
+        _iob: *mut bindings::io_comp_batch,
+    ) -> core::ffi::c_int {
+        // SAFETY: By function safety requirement, `hctx` was initialized by
+        // `init_hctx_callback` and thus `driver_data` came from a call to
+        // `into_foreign`.
+        let hw_data = unsafe { T::HwData::borrow((*hctx).driver_data) };
+        T::poll(hw_data).into()
+    }
+
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure.
+    /// `tagset_data` must be initialized by the initializer returned by
+    /// `TagSet::try_new` as part of tag set initialization. `hctx` must be a
+    /// pointer to a valid `blk_mq_hw_ctx` where the `driver_data` field was not
+    /// yet initialized. This function may only be called onece before
+    /// `exit_hctx_callback` is called for the same context.
+    unsafe extern "C" fn init_hctx_callback(
+        hctx: *mut bindings::blk_mq_hw_ctx,
+        tagset_data: *mut core::ffi::c_void,
+        hctx_idx: core::ffi::c_uint,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: By the safety requirements of this function,
+            // `tagset_data` came from a call to `into_foreign` when the
+            // `TagSet` was initialized.
+            let tagset_data = unsafe { T::TagSetData::borrow(tagset_data) };
+            let data = T::init_hctx(tagset_data, hctx_idx)?;
+
+            // SAFETY: by the safety requirments of this function, `hctx` is
+            // valid for write
+            unsafe { (*hctx).driver_data = data.into_foreign() as _ };
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure. `hctx` must
+    /// be a valid pointer that was previously initialized by a call to
+    /// `init_hctx_callback`. This function may be called only once after
+    /// `init_hctx_callback` was called.
+    unsafe extern "C" fn exit_hctx_callback(
+        hctx: *mut bindings::blk_mq_hw_ctx,
+        _hctx_idx: core::ffi::c_uint,
+    ) {
+        // SAFETY: By the safety requirements of this function, `hctx` is valid for read.
+        let ptr = unsafe { (*hctx).driver_data };
+
+        // SAFETY: By the safety requirements of this function, `ptr` came from
+        // a call to `into_foreign` in `init_hctx_callback`
+        unsafe { T::HwData::from_foreign(ptr) };
+    }
+
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure. `set` must point to an initialized `TagSet<T>`.
+    unsafe extern "C" fn init_request_callback(
+        set: *mut bindings::blk_mq_tag_set,
+        rq: *mut bindings::request,
+        _hctx_idx: core::ffi::c_uint,
+        _numa_node: core::ffi::c_uint,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The tagset invariants guarantee that all requests are allocated with extra memory
+            // for the request data.
+            let pdu = unsafe { bindings::blk_mq_rq_to_pdu(rq) }.cast::<T::RequestData>();
+
+            // SAFETY: Because `set` is a `TagSet<T>`, `driver_data` comes from
+            // a call to `into_foregn` by the initializer returned by
+            // `TagSet::try_new`.
+            let tagset_data = unsafe { T::TagSetData::borrow((*set).driver_data) };
+
+            let initializer = T::new_request_data(tagset_data);
+
+            // SAFETY: `pdu` is a valid pointer as established above. We do not
+            // touch `pdu` if `__pinned_init` returns an error. We promise ot to
+            // move the pointee of `pdu`.
+            unsafe { initializer.__pinned_init(pdu)? };
+
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure. `rq` must
+    /// point to a request that was initialized by a call to
+    /// `Self::init_request_callback`.
+    unsafe extern "C" fn exit_request_callback(
+        _set: *mut bindings::blk_mq_tag_set,
+        rq: *mut bindings::request,
+        _hctx_idx: core::ffi::c_uint,
+    ) {
+        // SAFETY: The tagset invariants guarantee that all requests are allocated with extra memory
+        // for the request data.
+        let pdu = unsafe { bindings::blk_mq_rq_to_pdu(rq) }.cast::<T::RequestData>();
+
+        // SAFETY: `pdu` is valid for read and write and is properly initialised.
+        unsafe { core::ptr::drop_in_place(pdu) };
+    }
+
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure. `tag_set`
+    /// must be a pointer to a valid and initialized `TagSet<T>`. The pointee
+    /// must be valid for use as a reference at least the duration of this call.
+    unsafe extern "C" fn map_queues_callback(tag_set: *mut bindings::blk_mq_tag_set) {
+        // SAFETY: The safety requirements of this function satiesfies the
+        // requirements of `TagSet::from_ptr`.
+        let tag_set = unsafe { TagSet::from_ptr(tag_set) };
+        T::map_queues(tag_set);
+    }
+
+    const VTABLE: bindings::blk_mq_ops = bindings::blk_mq_ops {
+        queue_rq: Some(Self::queue_rq_callback),
+        queue_rqs: None,
+        commit_rqs: Some(Self::commit_rqs_callback),
+        get_budget: None,
+        put_budget: None,
+        set_rq_budget_token: None,
+        get_rq_budget_token: None,
+        timeout: None,
+        poll: if T::HAS_POLL {
+            Some(Self::poll_callback)
+        } else {
+            None
+        },
+        complete: Some(Self::complete_callback),
+        init_hctx: Some(Self::init_hctx_callback),
+        exit_hctx: Some(Self::exit_hctx_callback),
+        init_request: Some(Self::init_request_callback),
+        exit_request: Some(Self::exit_request_callback),
+        cleanup_rq: None,
+        busy: None,
+        map_queues: if T::HAS_MAP_QUEUES {
+            Some(Self::map_queues_callback)
+        } else {
+            None
+        },
+        #[cfg(CONFIG_BLK_DEBUG_FS)]
+        show_rq: None,
+    };
+
+    pub(crate) const fn build() -> &'static bindings::blk_mq_ops {
+        &Self::VTABLE
+    }
+}
diff --git a/rust/kernel/block/mq/raw_writer.rs b/rust/kernel/block/mq/raw_writer.rs
new file mode 100644
index 000000000000..f7857740af29
--- /dev/null
+++ b/rust/kernel/block/mq/raw_writer.rs
@@ -0,0 +1,60 @@
+use core::{
+    fmt::{self, Write},
+    marker::PhantomData,
+};
+
+/// A mutable reference to a byte buffer where a string can be written into
+///
+/// # Invariants
+///
+/// * `ptr` is not aliased and valid for read and write for `len` bytes
+///
+pub(crate) struct RawWriter<'a> {
+    ptr: *mut u8,
+    len: usize,
+    _p: PhantomData<&'a ()>,
+}
+
+impl<'a> RawWriter<'a> {
+    /// Create a new `RawWriter` instance.
+    ///
+    /// # Safety
+    ///
+    /// * `ptr` must be valid for read and write for `len` consecutive `u8` elements
+    /// * `ptr` must not be aliased
+    unsafe fn new(ptr: *mut u8, len: usize) -> RawWriter<'a> {
+        Self {
+            ptr,
+            len,
+            _p: PhantomData,
+        }
+    }
+
+    pub(crate) fn from_array<const N: usize>(a: &'a mut [core::ffi::c_char; N]) -> RawWriter<'a> {
+        // SAFETY: the buffer of `a` is valid for read and write for at least `N` bytes
+        unsafe { Self::new(a.as_mut_ptr().cast::<u8>(), N) }
+    }
+}
+
+impl Write for RawWriter<'_> {
+    fn write_str(&mut self, s: &str) -> fmt::Result {
+        let bytes = s.as_bytes();
+        let len = bytes.len();
+        if len > self.len {
+            return Err(fmt::Error);
+        }
+
+        // SAFETY:
+        // * `bytes` is valid for reads of `bytes.len()` size because we hold a shared reference to `s`
+        // * By type invariant `self.ptr` is valid for writes for at lest `self.len` bytes
+        // * The regions are not overlapping as `ptr` is not aliased
+        unsafe { core::ptr::copy_nonoverlapping(&bytes[0], self.ptr, len) };
+
+        // SAFETY: By type invariant of `Self`, `ptr` is in bounds of an
+        // allocation. Also by type invariant, the pointer resulting from this
+        // addition is also in bounds.
+        self.ptr = unsafe { self.ptr.add(len) };
+        self.len -= len;
+        Ok(())
+    }
+}
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
new file mode 100644
index 000000000000..b4dacac5e091
--- /dev/null
+++ b/rust/kernel/block/mq/request.rs
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This module provides a wrapper for the C `struct request` type.
+//!
+//! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
+
+use crate::{
+    bindings,
+    block::mq::Operations,
+    error::{Error, Result},
+    types::{ARef, AlwaysRefCounted, Opaque},
+};
+use core::{ffi::c_void, marker::PhantomData, ops::Deref};
+
+/// A wrapper around a blk-mq `struct request`. This represents an IO request.
+///
+/// # Invariants
+///
+/// * `self.0` is a valid `struct request` created by the C portion of the kernel
+/// * `self` is reference counted. a call to `req_ref_inc_not_zero` keeps the
+///    instance alive at least until a matching call to `req_ref_put_and_test`
+///
+#[repr(transparent)]
+pub struct Request<T: Operations>(Opaque<bindings::request>, PhantomData<T>);
+
+impl<T: Operations> Request<T> {
+    /// Create a `&mut Request` from a `bindings::request` pointer
+    ///
+    /// # Safety
+    ///
+    /// * `ptr` must be aligned and point to a valid `bindings::request` instance
+    /// * Caller must ensure that the pointee of `ptr` is live and owned
+    ///   exclusively by caller for at least `'a`
+    ///
+    pub(crate) unsafe fn from_ptr_mut<'a>(ptr: *mut bindings::request) -> &'a mut Self {
+        // SAFETY:
+        // * The cast is valid as `Self` is transparent.
+        // * By safety requirements of this function, the reference will be
+        //   valid for 'a.
+        unsafe { &mut *(ptr.cast::<Self>()) }
+    }
+
+    /// Get the command identifier for the request
+    pub fn command(&self) -> u32 {
+        // SAFETY: By C API contract and type invariant, `cmd_flags` is valid for read
+        unsafe { (*self.0.get()).cmd_flags & ((1 << bindings::REQ_OP_BITS) - 1) }
+    }
+
+    /// Call this to indicate to the kernel that the request has been issued by the driver
+    pub fn start(&self) {
+        // SAFETY: By type invariant, `self.0` is a valid `struct request`. By
+        // existence of `&mut self` we have exclusive access.
+        unsafe { bindings::blk_mq_start_request(self.0.get()) };
+    }
+
+    /// Call this to indicate to the kernel that the request has been completed without errors
+    pub fn end_ok(&self) {
+        // SAFETY: By type invariant, `self.0` is a valid `struct request`. By
+        // existence of `&mut self` we have exclusive access.
+        unsafe { bindings::blk_mq_end_request(self.0.get(), bindings::BLK_STS_OK as _) };
+    }
+
+    /// Call this to indicate to the kernel that the request completed with an error
+    pub fn end_err(&self, err: Error) {
+        // SAFETY: By type invariant, `self.0` is a valid `struct request`. By
+        // existence of `&mut self` we have exclusive access.
+        unsafe { bindings::blk_mq_end_request(self.0.get(), err.to_blk_status()) };
+    }
+
+    /// Call this to indicate that the request completed with the status indicated by `status`
+    pub fn end(&self, status: Result) {
+        if let Err(e) = status {
+            self.end_err(e);
+        } else {
+            self.end_ok();
+        }
+    }
+
+    /// Call this to schedule defered completion of the request
+    pub fn complete(&self) {
+        // SAFETY: By type invariant, `self.0` is a valid `struct request`
+        if !unsafe { bindings::blk_mq_complete_request_remote(self.0.get()) } {
+            T::complete(self);
+        }
+    }
+
+    /// Get the target sector for the request
+    #[inline(always)]
+    pub fn sector(&self) -> usize {
+        // SAFETY: By type invariant of `Self`, `self.0` is valid and live.
+        unsafe { (*self.0.get()).__sector as usize }
+    }
+
+    /// Returns an owned reference to the per-request data associated with this
+    /// request
+    pub fn owned_data_ref(request: ARef<Self>) -> RequestDataRef<T> {
+        RequestDataRef::new(request)
+    }
+
+    /// Returns a reference to the oer-request data associated with this request
+    pub fn data_ref(&self) -> &T::RequestData {
+        let request_ptr = self.0.get().cast::<bindings::request>();
+
+        // SAFETY: `request_ptr` is a valid `struct request` because `ARef` is
+        // `repr(transparent)`
+        let p: *mut c_void = unsafe { bindings::blk_mq_rq_to_pdu(request_ptr) };
+
+        let p = p.cast::<T::RequestData>();
+
+        // SAFETY: By C API contract, `p` is initialized by a call to
+        // `OperationsVTable::init_request_callback()`. By existence of `&self`
+        // it must be valid for use as a shared reference.
+        unsafe { &*p }
+    }
+}
+
+// SAFETY: It is impossible to obtain an owned or mutable `Request`, so we can
+// mark it `Send`.
+unsafe impl<T: Operations> Send for Request<T> {}
+
+// SAFETY: `Request` references can be shared across threads.
+unsafe impl<T: Operations> Sync for Request<T> {}
+
+/// An owned reference to a `Request<T>`
+#[repr(transparent)]
+pub struct RequestDataRef<T: Operations> {
+    request: ARef<Request<T>>,
+}
+
+impl<T> RequestDataRef<T>
+where
+    T: Operations,
+{
+    /// Create a new instance.
+    fn new(request: ARef<Request<T>>) -> Self {
+        Self { request }
+    }
+
+    /// Get a reference to the underlying request
+    pub fn request(&self) -> &Request<T> {
+        &self.request
+    }
+}
+
+impl<T> Deref for RequestDataRef<T>
+where
+    T: Operations,
+{
+    type Target = T::RequestData;
+
+    fn deref(&self) -> &Self::Target {
+        self.request.data_ref()
+    }
+}
+
+// SAFETY: All instances of `Request<T>` are reference counted. This
+// implementation of `AlwaysRefCounted` ensure that increments to the ref count
+// keeps the object alive in memory at least until a matching reference count
+// decrement is executed.
+unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
+    fn inc_ref(&self) {
+        // SAFETY: By type invariant `self.0` is a valid `struct reqeust`
+        #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
+        let updated = unsafe { bindings::req_ref_inc_not_zero(self.0.get()) };
+        #[cfg(CONFIG_DEBUG_MISC)]
+        if !updated {
+            crate::pr_err!("Request refcount zero on clone");
+        }
+    }
+
+    unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
+        // SAFETY: By type invariant `self.0` is a valid `struct reqeust`
+        let zero = unsafe { bindings::req_ref_put_and_test(obj.as_ref().0.get()) };
+        if zero {
+            // SAFETY: By type invariant of `self` we have the last reference to
+            // `obj` and it is safe to free it.
+            unsafe {
+                bindings::blk_mq_free_request_internal(obj.as_ptr().cast::<bindings::request>())
+            };
+        }
+    }
+}
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
new file mode 100644
index 000000000000..7f463b7e288b
--- /dev/null
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This module provides the `TagSet` struct to wrap the C `struct blk_mq_tag_set`.
+//!
+//! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
+
+use core::pin::Pin;
+
+use crate::{
+    bindings,
+    block::mq::{operations::OperationsVTable, Operations},
+    error::{self, Error, Result},
+    prelude::PinInit,
+    try_pin_init,
+    types::{ForeignOwnable, Opaque},
+};
+use core::{convert::TryInto, marker::PhantomData};
+use macros::{pin_data, pinned_drop};
+
+/// A wrapper for the C `struct blk_mq_tag_set`.
+///
+/// `struct blk_mq_tag_set` contains a `struct list_head` and so must be pinned.
+#[pin_data(PinnedDrop)]
+#[repr(transparent)]
+pub struct TagSet<T: Operations> {
+    #[pin]
+    inner: Opaque<bindings::blk_mq_tag_set>,
+    _p: PhantomData<T>,
+}
+
+impl<T: Operations> TagSet<T> {
+    /// Try to create a new tag set
+    pub fn try_new(
+        nr_hw_queues: u32,
+        tagset_data: T::TagSetData,
+        num_tags: u32,
+        num_maps: u32,
+    ) -> impl PinInit<Self, error::Error> {
+        try_pin_init!( TagSet {
+            inner <- Opaque::try_ffi_init(move |place: *mut bindings::blk_mq_tag_set| -> Result<()> {
+
+                // SAFETY: try_ffi_init promises that `place` is writable, and
+                // zeroes is a valid bit pattern for this structure.
+                unsafe { core::ptr::write_bytes(place, 0, 1) };
+
+                /// For a raw pointer to a struct, write a struct field without
+                /// creating a reference to the field
+                macro_rules! write_ptr_field {
+                    ($target:ident, $field:ident, $value:expr) => {
+                        ::core::ptr::write(::core::ptr::addr_of_mut!((*$target).$field), $value)
+                    };
+                }
+
+                // SAFETY: try_ffi_init promises that `place` is writable
+                unsafe {
+                    write_ptr_field!(place, ops, OperationsVTable::<T>::build());
+                    write_ptr_field!(place, nr_hw_queues , nr_hw_queues);
+                    write_ptr_field!(place, timeout , 0); // 0 means default which is 30 * HZ in C
+                    write_ptr_field!(place, numa_node , bindings::NUMA_NO_NODE);
+                    write_ptr_field!(place, queue_depth , num_tags);
+                    write_ptr_field!(place, cmd_size , core::mem::size_of::<T::RequestData>().try_into()?);
+                    write_ptr_field!(place, flags , bindings::BLK_MQ_F_SHOULD_MERGE);
+                    write_ptr_field!(place, driver_data , tagset_data.into_foreign() as _);
+                    write_ptr_field!(place, nr_maps , num_maps);
+                }
+
+                // SAFETY: Relevant fields of `place` are initialised above
+                let ret = unsafe { bindings::blk_mq_alloc_tag_set(place) };
+                if ret < 0 {
+                    // SAFETY: We created `driver_data` above with `into_foreign`
+                    unsafe { T::TagSetData::from_foreign((*place).driver_data) };
+                    return Err(Error::from_errno(ret));
+                }
+
+                Ok(())
+            }),
+            _p: PhantomData,
+        })
+    }
+
+    /// Return the pointer to the wrapped `struct blk_mq_tag_set`
+    pub(crate) fn raw_tag_set(&self) -> *mut bindings::blk_mq_tag_set {
+        self.inner.get()
+    }
+
+    /// Create a `TagSet<T>` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be a pointer to a valid and initialized `TagSet<T>`. There
+    /// may be no other mutable references to the tag set. The pointee must be
+    /// live and valid at least for the duration of the returned lifetime `'a`.
+    pub(crate) unsafe fn from_ptr<'a>(ptr: *mut bindings::blk_mq_tag_set) -> &'a Self {
+        // SAFETY: By the safety requirements of this function, `ptr` is valid
+        // for use as a reference for the duration of `'a`.
+        unsafe { &*(ptr.cast::<Self>()) }
+    }
+}
+
+#[pinned_drop]
+impl<T: Operations> PinnedDrop for TagSet<T> {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: We are not moving self below
+        let this = unsafe { Pin::into_inner_unchecked(self) };
+
+        // SAFETY: `this.inner.get()` points to a valid `blk_mq_tag_set` and
+        // thus is safe to dereference.
+        let tagset_data = unsafe { (*this.inner.get()).driver_data };
+
+        // SAFETY: `inner` is valid and has been properly initialised during construction.
+        unsafe { bindings::blk_mq_free_tag_set(this.inner.get()) };
+
+        // SAFETY: `tagset_data` was created by a call to
+        // `ForeignOwnable::into_foreign` in `TagSet::try_new()`
+        unsafe { T::TagSetData::from_foreign(tagset_data) };
+    }
+}
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 4f0c1edd63b7..c947fd631416 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -130,6 +130,11 @@ pub fn to_errno(self) -> core::ffi::c_int {
         self.0
     }
 
+    pub(crate) fn to_blk_status(self) -> bindings::blk_status_t {
+        // SAFETY: `self.0` is a valid error due to its invariant.
+        unsafe { bindings::errno_to_blk_status(self.0) }
+    }
+
     /// Returns the error encoded as a pointer.
     #[allow(dead_code)]
     pub(crate) fn to_ptr<T>(self) -> *mut T {
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 638a68af341a..9f02a8b352e0 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -34,6 +34,7 @@
 #[cfg(not(test))]
 #[cfg(not(testlib))]
 mod allocator;
+pub mod block;
 mod build_assert;
 mod cache_aligned;
 pub mod error;
-- 
2.44.0


