Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7971A7FF93D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346356AbjK3SXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjK3SXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:23:38 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B85D1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:23:44 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b51e26a7aso11865e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701368623; x=1701973423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dzWqt5ncHZST4wzgqFNCBg5DuH2RtK6Ow/4bVvt1ow=;
        b=fRwBHf/ehmbMzI+xp1Wgy5ut5j7hKvYuNH3M/m/x1RKdzT2glOcBRdAj0WLOeHZi9N
         OlzaK1+1nWJT63JXzj2EUTFVRE61rEySlk6vg0nmX7V2ljb9Zu2R7ueXET3vgz+iREc6
         9MDOpB55mbSUeGtFY5Z/TpDcghMqnDwVXM9ccpd3MXdk+8ar7qCkW2ef1SxK2/0MBy/u
         N4FXbv6fuL4N/V8La7QUjOoM300FUDWEpRGfxO4/eXjik1mnwTkOdgr2mpPx24+treRq
         PsU86/ibOkeYmQyJpMQDvcv/W4MMAL9IJZw3oQ2UuT8whhO4iFP/HbU5QYVO58UbCu1R
         PXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701368623; x=1701973423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dzWqt5ncHZST4wzgqFNCBg5DuH2RtK6Ow/4bVvt1ow=;
        b=jscq74cui8tNLCqMM/cITXAMTO7oH/FeJvweyn/HQCGVejEkWprbsoFLua9NnCgJNe
         OApB60UwQYo45PF0pyQXVUvAHwCIJqU8NmSHgAqapVNstAVdp1rqK2AY6cwUCOY3EmqQ
         PZxlc9mJkN3w8jz4uxOuqDefVHBqPr+F4VVVP653K3wFa1ieTPjU5ojO1xilnZFS4wME
         HBfDYHa1U/Aoq/sga8hQ+KpZ68F70xfRfKprVH8p2U1Lex6uptDA0K4uIJIcKkC2Eq5/
         0i2sgrgQyUPjw8WpjKu8QWxw+zjfFr14MGbPknkJ6ZRDyykpaQ7jfZ9LsAeZJfmUvVyV
         hF8w==
X-Gm-Message-State: AOJu0Ywd6v+rZjIjRqmt+Zdh4JT12WYksru+NnF93PmfNB0dLcq9+/Cy
        l/TZP3CDBvky7Qzx3ZhOyUlc6ksUQdoRqwXw+/XVhA==
X-Google-Smtp-Source: AGHT+IGJ/dqFXLX14CP4bI3K+z+4pw6j0MP3GokxnGr9wksHIOdLtsmRecnShIRMY+T2S0kzSDmGyAYqFHVJ5xZk4hU=
X-Received: by 2002:a05:600c:a686:b0:40b:4355:a04b with SMTP id
 ip6-20020a05600ca68600b0040b4355a04bmr213498wmb.6.1701368622681; Thu, 30 Nov
 2023 10:23:42 -0800 (PST)
MIME-Version: 1.0
References: <20231130135723.17562-1-chengen.du@canonical.com>
In-Reply-To: <20231130135723.17562-1-chengen.du@canonical.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 30 Nov 2023 10:23:31 -0800
Message-ID: <CAP-5=fWGfaTwhJRHWUZgRwb4Z16C=zdWWjb8eeQB6PReEtw9Sw@mail.gmail.com>
Subject: Re: [PATCH] perf symbols: Parse NOTE segments until the build id is found
To:     Chengen Du <chengen.du@canonical.com>
Cc:     namhyung@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Nov 30, 2023 at 5:57=E2=80=AFAM Chengen Du <chengen.du@canonical.co=
m> wrote:
>
> In the ELF file, multiple NOTE segments may exist.
> To locate the build id, the process shall persist
> in parsing NOTE segments until the build id is found.
>
> Signed-off-by: Chengen Du <chengen.du@canonical.com>

Acked-by: Ian Rogers <irogers@google.com>

For this code to be run then libelf needs to be disabled, I guess this
is why the problem has existed, out of curiosity why not use libelf?
If you look at tools/perf/Makefile.config, disabling libelf disables
libbpf, which means a whole heap of perf tool features are going to be
missing for you.

It may also be possible to add:
Fixes b691f64360ec ("perf symbols: Implement poor man's ELF parser")

Thanks,
Ian

> ---
>  tools/perf/util/symbol-minimal.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-mi=
nimal.c
> index a81a14769bd1..1da8b713509c 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c
> @@ -159,9 +159,10 @@ int filename__read_build_id(const char *filename, st=
ruct build_id *bid)
>                                 goto out_free;
>
>                         ret =3D read_build_id(buf, buf_size, bid, need_sw=
ap);
> -                       if (ret =3D=3D 0)
> +                       if (ret =3D=3D 0) {
>                                 ret =3D bid->size;
> -                       break;
> +                               break;
> +                       }
>                 }
>         } else {
>                 Elf64_Ehdr ehdr;
> @@ -210,9 +211,10 @@ int filename__read_build_id(const char *filename, st=
ruct build_id *bid)
>                                 goto out_free;
>
>                         ret =3D read_build_id(buf, buf_size, bid, need_sw=
ap);
> -                       if (ret =3D=3D 0)
> +                       if (ret =3D=3D 0) {
>                                 ret =3D bid->size;
> -                       break;
> +                               break;
> +                       }
>                 }
>         }
>  out_free:
> --
> 2.40.1
>
