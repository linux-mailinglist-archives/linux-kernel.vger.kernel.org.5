Return-Path: <linux-kernel+bounces-32680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE17835ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718DA1F22E2C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8469E3A1AA;
	Mon, 22 Jan 2024 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v25/ui4B"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC6139FC8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917432; cv=none; b=LH5PP6fjQV1oOpTGgbnftgc+L9gEqoMOuvbDFn5M9LoaABhPHUuYC9ziuSKrtFGYYk28ehvpe2Ysw6Nz16ivrI4r1cD6cGPQzg2S69qtX8HZE5WX/hwF1lk9pj/h9Y7RwpJkuTLCYtVUgSATw9/r4TxV5TXEIFnAnQmOmSnmpyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917432; c=relaxed/simple;
	bh=YkgHXgJDhjgzGUClz+Vy1P/+dt5Hxm+SkSb5hZ8rhgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YySUMBGzUtBddvU35B0Ikpptg8iHQ+98uujJUpT7gvwv7+guXicH/BjeXp4iepibzNyXy1abxM2FDHj/d4Ngmhn3Dd30MZb52gPT0p+aJ5o3VASwIw0Mbipu/f/Gt+2DTQH+Lbq20iwyDprJaqs5bKC9tdmcO+YL/eqNH9k1cho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v25/ui4B; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7831b3a48e7so198717385a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705917430; x=1706522230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rKc/goBzVwdZogi61XdfYVie6DI5305ZMhUyeoLBnU=;
        b=v25/ui4B1jVE62i4Exx3jNiqyaaCj6WLSjnqRTfJj72nmVDL5mdz1BMSjHO9ImWdc/
         TOh99wRWi7iwzfTyz/dg1s+W+/emgHX8f38ZLloZkq53Uxs2QCoddyoBK8s2HvW+Jca/
         sbmLhIO+frRRtxc/+09OR04qCtaEAto/qDmkGrPBgabdRtxH6gVROonZJelcTs+xzb9H
         e2Wy7h9utLOtFxESO4HeOQj0BQkgrgjuGLcqhfGYUkgoudp7M3eWBwkKYptiqnZK7VFx
         WP4Qaz79M5SIK/8sdR5YCrY3RFgNwni/eeXrOCRR0P4Y+635F27jJXdrJRJ0wsKh5OxF
         K3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705917430; x=1706522230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rKc/goBzVwdZogi61XdfYVie6DI5305ZMhUyeoLBnU=;
        b=wIiTyuq8r841LOrUKaEgZ+be8jGXYgmW8uk/PwS6wczMA/1+dM1VXlcC+3zn3i81fH
         dJc7j5570qvwrqh5jHq8pvqw9kZwH2u4NXb2BFKN6KEYyyuM4JeBhCQpLb9fF+sg2OnD
         BSO51jugD21+RJT9B/0JZgAQeEQQLvV0NlAK10cP65khIVLBH0t7Oik/G7hgneaxYMlB
         KGQdXp87wNTA9yi27rfgApwQmWKjEdlOP4MoKUUOIS6j8ZPmYx6oWvHLGv48QIcIh9RC
         jifMsWqhgFpEWdHVg53DcIQMjK+LoPO8jO5rv8F5AZ5aALh6q1d3HS7qorPjRb7rTNJl
         PYsA==
X-Gm-Message-State: AOJu0YxjZeQFD1gW/M4lOwQmQ7KNJ3qlwBAuZaojxvTRiujp8J614FsL
	YRYrLWczIz9uBOp1PV+nnNsy6tivCCLeQKpYg0QXvZ5lkgfB9B4CG2PWdIoJmldEirJBLug6pFk
	wSh8l+3ffWk+bW0yXsh9L3Eum4+icMQSZ6bXE
X-Google-Smtp-Source: AGHT+IGYP8VHpM3Oph8CFnz0g/mJ9jSbX248qH2b2vUQpFcyR6bh+yya24MD/KchaFwIIAbaVzmkfJYYsPmNqbQKbCY=
X-Received: by 2002:a05:6214:20a2:b0:686:1e2:747e with SMTP id
 2-20020a05621420a200b0068601e2747emr2720892qvd.71.1705917430029; Mon, 22 Jan
 2024 01:57:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118110022.2538350-1-elver@google.com>
In-Reply-To: <20240118110022.2538350-1-elver@google.com>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 22 Jan 2024 10:56:31 +0100
Message-ID: <CAG_fn=Wdkv8-=X1j-Rh8u-zhRCW9oY1GQ-=C3n=9eic6Vyr=iQ@mail.gmail.com>
Subject: Re: [PATCH] mm, kmsan: fix infinite recursion due to RCU critical section
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzbot+93a9e8a3dea8d6085e12@syzkaller.appspotmail.com, 
	Charan Teja Kalla <quic_charante@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 12:00=E2=80=AFPM Marco Elver <elver@google.com> wro=
te:
>
> Alexander Potapenko writes in [1]: "For every memory access in the code
> instrumented by KMSAN we call kmsan_get_metadata() to obtain the
> metadata for the memory being accessed. For virtual memory the metadata
> pointers are stored in the corresponding `struct page`, therefore we
> need to call virt_to_page() to get them.
>
> According to the comment in arch/x86/include/asm/page.h,
> virt_to_page(kaddr) returns a valid pointer iff virt_addr_valid(kaddr)
> is true, so KMSAN needs to call virt_addr_valid() as well.
>
> To avoid recursion, kmsan_get_metadata() must not call instrumented
> code, therefore ./arch/x86/include/asm/kmsan.h forks parts of
> arch/x86/mm/physaddr.c to check whether a virtual address is valid or
> not.
>
> But the introduction of rcu_read_lock() to pfn_valid() added
> instrumented RCU API calls to virt_to_page_or_null(), which is called by
> kmsan_get_metadata(), so there is an infinite recursion now.  I do not
> think it is correct to stop that recursion by doing
> kmsan_enter_runtime()/kmsan_exit_runtime() in kmsan_get_metadata(): that
> would prevent instrumented functions called from within the runtime from
> tracking the shadow values, which might introduce false positives."
>
> Fix the issue by switching pfn_valid() to the _sched() variant of
> rcu_read_lock/unlock(), which does not require calling into RCU. Given
> the critical section in pfn_valid() is very small, this is a reasonable
> trade-off (with preemptible RCU).
>
> KMSAN further needs to be careful to suppress calls into the scheduler,
> which would be another source of recursion. This can be done by wrapping
> the call to pfn_valid() into preempt_disable/enable_no_resched(). The
> downside is that this sacrifices breaking scheduling guarantees;
> however, a kernel compiled with KMSAN has already given up any
> performance guarantees due to being heavily instrumented.
>
> Note, KMSAN code already disables tracing via Makefile, and since
> mmzone.h is included, it is not necessary to use the notrace variant,
> which is generally preferred in all other cases.
>
> Link: https://lkml.kernel.org/r/20240115184430.2710652-1-glider@google.co=
m [1]
> Reported-by: Alexander Potapenko <glider@google.com>
> Reported-by: syzbot+93a9e8a3dea8d6085e12@syzkaller.appspotmail.com
> Signed-off-by: Marco Elver <elver@google.com>
> Cc: Charan Teja Kalla <quic_charante@quicinc.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>

