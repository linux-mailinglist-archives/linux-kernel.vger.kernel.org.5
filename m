Return-Path: <linux-kernel+bounces-43837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AA7841964
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18C06B226B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167FE1E49D;
	Tue, 30 Jan 2024 02:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ue6PF6IV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655F8364BF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706582333; cv=none; b=h3JA2cYv7HtSZnuTg+4gqb2njLvPdTEY3V2WmYRjwcgEhJ0RUzPJteCaGY0ljf2UX8swjFfbj7rqizBeeLYKasvgRnFq4rYwQj+XV1vM00phov5pQXQ3B83WBC5ujrptShZA1k2JfVq2L79PQQ3RHEjVl9M88Uj7gMcImlWE9xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706582333; c=relaxed/simple;
	bh=8NFkxLjfDsMYKBVX/2CVn4EMmha53R183167AkLrZ2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=imzYZWsSmhofJ79UyZ1+R3PsMsVTnGBQ2Kj/qXYVBHYUCdfUwUmQLRhZahxAnViEK6aVUJ0b+KX+xVbl29qmGKlbotn7pvM6rXFQfcNm6CJRyLvz5qynWgjDg8UALNBKHxqq2T/YuvPLw8rvvNeJU1BEuj7qgxJCYNXY9VYbkeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ue6PF6IV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706582330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Da1Kai79LDMmtf1ru1K3D52dA9E7Gwnh/kl6V6/IJ3k=;
	b=Ue6PF6IVxrl+3qIItXpXndttGjjkoM4SK65WrrfyVI55P2G+0fvxEwQOOTpuan40Fg8KbZ
	GasI8PGsTirEYytgJOwm3rcwcGGS0Wx1KRSCX60d/9F5Sj7soWC4x6soV/Iz7zawa8sGrj
	qLHR7wsQYY9WG8PqwqoxtMxcm7Jwkl4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-Fcs0CYXaPW2-ini3LQrffw-1; Mon, 29 Jan 2024 21:38:48 -0500
X-MC-Unique: Fcs0CYXaPW2-ini3LQrffw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a357c92f241so103593566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706582327; x=1707187127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Da1Kai79LDMmtf1ru1K3D52dA9E7Gwnh/kl6V6/IJ3k=;
        b=hdxU8KRuuHZFS6TEzzCjZYEXbVKMTtivy1FX7zYt105xS46wgzXxBADvWfEGLObMy5
         z//TvLFTbfDRVk7LXQegl+On1c+yuxWiT5ge3dJcQMqkrkjcIll1je3hDUnpS1iPOQZM
         ZYW7XJYIZHU9OOzoAmEaxfrzG6P8pFQBrrsnyRwTy12IsjnovLH+aZw1Df/TN2IqKsgF
         k00Rd7koWKinpVpZij6FCtAvuIYCdK3DgZNVMfOdb3rsn0M0uIlyntvuq4+YjmdgeUiw
         QNlk8iL0wanxM2vuwkc6oYamgr8k0sLPRiQN4ld1QHdjaWk0mv6rD35M97wymb6rckHi
         dUug==
X-Gm-Message-State: AOJu0YxesDIK50scs04j7NyZf0F2xpw/Ob7gWJmbHbenKL04doU021H+
	jGnXRN9F6KXQztdiwYPX9l7UWTpxRa4nyGGy3pPuz5kRhZQudPwbDYAjPq4Vt3I8ZSIi36SsbUQ
	JLiTBYAkBjH8oeoR1leMFcnahmTgW1Sgsgo4rYMs6pfSWRlcf172gqZgOv/2u/w==
X-Received: by 2002:a17:906:81d5:b0:a31:49a1:4d5e with SMTP id e21-20020a17090681d500b00a3149a14d5emr5643881ejx.24.1706582327375;
        Mon, 29 Jan 2024 18:38:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV3Puy+toKVntNBLPCBVKA8P9s0vfikb8UxH9LYr4Idft4CPH4iGMWXhgCD6yu6FxA1NsNvA==
X-Received: by 2002:a17:906:81d5:b0:a31:49a1:4d5e with SMTP id e21-20020a17090681d500b00a3149a14d5emr5643876ejx.24.1706582327099;
        Mon, 29 Jan 2024 18:38:47 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id fj18-20020a1709069c9200b00a3496fa1f7fsm4591092ejc.91.2024.01.29.18.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 18:38:46 -0800 (PST)
From: Danilo Krummrich <dakr@redhat.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH v2] rust: str: add {make,to}_{upper,lower}case() to CString
Date: Tue, 30 Jan 2024 03:35:39 +0100
Message-ID: <20240130023843.11512-1-dakr@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functions to convert a CString to upper- / lowercase, either
in-place or by creating a copy of the original CString.

Naming followes the one from the Rust stdlib, where functions starting
with 'to' create a copy and functions starting with 'make' perform an
in-place conversion.

This is required by the Nova project (GSP only Rust successor of
Nouveau) to convert stringified enum values (representing different GPU
chipsets) to strings in order to generate the corresponding firmware
paths. See also [1].

[1] https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/String.20manipulation.20in.20kernel.20Rust

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
Changes in V2:
  - expand commit message mentioning the use case
  - expand function doc comments to match the ones from Rust's stdlib
  - rename to_* to make_* and add the actual to_* implementations
---
 rust/kernel/str.rs | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 7d848b83add4..758bb70d98e9 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -581,6 +581,66 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
         // exist in the buffer.
         Ok(Self { buf })
     }
+
+    /// Converts this CString to its ASCII lower case equivalent in-place.
+    ///
+    /// ASCII letters 'A' to 'Z' are mapped to 'a' to 'z',
+    /// but non-ASCII letters are unchanged.
+    ///
+    /// To return a new lowercased value without modifying the existing one, use
+    /// [`to_ascii_lowercase()`].
+    ///
+    /// [`to_ascii_lowercase()`]: #method.to_ascii_lowercase
+    pub fn make_ascii_lowercase(&mut self) {
+        self.buf.make_ascii_lowercase();
+    }
+
+    /// Converts this CString to its ASCII upper case equivalent in-place.
+    ///
+    /// ASCII letters 'a' to 'z' are mapped to 'A' to 'Z',
+    /// but non-ASCII letters are unchanged.
+    ///
+    /// To return a new uppercased value without modifying the existing one, use
+    /// [`to_ascii_uppercase()`].
+    ///
+    /// [`to_ascii_uppercase()`]: #method.to_ascii_uppercase
+    pub fn make_ascii_uppercase(&mut self) {
+        self.buf.make_ascii_uppercase();
+    }
+
+    /// Returns a copy of this CString where each character is mapped to its
+    /// ASCII lower case equivalent.
+    ///
+    /// ASCII letters 'A' to 'Z' are mapped to 'a' to 'z',
+    /// but non-ASCII letters are unchanged.
+    ///
+    /// To lowercase the value in-place, use [`make_ascii_lowercase`].
+    ///
+    /// [`make_ascii_lowercase`]: str::make_ascii_lowercase
+    pub fn to_ascii_lowercase(&self) -> Result<CString, AllocError> {
+        let mut s = (*self).to_cstring()?;
+
+        s.make_ascii_lowercase();
+
+        return Ok(s);
+    }
+
+    /// Returns a copy of this CString where each character is mapped to its
+    /// ASCII upper case equivalent.
+    ///
+    /// ASCII letters 'a' to 'z' are mapped to 'A' to 'Z',
+    /// but non-ASCII letters are unchanged.
+    ///
+    /// To uppercase the value in-place, use [`make_ascii_uppercase`].
+    ///
+    /// [`make_ascii_uppercase`]: str::make_ascii_uppercase
+    pub fn to_ascii_uppercase(&self) -> Result<CString, AllocError> {
+        let mut s = (*self).to_cstring()?;
+
+        s.make_ascii_uppercase();
+
+        return Ok(s);
+    }
 }
 
 impl Deref for CString {

base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
-- 
2.43.0


