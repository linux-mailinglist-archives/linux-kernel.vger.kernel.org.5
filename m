Return-Path: <linux-kernel+bounces-19717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4478271CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113DD1F23211
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0904778D;
	Mon,  8 Jan 2024 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RoAfq4dO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FB147780
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e7547e98f1so31754497b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 06:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704725404; x=1705330204; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5BINcGECvEsWTT9DMOcD/NYX5FsAQjYJ3MPey7hy/CI=;
        b=RoAfq4dOGv3yBeCPUGy1dipj4Big8eoYGbojMuPcmMWoPb+tkEJc5q0og/CvchkMKS
         DchFjQBNW/HSLo4IheNxBMZbe33HU76nsvSc++g/b2aGRY+IaBP/hJ2ORmnRZ9cPtipW
         wE/HskxX+ThMMMZerTXzOZ23aOgX5sJUTcGoMyFlboHhQJmPqwFRcYrDluKQ2ZNAhAbJ
         RzYGmBK2zHQ1C+XNaxsJ8zIhnnJd98GsLh4cOFUEB0Ps2U79wOg1zGxR0N/ifouRkoxq
         GIWlneU9HaGXlYDFUYeBC8fEfk6c49BNn5UUT5Tl62n7Nen6Tr7Kk+kKzWgahCsS6Wbi
         vjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704725404; x=1705330204;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5BINcGECvEsWTT9DMOcD/NYX5FsAQjYJ3MPey7hy/CI=;
        b=GO8wSpDUHBa8x/cDIfnGcbrxv+lMFt0G6usunwn4BCF/9GeErlErelK5s8ciL9x/3b
         87v0293yfw9/knMq956BsTbnlSGJ9AJoUHH8fqdRV0dC+Nf9tNKszBRnxWW0Et2xQqZS
         oTdJdhcdGU/hWuDgEzNzRL9LO/L1DyuPNGG/YhAwzKucMLJYUMNoBM9e3rVzVdcSs5d7
         uUy3JoKfm3ZmSZdNNLtD+yIlbHLTQE7i53y17NZ6DfhNT2FMlHXYaiPV8DL6Q2jxMaQl
         kpCC1KTq2Q0EadrK17JufmnhCNWSC2t9P872cIVhIXB8EF8KJTM7bLd4Is02C2KxxKkR
         vXQg==
X-Gm-Message-State: AOJu0YxIOChd6pCfTWp6siNFMVJfQDzXVh94msHkHQm6sFGErFDtJ+jz
	uv5/XkZDdBtF8SSITe7DcTS8+Xy3DVR6t/wWfxLGkw==
X-Google-Smtp-Source: AGHT+IGOGzj9aEfvqssJXaiS+G17nnnYxCa62EX3NL6uTdjiNulnlUsR7q2pYMVsE+EpUC7eFqLAVDqiB2tELbo=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:27c1:b0:dbe:d5b3:89dc with SMTP
 id ec1-20020a05690227c100b00dbed5b389dcmr1610521ybb.0.1704725403851; Mon, 08
 Jan 2024 06:50:03 -0800 (PST)
Date: Mon, 08 Jan 2024 14:49:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJULnGUC/3XNSwrCMBSF4a2UjI3k2aIj9yEO8rhpA7aRpESld
 O+mhYIiHf4H7ncnlCB6SOhcTShC9smHoYQ4VMh0amgBe1saMcI4ZUTiqPEAT2zCYLOKuIexCzZ
 h1mh1ktZJKygqx48Izr9W+Hor3fk0hvhe/2S6rBtZ75GZYoI5V8Io3Tir1KUNob3D0YQeLWZmX w7dd1hxNJFK1xRqK/WfwzdHEErErsOL0xAtqXBGg2Q/zjzPHyDd8ABNAQAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2913; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=XVBH1qF+OhuNqpjEXI7B/xwdvAfa7Seq4OzBOwOWR64=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlnAuW1Vhoq6TeJkpHejsmIMZb2vak2s481PpY1
 W7Vd6hXk7OJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZZwLlgAKCRAEWL7uWMY5
 RoPUD/0feWBz/CvDY5WnXDYuRumChdf+/N5FkNrkJvErOCB5U97equhbuyFNh0b4m2BDkKOCNUE
 NuKht2KU6vstUyidH4M1ZcSiCvP8n5bc8brNVyKfYGELQSYeqWvFGyJZVgtIXNiCQk8Qy/VPemJ
 BTXJvw/ecwRHE1Yoy6EOLvvDGVmeHLsyTz/XWVjY8Q/daEB0pcAhSUHPueXYhhK2qh9lG+K9lsV
 YeE/O/sg+TaNt8pVSMx3s6Kqw/Ty0eCUz08tJJOQEm2x/y/z2IK6fIw1dXIqZie6B+Inf0SBFv5
 Zx1yLz0XzIbqhEt+nwq4RekUOIgdeCSKa21H/82jmhqqCgztF3exdiCq7sCvKmb3ZVYv0KO94RJ
 9opZx7lsIKt4CeMP9rP6+/wt2uvigaLmd0ZhZOd6qA9vLGqAK9SdDgaOYLK3RC6dRPwBoUn9aSl
 TWGpD04xqoegPH4AxFpq+w9c5H1CzNKP99MFp0jQFHrbNSPiinu3zlFT5fmBIuUaGLKmx3genSp
 AOVGzJYCAyJKPA6JEExHYd9SdLSqFCtHGOzaEyvHWwlfGmA8J8QvBmUjFMD9KdckehUR1C2mFKg
 ep78QyvgFjvhStDFAyAeu9HQULxfUCUoZFU7oq1YW0Cq3Sad9dEVuLBzfDkV7cEcowmol275yN8 nQIoZMfGQsIxejg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240108-rb-new-condvar-methods-v4-0-88e0c871cc05@google.com>
Subject: [PATCH v4 0/4] Additional CondVar methods needed by Rust Binder
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Tiago Lam <tiagolam@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This patchset contains some CondVar methods that Rust Binder needs.

The CondVar type implements a condition variable, and tries to mirror
the API of the CondVar type provided by the Rust standard library [2].
It is implemented using a `wait_queue_head`.

Please see the Rust Binder RFC for usage examples [1].

Users of rust: sync: add `CondVar::notify_sync`:
	[PATCH RFC 04/20] rust_binder: add work lists
	[PATCH RFC 07/20] rust_binder: add epoll support
	[PATCH RFC 08/20] rust_binder: add non-oneway transactions

Users of rust: time: add msecs to jiffies conversion:
	[PATCH v2 3/3] rust: sync: add `CondVar::wait_timeout`
	[PATCH RFC 15/20] rust_binder: add process freezing

Users of rust: sync: add `CondVar::wait_timeout`:
	[PATCH RFC 15/20] rust_binder: add process freezing

This patchset is based on top of the rust-6.8 tag.

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
Link: https://doc.rust-lang.org/stable/std/sync/struct.Condvar.html [2]
Link: https://lore.kernel.org/all/20231214200421.690629-1-boqun.feng@gmail.com/ [3]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v4:
- Fix imports.
- Improve documentation for `notify_sync`.
- Add justification for using a jiffies-based `wait_timeout`.
- Link to v3: https://lore.kernel.org/r/20240104-rb-new-condvar-methods-v3-0-70b514fcbe52@google.com

Changes in v3:
- Update module description for new `time` module.
- Move constants to `rust/kernel/task.rs`.
- Fix incorrect doc-comment on `CondVar::notify`.
- Rename c_long argument to `timeout_in_jiffies`.
- Link to v2: https://lore.kernel.org/r/20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com

Changes in v2:
- Introduce "rust: time: add msecs to jiffies conversion" patch.
- Introduce "rust: sync: update integer types in CondVar" patch.
- Merge wait_internal and wait_internal_timeout.
- Use new Jiffies type alias instead of u64.
- Update names to use _interruptable suffix (and base patchset on top of [3]).
- Link to v1: https://lore.kernel.org/r/20231206-rb-new-condvar-methods-v1-0-33a4cab7fdaa@google.com

---
Alice Ryhl (4):
      rust: sync: add `CondVar::notify_sync`
      rust: time: add msecs to jiffies conversion
      rust: sync: add `CondVar::wait_timeout`
      rust: sync: update integer types in CondVar

 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  1 +
 rust/kernel/sync/condvar.rs     | 95 ++++++++++++++++++++++++++++++++---------
 rust/kernel/sync/lock.rs        |  4 +-
 rust/kernel/task.rs             | 18 +++++++-
 rust/kernel/time.rs             | 20 +++++++++
 6 files changed, 117 insertions(+), 22 deletions(-)
---
base-commit: 711cbfc717650532624ca9f56fbaf191bed56e67
change-id: 20231205-rb-new-condvar-methods-27ba95df5d41

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


