Return-Path: <linux-kernel+bounces-67455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45899856BBC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A43528D563
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0471386B5;
	Thu, 15 Feb 2024 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yTMCUNr/"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F551386AA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019881; cv=none; b=bQoylaX0qcTm/6pL8ISXx/ixZz5EbS/WrfI+IxPfeVpJaCojukbuSOHpKN3Yd9eZrSsVu+5Rk/6kPB2aYP+sbH6enWwEAdepOsuOSWk9YYlMgXOFaOC6cAbTHuuTCrGmOsfOjdR3zeNWJkfd3jI5B4uO3uxbhoU/qMjKrHMcAH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019881; c=relaxed/simple;
	bh=pBbPhTflFUG6wHN9o12IuzojR1JaaY/ff6CYDQHeD7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nh+14yc7B/RcFrKJM99tzO2+2HIY9Y0paY6IrOBfDVtR2905LUrt2M8RF376E6zuBbLSSe1CuswM3U3w0Fbd8h9cuOEoeVOTs0zMnp0ncA3D/xvBlAjIjbgW1Fo8WRCBBQb+KqpzMRBaga8pmA9QFN33EL2L9rq+kUxON2+HO7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yTMCUNr/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-411a5b8765bso7192315e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708019878; x=1708624678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpqTtw6FYrW3PoFuWsqUH7t3JUAVgmdouNuTTew3X4Y=;
        b=yTMCUNr/4KwtsP4+kfFodczTFFFdY3YeO9sMr+PvazdgVxC5jGwGmu8mL/HTVMOmyJ
         Va+m01Z5YsJxa1M9bqDaeRCBy0AUj8t8Uy+0z3/JPHoh4fT460sSGIZCBH2U+oU8xrq3
         BCVT4g7KUIxfYOtA86L4ITyyUyIl1k8y0+oIX3/OAFHZ3oJVB5JmRSu96KA0l5E5ARin
         WpjD06JmbgoLDmivTsBPOHt9KvvFIYquCe7yFE8kZ7aBc+XTMfZpRY/L8N8qs6+AvQs8
         l9iH0o3y31Cv6pLb4sNWixt5qv5zrc4ZMgNwHUhlzJ/QACd44IzQDO8lTKzRODxa7CcC
         L2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708019878; x=1708624678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpqTtw6FYrW3PoFuWsqUH7t3JUAVgmdouNuTTew3X4Y=;
        b=vF7NSDHO8JIrUB+7Ep/l4sWnvZ1knnA54VZX9LVmMikuW9jZ2vjdeL0K0likWVq829
         f2sWPEmbx25VAnX87yVXoeZwAsigYbyQLfBZpEQrz9vvHXcWvXcSNMzshWZO2ZzYsfTa
         DLBvZCu1fUL6VO7AKdcoECZyAXWHpwJEY86Mi1wtzshvJ3//TopJzcZPIfSw1jvd0NAA
         kNXmPUjaSsR1gTRGW1dW0PFgRTx8G/BC5yQD7IVy9cqET1hdHjX+gEniRegiE8PiPuRR
         pZV9hGWY46/NxbTbjKkkiaxULUZ10gtr4xkCpc18c7IlGsUTlZRw816s/jVhlih2sy79
         pULw==
X-Forwarded-Encrypted: i=1; AJvYcCW2XLma6i5XbZGGFjZJMTG2f311ZzYmJ7hgjH3R6/ZAF64P/OeJbmPvt5maC6WlBsPuEqj3TTWQUwKhE/rSnU770t7VXZDJ0fMPlVYT
X-Gm-Message-State: AOJu0YxaIhQ16FAAdWlxtpCjSemRvruDzxkfPHIZYgFr2nH5AwAOY/z5
	+4kBMp9sNRSx3WrWPoZz4ydENjGAvTj3mauTHUiRiMzw4WcsHYzEX7yBtdvyO8zX5NXoUJRq+UB
	8lrJBI/qHgEl9elsm0+ujZLOvI9fqZHf8mRon
X-Google-Smtp-Source: AGHT+IEp6ui6I2cesALfvxXVIbye1QcTH0l5ylN0OoIRmAT/rFJ/jWZYvt1ckNWO8K0z1iI+7MukerEQbd4EctdVzRY=
X-Received: by 2002:a05:600c:1d16:b0:410:e91d:fa6c with SMTP id
 l22-20020a05600c1d1600b00410e91dfa6cmr2266070wms.2.1708019878367; Thu, 15 Feb
 2024 09:57:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215010004.1456078-1-seanjc@google.com> <20240215010004.1456078-2-seanjc@google.com>
In-Reply-To: <20240215010004.1456078-2-seanjc@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 15 Feb 2024 09:57:29 -0800
Message-ID: <CALzav=c0MFB7UG7yaXB3bAFampYO_xN=5Pjao6La55wy4cwjSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: x86: Mark target gfn of emulated atomic
 instruction as dirty
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pasha Tatashin <tatashin@google.com>, Michael Krebs <mkrebs@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 5:00=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> When emulating an atomic access on behalf of the guest, mark the target
> gfn dirty if the CMPXCHG by KVM is attempted and doesn't fault.  This
> fixes a bug where KVM effectively corrupts guest memory during live
> migration by writing to guest memory without informing userspace that the
> page is dirty.
>
> Marking the page dirty got unintentionally dropped when KVM's emulated
> CMPXCHG was converted to do a user access.  Before that, KVM explicitly
> mapped the guest page into kernel memory, and marked the page dirty durin=
g
> the unmap phase.
>
> Mark the page dirty even if the CMPXCHG fails, as the old data is written
> back on failure, i.e. the page is still written.  The value written is
> guaranteed to be the same because the operation is atomic, but KVM's ABI
> is that all writes are dirty logged regardless of the value written.  And
> more importantly, that's what KVM did before the buggy commit.
>
> Huge kudos to the folks on the Cc list (and many others), who did all the
> actual work of triaging and debugging.
>
> Fixes: 1c2361f667f3 ("KVM: x86: Use __try_cmpxchg_user() to emulate atomi=
c accesses")

I'm only half serious but... Should we just revert this commit?

This commit claims that kvm_vcpu_map() is unsafe because it can race
with mremap(). But there are many other places where KVM uses
kvm_vcpu_map() (e.g. nested VMX). It seems like KVM is just not
compatible with mremap() until we address all the users of
kvm_vcpu_map(). Patching _just_ emulator_cmpxchg_emulated() seems
silly but maybe I'm missing some context on what led to commit
1c2361f667f3 being written.

kvm_vcpu_map/unmap() might not be the best interface, but it serves as
a common choke-point for mapping guest memory to access in KVM. This
is helpful for avoiding missed dirty logging updates (obviously) and
will be even more helpful if we add support for freezing guest memory
and "KVM Userfault" (as discussed in the 1/3 PUCK). I think we all
agree we should do more of this (common choke points), not less. If
there's a usecase for mremap()ing guest memory, we should make
kvm_vcpu_map() play nice with mmu_notifiers.

