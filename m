Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED1378DD7B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244357AbjH3Suw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245307AbjH3PH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:07:57 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C74C2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:07:51 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bcfdadd149so70528291fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693408069; x=1694012869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gsv2vy0NbRUitL+DqdxFoOF89HcPlyA0hr/AZRAjcvs=;
        b=Beflx1uLMM8QWOA/AXulwxMsQBLj2h9RxVihZxZ3QTjSCmhtOscjQD4+pPafLuS46I
         Ll/ApEsVa39WaHdJlbrTu0Db03gmi5Zs2+INKQcGR6y8PVUrGS4LaFXUyeSGEMiPXq+c
         0Ml6DCCO9LWtS26HCsjRQM4vvqtEaylnXxfBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693408069; x=1694012869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsv2vy0NbRUitL+DqdxFoOF89HcPlyA0hr/AZRAjcvs=;
        b=OcQHQO3cuxbyk+fcnhfLxccWbrU+UuQoN18ACRpEB5PTjpAjTpeLj+j9oOiHm677YO
         rehFO1dzgfFSWNqUKTNaHvCtk8yCYxLRD81PQKzJHtb3f/xV7HAe5bK/1g26mVXo70Qx
         +Sdr/YAGeo5B/OmweLUvV6NakU10Kql62OAIyp0/uCBupDwizq3MH4990forsn0ITWLr
         G1YTlJCem5myrOAmzQR2xxzIGTndbV/8mrw4SDjkWpjH9iNh8J+dFtjYrR3BbuXH7QCG
         y4ppaRxwcCNFksAVto6u0IcqXR8L7ygridK0oJdzCAG389oZ6YoG9N/z1Fxx+M4Hfcfg
         /O/w==
X-Gm-Message-State: AOJu0Yz2kM3/7UigIeFKfcMPmaOdFYwSblsW+jL/JaiO444LlRh4igZ5
        uW0UfQG54KJ+VkLEpk9yGMweBwbJiLsIgOpGnVZzD0EC
X-Google-Smtp-Source: AGHT+IFNcWc4Gtn/SEotDtEpJ3pjGfdGAnfbxpwjZ5ELhczp4JYFFNUWPFiV7MerAaIdt18LI9SJ1Q==
X-Received: by 2002:a2e:721a:0:b0:2bc:d507:af with SMTP id n26-20020a2e721a000000b002bcd50700afmr1759611ljc.28.1693408069310;
        Wed, 30 Aug 2023 08:07:49 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906361600b0099cadcf13cesm7285924ejb.66.2023.08.30.08.07.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 08:07:48 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-99c0cb7285fso740249666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:07:48 -0700 (PDT)
X-Received: by 2002:a17:906:cb:b0:9a2:1ec1:625d with SMTP id
 11-20020a17090600cb00b009a21ec1625dmr2019888eji.64.1693408068433; Wed, 30 Aug
 2023 08:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230829213441.310655-1-ulf.hansson@linaro.org>
 <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
 <CAHk-=wjLO=Jsdk2prq0piznMMCk+V0_fRaFRHEPuaALpF8J=hw@mail.gmail.com>
 <96bb0de0-06d9-46f8-b02f-dc924afff13c@app.fastmail.com> <CAHk-=wi5Lh-NG_rvcx3Zyqd2Uhj76G4V73tWCFULhVzOU6e1xg@mail.gmail.com>
 <CAPDyKFrJH-1uaPCwnWZDPi4MRtOm=N2CHSRyvjXRDbQ1y-oOrw@mail.gmail.com>
In-Reply-To: <CAPDyKFrJH-1uaPCwnWZDPi4MRtOm=N2CHSRyvjXRDbQ1y-oOrw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Aug 2023 08:07:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1j0HuNWKLEzi74zEr2rGnMLEFZjLvV=rzdqzQPqOzdQ@mail.gmail.com>
Message-ID: <CAHk-=wj1j0HuNWKLEzi74zEr2rGnMLEFZjLvV=rzdqzQPqOzdQ@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC/genpd driver updates for v6.6
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023 at 01:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> *) The new subsystem is solely intended for the generic PM domain
> providers. Other PM domains providers, like the ACPI PM domains for
> example (drivers/acpi/*), don't really belong here, at least in my
> opinion. So, maybe "domain" isn't specific enough? Although, if not
> using "genpd", I have no better suggestion.

I'm perfectly fine spelling out longer names. "drivers/power/generic"
would be fine to me too, for example.

We can even use names that are longer than 8.3 or - this is heretical
- the 14 characters of the original Unix filesystem. So it could be
something even more descriptive.

I personally always use tab-completion when doing filenames, so at
least to me, longer descriptive names that don't all start with the
same thing are perfectly fine. Others may have more of a typing issue,
so maybe 'generic' is better than 'generic-power-domain'.

(On that note, exactly *because* I use tab-completion, I hate things like this:

   drivers/scsi/scsi_{common,debug,error,ioctl,...}.c

which is entirely redundant in how it just repeats the "scsi" part
pointlessly, causes more typing, _and_ then also causes tab-completion
to not work well. But that's a separate issue).

> I get your point. I was indeed trying to obey the current naming
> strategy, but I think it's not entirely easy to understand what is
> prefered.

It's not like we have any hard rules. Most of our naming ends up being
pretty random, and everybody thinks that *their* TLA is so obvious,
because they've been using it for ages.

But the "please use common and industry-wide TLA's, write things out
otherwise" is a good rule both when it comes to docs and to filenames.

And that "industry-wide" is pretty important. Not some kind of "local
jargon TLA".

We as kernel people hopefully all know what "TLB" or "VM" means, but
every time somebody sends me something like "x86 SEV" patches, I have
to remind myself, and that's despite me being fairly intimate with
x86.

> Please advise me on how to move forward.

Just to not cause pain during the merge window, I think I'll take the
current trees (eventually - I still have other things pending first),
but I would like

 (a) a new pull request message that actually spells things out and
does *not* use 'genpd' as if it was meaningful so that I can at least
have documentation in the merge window

 (b) a plan to rename that directory to something saner and more descriptive

I don't care deeply about what the exact name in (b) is, but it should
be real words that make sense in context. Or a very standard
abbreviations (ie I consider "misc" to be a word, not an abbreviation,
because I'd rather not see everybody butcher the spelling of it).

                   Linus
