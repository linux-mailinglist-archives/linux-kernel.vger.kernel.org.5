Return-Path: <linux-kernel+bounces-134607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF2989B387
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25DCF1C21472
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798843DB8C;
	Sun,  7 Apr 2024 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0ws60Lq"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5433D541
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712514767; cv=none; b=Cr42S5c3WBCjExu2xpWv4wR4reqUIplUnwbYJhoVg4BGzqXKgzikY1HU0xBcYwEeqh/XpzkzBlWYVnhzFZkzL3TUkorbfEXOb+nAUOrU33KzsBpvRESZRa5CsOJ8CryjtaQJdoPsmxVCjTs6AVDLsSazdYHxbgNupSw/Xg1iDwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712514767; c=relaxed/simple;
	bh=ztHnNx/SQUL/wwuwHRpMPiRVSAVPrQTfiIVmDy7B+jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7cBeoB7L1lTx+qr2NjxIyWsSNy8NlxKGq5aBPm1slNSy0b55Nlyj7TuSPi7kx9SKBhEPsQm05drqkPRYnMi9GXhCZURc2zXT32QjWvxj3DF6kFxl6yfO/mE6D7RLKElxT7N6oM5nKzbbZDWP0u06Z+vhW5kYydJDBHUWadANVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N0ws60Lq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3c89f3d32so156265ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 11:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712514765; x=1713119565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLqjjjy5BIBpzS1nANECMi7hVdMwuO/IpZycBkQpgS0=;
        b=N0ws60LqS/uXI5sgK/zPm6o1eyGkFkIQs2EwwM8woaIKJgGWGbVJ5OV3JMKVP3BXey
         FHJ5iwLE5Egvb2xAYyu2LqutK5O2hYy9/IYAcx0I6hjIZZxLypcmu4b9IaRf4CvbUwu9
         YVI5qWpnqMmTfPXwJfHqmRTyElYdBqJwCSGSnLtPWnbkpjsqC8bJxukjkSDFNGxEDF0X
         n1vkgeNYEiYzG1pFVb2juCvoGutIU7aL9A2Um+8VNH5IWT6RPMFFfYP9+A4JgPbF2RtK
         XXDC0TkLWIoWsaYkNx8pjmszep0gIsJOsOaQVr59lf2vCxpPvsslh7zZir7YI+aYpHBE
         yT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712514765; x=1713119565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLqjjjy5BIBpzS1nANECMi7hVdMwuO/IpZycBkQpgS0=;
        b=c/v2D0yTg2c4M3a2hBjQsC5u0YUiSPNXizJIW9vYQ5SzdHwVEsFL5+9W/89OAZQM6V
         2FQYSevNiSw7e4mlvx4e1t9pColEybFoPX+8KuSBrihqlM3hdDQWi4WLrE8UkEE7ItME
         ZmbdknWb0GSucHeaGQRBWUi9Tb9p97r+jrj1jR9fj7ZMEvVnWjyHtBWfAm68VPusn25s
         elxyrP8r9hGOBIe8Ht3m2CLbXmxXZTMVq99hRXkrejh7hlj6BzytFeyP3FhjaCGkd+GC
         m462rRAMPE81k5suyI2RurptDunUU6V0ef5iQ0VF9AIrIqwNimE43Pp80lgxnNJltt19
         kGMw==
X-Forwarded-Encrypted: i=1; AJvYcCU5ZpEYwmhh+f2rdApP4kl6YW0sTdabQMH2wH0j0uhA3LFp9i36CXvu9w5SoWo6E37wz4xL4139OqaggMbLcxuHx9Y/u5BfA/SaKC8z
X-Gm-Message-State: AOJu0Yy448USAqbIEIXvXWgyXVBXMMjSSlZENSyfiDVfFMHHzSGuug/e
	rF12bx8F6Sk+XjEpK4aC/mIJ+W4VRqTlye2pXvCFZk2VYbnh3xsJ00NFxpCGPdO4odZDDrwaBuI
	HxIgnVdERGiu3cgbOzEtcs8g+W64zLqJIpwOJ
X-Google-Smtp-Source: AGHT+IFJVydgcdM1xx89HGIXg/sm7hAU4b3TmyPgCj29iXcoepIXFDZtzFe8jWiNvQAUJAbfsMrh/qPjYSNKJohaHgk=
X-Received: by 2002:a17:902:d2c1:b0:1e2:29f3:aff1 with SMTP id
 n1-20020a170902d2c100b001e229f3aff1mr178307plc.25.1712514765171; Sun, 07 Apr
 2024 11:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407-perf_digit-v1-0-57ec37c63394@codewreck.org>
 <20240407-perf_digit-v1-3-57ec37c63394@codewreck.org> <ZhKTrUPbUnBviQYK@codewreck.org>
In-Reply-To: <ZhKTrUPbUnBviQYK@codewreck.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 7 Apr 2024 11:32:31 -0700
Message-ID: <CAP-5=fWT4=yT9rxKmR4ing9i-EffRQnjTP355wU-fFN1Mfnezg@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf parse: Allow names to start with digits
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 5:38=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Dominique Martinet wrote on Sun, Apr 07, 2024 at 09:18:21PM +0900:
> > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-eve=
nts.l
> > index e86c45675e1d..41c30ff29783 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -158,7 +158,7 @@ event             [^,{}/]+
> >  num_dec              [0-9]+
> >  num_hex              0x[a-fA-F0-9]{1,16}
> >  num_raw_hex  [a-fA-F0-9]{1,16}
> > -name         [a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*
> > +name         [a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*
>
> grmbl sorry I guess I didn't actually test this two years ago (?!), or
> used it differently (commit message is weird and also needs fixing,
> perf probe -e 9p:* does not make sense) or something changed but
> that's not enough:
>
> ----
> $ sudo ./perf trace -e 9p:9p_fid_ref
> event syntax error: '9p:9p_fid_ref'
>                      \___ parser error
> Run 'perf list' for a list of valid events
> ----
>
> Adding 0-9 to name_tag as well makes perf trace works.
>
> I'm not sure what name_minus is for but I did't need to add that one in
> my test.
>
> That also highlights that the test I added isn't sufficient, if someone
> familiar with the code could hint at a better place to test please tell!
> Otherwise I'll have a look next weekend, I need to get back to my 9p
> bugs now I've got a working perf command..
>
> >  name_tag     [\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=3D]*[\']
> >  name_minus   [a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
> >  drv_cfg_term [a-zA-Z0-9_\.]+(=3D[a-zA-Z0-9_*?\.:]+)?
> >

Try adding PARSER_DEBUG=3D1 to your command line, I need to do the followin=
g:
```
$ make EXTRA_CFLAGS=3D"-Wno-error=3Dredundant-decls" PARSER_DEBUG=3D1
```
For your example it seems to parse with the changes, but I see (which
should be expected):
```
event syntax error: '9p:9p_fid_ref'
                    \___ unknown tracepoint

Error:  File /sys/kernel/tracing//events/9p/9p_fid_ref not found.
Hint:   Perhaps this kernel misses some CONFIG_ setting to enable this feat=
ure?.

Run 'perf list' for a list of valid events

Usage: perf stat [<options>] [<command>]

   -e, --event <event>   event selector. use 'perf list' to list
available events
```
I think Jiri's e-mail should be jolsa@kernel.org.

Thanks,
Ian

> --
> Dominique Martinet | Asmadeus

