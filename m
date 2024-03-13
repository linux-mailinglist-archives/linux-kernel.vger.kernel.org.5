Return-Path: <linux-kernel+bounces-101403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 631EA87A6B0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176A4281363
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018A53FB10;
	Wed, 13 Mar 2024 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="DVKs6gbv"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F93EA80
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327966; cv=none; b=ricHqKkyZzB95fXxI7QM4xw038yyYzbRX0AF48iSO93vRSRdajeXMrXli0ZhzJnAbRjWuWQ8KneBSqkHBFPDj+7c1DADtYEhyF/HiNcTbP4FcXM/uHKLzQRIpEtCbHRn9zzb5V4LMcgpqf6yXrW+xcZTuw99cydw/SxPblWuCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327966; c=relaxed/simple;
	bh=+7p29bGGxWJhQPF+XbBPwBQGGdm2QhUpvCj1q5NEvAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/jojYRsYduvHkhT4D7camAgU11fZKpdejDIgWzmp1NlvHQZbr0ufq236kh6usycp/M8knHLLkyth/YUaOojBcQpXKfMQpJvUOwPCwzxStVLCsqggxz/PTgWM725/qWQ8c6aMbZw+A6nbPInNgWQKRIbK9QOkrHn48L17SFVi34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=DVKs6gbv; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5682360e095so8195171a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710327962; x=1710932762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E6ChQUoNXFzZpGvU3Nd1F1JeRFjGX/gvu+taEqVhzo4=;
        b=DVKs6gbvC7GS455jiIyvPDGJUxK7SFyUNXv0tWWchUmyyb+C+zkWDRHCWDnJ8hud+V
         xrt0NFHnGcedL+sgFHNOcRmmWuBQvs0TyGV/XIDLgm0UmZ+UGGsvmlVIfHfSIuGUusCY
         YNm7lCvYo7RoBSikKipsqKpeMxjuzQynzUQu5KJWWsJrehI1T2b1eW7qd8opIpu19EOL
         sv4G1wtPncRH+xjPLY6pxf+27ebI3y92ZsTQYr0cnTGc8PFxw5KbGYV5UrYQb34WKQcQ
         zjVZzuJmdPfmWx8rmRCIr6Ct4oH4ivba/5O6RAxEisMmHO6G0bsSOh1FtiijLkK7GfTe
         TSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710327962; x=1710932762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6ChQUoNXFzZpGvU3Nd1F1JeRFjGX/gvu+taEqVhzo4=;
        b=G0asBL97H3fPHO20CO1ChIPFRaDDI4pnvay6JBb1hzRDYpXoIAGXCdplicgO4CJUpQ
         ani/1ZRYSICpjp+On60cGQwD72I08RKR590t7VCRB6836NztfNYWCTGS1dGZ4PxgptKj
         SHwgxl9cx7Ka5wWdoIlRU4Az+BHVtqn8jPQkLpkPvh1HY59b8Eqb5vAVgjm8ZSojReuJ
         +TXTtPyETAzSDqXP5Z0g/DmBWSEshmDh+NgCe4oJmt6JyTf5c8f/kXt19I1JFk+OU/JS
         LxNRZI+1gnS3MAEOVbaW9k1QRxeO6Z7NE3K9+29m7ZOQ0/wu8W1iO9EM+/teI7p/yho4
         0MLg==
X-Forwarded-Encrypted: i=1; AJvYcCW54kUW0Uh0zQJPnDIyE1xqdy//c7DJ1rIXS6fTmhFtB3/YnTWFZ5PvgIpuLNGkgjXUE5Jleo4qovFiesMG4WQh37vqIecz81d0pHWO
X-Gm-Message-State: AOJu0Yy6nR3FgEJEv35lIeEvmdVprwNaeOvhPe48UyD4e2knhg61G0Nl
	dV34Y7bJ+CDiP3TSVbaoV45CusxlERXlQZYRn2i+pQ66RhFgYDLo4/L6suX0YlI=
X-Google-Smtp-Source: AGHT+IF2qHriqmWq4ZDmQaUBHxnPl/trI9zY0IN49oPlTnPUdziuSefAOXAS40sPWtFRzodghFtyXA==
X-Received: by 2002:a17:907:d40a:b0:a45:2f1b:c07d with SMTP id vi10-20020a170907d40a00b00a452f1bc07dmr9360512ejc.10.1710327961729;
        Wed, 13 Mar 2024 04:06:01 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id n17-20020a170906701100b00a46372f6c69sm2160263ejj.190.2024.03.13.04.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 04:06:01 -0700 (PDT)
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
Subject: [RFC PATCH 0/5] Rust block device driver API and null block driver
Date: Wed, 13 Mar 2024 12:05:07 +0100
Message-ID: <20240313110515.70088-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Hi All!

This is the second version of the Rust block device driver API and the Rust null
block driver. The context and motivation can be seen in cover letter of the RFC
v1 [1]. If more context is required, a talk about this effort was recorded at
LPC [2]. I hope to be able to discuss this series at LSF this year [3].

The series is still in RFC state, as many dependencies have not yet been merged.

Changes from v1:
 - Improved request lifetime tracking
 - Changed rust null block driver name to `rnull`
 - Added timer completion support to `rnull`
 - Added softirq completion support to `rnull`
 - Moved to `xarray` for memory backing
 - Adopted the folio abstraction where applicable
 - Added `SAFETY` comments to all unsafe blocks
 - Improved documentation and added examples
 - Fixed up `vtable` default method behavior
 - Dropped `unsafe` from vtable builder
 - Fixed a safety issue in `RawWriter`
 - Dropped the `TagSetRef` abstraction
 - Renamed `Bio::iter` -> `Bio::raw_iter`
 - Updated `core::fmt::Display for Bio` for readability
 - Simplified `BioIterator::next`
 - Documented and refactored `bvec_iter` functions
 - Moved cache alignment out of `Lock`
 - Added MAINTAINER entry

Thanks for all the input on v1!


Performance
===========

Rather than include an abundance of performance numbers in this letter, I would
refer to [4] for a comparison of performance to the C null block driver. In
general across all of the benchmark configurations, the mean of the difference
is -2.5%, with individual configurations showing [-10%;30%] difference in IO/s.


Request lifetime modeling
=========================

While implementing timer completion, it became clear that the request lifetime
modeling applied in the v1 RFC was not adequate. With that modeling, combined
with the timer callback feature, a developer would be able to write safe Rust
code that violates the Rust invariants for references, thus leading to undefined
behavior. A similar situation would happen in the completion path when
developers write code to convert from a completion id to a `&Request`.

To make these situations safe, and thus free from undefined behavior, the
`Request` type now applies reference counting. The logic piggybacks on the
`atomic_t ref` field of the C `struct request`. In order to make this work, the
Rust code has to be able to free requests when the refcount reaches zero.
Therefore, the series exposes (EXPORT_SYMBOL_GPL) the internal blk-mq symbol
`__blk_mq_free_request`.

I am curious what the community thinks of this approach and whether it is OK to
expose this symbol so that Rust can call it.

One consequence of these changes is that requests that are processed by a Rust
block device driver, are freed at a different place in the completion path, than
requests processed by C drivers. Requests processed by C drivers are typically
freed and recycled inline during the call to `blk_mq_complete_request`. The
requests processed by a Rust driver will be recycled when the `RequestRef` is
dropped, which is usually at some time after the request has been completed.

There does not seem to be any statistically significant effect on performance
for the rust null block implementation due to this change.


Dependencies
============

This series is based on the branch `rnull-deps-v6.8` of [5]. This tree is based
on the upstream `v6.8` tag and has been prepared with dependencies for this
series:

- [17] rust: add `CacheAligned` for easy cache line alignment of values
- [16] rust: xarray: add mutable access through `Guard`
- [15] rust: hrtimer: introduce hrtimer support
- [14] rust: add `Opaque::try_ffi_init`
- [13] rust: make `ARef` repr transparent
- [12] rust: folio: add `with_slice_into_page()`
- [11] rust: page: add `from_raw()`
- [10] rust: page: add `with_slice_into_page()`
- [ 9] IM: implement `ForeignOwnable` for `Pin`
- [ 8] IM: add `module_params` macro
- [ 7] rust: xarray: fix example
- [ 6] LIST: rust: xarray: Add an abstraction for XArray
- [ 5] LIST: rust: types: add FOREIGN_ALIGN to ForeignOwnable
- [ 4] LIST: rust: lock: implement `IrqSaveBackend` for `SpinLock`
- [ 3] LIST: rust: lock: add support for `Lock::lock_irqsave`
- [ 2] LIST: rust: add improved version of `ForeignOwnable::borrow_mut`
- [ 1] LIST: rust: folio: introduce basic support for folios
- [ 0] LIST: rust: add abstraction for `struct page`

Dependencies 0-6 are patches that have appeared on the list but are not yet
merged. Dependencies 8-9 are imports from the `rust` branch [6,7] that have not
yet been submitted. Dependencies 10-17 I will submit independently in the near
future.

If the upstream maintainers agree, then when the dependencies are merged, I will
eventually start submitting PRs to Jens. I fully commit to maintain this code as
indicated in the MAINTAINERS entry.

Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/rust-for-linux/20230503090708.2524310-1-nmi@metaspace.dk
[2] https://lpc.events/event/17/contributions/1425
[3] https://lore.kernel.org/rust-for-linux/87v87cgsp8.fsf@metaspace.dk
[4] https://rust-for-linux.com/null-block-driver
[5] git https://github.com/metaspace/linux.git rnull-deps-v6.8
[6] git https://github.com/rust-for-Linux/linux.git rust
[7] https://rust-for-linux.com/branches#rust


Andreas Hindborg (5):
  rust: block: introduce `kernel::block::mq` module
  rust: block: introduce `kernel::block::bio` module
  rust: block: allow `hrtimer::Timer` in `RequestData`
  rust: block: add rnull, Rust null_blk implementation
  MAINTAINERS: add entry for Rust block device driver API

 MAINTAINERS                        |  14 ++
 block/blk-mq.c                     |   3 +-
 drivers/block/Kconfig              |   4 +
 drivers/block/Makefile             |   3 +
 drivers/block/rnull.rs             | 323 +++++++++++++++++++++++++++
 include/linux/blk-mq.h             |   1 +
 rust/bindings/bindings_helper.h    |   2 +
 rust/helpers.c                     |  46 ++++
 rust/kernel/block.rs               |   6 +
 rust/kernel/block/bio.rs           | 112 ++++++++++
 rust/kernel/block/bio/vec.rs       | 279 +++++++++++++++++++++++
 rust/kernel/block/mq.rs            | 131 +++++++++++
 rust/kernel/block/mq/gen_disk.rs   | 174 +++++++++++++++
 rust/kernel/block/mq/operations.rs | 346 +++++++++++++++++++++++++++++
 rust/kernel/block/mq/raw_writer.rs |  60 +++++
 rust/kernel/block/mq/request.rs    | 269 ++++++++++++++++++++++
 rust/kernel/block/mq/tag_set.rs    | 117 ++++++++++
 rust/kernel/error.rs               |   5 +
 rust/kernel/lib.rs                 |   1 +
 scripts/Makefile.build             |   2 +-
 20 files changed, 1896 insertions(+), 2 deletions(-)
 create mode 100644 drivers/block/rnull.rs
 create mode 100644 rust/kernel/block.rs
 create mode 100644 rust/kernel/block/bio.rs
 create mode 100644 rust/kernel/block/bio/vec.rs
 create mode 100644 rust/kernel/block/mq.rs
 create mode 100644 rust/kernel/block/mq/gen_disk.rs
 create mode 100644 rust/kernel/block/mq/operations.rs
 create mode 100644 rust/kernel/block/mq/raw_writer.rs
 create mode 100644 rust/kernel/block/mq/request.rs
 create mode 100644 rust/kernel/block/mq/tag_set.rs


base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
prerequisite-patch-id: 299c2cc48c45c8149e7cb18c6146a0308e5d0a44
prerequisite-patch-id: 5153ee1c410dbdf22a6fd40667712943b4b89a97
prerequisite-patch-id: 4d025bab9bc9741aedecc5327ad18f88f9105271
prerequisite-patch-id: a5e932c86fa6c68234764aa3d7f314e5b534b1d9
prerequisite-patch-id: aef3042976c4c678b7aa96154fc280f9061ebaf7
prerequisite-patch-id: 8bf108ad0af2a3ec89acb8d99ee1b49ca2f51c69
prerequisite-patch-id: a803b221c3232db3258406a4075558e85acefd09
prerequisite-patch-id: 5e9cbcd0dc56a83353f0e4a3b5d4e8d5b51f3160
prerequisite-patch-id: 28bae4a7fe83b36afed9892515a6dde1ea51e98a
prerequisite-patch-id: 5b5ea2a21b37afb05fdf655396a6f74d83bb99c4
prerequisite-patch-id: dc53b6ce21f74726d5d13988398c2954da07bcb6
prerequisite-patch-id: b86d2b14f1770c1d4756ca10b93efaada643e560
prerequisite-patch-id: 6a155859eb9a18afcd22a5bda3350d45d92e2fc7
prerequisite-patch-id: c8ca075008f50d3cf1781c1ea1130a8ee735e7d2
prerequisite-patch-id: b000cd190fe80dea3f4dd9172ecf8787f23b72be
prerequisite-patch-id: b72f1fc3bd44b60911d9d91ecc5a45812a75eba3
prerequisite-patch-id: 167c7770e124b9afa44bead742f90a57ac73f2d7
prerequisite-patch-id: cc24a3135b4f258f4b1ea83ac91c2be4ffe31772
-- 
2.44.0


