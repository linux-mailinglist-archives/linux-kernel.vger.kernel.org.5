Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727C17BE4C4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376659AbjJIPbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376424AbjJIPbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:31:49 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD42AF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:31:47 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5068b69f4aeso7526e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 08:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696865505; x=1697470305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9lR87UXDmLmGW5fgYOoK9D3OVG+W1Apjk0vJRi7zLM=;
        b=1tWV7OGcc9ERBFbl2dNcxy8q1A0XpAwBL0l/MU9Blu9Vm6az6ft1qpkdtJAiwe4qYK
         YUZYHGV9S2coLdV5tIbCkPvg5ewylf7VYmM8GgU/4bcMJMbcUu8zT15akCx1XFZI/NT2
         ssWU40vzAGlif9Q+Eoq5iA581psoE/EzP7NFixsuZzNm1hfYzolD390CvsraTxxA7uyo
         h21YpmJUBie4B7uSJ0TIQjoDU3rf4RuzM7xodYvnrJlMUtesDgyPnbWLFMjgUWq7Sgzh
         gz9eINt4BOHJr3hS0bTDOGtDslDgV6GXsCeIXAegQQdHxRS/E/g6NE9tay8z7Qg5vw+5
         DZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865505; x=1697470305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9lR87UXDmLmGW5fgYOoK9D3OVG+W1Apjk0vJRi7zLM=;
        b=ScnL5KvivSpPYoMiN7os4pO3V0FbWCLRateqcea7cmqiIhRC92dLuJHs6olFcOt/n4
         M5QUw8do+Yg7VkcFEZcuvQ0NMRcBlBV2HeFYHtyjzpC082Q27/Yy9tk9J1GZdxeyHpTd
         P5/tV1AGTEhmjLSunCU5lmGsKTrpVZ3XDxEBWH3QQ3yYX9rTiwdIkPKkkv1nQMraj0IR
         qPwSQ7fP6MO7SYD1hlPNiQv9FyMQuUfHRZ/5pX5sRSotoOxCSZD+pRo9NILSeZtvIa1f
         im69glA3fOXsUbZ6lpzbeqeEPJ4C8UOsM04MQw2DPBGL4dN12D48LSNt1Y1jC3/NaNCK
         OIMg==
X-Gm-Message-State: AOJu0YxuApgEC+/czxnLfEnfIK64lRBjkanefOvFeY/Iwq3OgwjoFyMd
        XxqpigZTjoOpGBXVMLYsTxNhDPcXmK1UXXxb5T+iDg==
X-Google-Smtp-Source: AGHT+IFej5jFA1THvSV2aeZXzaiKcyhdWw6v1JEH9n5f40OTL3FiZOid29zfdAkp5ezAFfSgfuUUxlraEg0PWsjYwkg=
X-Received: by 2002:a05:6512:4801:b0:502:a55e:fec0 with SMTP id
 eo1-20020a056512480100b00502a55efec0mr231745lfb.6.1696865505263; Mon, 09 Oct
 2023 08:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231002221909.2958708-1-irogers@google.com> <CAP-5=fX-VOeCkOJY5xeW67x0+A0tGAHM4VYBBz46L-g2eRCR+w@mail.gmail.com>
 <93afcf44-5f8b-49c1-abc5-5304cba5f991@intel.com> <CAP-5=fXzcR6QKKhFG5PS1pFYi5JsO4AOUoH_-Bv0O+11YzEkkw@mail.gmail.com>
 <CAM9d7cjQZvZm+Vyrx9PTUYMFN5RjE+i-Kq1kbffyVp2hGKF6sg@mail.gmail.com>
In-Reply-To: <CAM9d7cjQZvZm+Vyrx9PTUYMFN5RjE+i-Kq1kbffyVp2hGKF6sg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 9 Oct 2023 08:31:33 -0700
Message-ID: <CAP-5=fUo-vuLofC4jgHC9z=BTe80OEiY_PoQWqQtyVdvHcf+KQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf intel-pt: pkt-decoder: Fix alignment issues
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 8, 2023 at 10:29=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 5, 2023 at 2:24=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On Thu, Oct 5, 2023 at 12:06=E2=80=AFPM Adrian Hunter <adrian.hunter@in=
tel.com> wrote:
> > >
> > > On 5/10/23 18:48, Ian Rogers wrote:
> > > > On Mon, Oct 2, 2023 at 3:19=E2=80=AFPM Ian Rogers <irogers@google.c=
om> wrote:
> > > >>
> > > >> The byte aligned buffer is cast to large types and dereferenced
> > > >> causing misaligned pointer warnings from undefined behavior saniti=
zer.
> > > >> Fix the alignment issues with memcpy which may require the
> > > >> introduction of temporaries.
> > > >>
> > > >> Signed-off-by: Ian Rogers <irogers@google.com>
> > > >> ---
> > > >
> > > > This is a relatively small change that fixes building with
> > > > -fsanitize=3Dalignment -fsanitize-undefined-trap-on-error. Adrian, =
as
> > > > this is Intel-PT could you take a look?
> > >
> > > Thanks! This has been down my list of things to do for ages,
> > > but using get_unaligned_le16() etc seems nicer.  I sent a patch
> > > set for that.
> >
> > Thanks Adrian! Your patch set looks good and I think after Arnaldo's
> > comment is addressed we should go with it.
>
> I think it can be done as a later step as long as the interface is the
> same.  Can I add your Ack's to the Adrian's patchset?

I think addressing Arnaldo's comment:
https://lore.kernel.org/lkml/ZR8QnasisGEsaaDR@kernel.org/
will need some changes to the patch series, and so I was waiting to
see the outcome of that.

Thanks,
Ian

> Thanks,
> Namhyung
