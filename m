Return-Path: <linux-kernel+bounces-61311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2558510DA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9831F21FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D3918059;
	Mon, 12 Feb 2024 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLUyuWQc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC2182A3
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733809; cv=none; b=iE1KIosbdbFX6RZ3TXLfALSFf73bMZDMeufVdb8te01aBYYnzz5gZ2khgAZCwJ8IVEXBxCG7JN76fu6fFGQwH2S5l9iiroT426cQbtlV/Oig4B+Fdfwny6lbIKFnRjxRwIE5RgBwOhHKnIkKSoZ2GBeBHS+EpFTEI9lhqIgDRg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733809; c=relaxed/simple;
	bh=H7fKjnfkFZJqm1/uhc0nHamHeLBXPVOBRneRuCwvSDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwlEWD2Y3M2IFKoPgUIdcSZKJpEOPH3RzQOMG9DNlJ2xxlN5h2L0teY4mEcIUrOgkoLvTnkIL66XZSQ7knO+xv+pJyILUrmgittqxBbAGxclK12gJRH3DjXHXM58K3EcZRuuZ9/P9ikWXydUhJsAHh447COcsE0BZ5BvrxBgKqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eLUyuWQc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707733806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbEOSaawXH7zOkm7lWBcOWhVGmzO+y0LgNswENFILP4=;
	b=eLUyuWQcKDrvatiE1PRSRNfPYe89XStwpDhiHzoW2EmwmkyowHXCaU6biNbtD8G2pBe0fe
	vT9U9WOse87BbQCwSMgTSoYJ6ALaobFchBVdt9hdPVvb2uK/pefDSrSHTek2VBs0G+mMRb
	8HRqesBvzyCTlMcSZpFC+sHm3TcSfrY=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-vyDslhbbPgqyZIM_krQ6KA-1; Mon, 12 Feb 2024 05:30:04 -0500
X-MC-Unique: vyDslhbbPgqyZIM_krQ6KA-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-46d639c4883so622997137.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707733804; x=1708338604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbEOSaawXH7zOkm7lWBcOWhVGmzO+y0LgNswENFILP4=;
        b=qpfZPlkZ0t86zVr/CgOvbp5RzR6FsjdYPFr3hHu/8b6ImMqm2hTFL8kRYyC3euh5Mr
         Czbv4jsmeq8kjYGyiQr+w6c8NtauU+mWcnFh0M6Il6xIGGp0F4nfuTWryYTd1eQv+VXG
         JMi0GiX4oBTd2s9hv4Dbbb0IRKlTexWS5JCnJUc0voUZAejrX4K3VVjwUptiQdJ3FBKq
         VT1IH3ASm/5alBVoPaAsNOwPiFGsMY40/Ebtx7GFGn49EH3gh3ER6Nw0+e/ClgH6Z4Ez
         vf4yBt0Z6edVqzotfUD9G7Y59gzzCRSk/iVxSE3AKdrff06g7jCp1T56ZdYgEG70xSBd
         99Qw==
X-Gm-Message-State: AOJu0YzNlXXMETyFqG31VrPVPv7BNjSVjiFCrK1Qk5rB2roxPwhMk/e0
	QcRpjaiNz+/ysFXYkub5hl/YgH0nT3hZ6D1qoFkxgP9J9FWL+p6jzj2crIzDXDxDm7Nonzxn2p9
	YiFcCG5IKaelzMTy+tCUQI7jCXUZcQPPHedwXSxBKPWir006ACBHZ4FLuJFwIH8neEZvLzeYRsQ
	t1DihZDbsTkVCIYgNP2EFhQWnqm4XxX+XfjFhD
X-Received: by 2002:a05:6102:83:b0:46d:246e:93d3 with SMTP id t3-20020a056102008300b0046d246e93d3mr3339610vsp.17.1707733804263;
        Mon, 12 Feb 2024 02:30:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFY7xJxEY2WGHyVMc0RNCpzZHeCexMfOI7lUf7TYO6UzX1vkhyxPuvsqX/hjA+ycUtZ+Nz7RJd0pwH6JYaV5M=
X-Received: by 2002:a05:6102:83:b0:46d:246e:93d3 with SMTP id
 t3-20020a056102008300b0046d246e93d3mr3339592vsp.17.1707733803936; Mon, 12 Feb
 2024 02:30:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705965634.git.isaku.yamahata@intel.com> <cce34006a4db0e1995ce007c917f834b117b12af.1705965635.git.isaku.yamahata@intel.com>
In-Reply-To: <cce34006a4db0e1995ce007c917f834b117b12af.1705965635.git.isaku.yamahata@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Feb 2024 11:29:51 +0100
Message-ID: <CABgObfbZRO3yiXoHAoHSsBp4sKQY9r4GTLt-SRqevz2c8wOqbQ@mail.gmail.com>
Subject: Re: [PATCH v18 044/121] KVM: x86/mmu: Assume guest MMIOs are shared
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	isaku.yamahata@gmail.com, erdemaktas@google.com, 
	Sean Christopherson <seanjc@google.com>, Sagi Shahar <sagis@google.com>, Kai Huang <kai.huang@intel.com>, 
	chen.bo@intel.com, hang.yuan@intel.com, tina.zhang@intel.com, 
	Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 12:55=E2=80=AFAM <isaku.yamahata@intel.com> wrote:
>
> From: Chao Gao <chao.gao@intel.com>
>
> Guest TD doesn't necessarily invoke MAP_GPA to convert the virtual MMIO
> range to shared before accessing it.  When TD tries to access the virtual
> device's MMIO as shared, an EPT violation is raised first.
> kvm_mem_is_private() checks whether the GFN is shared or private.  If
> MAP_GPA is not called for the GPA, KVM thinks the GPA is private and
> refuses shared access, and doesn't set up shared EPT entry.  The guest
> can't make progress.
>
> Instead of requiring the guest to invoke MAP_GPA for regions of virtual
> MMIOs assume regions of virtual MMIOs are shared in KVM as well (i.e., GP=
As
> either have no kvm_memory_slot or are backed by host MMIOs). So that gues=
ts
> can access those MMIO regions.

I'm not sure how the patch below deals with host MMIOs?

> Signed-off-by: Chao Gao <chao.gao@intel.com>

Missing Signed-off-by.

Also, this patch conflicts with "[PATCH v11 09/35] KVM: x86: Determine
shared/private faults based on vm_type".  I think in general the logic
in that patch (which forces an exit to userspace if needed, to convert
the MMIO area to shared) can be applied to sw-protected and TDX guests
as well. I'm preparing a set of common patches that can be applied for
6.9 and will include something after testing with sw-protected VMs.

Paolo


> ---
>  arch/x86/kvm/mmu/mmu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index e93bc16a5e9b..583ae9d6bf5d 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4371,7 +4371,12 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu=
, struct kvm_page_fault *fault
>                         return RET_PF_EMULATE;
>         }
>
> -       if (fault->is_private !=3D kvm_mem_is_private(vcpu->kvm, fault->g=
fn)) {
> +       /*
> +        * !fault->slot means MMIO.  Don't require explicit GPA conversio=
n for
> +        * MMIO because MMIO is assigned at the boot time.
> +        */
> +       if (fault->slot &&
> +           fault->is_private !=3D kvm_mem_is_private(vcpu->kvm, fault->g=
fn)) {
>                 if (vcpu->kvm->arch.vm_type =3D=3D KVM_X86_SW_PROTECTED_V=
M)
>                         return RET_PF_RETRY;
>                 kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> --
> 2.25.1
>


