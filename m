Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42F980F538
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377086AbjLLSII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377081AbjLLSIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:08:06 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961DBCA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:08:12 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso2985e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702404491; x=1703009291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhYdf+8cQfQ3MBTe94vw2YkuW7rtXoDUvtiEUFEToaQ=;
        b=WuDYgIxEwZyV86F+YyWEX3X8tT0gogswv5nuOtTCuS+TCMheELgY9+CrcDV2A++ptJ
         XhFBSApt1S1BPbvn872zL1+PXMPwyFpgrw/7sWt9uB37qdK+tI1g1f2IKbOisvogtzXV
         4hG3yLHHvHMNbqRAOrGdkAYY8EwrHKxpUHG59Ka+XB6XT9Gx6kLQ8n1WcQL2SJ6S9nmP
         JhDAaS379pfjHMlRjti8wdUYlE/hoIITOlidzrUJp4hqWzTSnjtERAdZy6t++BHV98dm
         dU0slBlQgl6L8MTlpXwF2iD/u/17wfRGgB8/nkp/+hVNfMGyKsBMvrkaDBYnj1JvFVqa
         2AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702404491; x=1703009291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhYdf+8cQfQ3MBTe94vw2YkuW7rtXoDUvtiEUFEToaQ=;
        b=q9q+2CHMQcSUFTVArfUzV5gDhjfnUOAMQcI1eqDPdDLUCEz/a0kj1iYlKZILYCu7Ee
         3zXR19eY40gyvXIEUpaUOCrCUTHaOOSXzL46qSF1/STQgHEsF5B6v3EkvClvb+4Znamk
         OnhmF0He5OWGfCtB/F/JdP3QwBoH7vYn5gBcWIGpRkwMp9ZmsCK6b9al2+/42hzsea8b
         eOyqxPWE+VKWBbO4dE5QQnrZ8qnBMhihQaoNdRyHJF8RPjV0002maMyx2b+4M11dhQBa
         WMob4eX7E8dUfe9RM08RjmMJNnn3SaUGKJRS0BGaldJYp8XP/c1EQXDsB2mngmQ7nEv1
         N8cw==
X-Gm-Message-State: AOJu0YzZx3W+IkgNvXajstKxro2l/L7glKrC6y5/hqe+g8UEk6Y6ZSVL
        HYUcwEXDDP845TJdeIC+RujjS21UglXtVVm2l3Dqsg==
X-Google-Smtp-Source: AGHT+IEY9JpTUZMLV0vKfFqIa+W0hU/BLMoseO7ZQoy1ydLtjF1Ozffn/lu+j4tpuI19zVLxcHQ6IJKe8IEo2dyMPyE=
X-Received: by 2002:a05:600c:3648:b0:3f7:3e85:36a with SMTP id
 y8-20020a05600c364800b003f73e85036amr324700wmq.7.1702404490911; Tue, 12 Dec
 2023 10:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20231212070547.612536-1-namhyung@kernel.org> <20231212070547.612536-2-namhyung@kernel.org>
In-Reply-To: <20231212070547.612536-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 12 Dec 2023 10:07:59 -0800
Message-ID: <CAP-5=fUsVd-ZAL0yBeKpQ5RvQVWs+ujXZj679sYQAwPLmzrCXQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf genelf: Set ELF program header addresses properly
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 11:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> The text section starts after the ELF headers so PHDR.p_vaddr and
> others should have the correct addresses.
>
> Fixes: babd04386b1d ("perf jit: Include program header in ELF files")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/genelf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
> index fefc72066c4e..ac17a3cb59dc 100644
> --- a/tools/perf/util/genelf.c
> +++ b/tools/perf/util/genelf.c
> @@ -293,9 +293,9 @@ jit_write_elf(int fd, uint64_t load_addr, const char =
*sym,
>          */
>         phdr =3D elf_newphdr(e, 1);
>         phdr[0].p_type =3D PT_LOAD;
> -       phdr[0].p_offset =3D 0;
> -       phdr[0].p_vaddr =3D 0;
> -       phdr[0].p_paddr =3D 0;
> +       phdr[0].p_offset =3D GEN_ELF_TEXT_OFFSET;
> +       phdr[0].p_vaddr =3D GEN_ELF_TEXT_OFFSET;
> +       phdr[0].p_paddr =3D GEN_ELF_TEXT_OFFSET;
>         phdr[0].p_filesz =3D csize;
>         phdr[0].p_memsz =3D csize;
>         phdr[0].p_flags =3D PF_X | PF_R;
> --
> 2.43.0.472.g3155946c3a-goog
>
