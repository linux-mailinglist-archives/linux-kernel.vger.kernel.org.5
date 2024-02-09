Return-Path: <linux-kernel+bounces-60051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C7B84FF1A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CE51C23162
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EF420DE3;
	Fri,  9 Feb 2024 21:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bgObKC5d"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9653218AE4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515216; cv=none; b=rXhxF4X/6ahILaidmH1J6TDW+MKPu3Qz3YIGCUXaGs6wZRMDM8kEySy9ueRtMz8ZjtQSHU4iFNUNfeZmrh7twDpu0r951BWTok2+ke7UfbWQRkO6iwM2oCrvB3ldKgU6gAX2Yv7ecki17GlbUYQdpGqzRk6V80TI1yiXnWpNhVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515216; c=relaxed/simple;
	bh=E9RmYNvl+KP6ZoWmKcRICoo2zuZ2p0BRZ6TGm1vclWs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VSV6/rnMWM9yLFraJ1J2f3f8f5BCZ88Dqx3PpP3JEb71E8dnFR7aZ31RAFQBM8u9jZ5vQrR2jfRKXl1PH5iEEGktqim5zuczmZswvZ/3SfPtFctL8uJZ0/6L1gwQNEyCmo2CxoO7txmeiNC+4sYAEbCvVOGUvtX3ttKWXLQ78mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bgObKC5d; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f0fd486b9aso24445647b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707515213; x=1708120013; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GL+pH50a20qqS3C4DJIFftY5VDxfmSdvc8SiM1uAYxI=;
        b=bgObKC5dU+HxZNEKGVV5a2b0EV8Ey4AOAs8Y9eMgSqd6tLJLBrFwKW8jOdTuREerml
         KmCl13MJNxd1nU0dIypu3NImilHftQjypOoGTAcOfY8Nb6Ogl68UlrgcUSIZiM74xT16
         fH5lglZhAmkrIcmd+LaFwC7W4PkhWOMLre/ZzTyGvvcnVS6BXT2UkruoxPxUrovuaTIS
         JFI2Xow2+G8rLSEnEHcW+0wfN1z2bDqOYwHs1WC0Z3Nrh6iBCeqrBrCs8vbQ1bWy/cI4
         V8D1Xt7ja8hrGmXJ1NkmPwrAv45HL3kcM9mW1kwGZFkGCVXOd23jS6fZOUyrngjF7t5S
         +lPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707515213; x=1708120013;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GL+pH50a20qqS3C4DJIFftY5VDxfmSdvc8SiM1uAYxI=;
        b=vZMxQseY5lCPAZPNpCPr/rCihcOy1rQZX1FlkvwOyL0s6mg7bNau6Go7nnwMlx5aGZ
         zZijhFjQ5xZm9KEJXg2skv6jBU16UX7BgzFoyQYlS7MxBLIrCb6mEHUYxL1srhLkIRKL
         NfUiHRTvrsumz/tYzM9bBXMb1eRcSw7wAe+4+RQ70PQIAcu9GReH7axZk/OhOlBOMJER
         Sv514m2uFFULLZQqoaC7M3vWh6LjDOx2Il7++RDDTF1aSVCftT4oQpm37e/X41eCQJ+n
         XNolPF8c1N34ZbsnMQvuLpYH9EoPIITv4ZqzVLMDW5StSzIK9O3dZRWDGvxXfT+2FZ5Y
         uzVA==
X-Gm-Message-State: AOJu0Yx2PiOSigTLXQu7ysO+EM6TTarE+Xy+l6C0ss9bLtp6j2Xe8j5s
	gAEY7qZl8hNnbXeRhTPoxVKHpANhIPEuFnRT5fYJ9NBrOo/tYu/qpf+b4oL5MezILplSRD2vuBD
	m2g==
X-Google-Smtp-Source: AGHT+IHZrpvVEOXi6Dk7Xe7SLPmmmmxXWbzbmKhX4ZyvV8jkQs/9u4eI8K/UypS9QLyMLVxothRIaLWQdi0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:8387:0:b0:dc6:db9b:7a6d with SMTP id
 t7-20020a258387000000b00dc6db9b7a6dmr16955ybk.13.1707515213670; Fri, 09 Feb
 2024 13:46:53 -0800 (PST)
Date: Fri, 9 Feb 2024 13:46:52 -0800
In-Reply-To: <CAHk-=wgBt9SsYjyHWn1ZH5V0Q7P6thqv_urVCTYqyWNUWSJ6_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208220604.140859-1-seanjc@google.com> <CAKwvOdk_obRUkD6WQHhS9uoFVe3HrgqH5h+FpqsNNgmj4cmvCQ@mail.gmail.com>
 <DM6PR02MB40587AD6ABBF1814E9CCFA7CB84B2@DM6PR02MB4058.namprd02.prod.outlook.com>
 <CAHk-=wi3p5C1n03UYoQhgVDJbh_0ogCpwbgVGnOdGn6RJ6hnKA@mail.gmail.com>
 <ZcZyWrawr1NUCiQZ@google.com> <CAKwvOdmKaYYxf7vjvPf2vbn-Ly+4=JZ_zf+OcjYOkWCkgyU_kA@mail.gmail.com>
 <CAHk-=wgEABCwu7HkJufpWC=K7u_say8k6Tp9eHvAXFa4DNXgzQ@mail.gmail.com> <CAHk-=wgBt9SsYjyHWn1ZH5V0Q7P6thqv_urVCTYqyWNUWSJ6_g@mail.gmail.com>
Message-ID: <ZcadTKwaSvvywNA9@google.com>
Subject: Re: [PATCH] Kconfig: Explicitly disable asm goto w/ outputs on gcc-11
 (and earlier)
From: Sean Christopherson <seanjc@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Jakub Jelinek <jakub@redhat.com>, "Andrew Pinski (QUIC)" <quic_apinski@quicinc.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 09, 2024, Linus Torvalds wrote:
> Sean? Does this work for the case you noticed?

Yep.  You can quite literally see the effect of the asm("").  A "good" sequence
directly propagates the result from the VMREAD's destination register to its
final destination

  <+1756>:  mov    $0x280e,%r13d
  <+1762>:  vmread %r13,%r13
  <+1766>:  jbe    0x209fa <sync_vmcs02_to_vmcs12+1834>
  <+1768>:  mov    %r13,0xe8(%rbx)

whereas the "bad" sequence bounces through a different register.

  <+1780>:  mov    $0x2810,%eax
  <+1785>:  vmread %rax,%rax
  <+1788>:  jbe    0x209e4 <sync_vmcs02_to_vmcs12+1812>
  <+1790>:  mov    %rax,%r12
  <+1793>:  mov    %r12,0xf0(%rbx)

> That (b) is very much voodoo programming, but it matches the old magic
> barrier thing that Jakub Jelinek suggested for the really *old* gcc
> bug wrt plain (non-output) "asm goto". The underlying bug for _that_
> was fixed long ago:
> 
>     http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58670
> 
> We removed that for plain "asm goto" workaround a couple of years ago,
> so "asm_volatile_goto()" has been a no-op since June 2022, but this
> now resurrects that hack for the output case.
> 
> I'm not loving it, but Sean seemed to confirm that it fixes the code
> generation problem, so ...

Yeah, I'm in the same boat.

