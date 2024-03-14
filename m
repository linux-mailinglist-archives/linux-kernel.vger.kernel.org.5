Return-Path: <linux-kernel+bounces-103848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC7D87C565
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5821C2827A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C864FFC0E;
	Thu, 14 Mar 2024 22:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mbophuYk"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12AD28FA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 22:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710456991; cv=none; b=hGnXn9d3Wq7kHjvNILVe4DIX29jIFJkO8+9xRMU9hstR+h085xYaCbsJilT1wkz3AdVltGyAm6w0cUJZ98oBt72/yaBacs13C6Sw9pmSo91ZrZD64oB6kNFBQgWggrycT4IeMo/EukDidkyzfAYoI79sDWoIXcxnwSb6dJZRi10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710456991; c=relaxed/simple;
	bh=zUGwVd0Yv0nkOSW9GUHRgOk7KhLFU9jjeRUEPHTKrY4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T0FvsaYLjoLeZxTLs6LaJEinsJ+wwehZj2vvIH0Z9V9HRS8PrvQmZC7cisP4ejcsk7cOlIQ7PNSZK/H8BNTna5oiZ2hO9+qyYBoaYDaekoahDgC4DOL7tj5FGBwUd2CeTeEqkCPfL5iQYyGIF4Gj4w3aruOR8vU00v+Bw3HrxhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mbophuYk; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e6bf91a8dfso1596473b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 15:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710456989; x=1711061789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XbqpstRtYQ8JkMb3zpP7dCjT/ZA8dEtLsJkyinUWLF4=;
        b=mbophuYkBhPIA2DdTdZXvjo0Omt1x10Its4SdYzox4K6eCR/cHNo/TmJ9tK6BMu3Hz
         32qWQRQaJaIAnuANjSHgt0wp4CQfHggheHwyuHHy52XrXbX5YDL2AZDsjbjViz3NHrIS
         U7eUaSQeUh4VvzK6R2FUhxdN7TKGUFsMfOL3VCGakOIliK1F4OZysnmVcX1ldpsCOWDi
         NPzhUa2GVYK7EM0FzknllQZ0HNhso+mX8gYkdcv4wqPzh0ZuoDKtLmsu8U8z58WmkYrU
         738wIoKGl3NQaHVQ7JuqwkJiAHfzZuZJ0HEZ614ZjkeWCb4dONYLcme2s214+sLTyQwn
         r60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710456989; x=1711061789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XbqpstRtYQ8JkMb3zpP7dCjT/ZA8dEtLsJkyinUWLF4=;
        b=pvF1gQItgABnsdtlyn5uH6j7vFMXyy4i/5g6R+0+Qdv1ILwVvWrHj532rR0Ah0QnTx
         LriNaFKYruROzCTgnemxnpSX2JEeZZC4zQuCdlz2arkhZsz5xTD4oLLsvR39bcl9ECM4
         pADK+Hm9Kf8v9ujez4I/QbXky2Tq5MDqV15MF3849ps+BZ0mluE/ttTwlBNwkRyl0AV7
         ZRddM3LG2ldeLTVNz0mJTUSOvyH0CuC4tZ58Sof+LyA79G/TnHE/L2ZpKgj5DxxFQevS
         Y6aWIR7/t4VUL+ux+cXXGbhF9oAJ+w4Ua5BUHatrK9nqqTKeE96PZ7PsuNKPlk1x96/W
         CXnw==
X-Forwarded-Encrypted: i=1; AJvYcCUXRDhDwqHgk1YyOyTW/IoeYNpQNK/vf4g5e+SLmMuw76atQWSD/tW2xFmIhLGTeeQToV6+68xaEhjjTQbhdNwKtkCURSmQkGPr2mMw
X-Gm-Message-State: AOJu0YzCol7HZISGRIMbloQCOO1pVlOuuUwOQLjxwlbPzYBDEa1r5NdA
	hFIe7I/lXMQdufQYzFKTdo+nmbqTWLx16ktWpH2kJh9Wsemaj+hRQbn/Pebdm4zhi69tK/0lFxV
	/Jw==
X-Google-Smtp-Source: AGHT+IHL1nGWRPUt2Oy0hxjclaJNlV5M3ONGqW8lRTubyLes97erS22uxfuXyy1x83TcEl2bg5Z3zG2zvOA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d18:b0:6e6:c38e:eaa7 with SMTP id
 fa24-20020a056a002d1800b006e6c38eeaa7mr137828pfb.5.1710456989038; Thu, 14 Mar
 2024 15:56:29 -0700 (PDT)
Date: Thu, 14 Mar 2024 15:56:27 -0700
In-Reply-To: <20240314220923.htmb4qix4ct5m5om@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226190344.787149-1-pbonzini@redhat.com> <20240226190344.787149-11-pbonzini@redhat.com>
 <20240314024952.w6n6ol5hjzqayn2g@amd.com> <20240314220923.htmb4qix4ct5m5om@amd.com>
Message-ID: <ZfOAm8HtAaazpc5O@google.com>
Subject: Re: [PATCH v3 10/15] KVM: x86: add fields to struct kvm_arch for CoCo features
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	aik@amd.com, pankaj.gupta@amd.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 14, 2024, Michael Roth wrote:
> On Wed, Mar 13, 2024 at 09:49:52PM -0500, Michael Roth wrote:
> > I've been trying to get SNP running on top of these patches and hit and
> > issue with these due to fpstate_set_confidential() being done during
> > svm_vcpu_create(), so when QEMU tries to sync FPU state prior to calling
> > SNP_LAUNCH_FINISH it errors out. I think the same would happen with
> > SEV-ES as well.
> > 
> > Maybe fpstate_set_confidential() should be relocated to SEV_LAUNCH_FINISH
> > site as part of these patches?
> 
> Talked to Tom a bit about this and that might not make much sense unless
> we actually want to add some code to sync that FPU state into the VMSA
> prior to encryption/measurement. Otherwise, it might as well be set to
> confidential as soon as vCPU is created.
> 
> And if userspace wants to write FPU register state that will not actually
> become part of the guest state, it probably does make sense to return an
> error for new VM types and leave it to userspace to deal with
> special-casing that vs. the other ioctls like SET_REGS/SREGS/etc.

Won't regs and sregs suffer the same fate?  That might not matter _today_ for
"real" VMs, but it would be a blocking issue for selftests, which need to stuff
state to jumpstart vCPUs.

And maybe someday real VMs will catch up to the times and stop starting at the
RESET vector...

