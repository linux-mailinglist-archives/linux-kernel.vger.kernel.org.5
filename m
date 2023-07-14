Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C064E75367D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbjGNJaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbjGNJaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:30:11 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9532D5F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:30:09 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b701e1c80fso24820831fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1689327008; x=1691919008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dosegy5s6S3Py/sYCBb7fr6YwHTMUrv8EM9f77WeMOc=;
        b=Xqcw23ipPcPee2KGDUUmScxC6YI+Lt+tpZLhyiWzpqBFRO340fdakn0xdVV1NlwZYo
         8LZbDjW6NUOsDs0GB/lm0oM1oxUlYm5/QtzGj1+yTps3jl6EW1l2EbnJeFvc6s69+PMu
         3etpZNsNrgUTw2j28xUGW6FsyP7PGWyvOkhIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689327008; x=1691919008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dosegy5s6S3Py/sYCBb7fr6YwHTMUrv8EM9f77WeMOc=;
        b=M+DtQBWiwDIqVmkJnLhdVFObnulm3VnfBZ0Ky8NAr03FDNUGmTPHLuTUale0TzLAng
         3Hgl3VrmvC1n28bCZ6xWx4XoLbrS1S7h/BsADjNoG3YDVQAN2HEPrWNS6N8bMxbhBmrp
         uhYU2dTL3otMdVcZcPBHgWCrEmujJM/tjji+rdCac1rbQAnQRpg4uSDa4K8r87b2TpmL
         3YtEuxnwsMWAi/UpMGxxl+Z4PpF6NWzsXR5kdnnn/NHEiI4CNgcv6KUrei1qLpM3ANV3
         b7xQefTZjvJjpv7KLKWsX7rHJZ8rsWLtCeHZsszUwMTR9eLc8jVHAw4tMnBnPXHuzkXG
         pKlQ==
X-Gm-Message-State: ABy/qLZG9g4Ddz4WT1Iqk/Nu3UXIJMJ8INhjIVRh07s/n97Ll1BfiPBT
        9l1KcnnDQ8N6+QUTm+kgCQg3ONcwAh0KSLGoYKv0
X-Google-Smtp-Source: APBJJlEPgo1IICV+iHBqiUW+Vh3Nr2Vbvx10CePV36LNEMGHrNoz3v5ECTBa/vGZDHxkGoGYB97wfvhB3JFhCknlnkc=
X-Received: by 2002:a2e:a16f:0:b0:2b6:d57f:d81 with SMTP id
 u15-20020a2ea16f000000b002b6d57f0d81mr3198367ljl.53.1689327007925; Fri, 14
 Jul 2023 02:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230703124647.215952-1-alexghiti@rivosinc.com> <20230703124647.215952-11-alexghiti@rivosinc.com>
In-Reply-To: <20230703124647.215952-11-alexghiti@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 14 Jul 2023 02:29:56 -0700
Message-ID: <CAOnJCUJcYAX3=h=O6nCjN+hAL9cT8Cmw5sgXa1MZpKEPCuyM-A@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] perf: tests: Adapt mmap-basic.c for riscv
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 5:57=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> riscv now supports mmaping hardware counters to userspace so adapt the te=
st
> to run on this architecture.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  tools/perf/tests/mmap-basic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.=
c
> index e68ca6229756..f5075ca774f8 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -284,7 +284,7 @@ static struct test_case tests__basic_mmap[] =3D {
>                          "permissions"),
>         TEST_CASE_REASON("User space counter reading of instructions",
>                          mmap_user_read_instr,
> -#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || =
__riscv_xlen =3D=3D 64
>                          "permissions"
>  #else
>                          "unsupported"
> @@ -292,7 +292,7 @@ static struct test_case tests__basic_mmap[] =3D {
>                 ),
>         TEST_CASE_REASON("User space counter reading of cycles",
>                          mmap_user_read_cycles,
> -#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || =
__riscv_xlen =3D=3D 64
>                          "permissions"
>  #else
>                          "unsupported"
> --
> 2.39.2
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
--=20
Regards,
Atish
