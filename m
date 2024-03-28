Return-Path: <linux-kernel+bounces-122342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B3988F56A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB82AB21289
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9361EB55;
	Thu, 28 Mar 2024 02:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNqa5zBC"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331DF386
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711593351; cv=none; b=dWyoKF07/lGe2egrZG35tSqKRbhXaa1zcs0CsfmEGT9GRtqBDClt8saRc/GtLuanZXL4qoSRLLg7uG7gFqwA9J/9XsGAJUQ2SirTwrOulVk10MWHmhKamzhpqJQSy8RfjsAXYjFqBRUSAfX6rKNjLe1L8fUhy8xGlUQdvVsJmtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711593351; c=relaxed/simple;
	bh=0R24u452LaT2qzR1G87IGAYBRmr17XS5Gu2jDvqLnd4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UNkTbKnYzucWgXN/tlNIHh258UhnfaQ2/dn6IfalHV1fpRB7dHRb7oVC44IEcq4yTZI4D9Bwx2SMg5Wy7BLl6K0kkaM6H+iRta/O1FHgoWSDkWH0MNNdnDIVwZuyUjotFzNnuyWB6HjfBgrp+xuctgdpddvE7Y0VG32+n8KJZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BNqa5zBC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc4563611cso805426276.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711593348; x=1712198148; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tn1V7cT0/uugUJxaDzYA8tibaw31zbYQ1co3qQTHee4=;
        b=BNqa5zBCrXe42lqqvJGwD+94kl/rrRid6gMz8sj9UGEl/gV66mvS+gbUBbPI9EqbCV
         q6Bn5ooPkrul3xSV5fZPoTV8AqN89nj1G/Nlj1FZgpftgv5P+yQQkpFWcBq/7OE1jKaQ
         +DwUzsduPhXoQZTj+62gUzy9LepE6jU3csgroXLT5C/YurnTjg69YjUDzrFbF/Gi9z4h
         xJ+a3nGK2EUrb7wMJsM0B/VDSpDE2fnsGhdcZADgN/YvwhKD0g4DobdNrvQs3oNH/N24
         cqCGU0Bs7o5tUPvOGc0sNl9nHVh+8Rdyc275Ng2TAMYkNSnJ3jxyzYbTeBUGdNkSLIAc
         dRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711593348; x=1712198148;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tn1V7cT0/uugUJxaDzYA8tibaw31zbYQ1co3qQTHee4=;
        b=jVnlN2A74LTKkKJVshdajHCpuIAcm3b3M4+Bggtx26PBzqc4tAWiXlHhRA8becOaVK
         pcueLKmCCkvM8UW+1UjLqFfB7gf3XirlP2F5FT+vqa/jQItxDNPjaOhKUKhyoZy1ScP2
         L5dsWxfyctZRYYlyZJC5pqohy41LgiibEumvcQSyGSf3sVbtXHY/cWxtVNrnN+I0THnS
         L8Sottqa80kxjG0Lmctw/h3+JwnGAIvKUEK4ZVIN79b8g10jtawHrppOHvNTbWimjkUI
         nEGQCul42jPDo147CAcPGqKGScC+e05B2CmSzkSgSdDXgLy9XGjzMHZ0vOh55l7XM6RK
         TVIg==
X-Forwarded-Encrypted: i=1; AJvYcCVcjzcVOgk9A46c+iCA5K78qZ4BZtitYOj/MFQX0ccE+OUbIM4f7tvWiPDOZ9vwDx8yHscFldW+swL85dTZa6rCIKtLxxZ95ROQ512F
X-Gm-Message-State: AOJu0YxxzGhuIRu7zWscHhCJHFETsv84U9bHgOFwjf0PpDgJP/mmRL+o
	2TQyzVg5OYU/l+oefeU94sUTehd/46ry3t7/ad218tsnU+j9VyRF39V0SYf8Mjgqn/Td1HpDzkp
	7MWYSzW5/m6BBTUp3yqPDVQ==
X-Google-Smtp-Source: AGHT+IFmu/wyvjPJ86C2YpqmMzCjCxqoKynwb/5895KHOEbiGTXB3f51zjw8tqW3FQ608rm4NQTJd4dFZkDKVH6OPw==
X-Received: from ctop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:1223])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:1007:b0:dcd:ad52:6932 with
 SMTP id w7-20020a056902100700b00dcdad526932mr540194ybt.5.1711593348331; Wed,
 27 Mar 2024 19:35:48 -0700 (PDT)
Date: Thu, 28 Mar 2024 02:35:44 +0000
In-Reply-To: <20240314232637.2538648-12-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314232637.2538648-1-seanjc@google.com> <20240314232637.2538648-12-seanjc@google.com>
Message-ID: <diqz1q7vm6bj.fsf@ctop-sg.c.googlers.com>
Subject: Re: [PATCH 11/18] KVM: selftests: Map x86's exception_handlers at VM
 creation, not vCPU setup
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Map x86's exception handlers at VM creation, not vCPU setup, as the
> mapping is per-VM, i.e. doesn't need to be (re)done for every vCPU.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/lib/x86_64/processor.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 5813d93b2e7c..f4046029f168 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -552,7 +552,6 @@ static void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu)
>  	sregs.gdt.limit = getpagesize() - 1;
>  	kvm_seg_set_kernel_data_64bit(NULL, DEFAULT_DATA_SELECTOR, &sregs.gs);
>  	vcpu_sregs_set(vcpu, &sregs);
> -	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) = vm->handlers;
>  }
>  
>  static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> @@ -651,6 +650,8 @@ static void vm_init_descriptor_tables(struct kvm_vm *vm)
>  	for (i = 0; i < NUM_INTERRUPTS; i++)
>  		set_idt_entry(vm, i, (unsigned long)(&idt_handlers)[i], 0,
>  			DEFAULT_CODE_SELECTOR);
> +
> +	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) = vm->handlers;
>  }
>  
>  void vm_install_exception_handler(struct kvm_vm *vm, int vector,
> -- 
> 2.44.0.291.gc1ea87d7ee-goog

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

