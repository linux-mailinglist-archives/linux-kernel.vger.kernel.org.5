Return-Path: <linux-kernel+bounces-149762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091E88A9586
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FA61F21CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4A815AD9B;
	Thu, 18 Apr 2024 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bemWftTu"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5240215991E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430774; cv=none; b=F1kvTPf0sWsgf9vAKwrIfw7eBs2kKvfJ+1N+RnSpaWFETGGTnBX6FTCMbfw5oaQYYn6ynh8jorX0XbsePqcq3fMP9gbqW4ezQU7HTjmnJHFiOqNiTWqvkm+7SU5H8+JW6AnmOXiyr9K0CyxApu/Nq1NXzxZL8ZNTt4WEpGnWAnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430774; c=relaxed/simple;
	bh=EKOb+HQOdPSDwGBxYIVC+gfTRfSx/aJkWNgqulepRkI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WG8QdlIhLjCXegCJFDUdARWqlCG2187hCpAfu805O9XdUtj3eHkjYRt5CNzW0Bx+4SriIaFJMCvKxJcHI2GJIDNOX+kQQ2qt+tfMLYoO+/Z/zHk+v4jTZvdIel13SC2pEYGM+otZPj4cIMOZjAnse+wkZA1O6gSVXnxg2r6wko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bemWftTu; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2d87d146022so5395661fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713430770; x=1714035570; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tjcuz1zEduZDelE435DU7CODjxYuJ/nMkJoF3xPyrOQ=;
        b=bemWftTuIBV+TrcMcKdOA0I2VCjpXdZfFu8ILwMZYPOM3kyJxIPFjDWopz4RRKf28T
         HgmHcQAgVJ3CYX6H8C4ZHkjkfXGDwunUgz4XKUSB7en0TGGaryKE5X6nGSfULBtvubnO
         ZomyC7dA37Rn4BL9q8iKFyXh1U/9C0IyMa/oiZKk5nSyom/ejBZkbMCl1qANG4qnOV67
         rZGb0yZzMsWys+nN2BV3tGqS51OhMj22It8i8D1aH64zE4VAOgz3DJ/PxTk0ZJ5+zaRC
         lm89KFJQFzdILt4AWGhZPHrsqtLC/IHZwb2NdIobmjOkIGPWhtXYtsT6opsBNsL2c98o
         ctsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713430770; x=1714035570;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjcuz1zEduZDelE435DU7CODjxYuJ/nMkJoF3xPyrOQ=;
        b=GycY7ZoTaBrPSD36T5RcVsHKUKbqLBIsafbW4WI3P4SAUIIxWHSFsPVDZJr8BGdHom
         T+rgI8yfnTk/ZXD0kCsF7z7qKXBBiuu25SQDkLagnAVg39aLjT8/CXozAY41vaFeDh3t
         3z55VZwL6AryTQXiFZLVNiQlswIgm6kMrvkzlTWVdDvKPU/IOu8MDLVG3toIMfu45SNU
         4fDUxT6I2uzCNV7skRZmljmCFbZ8V2gLDq5cLTUuAGZ95Lvy9ZLuN5TaiSFd9EZ1Q0fi
         AInUjlKoBiYXvQnJSRquuGryjOtz+a8Xzei+Pl8D6KeXF8coY42U2xCq6m//z1kkvEKG
         jYuA==
X-Forwarded-Encrypted: i=1; AJvYcCVajauZddXibpTzAyLNs+6fKYXYrTqt5/V1cBwhFoMppIR69ZDbcfLno3E7djgxOmBg+PgXGqVv27Hf+CjV2jgCK6yagLMHtHHVUMT/
X-Gm-Message-State: AOJu0YxWeMS6lhY9CzHhIoiCLUBFQYdd3LJ8GArJ6QMfjmkTizkt1q4w
	lqjmf4CzcmecW5G6Iev3TPIkgzTEPnlXFHdqbhHpK8Grw4J4Fq4+cQ+E/oQtlLq5XToLq7AO/O5
	74ijcgYfC2+N3iA==
X-Google-Smtp-Source: AGHT+IFD4zFEKLzwwqRcxHO2U42hED49hamO66nHcnOSUg2YEF8UQokeTd73CF3AhLyw0IFIrk8AVfurp0BM69Q=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:a801:0:b0:2dc:14d2:20f7 with SMTP id
 l1-20020a2ea801000000b002dc14d220f7mr203ljq.9.1713430770579; Thu, 18 Apr 2024
 01:59:30 -0700 (PDT)
Date: Thu, 18 Apr 2024 08:59:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOTgIGYC/2XOwW7DIAwG4FepOI8JjMnoTnuPaQfimBSpKVUyo
 U1V3n1OL2GKOP2G7zcPtfCceVHvp4eaueYll5uE7uWk6BJvI+s8SFZgwFkLQcdrJtbTpHvyzqH
 viDkoeX6fOeWfZ9Xnl+RLXr7L/PtsrnabbiVoLOBeUq02erCxJ6bgCPFjLGW88iuVSW0tFXYJp
 llfYZMBLHi5wNgdpNulfL2RTiQN6a13UeSZDhJ3KaeRKBLPMSAgUDJwkL6R1jfSi+yS94xD4OT tP7mu6x9zHjE7iQEAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5147; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=EKOb+HQOdPSDwGBxYIVC+gfTRfSx/aJkWNgqulepRkI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmIODpvn8YfthhJyGIeqFlR8yHa3C9Ul13gEsd0
 HVls3uAQBOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZiDg6QAKCRAEWL7uWMY5
 RkZ/D/96tk+NcZHWL5a1hchXVUpuXjVL0AymcssJSlYyOWYe2xnTOVbpQwg4Oo5cANiWPFyOoya
 hNONBYZCjpxUbQRkVi+yYKhVjHgILqf+b2vuR2xRKD+b4OPCIMO9GMvn+HAdZOEBqbxTN4S9vR3
 PMVu1Ma8aAYwHNIcvrRc84iTW+q9C6Ez8UfwGfN8Wro1WFguJmsInBfPzy0DDDAJbK3kmafpwqg
 8VNMHnr111Psg88SZVCQOjehLlTCLWEv9xO89rW4vMZ0g4alszYGUF06g2haQdCuEhanwo8bQ06
 6KWwpx948WfAwIQCh6A4yBlKJUfpVNzdfODsahr0OohgelmIwdGPVaToBY4xSybBr8niN4Kn0Ak
 OBChHRyJEKlDWE5U6slhYZ9WDNllPAurIDjB9Aegml7F3OYc21dSbUs0CGxUglTp6WKN9pjBSd/
 45IjwxJpi3fxfA5+bYFgIT2u5CmztdV5tqMj5g9aRVSk5ildy9fY8yYw+Jp75Yvpq4gbp96sZZY
 G14q8FZHYM2LN6lVC8Xem1i4SfGgLICM3FCQInMdQJUK7Q1JkxJ7H4sbrYYW+2xiQJvAm6LCbGo
 TY26fZqZGx3HOUD8p8CYZxtMJjNqZjWshi3MP5iwgUNtHDgkk099IVwMrCsAz1bEidgr2VOWK1w xmOk2hZb3SGJ73Q==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
Subject: [PATCH v6 0/4] Memory management patches needed by Rust Binder
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
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Christian Brauner <brauner@kernel.org>
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
Changes in v6:
- Base on top of Wedson's Allocation APIs patchset.
  - Do not define my own gfp flags, instead use the ones that are now
    available in `kernel::alloc`.
  - Add gfp flags to `read_all` methods instead of always using
    GFP_KERNEL.
  - The __GFP_HIGHMEM flag is not provided by the Allocation APIs
    patchset, and I do not add it here. I will send a separate patchset
    for adding it.
- Use usize instead of void pointer for userspace address.
- Add _raw suffix to `fill_zero` and `copy_from_user_slice`.
- Do not allow interior mutability in AsBytes/FromBytes.
- Doc changes:
  - Mention that validity of user slices is checked at read/write time,
    not in the constructor of the user slice.
  - Mention that methods can also return EFAULT if a bounds check fails.
  - Mention that methods may have partially copied data even if they
    return EFAULT.
  - Add link from `read_raw` to `read_slice`.
  - Move comment about initialized memory on `read_raw` to
    `# Guarantees` section.
  - Add examples for `Page::alloc_page`.
  - A previous version renamed UserSlicePtr to UserSlice but forgot to
    update that in the commit message. Commit message fixed in this
    version.
- Add Reviewed-by tags submitted on v5.
- Link to v5: https://lore.kernel.org/rust-for-linux/20240415-alice-mm-v5-0-6f55e4d8ef51@google.com/

Changes in v5:
- Fix casts in declarations of PAGE_* constants.
- Fix formatting of PAGE_MASK.
- Reformat comments at 100 line length.
- Minor fixes to safety comments of `read_raw` and `write_slice`.
- Link to v4: https://lore.kernel.org/rust-for-linux/20240404-alice-mm-v4-0-49a84242cf02@google.com/

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
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |  34 ++++
 rust/kernel/alloc.rs            |   7 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/page.rs             | 250 ++++++++++++++++++++++++++
 rust/kernel/types.rs            |  64 +++++++
 rust/kernel/uaccess.rs          | 388 ++++++++++++++++++++++++++++++++++++++++
 9 files changed, 774 insertions(+), 40 deletions(-)
---
base-commit: 2c1092853f163762ef0aabc551a630ef233e1be3
change-id: 20231128-alice-mm-bc533456cee8

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


