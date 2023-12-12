Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401FE80F539
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377081AbjLLSI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377064AbjLLSIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:08:25 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3939394
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:08:31 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bf09be81bso156e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702404509; x=1703009309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hpk0I1KigXVxBpZ4grAzm0OjYz4EHzBeGwLl/SIDW/0=;
        b=Bg0uoCzhmDOfY4WXX8qTnG0J4MgrFdB3BcGqN+/g3BFV0NjyDVu2S/Ydgd6LBnd9lq
         kvA5aP3dTmpzYTeqCnfxYg+mIu7PjVu08xaDrJ5/R81oYnCc8tetGncToZ5RwewGQr2G
         hIecZ2B2EMZYkRKdmq03/fMawLyp/Clra4R0jz3OKl7KUpOOMjdBFLRnmbGmHR7TzLhG
         JfSvGMUkLEY78y7akqdkGKPahCkM8lkJwdqYDducb5bZJWBPXUnn3bOeXNUNsvG5OgNJ
         hKMXlT3rRstYo9Fy0znuGJmewbX3slm++9r9N4O3itJ2FRJSij5zm2n8e5Fnasuz2P78
         IQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702404509; x=1703009309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hpk0I1KigXVxBpZ4grAzm0OjYz4EHzBeGwLl/SIDW/0=;
        b=ehDdyTBK7H/IjYsFDRk95ejnqoZWQ4v9Ovn0bTFg5HOGopVmuWAPL5hGFiUmAJthlc
         Q7ptr38KhaSeramz3qQiEzoW0Syw/Kdye/UDznxcIKs/2YTag/95VBezWje41AYkb3zl
         IKsPaCvuO+nQXY9bTXP/QfhmoOIZ3gKkkOGZZBxKgrBPRKVn5YyGtTI7Cy+emZEzOmaZ
         jLbCr3X81W/YZs7el8oyR6hglGAcnw58qwWem8S8vEAMWQGokh3a7J4P+srRx1alLzdt
         hfChnqwqpDSdS4SFCOPI6nMK9EJEQQLjebbmTaHNQ3ljqMZK1YfAKoXoIVbmZvFbeupJ
         Riiw==
X-Gm-Message-State: AOJu0YyuiTMlSzF9E5ELrci11zp0MgAPJaYV3ZCAs1Re7Oqv4Ac1UdWa
        1yZGltLMFN1hslBDaN2MTonR/bu+v/1ithnHWrphIA==
X-Google-Smtp-Source: AGHT+IFBZ05n9XhR5PQ15KNzGWQ5iv+YNiqgeDMnt5FCveq3o4RVTN+QwviBU+wV1z4qSILlNCDFINKGAnaqCb98Wzk=
X-Received: by 2002:a05:6512:539:b0:50c:e19:b658 with SMTP id
 o25-20020a056512053900b0050c0e19b658mr267201lfc.1.1702404509283; Tue, 12 Dec
 2023 10:08:29 -0800 (PST)
MIME-Version: 1.0
References: <20231212070547.612536-1-namhyung@kernel.org> <20231212070547.612536-4-namhyung@kernel.org>
In-Reply-To: <20231212070547.612536-4-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 12 Dec 2023 10:08:18 -0800
Message-ID: <CAP-5=fW+iS8J=DVW3qmQK9n0y1vLkZxn62JX8D8ETTWBtuq09A@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf unwind-libunwind: Fix base address for .eh_frame
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Pablo Galindo <pablogsal@gmail.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 11:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> The base address of a DSO mapping should start at the start of the file.
> Usually DSOs are mapped from the pgoff 0 so it doesn't matter when it
> uses the start of the map address.  But generated DSOs for JIT codes
> doesn't start from the 0 so it should subtract the offset to calculate
> the .eh_frame table offsets correctly.
>
> Fixes: dc2cf4ca866f ("perf unwind: Fix segbase for ld.lld linked objects"=
)
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/unwind-libunwind-local.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/u=
nwind-libunwind-local.c
> index c0641882fd2f..5e5c3395a499 100644
> --- a/tools/perf/util/unwind-libunwind-local.c
> +++ b/tools/perf/util/unwind-libunwind-local.c
> @@ -327,7 +327,7 @@ static int read_unwind_spec_eh_frame(struct dso *dso,=
 struct unwind_info *ui,
>
>         maps__for_each_entry(thread__maps(ui->thread), map_node) {
>                 struct map *map =3D map_node->map;
> -               u64 start =3D map__start(map);
> +               u64 start =3D map__start(map) - map__pgoff(map);
>
>                 if (map__dso(map) =3D=3D dso && start < base_addr)
>                         base_addr =3D start;
> --
> 2.43.0.472.g3155946c3a-goog
>
