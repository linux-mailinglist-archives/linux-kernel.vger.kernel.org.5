Return-Path: <linux-kernel+bounces-85963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F273586BD9F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67FF2B2666C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163F355E51;
	Thu, 29 Feb 2024 00:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ry6vHJpd"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF2F2D051
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168142; cv=none; b=ppDblMUx/t7jk0j7uba14tXHa0t6bTY7NRQkqSiMtToqMqDzrA67DFxvk+EJEeUA5AJ65hRdbXQ4jF1tnAxyxahz3ZgGYODYy0TQkCF2eWDBrTESOYMJpjYsZRsMkc4jrk1HhSbezPc6Hh34VWWW/24VM+FUHtrhakXDVXNVMhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168142; c=relaxed/simple;
	bh=i6eHilJBW3eqkl1QuCHLL88/9qCtvwmmijhDpn1hbzE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B6MVu5jQqLMf5y1AIK5fZJ0GlwemakhjaIvOqlX52CQQ7JUqpb0xcc3Y4PxzZact1o0iM2Ke19tqfGzBGzRFuk05vhoSf+SyQuViXxhQIOCMA2fFzuOE4GzNkmVQJ1kSN/l3TkBqBBmGvtTeC5pnBLofFanvWHPXA/24tHfDwZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ry6vHJpd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-299cae4f36bso247816a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709168138; x=1709772938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eliV97qbvjzlWA6WTHOIiPM9PEq5O0yXOeFOONF3xgI=;
        b=ry6vHJpdDdYiKlwAWpC8vMAukyPbaD+CVeKJevP24TZ+XayMDosxX55EEiMAu5cgE6
         Ic88IKKx0wosyDKT2THLTdtrfzCTjBLuPX+Q50IgjqHFdxzER229cDuvbW0XfMP8ic64
         1VSERDBnmIhn5aWeTiamvkdj9G8btJhD+r6NWAltDR6naA++ArUVlcY8dILPAl5TbD5r
         DLzM7lFLIsyy7Wapv5mLBP9Eqa1Sm9gmUDjALVrdrnUbFo7Okb0VcE1L5dv6Qv2hwIXo
         Soq3/X12WhkmGy+qU1pxsayoWD9IOWweVg9klN7aZVgE2QVstxojbt7Yr9NSzWMRABo4
         85sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709168138; x=1709772938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eliV97qbvjzlWA6WTHOIiPM9PEq5O0yXOeFOONF3xgI=;
        b=M/lo673FLBNY7LehWx0zKl56xRK7vZwc6dZAjOxihmzBRsCOa7ztu/289neScOyxG8
         3J9kBTjvKE88zOS5R0TGztXJPRcqmCVAuHdGVXuAUzO4Y6yd2hDXtXzVQ7IgRuBB4jj9
         8z3JYK6eFiLrjR43PkYLd2fU60D7gCXlHtrdU82PhjM2llqer7f3GyHQuqwxbSEcizti
         DMgI9lGIMwt7KYiNiBpG9lGpK9+IqZvdC5SZ4ULcrZL2WUn8fxqYsVLUDm0lNOjOewWt
         RW1BYjGVi0d70Z8tCNpkfgO3+zilp3Wx2gO0mZD2Sw50FuNQ04Ktpvaz2BkNYiu8BLvx
         mL9g==
X-Forwarded-Encrypted: i=1; AJvYcCXkc76wxgyZtpXoZmndKQGnglf+3sitMIqgmbBIcYZSnztJdhdUi7pgBz940iY4Dr3kS5SZ8AO935bW9BZoBZ52hvvQHvI5fh+6upIm
X-Gm-Message-State: AOJu0Yzf3hA2ns1+YwHJCAQu1wHtTAwJIh2oauf7pIPc5AO75amnOPhu
	RSWy0lQQG3QffixSBGceTyMgEa52a5tU0MAKrzfEp1TgjMV4UyJS+GD8hNpjUCFdFOy+tZj+p7u
	MIw==
X-Google-Smtp-Source: AGHT+IGzoolXH5/Ep5baoVnZ7lanocljLeHRfew+WA071KUPfkGU9QcYsHqkuQzMw7/1VGlx+YyYgvht8/s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1b49:b0:299:dbe9:353b with SMTP id
 nv9-20020a17090b1b4900b00299dbe9353bmr2092pjb.9.1709168138371; Wed, 28 Feb
 2024 16:55:38 -0800 (PST)
Date: Wed, 28 Feb 2024 16:55:36 -0800
In-Reply-To: <Zd-2VK2kvMr_t1jx@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223004258.3104051-1-seanjc@google.com> <170900037528.3692126.18029642068469384283.b4-ty@google.com>
 <Zd-2VK2kvMr_t1jx@google.com>
Message-ID: <Zd_WCJtlPpJVDcyg@google.com>
Subject: Re: [PATCH v9 00/11] KVM: selftests: Add SEV and SEV-ES smoke tests
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Andrew Jones <andrew.jones@linux.dev>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Carlos Bilbao <carlos.bilbao@amd.com>, 
	Peter Gonda <pgonda@google.com>, Itaru Kitayama <itaru.kitayama@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 28, 2024, Sean Christopherson wrote:
> FYI, the hashes changed due to a force push to squash a bug in a different
> series.
> 
> [1/11] KVM: selftests: Extend VM creation's @shape to allow control of VM subtype
>       https://github.com/kvm-x86/linux/commit/126190379c57
> [2/11] KVM: selftests: Make sparsebit structs const where appropriate
>       https://github.com/kvm-x86/linux/commit/35f50c91c43e
> [3/11] KVM: selftests: Add a macro to iterate over a sparsebit range
>       https://github.com/kvm-x86/linux/commit/57e19f057758
> [4/11] KVM: selftests: Add support for allocating/managing protected guest memory
>       https://github.com/kvm-x86/linux/commit/cd8eb2913205
> [5/11] KVM: selftests: Add support for protected vm_vaddr_* allocations
>       https://github.com/kvm-x86/linux/commit/d210eebb51a2
> [6/11] KVM: selftests: Explicitly ucall pool from shared memory
>       https://github.com/kvm-x86/linux/commit/31e00dae72fd
> [7/11] KVM: selftests: Allow tagging protected memory in guest page tables
>       https://github.com/kvm-x86/linux/commit/bf47e87c65be
> [8/11] KVM: selftests: Add library for creating and interacting with SEV guests
>       https://github.com/kvm-x86/linux/commit/bdceeebcddb8
> [9/11] KVM: selftests: Use the SEV library APIs in the intra-host migration test
>       https://github.com/kvm-x86/linux/commit/8b174eb9d289
> [10/11] KVM: selftests: Add a basic SEV smoke test
>       https://github.com/kvm-x86/linux/commit/faa0d7027de3
> [11/11] KVM: selftests: Add a basic SEV-ES smoke test
>       https://github.com/kvm-x86/linux/commit/974ba6f0e595

That didn't last long.  I forgot that I needed to change the include guards in
kvm_util_arch.h.  New-new hashes:

[1/11] KVM: selftests: Extend VM creation's @shape to allow control of VM subtype
      https://github.com/kvm-x86/linux/commit/126190379c57
[2/11] KVM: selftests: Make sparsebit structs const where appropriate
      https://github.com/kvm-x86/linux/commit/35f50c91c43e
[3/11] KVM: selftests: Add a macro to iterate over a sparsebit range
      https://github.com/kvm-x86/linux/commit/57e19f057758
[4/11] KVM: selftests: Add support for allocating/managing protected guest memory
      https://github.com/kvm-x86/linux/commit/cd8eb2913205
[5/11] KVM: selftests: Add support for protected vm_vaddr_* allocations
      https://github.com/kvm-x86/linux/commit/d210eebb51a2
[6/11] KVM: selftests: Explicitly ucall pool from shared memory
      https://github.com/kvm-x86/linux/commit/31e00dae72fd
[7/11] KVM: selftests: Allow tagging protected memory in guest page tables
      https://github.com/kvm-x86/linux/commit/be1bd4c5394f
[8/11] KVM: selftests: Add library for creating and interacting with SEV guests
      https://github.com/kvm-x86/linux/commit/ae20eef5323c
[9/11] KVM: selftests: Use the SEV library APIs in the intra-host migration test
      https://github.com/kvm-x86/linux/commit/69f8e15ab61f
[10/11] KVM: selftests: Add a basic SEV smoke test
      https://github.com/kvm-x86/linux/commit/be250ff437fa
[11/11] KVM: selftests: Add a basic SEV-ES smoke test
      https://github.com/kvm-x86/linux/commit/40e09b3ccfac

