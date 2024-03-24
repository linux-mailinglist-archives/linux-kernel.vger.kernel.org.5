Return-Path: <linux-kernel+bounces-112885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A8A887F7E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D7F2812CF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097E84597A;
	Sun, 24 Mar 2024 22:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcT/QOgL"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFEA43ACC;
	Sun, 24 Mar 2024 22:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319665; cv=none; b=NT63A3eHlqNTrZg3A2JSXQsAqHRLRRxpGXWjUbayWKfXgQ0ZQLv+c6hDBnvLDl7cY5Mo9lIrdvisR/p3dmPnIXg7wUFvT3akOG4ESK+ielkMiDKjmjv5sMF0oYaDAQtSLpKA22efFHhUbFo8aSppghaQSAADVg4BR2LZRiM4P9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319665; c=relaxed/simple;
	bh=bJ86mbIQjLwbn//NFmnurEsU7QTgkvcp3FVZZRVJCis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqE8ABaSuDsxVk2yMoCmdfkL+Mroijz9h97zoEQ16MqCSsSH1AIV1WApN4aSYU66IRpq6FuMGe/mbigXT3mE+IEK9cTHP/a6ht0HwlxZe0XeMlENyJ7Bp7+dSbyeBKkwTVhDIPw07UpujLBahrSCahn0lPyIBdmCpkuhf/6feV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcT/QOgL; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78a3bccc420so171560485a.1;
        Sun, 24 Mar 2024 15:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711319662; x=1711924462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sdmtxUeccR9mblyOKVx+vdMDj9Zw7MyhLqQWnpnpKTE=;
        b=XcT/QOgLouX+XbDSUamrw2L1UgLIY3emyDz0iMOsWLpSBaWjC6iMuTq8wvkN/yqUFC
         TPwbFO4ksYueykT9CHGjELt4NeVzpQfZSu+tgVGTNFNXK9sxqGCRCwh3JmQtHIvqQnpM
         HVPyIy+BpNZ/hIZ77I67yYZzjwS2X/idCRf9hA5HEajahrv/k5prgdyAwFjjr2IGPo4o
         pw6QOZw23+cJh4nY9DNYat5wp5+d8BQAVtDhn2+NC6SZwFZ6K7rebDnTyPLIetwcjv/8
         uMIKoYzndb9ptybt8iGwlG4hueRAT556nsdyrRA0EqQYrHeyuNZMsSVmoeaFn6V36cvi
         Xz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711319662; x=1711924462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sdmtxUeccR9mblyOKVx+vdMDj9Zw7MyhLqQWnpnpKTE=;
        b=VTf/fzQnedF45TgW/jLjz9RAwJnKi1fDwB8mHCiR+wH5ocx0vc/QS1hSia9sTuR81g
         NOUypzSLaTJAVEKvvXya+7+gfpFI9oOtp2Eclz2MtGBo5u6k3xE7sIqbseWNl50k4yNC
         7ZqBlFz751/xP85O4zCd0QnNiyI/07DarmU8+pwkPzQjN2l2rzW1cqw2VFv6JmhYuCyW
         TJsWjvQmmxzViGcwG00IyTmoIHZ0zdmzHamoWNbQCj3wLnFMFy4DnhOM3oty6VdC4NFH
         uBvr1sApTJ0/iKVGczGXSIN3OjVfFyyHExecH0GeA4zUPrJbRVoRUyMcuLOor42SFh7X
         +i5w==
X-Forwarded-Encrypted: i=1; AJvYcCVadp1Edc2E/5TmGhTGLUkeaEz5w8fySiql5T0gkBIpmIZOHXOeOCSCISRpLGgTz7L/o2wi2U8dqT7SjjoHjR6UaOu4gxIZb7BFC+8P
X-Gm-Message-State: AOJu0YyFToaDUSvo3Nb/hguVuiQS/L8pmwvGl+pX9gy2/+Iu3bNYglqz
	cWCB50u6z5qFJPHQ8Y9dJuWKWlSRTntL/gTr29OJkNis+yQ1o14q
X-Google-Smtp-Source: AGHT+IFLQPh7gqo+zXF+9PbKRGc+rHtCUybFWEY/2W6Tn5dZpR95LD4k7sPOmVENHxAxa3tgQSbCdA==
X-Received: by 2002:a05:620a:4c:b0:78a:3326:13f with SMTP id t12-20020a05620a004c00b0078a3326013fmr6094290qkt.58.1711319662549;
        Sun, 24 Mar 2024 15:34:22 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id w14-20020a05620a094e00b00787930320b6sm1652237qkw.70.2024.03.24.15.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 15:34:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id A14901200032;
	Sun, 24 Mar 2024 18:34:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 24 Mar 2024 18:34:21 -0400
X-ME-Sender: <xms:baoAZuVP-c-k2r-eUekvNLcsRKMaMAv1mZ2q2JIqrDXFjHJzke2yqQ>
    <xme:baoAZqneABAPAlQQioms_pbpZJTO5u3sFgc5wxFUc2TrjqItLQQTADnSxFU7vz-qu
    dfRKwu48j-Prfhrfw>
X-ME-Received: <xmr:baoAZib8lmEnzvJnj1EhIG63pEtxO16mrha0bSHyPXQBnpk3s902SyXS6MA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtjedgudeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepjeeftdetjeekjefguefggffgiedvieffleejieejueeugfehiefhhfef
    geekkedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdprghnughrohhiugdrtghomh
    dprhhushhtqdhfohhrqdhlihhnuhigrdgtohhmnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrh
    hsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgv
    nhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:baoAZlXsvt8JYuCQDiAWgkmnqK3joe-FjfFVCYvzaw8HSUtzG88Reg>
    <xmx:baoAZonCPp1qnyYvsb9C6hyfkAYBP1hQcww4-hMMTZ0AWxYPyqhGsQ>
    <xmx:baoAZqeGsvv1RTxwuF165DY3DcHZHJ3YAQMsDXPKFUH1vJGWg2hh9w>
    <xmx:baoAZqHwjvbDqAFR-oQ7oOI7mqOa9hn2ryXvlKXjK97ZWuQBcCM2UQ>
    <xmx:baoAZvpaGj_uUUtk6QLrnL0kL8pnAAYk0ykOLQtxwxhgsuw_dq81vTfqf2I>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Mar 2024 18:34:20 -0400 (EDT)
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
	Valentin Obst <kernel@valentinobst.de>,
	Heghedus Razvan <heghedus.razvan@protonmail.com>,
	Asahi Lina <lina@asahilina.net>
Subject: [PATCH 4/5] rust: time: Support reading CLOCK_MONOTONIC
Date: Sun, 24 Mar 2024 15:33:38 -0700
Message-ID: <20240324223339.971934-5-boqun.feng@gmail.com>
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

Rust Binder will need to read CLOCK_MONOTONIC to compute how many
milliseconds a transaction has been active for when dumping the current
state of the Binder driver. This replicates the logic in C Binder [1].

For a usage example in Rust Binder, see [2].

Hence add the support for CLOCK_MONOTONIC read.

The `ktime_get` method cannot be safely called in NMI context. This
requirement is not checked by these abstractions, but it is intended
that klint [3] or a similar tool will be used to check it in the future.

Link: https://lore.kernel.org/lkml/5ac8c0d09392290be789423f0dd78a520b830fab.1682333709.git.zhangchuang3@xiaomi.com/ [1]
Link: https://r.android.com/3004103 [2]
Link: https://rust-for-linux.com/klint [3]
Co-developed-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
Signed-off-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
Co-developed-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Asahi Lina <lina@asahilina.net>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
@Alice, I still put the link to the usage of Android binder here, if you
want to remove that, please let me know.

 rust/kernel/time.rs | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 0f9f5605ed48..5cd669cbea01 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -113,3 +113,22 @@ fn sub(self, other: Self) -> Self::Output {
         Duration::new(self.inner.wrapping_sub(other.inner))
     }
 }
+
+/// Contains the various clock source types available to the kernel.
+pub mod clock {
+    use super::*;
+
+    /// A clock representing the default kernel time source (`CLOCK_MONOTONIC`).
+    pub struct KernelTime;
+
+    /// `CLOCK_MONOTONIC` is monotonic.
+    impl Monotonic for KernelTime {}
+
+    impl Clock for KernelTime {
+        #[inline]
+        fn now() -> Instant<Self> {
+            // SAFETY: It is always safe to call `ktime_get` outside of NMI context.
+            Instant::<Self>::new(unsafe { bindings::ktime_get() })
+        }
+    }
+}
-- 
2.44.0


