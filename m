Return-Path: <linux-kernel+bounces-147033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA6C8A6E74
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED8F28469A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3556C12FF9B;
	Tue, 16 Apr 2024 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1TgyPa11"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1171CAA6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278110; cv=none; b=hTYL+CZ3W5NFQfKzR6rlKo4lSBVQ8qJLVSXHufwLNVhwHlf3d0cjq3yFKZ49UDrwoaaxH1cEi6MElte90xiTuTC76Iam3sx/5jy5Mq7Pmym6cmGTMYbwYqRpCoSXowkwmy+wCoBkLeVKfBL9ih4NJZYiyL2wiN3wK89VqYaApik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278110; c=relaxed/simple;
	bh=5b+5hL9rPyKMRHu+Iqgp1IW1oazXi33cdzJZvnSCXnA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GIyatWcGcXpwjsP6udjrL4JPQYW+PtGhIYe5alD0lj1+tbbUZpb5sDArS2WuX15B5VH6p6PgRxO2W2KcHJHONCG9LIfkA2F8TnERzxfacwCSlHQGuJ4q8SEc9gJIfwR3oPqA/1Fda25T0E/Hw+usRqeZ+BgVMh+sYJagmVZdy80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1TgyPa11; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61890f3180aso56603467b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713278107; x=1713882907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vN+AXSDOO6J4zY3qfDIMigzIecHs2urKyg7rVUF24U4=;
        b=1TgyPa11V07JSifsLSabnJT40yUB6aJmaGrNfv6XEykA4F1Fm/DruYgCqvJ48TJE/3
         Z067YxBWVOJxqNEHqL3p4XAKqQhAT5UcwX+UPjbLKgv87fPCMSipIhSAiOgDmJA8DCc2
         B8idloPxZrLxzv+9fv9dTM5JjK5IzwFSPEA9U7acDl8Oz4XJbJtnkENyj0L/ahWBskIQ
         kY5FkI+DCjQY/iF4AMK9Cm0T0w9bbOQU94DRX9uTt6rARgFpfmjkt0P1b/irIkj6lM4r
         mG3p2ZKuwwg4rwOoq5koCFufEF6wv8oXfnIHvb3jzUE2Lh1RSagkOv6UXIE34lWklV7G
         VISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713278107; x=1713882907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vN+AXSDOO6J4zY3qfDIMigzIecHs2urKyg7rVUF24U4=;
        b=wSGJ3D4rw2gEiEVL0/H4ovXwMwM/F5jEDkJpujceZMuObRoAWADqAk3iPuHmYYnsFq
         IPwNub90ooDfSKBvXMEKU12hHdoqve6ivJ6NlBsPH0GRGDFw+Wg8Etyk/2qNZ6eAgs1R
         7sQeAvL1VlZNv8iNqzT6caGxKtUu9qlCM+ZOixqpKssgLtbn0fnkj+y/iDtksMkS33iJ
         Vdq3p1OiVmO7gc03VWEGBERgUO86ivPVidQ2+ozd7W5XpCZXJxV3ig9gH3NjlOFUvBtg
         ubVoUQ2/PXODIWfR+pPJj4UYyiROqwjPSxDO9GIN5GvDcR/sraEKrBty0itv+b0uFGO1
         NurA==
X-Forwarded-Encrypted: i=1; AJvYcCWdOGDZ0NvI2tyhjkUt0wUiBsdh08a7LsUBPtpGHHNdpWGyLAgrLYH1ELvZ98S/kB/PKlNVZpTAzLr0l3V+u+RquayATR7IPmaOGdws
X-Gm-Message-State: AOJu0Yxb86m0EOhX3xqyNEDEUpXLeGXc/gVXMooI/3MNVTA8xDcEEBu0
	oZWmoazGnHrjLLe/tQai0wIgVEbsPKRDkJRRqtkOaklhMySvf1CzjYb/z52ldbz06thPhXrJHmN
	cFQ==
X-Google-Smtp-Source: AGHT+IG4lhj33U4fJVNWUAww1HP2HpnI+82XrjJO6hKWDb9JArLMM+lM25n+6oLBV9hi7nYBN/1mhdqaz6c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:6cd4:0:b0:61a:998f:39da with SMTP id
 h203-20020a816cd4000000b0061a998f39damr2487739ywc.9.1713278107595; Tue, 16
 Apr 2024 07:35:07 -0700 (PDT)
Date: Tue, 16 Apr 2024 07:35:06 -0700
In-Reply-To: <20240416123558.212040-1-julian.stecklina@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416123558.212040-1-julian.stecklina@cyberus-technology.de>
Message-ID: <Zh6MmgOqvFPuWzD9@google.com>
Subject: Re: [PATCH 1/2] KVM: nVMX: fix CR4_READ_SHADOW when L0 updates CR4
 during a signal
From: Sean Christopherson <seanjc@google.com>
To: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Prescher <thomas.prescher@cyberus-technology.de>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 16, 2024, Julian Stecklina wrote:
> From: Thomas Prescher <thomas.prescher@cyberus-technology.de>
> 
> This issue occurs when the kernel is interrupted by a signal while
> running a L2 guest. If the signal is meant to be delivered to the L0
> VMM, and L0 updates CR4 for L1, i.e. when the VMM sets
> KVM_SYNC_X86_SREGS in kvm_run->kvm_dirty_regs, the kernel programs an
> incorrect read shadow value for L2's CR4.
> 
> The result is that the guest can read a value for CR4 where bits from
> L1 have leaked into L2.

No, this is a userspace bug.  If L2 is active when userspace stuffs register state,
then from KVM's perspective the incoming value is L2's value.  E.g. if userspace
*wants* to update L2 CR4 for whatever reason, this patch would result in L2 getting
a stale value, i.e. the value of CR4 at the time of VM-Enter.

And even if userspace wants to change L1, this patch is wrong, as KVM is writing
vmcs02.GUEST_CR4, i.e. is clobbering the L2 CR4 that was programmed by L1, *and*
is dropping the CR4 value that userspace wanted to stuff for L1.

To fix this, your userspace needs to either wait until L2 isn't active, or force
the vCPU out of L2 (which isn't easy, but it's doable if absolutely necessary).

Pulling in a snippet from the initial bug report[*],

 : The reason why this triggers in VirtualBox and not in Qemu is that there are
 : cases where VirtualBox marks CR4 dirty even though it hasn't changed.

simply not trying to stuff register state dirty when L2 is active sounds like it
would resolve the issue.

https://lore.kernel.org/all/af2ede328efee9dc3761333bd47648ee6f752686.camel@cyberus-technology.de

> We found this issue by running uXen [1] as L2 in VirtualBox/KVM [2].
> The issue can also easily be reproduced in Qemu/KVM if we force a sreg
> sync on each call to KVM_RUN [3]. The issue can also be reproduced by
> running a L2 Windows 10. In the Windows case, CR4.VMXE leaks from L1
> to L2 causing the OS to blue-screen with a kernel thread exception
> during TLB invalidation where the following code sequence triggers the
> issue:
> 
> mov rax, cr4 <--- L2 reads CR4 with contents from L1
> mov rcx, cr4
> btc 0x7, rax <--- L2 toggles CR4.PGE
> mov cr4, rax <--- #GP because L2 writes CR4 with reserved bits set
> mov cr4, rcx
> 
> The existing code seems to fixup CR4_READ_SHADOW after calling
> vmx_set_cr4 except in __set_sregs_common. While we could fix it there
> as well, it's easier to just handle it centrally.
> 
> There might be a similar issue with CR0.
> 
> [1] https://github.com/OpenXT/uxen
> [2] https://github.com/cyberus-technology/virtualbox-kvm
> [3] https://github.com/tpressure/qemu/commit/d64c9d5e76f3f3b747bea7653d677bd61e13aafe
> 
> Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
> Signed-off-by: Thomas Prescher <thomas.prescher@cyberus-technology.de>

SoB is reversed, yours should come after Thomas'.

> ---
>  arch/x86/kvm/vmx/vmx.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 6780313914f8..0d4af00245f3 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -3474,7 +3474,11 @@ void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
>  			hw_cr4 &= ~(X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_PKE);
>  	}
>  
> -	vmcs_writel(CR4_READ_SHADOW, cr4);
> +	if (is_guest_mode(vcpu))
> +		vmcs_writel(CR4_READ_SHADOW, nested_read_cr4(get_vmcs12(vcpu)));
> +	else
> +		vmcs_writel(CR4_READ_SHADOW, cr4);
> +
>  	vmcs_writel(GUEST_CR4, hw_cr4);
>  
>  	if ((cr4 ^ old_cr4) & (X86_CR4_OSXSAVE | X86_CR4_PKE))
> -- 
> 2.43.2
> 

