Return-Path: <linux-kernel+bounces-131436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954CB8987E6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F741C21B8C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A861684D35;
	Thu,  4 Apr 2024 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JPwtZY+d"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B0F8662A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233924; cv=none; b=YckSPenjHgbP/mCkOEvx5JpN2lAR0/lxI5+IR06UNuzOipqUB7F0ujGH7NDrR0pLeRtwUf7YplLeBNaKkL54JeYvEKdbHF7YYBD+jwQmoUIQBv+iUNgI/i3QCZNuHmwI6pk0a68fcLN/y/D5sQJslv+l9YvHUqHvB9a9jwzt5hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233924; c=relaxed/simple;
	bh=uGUdk3e/USR45wu9+IdS0MgK8dBh31QXCZ/leMk0cGw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hlC4dks63yYKSN3paoDC7joklwKX9+2kny/Hi/UTeFBhFyRTFL6N2t5a2JlRg4xotWDvHTwJep3o3a4PRk4xBMa2ed8RhZ7tscCzqHVnFlr/eVa4Gz/N0p3iTKWvgn/ww2Wnc8wEKnIkHk0vkJ9a0PTD3KV3XNQTkqUeLWpQpls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JPwtZY+d; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so1764142276.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712233922; x=1712838722; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BdH/gdE1nY5fzXt07x1io7y2LA29YSrbMxYZzDwB1DA=;
        b=JPwtZY+dHV+cedyXfBXGDprX4/0KhbJctJNUTArt5cVCGgZjw0Weg2+jTngxsDYJ9w
         9lpRhhYuuv0LrRqlowOHPW/6UtlfoNFk0yc6TTKdD2+TgqeRIiMcBU7CwSQO0+KhoL4z
         206H6uO4Z2e6LgtVU/qPw+KrlF6WoiyBjA6BNfFYnPiT/6KQCzE2kL4otvtvKa087Bwc
         w6wu3cO8TYVHdsMjWgZk9Rk9jBCkmIf0OpZbx0lNCsFKsLcfs3ejBodkDvIOqg/W0yOF
         tQ8HuQQUuD629kmdOw/4sYnr1UgceWF9sL7iVhe6FBjW0zcb7zff/amVBf9IBu4bQMFI
         rT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233922; x=1712838722;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdH/gdE1nY5fzXt07x1io7y2LA29YSrbMxYZzDwB1DA=;
        b=s31tV7VgZ8XQ6UKD8jCN/eFJ5tj5c5ZuABO60T4PxEDuBJgbwe/3XfMgvRNtyGIr6w
         +LXzwIYQmTnrsix/lpFLOIc40/ogueqqo2izEdAePcxbOSFYJnmHWB5uj4vnGhTUk/IP
         RAeGtyEJxVWQXZ64sSHzSOjo25yftj2QFeyhW66HDm411IAf+i6+P3rOrpMudJBCz9EK
         qpF+NHCELqPXNt//WXClLLxcLJ9BRxbhdDFLg8e0cpldu1Y+h2Vt4EOy4OPoqgRJco+y
         6qurD9VHgcm0iICtsgWY05rye4F/Lrd4JUFvIg2IByOsWeqm8qqPGYQhoOhRkrLRme7+
         OWhA==
X-Forwarded-Encrypted: i=1; AJvYcCXDV3f/kcONPhKU9zgQoBEp2O6SOFDYg5bnHO23tQ9tyKPxlMcvnVrF/+8WScoLodUIEeRQKosQhqeXRfweEHCNppndHvA2HinU/h7D
X-Gm-Message-State: AOJu0YwC0n1ykLdqwilqW/kgTcWTeY/kmWLPOQVGzXW3rVwOJz0KfmhC
	k/TfoPkg5XMfPP2p/dtpboB3vaahzEuUOOKDLFoy65evq291OybcOulyrK/vw8imOg0z6GNh7Yv
	uwZOZbDqZ8UxHoA==
X-Google-Smtp-Source: AGHT+IEzh3qIzx1LAGE4XI7mt8DeGvKPiyuxF8I3px9EKzj/18nnGCvXVL454agqVBa79GQD+n0YaBC4Ds3u/dA=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:124e:b0:dc6:e8a7:fdba with SMTP
 id t14-20020a056902124e00b00dc6e8a7fdbamr667777ybu.4.1712233922217; Thu, 04
 Apr 2024 05:32:02 -0700 (PDT)
Date: Thu, 04 Apr 2024 12:31:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKqdDmYC/2WOQQ6CMBBFr2K6tqadFkRX3sO4KMMATYCa1jQaw
 t1t2YBx+Wf+ezMzC+QtBXY9zMxTtMG6KQV9PDDszdQRt03KDAQoKaHiZrBIfBx5jYVSuiiRqGK
 p/vTU2vequj9S7m14Of9ZzVHmaZZoIUFvkii54I00NRJWCrW+dc51A53QjSxbImwkiN35CJmsQ EKRFtqUf6TayPT6jlSJxKY918ok8oI/5LIsX2UGH+EVAQAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3421; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=uGUdk3e/USR45wu9+IdS0MgK8dBh31QXCZ/leMk0cGw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmDp2toiRNy364oNYICcJk/sSU/qgF/S+vB+KAC
 UcWEIQPVMSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZg6drQAKCRAEWL7uWMY5
 RmGtD/9vmmD8rIAtTMInumhoyT6YIjXsYoBFdWkL/6yRQu4cwHvlSnwGi/7bAKtHK9ovPJuVjs+
 cFAsn7y2j9s/jvGA/97N7qdXTQNKoMd0ojcC6TA11XTbYV4uWTrQYfHbmi8wjKIZv6cgnL6kRo8
 5tqHWOucZdduDrD/g8vWVxmrYB7m3iC0p0YOdLxHdft5TIyLQKm/wClid7hQApy72nDYBSui86w
 5CkhiLUmjPDnYvAy2ITx6esrLBP5xBqMpUb6u2aDaR/i4JS9bor0V6PEDL83WhO78Qb+S+RKAtV
 q4W0dCNR7gBwPDJ2ATUHXLyInmbKotvd1eYGTf+gE/KOTVigNYMBPIQL4ooywsVxzu5DxVPou4T
 ONXWnG/keiMZDxuzZxLUGnU/0n8AFvxowwb7xsUoG2FH9d1yXI5f8L5yAW2Mamt/7lEyqjhLX/u
 eEJVe0PTVF+SBl+3eTvUMF2uAuNU4nm1456lbiD9nJDfsLOu1AWUtGsfYVNaiok3BsYKcqkRbu4
 u1eiy6ldcFaoXum6iHL0QvK9rX+MZPcjQNBQl1G4ALfrZTn32Jhk8q7G9Rd39g4shyHf9NRZJsd
 X1GsmLB2LJw7V9dwvNLv3DQa2hIMig3gIFyjq4lCwv+TR1yolDb0nvONC/B9UMwNLNjk9OuN+mW +l3Qxg8RtTX6c/Q==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240404-alice-mm-v4-0-49a84242cf02@google.com>
Subject: [PATCH v4 0/4] Memory management patches needed by Rust Binder
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"

This patchset contains some abstractions needed by the Rust
implementation of the Binder driver for passing data between userspace,
kernelspace, and directly into other processes.

These abstractions do not exactly match what was included in the Rust
Binder RFC - I have made various improvements and simplifications since
then. Nonetheless, please see the Rust Binder RFC [1] to get an
understanding for how this will be used:

Users of "rust: add userspace pointers"
     and "rust: add typed accessors for userspace pointers":
	rust_binder: add binderfs support to Rust binder
	rust_binder: add threading support
	rust_binder: add nodes and context managers
	rust_binder: add oneway transactions
	rust_binder: add death notifications
	rust_binder: send nodes in transactions
	rust_binder: add BINDER_TYPE_PTR support
	rust_binder: add BINDER_TYPE_FDA support
	rust_binder: add process freezing

Users of "rust: add abstraction for `struct page`":
	rust_binder: add oneway transactions
	rust_binder: add vma shrinker

Links: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v4:
- Rephrase when we fail with EFAULT.
- Remove `pub` from examples.
- Use slices for raw uaccess methods.
- Fix PAGE_MASK constant.
- Rephrase most safety comments in Page abstraction.
- Make with_pointer_into_page and with_page_mapped private.
- Explain how raw pointers into pages are used correctly.
- Other minor doc improvements.
- Link to v3: https://lore.kernel.org/rust-for-linux/20240311-alice-mm-v3-0-cdf7b3a2049c@google.com/

Changes in v3:
- Fix bug in read_all.
- Add missing `#include <linux/nospec.h>`.
- Mention that the second patch passes CONFIG_TEST_USER_COPY.
- Add gfp flags for Page.
- Minor documentation adjustments.
- Link to v2: https://lore.kernel.org/rust-for-linux/20240208-alice-mm-v2-0-d821250204a6@google.com/

Changes in v2:
- Rename user_ptr module to uaccess.
- Use srctree-relative links.
- Improve documentation.
- Rename UserSlicePtr to UserSlice.
- Make read_to_end append to the buffer.
- Use named fields for uaccess types.
- Add examples.
- Use _copy_from/to_user to skip check_object_size.
- Rename traits and move to kernel::types.
- Remove PAGE_MASK constant.
- Rename page methods to say _raw.
- Link to v1: https://lore.kernel.org/rust-for-linux/20240124-alice-mm-v1-0-d1abcec83c44@google.com/

---
Alice Ryhl (2):
      rust: uaccess: add typed accessors for userspace pointers
      rust: add abstraction for `struct page`

Arnd Bergmann (1):
      uaccess: always export _copy_[from|to]_user with CONFIG_RUST

Wedson Almeida Filho (1):
      rust: uaccess: add userspace pointers

 include/linux/uaccess.h         |  38 ++--
 lib/usercopy.c                  |  30 +---
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers.c                  |  34 ++++
 rust/kernel/lib.rs              |   2 +
 rust/kernel/page.rs             | 259 +++++++++++++++++++++++++++
 rust/kernel/types.rs            |  67 +++++++
 rust/kernel/uaccess.rs          | 383 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 775 insertions(+), 40 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20231128-alice-mm-bc533456cee8

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


