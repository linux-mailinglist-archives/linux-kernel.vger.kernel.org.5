Return-Path: <linux-kernel+bounces-94772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA56874512
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D188C285BD3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590FC641;
	Thu,  7 Mar 2024 00:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jz7Ko40B"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E4360
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 00:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709770523; cv=none; b=GTDAn+GRX3mqspZhYJi3eX+gAVhQW/aJbge5l+KWIffuaeezCH7iYm/W/kffHHntxlVlfQ3hy/oYcv6EC2kjea9T1Y4PYYq3zIPcKKZH4/3yuLEpCT90JNty+PTEjRHC4pV9ivrvyeExxD6B2mdI7j0+xqUlykUmI82zYTmC7sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709770523; c=relaxed/simple;
	bh=x/S16KpL+i13Ge1mtNj16CtsEUJAtaUlgbZM53ueAvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=minRovrEnPb9W/DSOcJOVU1nxxB5+9/+y2jBAew3BQBRldOT8lqSBrm+ZshNo7xCs6A/T4TYsK2+vtfDQUHBcCR2hmHu2Bck1b7h5GRROSL9A8nTJMacmcCfPuw1u4VWieWfxHYGNgeRrYdDVQzaUPBOcnUE/oftNrLKOFk3Ghc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jz7Ko40B; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56693f0d235so4489a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 16:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709770520; x=1710375320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GogOwn0abICgptxLeFRJdB20nKt+qu1L7bx6MAwW9+Q=;
        b=jz7Ko40B6oVB9E8OByoPbNHegO5BgMMAGykfn3N11A4MrQyhQulN+gbcRzzCPRSvwB
         I+J8/C+VFGTptKwFTa5h0FeKi8W08wfJHemBNV8Lgr7QwmddleONgHwPN+IltzRkUohf
         R8vno/0tSD5qrHga3K+CLA1+lmGGINdqWzrIRiwSBk6Kd/rHcFJ9pV0TkAo+nPNqcfEQ
         Fj5nhjiV5ON194NP8xdmcwsbqU9FcT5y5EKYrJJq9w94uTtJ6fB4nIM3MCPh8dKOb9n+
         fb1rl4CnMb3zcWeQWC+nODdJ9WTjHLgv18F87YWn4ENAtOpa3BlL1zq3TxTTwpvsYyCy
         VhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709770520; x=1710375320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GogOwn0abICgptxLeFRJdB20nKt+qu1L7bx6MAwW9+Q=;
        b=muy+0KIzpt06JLA9r2bJZF1xY/Lm7z1wXJ/9EjY5d2QSNHRJ3MdPFojPDlRVFXk5ai
         w3xg1k2pDruvkS/38NfRs9BUq+ExYzOL5f3UTf17eFZoA0l9bj5Hv8ZEQOjUuW6aDGyr
         PD1tgMkGlxcDSF3/Fgs8Jpf8e6EAHMPbQ+rFrQzLKb7a1HRqRH1MKf8udRFowf5QAm+9
         rUIPWFZCpQ3bRHh+Au+vtyODPPOI1QCEHtT5ii0T7/2U4gfrqB5UzFnwjBD+EAn1i/YM
         Ukmx2VNT9W+vO48ORZ9JU058ulTplwpRTyxctCTHDUOv12m5D60nQnbb1ONZxNi9ydZv
         PvVA==
X-Forwarded-Encrypted: i=1; AJvYcCVLxcUIZr1RgTr+sMHBQVeQ1yWHi7hExzDVWL5/Ot+bEEiKmerDzXLTypNi3kJDfMOldl89Pkn2juZuUEMABWScnDOqqGvTbdc22S+q
X-Gm-Message-State: AOJu0YworioV6c5MS/Znoln3qTJRfnNP82WIteFttd5BPklSRR8uyVsk
	AnxYx+580xNhOFWFRRMZw2n65QgBb4HFKU66UUxc09bNYvC84Qi2xhLHJii96VwKIYObrUDHD0E
	Gx+9DF2KXR5RXfVcUFrexHLl7AJSH7CACfx0X
X-Google-Smtp-Source: AGHT+IF9p03Qc4LT5K21cURf5Rd6rTZoQi/xKG26xr51Lg0BX+yyGR4NdhuXt/Nqs5BEx/r4pKehWn9EFfmcasXzDzk=
X-Received: by 2002:a05:6402:298:b0:566:e8fc:8f83 with SMTP id
 l24-20020a056402029800b00566e8fc8f83mr72777edv.7.1709770519926; Wed, 06 Mar
 2024 16:15:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306223056.226518-1-rmoar@google.com>
In-Reply-To: <20240306223056.226518-1-rmoar@google.com>
From: Daniel Latypov <dlatypov@google.com>
Date: Wed, 6 Mar 2024 16:15:07 -0800
Message-ID: <CAGS_qxoMbFQMGtddX0B25qkH5p3RDZLgJEYbFcPBtsDDoUN-2Q@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: add ability to parse multiple files
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, davidgow@google.com, brendan.higgins@linux.dev, 
	kevko@google.com, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 2:30=E2=80=AFPM Rae Moar <rmoar@google.com> wrote:
>

Note: looks like there's two small bugs w/ the stdin codepath.
If both are addressed, it looks like stdin works again for me.

<snip>

> Changes since v1:
> - Annotate type of parsed_files
> - Add ability to input file name from stdin again
> - Make for loops a bit terser
> - Add no output warning
> - Change feature to take in multiple fields rather than a directory.
>   Currently nonrecursive. Let me know if people would prefer this as
>   recursive.

Just noting that I'd like to hear other's opinions on this.

I personally prefer the current approach.
I don't imagine there are going to be many nested directories of just
KTAP output files.

I.e. I'm assuming users would either be fine with
# just one dir w/ all KTAP outputs
$ kunit.py parse some_dir/*
# KTAP mixed in w/ other files, like we see in debugfs
$ find some_dir/ -name 'ktap_output' | xargs kunit.py parse

>
>  tools/testing/kunit/kunit.py | 45 +++++++++++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 13 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index bc74088c458a..df804a118aa5 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -511,19 +511,37 @@ def exec_handler(cli_args: argparse.Namespace) -> N=
one:
>
>
>  def parse_handler(cli_args: argparse.Namespace) -> None:
> -       if cli_args.file is None:
> +       parsed_files =3D [] # type: List[str]
> +       total_test =3D kunit_parser.Test()
> +       total_test.status =3D kunit_parser.TestStatus.SUCCESS
> +       if cli_args.files is None:
>                 sys.stdin.reconfigure(errors=3D'backslashreplace')  # typ=
e: ignore
> -               kunit_output =3D sys.stdin  # type: Iterable[str]
> +               parsed_files.append(sys.stdin)
> +       elif cli_args.files[0] =3D=3D "debugfs" and len(cli_args.files) =
=3D=3D 1:

For me, the stdin branch doesn't get taken, i.e.

$ ./tools/testing/kunit/kunit.py parse
..
  File "./tools/testing/kunit/kunit.py", line 520, in parse_handler
    elif cli_args.files[0] =3D=3D "debugfs" and len(cli_args.files) =3D=3D =
1:
         ~~~~~~~~~~~~~~^^^
IndexError: list index out of range

If unspecified, apparently `cli_args.files =3D=3D []`, so we'd want to chan=
ge it to
  if not cli_args.files:
     # stdin codepath

> +               for (root, _, files) in os.walk("/sys/kernel/debug/kunit"=
):
> +                       parsed_files.extend(os.path.join(root, f) for f i=
n files if f =3D=3D "results")
>         else:
> -               with open(cli_args.file, 'r', errors=3D'backslashreplace'=
) as f:
> +               parsed_files.extend(f for f in cli_args.files if os.path.=
isfile(f))
> +
> +       if len(parsed_files) =3D=3D 0:
> +               print("No output found.")

This is what a user sees if they pass a dir in now
$ ./tools/testing/kunit/kunit.py parse tools/testing/kunit/test_data/
No output found.

I'm wondering if we should try to make the user's error more obvious.
E.g. we could add a list where `not os.path.isfile(f)` and print it like:

$ ./tools/testing/kunit/kunit.py parse tools/testing/kunit/test_data/
Ignoring 1 non-regular files: tools/testing/kunit/test_data/
No output found.


> +
> +       for file in parsed_files:
> +               print(file)
> +               with open(file, 'r', errors=3D'backslashreplace') as f:

In the stdin case, `file` here is already a File object and not a filename.

Note: mypy/pytype will complain since the type annotation says List[str]
 kunit.py:520: error: Argument 1 to "append" of "list" has
incompatible type "TextIO"; expected "str"

Could do something like
       parsed_files =3D [] # type: List[Union[str, TextIO]]
..
               if isinstance(file, str):
                       print(file)
                       with open(file, 'r', errors=3D'backslashreplace') as=
 f:
                               kunit_output =3D f.read().splitlines()
               else:  # file is sys.stdin
                       kunit_output =3D file.read().splitlines()

With ^ and the change above to the `if`, seems like stdin works for me

$ echo "invalid" | ./tools/testing/kunit/kunit.py parse
$ ./tools/testing/kunit/kunit.py parse <
tools/testing/kunit/test_data/test_skip_tests.log

Thanks,
Daniel

