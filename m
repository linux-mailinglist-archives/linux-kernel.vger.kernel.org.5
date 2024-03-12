Return-Path: <linux-kernel+bounces-100427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 769FE879769
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3CC283CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214207CF01;
	Tue, 12 Mar 2024 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P1sGbSfh"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43B97C091
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710256905; cv=none; b=qgFwdOLC/VlMtQSfM1xUHpX9FktvFHbCgn8SAfqflj7HRaVl1vnf0Mpax5GxbhR99JvDme8gbTo+m8gzStswllBzVgZL98aPpApVkFyIMeC1nVACiucNMvfM/bwJZvlt9hkaf1nwUVE+xCFQsa5dNcb7seKpeF0Rj0bn6/gBWnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710256905; c=relaxed/simple;
	bh=l8cFlUqG6TeEDT2PHMu3g5kub53AeJTLgoJZqa8pOT0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JhGzH2uGRs6FlUmp89HaFZwjOmeXhTN7y6+LM3BMSFEV03n7RGj/1OrzjcChaghkMxabD84N3XEjebxH8mrC/1gELwCEJQPFgpEXDU840I1h73dbl4eWJK5fVO5gMOAOXzWhd0XZvi83UGcW6Rdqdz2+SxK9FaG72b20KWgWOJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P1sGbSfh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608e4171382so522217b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710256903; x=1710861703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3xjpLBn34GnxYZBQDEQ50UwfGqCy58xS1xpcBAoyhM=;
        b=P1sGbSfhGxtfKzqLTNw4dDv0ITGry/K5madExWbOdjCNvIEu6lkeYrUV1hM5uaMyvk
         RMzKx33OvXoNCa+oSlxLsfLU4P0ab5PbLQyIj4DVkXfqVaTCuCQFvqFlKXr/i1SxwXRe
         VsnFlL5gg0j0pseQ0Mix20aMSNoJcGccFsnf01HvFhm7SAKfMFGExwrs5dr6++HUJ08l
         llc/UQm6fIeLyBniw7w2Usb3dquxqoBboXBlTHMVbrFVaO+p7Qcv5Cs6dWfybfJ+cC4U
         lPwKS8USSgQfkhKIbKD1hz2YYdJ9djvhCj1yk1kTAPZLvnMRaJk8U7RXJ5fqC6+xPOc2
         AWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710256903; x=1710861703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3xjpLBn34GnxYZBQDEQ50UwfGqCy58xS1xpcBAoyhM=;
        b=iefA+wR2g6nc7PNMr5NuUVB9Xozv/nppJhnr1vZ6/T3fbrYLMFvPtt01WTWDGO2S+3
         EzkEtp1CXLtQ4PkB/tw6ne+ttcBy9akGgeU6p+yX53O+B1NAbReA1k+2lHt/26b+Xf2z
         tP7LeAbKsbJJ0WYNCx3zA9Qr2ksRbIiNEGw1wo4XvdrV55fAAzo5fGclkmj17VDP8RBA
         W1wNoQRJqQSHeQAkZnrJOOLXCNuuYf7KeZUlBL2LGbLGn+Ga/SCXg4F4qiSt06ygN8xs
         d6xcKPvpiTgzHxfrIi0Let+TQU3wOycBwtzvqJ3sj8BiJr3iWBeEZTp3/86mYreVVNVy
         F9ig==
X-Forwarded-Encrypted: i=1; AJvYcCUBQy8VzQTReIewo5Lp1a/f5kc1L1DbpIfahOsoCUgiPt4K5MfrwpZlKfzPLwAnX0B6qZK9iB1kwLr8lF9odOKMztoJggV15L6CzszJ
X-Gm-Message-State: AOJu0Yx+kMLHzfvuK7sdFAHpgSIqRAV8eGRiPlPNS9BbyzYBSa9XwC3D
	DQjtnomn+EgmXOZj/c2hOXxxzNqhK77fINdBRTrNdAHNBTeIQJCaFP37V2eGZWXkm3omY0pOsqN
	qNg==
X-Google-Smtp-Source: AGHT+IEDUQjk+iVnkL/nXvTeg23l7mhoANKZCGNMVf2KZPBX12mEpqSfgi1Oeu4NkHASdM5Ywuv4wUYOC98=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:bbd0:0:b0:dcb:fb69:eadc with SMTP id
 c16-20020a25bbd0000000b00dcbfb69eadcmr127534ybk.6.1710256902800; Tue, 12 Mar
 2024 08:21:42 -0700 (PDT)
Date: Tue, 12 Mar 2024 08:21:41 -0700
In-Reply-To: <tencent_AA5D14EAA36D58807959EE9AFC9E07548108@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <tencent_4B50D08D2E6211E4F9B867F0531F2C05BA0A@qq.com>
 <Ze8vM6HcU4vnXVSS@google.com> <tencent_AA5D14EAA36D58807959EE9AFC9E07548108@qq.com>
Message-ID: <ZfBzBUbxpF9MpII-@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: treat WC memory as MMIO
From: Sean Christopherson <seanjc@google.com>
To: francisco flynn <francisco_flynn@foxmail.com>
Cc: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, 
	hpa@zytor.com, rdunlap@infradead.org, akpm@linux-foundation.org, 
	bhelgaas@google.com, mawupeng1@huawei.com, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 12, 2024, francisco flynn wrote:
> On 2024/3/12 00:20, Sean Christopherson wrote:
> > On Mon, Mar 11, 2024, francisco_flynn wrote:
> >> when doing kvm_tdp_mmu_map for WC memory, such as pages
> >> allocated by amdgpu ttm driver for ttm_write_combined
> >> caching mode(e.g. host coherent in vulkan),
> >> the spte would be set to WB, in this case, vcpu write
> >> to these pages would goes to cache first, and never
> >> be write-combined and host-coherent anymore. so
> >> WC memory should be treated as MMIO, and the effective
> >> memory type is depending on guest PAT.
> > 
> > No, the effective memtype is not fully guest controlled.  By forcing the EPT memtype
> > to UC, the guest can only use UC or WC.  I don't know if there's a use case for
> 
> Well,it's actually the host mapping memory WC and guest uses WC,

No, when the guest is running, the host, i.e. KVM, sets the EPT memory type to UC

  static u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
  {
	if (is_mmio)
		return MTRR_TYPE_UNCACHABLE << VMX_EPT_MT_EPTE_SHIFT;

which effectively makes the guest "MTRR" memtype UC, and thus restricts the guest
to using UC or WC.

Your use case wants to map the memory as WC in the guest, but there are zero
guarantees that *every* use case wants to access such memory as WC (or UC),
i.e. forcing UC could cause performance regressions for existing use cases.

Ideally, KVM would force the EPT memtype to match the host PAT memtype while still
honoring guest PAT, but if we wanted to go that route, then KVM should (a) stuff
the exact memtype, (b) stuff the memtype for all of guest memory, and (c) do so
for all flavors of KVM on x86, not just EPT on VMX.

Unfortunatley, making that change now risks breaking 15+ years of KVM ABI.  And
there's also the whole "unsafe on Intel CPUs without self-snoop" problem.

> one use case is virtio-gpu host blob, which is to map physical GPU buffers into guest
> 
> > the host mapping memory WC while the guest uses WB, but it should be a moot point,
> > because this this series should do what you want (allow guest to map GPU buffers
> > as WC).
> > 
> > https://lore.kernel.org/all/20240309010929.1403984-1-seanjc@google.com
> > 
> 
> yes, this is what i want, but for virtio-gpu device, if we mapping WC typed 
> GPU buffer into guest, kvm_arch_has_noncoherent_dma would return false, 
> so on cpu without self-snoop support, guest PAT will be ignored, the effective
> memory type would be set to WB, causing data inconsistency.

My understanding is that every Intel CPU released in the last 8+ years supports
self-snoop.  See check_memory_type_self_snoop_errata().

IMO, that's a perfectly reasonable line to draw: if you want virtio-gpu support,
upgrade to Ivy Bridge or later.

