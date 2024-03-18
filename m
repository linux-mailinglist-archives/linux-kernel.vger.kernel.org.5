Return-Path: <linux-kernel+bounces-106683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CF487F1E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8B828202B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B9958222;
	Mon, 18 Mar 2024 21:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qu9xK9Bd"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CAD58131
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796583; cv=none; b=uIR5nQU9H5pOxNYwYwD8HA9bbvim0rNJ+slGGCqfRtfL3jjn9AZwi1g8C+jaUWtv4zGxVTNgxDdlPwqUVhyEXc8oBVs8IpVYjHTaNQ1+VSMfcGfrbPgvxZI7sMdFk0YasphUmWN/m577aEs7/8kfJtPb5Yd4Fi4zh/v7yMvOHv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796583; c=relaxed/simple;
	bh=SFPGfzAG30iVHrPgWsuS4UuJ+iODLq3ukOUpXn/MPmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqJil7mbFdM1ffy4nEXQY/pazfATiQdV1cNrBTuFbtlCyr1TDG50RZHkKen/uSjlXVapc0O3IDzreMSbXhScG3rS6v8wyzXR1TAcMZP96ecDeCGmM5jm1wcR9EAh590pytQUVihV1v/BPyRnEnlZzLGqnMJXm0cgy8bVfFHtq1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qu9xK9Bd; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42ee0c326e8so71621cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710796580; x=1711401380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixKQUz2kNgqRsZicLwAD7GWepD+zZf9djmhTNfiz4IM=;
        b=qu9xK9Bd4vOaDvOFXivHXZGa0byGzoqPwFHgYRDRLctgPp7laRPKeMZXUYRPV+tH9y
         4SwsAtdJo4Cril+ojd4SAIf6gkWOK1Knn+CPMk68EjtUCaToI5rIKa/quiHnT8qS52UB
         ieZQevcriNIDCoBvC+/8UIgntmWndTgAc3S4104Swjg9VmJdPpDg9hdJ+Ohcb4zYo3Qm
         HrSfzmIg/mNggeAWWLsIPW8RvcOETLDSaWUbnfwvVikD+YLr1+kF5McuZz4whNo5+NIT
         LrAiQT3Eq5BVrRpWqPApP+dIGZglLEyNAVBh6+Hufw52AShU015+CwzCh2myciqOPUD2
         0Zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710796580; x=1711401380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixKQUz2kNgqRsZicLwAD7GWepD+zZf9djmhTNfiz4IM=;
        b=BUCnIuvday87Usv9kWXbWJSDasFAghOZLkBL6eZszC/8RhIwplaxUji6EfFrQvzu1S
         YnyOQw/fQOwnkjY5GORXq5lSuJ9r3ygEgUhxWju3SUof1Pix9lcNH/5EN3yUBukXmf3D
         GPxsRZVJBg0zJO7vBb4KlgXTgDQ0wf5T/KJKarE0sKalQIkU6AnVomV6ekTnpurILBma
         GsviWo71KPaCG3Xw75+oPaW9CIU4Jxu+fOIG7Qa2hCrcPNJY1pkvsetv61s0q0L3MDy+
         mWNhx0aSgCO56X9AjcHXqiaClR9NujJVoZsN/KtizZyklwTc65pkluo8iEWlOzLNrE+w
         5Tyw==
X-Forwarded-Encrypted: i=1; AJvYcCX1iXJ2b95wmKn+Fh0LL9NowuyBkirqmQ2QaThbKqXgeP8NfKZHDPzGUkgHowQcdENJGkGZoBIfQPa2dWpIVGCG01XrUZEnZXSSk1MQ
X-Gm-Message-State: AOJu0Yy0Gkb+iUjhtyB4VXYZOaJdDMJIXVHiU6g4FUnozaUwMfHTOddO
	ze5y//MVx7Jr+6sYnbTS+1uL0AWAut4tyXWS/IYdPeSeFntYZjyBu75wuqwM7Oxq9IEZ0N5yW0p
	ZeNbUDEe4/Vt1Qs8iFmyjIUQARPIIDcA+0ALA
X-Google-Smtp-Source: AGHT+IGGkH55EcQ5iOxoOL7VTpUL0YSFGZwKq8J2aYo4iS5T3knnpvLdfASa+DADvml67Xmf1XTRFru9aKiBddA/nP8=
X-Received: by 2002:a05:622a:589:b0:430:a827:cdef with SMTP id
 c9-20020a05622a058900b00430a827cdefmr27519qtb.23.1710796580082; Mon, 18 Mar
 2024 14:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307222932.584164-1-rmoar@google.com> <CAGS_qxr==N-E4VHei0o-A1=5dno_ozqMsHPHoq7RFF5bearhpg@mail.gmail.com>
In-Reply-To: <CAGS_qxr==N-E4VHei0o-A1=5dno_ozqMsHPHoq7RFF5bearhpg@mail.gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Mon, 18 Mar 2024 17:16:07 -0400
Message-ID: <CA+GJov6YqNpm5qvQhgJKzmBkWeCDDoS8mUD68hNpr=ObR3audg@mail.gmail.com>
Subject: Re: [PATCH v3] kunit: tool: add ability to parse multiple files
To: Daniel Latypov <dlatypov@google.com>
Cc: shuah@kernel.org, davidgow@google.com, brendan.higgins@linux.dev, 
	kevko@google.com, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 7:16=E2=80=AFPM Daniel Latypov <dlatypov@google.com=
> wrote:
>
> On Thu, Mar 7, 2024 at 2:29=E2=80=AFPM Rae Moar <rmoar@google.com> wrote:
> >
> > Add ability to parse multiple files. Additionally add the
> > ability to parse all results in the KUnit debugfs repository.
> >
> > How to parse multiple files:
> >
> > ./tools/testing/kunit/kunit.py parse results.log results2.log
> >
> > How to parse all files in directory:
> >
> > ./tools/testing/kunit/kunit.py parse directory_path/*
> >
> > How to parse KUnit debugfs repository:
> >
> > ./tools/testing/kunit/kunit.py parse debugfs
> >
> > For each file, the parser outputs the file name, results, and test
> > summary. At the end of all parsing, the parser outputs a total summary
> > line.
> >
> > This feature can be easily tested on the tools/testing/kunit/test_data/
> > directory.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
> > Changes since v2:
> > - Fixed bug with input from command line. I changed this to use
> >   input(). Daniel, let me know if this works for you.
>
> Oops, sorry for the delay.

Hi!

No worries at all. Thanks for the review!

>
> Hmm, it seems to be treating the stdin lines like file names
>
> $ ./tools/testing/kunit/kunit.py parse <
> ./tools/testing/kunit/test_data/test_config_printk_time.log
> File path: Could not find  [    0.060000] printk: console [mc-1] enabled
>
> Oh, I see, we're prompting the user via
>   input("File path: ")
> ?
>
> I'm not necessarily against such a change, but I would personally
> prefer the old behavior of being able to read ktap from stdin
> directly.
> As a user, I'd also prefer to only type out filenames as arguments
> where I can get autocomplete, so `input()` here wouldn't help me
> personally.
>
> Applying a hackish patch like this [1] on top gets the behavior I'd
> personally expect:
> $ ./tools/testing/kunit/kunit.py parse <
> ./tools/testing/kunit/test_data/test_config_printk_time.log
> /dev/stdin
> ...
> [16:01:50] Testing complete. Ran 10 tests: passed: 10
>
> I'd mentioned in the previous version that we could have parsed files
> contain a `Union[str, TextIO]` and then read from the `sys.stdin` file
> object directly.
> But having it blindly open `/dev/stdin` seems to work just the same,
> if we want to keep our list simpler and just hold strings.
>

I definitely see why the change to stdin would be better. My original
change to input() was to keep it simple. But I really like the change
listed below. I will go ahead and implement that.

> [1] this just also re-orders the `os.path.isdir()` check as mentioned
> below, which simplifies things
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 1aa3d736d80c..311d107bd684 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -515,18 +515,18 @@ def parse_handler(cli_args: argparse.Namespace) -> =
None:
>         total_test =3D kunit_parser.Test()
>         total_test.status =3D kunit_parser.TestStatus.SUCCESS
>         if not parsed_files:
> -               parsed_files.append(input("File path: "))
> -
> -       if parsed_files[0] =3D=3D "debugfs" and len(parsed_files) =3D=3D =
1:
> +               parsed_files.append('/dev/stdin')
> +       elif len(parsed_files) =3D=3D 1 and parsed_files[0] =3D=3D "debug=
fs":
>                 parsed_files.pop()
>                 for (root, _, files) in os.walk("/sys/kernel/debug/kunit"=
):
>                         parsed_files.extend(os.path.join(root, f) for
> f in files if f =3D=3D "results")
> -
> -       if not parsed_files:
> -               print("No files found.")
> +               if not parsed_files:
> +                       print("No files found.")
>
>         for file in parsed_files:
> -               if os.path.isfile(file):
> +               if os.path.isdir(file):
> +                       print("Ignoring directory ", file)
> +               elif os.path.exists(file):
>                         print(file)
>                         with open(file, 'r', errors=3D'backslashreplace')=
 as f:
>                                 kunit_output =3D f.read().splitlines()
> @@ -536,8 +536,6 @@ def parse_handler(cli_args: argparse.Namespace) -> No=
ne:
>                                                         json=3Dcli_args.j=
son)
>                         _, test =3D parse_tests(request, metadata, kunit_=
output)
>                         total_test.subtests.append(test)
> -               elif os.path.isdir(file):
> -                       print("Ignoring directory ", file)
>                 else:
>                         print("Could not find ", file)
>
>
> > - Add more specific warning messages
> >
> >  tools/testing/kunit/kunit.py | 56 +++++++++++++++++++++++++-----------
> >  1 file changed, 40 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.p=
y
> > index bc74088c458a..1aa3d736d80c 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -511,19 +511,42 @@ def exec_handler(cli_args: argparse.Namespace) ->=
 None:
> >
> >
> >  def parse_handler(cli_args: argparse.Namespace) -> None:
> > -       if cli_args.file is None:
> > -               sys.stdin.reconfigure(errors=3D'backslashreplace')  # t=
ype: ignore
> > -               kunit_output =3D sys.stdin  # type: Iterable[str]
> > -       else:
> > -               with open(cli_args.file, 'r', errors=3D'backslashreplac=
e') as f:
> > -                       kunit_output =3D f.read().splitlines()
> > -       # We know nothing about how the result was created!
> > -       metadata =3D kunit_json.Metadata()
> > -       request =3D KunitParseRequest(raw_output=3Dcli_args.raw_output,
> > -                                       json=3Dcli_args.json)
> > -       result, _ =3D parse_tests(request, metadata, kunit_output)
> > -       if result.status !=3D KunitStatus.SUCCESS:
> > -               sys.exit(1)
> > +       parsed_files =3D cli_args.files # type: List[str]
> > +       total_test =3D kunit_parser.Test()
> > +       total_test.status =3D kunit_parser.TestStatus.SUCCESS
> > +       if not parsed_files:
> > +               parsed_files.append(input("File path: "))
> > +
> > +       if parsed_files[0] =3D=3D "debugfs" and len(parsed_files) =3D=
=3D 1:
> > +               parsed_files.pop()
> > +               for (root, _, files) in os.walk("/sys/kernel/debug/kuni=
t"):
> > +                       parsed_files.extend(os.path.join(root, f) for f=
 in files if f =3D=3D "results")
> > +
> > +       if not parsed_files:
> > +               print("No files found.")
> > +
> > +       for file in parsed_files:
> > +               if os.path.isfile(file):
>
> Note: perhaps we should reorder this to
>
> if os.path.isdir(file):
>    ...
> elif os.path.exists(file):
>   ...
>
> That way this code will then start handling non-regular, yet readable
> files, like links, etc.
> That would also help out if we started passing in the magic
> "/dev/stdin" (since it's a symlink)

Oh I see. Yes I will try to implement this! Thanks!

>
> > +                       print(file)
> > +                       with open(file, 'r', errors=3D'backslashreplace=
') as f:
> > +                               kunit_output =3D f.read().splitlines()
> > +                       # We know nothing about how the result was crea=
ted!
> > +                       metadata =3D kunit_json.Metadata()
> > +                       request =3D KunitParseRequest(raw_output=3Dcli_=
args.raw_output,
> > +                                                       json=3Dcli_args=
json)
> > +                       _, test =3D parse_tests(request, metadata, kuni=
t_output)
> > +                       total_test.subtests.append(test)
> > +               elif os.path.isdir(file):
> > +                       print("Ignoring directory ", file)
>
> minor nit: `print()` will automatically put a space between arguments, e.=
g.
> > Ignoring directory  .
> is what it'll print if I run `kunit.py parse .`
>
> It might be better to use a f-string so put quotes around it, like so
>   print(f'Ignoring directory "{file}"')}
> and below,
>   print(f'Could not find "{file}"')
>

Yep! Happy to change this.

> > +               else:
> > +                       print("Could not find ", file)
> > +
> > +       if len(parsed_files) > 1: # if more than one file was parsed ou=
tput total summary
> > +               print('All files parsed.')
> > +               if not request.raw_output:
> > +                       stdout.print_with_timestamp(kunit_parser.DIVIDE=
R)
> > +                       kunit_parser.bubble_up_test_results(total_test)
> > +                       kunit_parser.print_summary_line(total_test)
> >
> >
> >  subcommand_handlers_map =3D {
> > @@ -569,9 +592,10 @@ def main(argv: Sequence[str]) -> None:
> >                                             help=3D'Parses KUnit result=
s from a file, '
> >                                             'and parses formatted resul=
ts.')
> >         add_parse_opts(parse_parser)
> > -       parse_parser.add_argument('file',
> > -                                 help=3D'Specifies the file to read re=
sults from.',
> > -                                 type=3Dstr, nargs=3D'?', metavar=3D'i=
nput_file')
> > +       parse_parser.add_argument('files',
> > +                                 help=3D'List of file paths to read re=
sults from or keyword'
> > +                                               '"debugfs" to read all =
results from the debugfs directory.',
>
> minor spacing note: there are two ' 's here in the series of tabs, i.e.
>   ^I^I^I^I  ^I^I'"debugfs" to read all results from the debugfs directory=
',$
> (using vim's :list formatting)
>
> This was copy-pasted from the lines above and below which look like
>   ^I^I^I^I  help=3D'List of file paths to read results from or keyword'$
> i.e. they use the 2 spaces to align after the tabs.
>
> We can just drop those 2 spaces since they won't visually affect the
> outcome with a tabwidth of 8 spaces.

Thanks for pointing this out! I will change the spacing here. I am
thinking of just changing it to match the other lines. So something
like this:
 ^I^I^I^I  '"debugfs" to read all results from the debugfs directory.',$


>
> Sorry again for the delayed reply,
> Daniel

