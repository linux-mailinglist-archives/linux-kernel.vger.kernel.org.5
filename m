Return-Path: <linux-kernel+bounces-157442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB7F8B11B7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2101D1C22E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E592616D9A3;
	Wed, 24 Apr 2024 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QW+Bi4CO"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9F216D4E5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982206; cv=none; b=n2yH6FMtsdP2wrVqsO54v6Zv7f0FS/ggTW71reJbzC3J9qIDGJLxJNq4606bVO/DaTuFiw1BJRzh0Cgw81tge23nAFhLaUAuDpNkoOAeF6O1bG2MQWnc0d3cYMCTnA1MBNnJdjyBFvfgZZoxVLqRKj0C5BQQ9rNTEdLJtKWyYWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982206; c=relaxed/simple;
	bh=jW/Q55tFYbDjApVjeRiSYiCAMWJJXza1aMX93bHT510=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlAg2Clw+dnrpNxjIWCQZSy3cbCf+A7aCYFY0vhDtAM/Nae3mugdDvHDwQVsASzJeF0rXUkGah07e1K5TrOH6/AzK6W2Uht4fYQYVqg8Z2X23wTEH/GkclSCJChJxVBUOj6ZAEocQYw60oiq7Ubvo3AIy7Fv+7tOFe0cbLXQ5XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QW+Bi4CO; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-439b1c72676so51061cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713982203; x=1714587003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0p7tew2agWpR4bqy2GNP4coWXMPXtcWBzHy2OtkeHU=;
        b=QW+Bi4COtIuCXgUr7kZfIbEl0vXLBMhdIEEAmPplYqi0qOwCPfGKmDbOaag2M0YYEH
         9TF/RpYP4mdani2KGWMD0LUuHwTEfoxQRSneoXgIwnE9e7LfTvxeSMutEEAzdw2g5nGC
         Xv26mMqd5TtkyRGnJ/Q3cr0vuEQ/zVJEeV/TasgrOV193xIJ66aiGehjf4uOUy/uMuL/
         uLKCKUqkdR0CibqQKXJ1LvWzz7sF3yLRf+e6JRlKHsCDp8cteW+0Hs6+8vXDvT5AwkDV
         rrk77kL9LNj4Uf76SbGKUmRDHN9yL+0mvlsKWuf6PsDxA0Ysb29MOaDDYPqBfyPFYDQT
         gK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713982203; x=1714587003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0p7tew2agWpR4bqy2GNP4coWXMPXtcWBzHy2OtkeHU=;
        b=JVX2jzx5ErccQg7hMz8V6TAJkRswsC8vt6POeHkjkXoVbbjFGNWLdmGir8Pm13InSL
         QGYQsfiY8QRg+LkJwPPjd83oPrsSmYjg06d5n42xgh6ES6gRP2iI+t/tD5E/Mr/g2VbI
         OZm3B333roHFlYBNPrTRH2ybi0VxwCd6B5rzo9JzPhPfABJL/5PZ0LUa6N+ten8oqJPA
         aWAO7aeuGG60x6C5aOVoz1cTk7DJF2YwR8gz+FkHJa/pj33INjLE3TXhET7A53amiimW
         TfJjjSSlKkKCxFHCD+SEYCxp1TfIm2y31G9GOdp+F+y6Heh3DV2WuyQUedVJXaaAc308
         dgJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZbLMoMVrYDhUXzyX2JMWgYqq5aOph4IZgrC0vRp4vzU0N7nBRtNSoshEUeET6aNnRc6cL6Me86wXGpxgWcL+K/jmw7GVPLa4Ho3BX
X-Gm-Message-State: AOJu0YyKbE1s+zenj6HWcPcf8dcyYOhOKvtcHoUOlRzmHGZa2fHCUysJ
	OFCdTnyw6UYjs5w73/uk4SeBJv9JFMLck8RadfjVNyk6KtgHvEme+AMVXSkKEHaXWGntsYg9456
	TpzD95AR6AGJ9+IIsd9QdadS5oqZfLq0eJbfW
X-Google-Smtp-Source: AGHT+IEf1xK91w8EzNnQxjP/YvLQLVL0MX8bH38rlLCAsYIwB/Wz6ve1x9vMseOWLCGw26FrjLwHxWb/DuvT4Zwzs8U=
X-Received: by 2002:ac8:134a:0:b0:437:8ba1:ee1 with SMTP id
 f10-20020ac8134a000000b004378ba10ee1mr9969qtj.5.1713982203329; Wed, 24 Apr
 2024 11:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424001231.849972-1-namhyung@kernel.org>
In-Reply-To: <20240424001231.849972-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Apr 2024 11:09:48 -0700
Message-ID: <CAP-5=fWNWiuiLOKyNHYcuT9xmJkciUBodjCX1E_TRrTMMsM4uw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Add a new test for perf annotate
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 5:12=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Add a basic perf annotate test
>
>   $ ./perf test annotate -vv
>    76: perf annotate basic tests:
>   --- start ---
>   test child forked, pid 846989
>    fbcd0-fbd55 l noploop
>   perf does have symbol 'noploop'
>   Basic perf annotate test
>            : 0     0xfbcd0 <noploop>:
>       0.00 :   fbcd0:       pushq   %rbp
>       0.00 :   fbcd1:       movq    %rsp, %rbp
>       0.00 :   fbcd4:       pushq   %r12
>       0.00 :   fbcd6:       pushq   %rbx
>       0.00 :   fbcd7:       movl    $1, %ebx
>       0.00 :   fbcdc:       subq    $0x10, %rsp
>       0.00 :   fbce0:       movq    %fs:0x28, %rax
>       0.00 :   fbce9:       movq    %rax, -0x18(%rbp)
>       0.00 :   fbced:       xorl    %eax, %eax
>       0.00 :   fbcef:       testl   %edi, %edi
>       0.00 :   fbcf1:       jle     0xfbd04
>       0.00 :   fbcf3:       movq    (%rsi), %rdi
>       0.00 :   fbcf6:       movl    $0xa, %edx
>       0.00 :   fbcfb:       xorl    %esi, %esi
>       0.00 :   fbcfd:       callq   0x41920
>       0.00 :   fbd02:       movl    %eax, %ebx
>       0.00 :   fbd04:       leaq    -0x7b(%rip), %r12   # fbc90 <sighandl=
er>
>       0.00 :   fbd0b:       movl    $2, %edi
>       0.00 :   fbd10:       movq    %r12, %rsi
>       0.00 :   fbd13:       callq   0x40a00
>       0.00 :   fbd18:       movl    $0xe, %edi
>       0.00 :   fbd1d:       movq    %r12, %rsi
>       0.00 :   fbd20:       callq   0x40a00
>       0.00 :   fbd25:       movl    %ebx, %edi
>       0.00 :   fbd27:       callq   0x407c0
>       0.10 :   fbd2c:       movl    0x89785e(%rip), %eax        # 993590 =
<done>
>       0.00 :   fbd32:       testl   %eax, %eax
>      99.90 :   fbd34:       je      0xfbd2c
>       0.00 :   fbd36:       movq    -0x18(%rbp), %rax
>       0.00 :   fbd3a:       subq    %fs:0x28, %rax
>       0.00 :   fbd43:       jne     0xfbd50
>       0.00 :   fbd45:       addq    $0x10, %rsp
>       0.00 :   fbd49:       xorl    %eax, %eax
>       0.00 :   fbd4b:       popq    %rbx
>       0.00 :   fbd4c:       popq    %r12
>       0.00 :   fbd4e:       popq    %rbp
>       0.00 :   fbd4f:       retq
>       0.00 :   fbd50:       callq   0x407e0
>       0.00 :   fbcd0:       pushq   %rbp
>       0.00 :   fbcd1:       movq    %rsp, %rbp
>       0.00 :   fbcd4:       pushq   %r12
>       0.00 :   fbcd0:  push   %rbp
>       0.00 :   fbcd1:  mov    %rsp,%rbp
>       0.00 :   fbcd4:  push   %r12
>   Basic annotate test [Success]
>   ---- end(0) ----
>    76: perf annotate basic tests                                       : =
Ok
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Looks good, thanks for this!

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/annotate.sh | 83 ++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100755 tools/perf/tests/shell/annotate.sh
>
> diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/=
annotate.sh
> new file mode 100755
> index 000000000000..7820d13eebae
> --- /dev/null
> +++ b/tools/perf/tests/shell/annotate.sh
> @@ -0,0 +1,83 @@
> +#!/bin/sh
> +# perf annotate basic tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +shelldir=3D$(dirname "$0")
> +
> +# shellcheck source=3Dlib/perf_has_symbol.sh
> +. "${shelldir}"/lib/perf_has_symbol.sh
> +
> +testsym=3D"noploop"
> +
> +skip_test_missing_symbol ${testsym}
> +
> +err=3D0
> +perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +testprog=3D"perf test -w noploop"
> +# disassembly format: "percent : offset: instruction (operands ...)"
> +disasm_regex=3D"[0-9]*\.[0-9]* *: *\w*: *\w*"
> +
> +cleanup() {
> +  rm -rf "${perfdata}"
> +  rm -rf "${perfdata}".old
> +
> +  trap - EXIT TERM INT
> +}
> +
> +trap_cleanup() {
> +  cleanup
> +  exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
> +
> +test_basic() {
> +  echo "Basic perf annotate test"
> +  if ! perf record -o "${perfdata}" ${testprog} 2> /dev/null
> +  then
> +    echo "Basic annotate [Failed record]"
> +    err=3D1
> +    return
> +  fi
> +
> +  # check if it has the target symbol
> +  if ! perf annotate -i "${perfdata}" 2> /dev/null | grep "${testsym}"
> +  then
> +    echo "Basic annotate [Failed missing symbol]"
> +    err=3D1
> +    return
> +  fi
> +
> +  # check if it has the disassembly lines
> +  if ! perf annotate -i "${perfdata}" 2> /dev/null | grep "${disasm_rege=
x}"
> +  then
> +    echo "Basic annotate [Failed missing disasm output]"
> +    err=3D1
> +    return
> +  fi
> +
> +  # check again with a target symbol name
> +  if ! perf annotate -i "${perfdata}" "${testsym}" 2> /dev/null | \
> +         grep -m 3 "${disasm_regex}"
> +  then
> +    echo "Basic annotate [Failed missing disasm output]"
> +    err=3D1
> +    return
> +  fi
> +
> +  # check one more with external objdump tool (forced by --objdump optio=
n)
> +  if ! perf annotate -i "${perfdata}" --objdump=3Dobjdump 2> /dev/null |=
 \
> +         grep -m 3 "${disasm_regex}"
> +  then
> +    echo "Basic annotate [Failed missing disasm output from objdump]"
> +    err=3D1
> +    return
> +  fi
> +  echo "Basic annotate test [Success]"
> +}
> +
> +test_basic
> +
> +cleanup
> +exit $err
> --
> 2.44.0.769.g3c40516874-goog
>

