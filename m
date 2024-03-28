Return-Path: <linux-kernel+bounces-122287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0873E88F4C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1271C2D89E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6C321364;
	Thu, 28 Mar 2024 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao3ENgSQ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D118208A1;
	Thu, 28 Mar 2024 01:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589779; cv=none; b=TMQY6kLd2v4myjEoA6c3i7FKHRFzUUCZLbciGvMeJKXOCnt6zb8s5NzjSJ2F8+ap1HHppFvzXmxOimS2HaezIg7CBf/6CopYB9Q0GW0UM+osFdA/ZE73dgXL+oIUjcZq3H/GeqCSjKTeZvFOBOty5OXkFx15y8iYjdZKHDKJMA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589779; c=relaxed/simple;
	bh=pb2ei1wLk2qSDLb8h3PpIJsZ0luiAYrTTycrHzaEMUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ram+nc6M/0bggLS6T/Z1UBUZnUAJfN+lYMtRwykwEaCEiHMh5eX0q0t1+5IWd/srEJqlrspwG2xl5kBMMS5wvjVKrex1Uc1ncK5I65lA4lImW3+KkkohiQTYqxglyzY9wsm7f/la3dzNsj8jxk1AE9IkRwMiiM1ZsDCrRq/GOb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ao3ENgSQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0f2798cd8so4529315ad.3;
        Wed, 27 Mar 2024 18:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711589776; x=1712194576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OGRcrH1onhx9sXOW/O2xO/9DcgcvYfP+E0tPv2K++Wc=;
        b=Ao3ENgSQY/UkELf2kVELFanVJOuTuoNgsCnmAUnph/vdm0se0HHUa9Y5qBifEGSPrW
         my+zmAp+zzJrsA/isWYuHT2juHq6/US33NPQ9fOrQ+BWoHENmmj2jUESfZZP8NwGNaGG
         pgxk3+7vd/bKpJFIvfniNCBb2M7EKCyrEib+uHoHPKS4PLVgyKkxhQOJeb/vfAdYNi3h
         A72vNU67JE3kfai/Pj3brhBwlOrRa8++lkpx3SNLkcjfrjijApqb+WHXds5xbWqd9EKr
         xllhuI7H1MYknYSlhAREf1pf50ieJ1/Tb6xuFeq01tlC5IjJPJ5OwIE0pGRw0X2n4KWz
         ZgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711589776; x=1712194576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGRcrH1onhx9sXOW/O2xO/9DcgcvYfP+E0tPv2K++Wc=;
        b=CJo7ry6BgUrsu6/2TVYEIBrv4x0QEAVu45Qh7iDIYAZP7YPLoYmZYEa/hWoyUbylkH
         iTKTk3W41fOIdFbUD5oil0G0e5JwlmJOvu9jG4vLfIhdatb6/98V5y87kL1J/oiOsTuf
         kTPSCHWLapm25RlwLh1tEOZ8Kn6Ic7KOGTKjvXZKCTVNXxPvzsMkqzrDPpNv9cmc2idC
         baTw3DFjfRgXgXpZGJWXNw7Hkf3mftQDCh9GDB/1OhWvAknF5IJ5xrN7NpCLZrqsKKYI
         /nakcvyzmW/Asgzx6vGCYKLEjOdf0dGSbIZ0hXvQEWa1O4x/9rViGn+5UuCTIXxRXi9e
         GCuA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ6ME2Hvf9mLnHZ7BbDnEx0G0T/QQohtRk4jcRqPkVOgc/zqNgW5dRpmZvyE4SfYecZkxFdDlncCH6lsDTDKlzwZKPTnTQ6RA4HIRO
X-Gm-Message-State: AOJu0YxvhB4ybSaYZG/xGa8z0TXcPkwS/CDDHjQLs2ROmuyN8ZV7LmXZ
	J2bEAd8/973Jq55AE0L+BbFnfbVkJdYyrwC6PiH/0aNYBiCtfKk0zGhzK5tb
X-Google-Smtp-Source: AGHT+IEGxR+Y0U7KGel7dpp4fWNJ9UVLAOwkz5Q2Hk5OzdOiXRKZRFKHDg9fXb8feOJgJPKNGurKXw==
X-Received: by 2002:a17:902:bd82:b0:1e2:16c6:6b06 with SMTP id q2-20020a170902bd8200b001e216c66b06mr207447pls.6.1711589776178;
        Wed, 27 Mar 2024 18:36:16 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id p16-20020a170902e75000b001dd7a97a266sm189144plf.282.2024.03.27.18.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 18:36:15 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH v3 00/10] Allocation APIs
Date: Wed, 27 Mar 2024 22:35:53 -0300
Message-Id: <20240328013603.206764-1-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

Revamp how we use the `alloc` crate.

We currently have a fork of the crate with changes to `Vec`; other
changes have been upstreamed (to the Rust project). This series removes
the fork and exposes all the functionality as extension traits.

Additionally, it also introduces allocation flag parameters to all
functions that may result in allocations (e.g., `Box::new`, `Arc::new`,
`Vec::push`, etc.) without the `try_` prefix -- the names are available
because we build `alloc` with `no_global_oom_handling`.

Lastly, the series also removes our reliance on the `allocator_api`
unstable feature.

Long term, we still want to make such functionality available in
upstream Rust, but this allows us to make progress now and reduces our
maintainance burden.

In summary:
1. Removes `alloc` fork
2. Removes use of `allocator_api` unstable feature
3. Introduces flags (e.g., GFP_KERNEL, GFP_ATOMIC) when allocating

---

Changes in v3:
- Rebased on top of the latest `rust-next` branch.
- Updated `krealloc_aligned` to use `Flags` instead of `bindings::gfp_t`.
- Added __GFP_ZERO to flags, as part of the previous change.
- Avoiding temporary stack value in `Box::new_uninit`.
- Implement `Box::new` using `Box::new_uninit` (so only one of them actually
  allocates).
- Added examples/tests to `VecExt` methods.
- Fixed bug in length in `extend_from_slice`
- Link to v2: https://lore.kernel.org/rust-for-linux/20240327023531.187880-1-wedsonaf@gmail.com/T/#t

Changes in v2:
- Updated description of `alloc` crate.
- Renamed vecext and boxext modules to vec_ext and box_ext.
- Added derive directive to `AllocError`.
- Updated safety comment in `BoxExt::new`.
- Updated `VecExt::push` and `VecExt::extend_from_slice` to use
  `spare_capacity_mut`
- Added directive to not compile `destructure` and `rebuild` when `test` or
  `testlib` are configured. Otherwise we have a warning because `push` and
  `extend_from_slice` don't use them anymore.
- Updated indentation in `Arc::new_uninit`
- Moved the removal of `TryReserveError` convesion to `Error` to patch 7, where
  usage of `TryReserveError` is actually removed.
- Link to v1: https://lore.kernel.org/rust-for-linux/20240325195418.166013-1-wedsonaf@gmail.com/T/#t

Wedson Almeida Filho (10):
  rust: kernel: move `allocator` module under `alloc`
  rust: alloc: introduce the `VecExt` trait
  kbuild: use the upstream `alloc` crate
  rust: alloc: remove our fork of the `alloc` crate
  rust: alloc: introduce allocation flags
  rust: alloc: introduce the `BoxExt` trait
  rust: alloc: update `VecExt` to take allocation flags
  rust: sync: update `Arc` and `UniqueArc` to take allocation flags
  rust: init: update `init` module to take allocation flags
  rust: kernel: remove usage of `allocator_api` unstable feature

 rust/Makefile                        |   16 +-
 rust/alloc/README.md                 |   36 -
 rust/alloc/alloc.rs                  |  452 ----
 rust/alloc/boxed.rs                  | 2463 -----------------
 rust/alloc/collections/mod.rs        |  160 --
 rust/alloc/lib.rs                    |  288 --
 rust/alloc/raw_vec.rs                |  611 -----
 rust/alloc/slice.rs                  |  890 -------
 rust/alloc/vec/drain.rs              |  255 --
 rust/alloc/vec/extract_if.rs         |  115 -
 rust/alloc/vec/into_iter.rs          |  454 ----
 rust/alloc/vec/is_zero.rs            |  204 --
 rust/alloc/vec/mod.rs                | 3683 --------------------------
 rust/alloc/vec/partial_eq.rs         |   49 -
 rust/alloc/vec/set_len_on_drop.rs    |   35 -
 rust/alloc/vec/spec_extend.rs        |  119 -
 rust/bindings/bindings_helper.h      |    3 +
 rust/kernel/alloc.rs                 |   74 +
 rust/kernel/{ => alloc}/allocator.rs |   17 +-
 rust/kernel/alloc/box_ext.rs         |   59 +
 rust/kernel/alloc/vec_ext.rs         |  176 ++
 rust/kernel/error.rs                 |   13 +-
 rust/kernel/init.rs                  |   57 +-
 rust/kernel/lib.rs                   |    5 +-
 rust/kernel/prelude.rs               |    2 +
 rust/kernel/str.rs                   |    6 +-
 rust/kernel/sync/arc.rs              |   50 +-
 rust/kernel/sync/condvar.rs          |    2 +-
 rust/kernel/sync/lock/mutex.rs       |    2 +-
 rust/kernel/sync/lock/spinlock.rs    |    2 +-
 rust/kernel/types.rs                 |    4 +-
 rust/kernel/workqueue.rs             |   14 +-
 samples/rust/rust_minimal.rs         |    6 +-
 samples/rust/rust_print.rs           |    4 +-
 scripts/generate_rust_analyzer.py    |    2 +-
 35 files changed, 405 insertions(+), 9923 deletions(-)
 delete mode 100644 rust/alloc/README.md
 delete mode 100644 rust/alloc/alloc.rs
 delete mode 100644 rust/alloc/boxed.rs
 delete mode 100644 rust/alloc/collections/mod.rs
 delete mode 100644 rust/alloc/lib.rs
 delete mode 100644 rust/alloc/raw_vec.rs
 delete mode 100644 rust/alloc/slice.rs
 delete mode 100644 rust/alloc/vec/drain.rs
 delete mode 100644 rust/alloc/vec/extract_if.rs
 delete mode 100644 rust/alloc/vec/into_iter.rs
 delete mode 100644 rust/alloc/vec/is_zero.rs
 delete mode 100644 rust/alloc/vec/mod.rs
 delete mode 100644 rust/alloc/vec/partial_eq.rs
 delete mode 100644 rust/alloc/vec/set_len_on_drop.rs
 delete mode 100644 rust/alloc/vec/spec_extend.rs
 create mode 100644 rust/kernel/alloc.rs
 rename rust/kernel/{ => alloc}/allocator.rs (86%)
 create mode 100644 rust/kernel/alloc/box_ext.rs
 create mode 100644 rust/kernel/alloc/vec_ext.rs


base-commit: 768409cff6cc89fe1194da880537a09857b6e4db
-- 
2.34.1


