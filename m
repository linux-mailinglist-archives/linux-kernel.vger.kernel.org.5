Return-Path: <linux-kernel+bounces-78739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F296886181A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66CBC1F23642
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9679E12880E;
	Fri, 23 Feb 2024 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7SxLlJz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA55882D74
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706256; cv=none; b=VKgQQVFXCuMu3RqGQsCE2+PueDTOXTbDLLAa4DkxJHPdPq4mpQL7mLqV7v0A5RU6O7A8dDpEy7JuZVRRFrfy8JGkM8vIbgEr7WSPCwCdRJTxvUl9RCKd5Mhytd8xuOCVX1N+/bZ0PruqFt8RpWteXIed6X9PvMdlGA6gKFqRUw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706256; c=relaxed/simple;
	bh=6X2pjKgoujjJyMfMa5m9DAj7vZS/YUa15KPy8QFZibs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IaC4gSecDbtPKqXizIBSR3rdBuig4Ebbe0Fb+LpaN18ftZNCTgVmwpKZ5MxM9b0VtHi+ILDG/sIpYtmPUfVfW1Z4GqaM7cj2uOOIIpxsFz0T2X8oISM90IMynn9XTlpajVXFX3uBt9y8JrVdlDQQ8QRcgFeHGpFhxk9KwUeBp8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7SxLlJz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708706253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jJz4ul1e27rNZHJvoOXiYFCd5EfCVL6UYrKBkI3v9BM=;
	b=X7SxLlJzGUD/+SSQWOEs4MLnWeU77H8E5MFlKSDi+mbD1NvvSC+otK8foiYgLzShz6TspK
	HpQwULA6scnepzViSUtNZzOmgzpUGoCBVSfa7U3Qt46goRW/C6ptiOvGOK4GFBpj84uyFr
	2X11FGF4nEVK/OKCphIki353vdMjxVE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-_u52cqdbN7yATReSICW_qw-1; Fri, 23 Feb 2024 11:37:32 -0500
X-MC-Unique: _u52cqdbN7yATReSICW_qw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-512e13a6a70so911979e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:37:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708706251; x=1709311051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJz4ul1e27rNZHJvoOXiYFCd5EfCVL6UYrKBkI3v9BM=;
        b=R/byqLPoJ+P/e+8sm6dogKtYmQ7+mfHdrbgVht/I/DcBkE2qg/6ynoLv/H13X3jM/T
         ATtM2gt1Uc6M8p2QWXs3QdXZClXhmOwcLaUhqRgO6A3+wQkErXlYHbSujpPivpyGBSlS
         7dMGy4UxErKT9v212esry5vi+L69saNkP9IErihihB5+jFI31BPOAMNBCY8vJm3jgZed
         TOBykDAqX2zlZmobMA5lB1rf7DBWMIF0jiejbDDmT51zmJt/j+AK4jjB9rUYDRkYQB5f
         8hXrKdNFvaZKqzpt2ligumiq7fed8zUUbv+1Ai8kfewCv6yck1mIPVpxBv8pCFjJm2GU
         Sy9A==
X-Forwarded-Encrypted: i=1; AJvYcCXsQcesGoeD+j7BUE+XME1zDA0FcbmYqKANn4UwfDUEOXm6rq0qs9GNBR5cMchwlaDcCk9/Qe3ndU6fX4KAtmpldzToDAjuge0SapYl
X-Gm-Message-State: AOJu0YzOtzhEzbZETF7qpDHeQw4c2V4Y2+LNGRseggrGfw/qTnCBpqwK
	oNteVcYSIFYRIkJbf6fwQS8ke2s3UJrTqZ2U/jW6a69cRl9j2rXGXMGb8OmnzRTywZy/NlvcTYG
	SuW4/u0C1QGt2mqvkTar9DyeHGPpmEMnqIj7cxRN90K8uheHkJ+hJD5xaAdBJVQ==
X-Received: by 2002:a19:7404:0:b0:512:d6b4:9622 with SMTP id v4-20020a197404000000b00512d6b49622mr133283lfe.69.1708706251108;
        Fri, 23 Feb 2024 08:37:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGI4zo7vR/7Cp58uza9NxBMjotbsgXxD9CrsZsnj8dw90uhjbw+HluXAvqIgWumYG4FZI7fQQ==
X-Received: by 2002:a19:7404:0:b0:512:d6b4:9622 with SMTP id v4-20020a197404000000b00512d6b49622mr133270lfe.69.1708706250687;
        Fri, 23 Feb 2024 08:37:30 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ev24-20020a056402541800b0056163b46393sm6542407edb.64.2024.02.23.08.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 08:37:30 -0800 (PST)
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
Subject: [PATCH v5] rust: str: add {make,to}_{upper,lower}case() to CString
Date: Fri, 23 Feb 2024 17:37:09 +0100
Message-ID: <20240223163726.12397-1-dakr@redhat.com>
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

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
Changes in V5:
  - remove unneeded return statements
  - use Vec::as_mut_slice() instead of a dereference
Changes in V4:
  - move to_ascii_{lower,upper}case() to CStr
  - add a few comments suggested by Alice
Changes in V3:
  - add an `impl DerefMut for CString`, such that these functions can be defined
    for `CStr` as `&mut self` and still be called on a `CString`
Changes in V2:
  - expand commit message mentioning the use case
  - expand function doc comments to match the ones from Rust's stdlib
  - rename to_* to make_* and add the actual to_* implementations
---
 rust/kernel/str.rs | 87 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 7d848b83add4..c1c8ccc80c52 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -5,7 +5,7 @@
 use alloc::alloc::AllocError;
 use alloc::vec::Vec;
 use core::fmt::{self, Write};
-use core::ops::{self, Deref, Index};
+use core::ops::{self, Deref, DerefMut, Index};
 
 use crate::{
     bindings,
@@ -143,6 +143,19 @@ pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError
         unsafe { core::mem::transmute(bytes) }
     }
 
+    /// Creates a mutable [`CStr`] from a `[u8]` without performing any
+    /// additional checks.
+    ///
+    /// # Safety
+    ///
+    /// `bytes` *must* end with a `NUL` byte, and should only have a single
+    /// `NUL` byte (or the string will be truncated).
+    #[inline]
+    pub unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
+        // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
+        unsafe { &mut *(bytes as *mut [u8] as *mut CStr) }
+    }
+
     /// Returns a C pointer to the string.
     #[inline]
     pub const fn as_char_ptr(&self) -> *const core::ffi::c_char {
@@ -206,6 +219,70 @@ pub unsafe fn as_str_unchecked(&self) -> &str {
     pub fn to_cstring(&self) -> Result<CString, AllocError> {
         CString::try_from(self)
     }
+
+    /// Converts this [`CStr`] to its ASCII lower case equivalent in-place.
+    ///
+    /// ASCII letters 'A' to 'Z' are mapped to 'a' to 'z',
+    /// but non-ASCII letters are unchanged.
+    ///
+    /// To return a new lowercased value without modifying the existing one, use
+    /// [`to_ascii_lowercase()`].
+    ///
+    /// [`to_ascii_lowercase()`]: #method.to_ascii_lowercase
+    pub fn make_ascii_lowercase(&mut self) {
+        // INVARIANT: This doesn't introduce or remove NUL bytes in the C
+        // string.
+        self.0.make_ascii_lowercase();
+    }
+
+    /// Converts this [`CStr`] to its ASCII upper case equivalent in-place.
+    ///
+    /// ASCII letters 'a' to 'z' are mapped to 'A' to 'Z',
+    /// but non-ASCII letters are unchanged.
+    ///
+    /// To return a new uppercased value without modifying the existing one, use
+    /// [`to_ascii_uppercase()`].
+    ///
+    /// [`to_ascii_uppercase()`]: #method.to_ascii_uppercase
+    pub fn make_ascii_uppercase(&mut self) {
+        // INVARIANT: This doesn't introduce or remove NUL bytes in the C
+        // string.
+        self.0.make_ascii_uppercase();
+    }
+
+    /// Returns a copy of this [`CString`] where each character is mapped to its
+    /// ASCII lower case equivalent.
+    ///
+    /// ASCII letters 'A' to 'Z' are mapped to 'a' to 'z',
+    /// but non-ASCII letters are unchanged.
+    ///
+    /// To lowercase the value in-place, use [`make_ascii_lowercase`].
+    ///
+    /// [`make_ascii_lowercase`]: str::make_ascii_lowercase
+    pub fn to_ascii_lowercase(&self) -> Result<CString, AllocError> {
+        let mut s = self.to_cstring()?;
+
+        s.make_ascii_lowercase();
+
+        Ok(s)
+    }
+
+    /// Returns a copy of this [`CString`] where each character is mapped to its
+    /// ASCII upper case equivalent.
+    ///
+    /// ASCII letters 'a' to 'z' are mapped to 'A' to 'Z',
+    /// but non-ASCII letters are unchanged.
+    ///
+    /// To uppercase the value in-place, use [`make_ascii_uppercase`].
+    ///
+    /// [`make_ascii_uppercase`]: str::make_ascii_uppercase
+    pub fn to_ascii_uppercase(&self) -> Result<CString, AllocError> {
+        let mut s = self.to_cstring()?;
+
+        s.make_ascii_uppercase();
+
+        Ok(s)
+    }
 }
 
 impl fmt::Display for CStr {
@@ -593,6 +670,14 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
+impl DerefMut for CString {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: A `CString` is always NUL-terminated and contains no other
+        // NUL bytes.
+        unsafe { CStr::from_bytes_with_nul_unchecked_mut(self.buf.as_mut_slice()) }
+    }
+}
+
 impl<'a> TryFrom<&'a CStr> for CString {
     type Error = AllocError;
 

base-commit: 39133352cbed6626956d38ed72012f49b0421e7b
-- 
2.43.0


