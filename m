Return-Path: <linux-kernel+bounces-50597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D54847B65
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680BA1C247C0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4F18175F;
	Fri,  2 Feb 2024 21:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K6X1dJBl"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9BA8063F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 21:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706908501; cv=none; b=EXLlqCvdzoiFtmC2HR7YHiU0rcBBoUVbqREHH3TZcXb/ebqqK//UJfxWKbfPcegOl9pz67xCUrtGWgDOh3RtkaW7uag5RaEPQil+cRoy2Kzwyc//26Nwq+TPcSE+uzov9jsbbVkIzbD5VMdukRXoJm7Cccv+w1msdDz5gzdV+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706908501; c=relaxed/simple;
	bh=WgxILiF//GwaDAUI2ya23z43c/S2iEAwu4PRQ9y0cAY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bSZq9gNpstV5kCrGZRue5+kow6KfoXIWmFgjY0ZFUfYT0sCg55t5RMrA1R2C94fLCXUH50K61BpYZq0BEUnwOQGoGR5NFixhEfNV3dC6fECrsSaPWHv6qoo7v1/552ctFrVJW+Eu+DzCOlEmKYb8Mph80VM+5MeMGOwrAEwtw7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K6X1dJBl; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cec090b2bdso2688850a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 13:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706908499; x=1707513299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uq7KIGo6ksoIAaNr+JZVlNnWKqprFhC+i/3sd4c5jr0=;
        b=K6X1dJBlCwndi4LNdjcIvUvZvMSJvoaCh2MEKpE29D7l/Yiu1fsEN5ib5hTVc2lB0M
         JZGePZQVrSv2Iz84jqpLry6B1pjZuH/P8x7ZUAnCQhdvjrcalyI57V+B3frJx5cnqzjJ
         mwROXz0Z0IsvoOM+MpLvy0XAY5cy5a43ffsoWRh7lOj3HOFTiyn/6LqtulUv8Yk/oyCL
         DQtOQEQk9XtdJLxIBDgySSkYc1/MbVlOL9yOluJsnlaicEiiTqHj1EukteVKOzv9FkvE
         EKKN3MJWFqbny+sZglzt1vdFA5rOVb2t8wahkn1hYKzHdozaWw2OICcH1YR6lZgOh3Jb
         +SzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706908499; x=1707513299;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uq7KIGo6ksoIAaNr+JZVlNnWKqprFhC+i/3sd4c5jr0=;
        b=h6VOchbwDOReQl8HdNwNbiKaUtbv1IwukYY2v6bZzSC8eEUjtogyI8pEoMNlfOZUI1
         oPnsI7xrHpP1N3v/9gEvzyfyOK9w5YFHx9NJqP+okOdoOSD8HSGedmcIvfUk9PfP7+b3
         HwoUqt9PJovjVIFtGmB0NOV6YEmQDCbnFhG4WBSKziB9ZvyrflBjsTL19TQ0iIvMLkoX
         kdH00iSMlkqjqUjJ8LTw5wbp1or/Q5mj7wtN1lR91s0r+zYAUBPl2Mu1NRkhvTDUwifD
         2CZEB7xJ3dtWxDgETRDuGkU/ni1OzgtSgDI1UcCWwmr6zfiOde32B1uTCd2yyEp3NR4x
         aTRQ==
X-Gm-Message-State: AOJu0YzFmsirVLhQyy4BHcuzbVKlY+9kjgWgsK+YXqXOcgZdKX67myGr
	Oz43C6uhApAf7JKWNOIslXSkDFFDuOlcj0gRcLsKWUoFwrCqAxyRR/a0LH+nQ5OEbLxCac4hXm4
	aaw==
X-Google-Smtp-Source: AGHT+IFVLmLkVXVVvZGLfIWrnCvRLCG+jeP6MsCJO3IsM6/mFibOyj9YkN3wYbHEizc9kSQGUkDAu580T58=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:91a:b0:5db:edbd:a2e0 with SMTP id
 ck26-20020a056a02091a00b005dbedbda2e0mr65596pgb.3.1706908498760; Fri, 02 Feb
 2024 13:14:58 -0800 (PST)
Date: Fri, 2 Feb 2024 13:14:57 -0800
In-Reply-To: <Zb0qaZ7iT0_8Rp7-@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202064332.9403-1-shahuang@redhat.com> <Zb0qaZ7iT0_8Rp7-@google.com>
Message-ID: <Zb1bUU4V6TYFZ972@google.com>
Subject: Re: [PATCH v3] KVM: selftests: Fix the dirty_log_test semaphore imbalance
From: Sean Christopherson <seanjc@google.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 02, 2024, Sean Christopherson wrote:
> On Fri, Feb 02, 2024, Shaoqin Huang wrote:
> > ---
> > v2->v3:
> >   - Rebase to v6.8-rc2.
> >   - Use TEST_ASSERT().
> 
> Patch says otherwise.
> 
> > @@ -726,6 +728,11 @@ static void run_test(enum vm_guest_mode mode, void *arg)
> >  		return;
> >  	}
> >  
> > +	sem_getvalue(&sem_vcpu_stop, &sem_val);
> > +	assert(sem_val == 0);
> > +	sem_getvalue(&sem_vcpu_cont, &sem_val);
> > +	assert(sem_val == 0);
> > +
> >  	/*
> >  	 * We reserve page table for 2 times of extra dirty mem which
> >  	 * will definitely cover the original (1G+) test range.  Here
> > @@ -825,6 +832,13 @@ static void run_test(enum vm_guest_mode mode, void *arg)
> >  		sync_global_to_guest(vm, iteration);
> >  	}
> >  
> > +	/*
> > +	 *
> > +	 * Before we set the host_quit, let the vcpu has time to run, to make
> > +	 * sure we consume the sem_vcpu_stop and the vcpu consume the
> > +	 * sem_vcpu_cont, to keep the semaphore balance.
> > +	 */
> > +	usleep(p->interval * 1000);
> 
> Sorry, I wasn't as explicit as I should have been.  When I said I don't have a
> better solution, I did not mean to imply that I am ok with busy waiting as a
> hack-a-around.
> 
> Against my better judgment, I spent half an hour slogging through this test to
> figure out what's going wrong.  IIUC, the problem is essentially that the test
> instructs the vCPU worker to continue _after_ the last iteration, and _then_ sets
> host_quit, which results in the vCPU running one extra (unvalidated) iteration.
> 
> For the other modes, which stop if and only if vcpu_sync_stop_requested is set,
> the extra iteration is a non-issue.  But because the dirty ring variant stops
> after every exit (to purge the ring), it hangs without an extra "continue".
> 
> So rather than blindly fire off an extra sem_vcpu_cont that may or may not be
> consumed, I believe the test can simply set host_quit _before_ the final "continue"
> so that the vCPU worker doesn't run an extra iteration.
> 
> I ran the below with 1000 loops of "for (i = 0; i < LOG_MODE_NUM; i++)" and so
> no issues.  I didn't see the assert you hit, but without the fix, I did see this
> fire within a few loops (less than 5 I think)l
> 
> 	assert(host_log_mode == LOG_MODE_DIRTY_RING ||
> 	       atomic_read(&vcpu_sync_stop_requested) == false);
> 
> I'll post this as two patches: one to fix the bug, and a second to have the
> LOG_MODE_DIRTY_RING variant clear vcpu_sync_stop_requested so that the above
> assert() can be modified as below.

Scratch patch 2, I'm pretty sure the vCPU worker can race with the main task and
clear vcpu_sync_stop_requested just before the main task sets it, which would
result in a false positive.  I didn't see any failures, but I'm 99% certain the
race exists.  I suspect there are some other warts in the test that would
complicate attempts to clean things up, so for now I'l just post the fix for
the imbalance bug.

