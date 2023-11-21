Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E817F2224
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjKUAav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjKUAar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:30:47 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2504BB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:30:41 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50931d0bb04so1161e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700526640; x=1701131440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvQ0rB+IUDdJY9ZjXpzk+S2nftp1wrq2OGd6WsZePU4=;
        b=dyU2utdGAU5BMa7DUaOBGd1jc3p1KwUrEO87meBqGKiHr0vliCWmPOJxpIo83zpzND
         2FEQSoEuGpzN4k5+xGngsSJuvXuyTi2DLBmxE5UOMxIKRY5aSZ5096DoON7zBy4T8Igb
         rPwb3RZJeIdWsrTuoV2kQNCh/wZOQ6mrWMCtNuvXCbDhm4GQ/M6iuK1ruMGS9QBl+HLm
         Vd8vBARg7PTw/sMruoP+KDevh88UaK1jgCXFtQLOetTm9Q3SbEDXqTZ2IarLrJ1yOHIk
         0BQav//BZaW1cbNXqCudylEybVMx8e54dxvusT/oSnRdUq3KBw9cmlmpcre4EjN6h6N2
         Ks0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700526640; x=1701131440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvQ0rB+IUDdJY9ZjXpzk+S2nftp1wrq2OGd6WsZePU4=;
        b=JcLzM8xBH1RvP7Ws+UGpa9EwsSwQLvrE6j2G6scL/BlqkAACsRISjR6l9iNyb2Y7sQ
         OAcUStEXY3WrQiHpEuNhRXBhbGa6iuxNN4SjjERxti1PCp4dg9oI+jq3xYn/XamV9e3w
         /jDpskTwWM400gagB+CQzJueGHVI43fMqJz09Ddsrjs3crCNZU3iMDaEth03ZYwFXDiy
         x5czRyS3c+PzlyOxVCCND51kKxDdVv8YeTI7hdP26a8f8FFHgyaX6Igi6VmfSPUdZMaZ
         3c4gILV/fOd4yR3r3QAnztsiAX3Ep4ItwxRNfNwsF/l48VRyAl9oo4wn3z1uhfrEktRx
         lfXg==
X-Gm-Message-State: AOJu0YxtJyM02d1jNJx76zyyMMSQqbsXXjAzXk4noR4s58J6HhLekSd8
        WOkMz9SvGX7zB99RGJnOvhHdqtVDFNUf5HAgoTvRR5ggFzRCAe/2zzFdIw==
X-Google-Smtp-Source: AGHT+IGhWa8uFpVZzszm1mkzH6FNOs2orD1AL4yp0wfXgD3+8jUuZf2t+MPTx5fRNLpCRz/xIIO9qnmOECzUHctWOTk=
X-Received: by 2002:a05:6512:401b:b0:50a:a7e5:eb93 with SMTP id
 br27-20020a056512401b00b0050aa7e5eb93mr194748lfb.2.1700526639940; Mon, 20 Nov
 2023 16:30:39 -0800 (PST)
MIME-Version: 1.0
References: <20231120112356.8652-1-zhaimingbing@cmss.chinamobile.com>
In-Reply-To: <20231120112356.8652-1-zhaimingbing@cmss.chinamobile.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Nov 2023 16:30:28 -0800
Message-ID: <CAP-5=fU4FBah=S_C7Zwh3MSNjwWtT5WrVB9OCc1jRM3eDCykng@mail.gmail.com>
Subject: Re: [PATCH] perf script perl: Fail check on dynamic allocation
To:     zhaimingbing <zhaimingbing@cmss.chinamobile.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Li Dong <lidong@vivo.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 3:24=E2=80=AFAM zhaimingbing
<zhaimingbing@cmss.chinamobile.com> wrote:
>
> Return ENOMEM when dynamic allocation failed.
>
> Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/scripting-engines/trace-event-perl.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools=
/perf/util/scripting-engines/trace-event-perl.c
> index 603091317..b072ac5d3 100644
> --- a/tools/perf/util/scripting-engines/trace-event-perl.c
> +++ b/tools/perf/util/scripting-engines/trace-event-perl.c
> @@ -490,6 +490,9 @@ static int perl_start_script(const char *script, int =
argc, const char **argv,
>         scripting_context->session =3D session;
>
>         command_line =3D malloc((argc + 2) * sizeof(const char *));
> +       if (!command_line)
> +               return -ENOMEM;
> +
>         command_line[0] =3D "";
>         command_line[1] =3D script;
>         for (i =3D 2; i < argc + 2; i++)
> --
> 2.33.0
>
>
>
>
