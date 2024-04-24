Return-Path: <linux-kernel+bounces-156175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D948AFED8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7AC28688F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172F37F490;
	Wed, 24 Apr 2024 02:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUxePWuK"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C68F47;
	Wed, 24 Apr 2024 02:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927224; cv=none; b=M6aQxjup4gaTJ4jRfcS0zk+F+z+0VJmYeWJW6rIHXFaTWJ22x5IwHrwJRGcAwIygRFlchTYkWmm2tbOoYRThjxAUnX1P+vpMjkROXshpUa21cMY3zt990ALcSvpG54lvfogbfk/NVUvwqkEAvBAqZnL625FkYZ3v8N3h7h0N4mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927224; c=relaxed/simple;
	bh=yTCwB5MKwpTb9TeIS1+gfR/A4L8mMnu2aKsPl0GCDSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5PMTKafusSaU18az0f3ukwP9sPBxDztzq3nwTyMm8OuvQ86KVKiLz1e7YPFuSkJRhiDv8gH+4kXVxKOVGrGUDKiWRfSHligVJsYlxUfhE+ipRZmHBFABWnvecR7g64jQpDYNyjPgx+cLhoZxYIojTuX/ky0vItbHncTV89HKTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUxePWuK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f07de6ab93so5977539b3a.2;
        Tue, 23 Apr 2024 19:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713927222; x=1714532022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmqU0PrGd+2IylBkSE4S0tLQ+pmhWNt4mrMys0RAJYA=;
        b=dUxePWuKWvnSAjVODpa5LgFO+cWfxMypOZ8i5fypb4IgDLf7vIz5csaGjpLcrR82uN
         keUhijRsK3581771Mbve6O+AsQbbccDYbhiEIqC8N25+61THMJ+ckbGE3REOoRitzW+v
         1t8wMgYXVD4vBtCyShBT5eHx33MlAKkM/PkOcls3nEH0siF0kONfBGMfmQ55XCNGgwcV
         jdzMY0GgygJyIYKv0jDDANmv1Kr4jRIZPqM+oNkwSLmeYqsGAxSbDVX4yNSC8g+ecMwt
         XfcQlIUz7l7bJaVXCEUUtbgQzn4nSamRZrRKuqyvZqAqm24teh9M3dm5klRikDtbSWVH
         pZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713927222; x=1714532022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmqU0PrGd+2IylBkSE4S0tLQ+pmhWNt4mrMys0RAJYA=;
        b=Nuopk5gVFnTTJujBFDP6KNAC5No2ySB/0t/OOv+d1SmQCc1QUfX80V50d1fVLYW8+H
         Rn/7o/gl2BlohwBDSC7zDcyOjMUOMDuWojuhHWiqC62AMy8iLJ7xy2UGo47mK/hVN2b9
         oeacMhjbaRM1DpFsFjPyG2o+WpuuZmc8tMA2BcZdl6LD86d06BbfQCabzxCKmdlgbOfB
         j6jLY4fIPP8mN5hjyCZ1EN5dNx/nmSmyhgGS6fi32sCFLM23bUnM8zyx6tJTXxFLc9+N
         O0utjjYiqb2ilaHLGSvJOeJ5l5A4RcFKOQog5yYSOxN57z6cVNRxNYKclBiHbJwPpfDN
         nfEw==
X-Forwarded-Encrypted: i=1; AJvYcCUHncSzbcNWsJT1ZeRwA0HPXjfNbTb77s6Zw07/uyQNQ+XFgvTSQNK6WuE/yHyTIMc/D7puiobaTb7KjdtZU/B7Jl1n
X-Gm-Message-State: AOJu0YxboyV4gcGLkfc2T5rTr+TryLmXxKjv0cp9SoAjqImBooNctPU3
	BD8aChW9OvW+vqltSk+JCMpDqySxPhGXGt/MD1Ixpk2WXJGS9YtdEZxjKmsR8kLNzIQMGWAvgv8
	4Y/hLnrzBY7smoNR0B70rR2c/BKY=
X-Google-Smtp-Source: AGHT+IG+oc+vtI2bjeexO0jUWY9BDO/Wzwjc+RFH/CqhS6s0BkmVLznukrPZ3u6NgMcMqxbtUvmBpjx7vr4WHCb1uNU=
X-Received: by 2002:a05:6a21:6802:b0:1aa:5fb4:87ff with SMTP id
 wr2-20020a056a21680200b001aa5fb487ffmr1262636pzb.14.1713927222330; Tue, 23
 Apr 2024 19:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407090558.3395-1-jiangshanlai@gmail.com> <20240407090558.3395-11-jiangshanlai@gmail.com>
 <CAEXW_YQUuGazgpLbERz7Y3nOq5nEkR+kx_Us9E30x1diiE2-eQ@mail.gmail.com>
In-Reply-To: <CAEXW_YQUuGazgpLbERz7Y3nOq5nEkR+kx_Us9E30x1diiE2-eQ@mail.gmail.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Wed, 24 Apr 2024 10:53:30 +0800
Message-ID: <CAJhGHyDyvUcXruA+kum_QPn-2pB1j+WjS-HyGCFJ8dYpW_vQFw@mail.gmail.com>
Subject: Re: [PATCH V2 10/11] x86/rcu: Add rcu_preempt_count
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, x86@kernel.org, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Nikolay Borisov <nik.borisov@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 2:09=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> On Sun, Apr 7, 2024 at 5:06=E2=80=AFAM Lai Jiangshan <jiangshanlai@gmail.=
com> wrote:
> >
> > From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> >
> > Implement PCPU_RCU_PREEMPT_COUNT for x86.
> > Mainly copied from asm/preempt.h
> >
> > Make rcu_read_[un]lock() inlined for rcu-preempt.
>
> Changelog is wrong. You inlined rcu_read_[un]lock in previous patch,
> not this one?

The previous patch just adds the non-arch framework code. The incline only
happens when CONFIG_PCPU_RCU_PREEMPT_COUNT=3Dy.  This patch implements
PCPU_RCU_PREEMPT_COUNT for x86, so rcu_read_[un]lock() was not made inlined
for x86 for rcu-preempt until this patch.

Thanks
Lai

>
> - Joel
>
> > Make rcu_read_lock() only one instruction.
> > Make rcu_read_unlock() only two instructions in the fast path.
> >
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> > ---
> >  arch/x86/Kconfig                   |   1 +
> >  arch/x86/include/asm/current.h     |   3 +
> >  arch/x86/include/asm/rcu_preempt.h | 107 +++++++++++++++++++++++++++++
> >  arch/x86/kernel/cpu/common.c       |   4 ++
> >  4 files changed, 115 insertions(+)
> >  create mode 100644 arch/x86/include/asm/rcu_preempt.h
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 4fff6ed46e90..e805cac3763d 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -256,6 +256,7 @@ config X86
> >         select HAVE_OBJTOOL                     if X86_64
> >         select HAVE_OPTPROBES
> >         select HAVE_PAGE_SIZE_4KB
> > +       select HAVE_PCPU_RCU_PREEMPT_COUNT
> >         select HAVE_PCSPKR_PLATFORM
> >         select HAVE_PERF_EVENTS
> >         select HAVE_PERF_EVENTS_NMI

