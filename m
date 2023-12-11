Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A0180DE24
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345227AbjLKVZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjLKVZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:25:28 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2906E4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:25:34 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50d11bd3144so924e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702329933; x=1702934733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5yenaQ1ff/Vs/GAtNYvSgpQQRs4dIvKBnG50jts6ek=;
        b=aMM3CcstV6MBlzz95Zqj1o6hp6gmqDYLzm1accsfakElEdJxAhc88A9laPwbYgD/Jo
         R/AtK5pU20csmPjvUwtvvGeXpesTlyra21xDuH1AiGKe88QOlb9AdhiCMHtkMggMZh//
         sivJvhDaqwppZvGc7BtNxX43hn7LnGegng23NR4ntQOQa9ICObwIJhmBrXw1/6+5fvuM
         icFiMEGIkzkb1ogylepaIxtgWwCXGq1tJebzsjYxcnIlq6mGoAoPKAgy057c4Dux5K2i
         LBTJ7ZqrxhRGKWl6MQL+N209+745hacrQ5Tka1GKmJU+Rjwiq/Pfm3eZJqspUIfQSh87
         n85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702329933; x=1702934733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5yenaQ1ff/Vs/GAtNYvSgpQQRs4dIvKBnG50jts6ek=;
        b=WUsXF5EIphUbZgh85xV/60OFsMttPDzkhMnUb5UPDDKvHcxUXoTL2s4R8TXIsn9baU
         JlLE3KtacFXdM4aEXEtFVRHWuKyu0nvEKkfezLYkvK6W49Qr72cThlG+JgctWWHBGTCm
         t9sUMsBbR3ESTMgeiW/GnsEsvu2hUEC/0bdbsPyyfIWuxeo5cxOg8s1a4Gdt0Pfk+i7k
         9Jut+MiNzHnYMuwI/n5wn6qdGrrvs/G1NujoJdITy1c30YGo512pagS7O3SCE5A2eUf9
         ik2tde9BpwhVGvzhhRTKWxp6+Lh9TQTn10f0SE0YnIY3TxqKPvr65zQ03RyFEjnvOxyT
         UJEA==
X-Gm-Message-State: AOJu0YzBeNgdmVgxR95tVkypvqiMRxlTH6HBggJZInOJJ8PEgEnZ1eGC
        ehulb7cq5CY+BJbjGM3PhvMC/MW0wDs0t1iZJL8rjw==
X-Google-Smtp-Source: AGHT+IFYrVG60A2sb1bXVaM+XTQlBKO8d1MrNroldDRxY4aQAZsWQRnta7tn8E25Qimvi8SEbwvzVApnV5UhwsUPDUo=
X-Received: by 2002:a05:6512:292:b0:50b:fe63:f06 with SMTP id
 j18-20020a056512029200b0050bfe630f06mr179410lfp.4.1702329932664; Mon, 11 Dec
 2023 13:25:32 -0800 (PST)
MIME-Version: 1.0
References: <ZXNnDrGKXbEELMXV@kernel.org> <3a8c66ec-537d-4e29-bf08-226dd41b08aa@linux.intel.com>
 <ZXd64qLLDTEJjSmb@kernel.org>
In-Reply-To: <ZXd64qLLDTEJjSmb@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 11 Dec 2023 13:25:21 -0800
Message-ID: <CAP-5=fUTbDKKkWW8P59B7fSorkWMhw5d0FayXYS2LzqDhmSqrw@mail.gmail.com>
Subject: Re: 'perf top' broken on intel hybrid systems
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 1:11=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Dec 08, 2023 at 02:39:37PM -0500, Liang, Kan escreveu:
> > On 2023-12-08 1:57 p.m., Arnaldo Carvalho de Melo wrote:
> > >     So I finally got a recent Intel hybrid system:
> > > root@fedora:~# grep -m1 "model name" /proc/cpuinfo
> > > model name  : Intel(R) Core(TM) i7-14700K
> > > root@fedora:~#
> > >     Most things work, but:
>
> > > root@fedora:~# perf top
>
> > > Error:
> > > The cycles:P event is not supported.
> > > root@fedora:~#
> > >
> > > root@fedora:~# perf top -e cycles:p
> > > Error:
> > > The cycles:p event is not supported.
> > > root@fedora:~# perf top -e cycles:pp
> > > Error:
> > > The cycles:pp event is not supported.
> > > ^[[Aroot@fedora:~# perf top -e cycles:ppp
> > > Error:
> > > The cycles:ppp event is not supported.
> > > root@fedora:~#
> > > root@fedora:~# perf top -e cycles
> > > Error:
> > > The cycles event is not supported.
> > > root@fedora:~#
>
> > The error is because the perf top always tries to open an event on the
> > user_requested_cpus, which are all CPUs by default.
>
> But what is wrong with that for the default event, CPU cycles?
>
> It should work for all CPUs, its the most basic event, right?
>
> We should have a rough idea where CPU (no matter which CPUs) cycles are
> being used.

Generally we wouldn't want to aggregate cycles events on two differing
PMUs as the CPUs for them likely behave quite differently. Most of the
cycle event opening is now done by parsing "cycles:P" which will give
two evsels, one for each core PMU. You're right that the correct PMU
can be determined for the legacy events without an extended type if
the CPU isn't the -1 any CPU value. We'd need special parsing to make
this work in the context of perf top, which doesn't seem desirable. I
think we should support wild card PMUs and fix the CPU maps like we do
in perf stat and perf record.

Thanks,
Ian
