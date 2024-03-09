Return-Path: <linux-kernel+bounces-97960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C28E487725D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 17:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463E61F21396
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 16:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ED71D522;
	Sat,  9 Mar 2024 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TeivA6P3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F486BE4F
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710002977; cv=none; b=pU4w/ActRGoOuWVIG+kZ1ZesdG7ExKRAbrAUwF8d+GChT9IagroWOX3EolSphnXbiJKA+td87DEQtVXOZhAbMCHPraSLPjoCM7qaMQVz/QnYJceuLD6AwCbcG4VUJukZ6hIYiHf9hkPj9cV8wYTABaPP5PBGrl1pnTv9+CRTKyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710002977; c=relaxed/simple;
	bh=vEjrS5jTBnIZ5FzwO9lUX33siNiNs4wHlGKklMXdwVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i46x5DeXPWePQMV88I2Q4nUC6ibh9wUhgoXbcMNTz8fBTbv58faikkisR5PlPQCPq6M1qXy0NTrPtHlaKdBN20GozfznOWvUbcWpy0jYYrQxXHk+hiMeuNJDXByfDoHaqXpm0HmGjWipKwWDVfyNFkZcjzEcQ50d1yYYqgKgv4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TeivA6P3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710002974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hxzKd5BY5dUVKboeSWBZqfH96IBVGZX3rTxUjkAuefw=;
	b=TeivA6P3QuK/5H7e1xv8lQyucv2SgM2Ia4LEFsG8sXi9CeI3lNbtlf52PcnjD+tE+OCcjK
	2OzOwSNz3pGKO29V9/5ESdIXrgw10AGGPYAYf/FARMT+TzK4VU9P3kd1W1L/a+CIG3hj0d
	HsLkhtXPsU0fRJVmq1Srx4m/km0SIvU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-Gp_AZQ1GPCa5pOya6Z33vQ-1; Sat, 09 Mar 2024 11:49:32 -0500
X-MC-Unique: Gp_AZQ1GPCa5pOya6Z33vQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40fb505c97aso9203805e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 08:49:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710002971; x=1710607771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxzKd5BY5dUVKboeSWBZqfH96IBVGZX3rTxUjkAuefw=;
        b=Yw/40veIm8mAEUou7fCHWb8sWVrjJvqQWpM4eE0mruUkyn65Z9yrhYYxjawV2W19zp
         WQo7ziQcE0N8fdV98VyZd1knkT9p9SYIeTjsMJ/BVAZ3JhNjo//Mb6buPp2CazkreFCj
         uLYauJq9kC/nwv1nLjkBzSAEaw+9x+TNImGfHqpBPzkpf70HmoTTr7iLYCwSud+t0QdQ
         XH0eoEz7wrihqMRkZneRpHtmcpR61hvIE+81j56HeOXVZ/RW4x6r5okFPZ9oz0Rir8Y6
         0rtcPhuMW94gHtWtY3RwfdEhSUkPWpTtrsoouE2gzeiDbxpB8Do35X8QB2OA3ReRTFeM
         JCKg==
X-Forwarded-Encrypted: i=1; AJvYcCUt1cHBPk4no6RGGD7Efa86p50IGC/++KiN9O2o6k6UuR1+XaeFDQNuXgrL1okEPceqKrGSz+K3i7C1j+bOhsYbxpAvbAm+0gOTUcG4
X-Gm-Message-State: AOJu0YwcL3fvo4uA9Z6UxW9oVZ/YiiUDszah4AGN7C+ZyG1Xwj849x2p
	qZ4wJbzlvWOw62vhdsEHOoJvcXzn5vCRMuDzaZ279aUrinkb61NwEgDZgQ9/6wFgVbfkLxMntua
	up4jdo9tj9CHwklnQ3e/72D/rFiN80X+q1xUa2scrlu7EkKw70g6zU8Hr/7+k5ieAGC8yxRxPUt
	xIftrofcRLTrgG14+vHmA18IkQOYT+kKzZh7PN
X-Received: by 2002:a05:600c:4708:b0:413:1606:ba64 with SMTP id v8-20020a05600c470800b004131606ba64mr1760583wmo.26.1710002970952;
        Sat, 09 Mar 2024 08:49:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeFrOz4NEDXcHS/tILDPmiHsy4NjPvEdxzi2dFwo7mGr98s579GNUjAqDqDJUrZJcl3mwsZpbS0k/uTM4hFMY=
X-Received: by 2002:a05:600c:4708:b0:413:1606:ba64 with SMTP id
 v8-20020a05600c470800b004131606ba64mr1760573wmo.26.1710002970575; Sat, 09 Mar
 2024 08:49:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223211508.3348529-1-seanjc@google.com>
In-Reply-To: <20240223211508.3348529-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 9 Mar 2024 17:49:18 +0100
Message-ID: <CABgObfYjcP1hN-SZgCKBcoAStYAouRfzdGFdbyqhZMak6DKKCg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: MMU(ish) fixes for 6.8
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 10:15=E2=80=AFPM Sean Christopherson <seanjc@google=
com> wrote:
>
> Two more MMU-related fixes for 6.8.  The first, and worst, fixes a data
> corruption bug during live migration due to KVM failing to mark a memslot
> dirty when emulating an atomic access.  Luckily, our userspace caught the
> corruption during checksumming after the final pause, but I've no idea if
> QEMU-based VMs have such protection.
>
> The second fixes a long-standing, but recently exposed, issue where yield=
ing
> mmu_lock to vCPUs attempting to fault in memory that is _currently_ being
> zapped/modified can bog down the invalidation task due it constantly yiel=
ding
> to vCPUS (which end up doing nothing).
>
> The following changes since commit 9895ceeb5cd61092f147f8d611e2df575879dd=
6f:
>
>   Merge tag 'kvmarm-fixes-6.8-2' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/kvmarm/kvmarm into HEAD (2024-02-16 12:02:38 -0500)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-6.8-2
>
> for you to fetch changes up to d02c357e5bfa7dfd618b7b3015624beb71f58f1f:
>
>   KVM: x86/mmu: Retry fault before acquiring mmu_lock if mapping is chang=
ing (2024-02-23 10:14:34 -0800)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM x86 fixes for 6.8, round 2:
>
>  - When emulating an atomic access, mark the gfn as dirty in the memslot
>    to fix a bug where KVM could fail to mark the slot as dirty during liv=
e
>    migration, ultimately resulting in guest data corruption due to a dirt=
y
>    page not being re-copied from the source to the target.
>
>  - Check for mmu_notifier invalidation events before faulting in the pfn,
>    and before acquiring mmu_lock, to avoid unnecessary work and lock
>    contention.  Contending mmu_lock is especially problematic on preempti=
ble
>    kernels, as KVM may yield mmu_lock in response to the contention, whic=
h
>    severely degrades overall performance due to vCPUs making it difficult
>    for the task that triggered invalidation to make forward progress.
>
>    Note, due to another kernel bug, this fix isn't limited to preemtible
>    kernels, as any kernel built with CONFIG_PREEMPT_DYNAMIC=3Dy will yiel=
d
>    contended rwlocks and spinlocks.
>
>    https://lore.kernel.org/all/20240110214723.695930-1-seanjc@google.com
>
> ----------------------------------------------------------------
> Sean Christopherson (2):
>       KVM: x86: Mark target gfn of emulated atomic instruction as dirty
>       KVM: x86/mmu: Retry fault before acquiring mmu_lock if mapping is c=
hanging
>
>  arch/x86/kvm/mmu/mmu.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/x86.c       | 10 ++++++++++
>  include/linux/kvm_host.h | 26 ++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+)
>


