Return-Path: <linux-kernel+bounces-108258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30433880877
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1E91F236A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D511A946;
	Wed, 20 Mar 2024 00:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSroxVNO"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA1566A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710893752; cv=none; b=o24aRWhiK15r18MGBPAVCQPemsLssCsEtpAyWcziBrkUDnW6A6L1f2MSPnyod6T35iPGi4E4Awe9QvPJiPrcEzfc13+wjnudUP98v6sJmZpqao4SnnaaH054zrFqLoTyAgM9neHjb+05iMQBSvJKM5xfVGSVqT077JkE0O5ymzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710893752; c=relaxed/simple;
	bh=w7N5groxenxQwOyx2Bg0o9JgzIKj55+kMVOrUurrk9Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tKeEOTJLknMoRmnSmGr5C8R0+0l8inPBmSz3hCYA6ebHu43EPd1Adkdae1ss8+IJaIoKoutFyAjkBE7uhnfD987An+gvzrGstDGhHSR7nlLVabkSAl/NVX4+bmO0r+7CXu4/S+s8pjywKCmDMMApulW3TdnYPoAlsvKvxufek9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSroxVNO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cc8d4e1a4so117839187b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710893750; x=1711498550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QwdnnYU5NTwIDpJoKUhQ+ev0BrLDudc5wiCqltwp/lk=;
        b=bSroxVNOMlhRMbm4vIfnBfwwKndEXfOCkPSEclAOu/7jzyqG45JIDH5emZRxcsQJLK
         Vduof3xv6U+bH+X7W+KFKZSj2XqrJjhwaZbplzWkAtYUzjVLwui78jrBzUMgKKczng6F
         hYb8ATjqkUcDQOigMbrKvluoKJmnA5U0Rk0kyn6Ir0BRdXw0kw+KIjVHlbsV6poefeQR
         eL02mPPcKWofZIwUuGHRu6J8FQGKZEyUDBckzAl7Y8peMMmiH7i4HjtM5Ca0nv5YUSmS
         aITDmev19YHOR4ONyWaNghbTbGRbOu0DeyoKKs/0oM8l/1m3vcA0yX3IUjxvx45F/5p7
         aaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710893750; x=1711498550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QwdnnYU5NTwIDpJoKUhQ+ev0BrLDudc5wiCqltwp/lk=;
        b=uxzysmCKGgrgA8e2jdYZCDmcpW8vPjhr54VVYhTvVUcATDURZu3RUqxnEj0FN5KX96
         oyMIu60Ysu+fyzHbmhYYxbRj8eozwVS+NnKQFn+G/kKu4ElJBuMWSb+8qtXJcnDn+COA
         3nHmLDtewSxlsD8j3JId0vGXBFMYDdVxP0kV+m1H6gzUPPQneWZr7aToIBdGUkFMOIDI
         aXGbU1RTy8BvVnu+h0OIC6I0C2nDLYs1c9cTBUhlwhmTpQO6hOlu7bY6tiuA9sTYUWeF
         WaLQgSbb6eDjGunFtas5BS05lrt7ghDc0O5pHWdiPJnHCWpsMHNVnKa8CpehLevLoY5X
         QJCg==
X-Forwarded-Encrypted: i=1; AJvYcCWlYSRWPGAwtWZ6UncU9GkAarIbEQ0G0218Dukn8nYzyEdHdd/hdz7RMLRpQvQhlHnEzacgSPL/3tUeoE1GPZWPEYfjbTReUHa0kcT5
X-Gm-Message-State: AOJu0Yxygh1oeyEaRJd/rHb/VAfOEql/+6nkM8vWu/UHt0t1vVBK35VL
	JhCqG5kSByEo3yvK/kfPoOuQ8Qj3UmaHdWOi8TYbUTmWrUj3qQ+wI8uIg3scDdSKI9ZTHEwReNE
	fHQ==
X-Google-Smtp-Source: AGHT+IFoMEoUU1bqXVgSJMZ8c63cXq26fjN6lJZWr1OCTaj+JhBJGEp+ggbssXee4pM4Ws29Fac1D1f2DtU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:db01:0:b0:60c:cbdc:48b4 with SMTP id
 d1-20020a0ddb01000000b0060ccbdc48b4mr1115906ywe.3.1710893750386; Tue, 19 Mar
 2024 17:15:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 19 Mar 2024 17:15:42 -0700
In-Reply-To: <20240320001542.3203871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240320001542.3203871-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240320001542.3203871-4-seanjc@google.com>
Subject: [PATCH 3/3] KVM: Explicitly disallow activatating a gfn_to_pfn_cache
 with INVALID_GPA
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, syzbot+106a4f72b0474e1d1b33@syzkaller.appspotmail.com, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"

Explicit disallow activating a gfn_to_pfn_cache with an error gpa, i.e.
INVALID_GPA, to ensure that KVM doesn't mistake a GPA-based cache for an
HVA-based cache (KVM uses INVALID_GPA as a magic value to differentiate
between GPA-based and HVA-based caches).

WARN if KVM attempts to activate a cache with INVALID_GPA, purely so that
new caches need to at least consider what to do with a "bad" GPA, as all
existing usage of kvm_gpc_activate() guarantees gpa != INVALID_GPA.  I.e.
removing the WARN in the future is completely reasonable if doing so would
yield cleaner/better code overall.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/pfncache.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 91b0e329006b..f618719644e0 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -418,6 +418,13 @@ static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned
 
 int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
 {
+	/*
+	 * Explicitly disallow INVALID_GPA so that the magic value can be used
+	 * by KVM to differentiate between GPA-based and HVA-based caches.
+	 */
+	if (WARN_ON_ONCE(kvm_is_error_gpa(gpa)))
+		return -EINVAL;
+
 	return __kvm_gpc_activate(gpc, gpa, KVM_HVA_ERR_BAD, len);
 }
 
-- 
2.44.0.291.gc1ea87d7ee-goog


