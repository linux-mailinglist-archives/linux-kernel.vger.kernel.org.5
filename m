Return-Path: <linux-kernel+bounces-91459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4418711C9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3921C21E94
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5FF7484;
	Tue,  5 Mar 2024 00:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mh0LXIwk"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352393210
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 00:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599066; cv=none; b=n9gk4DNVHJk18Cb/Y1PsMeqYfiVYeAbY0RabTLWNoytgOAY6egORyt3XCq9rWG1HI2SktDWae8+xghPwTL4laUvA8np6ys0uBNGKh2V9yeJyoQsxA+ywYQUsZgWKaIOAnJWhDIxGqH+aZkzV0JHuOIun5YLa1mnroMoqhRzYbzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599066; c=relaxed/simple;
	bh=DUXhp+g4qoxMZncdiQGNSWIv8z7LVY9hkgbsTfx2fRQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fK3Rr+vGkojfNQEIhbJRBhx3vThCgXKno8iQcIlIwBifHBVHhXskCw9r5fAUifHASIPPwuAsMfVwmaztS/esldVGurksQSskxZDF5++i4yBRvZ89x1Goxgqj+QRDrqS/mpEiyt0+yhht+5PmYe7f/ykCpAfePFAZExQQassJ6aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mh0LXIwk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-29976f92420so3934556a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 16:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709599064; x=1710203864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPDZDFGuvVe1xm4D1iYkB/saEEgYVA3F8rFzvBJXEcU=;
        b=Mh0LXIwkXgNwesFjha1FKnlA6c5sgTK0SKWV0vtb2srlO6C5NbuG+bux91YkryI1By
         rjitqWdS+0/mGelKxvuuF6EI48hPLdKski437eF5MuQ5DREOy5J42wdS5J2yVzq0xsuB
         epHDy/jX/ltAOAWXC+5BQNFOADIa0ieO0gGoADQzC/OQ8O3dPJARA0iZ/IQQKNwQDywh
         n6n0W65lkLA+T6VmZefqmov0Uvlz8fD8MPn57MkRM6dpIOW9fe4F5rMVP63+ZJnWX8sc
         MG/lTXjmXXPf9bREGw782OjOwp00taOEA8zrgYYRKBAvf/HONzBiqqgcC8eEYMVUQTXB
         nGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709599064; x=1710203864;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qPDZDFGuvVe1xm4D1iYkB/saEEgYVA3F8rFzvBJXEcU=;
        b=wl/K6FgymOq5QzAelZZm3FXrFdDEj0wTxTeaeSFo258aojWxeCx+iSgCd/QMsN7Toj
         4sRpsebgqRBqXVzz/Oi2kfpudRMPqgrZHQFECqOg9CREGvaFAGpWcyr6FzSfAnfweG3y
         +dBMpntjvs0xFp8O5LeQ78BH2aFsEnlRiX1ojo96RSbyMZQ4LuFKw7t3c4NApinOf+KW
         nBysWMBqVExfGVhZATczvOlNEizTYmw5yyccE/tUzGPPjl1dqI4z8Fw0++wn2gQ/phqL
         W4DiMlnu0qKeApq87wP2GnK2aBdJoOYyFw61jmqNnBx9RUASCYvYwqZuGGTSLS7iXLb9
         CzAA==
X-Forwarded-Encrypted: i=1; AJvYcCVO2b/rWrVi8lvUgwjIZJpstlpkPMdxHNGB6w8wjBoMVDgMO/ZTp8a4juQhJzwsLLk/vpYBySLtujufxP2Tb58dRLGxVyQfGXWCwD3A
X-Gm-Message-State: AOJu0Yx3L1ZtVn4I7yU6QoKXoM3VsBscJmKt2rDdDvcrsP/a/F/PFuPI
	BCiN3SeKXoOgzUD6IKV0C+9c90d8CCGKq+YuKQSEKCBQVaRaBFSIRWT7bf3gLK+GfdC6JORdKFW
	7dg==
X-Google-Smtp-Source: AGHT+IEIR3UYe44S1T2sQALNQ9lpMFR1+QrQVzgvSlJIhG/glLcCrrCzAf9Qa7vrIu0VeJkZ+mhlNOZcKOY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:5414:b0:29b:2fb2:e2a1 with SMTP id
 z20-20020a17090a541400b0029b2fb2e2a1mr5802pjh.2.1709599064239; Mon, 04 Mar
 2024 16:37:44 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon,  4 Mar 2024 16:37:42 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305003742.245767-1-seanjc@google.com>
Subject: [PATCH] KVM: Drop unused @may_block param from gfn_to_pfn_cache_invalidate_start()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Like Xu <like.xu.linux@gmail.com>, Paul Durrant <paul@xen.org>, 
	David Woodhouse <dwmw2@infradead.org>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove gfn_to_pfn_cache_invalidate_start()'s unused @may_block parameter,
which was leftover from KVM's abandoned (for now) attempt to support guest
usage of gfn_to_pfn caches.

Fixes: a4bff3df5147 ("KVM: pfncache: remove KVM_GUEST_USES_PFN usage")
Reported-by: Like Xu <like.xu.linux@gmail.com>
Cc: Paul Durrant <paul@xen.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 3 +--
 virt/kvm/kvm_mm.h   | 6 ++----
 virt/kvm/pfncache.c | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ff588677beb7..7106b57b8468 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -832,8 +832,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	 * mn_active_invalidate_count (see above) instead of
 	 * mmu_invalidate_in_progress.
 	 */
-	gfn_to_pfn_cache_invalidate_start(kvm, range->start, range->end,
-					  hva_range.may_block);
+	gfn_to_pfn_cache_invalidate_start(kvm, range->start, range->end);
 
 	/*
 	 * If one or more memslots were found and thus zapped, notify arch code
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index ecefc7ec51af..715f19669d01 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -26,13 +26,11 @@ kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool interruptible,
 #ifdef CONFIG_HAVE_KVM_PFNCACHE
 void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
 				       unsigned long start,
-				       unsigned long end,
-				       bool may_block);
+				       unsigned long end);
 #else
 static inline void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
 						     unsigned long start,
-						     unsigned long end,
-						     bool may_block)
+						     unsigned long end)
 {
 }
 #endif /* HAVE_KVM_PFNCACHE */
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 9ac8c9da4eda..bff9875cdcd2 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -23,7 +23,7 @@
  * MMU notifier 'invalidate_range_start' hook.
  */
 void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
-				       unsigned long end, bool may_block)
+				       unsigned long end)
 {
 	struct gfn_to_pfn_cache *gpc;
 

base-commit: 003d914220c97ef93cabfe3ec4e245e2383e19e9
-- 
2.44.0.278.ge034bb2e1d-goog


