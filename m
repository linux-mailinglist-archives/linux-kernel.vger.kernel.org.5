Return-Path: <linux-kernel+bounces-135226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F42789BD2D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C281F22D76
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF4A57335;
	Mon,  8 Apr 2024 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs/AQod8"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FAA55C07;
	Mon,  8 Apr 2024 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572239; cv=none; b=TyrgMokho4KFzIsCSaEGS+zRf9uDr7m56df90JmWiIFENoMMIyysbk7o0HampeaZlCVM72ttHhqtac8nLr0AI3yRJkGbTSoiKUI7EZC664/tjQxHfbeuGzJ7qeddLuf/t4eDwEZ9Etq0XkP3CF3q9HaOPiDGjZ4wsmsSXA60LtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572239; c=relaxed/simple;
	bh=GEGWc/XxgeRAFafF0SAHIMfS+1Ne1BKISwPtjIBH8cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdhNW7Qz1HE3MC0k+Y+qyhUb5wWXXAuYc8GrffmmfPTrfVRy6/GmUELE0VBcBAQMsN3Xdmt7g4sPp+O4aSrch+LLw9uhGMHsKGnINZFKBdIPjla6Fd8rozEO2zs5yfk1dCklHlry5WwNd6d+EXtOnjvXAEMONxs/xbw+KD20S/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fs/AQod8; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a51abd0d7c2so371968466b.2;
        Mon, 08 Apr 2024 03:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712572236; x=1713177036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDrTyP2Vy4iVLI6V80x+ZoMCFhWQosP2tXbTa3RDay8=;
        b=fs/AQod86L+wLdKHBOaLTMdj37ZH4nrPdivl7h2EH6UhVeis7Rl+P7hqVTyoXY5wCz
         n4uhFQ/n4ccg5KkPxIIDCHZPmp0XGrHWq616Gy7t3GcZ7RZzKonDMLX2tG3U3BtILZbL
         0HEAdbXcQ6BRUxv3wcQLiTBknrCBjXDAWjQklfYKwTKp2Sm35ACV7RAKuc16LYgTZhYu
         x809Qlk+S0osj3Fvyt95fMJ5dKg1UCaW56eEyl0zHlpuYLr30G8sLqGjqmwxTQ2/NJUL
         AW6I1nvAEd7QSj6EYA1bfwbNVW1WkvuVfxVgXdJ0rI07C7EzeNxPX5x/2CWO1InbFNtI
         eZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712572236; x=1713177036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDrTyP2Vy4iVLI6V80x+ZoMCFhWQosP2tXbTa3RDay8=;
        b=areTsULTnIWSzovhnGITHDdPZCebmhXtE9YjUYJvCyOoYGgdbLzUB+IHmgcFYDpl5K
         8QBDiNSnzQoXU71vryL0c2P6H/6jVioOEBhHkegVRrMzNqhbAsjgOitaRqbf7Kpd2lh5
         RmOayBphywU7C07icUVx6uMJeWV20rHm99FQKQ/ZsOutrTyrusmj0nuZV4eG8CEE9J5k
         bsuSEhska2msMcnAmS6LsNmVvyQ+15neQQ/bST6SvApcGRE4rroeOPslCNHR8Rn8eXNb
         ewRyk3lu7UPscKuGFaqVnN0wzbYHPqMhRHH2hQ6yZQrQA18d0F+p0hQdgFwb0L7rqbNa
         pI3w==
X-Forwarded-Encrypted: i=1; AJvYcCWt7VJzMBYHafaYYTFm0D3uKaTSXiZvPIiwlJWuTIGMOiLOae5GrUaOFOj8lp8NwnUTz4Grnw5qESP4crhL6l+fbDsPXIcwsqQO6jJf5PVLm6uRq7ARr8obT6Eh2sSW7UjIIh0nB/l+7J+t
X-Gm-Message-State: AOJu0YxxwkgEyBHJlvjmqsXRuh7I823heA9UnFfYBtI+2YZovFQIRsEo
	GjdVGCEaRRcvjq9VGKOMBFYJJo9aDC68MDkS+n7/n+fpanfx3rpKBY2U0ytRu5dRK9yzfyTuPWv
	5x3By3l30Z4gR5qkUazh5t4USwbM=
X-Google-Smtp-Source: AGHT+IHrzBrC48Lrtrj0shD3qgiyxsJ2BMGxhjJ541np4p2WV47+CJO76OS97mZZAM7ikNc4i6v64annsIx0/tuLNHw=
X-Received: by 2002:a17:906:f218:b0:a51:a676:db26 with SMTP id
 gt24-20020a170906f21800b00a51a676db26mr5349858ejb.21.1712572236205; Mon, 08
 Apr 2024 03:30:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zg3WicDB8m9am7dJ@surfacebook.localdomain> <20240408014453.1431652-1-liu.yeC@h3c.com>
In-Reply-To: <20240408014453.1431652-1-liu.yeC@h3c.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 8 Apr 2024 13:29:59 +0300
Message-ID: <CAHp75Vd3xAxmEEHHTXWvKYtieV+kUmP+L+tQGq30YDH9S2hc-w@mail.gmail.com>
Subject: Re: Re: [PATCH V8] kdb: Fix the deadlock issue in KDB debugging.
To: LiuYe <liu.yeC@h3c.com>
Cc: daniel.thompson@linaro.org, dianders@chromium.org, 
	gregkh@linuxfoundation.org, jason.wessel@windriver.com, jirislaby@kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 4:46=E2=80=AFAM LiuYe <liu.yeC@h3c.com> wrote:
> >Wed, Apr 03, 2024 at 02:11:09PM +0800, liu.yec@h3c.com kirjoitti:

..

> >Ouch.
> >Please, read this
> >https://www.kernel.org/doc/html/latest/process/submitting-patches.html#b=
acktraces-in-commit-messages
> >and modify the commit message accordingly.
>
> The example is the printout of the kernel lockup detection mechanism, whi=
ch may be easier to understand.
> If organized according to the format provided in the previous link, shoul=
d it be arranged as follows?

Do you think all lines are important from this?
Do you think you haven't dropped anything useful?

If "yes" is the answer to both Qs, then go with it (but at least I see
that first seems to me as "no", some lines are not important)


> Example:
> BUG: spinlock lockup suspected on CPU#0. owner_cpu: 1
> CPU1: Call Trace:
> __schedule
> schedule
> schedule_hrtimeout_range_clock
> mutex_unlock
> ep_scan_ready_list
> schedule_hrtimeout_range
> ep_poll
> wake_up_q
> SyS_epoll_wait
> entry_SYSCALL_64_fastpath
>
> CPU0: Call Trace:
> dump_stack
> spin_dump
> do_raw_spin_lock
> _raw_spin_lock
> try_to_wake_up
> wake_up_process
> insert_work
> __queue_work
> queue_work_on
> kgdboc_post_exp_handler
> kgdb_cpu_enter
> kgdb_handle_exception
> __kgdb_notify
> kgdb_notify
> notifier_call_chain
> notify_die
> do_int3
> int3

..

> >>  #include <linux/module.h>
> >>  #include <linux/platform_device.h>
> >>  #include <linux/serial_core.h>
> >> +#include <linux/irq_work.h>
> >
> >Please, keep it ordered (with visible context this should go at least be=
fore
> >module.h).
>
> I don't understand why this needs to be placed before module.h. Please ex=
plain further, thank you.

Alphabetical order helps long-term maintenance. Yes, I know that it is
not _fully_ sorted, but don't add more mess to it.

--=20
With Best Regards,
Andy Shevchenko

