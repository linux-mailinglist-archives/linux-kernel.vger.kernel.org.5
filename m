Return-Path: <linux-kernel+bounces-112883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BED887F7C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3E82812A9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8961B4204E;
	Sun, 24 Mar 2024 22:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4GwqlM8"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0C33D575;
	Sun, 24 Mar 2024 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319661; cv=none; b=EJttXu+BmhTpazyVrf6CZxEM7Og9r/FRG27ZsD5CtFDXgiPPoKb9JGpr9ph4L7E8TTaMDJiz+clpxwnL85FjapuG9iJvNLrf4vzznX488AsVnrk54dBDW8CTxvxg8cjjlPWvy0+3IEDmhj0un2nxdPWhAv78BiBNqHm3io9QZTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319661; c=relaxed/simple;
	bh=vvpQmM/Tf5QRvh84FsdH0Tqa7QhnDpFIQ+omIra6w3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnN7QAzp4Ud+NmR+D0LMwwDGaAcOX+CqpzzcO2uzbVq64vdYMU/lrLAbb4HQPj98D2eWXeKerDLRIdFKmaqWLunQZPxJlG/EfpTwW8WgYa+6KmezbWkW5+euScqYhXLwA1ACCXdn0nQFaewKT/qRGXD73Z2KYkBEVbqb/6pUJmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4GwqlM8; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-430acd766beso21109751cf.1;
        Sun, 24 Mar 2024 15:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711319659; x=1711924459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vdcgG0wCfsjDnuqEkDhhA7hvo7PO+8wNdJ07rpMikmg=;
        b=S4GwqlM81vlSasN7SFjspaCZHKKE3QBTURLPuF59GqWTYrmRvpDPcXfRc6qtOJfiFR
         6QgwGZmTLhd+7Zl6wBRjUHSXZ+wrA121sIWSocCjHdciBOilQ08nmhs6GYgmARyrieu+
         LVVQYLWe5a4MymM7dUCEbwrx+nIEOMVzUfbKuRP6009RIR6Rjax7Bpee6Xfg9I3INgTA
         rSJl389RNzvvkmSYwnKJTNU2U+bvurZN6WtEs8y/weM/CWUc9vJtuZuvKpqHXbJwzmbw
         srNL0Sj8FK6pecVUEkeu5+5ppJS+JLz2cZNkSXitGdFHyp/dfThgE/6PVXtwnHR2WhEY
         ZlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711319659; x=1711924459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdcgG0wCfsjDnuqEkDhhA7hvo7PO+8wNdJ07rpMikmg=;
        b=t4WYa7duoGGfFuAYdzEKgSIluuyCVklreO4CZeZ+WPNzx0Qju6AFBTiMEaL861W0JB
         5p0I0CgGQQIllOeTtfmpaWdPvkCo1MI4wZ83nLvcQkHnbkHTccEfiW/sYofnOkyxnDCJ
         ExZukGdRgGO/w94e2vTMUh8AKL/Jpbw97AdbIz5SK8Cwu0EQ7xbo6lWUrXCD/dSJZXDa
         iex+tM14n9hztKstkeN3vA8yOpXNBkJDOKWTet7EY54yJpWQB0aoVTSdd6admpot1VUP
         Dra8uWQPF4bxIQ851+qUHnPjS4bFNgrAI0xQh/HUHEdEp/D69N4EWMcxFtYUVN/NH+GD
         teZw==
X-Forwarded-Encrypted: i=1; AJvYcCXAfOM+9jbW7LJzDsFiIRbEHWT0PRNuVwYv/ZASGqpj4/ZasXjl3TzLykJvhsxE9FdSTkOX2iXjlu3Mwm5XLWcOrVSYB8i92AFar6bu
X-Gm-Message-State: AOJu0YzHnKdRrZrH3UqqmGM93p4pQOPRyT6mi3+qvWj/ml1ugQPZwKhS
	OA9lo6YaeLFRqrx5LCIGv07ltI7kk5VVB9sZzyGH1AZrj1NeX2Xg
X-Google-Smtp-Source: AGHT+IGyoyk66ziQtdmRMnAVtGYqPKFVrzwqgoF2f1PR+0p7X/wr6BEC7PCrJegX1V23TpgNtn15fw==
X-Received: by 2002:ac8:7e90:0:b0:431:4f15:69f9 with SMTP id w16-20020ac87e90000000b004314f1569f9mr3427042qtj.23.1711319659224;
        Sun, 24 Mar 2024 15:34:19 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id ge11-20020a05622a5c8b00b004309754810fsm1976124qtb.89.2024.03.24.15.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 15:34:18 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 58F1A1200032;
	Sun, 24 Mar 2024 18:34:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 24 Mar 2024 18:34:18 -0400
X-ME-Sender: <xms:aqoAZuxZiAn-1Qtc9JctAO0k0ljPkC7h7eoQysDwyOHQfh5QiTdgvQ>
    <xme:aqoAZqRtXmXinrFL7lhN-GyVKWrXO-oDXdVh39zS37o5wP5Drflicaw88U3y_9Amh
    CBcPGkF4SrgPtanbQ>
X-ME-Received: <xmr:aqoAZgVfRkLhyoM7oKihQ_A8DnVZhAK1CTqqu_QK9ZPqmBuDBcoSebIi1mo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtjedgudeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfevffeiueejhfeuiefggeeu
    heeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:aqoAZkhf1KTXzXRtA0swzZYf2W2tiK2uO4W2LvtBkm-r_cHPO3rJjw>
    <xmx:aqoAZgAGq35Da2Bupd3rVBDwV9ULUsm7Mr06LBjUReMnfQbfS854Fw>
    <xmx:aqoAZlIqHJ8M9tiwmtKuVZbQEgPbMOckJw3n7xfFpHYlLxd2Um30uA>
    <xmx:aqoAZnBCOZ-EUJFiei6sYnffcpcCilwGmKjtSPPXazE7WCdtBbWDKQ>
    <xmx:aqoAZuTwhBdERtGrGrB6hFa3ap9J4i0MvvGLfm65cUrT7WN_SOG86Tq00Fw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Mar 2024 18:34:17 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	benno.lossin@proton.me,
	Andreas Hindborg <a.hindborg@samsung.com>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>
Subject: [PATCH 2/5] rust: time: Introduce Duration type
Date: Sun, 24 Mar 2024 15:33:36 -0700
Message-ID: <20240324223339.971934-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240324223339.971934-1-boqun.feng@gmail.com>
References: <20240324223339.971934-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Ryhl <aliceryhl@google.com>

Introduce a type representing time duration. Define our own type instead
of using `core::time::Duration` because in kernel C code, an i64
(ktime_t) is used for representing time durations, an i64 backed
duration type is more efficient when interacting with time APIs in C.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
[boqun: Rename `Ktime` to `Duration`, and make it a type of durations]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/time.rs | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index bbb666e64dd7..b238b3a4e899 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -7,6 +7,9 @@
 //!
 //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
 
+/// The number of nanoseconds per millisecond.
+pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
+
 /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
 pub type Jiffies = core::ffi::c_ulong;
 
@@ -20,3 +23,44 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
     // matter what the argument is.
     unsafe { bindings::__msecs_to_jiffies(msecs) }
 }
+
+/// A time duration.
+///
+/// # Examples
+///
+/// ```
+/// let one_second = kernel::time::Duration::new(1000_000_000);
+///
+/// // 1 second is 1000 milliseconds.
+/// assert_eq!(one_second.to_ms(), 1000);
+/// ```
+#[repr(transparent)]
+#[derive(Copy, Clone, Debug)]
+pub struct Duration {
+    inner: i64,
+}
+
+impl Duration {
+    /// Creates a new duration of `ns` nanoseconds.
+    pub const fn new(ns: i64) -> Self {
+        Self { inner: ns }
+    }
+
+    /// Divides the number of nanoseconds by a compile-time constant.
+    #[inline]
+    fn divns_constant<const DIV: i64>(self) -> i64 {
+        self.to_ns() / DIV
+    }
+
+    /// Returns the number of milliseconds.
+    #[inline]
+    pub fn to_ms(self) -> i64 {
+        self.divns_constant::<NSEC_PER_MSEC>()
+    }
+
+    /// Returns the number of nanoseconds.
+    #[inline]
+    pub fn to_ns(self) -> i64 {
+        self.inner
+    }
+}
-- 
2.44.0


