Return-Path: <linux-kernel+bounces-90063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C6E86F9AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C41B2113C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A6BC133;
	Mon,  4 Mar 2024 05:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W41nBSLf"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125EAAD5E;
	Mon,  4 Mar 2024 05:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709530992; cv=none; b=UumKhGOy/kBXw5NJSRC733ABpuEGStJDunSUfJShWXG6xtDxRxkKEKWP07Tc64LQr/rahtMOpsZtUKsYE38hHOO82ZBepDZLkNc1P1y3b6UJu58oMAphuczlS9wJmEvyBF/aXkxqpn9GFoMRnzwW8IuHLgYblmnCCCNrAYq5wAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709530992; c=relaxed/simple;
	bh=WGkZHzlyAWQ8ISw8UICIlbevVxrfqlLQ1gYQEskJp5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkQ04pq5oo0RLQyUvmwD5lqCqVHTspfKTbu5uoaztttvmsExCvXJL7rx+fTTzQWYKxlSbP3dUKaxnBDHKrPX2O3n81lP5TXl2sTUyvk0kq0gBZvqe3Od4FrDnhT+ipabv5x92S/VjIIB5D82EkUo6p/JHGR1YhgD2/L45+yDpNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W41nBSLf; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d26227d508so46181651fa.2;
        Sun, 03 Mar 2024 21:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709530989; x=1710135789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGkZHzlyAWQ8ISw8UICIlbevVxrfqlLQ1gYQEskJp5s=;
        b=W41nBSLf62H1Iwy/YE1u8aUptPHHnHW0NoD5wu9R12u0oe3iPpApy5DYSj6VAW4YXu
         gCgkA5RfzrzUNlILm0CiE23b4JtBNs/d5MueuAVtKjH9qrcDHXkTTlTcV8PE8up1dALe
         BtCpY0L01wJgNqIURUAAXxYlu5hbHIBUsTXPkDqnCQkjcP+9kPNDnCsFdZFobnviczTs
         6FJQ5jw63oCe1GXgJBeBKmALOe1i8hmGCZSSBHKk989Gk0iOVaptGawchYEOBXvAFB8Y
         TivS0dNkMNC9Tl0/WI5/OfX+hzftdBeMlZyKSLjsKpJ/HXrUTaVZ/gtCk249IK02mjc2
         S6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709530989; x=1710135789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGkZHzlyAWQ8ISw8UICIlbevVxrfqlLQ1gYQEskJp5s=;
        b=cWV11LBTw6/ooIkwauxMg8nUSeJZcmziZe8+JtpoQXgk4LybleUDyVQe9jvho6i6nC
         63/RSeRzW0oYzwQbOj+SGJOavPKWpg7xW7LI0j1rAcIKCy8CIimupJIH2RB+fDLYKdp4
         CCOjg1f292PXQNXaQq0mH7obeSmGLYZLRmRW6xbVcL4+rJGW6uwFdHgstQbmOsnX0d3h
         +wvPeTv9bcq98KEnjBdejVe3VwOfR9iYu2QqubhRl7krC2+3PkCe/QI0iPtPuQ4rrTMY
         JnNp0S2bZ7aukkoc21NinYM9sjeyAg+Q0gTcbI5kk48ugZoCWTSnaTAbO1RIM/BYjGRT
         YrFg==
X-Forwarded-Encrypted: i=1; AJvYcCWQaFqDssw06GOh/rRuA/0xByVyztAXhS1+KLW/m8BEI59XkJzHzFl13CEKOFy60tFHLxrktuhep+MjECqElXEP81r1mRx93UTLl1O9zh6PTW9p4k5mb+Sg4+SNGxPyV+1JjM9W+7p2K3zy
X-Gm-Message-State: AOJu0YzUVVWTbc4c+hqEn+1HQPlYNDoq4lg1Bzjuunkj7uHqrNnRqy+A
	kC2DCPelvv+UiASYBG2rfKkm/EH5rglqkPVp7jQurBzVQJai8NQBC+C6nABIqeg4nFkBY+dgad+
	uefA6oEtovC2hjS4Iz4fPR6oWTLGnMtwLRZQ=
X-Google-Smtp-Source: AGHT+IHPkr8MXlXnsTqDQUAH848oUd/FhdaH0EQep/6PvORXBzYeJvj04y1lheh/RMMA5J9aeAhTYUSvWrrqiOjfQ9Q=
X-Received: by 2002:a2e:86d0:0:b0:2d2:b337:f55d with SMTP id
 n16-20020a2e86d0000000b002d2b337f55dmr5260411ljj.16.1709530988812; Sun, 03
 Mar 2024 21:43:08 -0800 (PST)
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
 <CAFULd4b0HN6eUJsOW6po8Hf16T3eMhjdKUvw-TS8yncNn-+Vyw@mail.gmail.com> <87bk7ux4e9.ffs@tglx>
In-Reply-To: <87bk7ux4e9.ffs@tglx>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 4 Mar 2024 06:42:57 +0100
Message-ID: <CAFULd4aEe2KU=UXEt2=GeLQq2uTSFvydBiwAdSa7B6T61Am=5w@mail.gmail.com>
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Arjan van de Ven <arjan@linux.intel.com>, x86@kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Sparse Mailing-list <linux-sparse@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 12:49=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Sun, Mar 03 2024 at 21:24, Uros Bizjak wrote:
> > On Sun, Mar 3, 2024 at 9:21=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> =
wrote:
> >> On Sun, Mar 3, 2024 at 9:10=E2=80=AFPM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >> > That's so sad because it would provide us compiler based __percpu
> >> > validation.
> >>
> >> Unfortunately, the c compiler can't strip qualifiers, so typeof() is
> >> of limited use also when const and volatile qualifiers are used.
> >> Perhaps some extension could be introduced to c standard to provide an
> >> unqualified type, e.g. typeof_unqual().
> >
> > Oh, there is one in C23 [1].
>
> Yes. I found it right after ranting.
>
> gcc >=3D 14 and clang >=3D 16 have support for it of course only when add=
ing
> -std=3Dc2x to the command line.
>
> Sigh. The name space qualifiers are non standard and then the thing
> which makes them more useful is hidden behind a standard.

With GCC, you can use __typeof_unqual__ (please note underscores)
without -std=3Dc2x [1]:

"... Alternate spelling __typeof_unqual__ is available in all C modes
and provides non-atomic unqualified version of what __typeof__
operator returns..."

Please also see the example in my last post. It can be compiled without -st=
d=3D...

[1] https://gcc.gnu.org/onlinedocs/gcc/Typeof.html

Uros.

