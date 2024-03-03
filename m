Return-Path: <linux-kernel+bounces-89910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C91986F72D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D6E1C20A18
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF33F7A706;
	Sun,  3 Mar 2024 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JY1J8DdB"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BF8A957;
	Sun,  3 Mar 2024 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709500806; cv=none; b=LTZH+F3zSfbg9cxcN8pi/zgyuJVRhSHcOOb3HvQM/SPgO3wcQGdjW2W1UfavKmBPP6DcUXM8EnaOE/kpCpri+lZ/+zMZatOBSaMS3o0Ga1RdCwfDeMaoBuhf/vyVuFOYiDamLQfnYnaRcAo+K9m72snnS8z158JUA5vJuHlg7As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709500806; c=relaxed/simple;
	bh=b1+PGDPg3AaCd4KGYAy/tgATvccAE7wfNpG/Ok+p19I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlUOJNoctnv8wlB1EaqTZ/+OpbY6tE9bvOxNyicVK7ddvtcAcktNI7mgET9S9JatehxytJIS2ywh0g0fAmJm78R4zRFLTPjBlppKt3z6Bf+w6+Wao2P/QAsFlCsHfHjcJLGk8oNhKEy4z2OpKFbDht0dKzbJKmumQLrqek8tJUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JY1J8DdB; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d311081954so42019111fa.2;
        Sun, 03 Mar 2024 13:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709500802; x=1710105602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BwYkjBXlBZesoIUNfa0a3rUePDN3R4LPFfw17Gvsbs=;
        b=JY1J8DdByHMwTQK+qO9xnml1DaSXZMAdWdzz6fCIbi1zTRnt5V8jNTSglbT28ogMLu
         rAI67tE3zSuywEdNJ2AYwy08DnVUO0v5MHqJGbAm87SG2hN46ABtrSgIBT814DQPCEav
         g1ICN69E4BP84qenVfr5scZYK94qCRMHVE48Sffe1Xn61k7etoT7JfR6QK7Kn8ODDmRt
         6sa3nw2/FMIxe8Q5VuQ5NxvlfRVFOrQsZAP4R8nGrrTUt7FJj6KYa2Y6idbRvBIQ1v4t
         q/ryPC03yKEJKIKU2bv5Iph/+p/vLrNhY7fCbX9YD+r0qIInRqs0KgOmoE8hlzvDUqUx
         ljEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709500802; x=1710105602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BwYkjBXlBZesoIUNfa0a3rUePDN3R4LPFfw17Gvsbs=;
        b=LOURs2GgTA5T1X+g2tRTfBktmUSp2XPPYz6db4wwNxL5dLPRkhwGzNBTA0Ynt8zZ/l
         6VVvP2rs1JFCVsiULqeQxLVaSrzjnRRLEkU5NMwt21qBy1r8TKyDRCJA0+YW5U+ih6IO
         N636eD1w6an4q0hLVU+k8TMuFxO5T6dWzatvrhJumzyT8Ts3eq/tnEGcY8wTyIYOVtJs
         7ulQ/UBISfCTYXIA5sPyzmj7GxGqBhZU2R6Az2MnUkgiuWQmqszXZuecB5Po25qBG0Wr
         VAppd3n6SwuauF603jFNTPiyo5/1tvo2DaRG+yACqGgcOcwCb3BdInQnk3Xqoou/623P
         fjyA==
X-Forwarded-Encrypted: i=1; AJvYcCUD5uRAkQg0Am+Du0SJBXHiAfg30XHTIKcShLAzlTSFroXLfvUB2Zxq65rNmTXshceRGD/MhLH72ui5vx7DUDfDcZsIhp5+zxnqXENzpJqGlzNTFvPu8AgPxnIKYLkmcb4WesCoNQQsaHhz
X-Gm-Message-State: AOJu0YyY6q3eQq1+XmnOD2bD8xyiAMgHn8HHyDpQBg70WHYgNHhe2Fw2
	j5kFZd7lkIYh74rE4Rp4ErTT0qzT+CYnCksmfGVuHCKC+kI12Rk99FKxKjY37T3rkxAne2+0CsK
	Qwb+pNf2JSLUdSPjiuRekJT/igB18VyMgOvM=
X-Google-Smtp-Source: AGHT+IFeOfOK6bx9XjIbBUV/ro9/M9cYaBUN1wdFhPsEa+HXrbjG+tPS3TvhIw/LocOC5VYdXXXAFZGpDAO0VhFV6pE=
X-Received: by 2002:a05:651c:1689:b0:2d2:9fc2:9bb8 with SMTP id
 bd9-20020a05651c168900b002d29fc29bb8mr4590358ljb.25.1709500802496; Sun, 03
 Mar 2024 13:20:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403020457.RCJoQ3ts-lkp@intel.com> <87edctwr6y.ffs@tglx>
 <87a5nhwpus.ffs@tglx> <87y1b0vp8m.ffs@tglx> <87sf18vdsq.ffs@tglx>
 <87le70uwf0.ffs@tglx> <CAHk-=wiWhfdc4Sw2VBq_2nL2NDxmZS32xG4P7mBVwABGqUoJnw@mail.gmail.com>
 <87edcruvja.ffs@tglx> <CAFULd4bVEUBEidTLbHNzRaJbSjXm99yC8LT=jdzFWb7xnuFH7g@mail.gmail.com>
 <87bk7vuldh.ffs@tglx> <CAFULd4arHT+_fy9_oUNpmsvyfVPGaeB_pdeuqVS3UTpP5R757A@mail.gmail.com>
 <CAFULd4b0HN6eUJsOW6po8Hf16T3eMhjdKUvw-TS8yncNn-+Vyw@mail.gmail.com>
In-Reply-To: <CAFULd4b0HN6eUJsOW6po8Hf16T3eMhjdKUvw-TS8yncNn-+Vyw@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 3 Mar 2024 22:19:50 +0100
Message-ID: <CAFULd4ZQwhASjvfya6eYv+9hMf=aQmSpW0wLSKPES4DRm0qeWQ@mail.gmail.com>
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Arjan van de Ven <arjan@linux.intel.com>, x86@kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 9:24=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> On Sun, Mar 3, 2024 at 9:21=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wr=
ote:
> >
> > On Sun, Mar 3, 2024 at 9:10=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
de> wrote:
> > >
> > > On Sun, Mar 03 2024 at 20:03, Uros Bizjak wrote:
> > > > On Sun, Mar 3, 2024 at 5:31=E2=80=AFPM Thomas Gleixner <tglx@linutr=
onix.de> wrote:
> > > >> I did not follow the __set_gs work closely, so I don't know whethe=
r Uros
> > > >> ever tried to actually mark the per CPU variable __set_gs right aw=
ay,
> > > >> which would obviously catch the above 'foo' nonsense.
> > > >
> > > > No, because [1]:
> > > >
> > > > "gcc does not provide a way to remove segment qualifiers, which is =
needed
> > > > to use typeof() to create local instances of the per-cpu variable. =
For
> > > > this reason, do not use the segment qualifier for per-cpu variables=
, and
> > > > do casting using the segment qualifier instead."
> > >
> > > Right. I just figured that out myself when playing with it in user
> > > space.
> > >
> > > That's so sad because it would provide us compiler based __percpu
> > > validation.
> >
> > Unfortunately, the c compiler can't strip qualifiers, so typeof() is
> > of limited use also when const and volatile qualifiers are used.
> > Perhaps some extension could be introduced to c standard to provide an
> > unqualified type, e.g. typeof_unqual().
>
> Oh, there is one in C23 [1].
>
> [1] https://en.cppreference.com/w/c/language/typeof

FYI: gcc-14 compiles this testcase:

--cut here--
__seg_gs int a;
__typeof_unqual__(a) b;

int foo (void)
{
  return a;
}

int bar (void)
{
  return b;
}
--cut here--

to (gcc -O2):

foo:
       movl    %gs:a(%rip), %eax
       ret

bar:
       movl    b(%rip), %eax
       ret

So, it *does* strip the __seg_gs qualifier here.

Uros.

