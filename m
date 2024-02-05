Return-Path: <linux-kernel+bounces-52948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 715B0849EC1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E048FB2A973
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48557405EB;
	Mon,  5 Feb 2024 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIEK+AfG"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64DA3FB32
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148206; cv=none; b=fCofrOQLwFAvbCmvj5ZQlZR6H7eMdBqTTibEtqjnZsNNOFZF7srnk91oxOGUNUb+jf0vAALrLae2QnsORqzMtP84NRFtN13KiUH1/kumMKHX1O+sFYTPEdRireUSJ2Vvsg08CHTwMPbAPzfitk6SYbphBRvGXoxLyrNV9cWbA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148206; c=relaxed/simple;
	bh=na6D3jFvDAGuKtOmimjbwOie5ZCOIzu8PmTwW3hy3cc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TgkZCjTBYZXMXyR64aEvbqM1qeJvr6kkdRSfGppwk2yFSuQ69DuXlYBMKpXTqlAJFUBnN6yqGYD2pDyVQV/eAIJi8u8ea1nMLaURRaZFqBrPZXxNRFxxYh17r8sB3OoHMtsME/rtLb1w91aOV1DDd3JPsnZcTRuMa0sgHEC/gh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SIEK+AfG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6df2b2d1aso5278540276.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 07:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707148204; x=1707753004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GAwMQVzV1pn9oaE0YS89RA+Q4EyWL5cwKaTUDQddqTs=;
        b=SIEK+AfGwQpcP2lrG5tLLhwG+X0E1txStov2pO15qh6xssOa5ZjZcVfAvKQk74aNwA
         NR75UyQppH88reHw3m0SrR8iQIwdghV/hmaUGIZUhr9DWxS4rtXZPR1ob+y1lKnLz+m3
         o88dM+1jVIkiA80tcWUnF7wJmM/tGgGVVbxHUbxIWcHz5TYGJmYM87zb9SjHznNXBzGc
         JpPl1PwuH2Oys8Wgpk56lvKyyNT49uNwxjOM5wxp4t53RgkqerzHDALOqtVpgPLR73LN
         FqXjZK5qhr+0xX/AW1a5v4UgjWDKtuJ4mHPu1VggtasiHVweYw1bR9JFDQn1AmOYn7N2
         zUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707148204; x=1707753004;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GAwMQVzV1pn9oaE0YS89RA+Q4EyWL5cwKaTUDQddqTs=;
        b=ZVAqgI7dUS9P7EkKoZvaaEEELdby2qBWwY2U8mQOhf3o7kkI8S2UVdUZeVRy5aTr32
         OmX/Hf+1IV85OWmIhnOGjqNKyGAx8NkiUv3CFPVQnf00KMelD+qNnYnqVzgLEjVUYX4f
         3ggEncqrQXS10Lgw0p3QwTVqE7aLXl/nP45htIGCtF8s6y0gLcip6+YtsGfF58I9yy/n
         2q8Oe89smA8P1hbdbZa6P7m0c9jHH2XhpEC57sLHtAP2ytGfVB7lm02Kwe/eJYSl+b6O
         upfJ3PfcUFLcslmzbMKrNHH7ii/dVKgmpSOHyukwB2oAiwDlyQMnoRpWv/WVlVmmDiEl
         y30g==
X-Gm-Message-State: AOJu0Yzwd/I++IU/LWc8eRwJFeKsDOJndTMSMZwPol+LXwtIL7VrQEbZ
	/REyNEpkQkDTme9oyF3f+3+1zzNqZBsghuyvwZRBt2dWhBu6lpeXxl1hURqX+o0tqzcw/AQApch
	IBMHzgnlXPCcnzHkKoWBnFl22XA==
X-Google-Smtp-Source: AGHT+IGx1P4ttD/5wp3LelUa4rh+cpv2aSW92se7mShsiShtYhqY3V9ZV97c441GGjl/+GAnvRD4Vu/PatP9VYi+jAs=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:1b88:b0:dc2:5456:d9ac with
 SMTP id ei8-20020a0569021b8800b00dc25456d9acmr565129ybb.5.1707148203919; Mon,
 05 Feb 2024 07:50:03 -0800 (PST)
Date: Mon, 05 Feb 2024 15:50:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKgDwWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDIwNT3SQT3aKkkqLUVN3EpCTDRANDszSDRAMloPqCotS0zAqwWdGxtbU A8SvFcFsAAAA=
X-Mailer: b4 0.12.3
Message-ID: <20240205-b4-rbtree-v1-0-995e3eee38c0@google.com>
Subject: [PATCH 0/6] Red-black tree abstraction needed by Rust Binder
From: mattgilbride@google.com
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
	linux-kernel@vger.kernel.org, Matt Gilbride <mattgilbride@google.com>, 
	Matt Gilbride <mattgilbride@gmail.com>
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
 rust/kernel/rbtree.rs | 1213 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1253 insertions(+)
---
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20231205-b4-rbtree-abb1a016f0a0

Best regards,
-- 
Matt Gilbride <mattgilbride@google.com>


