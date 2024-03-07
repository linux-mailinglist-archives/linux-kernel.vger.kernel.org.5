Return-Path: <linux-kernel+bounces-94796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17C6874554
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8251C21C7B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF86D4C7C;
	Thu,  7 Mar 2024 00:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qYL/uWqR"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE00E1859
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 00:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709772828; cv=none; b=oBP7ewrGT2vf+q4mN8Yvp/RhxSUaqecSLr2kaW1DmSC5JmA1DZH8gb9/ESHqAUXXCNa7HedJjAn60d37OJ6vNH+D4mqRQMVNhbtncNlAg36imAttCWsjYcAPh16UZWe0gDuJNt9ziCZdLzvqb03P1LNeki25MIgN6IrI9sv/ocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709772828; c=relaxed/simple;
	bh=5a/K4Sl1FUS7oq60ekNERF2iXFSv3DJI7QNsBj3/nFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i10j2DsoFQsiGebxOjfVtm70pq6AdvCS35NGbNzA756SLIxJi+CYEQlLTShoDDeCun65IfDoDoLleAdgcZEEJTrXhZoGkCjf/CYfaYADhNz6cRBE9sMtA9WVIJO2uWiM13A+ZMYCSi3GQn0PDHgmvObUgm/QdXGF0Fp96dkWZSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qYL/uWqR; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5dc90074016so284125a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 16:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709772826; x=1710377626; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=13JM4dn5oLawZvcGqOUh0FKLknmM5OO13+s6TUK67SM=;
        b=qYL/uWqRYfRXAJCaIezmM3j9JaQzznvy1x4cB/7jYWaQM/h/yWFYb8rs31WNLR2ctW
         QHl0RR/XxPo8It0EGAZwBUlzkrZNW3nJD4A/2ffQyz1496f1UPjP5cloclVw37uEh8tW
         e/rTbTn4ngCckwNj/h99lw4qKAkZbjmGmqiXDMUrh60ScTeD5E+7Ndow1dxzuje7J9ob
         WDBTWnwdVlpXYmw2vTQEI2GN22lEV1X7yyibD0CiwvubtAF/LdCW5cRswK/DhR9A2hjR
         +65vy4E3ZM32hNQaeN8riR57P4M/0K5lfrhZbN/jqTUjaX77mba+CtCfHJWewMR9ov5T
         SzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709772826; x=1710377626;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13JM4dn5oLawZvcGqOUh0FKLknmM5OO13+s6TUK67SM=;
        b=mWTkhUZ19zqPwqWoyxfGO8NamarkgYwIwP6rxFz+JT4lec5M+FpUgK//nb7baiw8Dx
         Q6UiIvoI0f/auufDj++5xeQkn0vIOw/r/zTh60/04oJiPya9ftXk2pOK82D+zJabytIt
         rL6sS69yt1V/wCeToMpGhmoRXxvE5iub+wBXqzDTtAuru1q9eFFIHg4uu9bDFYlu0LLb
         I2CbErBP2BjVgFOTYMHNv3/sn5tLRo72nIhOkx0HETkyuT6DUKyEvo9ip6i9PwDSQc8D
         8nPq3Tuw7nWqkhuFE+HctDwIpFrnLQvAlgabJgkJOIGJem4RIqUlbtnIoV5lLQmNcmaC
         D0Kw==
X-Forwarded-Encrypted: i=1; AJvYcCU3gbo2LFMtjyGItxZjKqJJA8oxrW5vkS3y7O9SirFrIKNvF3J/H/oCGND0zOBku6AWyKVRsKoS8MhliXkQQvhVFLGuWcWNCpArQJy7
X-Gm-Message-State: AOJu0YyX2xp58sPv4pMZd8iJBocD+8FjEHGjhbUi2+fgUes3vTH6rbjf
	oWfZVlxT/+pAomnDjOPD0a7SnUewK+0Bze/PWglcTj3wxEHbE77vianOxxv+ncjbOja0H2jqox6
	g4Q==
X-Google-Smtp-Source: AGHT+IEOis2Z/A2Rk3zVzgay5WAqcSG5X9JevTM43hdYFp0yDzRzI+2V1NgOIQ2StNbL0Xtfu4AKG73nMbc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:b8b:b0:5e4:5fba:17e with SMTP id
 dh11-20020a056a020b8b00b005e45fba017emr42501pgb.4.1709772825909; Wed, 06 Mar
 2024 16:53:45 -0800 (PST)
Date: Wed, 6 Mar 2024 16:53:43 -0800
In-Reply-To: <d325e811-c80d-49ba-85cf-06893cec659a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228024147.41573-1-seanjc@google.com> <20240228024147.41573-14-seanjc@google.com>
 <d325e811-c80d-49ba-85cf-06893cec659a@intel.com>
Message-ID: <ZekQF9MlVzlgleq7@google.com>
Subject: Re: [PATCH 13/16] KVM: x86/mmu: Handle no-slot faults at the
 beginning of kvm_faultin_pfn()
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 07, 2024, Kai Huang wrote:
> 
> 
> On 28/02/2024 3:41 pm, Sean Christopherson wrote:
> > --- a/arch/x86/kvm/mmu/mmu_internal.h
> > +++ b/arch/x86/kvm/mmu/mmu_internal.h
> > @@ -235,7 +235,7 @@ struct kvm_page_fault {
> >   	/* The memslot containing gfn. May be NULL. */
> >   	struct kvm_memory_slot *slot;
> > -	/* Outputs of kvm_faultin_pfn.  */
> > +	/* Outputs of kvm_faultin_pfn. */
> >   	unsigned long mmu_seq;
> >   	kvm_pfn_t pfn;
> >   	hva_t hva;
> 
> ... how about get rid of this non-related fix?

Eww, yeah, I'll drop it.  I originally had code that made the outputs valid if
and only if @slot was non-null, and had updated the comment accordingly, but
ended up going a different route and cleaned up the comment a little too well :-)

