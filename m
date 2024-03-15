Return-Path: <linux-kernel+bounces-104633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0559E87D14D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F8E282150
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49963C063;
	Fri, 15 Mar 2024 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hot1eDZm"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1281F2208A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520946; cv=none; b=MuKwXMAW1hR6vwKGJl+at9RX4FVbgnDBgO7enAAMGx78eAcyEGDndubM7sPHSxqJJCmrEVT2NvOEebtRjGXmhvoRmTEaBYDb3p9uqZXQEyobIKqvtSXd6aCkJ9+yA1/aOhqOgbYDlw0YEPRUveAWjh+HFhmYd2tre6rxuNUcHMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520946; c=relaxed/simple;
	bh=hIwLeauctgBMp7l98Z9Pbwy1HUT5HKtfynYgMSjBHg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6HSA3GtZuAH9UccTJtg6clUSWscUkNz4sQLAmJH7EYvl5Bo9asl9/AP+tyVPoCeN4mjyvcXAIyyiBqIcJYa1rGG3wGLfHQZDNJ/nyCQOwyVszrlSJcc4i1Y8c0voz8nwQEOjVTbBNNojozzL0Q/xG69vKUN+6s+VyTfOwXdZy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hot1eDZm; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a466fc8fcccso265688866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1710520942; x=1711125742; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=am/PWCEeHNB3+7UJCgYcRSSjRqhgq8ufptHRIWrU5Kw=;
        b=hot1eDZm7ba76H0z6cOyp9dL6RNJBuOT9lv/Ffziji28AqOAjsrOAnsqUkN1ratakk
         HxjvZWdUtxTeyICmncBaKSVYm+cS4omySbTo7afLezo6sBTVnQ/WnjnCr6u9G3GYCn6D
         y6JaWwSB4/jUJBbJhqSpXqMzI7VyVbqxtsKPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710520942; x=1711125742;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=am/PWCEeHNB3+7UJCgYcRSSjRqhgq8ufptHRIWrU5Kw=;
        b=r6bEQMrKIBkNAlirDrhCG28fJ6jqVDTadHNkJyRYJdiknNBZW2m7boyur5o9R2Xciq
         krHColnRwOfeLtkO5l0zrPKtMgykAEp6NEQBVPY8TUwR0ysqML88nD7Y0VKTb6OjLaMJ
         fpAqg/vGe4IASYufzeOb+56E/AfR02U6YavhXexjEp4hNZ3Lz5pCqanFiTMt4amijg7r
         4KURAzOA98MxfMG18/N5EBzD0k2EyuM30L3HkOHPw2sELWFBhrmVPJIKLGRQ6Zr1QKok
         f/qMHb53IIh2TniAx2l1tECvJ1pb1Aw8hM5QeCYxh4nSdqbWePxcuXdEtS+7VAtjb0qJ
         qZgA==
X-Forwarded-Encrypted: i=1; AJvYcCVHl1PMHRASEpZVqfvs94tS93vYqBc0SLkIgqbnus2Ju2t1/YjOXnqqaHfKSWx7VQrOamHruROUP9rgV0la+shtjrnksrJk6A9aK1zE
X-Gm-Message-State: AOJu0YwjwVlckiMzLbWAW0DrUFyVhndxyQh1wWZO8D2+Bm7nsMf9hN1A
	KQnD9nQp041G7yluCQby6Mweae+u69aVlBQ2WKkdgBVps1HSNU+8QYfUtWLcWJgtOSxhUpI3EI+
	d1s8=
X-Google-Smtp-Source: AGHT+IF4cBuCis1nghCnika/pZ96OuYAyV8JPX/VoJWWEAtwvJUhzFAuZLZTScb8V0HRuYjoZ6azZQ==
X-Received: by 2002:a17:906:561a:b0:a45:ac83:8743 with SMTP id f26-20020a170906561a00b00a45ac838743mr3267497ejq.33.1710520942035;
        Fri, 15 Mar 2024 09:42:22 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id ws4-20020a170907704400b00a468c11b8eesm577541ejb.30.2024.03.15.09.42.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 09:42:21 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso250174166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:42:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3aIx7xVXXQ4vNULfD9MsVBXwn2Nr+ICE5m5CWvnMUH7B7+cG23JX1QtFa7uPYTdd1sv5R67O2MQs54UuWJ1yQ2YTpyt5GUvX7IJ10
X-Received: by 2002:a17:906:bfc8:b0:a45:5be1:6e20 with SMTP id
 us8-20020a170906bfc800b00a455be16e20mr3108974ejb.23.1710520940765; Fri, 15
 Mar 2024 09:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303235029.555787150@linutronix.de> <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net>
In-Reply-To: <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 15 Mar 2024 09:42:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
Message-ID: <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, 
	Uros Bizjak <ubizjak@gmail.com>, linux-sparse@vger.kernel.org, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 09:17, Guenter Roeck <linux@roeck-us.net> wrote:
>
> [    3.291087] RIP: 0010:rapl_cpu_online+0xf2/0x110
> [    3.291087] Code: 05 ff 8e 07 03 40 42 0f 00 48 89 43 60 e8 56 5f 12 00 8b 15 b4 84 61 02 48 8b 05 01 8f 07 03 48 c7 83 90 00 00 00 e0 84 80 b6 <48> 89 9c d0 38 01 00 00 e9 2b ff ff ff b8 f4 ff ff ff e9 47 ff ff

The code is

  mov    %rax,0x60(%rbx)
  call   0x125f5f
  mov    0x26184b4(%rip),%edx
  mov    0x3078f01(%rip),%rax
  movq   $0xffffffffb68084e0,0x90(%rbx)
  mov    %rbx,0x138(%rax,%rdx,8)                <-- trapping instruction
  jmp    <backwards>

with %rdx being some index having the value 0xffffffed (-19).

That's ENODEV.

Without line numbers (if you have debug info for that kernel, it's
good to run "scripts/decode_stacktrace.sh" on stack traces) it's hard
to really know what's up, but I strongly suspect that it's this:

        rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;

because we have

   topology_logical_die_id(cpu) ->
       (cpu_data(cpu).topo.logical_die_id)

and we have

    c->topo.logical_die_id = topology_get_logical_id(apicid, TOPO_DIE_DOMAIN);

and topology_get_logical_id() does this:

        if (lvlid >= MAX_LOCAL_APIC)
                return -ERANGE;
        if (!test_bit(lvlid, apic_maps[at_level].map))
                return -ENODEV;

so that -ENODEV is not entirely unlikely for a UP run.

This also explains why it *used* to work - that whole thing is new to
the current merge window and came in through commit ca7e91776912
("Merge tag 'x86-apic-2024-03-10' of ...").

Thomas, over to you. I wonder if maybe all those topology macros
should just return 0 on an UP build, but that
topology_get_logical_id() thing looks a bit wrong regardless.

It really shouldn't depend on local apic data for configs that may not
*have* a local apic.

                 Linus

