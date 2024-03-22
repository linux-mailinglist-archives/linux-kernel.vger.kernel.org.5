Return-Path: <linux-kernel+bounces-111243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E0988699D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167311C21647
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1939720B27;
	Fri, 22 Mar 2024 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbx74dXZ"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77023199AD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100774; cv=none; b=jHaVqsK3zYjkJh5SuHSG4llnHwJHo34LIxK2v+fCxLMlsEYtt3x/ktCdGfiHoXHLkCbfGTR/M162RqOo8lYP84yxiXtzGs80FUCUhx2Q3rFWuzYHpEuCsYf2wRWclZJbQNI/nNj/B0/Bg9Mi0Ns6eKgQS++6l5CwT8b+9kBpoNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100774; c=relaxed/simple;
	bh=0HGFpWXgAxv11aew5mHIdUlJBH2vlMWPrdJhbQSPObo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbbxAjA+Jpojm6Yn9RbDCthNlZ/3wVQU2y6UKFymEzLtEpy0bRKhW3Jxknutm+i+gJTT3w/5NVEWwxW3LqCUVVFP2I4ZZ8oB7+4fgQ1ay1nbUIsdYj69hSzFpEbDNUfyf8TXP2bZUVcX7c3GgUpLw3PNP1AsEAEU3YKZpdygEik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbx74dXZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33ec8f13c62so1339793f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711100771; x=1711705571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCMdhgrdVKnqO69mGNK3lDO/Xxw/v0OhHwhqHjbo2/o=;
        b=lbx74dXZyIE6zJ5EY9rUXBZp8xJPAPRa/mfsto/Bhod19XfKc9Tt5BOo7rYhLOAgWK
         RKtA/XQ2vGbokChSD57YdtBikNIEB9u0h7bHeMui/aRKmOLC1nx0DxPsqFv8uSeryEbS
         Q6E3ck8uSunNaO38dWRTBAMimrPv9wF+y/he4bfO7MRg3qrjEGm7oVygJ9rcjC3yDr3G
         sNV/7gGqFyDrLJCTMMP2J4M6k0iEXvfcoG6BS7AG384XazjB3bn+dkKlLKQkpNdrwvN3
         TthhCMgLeAZAxXYmFau2arvk1Yj5SsYTFXgy9scXXvpPQohIvnZl++WUiPPVzaDZ3OZL
         bBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711100771; x=1711705571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCMdhgrdVKnqO69mGNK3lDO/Xxw/v0OhHwhqHjbo2/o=;
        b=mm49XOYcOrAAxDn8bp+4lonRzjyZm+E/AVC+eIGCyUu+6Pha9Dt2vJBGN4i6CbC4vB
         35mklcko6GHQMJd5RKEc7hiWlVfKVw9jp/MGHLIDfTly5PJrVFJHJ61YX58/KmrrfmUm
         1Puyxv2qQafQ45sgTtyO0ePSdL1G6wuWeRuxHc+1xv9zt02gxIcFdkMxS6rMMZ1fLjGs
         X3FmeIHoCQG100c5v6QDigyjCcIdpoIJsQq6RsCIWA/kh24CRk+RbhlzLiteFZi1cuBT
         mqIBh3LFIdytj+GFgYPUEgmdEEViAnCOt84G64INuw5T98xAnbaYK52LiteocoPtvlty
         aXuQ==
X-Gm-Message-State: AOJu0YwYwLH+dcP93fmk1gCNjDVvv297ZfTQI2X/AK398iK9Ec93wNid
	J3PtNIFGBC3VzXzTsEJ1zjmjxPsAe7SPBWrYpuRYRYbkSq909N6F
X-Google-Smtp-Source: AGHT+IFjWWU2ESxAg2Cz0R105MtacWmpaK7wodITswBfCb+WBb5jcerbJgIsQYs0Gj2amxDVSAAUcQ==
X-Received: by 2002:a5d:4250:0:b0:33e:77e6:40bf with SMTP id s16-20020a5d4250000000b0033e77e640bfmr1113151wrr.37.1711100770237;
        Fri, 22 Mar 2024 02:46:10 -0700 (PDT)
Received: from gmail.com (1F2EF04C.nat.pool.telekom.hu. [31.46.240.76])
        by smtp.gmail.com with ESMTPSA id i5-20020a5d5585000000b0033ed7181fd1sm1671644wrv.62.2024.03.22.02.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 02:46:09 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 22 Mar 2024 10:46:07 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	dave.hansen@linux.intel.com, tglx@linutronix.de,
	matthias.neugschwandtner@oracle.com, andrew.brownsword@oracle.com
Subject: Re: [RFC PATCH v2 1/1] x86/pkeys: update PKRU to enable pkey 0
 before XSAVE
Message-ID: <Zf1TX3QXjWQsVp2R@gmail.com>
References: <20240321215622.3396410-1-aruna.ramakrishna@oracle.com>
 <20240321215622.3396410-2-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321215622.3396410-2-aruna.ramakrishna@oracle.com>


* Aruna Ramakrishna <aruna.ramakrishna@oracle.com> wrote:

> This patch is a workaround for a bug where the PKRU value is not
> restored to the init value before the signal handler is invoked.
> 
> Problem description:
> Let's assume there's a multithreaded application that runs untrusted
> user code. Each thread has its stack/code protected by a non-zero pkey,
> and the PKRU register is set up such that only that particular non-zero
> pkey is enabled. Each thread also sets up an alternate signal stack to
> handle signals, which is protected by pkey zero. The pkeys man page
> documents that the PKRU will be reset to init_pkru when the signal
> handler is invoked, which means that pkey zero access will be enabled.
> But this reset happens after the kernel attempts to push fpu state
> to the alternate stack, which is not (yet) accessible by the kernel,
> which leads to a new SIGSEGV being sent to the application, terminating
> it.
> 
> Enabling both the non-zero pkey (for the thread) and pkey zero (in
> userspace) will not work for us. We cannot have the alt stack writeable
> by all - the rationale here is that the code running in that thread
> (using a non-zero pkey) is untrusted and should not have access to the
> alternate signal stack (that uses pkey zero), to prevent the return
> address of a function from being changed. The expectation is that kernel
> should be able to set up the alternate signal stack and deliver the
> signal to the application even if pkey zero is explicitly disabled by
> the application. The signal handler accessibility should not be dictated
> by the PKRU value that the thread sets up.
> 
> Solution:
> The PKRU register is managed by XSAVE, which means the sigframe contents
> must match the register contents - which is not the case here. We want
> the sigframe to contain the user-defined PKRU value (so that it is
> restored correctly from sigcontext) but the actual register must be
> reset to init_pkru so that the alt stack is accessible and the signal
> can be delivered to the application. It seems that the proper fix here
> would be to remove PKRU from the XSAVE framework and manage it
> separately, which is quite complicated. As a workaround, this patch does
> something like this:
> 
>         orig_pkru = rdpkru();
>         wrpkru(init_pkru & orig_pkru);
>         xsave_to_user_sigframe();
>         put_user(pkru_sigframe_addr, orig_pkru)
> 
> Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> Helped-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Helped-by: Prakash Sangappa <prakash.sangappa@oracle.com>
> ---
>  arch/x86/include/asm/fpu/signal.h  |  3 +-
>  arch/x86/include/asm/sighandling.h | 10 +++----
>  arch/x86/kernel/fpu/signal.c       | 44 ++++++++++++++++++++++++++----
>  arch/x86/kernel/fpu/xstate.c       | 13 +++++++++
>  arch/x86/kernel/fpu/xstate.h       |  1 +
>  arch/x86/kernel/signal.c           | 40 +++++++++++++++++++++------
>  arch/x86/kernel/signal_32.c        |  8 +++---
>  arch/x86/kernel/signal_64.c        |  9 +++---
>  8 files changed, 101 insertions(+), 27 deletions(-)

Ok, this looks a lot saner than the first patch.

A couple of requests:

1)

Please split out all the PKRU parameter passing interface changes into a 
separate patch. Ie. split out patches that don't change any behavior, and 
try to make the final feature-enabling (bug-fixing) patch as small and easy 
to read as possible. Maybe even have 3 patches:

  - function interface changes
  - helper function additions
  - behavioral changes to signal handler pkru context

2)

I do agree that isolation of sandboxed execution into a non-zero pkey might 
make sense. But this really needs an actual testcase.

3)

The semantics you've implemented for sigaltstacks are not the only possible 
ones. In principle, a signal handler with its own stack might want to have 
its own key(s) enabled. In a way a Linux signal handler is a mini-thread 
created on the fly, with its own stack and its own attributes. Some thought 
& analysis should go into which way to go here, and the best path should be 
chosen. Fixing the SIGSEGV you observed should be a happy side effect of 
other worthwile improvements.

Thanks,

	Ingo

