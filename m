Return-Path: <linux-kernel+bounces-150260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D074E8A9C6E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3721F2041D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B86165FCA;
	Thu, 18 Apr 2024 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yPRMROaM"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D33165FD8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449747; cv=none; b=XjehrEvm1jwFKxMyyi/8oGIPX+JhzefPA2XR+5YAGJyKalatWehyMfW3TPL1t9nE8rEJaR4vKdtVnedKC3s4RgzBh9j6nHD/TZBTfNo++vzj4GUK+zz8E+ewtm+yuvNEo6Sksru4C2HoXMuIFedVKoSCZjfLNk/uukGa67jMcbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449747; c=relaxed/simple;
	bh=m1YV3MNun7XuWA7B78NVbZOkPP2rvdY4f2uOk5CQSy0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=l3522Ldq5USx6Uabqg0Md84fk1HpKlnY7cL9abKKdarlwqZ4AY7fYleDyRAY6oAL1C8M0/tL2VjTGXOeAf29sNCMrnqlIZ/CNWh/V/fuA47JaNOxSNCQG3m2fPO9B7uLXGmxnt142Bjv3Forc2ShmY2JIi9p7zOqjGPeYwcDQn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yPRMROaM; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de4645bee83so1446499276.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713449743; x=1714054543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jwRanQRdUIcfSKJvkIkP9Sl2pJsKe5JFR6MS4BygDeE=;
        b=yPRMROaMcK6r3zz+iIgMkjx+K7tmye5Q3rIhJC9bH+w0/6WnKuImA4DRCEep4c3aX2
         mowYJnOqpR+n32lZ1I7t0SiyjHOrN+2Zsb8r394mllTUrQEmTZMAjviKFWZkQuzbK0rW
         ZSHXSRwnjArVz9tGdHttNU3s+55T6a6TH+1XqeRGIqUOFyMkOsAcbFA/rrZgKaONR6DB
         e9/w2suJGE9/x+IO1zSx1+Meo9lFP7X8V/a79Uh+vNTBgcgF0KDMXKfYvDjAPTax0Gkk
         BACaLl7bcW0ttfonJaiS7NuX36hx0/wSnR2zp7M6rqaB7K39Vnj/rbPCaZNhTHJ4snNW
         kqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449743; x=1714054543;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jwRanQRdUIcfSKJvkIkP9Sl2pJsKe5JFR6MS4BygDeE=;
        b=KfFqlQodKmptzXQfKrMZqtF8i6cWBiJVXmOcHcNvDvyNVx1r3JWJl6dnjPfYoSJRQ4
         klZMfjYLMYVdOSctzgec9beB7dWLMOiMl4ue4fNTbyr2mQvs+wRAfiZ6IksnRZjznnmr
         LLBa77HYW+5TddKqeWPYRJpQFuWLB6qNcz74L3gLDMikjJikGkRotspOzniXoMU3/mP4
         eiY1oHc/6H/nmxgBhE3RvmUG6fs8RCSHE6pP4pVnTztPNnXosRmbQwIdWfcUQgJjooKP
         gw+4dnl/Mm1CPc0nF5lEZkkJ2Ftszk0f+aGkkPvlli9PqG1DRHp2SZZ6U/UFKad7HfIE
         RIRg==
X-Forwarded-Encrypted: i=1; AJvYcCVPnHA1XBK4k25qiI2PjvCum884mSv7elbDevV/dK3/i2b7sPQMc3QZ73s04l6wQTaEBLgk6RLpxeYvIiReqXraKwss1NN/xDJkxOTj
X-Gm-Message-State: AOJu0Yz6/KQy26GJpYdBuqCfSrfm2T1EDQ2B3WtHnXjyJffC2k92uzCe
	A2JU3KA0Mep2JUoQOPBvgDdD0eNdrNoMqBcmi6X/6d+8bW0DB25I9b7pTIu8SPmaY/RdasCWwG5
	3OhUHSq3j3W6draOtw7qc5wUcxA==
X-Google-Smtp-Source: AGHT+IEhqqqsKD1LDmpoWsje1FxbuodFbsJWxju4+dQ1mp553sg934LNltIKyE0wL9oeaQY8GrcYmH2u+T02apahsmQ=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:150d:b0:de4:5ce5:2656 with
 SMTP id q13-20020a056902150d00b00de45ce52656mr241547ybu.8.1713449743516; Thu,
 18 Apr 2024 07:15:43 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:15:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAwrIWYC/1WMQQ6CMBBFr0Jmbc1MB4y48h7GRQsDNFFqWtJoC
 He3sILl+/nvzRAlOIlwK2YIklx0fszApwKawYy9KNdmBo2aSWOlbKmCnYKIMtaSQbp0aBDy/xO
 kc9+t9XhmHlycfPht6UTrulZKPFYSKVR1XQmLCF8bvPfe9y85N/4NaybpnUr1XtVZRUvExlhmb A/qsix/YmUBvd4AAAA=
X-Mailer: b4 0.12.4
Message-ID: <20240418-b4-rbtree-v3-0-323e134390ce@google.com>
Subject: [PATCH v3 0/5] Red-black tree abstraction needed by Rust Binder
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
Changes in v3:
- Address various feedback re: SAFETY and INVARIANT comments from v2.
- Update variable naming and add detailed comments for the `RBTree::insert` (later moved to
  `RBTree::raw_entry`) implementation.
- Link to v2: https://lore.kernel.org/r/20240219-b4-rbtree-v2-0-0b113aab330d@google.com

Changes in v2:
- Update documentation link to the C header file
- Use `core::convert::Infallible` in try_reserve_node
- Link to v1: https://lore.kernel.org/r/20240205-b4-rbtree-v1-0-995e3eee38c0@google.com

---
Alice Ryhl (1):
      rust: rbtree: add `RBTree::entry`

Matt Gilbride (1):
      rust: rbtree: add `RBTreeCursor`

Wedson Almeida Filho (3):
      rust: rbtree: add red-black tree implementation backed by the C version
      rust: rbtree: add `RBTreeIterator`
      rust: rbtree: add `RBTreeIteratorMut`

 rust/helpers.c        |    7 +
 rust/kernel/lib.rs    |    1 +
 rust/kernel/rbtree.rs | 1275 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1283 insertions(+)
---
base-commit: 768409cff6cc89fe1194da880537a09857b6e4db
change-id: 20231205-b4-rbtree-abb1a016f0a0

Best regards,
-- 
Matt Gilbride <mattgilbride@google.com>


