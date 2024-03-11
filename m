Return-Path: <linux-kernel+bounces-98715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E51E8877E58
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70821C214A3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABB639870;
	Mon, 11 Mar 2024 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sfkt/N98"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE780374DB
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154043; cv=none; b=g3ILNjdjToTWtPROUne12wyyN60AS9a4rpNr2ozbauxG/tmboBiuu+yGYTCCbbhqNFBbVikr5m+LUKE7mLp9osAk6s29ho81wfmfzjW5V2lDG4YagtK9mOEce+w+LKGNLKmzTbDlUghUHOkUPHPslduzfxeQOXcWweRgKD/pJBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154043; c=relaxed/simple;
	bh=eFO8v8hNbjIyLu0r8FdBf9oSrloJURleePlt88en+Ow=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YnPRdhQWNL0WL7B4EGwawBKQM0/mHtEn0KV92AvCZ2VgUpUHPARzpheFxzxo+C1I68lFjzuMm8TSn58Vi6yB4qMs1n930c0lmZzXSRrpCUmfre0e9VRnx2ytZSvzf4ZxRrXwvZEL0QMWeuAHEXNwMoGOaRSZ5qsj1aD6MxNjYEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sfkt/N98; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f38d676cecso64333687b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710154040; x=1710758840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OL5M0QWyifHNNdL2G7ppAclszTpwZdkP49JBOmqQfUg=;
        b=Sfkt/N98IbV0lZ6+5kuYDhjUzjN3znJSGoTELPLw7SRBfLTorLlXa6scD3wDtU8ULu
         H7rbEKET8r7RJ7ONTUv7pkMMxHp0XAUtC+5Bj/7w9e51cryGG/oOZwfPr2Utdwk+h3l1
         TgN0Vp4i5dTVplaGHfjsdxZPLnZNhBudnGxTypULRcjoUIUpLtrfASv6LlN+AgADzJTi
         uuToAh/mbTuerMeTAPMkghmEOwt9WNLBC4FP+E/wPZQPvn04O2FL1b+uJ/tOGDhCHidu
         Ts5WEbRRlXLTkEfODfc9NFWaz23L9yYsR3fgkIF1wV3ZvvPHvvE5Gh5TbyJ49PES8OeA
         /vWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710154040; x=1710758840;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OL5M0QWyifHNNdL2G7ppAclszTpwZdkP49JBOmqQfUg=;
        b=vpGecFFma50TNcql+030j3xPIT64VWjWZemOtHdBcP40QV/F+k2DQbzZnfPS7NbIPI
         aRoQKGzuXiIx+KaCTU6YhP84eSCmNLOlwQHH4XOj2D2tf48Kr/s7OGHiWx+byM1GBNP7
         bWnz7JEWMdaLM+jDTiiChUb8qxWMdvjdEK7HAvIYysP0N5FuXQWBG4RwIH7Wmflk8MAs
         8DK149M2RJSv37XXZeglVs/0Ls70qHaxQSJ/Dz8fbcr2+13yb5+LgmHFnCdlO4RgI2A3
         RgU1TLqKBrtXKXhMrfU7/hz+Mm+WlZx54qkEZ4tSaej/4cUho6GmJiSV9h3nrVaL9QcY
         Pq/g==
X-Forwarded-Encrypted: i=1; AJvYcCW2Bnr1xXF5CdW+qlsLDvPLzOm/ZCJbrRO6LhRB2xyVNAmPrh5G3/LzoYQt1sah7f39n1vLkeDbaGij489KzobxSQB+IQ7VNDJLNCB9
X-Gm-Message-State: AOJu0YyyzpYIxXljep4mCB4RVb5Bpuw6WLB1XV0hRbMzvIHM+Nh5BaS2
	zqfYmkrxW9uKKIgmAK1gAE80UyAlMisoXwjmydGdtSRD4mM0gHjA3sV+iUqbFwcLJ3cBlWa7eGX
	6zebyIcFxHZXKKw==
X-Google-Smtp-Source: AGHT+IE1ncu/WTcNjGAnRJ10XRaL7XtUuCqTkHwslE1ImUHNhjgR1ywcm4zJ24S5Uy+4a8JfkWXzPThuHXDDTec=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:aa14:0:b0:dcc:5463:49a8 with SMTP id
 s20-20020a25aa14000000b00dcc546349a8mr1576787ybi.6.1710154040582; Mon, 11 Mar
 2024 03:47:20 -0700 (PDT)
Date: Mon, 11 Mar 2024 10:47:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADHh7mUC/1WNwQ7CIAxAf2XhLAYKLMST/2E8sK5uJNswYIhm2
 b8Lu0yPr+17XVmi6CmxS7OySNknH5YC6tQwHN0yEPd9YQYClJRguZs8Ep9n3qFRSpsWiSwr589
 ID//eU7d74dGnV4ifvZxlndaIFhL0EcmSC95L1yGhVaj1dQhhmOiMYWa1kuEwQfy8z1BNCxJMW WjX/pnbtn0BsZxJJdsAAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2955; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=eFO8v8hNbjIyLu0r8FdBf9oSrloJURleePlt88en+Ow=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBl7uEzbZWmf9BCRypJrSQseEDCZlk4xAlqYenD3
 TaITrik6PKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZe7hMwAKCRAEWL7uWMY5
 Rn+BD/0YENdgVIyHtyKKIzmevaWvjv1Bz4CRTnVr6yyDiHjOQ6jb4fmjM1f3PPhdrXpe35T+TwH
 H5xuahzp3T7osiXs7jAbHzmIUzXei3YH9zY+gxGE/fLxRMSYFzD6FgXyGexkgyIbn1DY8XrmpEl
 4vGAoxJD3Lq/vsB8Y8LhmGBRXtEcUJE6pfB9AySb/YhEA1Kn+mhr7JM5EIpZxml71jA9oDvA5zY
 50xSALmT51CD31w7V/mSxvUkVX0zIdM5l2r9utasvXSA7f9gQbW0+Jtc2GFukHIAOzVKxaQ0NAx
 LA9tLpadDKRhtS20aJusKewF2yF7hFS4qk5CrDVKAu6GtwlEScBhfP0GA3PSWAdCg5/FruKhX02
 pS1XI4SdicSrkAIN289GK/forO9U7CcpAB/pmpaF2+i3D7xyrItmjPMFXMH5zYBREyTgrz72ck+
 vozSQZTVmQOjsU4L1nI6Qj9olliNU1eK3v3oCZ7fOEDkVTOVqhtUiYgYW112DjQL2P3yzRH01cy
 h8dzbbAIvuigCzK29AkXE9/6bUujoFFV5GaZRXlfo0c0pjpl4z0duf/yjun894N4XnjdXI/R++I
 +qiEFJCRPMsGysfiOCcELFNGCqFEUWrutdJpNqBQu2BEpHqNnLydAruOIyJ3Wsfgv8mOHwAsKEe wptsYX5Lzhg7jWg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240311-alice-mm-v3-0-cdf7b3a2049c@google.com>
Subject: [PATCH v3 0/4] Memory management patches needed by Rust Binder
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
 rust/bindings/bindings_helper.h |   3 +
 rust/helpers.c                  |  34 ++++
 rust/kernel/lib.rs              |   2 +
 rust/kernel/page.rs             | 223 +++++++++++++++++++++++
 rust/kernel/types.rs            |  67 +++++++
 rust/kernel/uaccess.rs          | 388 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 745 insertions(+), 40 deletions(-)
---
base-commit: 768409cff6cc89fe1194da880537a09857b6e4db
change-id: 20231128-alice-mm-bc533456cee8

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


