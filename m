Return-Path: <linux-kernel+bounces-36846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D955883A7A4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D661F2649A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01E32BAF2;
	Wed, 24 Jan 2024 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bzn9Q1K3"
Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625A01B801
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095249; cv=none; b=usTWAA7jBGT4htx0ncPS7d1uzXaB8Jo4hVxMgnuNsfbkRR0PHJGQXksXHauIDIDv8sAX9ol/R0i454e+ApER7H8+6xyesTX6wbgJl4mGNmVrizt+bFrTuoFU/WaX+sf7RMyavcv8qcPboMTnlkE/WlWo7/J/fetsv6QzTn1W7AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095249; c=relaxed/simple;
	bh=kWQZyqAOGP/F6TE9A7tinFjaaoaS7LJ3wiTiWkD4Qns=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gm4KnnaQO9w6J4MHAIKdQ/yAVIo+Wg//XBH67HkGBdiqjFvcy4nJeC5kd28kUQ92CCAguAugoP3BNZaBxqIkWWomtXsrIYCaYB+QDvfoqvTxN31mp/f+L2MQOZRF9K26EU0JwxstWj27s1P+HjRzQegeORwq6ljchFVDrXJl7O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bzn9Q1K3; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-50e55a909baso4520886e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706095245; x=1706700045; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q06qj25A3W72nqjSyyLYpEWv6SpYxc3VbfOrmnq1lmU=;
        b=Bzn9Q1K3f2EtWJMt/tOLFdvg3ouqm07N26C7RQ0a7XAJKeRg3yoSMFGO/dq+y6zDjZ
         3pK1AOnzSCZlDlUZICm1qy/05qU3wN2g3pPTFHUcpvwLzSxK0uu2o8M0h+pR+ekPDyME
         7EDMPGK+zgZL2Kdw/GGZ02pC2HWN34A4h/5gTTsdB7WPI9EnDGeGjowMvRutdnFt7DjF
         hKyHr00K4S13zgiQ5dTUaAD8sIH4R1ubqLOz/f7S5CN8j07MD9T3S8FN0lmZDOeWsksz
         XNJwHn8dp8Zv8I2IhPPlz7u0yjRRk5PDY1nTWzAcJ9tOrMiMmNQvYHv8fPC76C8QGbrY
         1j4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706095245; x=1706700045;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q06qj25A3W72nqjSyyLYpEWv6SpYxc3VbfOrmnq1lmU=;
        b=ZUyTmgex2Xw8DYiG8Ad3xuk2AGXpFxYqEjpg2D5tSdRqlE2ozLpJQ1zdnAVI+tL8zr
         2wxhqL+HloH10ensYPZEyHGqLadoE5Yzo6l+mW7i75HU/tQFbcqr2SNKRh/K/bVRpYJ4
         su1byPVV9LZkxR0RvSKPo7GmdRuQiMH4Rson5K90uVbfScElss7esYXWWi3YIpI3DnVt
         hWoPwWporjlWOjlDBYGbC/Fauwv25VKQPItZS7Vv8+qG3ZdEY93W4EwWTRT5e3l7+3lQ
         41oD+gZExX/ISat11LNPVmcTrnnglKFGYMYm6kPW2trYSeONWqdoigyfdUAz/fUGDr1O
         OocQ==
X-Gm-Message-State: AOJu0YxsP4EVQFmL7caWsSJz+fgsZH2pdhVjI0jrJeA6dawwnJ92Usyt
	zhkDTL+yL75YP1N37Oh/OeWkulkEpEtZXbxr7khe1FhxH2+p9Np+ztgPwsU4AgpTViYiX5dnAVX
	hdT0LbimtYp3vlA==
X-Google-Smtp-Source: AGHT+IGtewFNOMp+E7UHcuxspPCn1NHbjZFhNiQV1tQT73RWZ+1gjCDwEDBYZ88PY8GCHXnhdbCRL3PN6v+5eqQ=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:348a:b0:50e:7045:686 with SMTP
 id v10-20020a056512348a00b0050e70450686mr13196lfr.9.1706095245201; Wed, 24
 Jan 2024 03:20:45 -0800 (PST)
Date: Wed, 24 Jan 2024 11:20:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHTysGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQyML3cSczORU3dxc3aRkU2NjE1Oz5NRUCyWg8oKi1LTMCrBR0bG1tQB gnQXBWgAAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2107; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=kWQZyqAOGP/F6TE9A7tinFjaaoaS7LJ3wiTiWkD4Qns=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlsPJ0mZUB7ZjFDvGaQmhyq/UORIo20C2j9zcVt
 YdntYpZ4uKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZbDydAAKCRAEWL7uWMY5
 RgyDD/9O5nCInCi9N8fvfrgrF46WqPERLsFS23XOKO0HXmazeBbiBDasMKtTtRJTYjY835m8gGc
 kGptRXU5jX6dSdSywW/bEhqu4AR2K3dXqtWYSVVxU8lhu8e1V4Q8SVfIbZ5NDHq3tdytEJuey4M
 25pgYgWsXraIyrYswv8YbroJqEdS/ENClVz6Urn/yoHfNErOkn8ygvXEkhxfSFs5LuIkTEjd6Yb
 J70MVi02EhC4Ce9fU97PhL1QgEkxmlIY75li8xzxdO2MQWG9R0P0GhcTrO7zKMZOVsAhcuHUkLN
 mnSUhv2XALVke10eT1bfNkVjS/FrngCJ02mIWRNHoOTCV6wvxla+24DVx8rQqkEyrOXKPRoUjj8
 PG5pnmzcLASw2uwhoU6MHLqCkCMEwSEtkyHkAXGP6EZvDZ94Ru5UBk9gdziaVpCnloAqTfZZd2n
 mmm8nADiG7suUwBJKFfyBw7XBjh1z52aeWYOSTkn1AN/oPAE1gGThS5SrQMe86IMrrBVbWc108i
 g/iF+I/BLuQTsV2NQQIyFI5Ro4adCA6jMthxZx07tyCcy9qk5EOM2pgotgxrMP05c3o0q836Sy+
 G7A3Rh+a+xgLJ4ZcfQ6ejlxWblcrIWQmdNTx0Kj4mNaCuzZuvNZ14nURwD60prjTbSejAbQL4j7 Fpgm1T2lrt1cxWQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
Subject: [PATCH 0/3] Memory management patches needed by Rust Binder
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Kees Cook <keescook@chromium.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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

Especially the second patch with typed accessors needs review. It
contains a Rust analogy for when the C-side skips `check_object_size`,
and I would be very happy to receive feedback about whether I am going
about this in a reasonable way.

Links: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (2):
      rust: add typed accessors for userspace pointers
      rust: add abstraction for `struct page`

Wedson Almeida Filho (1):
      rust: add userspace pointers

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |  68 ++++++++
 rust/kernel/lib.rs              |   2 +
 rust/kernel/page.rs             | 176 ++++++++++++++++++++
 rust/kernel/user_ptr.rs         | 347 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 594 insertions(+)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20231128-alice-mm-bc533456cee8

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


