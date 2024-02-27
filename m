Return-Path: <linux-kernel+bounces-83944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E0286A060
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D1F1F21F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E4C13AA27;
	Tue, 27 Feb 2024 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOZ8xGJZ"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4696D2511F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062880; cv=none; b=CKny7s0XPSWGqZwmqIEECGcZNoJYmF0VOr/TSXVjy0bNYWpqpV0it7PGP2Kkx/iEwpu07ZZ6+9BSG167nnsy2M7TXc3T7IsHgxfAWRIGhDpo1d0qzIJwHnvokrIAeV1q3oaiNO47LPzZboyrChPaCm/GH7Z+rpcjs6jsPjGKvb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062880; c=relaxed/simple;
	bh=zbekMlrn7vcZ2XA2kYLqU8YdKEnzZ3RU12A9vKAe1qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qh9w17qxqH6IjX0ePiDwBARrBR/47AD7FL3i0Z0XRu9d6A7wXX7k6K6inkGVox+9KLdlLibJiOoDXbHjvBe2uaPw7cyJArw9MkdQLggCXr9AwekD/d67X/vHrpSGIswr2nfsh3qqhz6vLFw5uAMse9sdgWqaCzN0O/CTVCG+hdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hOZ8xGJZ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42e0b1b11bbso27251cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709062877; x=1709667677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kmy0Y9ggXPQX3ZKJXTwDEXzgywyH4ISUr8AQOAMPX0=;
        b=hOZ8xGJZIf2pQyWCxLS8GWaZOX9gkNTQVIq/5b2Y4UhMp8V6YRHNTangeooNNtnLwQ
         nPueZ/re0XyaojSqYlU8NhdR8+58Pa5cm3OpHwGwj7/P9toXmTvs/tYmooXQtBxdT7BZ
         kSIBbjI2jM9quTzPimguy5JyUX/q42yqYMhLnJRT/sElK74sQpcCzKmaO4KqIbPIHyNa
         NGcEu8m5QZUcGGvYdprnG2F+W/9TuDB4lkMTvgUYMTxNoa8CJxSBd3VE8whPiLsA1oEy
         NYk8KIc1+FfN1e1ERn/9F5I0qZfKixeNu3DByz6gtFgelT0QXYslyNB0DAwgKAls43Ro
         UYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709062877; x=1709667677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kmy0Y9ggXPQX3ZKJXTwDEXzgywyH4ISUr8AQOAMPX0=;
        b=cBg1gAoznO26LqvxFc81xU48oE7aBKtSsp2jxtkYKWgUu31Fm7A7V4pyRcHjS4bMWA
         MYsTq7yBuMY/SdU3dlPlZrynaOJk/GGUEtnGBCvJLwj3oGJb4YIBCyEt6ccXhv0tHc6M
         0GhXT0iqZS200FX49KFB94E7Xj4D4eqjk0zDDzLWsk3XKZYruekGcyMngzMdsamUGw/l
         fOppF/ss3UcDsYVGBH7X02TMp2KoQSbyVmfRQ2Ebg/+ynV6by5KANPsxNanPO6dzGRhJ
         wUia+cJaD2nFIwHwSs/3s4jg2w15RaNeZdUrRHwZGbCfQZQJvM+zbevaunM+d/UKoe3t
         y9QA==
X-Forwarded-Encrypted: i=1; AJvYcCXfrqMsbv1wy7iea6l8pCT9s6MgvLXi/WH08pr5nmn/yekGQivgdRGxbI42iKeE3fodNBxqXWV9z1R6NeA7tGn2wuYrxv2d7ZZ+v0pF
X-Gm-Message-State: AOJu0YyDkONxgSVJgDRQHKQo8hSy+YF2SbIs9oy5XKbeh55qrLd6x6K8
	5V1kz41EaVe/RBB2esBvR17/qkaH4/Pj1DEZbSRA2XqicVaKTnGrZGmUFKIFtVSLpYya9ptjQCJ
	SHu6aZapupP53sgv2TXEkXOYFPccouKnqLSh0
X-Google-Smtp-Source: AGHT+IG7+ANsowzp3aWo73JCwNd8g0AmTtzpnG9zTdwCzKeHLM+IZv7SMU7lKTBBWEII2yLupK5gzTpOUK4mJ3aKW1o=
X-Received: by 2002:a05:622a:d:b0:42e:a2a0:959c with SMTP id
 x13-20020a05622a000d00b0042ea2a0959cmr223695qtw.14.1709062877135; Tue, 27 Feb
 2024 11:41:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222221814.3572215-1-rmoar@google.com> <CAGS_qxqQ09wUppF9s1BgNoj5T2yo8+Yd0RLRBisj5th7Yw97eQ@mail.gmail.com>
In-Reply-To: <CAGS_qxqQ09wUppF9s1BgNoj5T2yo8+Yd0RLRBisj5th7Yw97eQ@mail.gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 27 Feb 2024 14:41:05 -0500
Message-ID: <CA+GJov5hCde3JAuwdZayzQ0HUkexbtgAVFrXbDeqpufV6OdC3g@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: add parsing of all files in directory
To: Daniel Latypov <dlatypov@google.com>
Cc: shuah@kernel.org, davidgow@google.com, brendan.higgins@linux.dev, 
	kevko@google.com, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 6:37=E2=80=AFPM Daniel Latypov <dlatypov@google.com=
> wrote:
>
> On Thu, Feb 22, 2024 at 2:18=E2=80=AFPM Rae Moar <rmoar@google.com> wrote=
:
> >
> > Add ability to parse all files within a directory. Additionally add the
> > ability to parse all results in the KUnit debugfs repository.
>
> Nice, I'd been hoping for this.
> It's enough to pull me back in for a bit :)
>
> <snip>
>
> >  tools/testing/kunit/kunit.py | 45 ++++++++++++++++++++++++++----------
> >  1 file changed, 33 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.p=
y
> > index bc74088c458a..827e6dac40ae 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -511,19 +511,40 @@ def exec_handler(cli_args: argparse.Namespace) ->=
 None:
> >
> >
> >  def parse_handler(cli_args: argparse.Namespace) -> None:
> > -       if cli_args.file is None:
> > +       parsed_files =3D []
>
> optional: can we annotate the type?
>   parsed_files =3D []  # type: List[str]

Hi Daniel!

Yes, happy to make this change for the next version.

>
> > +       total_test =3D kunit_parser.Test()
> > +       total_test.status =3D kunit_parser.TestStatus.SUCCESS
> > +       if cli_args.file_path is None:
> >                 sys.stdin.reconfigure(errors=3D'backslashreplace')  # t=
ype: ignore
> >                 kunit_output =3D sys.stdin  # type: Iterable[str]
>
> This branch no longer does anything, since we only parse what's in
> `parsed_files`
>
> E.g. if you try
> $ kunit.py parse $FILENAME
> it'll work whereas
> $ kunit.py parse < $FILENAME
> will do nothing
>
> We'll need to rework the control flow somehow

Ahh I see. Thanks for bringing this to my attention! I will change
this for the next version.

>
> > -       else:
> > -               with open(cli_args.file, 'r', errors=3D'backslashreplac=
e') as f:
> > +       elif cli_args.file_path =3D=3D "debugfs":
> > +               for (root, _, files) in os.walk("/sys/kernel/debug/kuni=
t"):
> > +                       for file in files:
> > +                               if file =3D=3D "results":
> > +                                       parsed_files.append(os.path.joi=
n(root, file))
> > +       elif os.path.isdir(cli_args.file_path):
> > +               for (root, _, files) in os.walk(cli_args.file_path):
> > +                       for file in files:
> > +                               parsed_files.append(os.path.join(root, =
file))
>
> just a note here, we could make this a bit terser via
>   parsed_files.extend(os.path.join(root, f) for f in files)
>
> and the debugfs branch could be rendered as
>   parsed_files.extend(os.path.join(root, f) for f in files if f =3D=3D "r=
esults")
>

Will do.

> > +       elif os.path.isfile(cli_args.file_path):
> > +               parsed_files.append(cli_args.file_path)
>
> nit: should there be an `else` here that prints a warning?
>
> Example that would trigger this case and silently do nothing
> $ mkfifo /tmp/example_fifo
> $ ./tools/testing/kunit/kunit.py parse /tmp/example_fifo
> <no output>
>

Yep you are definitely right I will add one here.

>
> <snip>
>
> > @@ -569,8 +590,8 @@ def main(argv: Sequence[str]) -> None:
> >                                             help=3D'Parses KUnit result=
s from a file, '
> >                                             'and parses formatted resul=
ts.')
> >         add_parse_opts(parse_parser)
> > -       parse_parser.add_argument('file',
> > -                                 help=3D'Specifies the file to read re=
sults from.',
> > +       parse_parser.add_argument('file_path',
> > +                                 help=3D'Specifies the file path to re=
ad results from.',
>
> Should this mention that the make `debugfs` string works?
>
> >                                   type=3Dstr, nargs=3D'?', metavar=3D'i=
nput_file')
>
> Tangent: would it be useful to allow the user to pass in multiple
> files now and set this to nargs=3D'*'?
>
> E.g.
> $ kunit.py parse /my/dir/some_prefix*
>
> It would also let people implement their own version of the debugfs logic=
 via
> $ find /other/debugfs/dir -name 'results' | xargs kunit.py parse
>
> That could be useful if the user has recursively copied off the
> debugfs from a test machine and wants to inspect it elsewhere, for
> example.
>

Oh this is an interesting idea. I will play around with it!

Thanks for looking this patch over!
-Rae

> Thanks,
> Daniel

