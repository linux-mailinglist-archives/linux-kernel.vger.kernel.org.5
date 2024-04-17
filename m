Return-Path: <linux-kernel+bounces-148491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798FE8A8364
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348BD282CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3143013D24E;
	Wed, 17 Apr 2024 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABLjXhEJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006D93D72
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358107; cv=none; b=DvxL1E/eEwq6jMJrdrJ/+yL4Q9pfC3EaxgIpXmCpBa2JUMFB8oIgRCwg/6OtA8AiB2JsUI8Q5Bk6QIHU1h4iLsWhslRP+I3vARZyNCkAxrrJ4xcUz9S8UnXbBjTqpInVY8Mgx1HVab0dqTv9s93nQgo7tAjv9B4BI2ei2wKDxfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358107; c=relaxed/simple;
	bh=+rBnuoxv9VlVOrTjCie1no0lsCBuIakPwhY4YqzQ+JQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+O6sO2QDxN2Yzk8jIgPHbitYbZdtqd1GygaPRScKJo2dNzvhZQeLI3sLO6ljhxr/Tiy4otcnrDEu8yRVehDKdvshc4+4g0cGnYQ2e5JdDRrbKrASOinyBcnrs39IvFz2brDSJgFJCcvRIP7EFkn9fLPRqka5rbknYX/D6A22J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ABLjXhEJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713358105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XsYlRw5sh/Id3XxML2Zd3Q4eq9CQ2fiMXrzcUrmGHw=;
	b=ABLjXhEJ4H5Eq7oJtg44jO1D9LTxgKQu9Py0tTga4ZdmTLy77Jnb4g8F58yqqouy+a5qB9
	pQcSZTfWIrcA/PrtNv8OYZKg/ux9BlZ77QgOYLmDlKqwgu1G4Lx0kixHuPHLmJ/bdLJYCm
	X0QF/T6iT5Pzt8b5U3t52jIJKks60w4=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-OjljCtHsN-OAs8jvS9iMig-1; Wed, 17 Apr 2024 08:48:23 -0400
X-MC-Unique: OjljCtHsN-OAs8jvS9iMig-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6ed5a1724b2so2681104b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 05:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713358103; x=1713962903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XsYlRw5sh/Id3XxML2Zd3Q4eq9CQ2fiMXrzcUrmGHw=;
        b=sVxz2pAcBTQ5w91QOSoAkG7Asuf/WVCWnE5G97OwCYkPRV9q5E9EVOjA7dPl4KRXAf
         cU+KUxffsRP99bIGvtYT8sNbrIdBcPoZ4ImF3eQodx4Jl8oesZT30Lc6WlXNUkhlGmsJ
         DoOBcg/6wqdqTnQSFWw+pFejaOPH3kdrllAMJoCkvc+sD7QLBf+0r4OpAwKeNrDxJEB3
         cbtemrCuPgCAqwvIMDuE7Z5S6N6C0tAC6RznSfwsjJGiuOra/KGxURaEtlc7ZBg6iLGW
         ttxsk+gAec6gnpHVk+DyzrsrWX426mjS5dQZQuoG7yQA6qEJUHeO6Asebd9GYCpsYAv6
         R1kg==
X-Forwarded-Encrypted: i=1; AJvYcCVRvkQj4J64lOaOzTDeROQPpP4sOUwLL1m7Y6NfW2FRkKUZPJTFTglMUFgMRVCMQkENIMLf/Si++byWYXUoDTv4LSW4XorRBT+CTy8l
X-Gm-Message-State: AOJu0YyliasRcGEb3OCtpDDer00SLmNjS/6H4XQOj5H2tNRS0ukCw+Th
	inPg24dE6LoPg8FHs7CVdNkwxemqrzBfHSPmMBuzbTpQc3VrY3mSpwUGaxpGza5Mj+qaiiSWz9l
	qOSUIPvRysiFYVwzK7H/4bH7ReKBrdR+7EvppO8clqG14GVu1dZzBKrgK6Q0cr/1Kyq9gb3xFty
	COa/Sq3piOSIj0j4SsoPKj/NyAqni5j3ydgYxI
X-Received: by 2002:a05:6a00:1145:b0:6ed:60a4:777b with SMTP id b5-20020a056a00114500b006ed60a4777bmr13933277pfm.8.1713358102773;
        Wed, 17 Apr 2024 05:48:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPWJ+3fFWpa9zfgX/yDQECXGExCP4Uxebsr47vLufIZ/BxxkIR9X35cFdJB6vwM4FQuq7CNfopgDLTm8yH2o4=
X-Received: by 2002:a05:6a00:1145:b0:6ed:60a4:777b with SMTP id
 b5-20020a056a00114500b006ed60a4777bmr13933250pfm.8.1713358102404; Wed, 17 Apr
 2024 05:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228024147.41573-1-seanjc@google.com>
In-Reply-To: <20240228024147.41573-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 17 Apr 2024 14:48:08 +0200
Message-ID: <CABgObfaS7RhUPe_FYS9SCuDzOfFw4X9P8XOhJSspVdzsYeoX2A@mail.gmail.com>
Subject: Re: [PATCH 00/16] KVM: x86/mmu: Page fault and MMIO cleanups
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 3:41=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> This is a combination of prep work for TDX and SNP, and a clean up of the
> page fault path to (hopefully) make it easier to follow the rules for
> private memory, noslot faults, writes to read-only slots, etc.
>
> Paolo, this is the series I mentioned in your TDX/SNP prep work series.
> Stating the obvious, these
>
>   KVM: x86/mmu: Pass full 64-bit error code when handling page faults
>   KVM: x86: Move synthetic PFERR_* sanity checks to SVM's #NPF handler
>
> are the drop-in replacements.

Applied to kvm-coco-queue, thanks, and these to kvm/queue as well:

 KVM: x86/mmu: Exit to userspace with -EFAULT if private fault hits emulati=
on
 KVM: x86: Remove separate "bit" defines for page fault error code masks
 KVM: x86: Define more SEV+ page fault error bits/flags for #NPF
 KVM: x86: Move synthetic PFERR_* sanity checks to SVM's #NPF handler
 KVM: x86/mmu: Pass full 64-bit error code when handling page faults
 KVM: x86/mmu: WARN if upper 32 bits of legacy #PF error code are non-zero

I have made a little hack for kvm-coco-queue, preserving for now the
usage of PFERR_GUEST_ENC_MASK in case people were relying on the
branch, to limit the rebase pain.

The remaining parts are split into a "[TO SQUASH] KVM: x86/mmu: Use
synthetic page fault error code to indicate private faults" commit at
the end of the branch.

Paolo

> Isaku Yamahata (1):
>   KVM: x86/mmu: Pass full 64-bit error code when handling page faults
>
> Sean Christopherson (15):
>   KVM: x86/mmu: Exit to userspace with -EFAULT if private fault hits
>     emulation
>   KVM: x86: Remove separate "bit" defines for page fault error code
>     masks
>   KVM: x86: Define more SEV+ page fault error bits/flags for #NPF
>   KVM: x86/mmu: Use synthetic page fault error code to indicate private
>     faults
>   KVM: x86/mmu: WARN if upper 32 bits of legacy #PF error code are
>     non-zero
>   KVM: x86: Move synthetic PFERR_* sanity checks to SVM's #NPF handler
>   KVM: x86/mmu: WARN and skip MMIO cache on private, reserved page
>     faults
>   KVM: x86/mmu: Move private vs. shared check above slot validity checks
>   KVM: x86/mmu: Don't force emulation of L2 accesses to non-APIC
>     internal slots
>   KVM: x86/mmu: Explicitly disallow private accesses to emulated MMIO
>   KVM: x86/mmu: Move slot checks from __kvm_faultin_pfn() to
>     kvm_faultin_pfn()
>   KVM: x86/mmu: Handle no-slot faults at the beginning of
>     kvm_faultin_pfn()
>   KVM: x86/mmu: Set kvm_page_fault.hva to KVM_HVA_ERR_BAD for "no slot"
>     faults
>   KVM: x86/mmu: Initialize kvm_page_fault's pfn and hva to error values
>   KVM: x86/mmu: Sanity check that __kvm_faultin_pfn() doesn't create
>     noslot pfns
>
>  arch/x86/include/asm/kvm_host.h |  45 ++++-----
>  arch/x86/kvm/mmu.h              |   4 +-
>  arch/x86/kvm/mmu/mmu.c          | 159 +++++++++++++++++++-------------
>  arch/x86/kvm/mmu/mmu_internal.h |  24 ++++-
>  arch/x86/kvm/mmu/mmutrace.h     |   2 +-
>  arch/x86/kvm/svm/svm.c          |   9 ++
>  6 files changed, 151 insertions(+), 92 deletions(-)
>
>
> base-commit: ec1e3d33557babed2c2c2c7da6e84293c2f56f58
> --
> 2.44.0.278.ge034bb2e1d-goog
>


