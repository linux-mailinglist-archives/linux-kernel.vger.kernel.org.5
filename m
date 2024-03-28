Return-Path: <linux-kernel+bounces-122288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D3F88F4C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88AD1C2777E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44F224B2F;
	Thu, 28 Mar 2024 01:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASEzMmIp"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18092263A;
	Thu, 28 Mar 2024 01:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589783; cv=none; b=fbyY6x62Hi4CPucwSRgwXd+h+B9oS1s1aUpkD0zov8nhSmn4g5erT61eAmrWjenIZX9dFGg7zVa/W2ftXBYvBk96a2iM3HeGRRW+254luUHMyBwjIMi08RhRJ/az+cDpYqGS3LkiYllEw0Ns+ZAF3FuLbFb4MHHTU8rnrRA2ylI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589783; c=relaxed/simple;
	bh=NFBI89hBxJyJdmj/crSHiXYAE5GVZ0Qr9b1Phi95F0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DSX6wOEzAmzll4unrRw+SFZxpo4B3TlwH+fwpou4u87x/OX8ceS7M3HAn04lfhE8EJ5jebQlzfQiclZLV26g+gxEdUdUM+Pb7XQm4cZiLpxfQ75UJci+byA3B3uTKncwR3yCEJWyTHQT9TTfA+mjcD44V//b1UvpuOugZWim17o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASEzMmIp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e0511a4383so4182585ad.2;
        Wed, 27 Mar 2024 18:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711589781; x=1712194581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zwgi78elLsZLyoWMFT63z+tSr2IF4Xl0SkbNI7is8B0=;
        b=ASEzMmIpKaAcAn+YqIqgFE7MwN754z34Z770b4avn6AeTPXZH4COycShICOVlgh1WL
         ejFjSIT8JTXJCZgquL/h6BVz4K43KThXH8keZV1kHVKiIuzjdnif4L2rp6qDQ7e6TM0t
         LXbE/dQf8ZXKEQazIFQhL1B0SSuA73hulsH/PgGTmwEpnwVS2f34GlV/G24ILpZNK9HB
         UNekA9iHFgGP12fbtlX/S9g01f9fFNsT9QJX6LzTMmCU3mg4Rvfx3LwSZ/Z4R1gIGf7O
         QrgLpqXEJmdyUrPXy8fF7k+GAtfmmZxFPHFDiPOcNA6BpoP0AnzkeYnMiIOFwvgJl3US
         kfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711589781; x=1712194581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zwgi78elLsZLyoWMFT63z+tSr2IF4Xl0SkbNI7is8B0=;
        b=D47k27x7QfciwRviIVk1ZfXN+p/UbUQrGC2Dp9lmS0V8PtGdbe2+y96XreygdmLwpB
         2UoxMYDGoFSK0kFTw/SpUMQuS/9dM98vnKh0k1NLg0SmsARwCCuex6TamdgyDw4NrD5S
         9GOkQX65/PJQSltlRPKgw8F4bNFWMt6TzYDBgfz0k3zFcPAtSQqjQX3BjibBrOV2KvX1
         HTZQtW5NWvBAU7QxEjMO6B8JpRaG4ol4y3AJeObYLUI/NXkPt7GScCPsvMYgJL04cImq
         MR6V/vl9KVe7akY7yYERMKH94a+sFomv0Nszd9Rb51pHGNT1vVutm2GJ2Ik/DbLaSoQg
         DRxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZtVe6ylZLlhhpUSHPAODz1IUDu2ThL9w+Q14wvO7OOB7o5RL7vfL6PcwkLVHuYZ0MzqhUf74Z/Eh9oL7tbdBhGxlvmYsqtgaLry3X
X-Gm-Message-State: AOJu0Yw6Maw/VYS01auASKOxdtorE3ut46h1i8ker+DzN1YFJTIbMuQd
	cNimbNJZWLjFKjDNZgfDDz3We1/aVKeHcqJCa/eGhDvP3loE4uCYOt0SwZKE
X-Google-Smtp-Source: AGHT+IELJHtjpcitF42G4MyuivD9UOgCQiso8xEHqddo10sOcYt0bZ7TB6nGMHRjkcFBCRsHIgP7Ew==
X-Received: by 2002:a17:902:eb87:b0:1dd:df6a:5e5f with SMTP id q7-20020a170902eb8700b001dddf6a5e5fmr1702789plg.10.1711589780910;
        Wed, 27 Mar 2024 18:36:20 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id p16-20020a170902e75000b001dd7a97a266sm189144plf.282.2024.03.27.18.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 18:36:20 -0700 (PDT)
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
Subject: [PATCH v3 01/10] rust: kernel: move `allocator` module under `alloc`
Date: Wed, 27 Mar 2024 22:35:54 -0300
Message-Id: <20240328013603.206764-2-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328013603.206764-1-wedsonaf@gmail.com>
References: <20240328013603.206764-1-wedsonaf@gmail.com>
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


