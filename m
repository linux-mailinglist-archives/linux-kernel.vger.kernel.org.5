Return-Path: <linux-kernel+bounces-131888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D32898D30
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A881F2BB0B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B44012DD9D;
	Thu,  4 Apr 2024 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r7UDiK71"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D1112D1ED
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712251868; cv=none; b=mbF+9r9sVMUh/rDE3wCBegHFoWSJKjeaDU0Q/YabElgZTp7KbhvqP4gyCG9vr9YUejkKAhdUvb4Obg3lyb8MttRlxb16i3Lo9o8znUMIkvnpqQGOt+lr5AnLsJPBoAmmfBgUGNX66jctgsPx6ntOZlIujL69q4166AuTsNjc3XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712251868; c=relaxed/simple;
	bh=9+nALMnWqMtktQiKdj6h/JJPaQ9s+Le7L/1VmoPzmqY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pKR8tl2n4y0MpYJojh9vE9+FjT6rKa0rnwuquK950XcZxzLNWcVvmA43Dl7f5rvLnE8RMTF9Qx+kFkMCjCUSixDOVAHlR3TIgZoZLbDwa4fmCm32nIxI6chavdivYtx5f/+JqlaIhpxAlnGGJP8nD7lPewsz16DGRfdDM5cjK/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r7UDiK71; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-615073c8dfbso24259207b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712251866; x=1712856666; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eo/SkK+TlNjp4T3bV1tp4QVg1mYvFjNY2jevZHmIKp0=;
        b=r7UDiK71LM6DruG/FsIRIuqNzoW6t90LwF4qzeciOZZCTsSmReW6k1JHrPqJdQ9TDt
         oVxF6pmJrh3E9bEo5cXjj1lJmw4wpqotgNwCzFE4g4ms9wwvCeB3UfF4woGfJriTSUI2
         NNqSA9hvOLJBAjNe94PdfBnpOyk32fCRp+wK+40StG2SNVY9d8xhzfRvtZThS5UagBuX
         YCrfxYKSuzzy7c8JUkd3t6cVsRz34mEyStgNKzSdCS22WC0wQv6N5RrYURAnpCjbGCoY
         0dmD9+BojCjl/zTMutkoM1FZltaN21BlLPqpjw+z11oEOSZSAxnEjUwUdVsK8zUn6Y/i
         Os8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712251866; x=1712856666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eo/SkK+TlNjp4T3bV1tp4QVg1mYvFjNY2jevZHmIKp0=;
        b=T7s0I6Rjrlb9zg4XGQY8/FhOWwBYLbsal5Y2PRmfZjQlb2UMc97bdkCiKZyIz+uadd
         lw23fhgoSuQ7I+P/o6cIvY8jiQYHJCavoB4WJRT3nZcNKswZGp2YTbDxVdZxDKG0e5ym
         VX982WHXU1rz7hjTfkBvMmpo+QSt6vq1HdSeVoQSr+jKwDKoB5DFaMwmFLkoTkhBkmMe
         Ua/aEYTGCVXIZFu9ASqi/ou6C/pMEqo2Ki/0CgxatsBOGI0Gb/GiAXZme5q65wcKNzxM
         AMvM8aimJusfcgzuo6e35y979pl/f+9vToMuLJI/xGXk7TBN1L+8TRjV5FcGe+RaByQK
         WZiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0FA2tFLcHfIjBR2vP+1hp5lBUex8EOqvPbFP/7fghNTIo5tvgc6QzDVpQoqTItuv84VAVyYI3oVZfx5vwZ1nTkw+YyHduryG3dvav
X-Gm-Message-State: AOJu0YwNzHxXcYlljRJcLQQ5B5pCRmZ6Ac8zpFLMVoZvlMhTZjax3gIj
	SxhKu/ozDnUI7K7u7HtvH/kOBxmX0P6k5eCpQukAulNs1KWEI/gCMmSclwbSAiQgFFz2i5cSP1A
	A+g==
X-Google-Smtp-Source: AGHT+IGxpleOXBSwibp1OJgiAWgTAeCKVGrLENZB5db4WF5+xM6eEryutq9uucKSEKwloLFURA8Eo/IRbrc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2d05:b0:dc2:2ace:860 with SMTP id
 fo5-20020a0569022d0500b00dc22ace0860mr20394ybb.2.1712251866075; Thu, 04 Apr
 2024 10:31:06 -0700 (PDT)
Date: Thu, 4 Apr 2024 10:31:04 -0700
In-Reply-To: <42dbf562-5eab-4f82-ad77-5ee5b8c79285@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240320005024.3216282-1-seanjc@google.com> <4d04b010-98f3-4eae-b320-a7dd6104b0bf@redhat.com>
 <CALzav=eLH+V_5Y6ZWsRkmnbEb6fxPa55B7xyWxP3o6qsrs_nHA@mail.gmail.com>
 <a2fff462-dfe6-4979-a7b2-131c6e0b5017@redhat.com> <ZgygGmaEuddZGKyX@google.com>
 <ca1f320b-dc06-48e0-b4f5-ce860a72f0e2@redhat.com> <Zg3V-M3iospVUEDU@google.com>
 <42dbf562-5eab-4f82-ad77-5ee5b8c79285@redhat.com>
Message-ID: <Zg7j2D6WFqcPaXFB@google.com>
Subject: Re: [RFC PATCH 0/4] KVM: x86/mmu: Rework marking folios dirty/accessed
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 04, 2024, David Hildenbrand wrote:
> On 04.04.24 00:19, Sean Christopherson wrote:
> > Hmm, we essentially already have an mmu_notifier today, since secondary MMUs need
> > to be invalidated before consuming dirty status.  Isn't the end result essentially
> > a sane FOLL_TOUCH?
> 
> Likely. As stated in my first mail, FOLL_TOUCH is a bit of a mess right now.
> 
> Having something that makes sure the writable PTE/PMD is dirty (or
> alternatively sets it dirty), paired with MMU notifiers notifying on any
> mkclean would be one option that would leave handling how to handle dirtying
> of folios completely to the core. It would behave just like a CPU writing to
> the page table, which would set the pte dirty.
> 
> Of course, if frequent clearing of the dirty PTE/PMD bit would be a problem
> (like we discussed for the accessed bit), that would not be an option. But
> from what I recall, only clearing the PTE/PMD dirty bit is rather rare.

And AFAICT, all cases already invalidate secondary MMUs anyways, so if anything
it would probably be a net positive, e.g. the notification could more precisely
say that SPTEs need to be read-only, not blasted away completely.

