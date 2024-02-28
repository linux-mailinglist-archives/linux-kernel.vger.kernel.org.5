Return-Path: <linux-kernel+bounces-84300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA7986A4B8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025F4284555
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0EC3FE1;
	Wed, 28 Feb 2024 01:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hswSztvp"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B93720EE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709082291; cv=none; b=IwXm90/CuQfJxP1VdgDhJcMf/OscnJ0hqKQWk+qjBzDJUpDvxK/wnANQjZreHPEAMU4tFSb+9ajQoijZm1TUF+7xfKuKrJwam9vZLBc0nctj1xrgm43E2TtC9/S6k95qPGrBri1hJsPlL+6Tx5wAOR2PuR9YeV5xTO1wKqT8Rfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709082291; c=relaxed/simple;
	bh=J52l5GvbPpvQV0SlI1cajTdwoGcxKSQNv/+Bf2T6xFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0sCWmO29RwS4Mksee5FStx5mOvNFLmoaAi846J1L7oS1mDUdEsijUVwhozDeHGAFbZPpgqiRjdHdVzrAbWeIa7i36GSL1Kb2DjbkRj8V4R17ROXcRTWHPjCL45QgZRpcvVvRLCTPaMTsbwnwFFFHRMYUwTHIApK/Cuux1HMeeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hswSztvp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3e85a76fa8so476317466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709082287; x=1709687087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xr41oLUL07lwHIIdNtUg07Bh7MIOah2pszh7uTbsMgM=;
        b=hswSztvpWVr6DS8Ds9o6XsJT8cqWX2ckmIMH0dJyFmELue6dPmIGuAEBVuKBkbnFSy
         9SvuilOisI3qtsQi0X0I3ehZMINu4Z1/z7+CsJFyMCf65rmdR7LwgH6RMpGPTxQuyJcP
         +yyJbDg2e07QOSb+bEqJHHaMqMR/ZmW+BtwVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709082287; x=1709687087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xr41oLUL07lwHIIdNtUg07Bh7MIOah2pszh7uTbsMgM=;
        b=BPtCj4EJzdQASDjhwfUO5tnllBUC6h2Dr25tXH9mCpc513RbmtsV9FVp1az59dq40N
         v2GSRpG0OnGjVy9d2X/xBQqQoYXFpZm8LCj/1Txnyd3Ihg+G/O6vakA1lvl+Frnu8S6E
         vsQgLQ+YYY1IJY2V5dnKNbQKL+JH9Zdbhs7BrL52leKYYdzZh9NTaUW/G4hsKSGSivTM
         VAbTX70mbB5ehL+L5upd+BLwrY8j379en5H2hEwrhVvptCjtbZIcMhPnEjjsGvPDM2JO
         BcaggRUSp3qqXecaPXlAuY+FBB7y1lQ5aFqCRPmoCDQl8P+TyLmyexnuE57jZtn5WEmt
         uLVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDBYdR9SeV6OCIWg/3cwnPv/Q6ZR2r4mr1IHz4DvcI2pgql0YW8P8mUTVmqUq/FkQcZQTtPm8rxoXG/HqpuznHmxJ2AxtPJs5RNqSg
X-Gm-Message-State: AOJu0YwYiYI9jQ9nuPLIpYeReLnD+fM9qeHbpw0YxgGbSD2pIA9P90Pa
	6ODVL9hvc6Ei00ErYP/KVNDtV7/BO2dFkEm4m+fdzzjL8d7BfWXAoL9SjInFYbvI4fE+LXcbEhV
	zI6kC
X-Google-Smtp-Source: AGHT+IEuOYK2XJ45rzkHSeQHAvStvuGI2owh+ZPh9KkKukQDfb9ZmeAF+bhzHJi3uM7piNFoNIyZ5Q==
X-Received: by 2002:a17:906:454e:b0:a42:fb21:5066 with SMTP id s14-20020a170906454e00b00a42fb215066mr5922860ejq.31.1709082287618;
        Tue, 27 Feb 2024 17:04:47 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id vb4-20020a170907d04400b00a3fd1999942sm1291785ejc.124.2024.02.27.17.04.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 17:04:47 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso6293a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:04:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgHAKbRDhGoIBXFiWaP8T7iQEsaYLy3RXp+khDgJx5zRIQIh7NDtwntAS6aD2KyC6EepomMF3BBfPEu7JNdZjPNo0KRZ89Od8o2tdy
X-Received: by 2002:a05:600c:a39c:b0:412:985b:a1e1 with SMTP id
 hn28-20020a05600ca39c00b00412985ba1e1mr33142wmb.4.1709081866214; Tue, 27 Feb
 2024 16:57:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <CAD=FV=WtJCkdSY=HYDmBjn3hc4TYT7j0bMxGCV-=B3o3bm-kpQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WtJCkdSY=HYDmBjn3hc4TYT7j0bMxGCV-=B3o3bm-kpQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 27 Feb 2024 16:57:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XMkrWmA1D6UjdTs8oZiXxKc1xiUoRqtNqAE-7GoPk8mA@mail.gmail.com>
Message-ID: <CAD=FV=XMkrWmA1D6UjdTs8oZiXxKc1xiUoRqtNqAE-7GoPk8mA@mail.gmail.com>
Subject: Re: [PATCH] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Misono Tomohiro <misono.tomohiro@fujitsu.com>, Chen-Yu Tsai <wens@csie.org>, 
	Stephen Boyd <swboyd@chromium.org>, Daniel Thompson <daniel.thompson@linaro.org>, 
	Sumit Garg <sumit.garg@linaro.org>, Frederic Weisbecker <frederic@kernel.org>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, 
	Valentin Schneider <vschneid@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 8, 2024 at 4:54=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Thu, Dec 7, 2023 at 5:03=E2=80=AFPM Douglas Anderson <dianders@chromiu=
m.org> wrote:
> >
> > When testing hard lockup handling on my sc7180-trogdor-lazor device
> > with pseudo-NMI enabled, with serial console enabled and with kgdb
> > disabled, I found that the stack crawls printed to the serial console
> > ended up as a jumbled mess. After rebooting, the pstore-based console
> > looked fine though. Also, enabling kgdb to trap the panic made the
> > console look fine and avoided the mess.
> >
> > After a bit of tracking down, I came to the conclusion that this was
> > what was happening:
> > 1. The panic path was stopping all other CPUs with
> >    panic_other_cpus_shutdown().
> > 2. At least one of those other CPUs was in the middle of printing to
> >    the serial console and holding the console port's lock, which is
> >    grabbed with "irqsave". ...but since we were stopping with an NMI
> >    we didn't care about the "irqsave" and interrupted anyway.
> > 3. Since we stopped the CPU while it was holding the lock it would
> >    never release it.
> > 4. All future calls to output to the console would end up failing to
> >    get the lock in qcom_geni_serial_console_write(). This isn't
> >    _totally_ unexpected at panic time but it's a code path that's not
> >    well tested, hard to get right, and apparently doesn't work
> >    terribly well on the Qualcomm geni serial driver.
> >
> > It would probably be a reasonable idea to try to make the Qualcomm
> > geni serial driver work better, but also it's nice not to get into
> > this situation in the first place.
> >
> > Taking a page from what x86 appears to do in native_stop_other_cpus(),
> > let's do this:
> > 1. First, we'll try to stop other CPUs with a normal IPI and wait a
> >    second. This gives them a chance to leave critical sections.
> > 2. If CPUs fail to stop then we'll retry with an NMI, but give a much
> >    lower timeout since there's no good reason for a CPU not to react
> >    quickly to a NMI.
> >
> > This works well and avoids the corrupted console and (presumably)
> > could help avoid other similar issues.
> >
> > In order to do this, we need to do a little re-organization of our
> > IPIs since we don't have any more free IDs. We'll do what was
> > suggested in previous conversations and combine "stop" and "crash
> > stop". That frees up an IPI so now we can have a "stop" and "stop
> > NMI".
> >
> > In order to do this we also need a slight change in the way we keep
> > track of which CPUs still need to be stopped. We need to know
> > specifically which CPUs haven't stopped yet when we fall back to NMI
> > but in the "crash stop" case the "cpu_online_mask" isn't updated as
> > CPUs go down. This is why that code path had an atomic of the number
> > of CPUs left. We'll solve this by making the cpumask into a
> > global. This has a potential memory implication--with NR_CPUs =3D 4096
> > this is 4096/8 =3D 512 bytes of globals. On the upside in that same cas=
e
> > we take 512 bytes off the stack which could potentially have made the
> > stop code less reliable. It can be noted that the NMI backtrace code
> > (lib/nmi_backtrace.c) uses the same approach and that use also
> > confirms that updating the mask is safe from NMI.
> >
> > All of the above lets us combine the logic for "stop" and "crash stop"
> > code, which appeared to have a bunch of arbitrary implementation
> > differences. Possibly this could make up for some of the 512 wasted
> > bytes. ;-)
> >
> > Aside from the above change where we try a normal IPI and then an NMI,
> > the combined function has a few subtle differences:
> > * In the normal smp_send_stop(), if we fail to stop one or more CPUs
> >   then we won't include the current CPU (the one running
> >   smp_send_stop()) in the error message.
> > * In crash_smp_send_stop(), if we fail to stop some CPUs we'll print
> >   the CPUs that we failed to stop instead of printing all _but_ the
> >   current running CPU.
> > * In crash_smp_send_stop(), we will now only print "SMP: stopping
> >   secondary CPUs" if (system_state <=3D SYSTEM_RUNNING).
> >
> > Fixes: d7402513c935 ("arm64: smp: IPI_CPU_STOP and IPI_CPU_CRASH_STOP s=
hould try for NMI")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > I'm not setup to test the crash_smp_send_stop(). I made sure it
> > compiled and hacked the panic() method to call it, but I haven't
> > actually run kexec. Hopefully others can confirm that it's working for
> > them.
> >
> >  arch/arm64/kernel/smp.c | 115 +++++++++++++++++++---------------------
> >  1 file changed, 54 insertions(+), 61 deletions(-)
>
> The sound of crickets is overwhelming. ;-) Does anyone have any
> comments here? Is this a terrible idea? Is this the best idea you've
> heard all year (it's only been 8 days, so maybe)? Is this great but
> the implementation is lacking (at best)? Do you hate that this waits
> for 1 second and wish it waited for 1 ms? 10 ms? 100 ms? 8192 ms?
>
> Aside from the weirdness of a processor being killed while holding the
> console lock, it does seem beneficial to give IRQs at least a little
> time to finish before killing a processor. I don't have any other
> explicit examples, but I could just imagine that things might be a
> little more orderly in such a case...

I'm still hoping to get some sort of feedback here. If people think
this is a terrible idea then I'll shut up now and leave well enough
alone, but it would be nice to actively decide and get the patch out
of limbo.

FWIW the serial console dumping issue that originally inspired me to
track this down has been worked around at least well enough to not
spew garbage in my console. See commit 9e957a155005 ("serial:
qcom-geni: Don't cancel/abort if we can't get the port lock"). It's
still a little awkward because we'll be running fully lockless during
panic time, but it seems to work...

-Doug

