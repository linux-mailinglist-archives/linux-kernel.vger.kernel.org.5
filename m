Return-Path: <linux-kernel+bounces-47363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E2C844CDF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F377A1F22A38
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3873F13D4E8;
	Wed, 31 Jan 2024 23:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="maibP1XV"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1533FB04
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743244; cv=none; b=gx3GT8ibOxEAV+ZS1VTDt8kKIAyo6E3Ob62zY5YZS/J8h+iRRSlQBpZV4r3zaI3kSaPH9SxrL4YuXC+kS7SRqNUdHuSo2YDh4qTmD6g9wUUQtfUjifgRi7xWklJr0E8Jv6xOIRkt26al+DR7nrdzbYJguDb40rSVyYYkd/E8dhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743244; c=relaxed/simple;
	bh=20/LowDbsSa6ybMupsfbqBknR9K6SfsjkkIXgL9bQ6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ubZjb1X3GaaCoIf78N/wNAzcN36Iul3/EfonWpZZUGqKJQqsQ/u8C1kEGk/aipq86RxpPhyCGWrBoXoGYgFVWMiXxMIcfejNMa0OYJHkHMe2OBR1EPGPaUI61PL2B8IhwQWxJyLJmsmeYtC+Tk0jzGERQHSbXtCiM3Z6HVqdPCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=maibP1XV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso510607276.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706743242; x=1707348042; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4LraT2XeL3rEGwAPZd0fqZsj1phEA9uuSczA3YvOZb4=;
        b=maibP1XVAla35TfYiIUBWF/dEUWpgk5ewEKDfXoe73KvSX3s7MIM+jbeUccinf6Ebg
         2QgkOl0nKBcVBa0g36EtuepTMQ2BJOenlxOTs2tPOXOF4Vrnn8UvH6eKtoPGvfYr51YL
         LumeYLCoS6peutkfubzxKWggQGtZbY4mhnCzY67I7DhYKC5Pa6Qoy2ktfmB+uIFsw/aG
         k/ev2kI24uIY76OVcU6HGgnDr6QvM0WqZfonlu+9oXrcEKFPsikqMkNa2EI8VW5A0GMR
         isYKBrQ4glYthh139Smt7aBD/tddrpcNv77oUzo4LcsKNLUnKXcxc2pOD14UbcMWRXOh
         0sMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706743242; x=1707348042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LraT2XeL3rEGwAPZd0fqZsj1phEA9uuSczA3YvOZb4=;
        b=cg56pMy8K0omppc8VhcV6ZcFK3Fze1kAAFPdw2zCKcOWzJWLxKEnBcNlXwXK8Rfncq
         uvvIR1BhOgau2HcPP5sjtxUXG/GDKwL2iljDsQ/vVAj5K2WkGYbTQXi18M84egwFdH46
         jlYNJJr8xv8SKd3aRCQP65lD6J1yWcDjvdmqqRxZRJCuORawgmqJC51f/CHlxNrB8R9h
         LQ63cHjiLR5n5Ogd8m6GGmUov1jNh9KBDJ3y0DpeAjGKzygdY93DBCs+mSPbaZXLmgIh
         D27uC8KZgvYiVdXk3iSOeC7DSADujbZwADGNjzC1KVF/17ujxRqZRjzVxOKonqBiSSn6
         +PCA==
X-Gm-Message-State: AOJu0YyY5ugmtnnFQFb+b9hMgsVztRvua6/0YnImmz4Cx8pZifjKSVZO
	XyiJI7kuD544T6FskA1RfMHyXrps7VYflwv216YqMuExumdcHEZaFQ9KA6NGXgsYNQBCgGQHu4v
	aKg==
X-Google-Smtp-Source: AGHT+IGN/AGCqkdJr6bpKzd1JOQ/JVcPRAqedMYNyR1G7Xg4nBku4fs5oM4yJkJ+BZj9xMDEHO8Wuiy2xjI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:920:b0:dc6:55ac:d08d with SMTP id
 bu32-20020a056902092000b00dc655acd08dmr832536ybb.5.1706743241894; Wed, 31 Jan
 2024 15:20:41 -0800 (PST)
Date: Wed, 31 Jan 2024 15:20:40 -0800
In-Reply-To: <20231102155111.28821-4-guang.zeng@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102155111.28821-1-guang.zeng@intel.com> <20231102155111.28821-4-guang.zeng@intel.com>
Message-ID: <ZbrVyB1Pj9KrH-Cl@google.com>
Subject: Re: [RFC PATCH v1 3/8] KVM: selftests: Add virt_arch_ucall_prealloc()
 arch specific implementation
From: Sean Christopherson <seanjc@google.com>
To: Zeng Guang <guang.zeng@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 02, 2023, Zeng Guang wrote:
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index a18db6a7b3cf..dbaa2cf83c1c 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -917,6 +917,23 @@ static inline void virt_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
>  	virt_arch_dump(stream, vm, indent);
>  }
>  
> +/*
> + * Virtual UCALL memory pre-processing
> + *
> + * Input Args:
> + *   ucall_gva - Guest virtual address point to memory of ucall pool
> + *
> + * Output Args: None
> + *
> + * Return:
> + *   Processed guest virtual address point to memory of ucall pool
> + */

Please omit the massive comments, they are yet another misguided remnant in
selftests that we are purging.

> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 6f4295a13d00..525b714ee13c 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -388,6 +388,18 @@ void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
>  	}
>  }
>  
> +void *virt_arch_ucall_prealloc(uint64_t ucall_gva)
> +{
> +	unsigned short desc_cs;
> +
> +	asm volatile ("mov %%cs,%0" :  "=r" (desc_cs));

Strictly speaking, CS.DPL is not the source of truth for CPL, SS.DPL is.  But
that's probably a moot point, because I again think this is a hack that shows the
overall approach isn't maintainable.

Can you post the actual usage of userspace selftests, i.e. the "full" series?
It's really hard to build a mental model of how this all fits together without
seeing the actual usage.

