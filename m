Return-Path: <linux-kernel+bounces-129733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5238E896F3F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E083DB26462
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BAB146D54;
	Wed,  3 Apr 2024 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3OEi/Wl0"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E525D146A69
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148506; cv=none; b=ij0R+py8HU7MzPanjz40hMUBcfCWl2iO3Y6JL88cwblXrKzbrYjVu8fASMrKQ+3dAaXcD6NwBNqxJ3pUyuJfG26Y8EH1UqM4oGtKBbqPqxbOzAhQaYKZsMfWotnhe4gAwAXwP4xy5DN7cbRQ7V1YLy/IaR0a1trGUvODBvFk7wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148506; c=relaxed/simple;
	bh=4fa99bxCzTQ+aNnZyVhhNdM2BDVJ2tsP+qybvHGqaKM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GxdIYyGnteCNKCKmF0gAbKCE4yJhVOBlVWcWg/gU+cwf0Vgp7XXi8GXmH6Q2bjz6zAgSfTH+3eJBabiowIRupf0WtE+fVMi2HnUl6GW0ddeDVEmltFSc9OtndtYrJt2EPaifWHJjKEagT6R3Sp/cZtHzexqdpV6ArOhPAQ4sG1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3OEi/Wl0; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd1779adbeso10964631276.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 05:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712148504; x=1712753304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+WTH0q5GpZ21Z4ilfFX2mq/pwBVpJa04vjJTZDZifhs=;
        b=3OEi/Wl0Ii6hwwI588T32CXWbyWiDiED+UtV+jHJNsq0jtrYcq1IfYusxJaiO6x6He
         sei4tMOIQ0psJ3aN+OanjaMcs3GqqHvBVkuN/I+ld9XiqLQxw+huWdQwehIhNHcHqfXr
         7/yq5TPsQOaOtUMU4cGTxLsuG0A/ZtV7fYve9emuRnYR7Rqs7OSqKAeYOSog4LR+UdeO
         Ukw3iQ1GE+hQHcigK3lUc7+HFsWxb8Pbxl5wwnJ547ax+EAP/+pUkBHOoe5nD2j0tkCa
         ZG4WEsBu8E+lVz2n7WIOQj1Mnkj/fNW2bFk4BCFwxG7nqj4L6UpITPpxHIwvpOfTDYzl
         XNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712148504; x=1712753304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+WTH0q5GpZ21Z4ilfFX2mq/pwBVpJa04vjJTZDZifhs=;
        b=qKEmChg20mmTVmXp5LBShaHqvno7P9KXsDumsnabdtQPbsWzOIrcEgvB2lupkG3XdS
         vEm7GTcf+Taqy5qu8WiDWUzw8HAqHjrPc3QccwJvf6V/cCbobpg5jnQVtWUN87qlPYpZ
         +DoDBJrOQMSS3KSB9dB0vlMYil5psgX9SZidqu9QqvOnmCfRz3zBdpCh5h6I4R1xsu2M
         9lXLiSaYHH9Q5facq7TTWTxpxYjrYMIvmapRbbva2f45RIT10gJfYyYHDGRz5x7lr455
         f7S9u9z2pGWoTvmiruiVMdMX4FbeqLt069pzQu7qkgQVBgCifnqpvm+top/qwsRhjYpq
         8GMw==
X-Forwarded-Encrypted: i=1; AJvYcCUNYLxIHEhlpD4TwTEgvJJEKbr/KX/PxnfnUnmjo5UHfZ0wESCxTnBEuMfaF7zMlbscEKGsv0F9bU1V3FPeWXYLyfvQ1UyXvtgUTwIh
X-Gm-Message-State: AOJu0YyEQqLc4gG6DyQ7VstW4nd440ctup4yc/2MqnPmFR435e5ycLrl
	DYNKA3r7Vic2CRY9xY8PVAz8VB2SAtl7v4qUaoSs3k9rgMubD/dpO++B8E4wRrfsD9j+sH+HbsK
	7kA==
X-Google-Smtp-Source: AGHT+IHzFSNyW912YO220dObmsVmcH6kZMbX/Cwr83xihFVbO6C+uvXA4mxpDrUftZoKCYJjCYYgrpO5rM0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1586:b0:dcb:b9d7:2760 with SMTP id
 k6-20020a056902158600b00dcbb9d72760mr4816449ybu.13.1712148504099; Wed, 03 Apr
 2024 05:48:24 -0700 (PDT)
Date: Wed, 3 Apr 2024 05:48:22 -0700
In-Reply-To: <20240403121436.GDZg1ILCn0a4Ddif3g@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <1d10cd73-2ae7-42d5-a318-2f9facc42bbe@alu.unizg.hr>
 <20240318202124.GCZfiiRGVV0angYI9j@fat_crate.local> <12619bd4-9e9e-4883-8706-55d050a4d11a@alu.unizg.hr>
 <20240326101642.GAZgKgisKXLvggu8Cz@fat_crate.local> <8fc784c2-2aad-4d1d-ba0f-e5ab69d28ec5@alu.unizg.hr>
 <20240328123830.dma3nnmmlb7r52ic@amd.com> <20240402101549.5166-1-bp@kernel.org>
 <20240402133856.dtzinbbudsu7rg7d@amd.com> <20240403121436.GDZg1ILCn0a4Ddif3g@fat_crate.local>
Message-ID: <Zg1QFlDdRrLRZchi@google.com>
Subject: Re: [BUG net-next] arch/x86/kernel/cpu/bugs.c:2935: "Unpatched return
 thunk in use. This should not happen!" [STACKTRACE]
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Michael Roth <michael.roth@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, bp@kernel.org, 
	bgardon@google.com, dave.hansen@linux.intel.com, dmatlack@google.com, 
	hpa@zytor.com, kvm@vger.kernel.org, leitao@debian.org, 
	linux-kernel@vger.kernel.org, maz@kernel.org, mingo@redhat.com, 
	mirsad.todorovac@alu.unizg.hr, pawan.kumar.gupta@linux.intel.com, 
	pbonzini@redhat.com, peterz@infradead.org, shahuang@redhat.com, 
	tabba@google.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 03, 2024, Borislav Petkov wrote:
> On Tue, Apr 02, 2024 at 08:38:56AM -0500, Michael Roth wrote:
> > On Tue, Apr 02, 2024 at 12:15:49PM +0200, bp@kernel.org wrote:
> > I can also trigger using one of the more basic KVM selftests:
> > 
> >   make INSTALL_HDR_PATH="$headers_dir" headers_install
> >   make -C tools/testing/selftests TARGETS="kvm" EXTRA_CFLAGS="-DDEBUG -I$headers_dir"
> >   sudo tools/testing/selftests/kvm/userspace_io_test
> 
> Ok, thanks, that helped.
> 
> Problem is:
> 
> 7f4b5cde2409 ("kvm: Disable objtool frame pointer checking for vmenter.S")
> 
> it is disabling checking of the arch/x86/kvm/svm/vmenter.S by objtool
> when CONFIG_FRAME_POINTER=y but that also leads to objtool *not*
> generating .return_sites and the return thunk remains unpatched.
> 
> I think we need to say: ignore frame pointer checking but still generate
> .return_sites.

I'm guessing a general solution for OBJECT_FILES_NON_STANDARD is needed, but I
have a series to drop it for vmenter.S.

https://lore.kernel.org/all/20240223204233.3337324-9-seanjc@google.com

