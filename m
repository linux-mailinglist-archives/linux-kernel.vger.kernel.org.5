Return-Path: <linux-kernel+bounces-157802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640C28B166E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1758B28424B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79DC16E887;
	Wed, 24 Apr 2024 22:48:51 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0654F155A50;
	Wed, 24 Apr 2024 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998931; cv=none; b=I5Ngc9TKV9FWh926uZo8om2OAnRW6ae3GKd/pTuwXR2/BKSj5fQbMes0Zy9p+NO/bJEVuA9AcjPXacBoYRlpZVBM7dCs0wbjVqePp4xL5mawNzFko5iBpXCmsWtYUijtBooQogPXekZkqSC810BFcksegegSiNnJ+L//1OMdXns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998931; c=relaxed/simple;
	bh=HWJ0tXck9M+iSd+3nJJ3wQ8Ni904YFXQtl5/s+z+x/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvF8iut72LmTa/riMeiQh9PBCG3HCixaHNUnyv0RtGt0Kk1JQET3YqoliOC2Z4pXgaIOkiUQuLgnLiVeAVrldetob/in4iXg7+D+TxOXwnxgADNZv4Paotp+wW2nE4PfaajEr3ydibs9d+kXcQlO5nJUHAAxmvFxTj9LoUVYq2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a58209b159so360466a91.3;
        Wed, 24 Apr 2024 15:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713998929; x=1714603729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+owEzSFWG5pFXPMumCZ4/vmcoV9pGQrrXPME2YLu4Y=;
        b=dVc/3Hea8tIyT0BawA5mlkKD/YvzD6VANZ/w1woMnQBOwNEgynhMNx0DOLLixjRZQ1
         Yi8ShI7BnEWvCUYvmyxE8qpj5sTtinYLZAXLGCWk83kIw94X7xi6MNJkI5aWBoRdQj7W
         cPyxVzU+I3XOEVyzrqgmhlzP3BE2smHoN90uuJVM/96FICVYKtG76SILVHl45kK3opLA
         kxAqen4hPJIS4KDnMjiVqVh2lUfdjhyW8dDvY7k/U5H4FUncEgIvEfoqxK9/F5zUPgTB
         8Fr+qtF+71kGjx47UXrWiann9P2IuS3B4j0NSfFea1DO5muXvD3rF9TsOs0XtphgGm/f
         9+nA==
X-Forwarded-Encrypted: i=1; AJvYcCVuH0U+bCmoVSmBY6ThA4/QjcjrKNGHBnJ6MVUAyfwOQjaVa7hWYxtk5wozl8dluB5BDZn2wTSBm/nfJZ7aPwajqHkWzmLTZMVWk1HLsigoZVGRZyQLJFg2X9X07Sy4VhGS0xTsSmOxR6LddlmpZQ==
X-Gm-Message-State: AOJu0YxxMJ4z2/occEpwfX/mZAmd14hLM+yjMpc6N+dmlPdvBhSPgJ7C
	7a7CY6noHKM7dDXdi088LKsiGcQ0KfQHxedYG7c6BiYpztqjuO33LrU49wggc2usEFDrB5tUgZu
	/Ny8N8jEhJK6b6o0YsktarxHCwn16iA==
X-Google-Smtp-Source: AGHT+IFaBv/6c7bT0MScbt+rbE18T1j/g7V487YpBTYUJeYKtkTeGT5QDXYadnfxvQYT6EYKYSjH7qsu2rOKD+wybZA=
X-Received: by 2002:a17:90b:3e87:b0:2ae:b8df:89e7 with SMTP id
 rj7-20020a17090b3e8700b002aeb8df89e7mr4001520pjb.38.1713998929108; Wed, 24
 Apr 2024 15:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424001231.849972-1-namhyung@kernel.org> <CAP-5=fWNWiuiLOKyNHYcuT9xmJkciUBodjCX1E_TRrTMMsM4uw@mail.gmail.com>
 <ZilzYDlzj7c1mQq4@x1>
In-Reply-To: <ZilzYDlzj7c1mQq4@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 24 Apr 2024 15:48:37 -0700
Message-ID: <CAM9d7cg0bKF7+BtmkFxnHtiUZcgCWNG7eMqDccrZnM92G78vdQ@mail.gmail.com>
Subject: Re: [PATCH] perf test: Add a new test for perf annotate
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 2:02=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Apr 24, 2024 at 11:09:48AM -0700, Ian Rogers wrote:
> > On Tue, Apr 23, 2024 at 5:12=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Add a basic perf annotate test
> > >
> > >   $ ./perf test annotate -vv
> > >    76: perf annotate basic tests:
> > >   --- start ---
> > >   test child forked, pid 846989
> > >    fbcd0-fbd55 l noploop
> > >   perf does have symbol 'noploop'
> > >   Basic perf annotate test
> > >            : 0     0xfbcd0 <noploop>:
> > >       0.00 :   fbcd0:       pushq   %rbp
> > >       0.00 :   fbcd1:       movq    %rsp, %rbp
> > >       0.00 :   fbcd4:       pushq   %r12
> > >       0.00 :   fbcd6:       pushq   %rbx
> > >       0.00 :   fbcd7:       movl    $1, %ebx
> > >       0.00 :   fbcdc:       subq    $0x10, %rsp
> > >       0.00 :   fbce0:       movq    %fs:0x28, %rax
> > >       0.00 :   fbce9:       movq    %rax, -0x18(%rbp)
> > >       0.00 :   fbced:       xorl    %eax, %eax
> > >       0.00 :   fbcef:       testl   %edi, %edi
> > >       0.00 :   fbcf1:       jle     0xfbd04
> > >       0.00 :   fbcf3:       movq    (%rsi), %rdi
> > >       0.00 :   fbcf6:       movl    $0xa, %edx
> > >       0.00 :   fbcfb:       xorl    %esi, %esi
> > >       0.00 :   fbcfd:       callq   0x41920
> > >       0.00 :   fbd02:       movl    %eax, %ebx
> > >       0.00 :   fbd04:       leaq    -0x7b(%rip), %r12   # fbc90 <sigh=
andler>
> > >       0.00 :   fbd0b:       movl    $2, %edi
> > >       0.00 :   fbd10:       movq    %r12, %rsi
> > >       0.00 :   fbd13:       callq   0x40a00
> > >       0.00 :   fbd18:       movl    $0xe, %edi
> > >       0.00 :   fbd1d:       movq    %r12, %rsi
> > >       0.00 :   fbd20:       callq   0x40a00
> > >       0.00 :   fbd25:       movl    %ebx, %edi
> > >       0.00 :   fbd27:       callq   0x407c0
> > >       0.10 :   fbd2c:       movl    0x89785e(%rip), %eax        # 993=
590 <done>
> > >       0.00 :   fbd32:       testl   %eax, %eax
> > >      99.90 :   fbd34:       je      0xfbd2c
> > >       0.00 :   fbd36:       movq    -0x18(%rbp), %rax
> > >       0.00 :   fbd3a:       subq    %fs:0x28, %rax
> > >       0.00 :   fbd43:       jne     0xfbd50
> > >       0.00 :   fbd45:       addq    $0x10, %rsp
> > >       0.00 :   fbd49:       xorl    %eax, %eax
> > >       0.00 :   fbd4b:       popq    %rbx
> > >       0.00 :   fbd4c:       popq    %r12
> > >       0.00 :   fbd4e:       popq    %rbp
> > >       0.00 :   fbd4f:       retq
> > >       0.00 :   fbd50:       callq   0x407e0
> > >       0.00 :   fbcd0:       pushq   %rbp
> > >       0.00 :   fbcd1:       movq    %rsp, %rbp
> > >       0.00 :   fbcd4:       pushq   %r12
> > >       0.00 :   fbcd0:  push   %rbp
> > >       0.00 :   fbcd1:  mov    %rsp,%rbp
> > >       0.00 :   fbcd4:  push   %r12
> > >   Basic annotate test [Success]
> > >   ---- end(0) ----
> > >    76: perf annotate basic tests                                     =
  : Ok
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Looks good, thanks for this!
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks! Applied, with the following changes to improve the error
> reporting, please holler if you disagree:

LGTM!

Thanks,
Namhyung

>
> diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/=
annotate.sh
> index 7820d13eebaef535..1db1e8113d9943a6 100755
> --- a/tools/perf/tests/shell/annotate.sh
> +++ b/tools/perf/tests/shell/annotate.sh
> @@ -36,7 +36,7 @@ test_basic() {
>    echo "Basic perf annotate test"
>    if ! perf record -o "${perfdata}" ${testprog} 2> /dev/null
>    then
> -    echo "Basic annotate [Failed record]"
> +    echo "Basic annotate [Failed: perf record]"
>      err=3D1
>      return
>    fi
> @@ -44,7 +44,7 @@ test_basic() {
>    # check if it has the target symbol
>    if ! perf annotate -i "${perfdata}" 2> /dev/null | grep "${testsym}"
>    then
> -    echo "Basic annotate [Failed missing symbol]"
> +    echo "Basic annotate [Failed: missing target symbol]"
>      err=3D1
>      return
>    fi
> @@ -52,7 +52,7 @@ test_basic() {
>    # check if it has the disassembly lines
>    if ! perf annotate -i "${perfdata}" 2> /dev/null | grep "${disasm_rege=
x}"
>    then
> -    echo "Basic annotate [Failed missing disasm output]"
> +    echo "Basic annotate [Failed: missing disasm output from default dis=
assembler]"
>      err=3D1
>      return
>    fi
> @@ -61,7 +61,7 @@ test_basic() {
>    if ! perf annotate -i "${perfdata}" "${testsym}" 2> /dev/null | \
>           grep -m 3 "${disasm_regex}"
>    then
> -    echo "Basic annotate [Failed missing disasm output]"
> +    echo "Basic annotate [Failed: missing disasm output when specifying =
the target symbol]"
>      err=3D1
>      return
>    fi
> @@ -70,7 +70,7 @@ test_basic() {
>    if ! perf annotate -i "${perfdata}" --objdump=3Dobjdump 2> /dev/null |=
 \
>           grep -m 3 "${disasm_regex}"
>    then
> -    echo "Basic annotate [Failed missing disasm output from objdump]"
> +    echo "Basic annotate [Failed: missing disasm output from non default=
 disassembler (using --objdump)]"
>      err=3D1
>      return
>    fi

