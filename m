Return-Path: <linux-kernel+bounces-155790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04EE8AF721
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2161C24F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791FD1411DF;
	Tue, 23 Apr 2024 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cnyJSpdt"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720BB13E057
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713899813; cv=none; b=ogO7seu0cB31TqTLkHANOk8Uyzo6EyR/36YBBfGMSZHDlD0MAwjy3Jr9hcP/HCzobw9cXGu/pIfSgOTaUCLIYgjKgnU/6IY4WW/4yredxxcacOp+1VeJCDVv5cR6wyrBmj8gmATKdZZaHGrieq55OE7d4I5zhKbhIJ/QqPS4zUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713899813; c=relaxed/simple;
	bh=rKJ3l5PngsMhhUsgGiBJulPEoC22NhzF9omTbh59/TI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rS6QNCwQjWZRbJwDl3XDOJlnECbjbCKEH1lB+taRwCahhja7rIlez4Y8+C3BQLqDI01/TY0L8JrYDrTRUGkGioBbVkdQhPDDyAyn0SnaTNsyaCS8/f5NJJZS+0LdV6fwmZ00T0xH0iv6JM5rFc2vCGeZzzMyqmohlPWnqaSUE38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cnyJSpdt; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ae63694954so2069885a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713899812; x=1714504612; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8B8BJDQiGUAbI0tZGCCPFyop6LA8Xy8bkwpS740fWe0=;
        b=cnyJSpdtTy358I3qXwRZOR0UkyGFGx7akqv6eOLaC4uZZgfLJ6vdUg6NKbsrU/hmgE
         3oRc87Nls3lX5EXG/tMfHyRrZ2PASYUXnwMXX48jTeYkzl2EGifKYzv+0T+BVnWpUIWX
         ikuqSatc4QLoPC5nsoo8ygJru5Cs6YquwMs0hQsEtt5UEC9DvdLgPZU6//0cSqbUn/X2
         C+g3sb5CUjC2CsYPpTYeVn9aoW2Jeb5rRq27m1tU0Fd1NpOuUp1taAjHYD6ApByS22zF
         E/CTHYuuvWPN7itfVNtwnK8OVN6UBh/K1AHpo1TYouPulANPreXtfm4LCs7sW8XgzhI3
         Iy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713899812; x=1714504612;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8B8BJDQiGUAbI0tZGCCPFyop6LA8Xy8bkwpS740fWe0=;
        b=LEMwXW/4H4SO1LAEX87MO+hzBOyp0tqO72+RDKDd3b3SoAfDYWdCpHEqx4ZLcT0vqu
         qDf25zCZEPbaT49FO59YhfESzepZjOf7BsgV0jXSLP7GCgiVBSviWS4F2WT0Kb6htAbl
         BF2cRY0lsBKqx2k1SQCbcKpRJoFzrm13m2xFTu/IhGCkneNYVHZ4vWcdmBzVwujE9TEL
         t6RRoqMgAsicgXWE52Ws124sppSVm63tIQ6pjTdvHUnCG+ncmDyr5rK5oKofhtiHYzWV
         oxUnOPHhSpKMh9UqlMorgrZ3Qe4BGwMrKYNpi5/xMIQFScdLYa8iVHegwnSgAZS2D8s6
         kMGg==
X-Forwarded-Encrypted: i=1; AJvYcCWeofZUBRzPkktxRDk4Jm/AOPZJtoAyDxSn3L6HPIBHhXUPjcfMeE5v8Arv/TPickKZ7zaGJFPnXCVntbR5K/3nO8JZyM4r47Sim3b5
X-Gm-Message-State: AOJu0YzlXcNX/dysGU+g4O8SIwvz+Z+UHQ/ME8nvY6Ch/n4cHWXkKlIh
	954uWpWCU0v9vvBVdqZiT56ESdHkWlArEokK73YVWeb5FXcx2CwBXoKiennJMfCn1UEEA9jVPOr
	JLQ==
X-Google-Smtp-Source: AGHT+IHc2Pkewcf/fjEyx1Ej8IWpt/3GzaBNYp2bJhAmBKboXze10z/yAFFif1JOzokxw7TZwp+xbvaMBRk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:8a95:b0:2a2:ff01:dd7c with SMTP id
 x21-20020a17090a8a9500b002a2ff01dd7cmr1330pjn.8.1713899811718; Tue, 23 Apr
 2024 12:16:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 23 Apr 2024 12:16:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423191649.2885257-1-seanjc@google.com>
Subject: [PATCH] Revert "KVM: async_pf: avoid recursive flushing of work items"
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xu Yilun <yilun.xu@linux.intel.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that KVM does NOT gift async #PF workers a "struct kvm" reference,
don't bother skipping "done" workers when flushing/canceling queued
workers, as the deadlock that was being fudged around can no longer occur.
When workers, i.e. async_pf_execute(), were gifted a referenced, it was
possible for a worker to put the last reference and trigger VM destruction,
i.e. trigger flushing of a workqueue from a worker in said workqueue.

Note, there is no actual lock, the deadlock was that a worker will be
stuck waiting for itself (the workqueue code simulates a lock/unlock via
lock_map_{acquire,release}()).

Skipping "done" workers isn't problematic per se, but using work->vcpu as
a "done" flag is confusing, e.g. it's not clear that async_pf.lock is
acquired to protect the work->vcpu, NOT the processing of async_pf.queue
(which is protected by vcpu->mutex).

This reverts commit 22583f0d9c85e60c9860bc8a0ebff59fe08be6d7.

Suggested-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/async_pf.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index 99a63bad0306..0ee4816b079a 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -80,7 +80,6 @@ static void async_pf_execute(struct work_struct *work)
 	spin_lock(&vcpu->async_pf.lock);
 	first = list_empty(&vcpu->async_pf.done);
 	list_add_tail(&apf->link, &vcpu->async_pf.done);
-	apf->vcpu = NULL;
 	spin_unlock(&vcpu->async_pf.lock);
 
 	/*
@@ -120,8 +119,6 @@ static void kvm_flush_and_free_async_pf_work(struct kvm_async_pf *work)
 
 void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
 {
-	spin_lock(&vcpu->async_pf.lock);
-
 	/* cancel outstanding work queue item */
 	while (!list_empty(&vcpu->async_pf.queue)) {
 		struct kvm_async_pf *work =
@@ -129,23 +126,15 @@ void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
 					 typeof(*work), queue);
 		list_del(&work->queue);
 
-		/*
-		 * We know it's present in vcpu->async_pf.done, do
-		 * nothing here.
-		 */
-		if (!work->vcpu)
-			continue;
-
-		spin_unlock(&vcpu->async_pf.lock);
 #ifdef CONFIG_KVM_ASYNC_PF_SYNC
 		flush_work(&work->work);
 #else
 		if (cancel_work_sync(&work->work))
 			kmem_cache_free(async_pf_cache, work);
 #endif
-		spin_lock(&vcpu->async_pf.lock);
 	}
 
+	spin_lock(&vcpu->async_pf.lock);
 	while (!list_empty(&vcpu->async_pf.done)) {
 		struct kvm_async_pf *work =
 			list_first_entry(&vcpu->async_pf.done,

base-commit: d2ea9fd98cca88b4724b4515cd4d40452f78caa8
-- 
2.44.0.769.g3c40516874-goog


