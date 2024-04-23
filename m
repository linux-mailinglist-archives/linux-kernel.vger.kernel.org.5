Return-Path: <linux-kernel+bounces-155535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B6F8AF3A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB90E1C239C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE1213CF9F;
	Tue, 23 Apr 2024 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RAbYyilf"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36BB13C9DF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888855; cv=none; b=QqaH9F81y3QQ3xHzD0VhKbUAN9lmAqAxCM+eQ16stL4az8iTGpV6PvbZ86ezLV2IYSZg5BxjQwEc50MAA/UMCLo6/ib+u8fraCw40Dz2CihMSTWo8fxMAPEz0c3XMR/88SZu3ZZasR34Jpx99anUucAy9ty6P0MgNfijDrlV7ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888855; c=relaxed/simple;
	bh=dWEAghxUZ6AljuU3Ocx2054Q77hrGSoiyNPUFJl8xkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MaHLieQvyc07TDZdXp4ao+CuaK90voC0AL24QBZi+C+/yeTL8aMzMhUEEgvVZLbkRzmbBSrHfHQk7atixqyd1Da7qQSkFZifyNKYVR6lrR2rRor5qHAaRZwlAqcA2uISOD/OKBPZB7cGTDlju/tHOM5u1ztUeyBGdpa3ULgQcBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RAbYyilf; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a55b78510bbso269832766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713888852; x=1714493652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N7OjeeVgqzJJaSGvTcJ0Yf3Ef5oITHumnbDzjX2kLmY=;
        b=RAbYyilf4imfGQ4o7MsgH1s5/cNo6XEhxJOnkfNXbCYAiJOknFqIAxjbFg0qOS919D
         Wmr3MCzc8Fk6Q5vgCNS1VyATcnmeQRqaLexTJx5D0XyZwzJ1t5LHjfjbskrI4sOq1waR
         015d8zi8ksLGDQrBoHxJi36E+ONQaEZFXOt38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713888852; x=1714493652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N7OjeeVgqzJJaSGvTcJ0Yf3Ef5oITHumnbDzjX2kLmY=;
        b=PsF1+wzDj0S5Wih//Da4/laX9Hrm0ylCz300gswuurTzkp1u0GfAQ+XV8EN7MBuufj
         2zH4uN77sY6XoVoEPQLVCB0dhcCeO6PjcDV0omUYl9eqmUhcDhi7szHXm+0Sng4ErqzY
         d8JaTHD7RW52ctCZHfxhIbIRPA6mchxmAmQbKJ3im/DUGq+KqXXOORMIH/Y+WMj3suw+
         f7yPGwjRmeqbftJ38v8iaNhQrPdeEW5HH1faejOZ98SfyRDmE6OYN+3QN99XPV+l1eJl
         NXqC9tJ0Uss2GaKbIjOI/cMVTpdQ79k1oJMf/HNScWPwuXDerGXnNI46UKdzZebmE2zh
         zqiw==
X-Forwarded-Encrypted: i=1; AJvYcCUOn4+oavuAbgnebHdtTTHTtRf/d0PfUayMjb0SJj3KowweisyzXN+xP4GmYDQGa9c90GXCRYOaLTKzLb8gjkqjQZbI+UoYhPzCWsCn
X-Gm-Message-State: AOJu0YxNDhAMgkA1KzzysiuxNeIxhSg32PDqqvguL5uruBDciyD0HXBO
	DcJHKY7h+ImiOQNwNsa+pz95ZJXkjXM2RPddAyDiyuJPy+mtBqs6mDDyGhB3LvGN6id6t6Tg5jY
	kddhXMg==
X-Google-Smtp-Source: AGHT+IEIXOtW7qMHjfXDzJ9R+E1zyZhEVaumEycSy56JH896Kc2GlTtlvS0YPrxwTnXoug+HwnX+jg==
X-Received: by 2002:a17:907:806:b0:a58:8743:12d5 with SMTP id wv6-20020a170907080600b00a58874312d5mr683734ejb.47.1713888851777;
        Tue, 23 Apr 2024 09:14:11 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id gx20-20020a1709068a5400b00a5885a7cb8csm446009ejc.119.2024.04.23.09.14.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 09:14:11 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-571bddd74c1so5641929a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:14:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0zyAPINAMO5WXqRzG4ZLx9CUB7IHBepCkhPUSJJZuE6kgNb7VGNtmP6fbv1f6B1WOFgA9jY+s/aEGyhKWxiGisadqwq7Dd/vdC1oe
X-Received: by 2002:a19:f611:0:b0:51a:f3b9:f76f with SMTP id
 x17-20020a19f611000000b0051af3b9f76fmr13743lfe.13.1713888830965; Tue, 23 Apr
 2024 09:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com> <74ffd154-5d92-4303-9977-6ddc9accdf01@linux.ibm.com>
In-Reply-To: <74ffd154-5d92-4303-9977-6ddc9accdf01@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Apr 2024 09:13:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrTE30xzuq4mcXidT4M0z_HRYJW9i8M9gD9VG7d29Qpg@mail.gmail.com>
Message-ID: <CAHk-=whrTE30xzuq4mcXidT4M0z_HRYJW9i8M9gD9VG7d29Qpg@mail.gmail.com>
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org, 
	paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org, 
	mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com, 
	andrew.cooper3@citrix.com, bristot@kernel.org, mathieu.desnoyers@efficios.com, 
	geert@linux-m68k.org, glaubitz@physik.fu-berlin.de, 
	anton.ivanov@cambridgegreys.com, mattst88@gmail.com, 
	krypton@ulrich-teichert.org, rostedt@goodmis.org, David.Laight@aculab.com, 
	richard@nod.at, mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com, 
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, 
	LKML <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Apr 2024 at 08:23, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
> Tried this patch on PowerPC by defining LAZY similar to x86. The change is below.
> Kept it at PREEMPT=none for PREEMPT_AUTO.
>
> Running into soft lockup on large systems (40Cores, SMT8) and seeing close to 100%
> regression on small system ( 12 Cores, SMT8). More details are after the patch.
>
> Are these the only arch bits that need to be defined? am I missing something very
> basic here? will try to debug this further. Any inputs?

I don't think powerpc uses the generic *_exit_to_user_mode() helper
functions, so you'll need to also add that logic to the low-level
powerpc code.

IOW, on x86, with this patch series, patch 06/30 did this:

-               if (ti_work & _TIF_NEED_RESCHED)
+               if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
                        schedule();

in kernel/entry/common.c exit_to_user_mode_loop().

But that works on x86 because it uses the irqentry_exit_to_user_mode().

On PowerPC, I think you need to at least fix up

    interrupt_exit_user_prepare_main()

similarly (and any other paths like that - I used to know the powerpc
code, but that was long long LOOONG ago).

                Linus

