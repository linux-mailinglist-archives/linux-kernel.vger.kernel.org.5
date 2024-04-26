Return-Path: <linux-kernel+bounces-160449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5199F8B3D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073351F213A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E95715B579;
	Fri, 26 Apr 2024 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uYmLCNzX"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BC06FD3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714151341; cv=none; b=RaKlMCtCBTopHPjlqn4Xpj3e0SeLPfodWemh5L46WPtZiWUx3X8T+mNy12AgXmCV5oycCpk/6hREg/nldTLqQqyLum7u49wML+rjX+LhYOW888NAHH+zcuYX6oS3UjfIa2c2okGsya/r7mKFVNcr8pAFaO22gU0B7Cm9nAWQNYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714151341; c=relaxed/simple;
	bh=/u+/VUHRstaeZlxjhr9IFqEbnV2hgYn2kTvggjqqTRc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gUiSYOUqtuZPRpXoHTnVGzn7ujx0hCrKL0lQT90y8KTrofA/mQSnfeFuYkuZeWBNXZEKiClDHui0UtFJO5bv163KXxuapGa+psFvlHqkItsrtxDBEAKATtrYiBPx5RpmxY+mC7o2SS1d9+ALLLDnKHt2+Zz0JRVo7nkn1Kt2a5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uYmLCNzX; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-60f089b3ac4so352768a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714151339; x=1714756139; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J0ICtEdh31VCqgmnJdIJar3kOHqlyDRMqt7YndTJd5M=;
        b=uYmLCNzXz7jBQBVK1opEhoIoSZX3z7jYkK9tW+bh/PH4qLIkXBidYzK4e8b1ldVKH3
         Cp0BJgR4Yc5n9zKhDftnOLgn6lxIymyuxHPCv0QSGtUbSSnwBMLlntSil8tinVzCkW4j
         DgMHbq/zX6fSmvdYN3jUy/hRTyWmODLtB4t9u3OPbpO7kYdoOd7oMtCbkocamIq0tA4+
         lVBTmtNCPWCaoEmNJX+mK/7i3Amg6iLxjVdsV9ZeTjUX2vVjOdbZJK3VoJ98mrukWqrW
         QIo8A8LmBlpZGcwc/YgmAVM2GujEs4luVNCbWNNyBCUxnCvISfjMj8LXrYBMr1DrwihA
         ygxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714151339; x=1714756139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J0ICtEdh31VCqgmnJdIJar3kOHqlyDRMqt7YndTJd5M=;
        b=PGhZr00ROMXMlvznlJJK4WbpPU0ebhAa1e419j3OSqzAmTdJH6siBaLSPWgxpVYmhp
         bHncXIWsid9GL3cVXZGKiJgFTSmx4sbCLJBuwBzCFgzgnky1jYn1LseTtPGB6Xxvfi23
         EInP8FKtFLuMd0sFLWowk5dRIFkAnr4EihftICyYOljaP26vOacrAc70riOxiMVo+840
         TFfunauoCvpQhkEVos+Ruwe4szPgvhN5qprA2lLNrRoFkm1NXa9h5E/h/JPqXxCJ1qy+
         UPqgjY7S5Fi/Y21PhCIhfF0w+U2D2HCtF8LdlhdhF5Pj/r1mFHYxiCExwPCHgINukXMB
         Ymzw==
X-Forwarded-Encrypted: i=1; AJvYcCVBseh735lN8RXh4a22RS+jDe8mRT4rw+2h8tCh0uBAAj2Iea2WORJnk3b1bhfwHRo/aQg1ZXXS4VeWVq8+gXR6TBMqMreGK8Y19c17
X-Gm-Message-State: AOJu0Yy8qyaRMbrzybrppkmY3SV+WjL1n806kDVBGxhkvX75W4Cg75iN
	iQ4E7zoVz+o/fUuM65YWbBT8hgAH13S8w+LYreLCcnu4+5BpnN6Z9gRXK5snLr+KCoJaZuGSpyM
	lew==
X-Google-Smtp-Source: AGHT+IGN4vuhhXu6RHaKsQDssSGbwGUwHoIe3QpHFtYc97Yq/BzD4QZntnxHirq8V1PdJAs18Y57hXAU0Tg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4cd:b0:1e4:7bf1:52b with SMTP id
 o13-20020a170902d4cd00b001e47bf1052bmr697plg.7.1714151339477; Fri, 26 Apr
 2024 10:08:59 -0700 (PDT)
Date: Fri, 26 Apr 2024 10:08:57 -0700
In-Reply-To: <ZitrMAplXSCKrypD@chao-email>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425233951.3344485-1-seanjc@google.com> <20240425233951.3344485-3-seanjc@google.com>
 <ZitrMAplXSCKrypD@chao-email>
Message-ID: <ZivfqQysu2hXHHFG@google.com>
Subject: Re: [PATCH 2/4] KVM: x86: Register emergency virt callback in common
 code, via kvm_x86_ops
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 26, 2024, Chao Gao wrote:
> >diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
> >index 502704596c83..afddfe3747dd 100644
> >--- a/arch/x86/kvm/vmx/x86_ops.h
> >+++ b/arch/x86/kvm/vmx/x86_ops.h
> >@@ -15,6 +15,7 @@ void vmx_hardware_unsetup(void);
> > int vmx_check_processor_compat(void);
> > int vmx_hardware_enable(void);
> > void vmx_hardware_disable(void);
> >+void vmx_emergency_disable(void);
> > int vmx_vm_init(struct kvm *kvm);
> > void vmx_vm_destroy(struct kvm *kvm);
> > int vmx_vcpu_precreate(struct kvm *kvm);
> >diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> >index e9ef1fa4b90b..12e88aa2cca2 100644
> >--- a/arch/x86/kvm/x86.c
> >+++ b/arch/x86/kvm/x86.c
> >@@ -9797,6 +9797,8 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
> > 
> > 	kvm_ops_update(ops);
> > 
> >+	cpu_emergency_register_virt_callback(kvm_x86_ops.emergency_disable);
> >+
> 
> vmx_emergency_disable() accesses loaded_vmcss_on_cpu but now it may be called
> before loaded_vmcss_on_cpu is initialized. This may be not a problem for now
> given the check for X86_CR4_VMXE  in vmx_emergency_disable(). But relying on
> that check is fragile. I think it is better to apply the patch below from Isaku
> before this patch.
> 
> https://lore.kernel.org/kvm/c1b7f0e5c2476f9f565acda5c1e746b8d181499b.1708933498.git.isaku.yamahata@intel.com/

Agreed, good eyeballs, and thanks for the reviews!

