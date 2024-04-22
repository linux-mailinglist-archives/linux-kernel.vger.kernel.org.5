Return-Path: <linux-kernel+bounces-153060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D068AC87B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7E1BB231DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F80137C31;
	Mon, 22 Apr 2024 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/vWRz1/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C353F56B62;
	Mon, 22 Apr 2024 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776893; cv=none; b=St8aI6tvmqBgmHKq66hFH2PzL7QPjFHDxWsiV6WrGjdV+U6PjJlrZmnqvs9Ht8gkHn0zKL0ya7dHKJ4wTkmQ5b9eprnN0ZyWEzJJ3uI9aR4ta7V8gC4lFtGRHg+4Yod61RQbZ7zsfazlMaXiEKUf3rbbNNOwyVsGCUbNBIdLYJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776893; c=relaxed/simple;
	bh=nLmuYu0vjDSSPfnTZYanrd2ZE6KNz5H4Gy9hK4smJew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tX9PzLz9UubyHdIL3m8/yrYpOve8eb3Y7yKq1AvPw1hvygq2wup7zZDdxPOelyTlp37D/31mWXvT3ueMnliB0zXJxEHDGbrx9dJLIKorkJkYzhhNPKPgvpUdJqVdcRZabMKKU8iudP1YfunDWaB/8phYpTXCiBkcjdQD/m/Zgyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/vWRz1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E509CC2BD11;
	Mon, 22 Apr 2024 09:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713776893;
	bh=nLmuYu0vjDSSPfnTZYanrd2ZE6KNz5H4Gy9hK4smJew=;
	h=From:To:Cc:Subject:Date:From;
	b=f/vWRz1/H6RXhOhaIZGUNLX/n8qb9XAR7xOna0+LcmYCPgZjinz83E8Vtio5GaKhn
	 Nm4hZTOi24CKzp40peY24bICe/TcrJ111eJwPohJXcliwcsp69ocFNwcQMxNk53OKK
	 0bnVjrf9NpyB9yTm1yoyfKdPy5r8a40uYvCBnYenIzWd7WQnJNVSn77wguPWgsG98C
	 zJPz9ZeRAcnrwVkE9obdd4a/RixaIcBNmx/zOcnPNlu8jAcCPc7nkKwbq4VhrUJcyU
	 84/7GOh0UOtsYz+4ASehvMM2Jat4Ac5CD1HC6kNCvo+2er+8ZbKkDR/ahRTzRc2yWz
	 jMHQAxvBZlZpQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kbuild@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	stable@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>
Subject: [PATCH] kbuild: rust: force `alloc` extern to allow "empty" Rust files
Date: Mon, 22 Apr 2024 11:06:44 +0200
Message-ID: <20240422090644.525520-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If one attempts to build an essentially empty file somewhere in the
kernel tree, it leads to a build error because the compiler does not
recognize the `new_uninit` unstable feature:

    error[E0635]: unknown feature `new_uninit`
     --> <crate attribute>:1:9
      |
    1 | feature(new_uninit)
      |         ^^^^^^^^^^

The reason is that we pass `-Zcrate-attr='feature(new_uninit)'` (together
with `-Zallow-features=new_uninit`) to let non-`rust/` code use that
unstable feature.

However, the compiler only recognizes the feature if the `alloc` crate
is resolved (the feature is an `alloc` one). `--extern alloc`, which we
pass, is not enough to resolve the crate.

Introducing a reference like `use alloc;` or `extern crate alloc;`
solves the issue, thus this is not seen in normal files. For instance,
`use`ing the `kernel` prelude introduces such a reference, since `alloc`
is used inside.

While normal use of the build system is not impacted by this, it can still
be fairly confusing for kernel developers [1], thus use the unstable
`force` option of `--extern` [2] (added in Rust 1.71 [3]) to force the
compiler to resolve `alloc`.

This new unstable feature is only needed meanwhile we use the other
unstable feature, since then we will not need `-Zcrate-attr`.

Cc: stable@vger.kernel.org # v6.6+
Reported-by: Daniel Almeida <daniel.almeida@collabora.com>
Reported-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/x/near/424096982 [1]
Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
Link: https://github.com/rust-lang/rust/issues/111302 [2]
Link: https://github.com/rust-lang/rust/pull/109421 [3]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index baf86c0880b6..533a7799fdfe 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -273,7 +273,7 @@ rust_common_cmd = \
 	-Zallow-features=$(rust_allowed_features) \
 	-Zcrate-attr=no_std \
 	-Zcrate-attr='feature($(rust_allowed_features))' \
-	--extern alloc --extern kernel \
+	-Zunstable-options --extern force:alloc --extern kernel \
 	--crate-type rlib -L $(objtree)/rust/ \
 	--crate-name $(basename $(notdir $@)) \
 	--sysroot=/dev/null \

base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.44.0


