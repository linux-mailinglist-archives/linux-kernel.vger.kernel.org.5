Return-Path: <linux-kernel+bounces-84405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 708DC86A660
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED421F2572E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF12E12E61;
	Wed, 28 Feb 2024 02:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C2m9PwJG"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03D95250
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709086375; cv=none; b=qI3AMkJBzS9gks7q/+HNsh/hqG1ZnQ8HD0siyHxAMWxrpHKJGOwujsggzJYZAWOGyMojxpCqky73QoecUwUp0Kdl79AYvp8GdPz4e6xbDrHPOCDxdB0dGocxM2q3wbZvThcnwOK9htcMFn+zFEOgJGtaf3lfSqGu8JyRxrmBd0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709086375; c=relaxed/simple;
	bh=heHaKIN6sSWB6QKxW3jTLPXpvf+aV78DvVXemWiQhpI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UF7ma10L1lRHR3hQfFAKmRFW8p6RpF/Qt6zbcQa8NzKhJXNMITTJE3beyWiVp5gIz280Hi/qsZ4MnE8ot8mTeBhCAvxTSAYamsdYV0K6FwtXB6rZl8gW1UhMoiiIMMbMRF1s3ckSkKk/LCdIxfqr+G24IXFMmCmkigJD/I/QfOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C2m9PwJG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60905312b04so43687977b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709086373; x=1709691173; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ug25ooKz3qoCHEHw9pjGJUPzAeGvqTHR1DcTVlpibj0=;
        b=C2m9PwJGvRVjr+V8fUL4n4LmlEFrkP3b0CsAuhuvEjnrN4f+xfp5u7pZ/KpM0BJf1Z
         NNQ2PFcwE+XGh/qPgvPOqc4npFDyNQSBlcyFpryT2MXXscPBXeQuYB43y4cZwdKLx11Y
         85NQwQJxgg3v+eLCR2mrjGYLhbGogGPf9IrcrolmXksibWjyJhTqnDZAXdReAUDPne3k
         pFHGsVAbajj84CPx/Y4FK7VSYfLdjbqzyi5941uDYNXKYdwORJDVqhzREtO9VN7tfi/O
         QFXLCVxfOl04mvSOFV9nOtllVVug0AocJCXi0ES/pz+64An+PUTZb1OwAXncd0NBUvWf
         chOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709086373; x=1709691173;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ug25ooKz3qoCHEHw9pjGJUPzAeGvqTHR1DcTVlpibj0=;
        b=c3FhVOlyZrmRmBqGsHMSLtGp1uTuyq2ItoTG+vQRBl2pDwfypLh8jq94uxh0UQy2Uc
         TmRk3JtwsEuhIiX7p1LPaQ87r5NgiA+lp5gQwWDCsdJtmKvHUNO/ASLNNER9BbnrUUgD
         HOxnMD9Mz4PP1bE5tHK+67VKhuFTviBtx6HcNq30N7yI1qEtjcWNi8+lZ/1qu3Xr+nX5
         PbaVLnjRC+Kj4B/87IWEQ0udoQGGEYWk5vzrUvRHXRwaIA1nWQpzPmp/E6F8sZyv9nv9
         NjQ1ZazMdYxtRTqJkk9gR0hcCrgnOphJmmyoN5v1ejavX86ZiXwZ2Qb0n4HriGU9eJ6I
         CY+w==
X-Forwarded-Encrypted: i=1; AJvYcCVBPY/GtGacgeL232yAghcfClZtmz4R+e7L0jWDjdSd8femio2APEz3AT4IvP8rP9a/kVejL16WxxaeaOWPRUnqOVvRfTe/ZCPriD+s
X-Gm-Message-State: AOJu0Yx6WKoCHVC+YMT0KkiU9NSC454+dn+qPlCq1gm9X474aIh++6Hr
	ZzepzvJvrNWTBrREJCCKV9JsATJWjFU6nkJ7F2vgM2TUyhCCftAujknDj721qUIhOE6CO096Ujs
	+tA==
X-Google-Smtp-Source: AGHT+IEWMTeeW/rW6Q/Vg95tNiBAFAaIWQo0WCsJMra9fasHaexVBEMkZqZy6bCuf2Vx83BD3Y0c2GDEzj0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ab02:0:b0:dcf:411d:67b9 with SMTP id
 u2-20020a25ab02000000b00dcf411d67b9mr330040ybi.5.1709086372730; Tue, 27 Feb
 2024 18:12:52 -0800 (PST)
Date: Tue, 27 Feb 2024 18:12:51 -0800
In-Reply-To: <75d37243-e2a3-421a-b74f-ccbe307fef96@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223004258.3104051-1-seanjc@google.com> <20240223004258.3104051-8-seanjc@google.com>
 <75d37243-e2a3-421a-b74f-ccbe307fef96@intel.com>
Message-ID: <Zd6Wo0hQu11L4aPc@google.com>
Subject: Re: [PATCH v9 07/11] KVM: selftests: Allow tagging protected memory
 in guest page tables
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Andrew Jones <andrew.jones@linux.dev>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Carlos Bilbao <carlos.bilbao@amd.com>, Peter Gonda <pgonda@google.com>, 
	Itaru Kitayama <itaru.kitayama@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 28, 2024, Xiaoyao Li wrote:
> On 2/23/2024 8:42 AM, Sean Christopherson wrote:
> ...
> > diff --git a/tools/testing/selftests/kvm/include/aarch64/kvm_util_arch.h b/tools/testing/selftests/kvm/include/aarch64/kvm_util_arch.h
> > new file mode 100644
> > index 000000000000..218f5cdf0d86
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/include/aarch64/kvm_util_arch.h
> > @@ -0,0 +1,7 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef _TOOLS_LINUX_ASM_ARM64_KVM_HOST_H
> > +#define _TOOLS_LINUX_ASM_ARM64_KVM_HOST_H
> 
> Since the file name is changed from kvm_host.h (in v7) to kvm_util_arch.h,
> we need to update it as well.
> 
> Ditto for other archs

Ugh, nice catch.  I'll fixup and force push (likely tomorrow).

> > +struct kvm_vm_arch {};
> > +
> > +#endif  // _TOOLS_LINUX_ASM_ARM64_KVM_HOST_H
> 
> 

