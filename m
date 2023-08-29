Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B7F78C94A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbjH2QDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237417AbjH2QDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:03:43 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB6F1A6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:03:40 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a88c422e23so2679145b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693325019; x=1693929819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFxggldoPBim4o7gj2Za9WWmVK+cpYLI2YfSUTJ9s80=;
        b=PcJPiqX+gOAV1u0cwoYg4moxB3sUybd7aQt64Q4UkZoYZqN7Ld+Vs6HLG1dl76wpgf
         RM2F4TJXlBAzhgMW5LuxP1z13rbmyi/aoeQAR0V3cPk5Kah4MryYSSgUGzWcBlA95VVf
         tvw/UgnhanzOZGYG7NrVpOgfA50y3iwgQr1Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693325019; x=1693929819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFxggldoPBim4o7gj2Za9WWmVK+cpYLI2YfSUTJ9s80=;
        b=dHRFxqjvOXGCYT0Ym4osLmoaTktzyYQc8nET1Ck7TzGu8bTB4h/F74JAItNGeDhZSX
         G/wZ+1W+QtPkrOg7A0Q19bWNDB5Jo77nRp47CSTf/R63/IcHQWvCkIwMnvefyvX0VLRJ
         vRcPjzF+5GkB05het3C29Bx50Tvr41OsdmtqDrlTiy0tspNPoQ3Og1cqbjKt4FY5qVs6
         VIhoWpH+SzBpxFGhUWU+JfsbGhyYvc++zb3J+UCLUNoK4C4p8Tybw53qbsukGTLWUtsc
         vYHFjrrgzP7XfXG9jlHqCir38rYP8033MT2lpum80nc5MlKHIUZNK2UcfddYn+KOu1UX
         JmvQ==
X-Gm-Message-State: AOJu0YzdC2fQNeX57TKuKsrcNcxn9kI9mng+XrXmdT19NZyx5hWbvRwB
        sP3u5Ak1q2cJF94UfFq07ev3U8wns6wIggJCl1RGiwA9
X-Google-Smtp-Source: AGHT+IEpLT4kfB752Lc3GO1/WiUPYEmuR4QXto0WwS7rXSblLA4nZ88T30rxtu9wE/9eAvqsuUlzRg==
X-Received: by 2002:a05:6808:2183:b0:3a7:1bd8:4eb6 with SMTP id be3-20020a056808218300b003a71bd84eb6mr14132446oib.44.1693325019034;
        Tue, 29 Aug 2023 09:03:39 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id o5-20020a0cf4c5000000b0064f4749e1a9sm3477931qvm.92.2023.08.29.09.03.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 09:03:38 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-529fa243739so16491a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:03:38 -0700 (PDT)
X-Received: by 2002:a50:c2c9:0:b0:522:28a1:2095 with SMTP id
 u9-20020a50c2c9000000b0052228a12095mr174413edf.3.1693324996834; Tue, 29 Aug
 2023 09:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230824153233.1006420-1-dianders@chromium.org>
 <20230824083012.v11.4.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid> <TYCPR01MB11025E1AB8ED779D1D67F05CBE5E7A@TYCPR01MB11025.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB11025E1AB8ED779D1D67F05CBE5E7A@TYCPR01MB11025.jpnprd01.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 29 Aug 2023 09:03:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UZeHicVLn3GAxdFrtUbwHnb8GEvsfe9BM7cfBrTrK=Fg@mail.gmail.com>
Message-ID: <CAD=FV=UZeHicVLn3GAxdFrtUbwHnb8GEvsfe9BM7cfBrTrK=Fg@mail.gmail.com>
Subject: Re: [PATCH v11 4/6] arm64: smp: Add arch support for backtrace using pseudo-NMI
To:     "Tomohiro Misono (Fujitsu)" <misono.tomohiro@fujitsu.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Yuichi Ito (Fujitsu)" <ito-yuichi@fujitsu.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 28, 2023 at 10:23=E2=80=AFPM Tomohiro Misono (Fujitsu)
<misono.tomohiro@fujitsu.com> wrote:
>
> > -----Original Message-----
> > Subject: [PATCH v11 4/6] arm64: smp: Add arch support for backtrace usi=
ng
> > pseudo-NMI
> >
> > Enable arch_trigger_cpumask_backtrace() support on arm64. This enables
> > things much like they are enabled on arm32 (including some of the
> > funky logic around NR_IPI, nr_ipi, and MAX_IPI) but with the
> > difference that, unlike arm32, we'll try to enable the backtrace to
> > use pseudo-NMI.
> >
> > NOTE: this patch is a squash of the little bit of code adding the
> > ability to mark an IPI to try to use pseudo-NMI plus the little bit of
> > code to hook things up for kgdb. This approach was decided upon in the
> > discussion of v9 [1].
> >
> > This patch depends on commit 36759e343ff9 ("nmi_backtrace: allow
>
> Hi,
> Is this commit ID valid? I believe this commit is not included in the
> mainline yet. Other than this,
>  Reviewed-by: Misono Tomohiro <misono.tomohiro@fujitsu.com>

Ah, good call. I must have grabbed that git hash before the commit
moved from Andrew Morton's unstable branch to his stable branch. As
far as I can tell, it should be commit 8d539b84f1e3 ("nmi_backtrace:
allow excluding an arbitrary CPU"). ...at least that's what's in
linuxnext today. That also appears to match the commit hash in the
pull request that Andrew just sent to Linus [1].

I'll update the git hash and add your tag in v12, which I'm currently
aiming to send out tomorrow.

[1] https://lore.kernel.org/r/20230828225431.354d3d2d3b80ee5b88e65eb5@linux=
-foundation.org
