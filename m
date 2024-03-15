Return-Path: <linux-kernel+bounces-104985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CB987D746
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D02282B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022D3DDAD;
	Fri, 15 Mar 2024 23:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Pgv/7/Aa"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA69659B6C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 23:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710544608; cv=none; b=HzBurKx/Q3BSCK0FYBq/tM9GbaUHDpCgMamgyFv8/5wAb+5hhxPwQ0JdGLxvhnnayLp1U2i7aNga1aPWcDKh0NI5VjOAHDtAa8Hpeu4q4UqKE6R4bKPvHECMNsQMpSAOTeOMWhdKNC+HrSp+vLCOq7jpm0MCA8+iMEFsSrvVKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710544608; c=relaxed/simple;
	bh=YG1vd1juQNaQvSUKtPdn0fqcJqdzmUUrzhazjbC0GP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txXWQG2bh2+eLJKUx32FxK1CqbHVg6Ylp/BhFlAtbOsYsz6QJ2inFGRQ/Lrph5DDrxlV1SDOx93VTRAz1+QVNYRNyD0AkPr72jcNbtV0M0PIvsin4BNkRjW8+S1Zbnaf+T2/wW8QctvWUPiXHULZTULif8yby3krBeyZ/lWw1oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pgv/7/Aa; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5687ebddd8eso6135a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710544603; x=1711149403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwLzfWwBwbCcEZKduRLWrp8dVywQR/08FJQ2Cohkdxk=;
        b=Pgv/7/AazUMuiuJwUE47lyE32bdBeKtM8Ci1LOHucW3alba10AE6pAVoi5cbme/P3J
         +r8KyzbogSonYhi0XqUoHp93QC7QEeyBGTpf3+gRGfOI6JVczCaOurOIS2Ss54+xp8fE
         X5jgw6WTwdyHUjIIoslLoe8U1+pO1UWsCiTiebrJBbAkzYYoApj5x0Jnex23/kviSdH/
         M/lkG58Z3q6FviFILpO74EcntvEmByPXQhv8EOifviIU+z5NAj5iBJgzNbi0lKqssaMb
         KfZ5FAVnu+A/6Q3UzLgI0Vbg02MGIwANQ3kwTTE4m99MAbnXttBGDFeeaVRiZEgCVLGy
         Y19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710544603; x=1711149403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwLzfWwBwbCcEZKduRLWrp8dVywQR/08FJQ2Cohkdxk=;
        b=wp3cPXk+zVE0vmGa5P5nJSZ3gaegS8rSkDhVXdb66M85ocU6TXQS7X3pi+CoRKLvfh
         5MGPXPhOtTffXaXhXa79JunjSg3wuHuYWaJUEx2whuaQyhWrcBIQbRZCOJ7fs18lECjv
         RaM7drcY9H8QRNq7O04CG8WufnGbE+uVmdTORA9lIOGOD0mwpEE7+YcFhQWi73dRfCnx
         eRmUpWBbHczz4G8Jtgqheb2LU50f5amA4tOo7L2eVV428Gu8bLucfOoO3gUTmqQWvR5+
         PHRMseJZ3+vqkLHLO2gSZQs5zpKpsFMLl+n+UrS3kEcK2VWZQ6ogZNacSWOdE42rg2uP
         45zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOTM2U0SUN2kEjL055XAbcl4QmigmpjglJPSWcA0d+/j9IkJ4CnlTaikZmUWEPFTBxyzHWB3bgCiHE1ewha+9Ta9jXoLbM+8SY4xLn
X-Gm-Message-State: AOJu0Yzz56k5Wk2ZjoSBGRkPGkJ2diOZebFgKTGbneZzypiUAyjerQgW
	61KJtaaTBYqhietZIjK8wrCft2kipW4ezzNK33OFYiRii9iPa75nt5S2KTCiFraHe95tfktNpkY
	W5fkbwtXt8SqQ7Ymz47CL3JxAlsWbZC6etRuX
X-Google-Smtp-Source: AGHT+IGKD8w8/5z/F0F9q8ayCrR92OJWIbaZuDsOWlQLAzyPphKXnc4hYGvwLrq4DSMEKG49OUJvLfIeuKwgMy4Ibew=
X-Received: by 2002:a05:6402:898:b0:568:6ca6:98c1 with SMTP id
 e24-20020a056402089800b005686ca698c1mr18546edy.0.1710544602820; Fri, 15 Mar
 2024 16:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307222932.584164-1-rmoar@google.com>
In-Reply-To: <20240307222932.584164-1-rmoar@google.com>
From: Daniel Latypov <dlatypov@google.com>
Date: Fri, 15 Mar 2024 16:16:30 -0700
Message-ID: <CAGS_qxr==N-E4VHei0o-A1=5dno_ozqMsHPHoq7RFF5bearhpg@mail.gmail.com>
Subject: Re: [PATCH v3] kunit: tool: add ability to parse multiple files
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, davidgow@google.com, brendan.higgins@linux.dev, 
	kevko@google.com, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 2:29=E2=80=AFPM Rae Moar <rmoar@google.com> wrote:
>
> Add ability to parse multiple files. Additionally add the
> ability to parse all results in the KUnit debugfs repository.
>
> How to parse multiple files:
>
> ./tools/testing/kunit/kunit.py parse results.log results2.log
>
> How to parse all files in directory:
>
> ./tools/testing/kunit/kunit.py parse directory_path/*
>
> How to parse KUnit debugfs repository:
>
> ./tools/testing/kunit/kunit.py parse debugfs
>
> For each file, the parser outputs the file name, results, and test
> summary. At the end of all parsing, the parser outputs a total summary
> line.
>
> This feature can be easily tested on the tools/testing/kunit/test_data/
> directory.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---
> Changes since v2:
> - Fixed bug with input from command line. I changed this to use
>   input(). Daniel, let me know if this works for you.

Oops, sorry for the delay.

Hmm, it seems to be treating the stdin lines like file names

$ ./tools/testing/kunit/kunit.py parse <
/tools/testing/kunit/test_data/test_config_printk_time.log
File path: Could not find  [    0.060000] printk: console [mc-1] enabled

Oh, I see, we're prompting the user via
  input("File path: ")
?

I'm not necessarily against such a change, but I would personally
prefer the old behavior of being able to read ktap from stdin
directly.
As a user, I'd also prefer to only type out filenames as arguments
where I can get autocomplete, so `input()` here wouldn't help me
personally.

Applying a hackish patch like this [1] on top gets the behavior I'd
personally expect:
$ ./tools/testing/kunit/kunit.py parse <
/tools/testing/kunit/test_data/test_config_printk_time.log
/dev/stdin
..
[16:01:50] Testing complete. Ran 10 tests: passed: 10

I'd mentioned in the previous version that we could have parsed files
contain a `Union[str, TextIO]` and then read from the `sys.stdin` file
object directly.
But having it blindly open `/dev/stdin` seems to work just the same,
if we want to keep our list simpler and just hold strings.

[1] this just also re-orders the `os.path.isdir()` check as mentioned
below, which simplifies things
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 1aa3d736d80c..311d107bd684 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -515,18 +515,18 @@ def parse_handler(cli_args: argparse.Namespace) -> No=
ne:
        total_test =3D kunit_parser.Test()
        total_test.status =3D kunit_parser.TestStatus.SUCCESS
        if not parsed_files:
-               parsed_files.append(input("File path: "))
-
-       if parsed_files[0] =3D=3D "debugfs" and len(parsed_files) =3D=3D 1:
+               parsed_files.append('/dev/stdin')
+       elif len(parsed_files) =3D=3D 1 and parsed_files[0] =3D=3D "debugfs=
":
                parsed_files.pop()
                for (root, _, files) in os.walk("/sys/kernel/debug/kunit"):
                        parsed_files.extend(os.path.join(root, f) for
f in files if f =3D=3D "results")
-
-       if not parsed_files:
-               print("No files found.")
+               if not parsed_files:
+                       print("No files found.")

        for file in parsed_files:
-               if os.path.isfile(file):
+               if os.path.isdir(file):
+                       print("Ignoring directory ", file)
+               elif os.path.exists(file):
                        print(file)
                        with open(file, 'r', errors=3D'backslashreplace') a=
s f:
                                kunit_output =3D f.read().splitlines()
@@ -536,8 +536,6 @@ def parse_handler(cli_args: argparse.Namespace) -> None=
:
                                                        json=3Dcli_args.jso=
n)
                        _, test =3D parse_tests(request, metadata, kunit_ou=
tput)
                        total_test.subtests.append(test)
-               elif os.path.isdir(file):
-                       print("Ignoring directory ", file)
                else:
                        print("Could not find ", file)


> - Add more specific warning messages
>
>  tools/testing/kunit/kunit.py | 56 +++++++++++++++++++++++++-----------
>  1 file changed, 40 insertions(+), 16 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index bc74088c458a..1aa3d736d80c 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -511,19 +511,42 @@ def exec_handler(cli_args: argparse.Namespace) -> N=
one:
>
>
>  def parse_handler(cli_args: argparse.Namespace) -> None:
> -       if cli_args.file is None:
> -               sys.stdin.reconfigure(errors=3D'backslashreplace')  # typ=
e: ignore
> -               kunit_output =3D sys.stdin  # type: Iterable[str]
> -       else:
> -               with open(cli_args.file, 'r', errors=3D'backslashreplace'=
) as f:
> -                       kunit_output =3D f.read().splitlines()
> -       # We know nothing about how the result was created!
> -       metadata =3D kunit_json.Metadata()
> -       request =3D KunitParseRequest(raw_output=3Dcli_args.raw_output,
> -                                       json=3Dcli_args.json)
> -       result, _ =3D parse_tests(request, metadata, kunit_output)
> -       if result.status !=3D KunitStatus.SUCCESS:
> -               sys.exit(1)
> +       parsed_files =3D cli_args.files # type: List[str]
> +       total_test =3D kunit_parser.Test()
> +       total_test.status =3D kunit_parser.TestStatus.SUCCESS
> +       if not parsed_files:
> +               parsed_files.append(input("File path: "))
> +
> +       if parsed_files[0] =3D=3D "debugfs" and len(parsed_files) =3D=3D =
1:
> +               parsed_files.pop()
> +               for (root, _, files) in os.walk("/sys/kernel/debug/kunit"=
):
> +                       parsed_files.extend(os.path.join(root, f) for f i=
n files if f =3D=3D "results")
> +
> +       if not parsed_files:
> +               print("No files found.")
> +
> +       for file in parsed_files:
> +               if os.path.isfile(file):

Note: perhaps we should reorder this to

if os.path.isdir(file):
   ...
elif os.path.exists(file):
  ...

That way this code will then start handling non-regular, yet readable
files, like links, etc.
That would also help out if we started passing in the magic
"/dev/stdin" (since it's a symlink)

> +                       print(file)
> +                       with open(file, 'r', errors=3D'backslashreplace')=
 as f:
> +                               kunit_output =3D f.read().splitlines()
> +                       # We know nothing about how the result was create=
d!
> +                       metadata =3D kunit_json.Metadata()
> +                       request =3D KunitParseRequest(raw_output=3Dcli_ar=
gs.raw_output,
> +                                                       json=3Dcli_args.j=
son)
> +                       _, test =3D parse_tests(request, metadata, kunit_=
output)
> +                       total_test.subtests.append(test)
> +               elif os.path.isdir(file):
> +                       print("Ignoring directory ", file)

minor nit: `print()` will automatically put a space between arguments, e.g.
> Ignoring directory  .
is what it'll print if I run `kunit.py parse .`

It might be better to use a f-string so put quotes around it, like so
  print(f'Ignoring directory "{file}"')}
and below,
  print(f'Could not find "{file}"')

> +               else:
> +                       print("Could not find ", file)
> +
> +       if len(parsed_files) > 1: # if more than one file was parsed outp=
ut total summary
> +               print('All files parsed.')
> +               if not request.raw_output:
> +                       stdout.print_with_timestamp(kunit_parser.DIVIDER)
> +                       kunit_parser.bubble_up_test_results(total_test)
> +                       kunit_parser.print_summary_line(total_test)
>
>
>  subcommand_handlers_map =3D {
> @@ -569,9 +592,10 @@ def main(argv: Sequence[str]) -> None:
>                                             help=3D'Parses KUnit results =
from a file, '
>                                             'and parses formatted results=
')
>         add_parse_opts(parse_parser)
> -       parse_parser.add_argument('file',
> -                                 help=3D'Specifies the file to read resu=
lts from.',
> -                                 type=3Dstr, nargs=3D'?', metavar=3D'inp=
ut_file')
> +       parse_parser.add_argument('files',
> +                                 help=3D'List of file paths to read resu=
lts from or keyword'
> +                                               '"debugfs" to read all re=
sults from the debugfs directory.',

minor spacing note: there are two ' 's here in the series of tabs, i.e.
  ^I^I^I^I  ^I^I'"debugfs" to read all results from the debugfs directory.'=
,$
(using vim's :list formatting)

This was copy-pasted from the lines above and below which look like
  ^I^I^I^I  help=3D'List of file paths to read results from or keyword'$
i.e. they use the 2 spaces to align after the tabs.

We can just drop those 2 spaces since they won't visually affect the
outcome with a tabwidth of 8 spaces.

Sorry again for the delayed reply,
Daniel

