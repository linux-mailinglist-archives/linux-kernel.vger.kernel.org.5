Return-Path: <linux-kernel+bounces-97721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57547876E67
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 02:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9711C20B8A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 01:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE0015AF;
	Sat,  9 Mar 2024 01:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2FT3jFrK"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D2F1DFD0
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709946587; cv=none; b=OuTMthdWos25r81gr7Dky9LYdEH6jr60xo1npvzT6dMmspj6cNZQl4ylzQaCYod7PQ5BSAhY4lDR8cNZrfJHBKmWuER53HSaXNkpjSIzOy80W52PEgxXwR7Mo82YWUwi4T83oflSZDVvmKYQqaR7kqUGTWJktuT6LgWSGSmT6Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709946587; c=relaxed/simple;
	bh=ycBchpSWHJX8l3+qZZZs50c8pkvQnvrnnxo1fe2hEZc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HuA7ZyIW9utiMq3YGul1FR2LoGpvxskNx9FGLZj++YJW0pBi7rxJ272NFEdCRVOtulliRRKLewO+2tr/R7/CZfAaTQdqeP3tKEiIb4MNatldkj8moKunKnBkp2GNkEqZkd3MT4JEm/bjoG33qEPccMUH60kO+o0o9h/rftyBG3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2FT3jFrK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a0b18e52dso10060597b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 17:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709946585; x=1710551385; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=g4owpzTMykQxDUqiA6ej7g45orHQxXd/2WL2dIWa35k=;
        b=2FT3jFrKAA7AuyqS+TGTMp9MsPHqm7nfNdjH2gI2DxkC+nmlNDEui/eS9thJOX3L5S
         AzMQ3rFqqzsW2L7qbBnund07mHDuaEKVjKrvkYPDHCZXG0ur10H3cnx9atKyDG3p1MgU
         tqvTarwQn0JLdGbaxq8kQyeUpzT1VeJQZJiRFWgNca0pp10U63YKD0HWAnTCWX1w7YTb
         F9DEM4vZmuJ/sM/Q+Xk9GimlRSMfphtZQt5tJhFx5z4an4zE9fMBWPSYNP8SgYEN39s0
         M7c/AbD+IijsH9oKNgd5nl8BpE7xcDg6qtDMYzwvW7/ZF6D39eBgg8UiKfaARAtWLOr0
         g0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709946585; x=1710551385;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4owpzTMykQxDUqiA6ej7g45orHQxXd/2WL2dIWa35k=;
        b=dlqlvSmYqby/ttZkI+aU+F/bPU+GAbyabTFJkgYA0MZEAtiI+RlLGkovadyxDkVmjZ
         RaSPjtWEH/P3t4XdjDkHiJBPmccmhHnk127oQdqopDH8LWDKXNKThI82cFY6/8XsN6Gn
         qj6s34BPPc22LeNKNJmRXshO077ooz6cGQVk7F4KQg/iz/HBvjhkofdQZH/NMZpFayF6
         rmPRO0lkPNiA0HBYp8Xcmq7IFokOYMtndh3E+yJcMbxjyv2SN0wDUysWZ6pmXFuAKNo3
         NSpM/Ll+IXJNmkQskR1ZVr8UgiZjffPWi7tYiagefbKs/aIVlqiIfRdEHGD1r42sU2eq
         gDGg==
X-Forwarded-Encrypted: i=1; AJvYcCVYtHiydY5sfybReaKT+RwUy/TrocmfbMWUIBRDWTP1bdS8v6GkNWoYRLMMpsE7OkTMK9oQUyGGtiCLHfVA2VjYOBtar36neLzxJ1Bg
X-Gm-Message-State: AOJu0YwZmgqXP5Z7aWJZDb9xSS/G/g1fBXr8jEzEWhgcblI4IF8hgc2f
	1hruNbjq4f0yFMRlu7J8NksRxPzHdgEaHSeFRhv3piWv7ohfdD8thv2lGFk2kXtEYGmr8CY/rPC
	3Aw==
X-Google-Smtp-Source: AGHT+IG6WhzVfQfNxhkh6vO1oFttllHBGIxq53Aa6SsBcpq2DPCtMuTS0yWAgaYlxw31FNSJQ8BASJ/xVnw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:df93:0:b0:609:6150:da22 with SMTP id
 i141-20020a0ddf93000000b006096150da22mr217869ywe.1.1709946585045; Fri, 08 Mar
 2024 17:09:45 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 Mar 2024 17:09:27 -0800
In-Reply-To: <20240309010929.1403984-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309010929.1403984-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240309010929.1403984-4-seanjc@google.com>
Subject: [PATCH 3/5] srcu: Add an API for a memory barrier after SRCU read lock
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>
Cc: kvm@vger.kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Yiwei Zhang <zzyiwei@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Yan Zhao <yan.y.zhao@intel.com>

To avoid redundant memory barriers, add smp_mb__after_srcu_read_lock() to
pair with smp_mb__after_srcu_read_unlock() for use in paths that need to
emit a memory barrier, but already do srcu_read_lock(), which includes a
full memory barrier.  Provide an API, e.g. as opposed to having callers
document the behavior via a comment, as the full memory barrier provided
by srcu_read_lock() is an implementation detail that shouldn't bleed into
random subsystems.

KVM will use smp_mb__after_srcu_read_lock() in it's VM-Exit path to ensure
a memory barrier is emitted, which is necessary to ensure correctness of
mixed memory types on CPUs that support self-snoop.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/srcu.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 236610e4a8fa..1cb4527076de 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -343,6 +343,20 @@ static inline void smp_mb__after_srcu_read_unlock(void)
 	/* __srcu_read_unlock has smp_mb() internally so nothing to do here. */
 }
 
+/**
+ * smp_mb__after_srcu_read_lock - ensure full ordering after srcu_read_lock
+ *
+ * Converts the preceding srcu_read_lock into a two-way memory barrier.
+ *
+ * Call this after srcu_read_lock, to guarantee that all memory operations
+ * that occur after smp_mb__after_srcu_read_lock will appear to happen after
+ * the preceding srcu_read_lock.
+ */
+static inline void smp_mb__after_srcu_read_lock(void)
+{
+	/* __srcu_read_lock has smp_mb() internally so nothing to do here. */
+}
+
 DEFINE_LOCK_GUARD_1(srcu, struct srcu_struct,
 		    _T->idx = srcu_read_lock(_T->lock),
 		    srcu_read_unlock(_T->lock, _T->idx),
-- 
2.44.0.278.ge034bb2e1d-goog


