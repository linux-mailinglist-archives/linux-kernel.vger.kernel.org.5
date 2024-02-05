Return-Path: <linux-kernel+bounces-52280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C931849639
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9605C1F21843
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA91125B7;
	Mon,  5 Feb 2024 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ok6j71GH"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84E7125A1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124729; cv=none; b=C6fWd2U2zodQVdvRB8+DzA0/F/OmXd9UGXaITgVMf/4J9yqfXGcdUcOXhg5O38SM/5ZWbdZmbIcPFIqXs3xlQNU7p8hgSCQ0bYMiSeb8qWLXSOih0fDbEU6+fI2p23X4LwxGGD4e7H12iNwVSMONkZFVr3SvicqOsMhLrmsy12U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124729; c=relaxed/simple;
	bh=8XZJ/IgL1JMzY5lgcFPKVTKdQYsXG/HJaPx+Ik6gB94=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eK68i/+i49J9VmBCTIrLGpirusln4R1ff0VfJPSZUKKIgj8iJ6cLFIP0GxD1t1GWCQD3vJbuHi+oBSIVXAUQCG0AuviR3SKdSqfhMRk1Pk/Yq+33/gtpa7mmcl1UQ/6qIH8cNcimoTRjoiWJF1SI7zg8Yv6rWWlS7wOwtoe7YCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ok6j71GH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc7165d7ca3so612634276.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707124726; x=1707729526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Gxk2ajCeRlR024TKzSLzvly8WJN2T7k2cWPUi6bXG0=;
        b=ok6j71GHOBJYAAjH1mmtEmSRXRP5Eqdbvk1SDKKjq+5+TDCHhCoVLfUqAe0+pvH/+3
         MKOqQwJHgqrjM4ZW+gLKhlczv/Oa5LieCkBIraAPtLkn122YzL7p97Fh0jCjoLNeYlZB
         rpMyt7wDiHYiBPaZhZ08F4YUoB0K+MuBRRdlQjD2xUckwCI1V2uoBPrcwsxhr5EDQkT5
         AgBfzc6k8PVVij1fkWbIJVk6eaESAEwapZT77fwIwDDaxeBjZOzhn+6qZq4j6/SPqTBM
         hjuWaFdMpAor0egUgqrkdzJFQ9LM9myHuUzXGm/fxC4scmUhpBCv4bI5dFXt3W8KasLV
         XFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707124726; x=1707729526;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Gxk2ajCeRlR024TKzSLzvly8WJN2T7k2cWPUi6bXG0=;
        b=LMDS+dslb8LauyC8tz8xSwHvMu9oXJWTk/uhozyPbK3jqabzQqwVD1KFLHneXDuQ63
         j62dhb7g5CTeeAQqGwckwKg7Rn2XJtfPsyQqEgVpFnfS99kuQQSYARSAbf/Ic8fxYUrT
         YpK6POr7Hu8ZXexGw8gtYY7wt9cSw4iwXyonv1P5c1gga92d3zdA/0ttAUHsEA9t0aqe
         QTeZsYex9VgU6BaauScOU1D+EDj+VxGoFrcLQ6wjcK7OCGuA4wkG8hTsKoXYs3dpuMBP
         NZwdmut9yeQY6040/5O6DdmVZWtIYVzRgm0GYKlmhRVq4MUA2S3Ibo3WWJLcrZarvB74
         1tyQ==
X-Gm-Message-State: AOJu0Ywa7SwNCS/cdXGH94Etjl9yfhlBjs1g6eunFf5716bro3BjPPtz
	CsNzQje/OsFUH6Rn/IIlFYG0t7GZqhdQ3TzO6rg/PY+2aIfX4d0WtpEYWBfTVOa8T4/RXiG0CNU
	2ZtGaRH/4Ht46rQ==
X-Google-Smtp-Source: AGHT+IG3BuUoJv4bjoNYEp0iMOpsszjB7c7QBaEDVUYixjVCksy3fmJ26gQCHRyt80iLODTHu7dmgWlIlut3BGQ=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:cc9:b0:dc2:57c9:b44d with SMTP
 id cq9-20020a0569020cc900b00dc257c9b44dmr534896ybb.8.1707124726693; Mon, 05
 Feb 2024 01:18:46 -0800 (PST)
Date: Mon,  5 Feb 2024 09:18:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2746; i=aliceryhl@google.com;
 h=from:subject; bh=8XZJ/IgL1JMzY5lgcFPKVTKdQYsXG/HJaPx+Ik6gB94=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlwKei/WJXwNa1kGveDERZkE/7Gq9ywL3f6UUFi
 yDyixhV/tCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZcCnogAKCRAEWL7uWMY5
 RqTMD/9zwprbrEKhYMbbQgpYaTRFzdeJBBljXrR0q+elDRZhdzFV1kRDfRBS+VMz5Bu7DYAaPUi
 xn3o7LZMOwbzRwsbBCjZLYwcAIXQIFe/HDaioHdWcqeLgDPIYws1cpxydVGHh7bxU0tpSePWvwC
 QXYEQtvH2jI4Qc2CRa1RnspuEAF+YJIMbJobmiKv7XzE2gWu2RAOFvmeu5aIlF3fvZE8M8t/GhM
 4yHziaSlbBLNVRIR51Cv04j32kOKtJcDYeiZ3eRTEY7NiSm6Edj4BPDUqMOBVMlomcFMM1+E8uQ
 cLsQghCvtFkcf8nkENTifcr9jLP/X5dt5FlsuYA61LElfJGJ9pXWm9ARSgb1+0YMxggz9wlsCbH
 JWCs3tr8P6fepJZ891HfxlYQDYtRcqV2EH5G4jY0qY+95Zgpk4bvHbnM0IMPHcjF+bm/5vj2RRQ
 78ZzUZaXUi9XHqXyOTznrmjCItWCIabNbUHItLYW194R/Gog4gwwuRVii+YUXdSnAkZskS0tG33
 nK+1fwSqy2DvSGfFS/cel4+NZsBsLvLCw/X5I56FrPeC8+X+/TQWBUf9naMXzQYz+9OGSQmC4CN
 gCP+FGu7KKvoZusZZA06xwn2V0K/xX97XT3Gdc9xyg6YaXxWR9TimpHhi4SgoPxkyFSRgN8I11B jPnV3IRbPAUNi6w==
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205091842.2858516-1-aliceryhl@google.com>
Subject: [PATCH] rust: stop using ptr_metadata feature
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The `byte_sub` method was stabilized in Rust 1.75.0. By using that
method, we no longer need the unstable `ptr_metadata` feature for
implementing `Arc::from_raw`.

This brings us one step closer towards not using unstable compiler
features.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
This patch is based on rust-next because it depends on the patch [1]
that upgrades to Rust 1.75.0.

[1]: https://lore.kernel.org/all/20231224172128.271447-1-ojeda@kernel.org/

 rust/kernel/lib.rs      |  1 -
 rust/kernel/sync/arc.rs | 10 ++++------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b89ecf4e97a0..b8d4c8167a29 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -17,7 +17,6 @@
 #![feature(dispatch_from_dyn)]
 #![feature(new_uninit)]
 #![feature(offset_of)]
-#![feature(ptr_metadata)]
 #![feature(receiver_trait)]
 #![feature(unsize)]
 
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 77cdbcf7bd2e..16309c3a9a01 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -30,7 +30,7 @@
     mem::{ManuallyDrop, MaybeUninit},
     ops::{Deref, DerefMut},
     pin::Pin,
-    ptr::{NonNull, Pointee},
+    ptr::NonNull,
 };
 use macros::pin_data;
 
@@ -239,18 +239,16 @@ pub unsafe fn from_raw(ptr: *const T) -> Self {
         // binary, so its layout is not so large that it can trigger arithmetic overflow.
         let val_offset = unsafe { refcount_layout.extend(val_layout).unwrap_unchecked().1 };
 
-        let metadata: <T as Pointee>::Metadata = core::ptr::metadata(ptr);
         // SAFETY: The metadata of `T` and `ArcInner<T>` is the same because `ArcInner` is a struct
         // with `T` as its last field.
         //
         // This is documented at:
         // <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.
-        let metadata: <ArcInner<T> as Pointee>::Metadata =
-            unsafe { core::mem::transmute_copy(&metadata) };
+        let ptr = ptr as *mut ArcInner<T>;
+
         // SAFETY: The pointer is in-bounds of an allocation both before and after offsetting the
         // pointer, since it originates from a previous call to `Arc::into_raw` and is still valid.
-        let ptr = unsafe { (ptr as *mut u8).sub(val_offset) as *mut () };
-        let ptr = core::ptr::from_raw_parts_mut(ptr, metadata);
+        let ptr = unsafe { ptr.byte_sub(val_offset) };
 
         // SAFETY: By the safety requirements we know that `ptr` came from `Arc::into_raw`, so the
         // reference count held then will be owned by the new `Arc` object.

base-commit: f090f0d0eea9666a96702b29bc9a64cbabee85c5
-- 
2.43.0.594.gd9cf4e227d-goog


