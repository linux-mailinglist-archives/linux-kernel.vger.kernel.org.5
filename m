Return-Path: <linux-kernel+bounces-104765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FD887D34D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD81284284
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A4D50275;
	Fri, 15 Mar 2024 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xes9C2sK"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF86A4EB22
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710526077; cv=none; b=b0CuW8+ORaKilTmt7P4BC5kr+56SvbRsPZHUJwZhNCWObQvWUhfLdMIliGfggLFbi3wH0Zq4p8mP4RxSpMD+ZXUEF8fRIN+u055PXl86eaVUCZkNOVDuIpVb4azQm83ARUDZIjZ0VDVdFdk3+ABFCILMOnf0myOTJ4oUJm3xruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710526077; c=relaxed/simple;
	bh=Ig5e3Uo4Kt6VkXUFZYwYIev6o2L4kkKcvCSrIKfFMiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ac1XCNnkNTvgtxxg73LFa3Tw45uZSna4Yvb8sXQOI6g4J3xiC+yzzeRTjrmksqEG6R4jp48NwASLxXeNZwqL82CkAooRGU4Egp/0tW2Pqq8W5CTarzWnTuXAtzFU4GB7buQVDCjnnNxzOSyj/TN/cdgbkEn0weZ7wENczS+32iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xes9C2sK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-413fff1dacfso6976595e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710526072; x=1711130872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/uFlk2C9GRLTlRVUjXmHsG5FS0j/ZDm8S03vQkEIVE=;
        b=xes9C2sKv6nAzgSSvS79CDOxKRuly7kPIq7/6k15weTwgIAEZVSRZpzgEmdIod7O4p
         k024rijIRGxPJSmPyLt93vYM0Ay8uY0pOznXE4CFgwtk1Gp9cKpCwwoyYbeCUz5fToYN
         NTq22HHWz13xINuABOele/HzaaX88G8skfReTxVu7ydRLER0oS5KH/2e5auOAqrfHT30
         ASaM6REpsZdrZf6rsc8xDvtX1AKaaVfJ+ZKFHWHUOkAJGzdWDYon2paEnxAviwqpVWIi
         zMTV5SBYKVSMBOZYYG8BlArBQHHLlGXdzuUsliyytDMw2O+K1CzwoaOsBIZzrRzCNztM
         Ro2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710526072; x=1711130872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/uFlk2C9GRLTlRVUjXmHsG5FS0j/ZDm8S03vQkEIVE=;
        b=uILSgsZOJ7TCjXBkYBXvqONiGoJXYidRxlc684KAHJOKX2EXsEyeT5+qVFYOvlFwsK
         bQmDRb5zgNA8xq/jUs7+kLxdc4INi7ahsbHWiBQJWz4L7Z63CewvysTB3utUBK8uL83l
         k71+zxtQBwCevj8iaxv1dji/oFm0S+e7JOKnWRzbdwK45KwgI0gM2+AmQ5PLEQwWkqkx
         +hGK6b4cXkSJmjcB8FZCMH9+wEt5ZJixZovYt6JDYBJ23tYZP9jZxfhN6rLF1S78S0Bf
         W2V7YzANdwbPSXcP2tYXO0S0VWWq0OpKq4EhT+ptCbMknPr7gEE3K5U8EK7XomaxXRBv
         X5dQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0PNXSTpGXxp/E9+ZHIhRmfLyd/C1I4AQxwa9ZJSq/J3dEePsDwc6fO1+kXLoPpNwkTOr07QhT+bePVPmErApwELwTYJLTqBw4mSog
X-Gm-Message-State: AOJu0YyqVMOxbLOqnh+vPdSSHH1L7F4q69tIYTM9G+qNnPmi8OU6ZntN
	pyg+hUcDQhIYYW1OOo58wvAH0TfvKMg89cJKxtfzvwcsqgPH+AeCHi9XUyQnw2qgZpZBDTs3wE9
	3XS/Hx32/6UBVFvYni9gM00vnvNrWrEvzUkmy6+d3gIPnrFxvMBDw
X-Google-Smtp-Source: AGHT+IGu6nVIelPinwKh8fg6JNaOh4MQswSKQ5MDu0Jozj6hakVDTRHEIHR55aeCL8Ju3fxhF1bLe+V+Qudn+IrgWEs=
X-Received: by 2002:a05:600c:4e16:b0:413:feb5:96f6 with SMTP id
 b22-20020a05600c4e1600b00413feb596f6mr2425881wmq.21.1710526072329; Fri, 15
 Mar 2024 11:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000c6526f06137f18cc@google.com>
In-Reply-To: <000000000000c6526f06137f18cc@google.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 15 Mar 2024 11:07:24 -0700
Message-ID: <CALzav=euH_n9WXG29CFd10urh85O4Mw2L=StEizVmh27CYzrtQ@mail.gmail.com>
Subject: Re: [syzbot] [kvm?] WARNING in clear_dirty_gfn_range
To: syzbot <syzbot+900d58a45dcaab9e4821@syzkaller.appspotmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 4:34=E2=80=AFPM syzbot
<syzbot+900d58a45dcaab9e4821@syzkaller.appspotmail.com> wrote:
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5165 at arch/x86/kvm/mmu/tdp_mmu.c:1526 clear_dirty_=
gfn_range+0x3d6/0x540 arch/x86/kvm/mmu/tdp_mmu.c:1526
> Modules linked in:
> CPU: 1 PID: 5165 Comm: syz-executor417 Not tainted 6.8.0-syzkaller-01185-=
g855684c7d938 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.=
16.2-1 04/01/2014
> RIP: 0010:clear_dirty_gfn_range+0x3d6/0x540 arch/x86/kvm/mmu/tdp_mmu.c:15=
26
> Call Trace:
>  <TASK>
>  kvm_tdp_mmu_clear_dirty_slot+0x24f/0x2e0 arch/x86/kvm/mmu/tdp_mmu.c:1557
>  kvm_mmu_slot_leaf_clear_dirty+0x38b/0x490 arch/x86/kvm/mmu/mmu.c:6783
>  kvm_mmu_slot_apply_flags arch/x86/kvm/x86.c:12962 [inline]
>  kvm_arch_commit_memory_region+0x299/0x490 arch/x86/kvm/x86.c:13031
>  kvm_commit_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:1751 =
[inline]
>  kvm_set_memslot+0x4d3/0x13e0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1=
994
>  __kvm_set_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:2129 [=
inline]
>  __kvm_set_memory_region+0xdbc/0x1520 arch/x86/kvm/../../../virt/kvm/kvm_=
main.c:2020
>  kvm_set_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:2150 [in=
line]
>  kvm_vm_ioctl_set_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c=
:2162 [inline]
>  kvm_vm_ioctl+0x151c/0x3e20 arch/x86/kvm/../../../virt/kvm/kvm_main.c:515=
2

The reproducer uses nested virtualization to launch an L2 with EPT
disabled. This creates a TDP MMU root with role.guest_mode=3D1, which
triggers the WARN_ON() in kvm_tdp_mmu_clear_dirty_slot() because
kvm_mmu_page_ad_need_write_protect() returns false whenever PML is
enabled and the shadow page role.guest_mode=3D1.

If I'm reading prepare_vmcs02_constant_state() correctly, we always
disable PML when running in L2. So when enable_pml=3D1 and L2 runs with
EPT disabled we are blind to dirty tracking L2 accesses.

