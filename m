Return-Path: <linux-kernel+bounces-94092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783478739D5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DFEF28806D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BF1133981;
	Wed,  6 Mar 2024 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xaGCm/iV"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8E013473B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736822; cv=none; b=HL4PjHabJ/UBMY79eDfQuma5KNOcpzZ039Ia4TnH/xkquLuYYFUh8F32KpWGnvWy/zJ6RuNOpioTPG8ijMaFhj7UYMvSGDts1h6TmW1p2yENaoitue/AD7VeAJe92MpCdTghSYkHzHjmW4xwQrnzz7VwAmVGEq+6tpBS9C2zIbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736822; c=relaxed/simple;
	bh=4qDDeM2GJDKd/s57z1lZPEZLMCakZLt6IBfNNHqraZo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iAfSP22HeErw59pWtaIPxZToIXpuLNlN/3bIL60k82g8X73fAUd60tnDqa76HFE4edlws7I67ldzM1SJozSi7AsrRWaxMSrJuD/MqZDm8eVEjN/mefBayqOlO/APm/9HTuWFptjTKLNmZ06RozzNoQFTU5QnqWlCk2g5Hk/Jn6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xaGCm/iV; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1dbe41ad98cso70065785ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 06:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709736820; x=1710341620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXZjsUmARj2Dgx8DrIwjJBZxc3BuQgEpxgkrz4sv/pc=;
        b=xaGCm/iVAkFOmYzkhR9T1TZBAWllldeizDKIalZpL5LN9aktu1TFGqBrqzH7Tzntzo
         6NTV8dlRed2/vDCPaJNabQC1yKK9pp8b8q+DdqoEMv+b2Tw93ll6C3/zB3GR/Rc1Q6BN
         r0ypmxvFi+lAR58oqv/H9AHnPydsOJ2b+gE7D0y8ewfUMf+pLGu/2J94SYrOtttoDxcD
         Vngdy1bO4t96VRDUmc3bsxUgA2odKd5lKU6/3fdyJrurrJbAH0JCxHYMOBoPlt1YqtAo
         ifXGQ4dU92koNbY3dA4AjC9nBgXMSy39bAmpHHI/K6WHC52Zx2Jc/kK4jkyPHRvJoV8t
         f5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709736820; x=1710341620;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXZjsUmARj2Dgx8DrIwjJBZxc3BuQgEpxgkrz4sv/pc=;
        b=C4XIYlFH8IMJg4SDfVFTNAycPVyY7eXgDYbAel++P2okSpwqWAl3KqBMW8Vr+xAYy9
         /rXSTXA7XK4AJcCjLEDmai6JZWgx2yd137R9zlQKAwZ6bpfPg/k6GtzdavJS2gwFJ5hk
         mtzg0Csgl/IeulrdPF3omAXZzcfCo/vWv/eSrY1CSqbjojUdOlNQFReTnBCUXTcYVVmF
         67Zdte7w1oQdp0/sh39PH5pd1umaR8GtlJ3cNXIu7Lox5KdU7X/Rn2Yvjiu91qEjJUfJ
         SmvTp+77FtAzi4+MjkIXiWiKOQRK1UHFU5u8/dVxW1blhlCjN7t35Wep7Be0BvTr4DlB
         qKQw==
X-Forwarded-Encrypted: i=1; AJvYcCXuL9Ia6hE34WNYJmXpkt8dgoaN4KL+GwyxpB/vQ5J7yuxzlG1H6xI3JVNvyeojqgK0mBUuVfHKoQwAy/+y/eDnzGafPm88wttkIrC3
X-Gm-Message-State: AOJu0YxN/olTKvpPy9tS9pdd7kwLwVyAvpTtZtAmUGrE74Imgl6Ge9QH
	a737/54iTCDUGI+0iLIdjzvLFYndEKtvQDFk5eRX+qw/VtHG95hHpmPlCE7BGk5fBytBDpvdh8E
	RZQ==
X-Google-Smtp-Source: AGHT+IFag51vL/UvoYhlWt+cP5hn/hFVKq6JWZ8TC7/r3Y68GfcXp0uRyzr/BSVM0D4aSJiRiUKQoyXIzXc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3507:b0:609:3c79:dbf1 with SMTP id
 fq7-20020a05690c350700b006093c79dbf1mr4263672ywb.8.1709736332428; Wed, 06 Mar
 2024 06:45:32 -0800 (PST)
Date: Wed, 6 Mar 2024 06:45:30 -0800
In-Reply-To: <Zeg6tKA0zNQ+dUpn@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228024147.41573-1-seanjc@google.com> <20240228024147.41573-6-seanjc@google.com>
 <Zeg6tKA0zNQ+dUpn@yilunxu-OptiPlex-7050>
Message-ID: <ZeiBLjzDsEN0UsaW@google.com>
Subject: Re: [PATCH 05/16] KVM: x86/mmu: Use synthetic page fault error code
 to indicate private faults
From: Sean Christopherson <seanjc@google.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 06, 2024, Xu Yilun wrote:
> On Tue, Feb 27, 2024 at 06:41:36PM -0800, Sean Christopherson wrote:
> > Add and use a synthetic, KVM-defined page fault error code to indicate
> > whether a fault is to private vs. shared memory.  TDX and SNP have
> > different mechanisms for reporting private vs. shared, and KVM's
> > software-protected VMs have no mechanism at all.  Usurp an error code
> > flag to avoid having to plumb another parameter to kvm_mmu_page_fault()
> > and friends.
> > 
> > Alternatively, KVM could borrow AMD's PFERR_GUEST_ENC_MASK, i.e. set it
> > for TDX and software-protected VMs as appropriate, but that would require
> > *clearing* the flag for SEV and SEV-ES VMs, which support encrypted
> > memory at the hardware layer, but don't utilize private memory at the
> > KVM layer.
> 
> I see this alternative in other patchset.  And I still don't understand why
> synthetic way is better after reading patch #5-7.  I assume for SEV(-ES) if
> there is spurious PFERR_GUEST_ENC flag set in error code when private memory
> is not used in KVM, then it is a HW issue or SW bug that needs to be caught
> and warned, and by the way cleared.

The conundrum is that SEV(-ES) support _encrypted_ memory, but cannot support
what KVM calls "private" memory.  In quotes because SEV(-ES) memory encryption
does provide confidentially/privacy, but in KVM they don't support memslots that
can be switched between private and shared, e.g. will return false for
kvm_arch_has_private_mem().

And KVM _can't_ sanely use private/shared memslots for SEV(-ES), because it's
impossible to intercept implicit conversions by the guest, i.e. KVM can't prevent
the guest from encrypting a page that KVM thinks is private, and vice versa.

But from hardware's perspective, while the APM is a bit misleading and I don't
love the behavior, I can't really argue that it's a hardware bug if the CPU sets
PFERR_GUEST_ENC on a fault where the guest access had C-bit=1, because the access
_was_ indeed to encrypted memory.

Which is a long-winded way of saying the unwanted PFERR_GUEST_ENC faults aren't
really spurious, nor are they hardware or software bugs, just another unfortunate
side effect of the fact that the hypervisor can't intercept shared<->encrypted
conversions for SEV(-ES) guests.  And that means that KVM can't WARN, because
literally every SNP-capable CPU would yell when running SEV(-ES) guests.

I also don't like the idea of usurping PFERR_GUEST_ENC to have it mean something
different in KVM as compared to how hardware defines/uses the flag.

Lastly, the approach in Paolo's series to propagate PFERR_GUEST_ENC to .is_private
iff the VM has private memory is brittle, in that it would be too easy for KVM
code that has access to the error code to do the wrong thing and interpret
PFERR_GUEST_ENC has meaning "private".

