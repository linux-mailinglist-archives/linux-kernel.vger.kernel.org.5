Return-Path: <linux-kernel+bounces-75404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3959F85E823
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A201C212F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592C2153BF9;
	Wed, 21 Feb 2024 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0LNcUEU"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAB61534F2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544513; cv=none; b=PR4FuYpGzT6m20JSogjOY+vquuGRbolRkDl/Lx+MtqgypQXqlFcqjccQwRom7og71kZ8zc9VlZkszs3FaMkdZIioOOa+7awOjFUA8ZicI+JOZuyUtoF+8s3EHIbo1wvuNU2TPkAGfxMeN1jRjKH+ipC2XDH/mtuMrLZKDCo4pbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544513; c=relaxed/simple;
	bh=qkZhp+ePz3dtXVk7UutjwpWx2QtP2MvgIxyFZrcOXXs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HIMgLozxb/q9K2nHUqK6RBgtNXFkIxsvWN3UEKYQI1FQk9AJ0w67AzXO9QaidCr1pjo+vbgerK97sO40djTmXavJUhDUYX9gbI3fWj84AOzsr4jTg3ZE4RPAEjB2btnEFL2cnBt3tuESFGMFUXPoI83olShGpiSvoJs0m3Mbvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0LNcUEU; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6085e433063so44747637b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544510; x=1709149310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6Mc1467Tr+n3B+nCTUL6nWniTp2NFe2UCsWnkAH0JA=;
        b=b0LNcUEUh2ruduEaLgcg3nQ9U5rhyUIb+7Qrs0mgzU4z+my3zwxazrgoseHW7b8yFO
         VNFgNMA3Oqu/AogWa+GjJrkcHUBWQBX/uyRM68yZ41UtQyrqaDmq1dJuN3J9PZtsy8Hk
         xVaJodmxmmTJLiJKd6x3wqHB5Jy+FOKCza02PStCK1uGD4dLE2dgIRbPlG7tI0zPI4qe
         Os5+nTV8bHblWubOdyD3EofzxQmX3EftO+oh/tZpBNMwc4P0E43oCyHd39v6njiUxdkB
         4hRqTjjxNmTQzeLnmpmkuY7rY5PCdHAZA3xqP06e3KASsOwvHHTO5KdhnhyYrApo7fLX
         2mlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544510; x=1709149310;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X6Mc1467Tr+n3B+nCTUL6nWniTp2NFe2UCsWnkAH0JA=;
        b=Sl29rRwtxi5y0ve+kfEgcTcCSps8L/kuG4RBOIjSeIi4ubfiCz6nuVz8cNnoeFj+81
         WYUT7j7As03ynTWr9C/kt83bqWmHaP0+oTjk/wOUJmdXLW35BWLZfwpfn+pD8xxPsT+X
         KdG8ade57BYOrivXUwEtPYxGSC1ff9V4pdjq/2hrz2pLvYVI3pQEYRiIDLCv+vSu04+Q
         Eikv7CF52ngxeImo/upKxB4+9OWmMdYDA5wcWAh5cpXE45l4T2CQE/VoK0//HRlWWqfl
         3PCUvZfkkks9dfyipMooRR8skR84dukCBJA5Zu/lS1xDCaLfqw+GfXEMQ0Z0Efw25DBI
         rT5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpBq2B2XU0nogDCxLpP9zcOwtKmBlAF+zwdiDkXvMMHmTomhNJBDUVBsat7ZnlbDxxJFPtB/cnlllniacUlJtLDAxNXXmRce9G9KwC
X-Gm-Message-State: AOJu0Yx3AKcCcgoXtr1NqLcjcZPUBuLFPQnGKnnrfEwuM16r1GOr34TG
	IoR6BVq9RT6Ga6o02Y6oKKJcNGewq90sAz4TavG5/N6UH/+RCn9X3lADQgxshzZBjoWbjimiuId
	PJg==
X-Google-Smtp-Source: AGHT+IFo4X8oIPfRZXy8Mvx3jkM76a/Fo26RcQOQzbZJGg3aZKwzpwtV53XrK+fKFAFr0Qz0jo83p6b+B/Y=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a05:690c:368a:b0:608:55be:5e3d with SMTP id
 fu10-20020a05690c368a00b0060855be5e3dmr1661247ywb.0.1708544509616; Wed, 21
 Feb 2024 11:41:49 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:37 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-25-surenb@google.com>
Subject: [PATCH v4 24/36] rust: Add a rust helper for krealloc()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Kent Overstreet <kent.overstreet@linux.dev>

Memory allocation profiling is turning krealloc() into a nontrivial
macro - so for now, we need a helper for it.

Until we have proper support on the rust side for memory allocation
profiling this does mean that all Rust allocations will be accounted to
the helper.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: "Bj=C3=B6rn Roy Baron" <bjorn3_gh@protonmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@samsung.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 rust/helpers.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 70e59efd92bc..ad62eaf604b3 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
@@ -157,6 +158,13 @@ void rust_helper_init_work_with_key(struct work_struct=
 *work, work_func_t func,
 }
 EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
=20
+void * __must_check rust_helper_krealloc(const void *objp, size_t new_size=
,
+					 gfp_t flags) __realloc_size(2)
+{
+	return krealloc(objp, new_size, flags);
+}
+EXPORT_SYMBOL_GPL(rust_helper_krealloc);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indi=
ces.
--=20
2.44.0.rc0.258.g7320e95886-goog


