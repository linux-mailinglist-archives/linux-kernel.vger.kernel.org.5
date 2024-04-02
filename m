Return-Path: <linux-kernel+bounces-127913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDBB8952BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2061C2324C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E4477F2C;
	Tue,  2 Apr 2024 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4RJZ2Wh7"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655BB3D547
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060242; cv=none; b=NM0qh62O/UniRxyLMaxv515EUfWzzLEVxB2U0nMCeHcLPXMh3CHSnIs6HWV/1VivJx5y8GS/YGGQT2srLdwmi5VzH15+SqNj1mUUlncxdQpCD/JGrzEHEQmiaql4TuYrtVNTX7QXT1O6fxgLzTE3bPA6IlZxN/Qum+QiKLccxPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060242; c=relaxed/simple;
	bh=hb9YLfFeW6qyr//dfTe23L1QTb0/GkGG5H39Mioi6E4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rFEShpFNmM18rQ/jysXN8bWZ16gLp+qWWDYHZ2lflYVxrJ2U9Ty7lVPHhvUCJ1UELkA+zSV11Fq6uUqLDC/Q5UqCEX78L3uuNESverZ/TNKWTCptrmEleG2YBjo19bRJ1VF6+GwUaEQEEhzvlHgBjWTnW/hGdYRf3T9sRF+lUgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4RJZ2Wh7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61514d1bc61so14032197b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712060239; x=1712665039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DjiqI8mRyYXqAtYdhAEsC5C9flNtT/OWZnrkh/1Nk4s=;
        b=4RJZ2Wh72KZCY2PXDHV5/2l1HQa6meQ5lYCqfKe0jXZvtoCig59/Pux4aSd85AEPQQ
         eZT26i3+CfJNxFnLflOHkGcugj9UJBCBKbjIFEieKDhpK7xwKRdId/du3L0yvCag0PlR
         tesQMYTpKEsFYRpHSKq3wtuZMq65ctZqPhd98bIpe7MDM9e8s7Z1dQM6ZV6eZRcozplM
         Q/jGpB3OC6hFi8PGlcp/Eo4YD0jsaXboTQuai8M8nULlAoe6b57gVSPPHsGOOLXyqqxD
         7g3MhEPFJ1JRnPBbXPSC3k6hALOWR01KxOeLZQlWC13+Q+Iia229w91xEJ8IDEN1brZQ
         9b5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712060239; x=1712665039;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DjiqI8mRyYXqAtYdhAEsC5C9flNtT/OWZnrkh/1Nk4s=;
        b=EnCBTAnYxodrko8rj3bplIJIAMkuiBozgZGr72QPmYZ3wnNp7NEak/XnYSS8Am8E2m
         RpPDW3eBQNi1dKfybo7cLwv9Gz6tmjfQA7MUF4MYeoJrRsM7thQGCdEUnhVXBX9JBqw/
         45nzjZnOzzIT1lFlMF3fyPv6ZMqwJZXrQaQMjq7hShP3G4n4uE+qBzRPkrt7Y6d/koJf
         6Tre85r69mtgFzimEE8n2bYTiJzz+hSYaghQE6SRlP88zRWA13J+P41UwWndUFxLwi9x
         6LeTzyiFY3gs8Y7ID4opbYVpDZ6NYnBLOzxrt+Y1fMpm2d+QI5rtP3AinjyiFev6NZzI
         LOLg==
X-Forwarded-Encrypted: i=1; AJvYcCXnHjQ74RNOPs3EPAAkhqukqa7TDjDvjcmNU+vqu7tstsNBSaVKCZIJUUK0GTC8HZExFuB4oWXr85W9j/RJ8EP6F3yKwmhPgZgj8Sfl
X-Gm-Message-State: AOJu0YyuQCXcAqcgPCV9HtDcP/F2TeuxmBE5TVu9kyz6d2EjLpDa11FN
	aFNIzL60b5vyhVgaR7aqqcuCNAVIUQrU07nvjTWJvVtMoCn2ZQ0e4UEm9ff16NNKZ2NB3stickR
	f8gn0CumRYpsLqQ==
X-Google-Smtp-Source: AGHT+IETf0y2x9+0Il6X7o1SicU337VQZAfyTSoBezHqdc2NUU9vqiIk4G3iBLGaUZFk4S9O9osTq3oflFJhPHc=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:b98:b0:614:935:a299 with SMTP
 id ck24-20020a05690c0b9800b006140935a299mr3044145ywb.1.1712060239438; Tue, 02
 Apr 2024 05:17:19 -0700 (PDT)
Date: Tue, 02 Apr 2024 12:16:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADn3C2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyND3ZzMvOzUFCBVXKJrZGpoZploaZBokpKqBNRRUJSallkBNi06trY WABJanWZdAAAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2767; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=hb9YLfFeW6qyr//dfTe23L1QTb0/GkGG5H39Mioi6E4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmC/dHtvJud93RLZvdv6d9mhlvN2Fsz9HC/J4z+
 B8E9nKCekyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZgv3RwAKCRAEWL7uWMY5
 RpqRD/9jTyQm9pFd55v3VDn+UbynCM+WGdAl5VQru105YREvXo8QQD0r9oe9X70i2RRxZ3tQvvy
 n428+KUXKrvYw3DYiK+nOMlnTQmrP8mm5DRVNVxCt3/vxaA+7ABT67zKt2u8yT2l1yv6sKuTxfH
 sS27HWjFS5YAIFKSkO1ioS14Aq6gGd4PYhPXQ+CZZOewBdmeSmf+28CCtAvzn8b7x2mslcwaU+M
 9Zmkm7uSusf4FdDlIMnfKW4WzTiPSfQQ8d7psE8yVmE+hF/CuhPAijMcQYSGR85LWjEeWoMlpwb
 aFC7ikSv6jP2bnBEtHXXE4j9QwqiwKWU6kfXkUVBWK/ZoFhrfcxweerdt4MpkS/y6cDTRYYiqHg
 XN1cSWoDKPaJaNQ5fuw65hBt+zSs+RnlbJ667rfbhWHqB6r7JBg4WOiGvJIsLpw8uRfmqfFlH5T
 cm57zmnjCfxyLQKIa82pY/vFpTO+fxW6MePhKRiPXnHPAQiLapjMEFLnAEL/XLsvLJysA8MMwqt
 dHbT0VP4y+VOeiO2kRjWatMek66+STlMiqd7c8s6v4gB0C9Iwpd7SAlKuyt4Vu4SnjSZCcgbRDl
 Q2/u/dDKxXkHShXzDh5nVv0YieqlJ2V3xA2hEW7FrpIGSV+aPiNj0ABk/Sn2qL80N74+EwMn/C4 HTUTqt7voriDxOA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
Subject: [PATCH 0/9] Add Rust linked list for reference counted values
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, 
	Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This patchset contains a Rust implementation of a doubly-linked list for
use with reference counted values. Linked lists are famously hard to
implement in Rust [1] given the cyclic nature of the pointers, and
indeed, this implementation uses unsafe to get around that.

Linked lists aren't great for cache locality reasons, but it can be hard
to avoid them for cases where you need data structures that don't
allocate. Most linked lists in Binder are for collections where order
matters (usually stacks or queues). There are also a few lists that are
just collections, but linked lists are only used for this purpose in
cases where the linked list is cold and performance isn't that
important. The linked list is chosen over Vec in this case so that I
don't have to worry about reducing the capacity of the vector. (Our
red/black trees are a much better place to look for improving cache
locality of collections in Rust Binder, and the upcoming xarray bindings
would help with that.)

Please see the Rust Binder RFC [2] for usage examples.

The linked lists are used all over Rust Binder, but some pointers for
where to look for examples:

[PATCH RFC 04/20] rust_binder: add work lists
Implements the work lists that store heterogeneous items. Uses the
various macros a bunch.

[PATCH RFC 10/20] rust_binder: add death notifications
Uses the cursor. Also has objects with multiple prev/next pointer pairs.

[PATCH RFC 15/20] rust_binder: add process freezing
Uses the iterator with for loops.

This patchset depends on [3].

Link: https://rust-unofficial.github.io/too-many-lists/ [1]
Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [2]
Link: https://lore.kernel.org/rust-for-linux/20240311-arc-for-list-v3-0-cba1883c62eb@google.com/ [3]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (9):
      rust: list: add ListArc
      rust: list: add tracking for ListArc
      rust: list: add struct with prev/next pointers
      rust: list: add macro for implementing ListItem
      rust: list: add List
      rust: list: add iterators
      rust: list: add cursor
      rust: list: support heterogeneous lists
      rust: list: add ListArcField

 rust/kernel/lib.rs                     |   1 +
 rust/kernel/list.rs                    | 637 +++++++++++++++++++++++++++++++++
 rust/kernel/list/arc.rs                | 431 ++++++++++++++++++++++
 rust/kernel/list/arc_field.rs          |  94 +++++
 rust/kernel/list/impl_list_item_mod.rs | 181 ++++++++++
 5 files changed, 1344 insertions(+)
---
base-commit: 98ebc2e1c5bd188fd3140a0f812b302bb9c3ad26
change-id: 20240221-linked-list-25169a90a4de

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


