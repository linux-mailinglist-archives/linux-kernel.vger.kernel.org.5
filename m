Return-Path: <linux-kernel+bounces-120223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0C888D498
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90FC1C2467C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5762B225AE;
	Wed, 27 Mar 2024 02:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhZkIM7s"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533CE21A0B;
	Wed, 27 Mar 2024 02:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506955; cv=none; b=sn5KhMHQ4wqYqBJt/dokxywB3IO4WcJ7H8TAM3OnPCqfaHhyKokA3ieCTFDGLVbjqHhATeMB+gIv7cviDxZJFOs7SqIx4NvYS1THa8yg5/60caSLbgGPKUfB1tu3VB9qj+XqP+b21RZIsxe8hITd+B2B6U02zBABMQQYmj5OK/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506955; c=relaxed/simple;
	bh=NFBI89hBxJyJdmj/crSHiXYAE5GVZ0Qr9b1Phi95F0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R2H/zsGwcPOqeeoXfT9stGIXev3IJ9LN6OJKfwCU5Q1K9ctZa8tnwdoo7qJN5mx0B583n7ibds06ywE+j0jVo9e15tmns0yNzTN5PaiyHRqq5T+6HL6mO26zo6ePRabogfCxusOramx/uSU1ZDxAFSzzFQTk1XczFYM8HgDPx60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhZkIM7s; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6b54a28d0so4187307b3a.2;
        Tue, 26 Mar 2024 19:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711506953; x=1712111753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zwgi78elLsZLyoWMFT63z+tSr2IF4Xl0SkbNI7is8B0=;
        b=mhZkIM7sOXsvZo3o5j+OgiP22YxFXtvt90ZgXrBH3nDatoBhiFXMCHuYw9KK0/HGoS
         iJGgs9nqPatzXyjp1NZtuwWEXbj6Ciegj3n5Rg5FTHwxiGJtU0POf88Ab2ptlubn0i+C
         gkerO0ydJ6v6ciVvkYBkqW5h2hCF4BKhHhTb4W85Me8Gw6DE95iHu6ZthETzIEbe7Qt+
         Jfwb3++KW97M1MExsy0C6/Mh5ismlYn5wjS+kQGMAgpEwutTRgcLQyytPRDIQfzz1Htx
         4jEupeFZ9rDX7FCNZLjZt/o2Deb8A8E6tzpUC+xQ7dk9utL6hmK42amICeYlZ+hmoM9R
         01Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711506953; x=1712111753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zwgi78elLsZLyoWMFT63z+tSr2IF4Xl0SkbNI7is8B0=;
        b=vj0jx0uIggMby7hyPWh4Cxlp1XEU6JHkxgegPOvdsMo7Psp0bhDTsZ8+SkQgB/4pRv
         FnK88H+y5ZRVoPybdYjG08nwgIzuoWOwlUNPPTIFRLPmhj12JPHfzk3rTXrtb2MFGz0A
         bOUlEyy08nXRrYRgR8JbGCY04Roy2wnRNV9aWVcmZ+e4u77oHHQdb0XrM1ax7m5cGPyR
         XQZoUBOmyDi2VEJxrD9HcnFSf3h6cys/l5Sdpc2rTRJM5MdUM+YCOdyKe/J1gse1OPDI
         uSnke8OyTKcpJ+WHd9qJUTIOC8qHpiiN/FROpIr8SNdeluvEgO5orI/DPdlDvhrG/wed
         vK6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMYeP9bk2aY8KM4z96hKfr59AgdiHz0vhjhJCOL5tfg5U6fC67c6FuWRXXC1tIpf4x+enFHsRHBGswI1Om6IHr9b/dL6bFSaZReh4O
X-Gm-Message-State: AOJu0YzXlc4NskKtMDbuMXHwnhrgnNPXyS6vwBK4HSKk8hz0/IZw0iFP
	lijJXpAg1Tni6YLbUMR+m34bQiMVYPKGxNyCPAjdV6uNtb52x9zGnEiIOWJP
X-Google-Smtp-Source: AGHT+IEzXziZSAC2AxHRimyV/t+hft4H78E2N2hO1aHrQSqmJWODH4Kj0Xma9E2d1IuOBCckc34+5A==
X-Received: by 2002:a05:6a20:f03:b0:1a3:638f:4fbe with SMTP id fl3-20020a056a200f0300b001a3638f4fbemr1251552pzb.42.1711506953609;
        Tue, 26 Mar 2024 19:35:53 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id l20-20020a17090a409400b0029b2e5bc1b9sm347441pjg.23.2024.03.26.19.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 19:35:53 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH v2 01/10] rust: kernel: move `allocator` module under `alloc`
Date: Tue, 26 Mar 2024 23:35:22 -0300
Message-Id: <20240327023531.187880-2-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327023531.187880-1-wedsonaf@gmail.com>
References: <20240327023531.187880-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

We will add more to the `alloc` module in subsequent patches (e.g.,
allocation flags and extension traits).

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/alloc.rs                 | 7 +++++++
 rust/kernel/{ => alloc}/allocator.rs | 0
 rust/kernel/lib.rs                   | 4 +---
 3 files changed, 8 insertions(+), 3 deletions(-)
 create mode 100644 rust/kernel/alloc.rs
 rename rust/kernel/{ => alloc}/allocator.rs (100%)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
new file mode 100644
index 000000000000..9aa5077d4a4c
--- /dev/null
+++ b/rust/kernel/alloc.rs
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Extensions to the [`alloc`] crate.
+
+#[cfg(not(test))]
+#[cfg(not(testlib))]
+mod allocator;
diff --git a/rust/kernel/allocator.rs b/rust/kernel/alloc/allocator.rs
similarity index 100%
rename from rust/kernel/allocator.rs
rename to rust/kernel/alloc/allocator.rs
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index be68d5e567b1..51f30e55bd00 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -28,9 +28,7 @@
 // Allow proc-macros to refer to `::kernel` inside the `kernel` crate (this crate).
 extern crate self as kernel;
 
-#[cfg(not(test))]
-#[cfg(not(testlib))]
-mod allocator;
+pub mod alloc;
 mod build_assert;
 pub mod error;
 pub mod init;
-- 
2.34.1


