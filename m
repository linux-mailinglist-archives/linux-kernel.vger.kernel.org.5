Return-Path: <linux-kernel+bounces-71240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C84C285A265
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA08284E23
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4602C86E;
	Mon, 19 Feb 2024 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oqk6Y6EN"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5592C68E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343316; cv=none; b=AnuiemWU4FrZufXcH/wneTP+ZXQbz3kZ3S9J4QiUUIun5F8fqgtKdPeC64xAADfj8c7zPaiPZCV9NGWJi4VeGaxqxbYYlfXj7kEiOo+TItxS+f7Sx2TaPB4CCpeQDHPlANqpYmG+81IuzOloospsPjf7PAkMTc0hZdhWyrEMtAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343316; c=relaxed/simple;
	bh=0BgyreMqzz0PMtI4QUlHgDPJch1SnZJpj6ZUNM2eegA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q7Ta6azk+LRZy1kRb0gLN9+89aTc7BowKPgfUXIohja06lZwBtK3xxLrTOztu8xHL6cM5jg/lihc7fi7prwM8B52f+QpPKtxqHdkxqHbWS1NEU/sRIsQbrsSJ/7LWcv99hxJhmytOA3QF5ZgiX7KQkpgjDbDbVHCgJRxmjJq4gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oqk6Y6EN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so5325860276.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708343313; x=1708948113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zq3hIb/a7G7RDHkyPhkOMlDdykFo1mSw4GBQxXEi8tU=;
        b=oqk6Y6ENgoe+QN87VFoeCynR06gMK0PE9szXy93wj+qpKdCv/Ut+jWHL38P+q4KSCJ
         +isL9ifP+vUnGrjI7URyHTo0P/2R5wFkCgxUTyOJT1G3HMT4ZempChegdeW5REDR3IQc
         2y8oZetCWnFiaFe9QvzzLdjpfZnbvGZBpC/ijeOJwKKuTIdKiZZhe2U9JAf+1Jxj0Dur
         GPIM9ceiLB9zfZOHGfq/vD0vnfQffbMFWEq3DJVkrquS2YvyVWFw/zqD654De1YqziG4
         BuzH+TD7sHyhjuOAJEAWeuu6pRHNWehubdtbG1FEj2z0Qsy0uDz84AHn+uLis/NPkfWD
         OlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343313; x=1708948113;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zq3hIb/a7G7RDHkyPhkOMlDdykFo1mSw4GBQxXEi8tU=;
        b=NuFCwZA6ohol2lCgcbt64+HqPiYk+ADXn0bb4FZZ91fu7BAK+62LLsJhb78IpAj0kF
         ICxfdgJd4Bp2fpP4cSiqaUfgj0bhRs/a8HedRmVfcnG7FBmPRv5/PiC664pGCqWPYlKx
         rer/qor9ISoLU8FuTzj9GTon6kfQqUqJwlT2EP8tSIWbYa5dUDsUnDOQ56C+xWhM7Xdp
         XT6zE8jxqZ7FCUYEDz31Y5gD9KxGUtKK6ZgHt3s8hh8TF2Eabs/n4KQVFSinEvJuiLS1
         yPSM4p+zGVO4oGpLUXte4FLRh6G0yfZ/XrGILvD930Whs9BsknToCTNJa1dujo68Yquq
         ndiw==
X-Forwarded-Encrypted: i=1; AJvYcCWfKDmPcKG/9bRV5ehkZZb4FiaFzoJs0+7/gPMIECeKNeil16UmRIr8EUhiV+UiAW1tw5UFNiY39RcZX/V/oGtufGNoRJL/qlqsGDM5
X-Gm-Message-State: AOJu0YzpJiU6D++TpbLuXo8BiBxHaMJZ9nZuvRhFcLdVSGrfE0pQe+F6
	LZ5uwdv2p+uuyc5Ik3AoQ+KrqvX5j4jMM/XlPm30YoKbUPtBbaAI6mfV58GB5/Earbq+ivuPtmd
	nb6DSCGufreVbtjMo6OkYRnkD1A==
X-Google-Smtp-Source: AGHT+IGUtuNzHb8DfAI1iCN8ixzq7V3b1Aq8vTZEZtpY7YPkl5b+Jjek01Sl+n0GHaRJyXNs96yLgaeGWpKAz7u4sbo=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:1b85:b0:dc2:26f6:fbc8 with
 SMTP id ei5-20020a0569021b8500b00dc226f6fbc8mr479732ybb.7.1708343313437; Mon,
 19 Feb 2024 03:48:33 -0800 (PST)
Date: Mon, 19 Feb 2024 11:48:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPc/02UC/1XMQQ7CIBCF4as0s3bMAK2xrryH6QJwSkm0NNAQT
 cPdpd25/F9evg0SR88Jbs0GkbNPPsw15KkBO+nZMfpnbZAklZDUoWkxmjUyozZGaBKXkTRB/S+ RR/85rMdQe/JpDfF70Fns66609K9kgYR937FiZnW1dHchuBefbXjDUEr5AbpTt/SjAAAA
X-Mailer: b4 0.12.4
Message-ID: <20240219-b4-rbtree-v2-0-0b113aab330d@google.com>
Subject: [PATCH v2 0/6] Red-black tree abstraction needed by Rust Binder
From: Matt Gilbride <mattgilbride@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, 
	Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Gilbride <mattgilbride@google.com>
Content-Type: text/plain; charset="utf-8"

This patchset contains the red-black tree abstractions needed by the Rust
implementation of the Binder driver.

Binder driver benefits from O(log n) search/insertion/deletion of
key/value mappings in various places, including `process.rs` and
`range_alloc.rs`.  In `range_alloc.rs`, the ability to store and
search by a generic key type is also useful.

Please see the Rust Binder RFC for usage examples [1]. Note that
the `container_of` macro is currently used only by `rbtree` itself.

Users of "rust: rbtree: add red-black tree implementation backed by the C version"
    [PATCH RFC 03/20] rust_binder: add threading support
    [PATCH RFC 05/20] rust_binder: add nodes and context managers
    [PATCH RFC 06/20] rust_binder: add oneway transactions

Users of "rust: rbtree: add `RBTreeIterator`"
    [PATCH RFC 17/20] rust_binder: add oneway spam detection

Users of "rust: rbtree: add `RBTreeIteratorMut`"
    [PATCH RFC 06/20] rust_binder: add oneway transactions

Users of "rust: rbtree: add `RBTreeCursor`"
    [PATCH RFC 06/20] rust_binder: add oneway transactions

Users of "rust: rbtree: add RBTree::entry"
    Not used in the original RFC, but introduced after further
    code review.  See: https://r.android.com/2849906

The Rust Binder RFC addresses the upstream deprecation of red-black
tree. Quoted here for convenience:

"This RFC uses the kernel's red-black tree for key/value mappings, but we
are aware that the red-black tree is deprecated. We did this to make the
performance comparison more fair, since C binder also uses rbtree for
this. We intend to replace these with XArrays instead. That said, we
don't think that XArray is a good fit for the range allocator, and we
propose to continue using the red-black tree for the range allocator."

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
Changes in v2:
- Update documentation link to the C header file
- Use `core::convert::Infallible` in try_reserve_node
- Link to v1: https://lore.kernel.org/r/20240205-b4-rbtree-v1-0-995e3eee38c0@google.com

---
Alice Ryhl (1):
      rust: rbtree: add `RBTree::entry`

Matt Gilbride (1):
      rust: rbtree: add `RBTreeCursor`

Wedson Almeida Filho (4):
      rust: add `container_of!` macro
      rust: rbtree: add red-black tree implementation backed by the C version
      rust: rbtree: add `RBTreeIterator`
      rust: rbtree: add `RBTreeIteratorMut`

 rust/helpers.c        |    7 +
 rust/kernel/lib.rs    |   33 ++
 rust/kernel/rbtree.rs | 1214 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1254 insertions(+)
---
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20231205-b4-rbtree-abb1a016f0a0

Best regards,
-- 
Matt Gilbride <mattgilbride@google.com>


