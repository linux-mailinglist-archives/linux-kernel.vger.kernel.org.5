Return-Path: <linux-kernel+bounces-143022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979778A3357
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D70F1F211D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8C61494B4;
	Fri, 12 Apr 2024 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="sZseXQIw"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34041148FE0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938326; cv=none; b=Bm3PXy+27RoAg5VkKGqXLzGszUEa1Cs0qV53DVYDvqss1jEXwHNQBFRWwjjBRZtwfWXDxR+DJWUYOzASuw3HU25XMBcLDuw1vuAdh83YiUzuy5Jz8962+c83CTcD+d3OrPnRZ/3/YBo2xP2Nz3ySxuqxW3HWwbeT3BxjU2pOQPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938326; c=relaxed/simple;
	bh=CyDf6s1oBPX3vBBot9QW9Bfdy/AMFlPJrHMpAv8DVOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWt0kJYxEACNE8p9d0sraSI5yfui6jIw54yvFp5O5ZnMwqu9lfJgGvHg/TJgihmM2q8zVB55u8TVFUD2LIkgv3p78XLF3TDXCn260bMUKoMWiD/bWZi7MP/R1t2SmY2i6HCwAHT+wCk6Daep6TFX+LNWpsTdprGPOsmB1NRVBhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sZseXQIw; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56fd95160e5so10698a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712938323; x=1713543123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5JT8K7AvdRwgx51et4e9LWrdmVm7FiW3UD4VOlrp94=;
        b=sZseXQIwrG9bEDBhNm72KckQD5JmkyZvf7jgDwOuzOORV8rHm58ZEscWetGEmI9LYt
         7734Q/HSBqUNBeCSMa3m/FsgP5Xho96KpSqD49wYNMJaiKscKG/4V58yFFPe3xJRtJAz
         qQ0CjlFPOBOUQqmpC8S5ezvrxp77S2/fLGyFI5K0MhSBygDtpS0y9v1oJsE+RfYbbxL3
         OHPV60DJx9VWBEza8FxrG2C/p6KsrdJThHoCnE5/7Nsjcfwo4Yv0RtUtIZjDyzth4/LJ
         9atHdjHVAkPV9r0RWdD5pR+R0oFGU1a9aEgfUQf4Ou2HGsM6VANhoMdUszH/ru1khAmm
         tLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712938323; x=1713543123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5JT8K7AvdRwgx51et4e9LWrdmVm7FiW3UD4VOlrp94=;
        b=pljax6JCgwFTw4xEBCb1Tfk0NvlrQ47HmsOslfJXefpjzsrK/MOxa9n9p61aejf6Ay
         /1V+aTQVHF3/BaJP6J8gS1D7t8uTqx/9H0SHRxqNzRJdql54MZKrRIDcIaQwZvZ410FU
         5Y7oTbKXbQMIzAXUe7VhL/B4DL75unih3lFOHF6eia7ULNMPMdNvg1h6H8dai7b+qed8
         0xXW3DqdVwdVAqCwnSsQGFgDEqtnCEODYbrsMD8Mh3IH3hFhUXoXj19OrCWdECr7LA57
         D1clp3GKEYOiRwS/MIje9MMvKqMXy3rqLrnWTwe0gZ4j/3wUj55sxoJUOOEg+isAvuIP
         QBsg==
X-Forwarded-Encrypted: i=1; AJvYcCXrzIExM2lqwbYLD6QbJSBdBt0SiumQkYKAtESu5dSn8WPyQrF8h/3TxtfTmqNnLjvDhr8dKtColipqtHjEZSfY26uofiANBlhLTmUA
X-Gm-Message-State: AOJu0YxTyB8KrT1ONmT1T3BenTYG3Z3zwXaff5NlEspDbo5hRO3aIw3G
	L7s9cZmfo1oN5nhykQ4COCpPzoRInokRC5F7shLakn8eNtmw8zdj92oksbDhA05ZJSCa8UEoytm
	kwY01TkEhw4w6/AyPrNgDJS07NfKiTIiNUI4=
X-Google-Smtp-Source: AGHT+IHRBVk7zH7YF+KtpjONjNtA7XUyVLa+CfCQyQPDJV89nxPfsVYooQGyNelh6x30YUHFeLeDGJ02K9QJnqgTZ9o=
X-Received: by 2002:a50:ccda:0:b0:570:99f:6c2e with SMTP id
 b26-20020a50ccda000000b00570099f6c2emr45146edj.1.1712938322737; Fri, 12 Apr
 2024 09:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411-mark-kselftest-exit-funcs-noreturn-v1-1-b027c948f586@kernel.org>
 <CAGG=3QUNPGtQ7OqzEtNW9BQET+a+1WW=h++CqRTHRY=YLrOAcw@mail.gmail.com>
In-Reply-To: <CAGG=3QUNPGtQ7OqzEtNW9BQET+a+1WW=h++CqRTHRY=YLrOAcw@mail.gmail.com>
From: Bill Wendling <morbo@google.com>
Date: Fri, 12 Apr 2024 09:11:46 -0700
Message-ID: <CAGG=3QXzs0VdaQjNtGD6aKEPXCy1dGQ06BSKww_HutB-x7BuMQ@mail.gmail.com>
Subject: Re: [PATCH] kselftest: Mark functions that unconditionally call
 exit() as __noreturn
To: Nathan Chancellor <nathan@kernel.org>
Cc: tglx@linutronix.de, shuah@kernel.org, oleg@redhat.com, 
	anna-maria@linutronix.de, frederic@kernel.org, ndesaulniers@google.com, 
	justinstitt@google.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 9:08=E2=80=AFAM Bill Wendling <morbo@google.com> wr=
ote:
>
> On Thu, Apr 11, 2024 at 11:45=E2=80=AFAM Nathan Chancellor <nathan@kernel=
org> wrote:
> >
> > After commit 6d029c25b71f ("selftests/timers/posix_timers: Reimplement
> > check_timer_distribution()"), clang warns:
> >
> >   tools/testing/selftests/timers/../kselftest.h:398:6: warning: variabl=
e 'major' is used uninitialized whenever '||' condition is true [-Wsometime=
s-uninitialized]
> >     398 |         if (uname(&info) || sscanf(info.release, "%u.%u.", &m=
ajor, &minor) !=3D 2)
> >         |             ^~~~~~~~~~~~
> >   tools/testing/selftests/timers/../kselftest.h:401:9: note: uninitiali=
zed use occurs here
> >     401 |         return major > min_major || (major =3D=3D min_major &=
& minor >=3D min_minor);
> >         |                ^~~~~
> >   tools/testing/selftests/timers/../kselftest.h:398:6: note: remove the=
 '||' if its condition is always false
> >     398 |         if (uname(&info) || sscanf(info.release, "%u.%u.", &m=
ajor, &minor) !=3D 2)
> >         |             ^~~~~~~~~~~~~~~
> >   tools/testing/selftests/timers/../kselftest.h:395:20: note: initializ=
e the variable 'major' to silence this warning
> >     395 |         unsigned int major, minor;
> >         |                           ^
> >         |                            =3D 0
> >
> > This is a false positive because if uname() fails, ksft_exit_fail_msg()
> > will be called, which unconditionally calls exit(), a noreturn function=
.
> > However, clang does not know that ksft_exit_fail_msg() will call exit()
> > at the point in the pipeline that the warning is emitted because
> > inlining has not occurred, so it assumes control flow will resume
> > normally after ksft_exit_fail_msg() is called.
> >
> > Make it clear to clang that all of the functions that call exit()
> > unconditionally in kselftest.h are noreturn transitively by marking the=
m
> > explicitly with '__attribute__((__noreturn__))', which clears up the
> > warning above and any future warnings that may appear for the same
> > reason.
> >
> > Fixes: 6d029c25b71f ("selftests/timers/posix_timers: Reimplement check_=
timer_distribution()")
> > Reported-by: John Stultz <jstultz@google.com>
> > Closes: https://lore.kernel.org/all/20240410232637.4135564-2-jstultz@go=
ogle.com/
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> > I have based this change on timers/urgent, as the commit that introduce=
s
> > this particular warning is there and it is marked for stable, even
> > though this appears to be a generic kselftest issue. I think it makes
> > the most sense for this change to go via timers/urgent with Shuah's ack=
.
> > While __noreturn with a return type other than 'void' does not make muc=
h
> > sense semantically, there are many places that these functions are used
> > as the return value for other functions such as main(), so I did not
> > change the return type of these functions from 'int' to 'void' to
> > minimize the necessary changes for a backport (it is an existing issue
> > anyways).
> >
> > I see there is another instance of this problem that will need to be
> > addressed in -next, introduced by commit f07041728422 ("selftests: add
> > ksft_exit_fail_perror()").
> > ---
> >  tools/testing/selftests/kselftest.h | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selfte=
sts/kselftest.h
> > index 973b18e156b2..0591974b57e0 100644
> > --- a/tools/testing/selftests/kselftest.h
> > +++ b/tools/testing/selftests/kselftest.h
> > @@ -80,6 +80,9 @@
> >  #define KSFT_XPASS 3
> >  #define KSFT_SKIP  4
> >
> > +#ifndef __noreturn
> > +#define __noreturn       __attribute__((__noreturn__))
> > +#endif
> >  #define __printf(a, b)   __attribute__((format(printf, a, b)))
> >
> >  /* counters */
> > @@ -300,13 +303,13 @@ void ksft_test_result_code(int exit_code, const c=
har *test_name,
> >         va_end(args);
> >  }
> >
> > -static inline int ksft_exit_pass(void)
> > +static inline __noreturn int ksft_exit_pass(void)
>
> Orthogonal to this fix, but why does a "no return" function have a
> non-void return type?
>
Oops...That's been asked. Sorry for the extra message.

-bw

