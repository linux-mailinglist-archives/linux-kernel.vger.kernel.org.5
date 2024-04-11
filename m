Return-Path: <linux-kernel+bounces-141703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5D38A222B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84CB3B22251
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577BE47A6A;
	Thu, 11 Apr 2024 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aWZcZKLB"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAD8D53C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877428; cv=none; b=LVae5uF1xJ5rIv+oYqz6SPZQuBkllvdCSfGazH78Eezf+k8OcZ62hKZ5qG2fen76HGVoXhZd02NUrSAYxffyC8jIUk0Cfk5+Ccrl1z9xYkrJammy0UkJG23Ow+a+Z95M1QAkYp+UfK+XmTQM7ihCMiJY8ZOwXL36zbdXoV+I4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877428; c=relaxed/simple;
	bh=BpVlVa98Ld8N5k9yDGC7wHjA38fX++HWC68Q50KplEE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dLZ+4DIvfIODL4qWl7lFyfdZuM5DG/xx3h1W5hLpWTbIgO29MGfHAzNxXJrxUybaUwpGMt/VTWqmzs7pyiMMXjB6oXAWbD7/AK3cvAYVR+x/H+Q+CFIfG3IdGafs7leHXEFKEbCy1yg/YYuWrlHlGRCjoO/W2pygGK/Iwzjov4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aWZcZKLB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e2be2a866aso3945815ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712877427; x=1713482227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaEKPQTfggD2ocO67Q/mDYf6kXhBuyVqa9iBD72w+wg=;
        b=aWZcZKLBn1y7sJMp2f7AVhsDaHqe2pAuwnpUz5r+6NnTbjbgIHxYS69qzAWbC9NnVR
         aGSVHYPL7GJsy2r0edzuB35fazSSSKkL/xU7n4eTfSJ7p4vb94xzOKJkKeFe/2iLq3Fq
         P3dhqhLNh7cJVPcKfwCX+PmD7UoogEgF1sr1/bo1k0oYfJbdMSxdsXdsnZ84EIBmdVj4
         XUbgzPfEhpdXrH2pG89w4v5WS1HRVvA1nmDFHYYtUhvSHTq7soWeSRsAPOXxZBbUXMHa
         GN9FOwSvBPFqZMRXvYDnG20QhEc2Sl+EVD5lSWVrENqxFbQNkmm9h9g3FnhJhrYnB1gr
         x4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712877427; x=1713482227;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaEKPQTfggD2ocO67Q/mDYf6kXhBuyVqa9iBD72w+wg=;
        b=DLj9mYj0kIzlynyByfuIvCp2e3EoDiZzQRYyDVimx/Kin+gqoXfIkgtn48m7h4gY5K
         1T71JB+6P3iJT6UPOzDsd/AIhgr5751m8uZqo+JCa7/7FiHBcxim1pNfcisSkoTk48xu
         /kA7CZHtNL1bGJu/h+6rfkZOOO59Dsb98L17zFEYyMw4j4AYtjDmOBAoqsaEhEwPcWib
         CR+Dd7GM0UvV+X92JkOK2Pr7BY0utFKlqJTXx0Z/4XEC/CnrsDMoP4Tzte8+fCb4NQVI
         JFF5lmrKSLLa+PNr8RbkQ8mgozOMWMpw62RTRxnzl9nSnOBDmV2KpjYUfn5JLR6kiy3p
         Ph+g==
X-Forwarded-Encrypted: i=1; AJvYcCWDCkzd40PABbumjhrrH0Q5qiljlZGW1vpK4jTjgr0N+M3ClBbz6ejts4b9G+GyE1CLpNJXKR4CFJqvS73Js8dbgza4xrvohdpczZ2E
X-Gm-Message-State: AOJu0Ywqs5jWgFzDv3GGmEIaGEAjQFqZPCwCpwIF3anI77ZQzh59Z/Sy
	DdQ1hsKeC8FNgIDiobJNbIiAz2P8nVbqBIbXvZPjg72P2NUsjoOFlxDBSidshNugwkpcjzfAVtg
	Utw==
X-Google-Smtp-Source: AGHT+IFkh8UwGORNfKAIhGU1TPD5433RiqkcctsyOHy6puas+6uDcvtX8qjhjvOj/SL+DVl0b2HUd131kpU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2444:b0:1e3:cf18:7336 with SMTP id
 l4-20020a170903244400b001e3cf187336mr3032pls.2.1712877426911; Thu, 11 Apr
 2024 16:17:06 -0700 (PDT)
Date: Thu, 11 Apr 2024 16:17:05 -0700
In-Reply-To: <ZhhucuZcaCKVPb5R@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com>
 <20240126085444.324918-40-xiong.y.zhang@linux.intel.com> <ZhhucuZcaCKVPb5R@google.com>
Message-ID: <Zhhvcd1R_uz_xbRU@google.com>
Subject: Re: [RFC PATCH 39/41] KVM: x86/pmu: Implement emulated counter
 increment for passthrough PMU
From: Sean Christopherson <seanjc@google.com>
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 11, 2024, Sean Christopherson wrote:
> > +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> > +	int bit;
> > +
> > +	for_each_set_bit(bit, pmu->incremented_pmc_idx, X86_PMC_IDX_MAX) {
> 
> I don't love the "incremented_pmc_idx" name.  It's specifically for emulated
> events, that should ideally be clear in the name.
> 
> And does the tracking the emulated counters actually buy anything?  Iterating
> over all PMCs and checking emulated_counter doesn't seem like it'd be measurably
> slow, especially not when this path is likely writing multiple MSRs.
> 
> Wait, why use that and not reprogram_pmi?

If the name is a sticking point, just rename it to something generic, e.g.
dirty_pmcs or something.

