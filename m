Return-Path: <linux-kernel+bounces-120222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BE788D497
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF3E1F2EBC3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8856321103;
	Wed, 27 Mar 2024 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOci+0Vi"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3304212E55;
	Wed, 27 Mar 2024 02:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506951; cv=none; b=LLrnzlNrAZ0QuG/wN13EO9RlsnjQ6C1k7UP55G5tDMEfyxkihlwFFjNYcq8DVFoCw/p5oponHcIuAhYtKPHKsg7bkBHYqnK5WfLI698VEGMzF/jWoBm3/WlBNbXmf1aGgBZDRtTGqtktuDkR+MHQIBD3vw7QqtHR/ZSKpjiC6Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506951; c=relaxed/simple;
	bh=y2zzynm2zh+qE9qqZdgoMEYhwSx3j6X8bOh+znAcf7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aSoMVfD4skdM2bIRYz1AAoGesoRt7tPqtdQrkxnvQHeWZraILRtAhvzVOxIvMrxeNaycfo+7gNZFMwfGbXsJjW3d+W9TuKkmJBAb18LFyOi6KMEY0YVoffNkgTk20M6HmBG2jCNXLhExIw2Yn8QEtJLLJXUXHcy16eb7R4gphLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOci+0Vi; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso3593228a12.2;
        Tue, 26 Mar 2024 19:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711506949; x=1712111749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zzpuZiLAjFHmsEl2ZTO7rWcGk9hHOOanbD6SfZr3xsA=;
        b=EOci+0ViXgUeTvvdksfSPSk3vKbRJVmqDN06d+krvoDgrmLNbunE/LpiQG2QUsRd6i
         cW0VlJ4kYiLzIQWDrB7BKODwvtW9BHswVECXSECQsw20qGQAEXrnqr9T+qiqH+x8sjPw
         Np5ey7YUIbv/SgfuZ3WMmmQ5YSFAC47PS2PtX8rtgoyfRgJfWWmpNujEbQn5niVGfmVK
         2FB3qYxmM3UrXWNL5zlP2GeBxZmF3qCskPA96g85zP4Ce/GmDKHhNC2hLdO/a3eGN9Vs
         Ce3+Or0pLRz7/cEvoe8Otf9iul/LOOzxOxEJB6GI0Exh2ioxiEckJ3wHIg5TuTIadoV7
         z9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711506949; x=1712111749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzpuZiLAjFHmsEl2ZTO7rWcGk9hHOOanbD6SfZr3xsA=;
        b=eJ0mPx4UVDnhzcHBoS9N/wOX4TKXcTCPfoPFOWuxdOPpvyHrfPIVJX5vrR1c56iHbn
         OZWBERCEdi0d6wJxr8Dw1vSEFWIWyIkzi72OLC5aEQyyXxfDThN0fnidsCbuBOIv4yNv
         7Gdj/WySdoKt73ixIn5w27QtbNjkqnAcuGYUSd7MYfvn1uijRYRbVj2wW0fet/nGI/1c
         6IEv5TdQofZDklWHbhStms+NUAc9U6ovoRQsXxzNxzyEKk91fHGg0k1gEJHn9EgBhvHZ
         eWM9R8XZYY+cWwoV1C3FxtYtONvswwJaBJxVePjFtzY517IJXWnXTvsI/r4yYfwaZxM2
         0rLA==
X-Forwarded-Encrypted: i=1; AJvYcCWmbVrTyBsYptkuQ679dxAwCXbpNgR9chEgIfA/QggrH63eiRkFEfiYro5+n7+uXDgk4qzGBSS0Fi6g8kXPqT+gPRKOQlzsmY0h0tyX
X-Gm-Message-State: AOJu0Yz8XXPMa3tpP+y9KgWdq5IPb8p9CuR0eAsyDioMC2pp3EzJQId/
	QIBFrtCjYPRUm8BO8AUgI8x51EH5FWvQWHu5eKrBpnF9fQK1Lt2JRajo8nA7
X-Google-Smtp-Source: AGHT+IE2MbLgSNszd/1aT46NSngy7z+qvpSJXYcaubYrv2voAMCn3ErPBIDD+SdTl9/ESVADeGM1jg==
X-Received: by 2002:a17:90a:f305:b0:2a0:3813:773b with SMTP id ca5-20020a17090af30500b002a03813773bmr10706507pjb.9.1711506948866;
        Tue, 26 Mar 2024 19:35:48 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id l20-20020a17090a409400b0029b2e5bc1b9sm347441pjg.23.2024.03.26.19.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 19:35:48 -0700 (PDT)
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
Subject: [PATCH v2 00/10] Allocation APIs
Date: Tue, 26 Mar 2024 23:35:21 -0300
Message-Id: <20240327023531.187880-1-wedsonaf@gmail.com>
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

Changes in v2:
- Updated description of `alloc` crate.
- Renamed vecext and boxext modules to vec_ext and box_ext.
- Added derive directive to `AllocError`.
- Updated safety comment in `BoxExt::new`.
- Updated `VecExt::push` and `VecExt::extend_from_slice` to use
  `spare_capacity_mut`
- Add directive to not compile `destructure` and `rebuild` in when `test` or
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
 rust/kernel/alloc.rs                 |   69 +
 rust/kernel/{ => alloc}/allocator.rs |    6 +-
 rust/kernel/alloc/box_ext.rs         |   61 +
 rust/kernel/alloc/vec_ext.rs         |  124 +
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
 35 files changed, 349 insertions(+), 9913 deletions(-)
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
 rename rust/kernel/{ => alloc}/allocator.rs (96%)
 create mode 100644 rust/kernel/alloc/box_ext.rs
 create mode 100644 rust/kernel/alloc/vec_ext.rs


base-commit: 768409cff6cc89fe1194da880537a09857b6e4db
-- 
2.34.1


