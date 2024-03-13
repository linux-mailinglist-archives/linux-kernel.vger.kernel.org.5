Return-Path: <linux-kernel+bounces-101404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A39BE87A6AF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE061F22819
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AE33FB09;
	Wed, 13 Mar 2024 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="QpGPgSSu"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520C03EA88
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327967; cv=none; b=FqzcEwredXA+wyzvgpFx+O/Fvn84HbNOmIn1HyPKL4ScKfJ1WCXaHLBMf9NrWuY1KIPlxXyViNpFQneQPKFdiki6BVKkF6t+qmwOy0gJ7sf7mgV7DL33bZcemortN0JdS6bnL55Vls5klD93ZKCUQ5NtR3UlyBLWlblPwSeLmJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327967; c=relaxed/simple;
	bh=0nWQWFCl6B4xYKkDm97E2SVl9EyjGoZdLZ86Sb/jU9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cY6/BWlyu2A51p8bA6nOyhwT6MNTYp8auzT1IJpEb1C+YMdlT36ykeED9Gqh2pO9FMo8d4eO+f2WtYX/UFdrGOm0JM3vwt1hruCxV/Gf1wjQHcEQ+ovb9+AeDtDnqWoBgFhKfiFXGgHlCXLYKnyrLVTBcY7nbznNxb9ep9op2d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=QpGPgSSu; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a44665605f3so899997366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710327964; x=1710932764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9bZI5MgzNqcWYjN2D6bG0PRoNDep28qrRC33Rpd138=;
        b=QpGPgSSurQeAV00kBohfIDQQ/sRbcn65+FgAjpsiTxNjEekBpJMerxBs2t3phB2iwJ
         KPkkqNlIK+ifJR+HcW+SqLy5RmnIwuy/B87lJ0e0pRYw+xsxG0Fv8/ucTq2YXBVu/pXG
         0bb1k4K3/b88I9bCvm7GrrAEuz/jHnruh5RFztsAoRdsDgreIMZPKJ0pRid4a1jR/SDN
         2hmavXdRUOHAq68FvSK4sgI1ZtM+lt/kgWQzbCaYlvKn/uXhlODQEtfCBkSHeBdF9S3q
         rZaEJkcsswGeR1RuA1XOu76bMkzWyD5+fS0BKfY4IV9TRBqr24H3z89Ze97+c0xVKKUL
         s0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710327964; x=1710932764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9bZI5MgzNqcWYjN2D6bG0PRoNDep28qrRC33Rpd138=;
        b=GBDzoWxZyyIUl98+OHd6B1KXfc+XRSIE/ZAxxx+808MlRNXzz9K5I/WHyi41oDUylH
         K4YUFzdRlEEhm2iM+rdAIimvcbeZf0g/LG4w0QpQL94KP9oSAIVSS2yj0wXoJ/t/i23l
         tWtCNLh3ZUC/agzNt3ooxyWOkbfFiLxDtpw+XgOEOJC2WmOQmlx83USHUZbR91eVOIUN
         bqAQPFeBwPxAK3kYJJSphj0TFb0NnLsdAqS1oeIoums0r8fpmrNY2SKOfgm5GaQkfQjD
         s0PW5TnaWp1nfE4pf2BnozeLiGNKwhIqPf16V01p5UPXTMxhkl/LTt5u2Gxe6bt6o21Q
         kUjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6dy0YcXYe3Jq6jcuxD+/e0LtjyHuuLhI3qzePU/YB55oYtMs7OZnZKWSFQJpwk8GcCbi76xlHQ7gFgPClapFGh7aWijJsHYnjtAo3
X-Gm-Message-State: AOJu0YyXhwOCKqESNC80Nuxs0u80WFvgxUSmTtlQQERAMFHdyCx7eAN9
	VmUqhzeo7dOb15DoBMdDKynCoBgu2sJJyYlXNL2SLF4pFmM3NFVwmjlBfxTu/BQ=
X-Google-Smtp-Source: AGHT+IGELi8A7Ge1QGtgoog0Js/kx4/CnhNpUUdBbM6NEhHLHoRBcFT6jXqrv9OjTLpIoqQcdAlmcQ==
X-Received: by 2002:a17:907:d049:b0:a43:f587:d427 with SMTP id vb9-20020a170907d04900b00a43f587d427mr9420734ejc.34.1710327963467;
        Wed, 13 Mar 2024 04:06:03 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id o18-20020a17090608d200b00a461f6da4e3sm3367049eje.94.2024.03.13.04.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 04:06:03 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yexuan Yang <1182282462@bupt.edu.cn>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: [RFC PATCH 3/5] rust: block: allow `hrtimer::Timer` in `RequestData`
Date: Wed, 13 Mar 2024 12:05:10 +0100
Message-ID: <20240313110515.70088-4-nmi@metaspace.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313110515.70088-1-nmi@metaspace.dk>
References: <20240313110515.70088-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/kernel/block/mq/request.rs | 67 ++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index cccffde45981..8b7f08f894be 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -4,13 +4,16 @@
 //!
 //! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
 
+use kernel::hrtimer::RawTimer;
+
 use crate::{
     bindings,
     block::mq::Operations,
     error::{Error, Result},
+    hrtimer::{HasTimer, TimerCallback},
     types::{ARef, AlwaysRefCounted, Opaque},
 };
-use core::{ffi::c_void, marker::PhantomData, ops::Deref};
+use core::{ffi::c_void, marker::PhantomData, ops::Deref, ptr::NonNull};
 
 use crate::block::bio::Bio;
 use crate::block::bio::BioIterator;
@@ -175,6 +178,68 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
+impl<T> RawTimer for RequestDataRef<T>
+where
+    T: Operations,
+    T::RequestData: HasTimer<T::RequestData>,
+    T::RequestData: Sync,
+{
+    fn schedule(self, expires: u64) {
+        let self_ptr = self.deref() as *const T::RequestData;
+        core::mem::forget(self);
+
+        // SAFETY: `self_ptr` is a valid pointer to a `T::RequestData`
+        let timer_ptr = unsafe { T::RequestData::raw_get_timer(self_ptr) };
+
+        // `Timer` is `repr(transparent)`
+        let c_timer_ptr = timer_ptr.cast::<bindings::hrtimer>();
+
+        // Schedule the timer - if it is already scheduled it is removed and
+        // inserted
+
+        // SAFETY: c_timer_ptr points to a valid hrtimer instance that was
+        // initialized by `hrtimer_init`
+        unsafe {
+            bindings::hrtimer_start_range_ns(
+                c_timer_ptr as *mut _,
+                expires as i64,
+                0,
+                bindings::hrtimer_mode_HRTIMER_MODE_REL,
+            );
+        }
+    }
+}
+
+impl<T> kernel::hrtimer::RawTimerCallback for RequestDataRef<T>
+where
+    T: Operations,
+    T: Sync,
+    T::RequestData: HasTimer<T::RequestData>,
+    T::RequestData: TimerCallback<Receiver = Self>,
+{
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+        // `Timer` is `repr(transparent)`
+        let timer_ptr = ptr.cast::<kernel::hrtimer::Timer<T::RequestData>>();
+
+        // SAFETY: By C API contract `ptr` is the pointer we passed when
+        // enqueing the timer, so it is a `Timer<T::RequestData>` embedded in a `T::RequestData`
+        let receiver_ptr = unsafe { T::RequestData::timer_container_of(timer_ptr) };
+
+        // SAFETY: The pointer was returned by `T::timer_container_of` so it
+        // points to a valid `T::RequestData`
+        let request_ptr = unsafe { bindings::blk_mq_rq_from_pdu(receiver_ptr.cast::<c_void>()) };
+
+        // SAFETY: We own a refcount that we leaked during `RawTimer::schedule()`
+        let dref = RequestDataRef::new(unsafe {
+            ARef::from_raw(NonNull::new_unchecked(request_ptr.cast::<Request<T>>()))
+        });
+
+        T::RequestData::run(dref);
+
+        bindings::hrtimer_restart_HRTIMER_NORESTART
+    }
+}
+
 // SAFETY: All instances of `Request<T>` are reference counted. This
 // implementation of `AlwaysRefCounted` ensure that increments to the ref count
 // keeps the object alive in memory at least until a matching reference count
-- 
2.44.0


