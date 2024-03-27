Return-Path: <linux-kernel+bounces-120177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6603188D3C4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7ACC2C7785
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E341CD23;
	Wed, 27 Mar 2024 01:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asZrNfI6"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9017BD2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711503263; cv=none; b=GLIABGr5biJh8ftPRVT1Yl+yaMwPrJuVWmnnfxDK/WLudkvSmAaNwcPuY/Eb6eYuts0Bmnb8/A0tneC2sIhnzW+ptvZb4lFtiJbfirIKOfGb0Mmg2skk3jPOCZg7bavLt6VovNBShDKgZxUkiTxhnF652WV3GMjgwSMqobhPIj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711503263; c=relaxed/simple;
	bh=f73qLbMMBJKUFLQcYp+jfmn3MzoXvcHWVQAHEnqfeK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKj8KrkUYZvBEdwtNSTJMUEkmo7xVa3Pz6A/R6kvhPXJy7q+KOyTJWSQJvUpYRj0ImzCPTKy9A/f0qclUSVklezFlR9T0HJ7z4+Fgb1yApVrH56uSbiF1gIi2Clqu+UyuUp6gNGRRKfjzmyeWp7QQ0u/bG0s8Ij0/Ujy2ykhZd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asZrNfI6; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-47679ac2798so1662776137.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711503260; x=1712108060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCYB7c+BMWHnOOEe3cAwNiyes927XAOxAN0PxG44CVM=;
        b=asZrNfI666mVFLSP1i3XmtxZnZ2boYgES0mq0b6KhXlhxFUNZuiqvFRp/Lw11SvBi6
         1yYLV78Is/+ZhD6D0Wy2ej2O8icBlfksbSYcAhj1eUb6FbfOjzz11aUT83Da06tMDvmO
         vEC1TQaXSbBL88RF2S2id96TuKTtZ9CK1va1GfVKnoiqdV5BK1lX4ZTiJPlyTnz2Jw87
         B2HBT+5r/qV+FRAr2p8tJjxsxsXh8YrbYa0O0N168Xp0vwUnSMT++Hp6GZcdH9UBnJPn
         u6/e43WtNy23LBP1f2Rl2uLzQNgcm67dqTaJ5vszrQuhQQ/OYK9hihTJ37cipgMDvAZZ
         AsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711503260; x=1712108060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCYB7c+BMWHnOOEe3cAwNiyes927XAOxAN0PxG44CVM=;
        b=QJuXy86ZNeWFNtg53WL1ojAXHZimTPyxuaYXcdMw30Mc7upTMSJdWtAydioLfdWtIy
         N69IYBqv3ae0UxOPgouLRtmVNZlMP9z5hI8DOpjAe/ICM78RqifoovCGLVuc4iFe8vj9
         sLeMIgEbZRiegWLhG8EzHK4g9YsLtUc84sXoRakt0K1DSRDuRPjl3oGHv1rEYKG3+6ba
         tlqIuQUs55MhOWw3AbyLkG56r4BNwWX3SxRRgk2tHv2X1Sx7gtFnofBc0SSJtDx6xH52
         Hxjo+JtGVMl5L/MjUW4PbajIBPcM3kE9qP43o9xZX99ZtW46aH2hAWQ8nKIUhMA+nYIG
         9YBA==
X-Forwarded-Encrypted: i=1; AJvYcCUno+rsIEy97aKw2c1rmrRn9YDTB/evgbJ5me4Ecv+Hjy4C0VXnTsHwjGp3cUd1SRNiD4FngSa3iSFjZYwDAXnQQgaHLmMvAiJGfbFI
X-Gm-Message-State: AOJu0YwhF5GHZELq8f/pJi6+iLkaPT4lc1shX7XaNYhTquMfG/5SFKAn
	mbOL4xDD+Ws5WG0uu1JaIDQOGOSnozBaa965mhi1pXk3IH6bEpqgqkdVh+RkECwpcmLz184jF9x
	DiTHxkjuRdo5cnAAugm8v0RHBUeo=
X-Google-Smtp-Source: AGHT+IGcOWldV2TYE5N0G/Ct0a7Zt3ICmaV1ZDUQCub4y7h5dq1o3m51b3vR3b0n7p3KF5iHGCAzfwGleI/UKNanIT8=
X-Received: by 2002:a67:e91a:0:b0:476:d5f9:bf96 with SMTP id
 c26-20020a67e91a000000b00476d5f9bf96mr8044725vso.0.1711503260425; Tue, 26 Mar
 2024 18:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a49546e8-6749-4458-98da-67fd37b7df18@rivosinc.com>
 <mhng-a3b495e6-aca6-4137-a3c1-8fcacafd8596@palmer-ri-x1c9a>
 <ZfLxip96o5MVjHAF@xhacker> <ZfL1buKdDI-p5b9X@xhacker> <ZgGteKG_a3KGn5wV@xhacker>
 <CAGu26P_tUpSvXqdSz3pOdPNHbe6MyEYJ2XCHo8pD8jeE5pT+_Q@mail.gmail.com> <ZgNzBwsmeibHMjvc@xhacker>
In-Reply-To: <ZgNzBwsmeibHMjvc@xhacker>
From: Charles Lohr <lohr85@gmail.com>
Date: Tue, 26 Mar 2024 18:34:09 -0700
Message-ID: <CAGu26P-CqdsQzNTNDidBUg=pxU3vs7QhNEajokGKe7p8M2sLBA@mail.gmail.com>
Subject: Re: [PATCH] riscv: deprecate CONFIG_MMU=n
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, cleger@rivosinc.com, 
	Conor Dooley <conor@kernel.org>, samuel.holland@sifive.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, ajones@ventanamicro.com, dlemoal@kernel.org, 
	Bjorn Topel <bjorn@rivosinc.com>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, if you don't mind clarifying, do you know which version you
used, where you got it, and if you had to apply any patches?

Charles

On Tue, Mar 26, 2024 at 6:28=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> On Tue, Mar 26, 2024 at 01:25:08PM -0700, Charles Lohr wrote:
> > Jisheng, are you using musl or uclibc? I've been having difficulty
> > getting new versions of each working with the newer kernels with
> > system calls not lining up.
>
> Hi Charles,
>
> I tested nommu linux with uclibc, both rv32 and rv64
>
> Thanks
>
> >
> > Also, is there a better place to ask questions about the more
> > user-spacy stuff?  That's really where I've been struggling to
> > maintain things, keeping buildroot working when targeting RV32 NOMMU.
> > Thankfully a lot of the stickiest problems have all been upstreamed.
> >
> > Charles
> >
> > On Mon, Mar 25, 2024 at 10:12=E2=80=AFAM Jisheng Zhang <jszhang@kernel.=
org> wrote:
> > >
> > > On Thu, Mar 14, 2024 at 09:02:43PM +0800, Jisheng Zhang wrote:
> > > > On Thu, Mar 14, 2024 at 08:46:21PM +0800, Jisheng Zhang wrote:
> > > > > On Tue, Feb 27, 2024 at 08:38:50AM -0800, Palmer Dabbelt wrote:
> > > > > > On Tue, 27 Feb 2024 01:11:41 PST (-0800), cleger@rivosinc.com w=
rote:
> > > > > > >
> > > > > > >
> > > > > > > On 26/02/2024 20:00, Charles Lohr wrote:
> > > > > > > > WOAH! Please DO NOT deprecate NOMMU. I use the NOMMU build =
constantly
> > > > > > > > and NOMMU Linux on RISC-V is the avenue used by many FPGA s=
oft cores
> > > > > > > > for Linux, as well as some limited systems.
> > > > > >
> > > > > > OK.
> > > > > >
> > > > > > I just build test this stuff, as I don't really have a use for =
it
> > > > > > personally.  I figured if nobody's reporting bugs then probably=
 it's broken
> > > > > > and nobody's noticed because nobody's using it.
> > > > > >
> > > > > > > > I get new copies of the kernel when there are releases and =
test them
> > > > > > > > frequently to make sure everything is still working as expe=
cted.
> > > > > >
> > > > > > I'd actually expected it to be broken, but I guess we managed t=
o avoid
> > > > > > screwing things up ;)
> > > > > >
> > > > > > > > For us we just don't care about XIP. I mean if someone did =
push it
> > > > >
> > > > > I don't care XIP either, and IMHO the XIP's maintenance effort is=
 much
> > > > > bigger than NOMMU(just check the various XIP_FIXUP* or CONFIG_XIP=
_KERNEL
> > > > > macros around lowlevel pgtable.h, page.h). If we can remove XIP, =
the
> > > > > code readability will be much better.
> > > > >
> > > > > Or sending out a similar XIP deprecation patch to see whether the=
re's
> > > > > any complain ? ;)
> > > > >
> > > > > > > > through to fruition, I'd also test and use it, but I urge y=
ou please
> > > > > > > > do not deprecate this.  While it's sometimes needed a bit o=
f a
> > > > >
> > > > > +1 for urge the upstream please do not deprecate NOMMU.
> > > > >
> > > > > Besides the soft(FPGA) core mentioned by Charles, here is another=
 real
> > > >
> > > > And I'd like to write more about soft core: riscv is a free and ope=
n
> > > > ISA, this make it really good for education, for simple riscv
> > > > implementation or emulator. Once riscv IMA is implemented(even if M=
MU,
> > > > cache, TLB stuff don't exist), it's not far away from making linux
> > > > running on the FPGA or emulator. If the gain is larger than the mai=
ntenance
> > > > effort, I'd like to urge keeping the NOMMU support.
> > > >
> > > > Thanks a lot
> > > >
> > > > > usage case: As is known, Sophgo CV1800B platforms such as Milk Du=
o
> > > > > contains two C906 core, one(a.k.a big core) with MMU another(a.k.=
a small
> > > > > core)w/o MMU. The vendor sdk runs freertos on the small core, but=
 it
> > > > > doesn't prevent users to run other OS such as threadx, zephyr or =
nommu
> > > > > linux on the small core. In fact, I sucessfully brought up nommu =
linux
> > > > > on the small core. I didn't just send out the patches in time dur=
ing this
> > > > > dev window duo to my personal career reason(I spent the time on h=
unting
> > > > > for a new job)
> > > > >
> > > > > I plan to send out NOMMU related patches once 6.9-rc1 is out.
> > >
> > > As is promised, the NOMMU improvement patches are sent out
> > > https://lore.kernel.org/linux-riscv/20240325164021.3229-1-jszhang@ker=
nel.org/T/#t
> > >
> > > Thanks
> > >
> > > > >
> > > > > > > > creative build to get everything working, I've never needed=
 to patch
> > > > > > > > anything in the kernel beyond patching in a custom console =
for serial
> > > > > > > > output.
> > > > > > > >
> > > > > > >
> > > > > > > Hey Charles,
> > > > > > >
> > > > > > > No worries, we actually did not expected NOMMU to have *so ma=
ny* users.
> > > > > > > I guess deprecating stuff is a good way to have immediate fee=
dback ;).
> > > > > > > Having FDPIC psABI to be merged upstream could also probably =
be a
> > > > > > > positive point toward a better NOMMU support.
> > > > > >
> > > > > > Ya, that's probably the right way to do it.  Touching anything =
in the psABI
> > > > > > is pretty miserable, though, so I don't really want to force pe=
ople to do
> > > > > > it...
> > > > > >
> > > > > > > > I am happy to discuss the possibility of me and or one of t=
he other
> > > > > > > > RISC-V soft (FPGA) core people stepping up to try to be mor=
e active,
> > > > > > > > but so far we've just been very well serviced by the curren=
t NOMMU
> > > > > > > > Linux setup.
> > > > > > >
> > > > > > > It could probably be nice to have some feedback/Tested-by: fr=
om NOMMU
> > > > > > > users for new releases then.
> > > > > >
> > > > > > Having more upstream interaction from users is always appreciat=
ed, that's
> > > > > > the best way to prove people are using the code.  If you guys h=
ave the time
> > > > > > it'd be great to get this into some sort of CI, ideally running=
 on some real
> > > > > > platform.
> > > > >
> > > > > As above, I'd also like to step up on the NOMMU stuff, at least t=
est
> > > > > nommu on milkv duo's small core. And can be seen from my git comm=
it
> > > > > histotry, I was active, and I belive I will still be active on ri=
scv linux
> > > > > kernel development.
> > > > >
> > > > > >
> > > > > > > Thanks,
> > > > > > >
> > > > > > > Cl=C3=A9ment
> > > > > > >
> > > > > > > >
> > > > > > > > Charles
> > > > > > > >
> > > > > > > >
> > > > > > > > On Mon, Feb 26, 2024 at 8:03=E2=80=AFAM Conor Dooley <conor=
@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Feb 26, 2024 at 04:25:24PM +0100, Cl=C3=A9ment L=
=C3=A9ger wrote:
> > > > > > > > > > I guess I could also mark XIP as deprecated.
> > > > > > > > >
> > > > > > > > > I'm not so sure, people recently added XIP support to QEM=
U (and sent
> > > > > > > > > kernel fixes in December). XIP is also not nearly as much=
 of a problem
> > > > > > > > > to support, there's far less that it does differently, th=
e main barrier
> > > > > > > > > was the inability to test it which is no longer the case.
> > > > > > > > > That said, XIP is gonna kill itself off I feel as it does=
 not support
> > > > > > > > > runtime patching and therefore is extremely limited on ex=
tensions, given
> > > > > > > > > we use alternatives for all of that (although I suppose i=
f someone has a
> > > > > > > > > usecase they could make nasty macros worse and implement =
a compiletime
> > > > > > > > > switch in the alternatives too).
> > > > > > > > >
> > > > > > > > > Cheers,
> > > > > > > > > Conor.
> > > > > > > > >
> > > > > > > > > _______________________________________________
> > > > > > > > > linux-riscv mailing list
> > > > > > > > > linux-riscv@lists.infradead.org
> > > > > > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > > > > >
> > > > > > _______________________________________________
> > > > > > linux-riscv mailing list
> > > > > > linux-riscv@lists.infradead.org
> > > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv

