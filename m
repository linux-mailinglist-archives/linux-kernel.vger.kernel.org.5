Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEB978D102
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 02:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241343AbjH3ATw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 20:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbjH3ATW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 20:19:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C03CC2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:19:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a2185bd83cso657950766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693354757; x=1693959557; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0TRiwO9brInVsWGB1zNLCt57WQP0un85fvRaKypoTus=;
        b=ZbRf6oaIpWGTm+D8VcVtcgk5wKagLirZpn1iRjikynrr3EcJAmCxSR/dnEFDpvMM/V
         FkvXzekJKC2GV84pgXFr4KZ4Gk+jtHMoqZcP6/kNlJHsy8gBLkrQ2ENZCkFS/Zc8pDpo
         kDD3NNZ504LipgaT6uZjQq9PZz50cprEPkXyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693354757; x=1693959557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0TRiwO9brInVsWGB1zNLCt57WQP0un85fvRaKypoTus=;
        b=aockZVd6pO0mPUmMdGOI9F2zuK2uRpRT3TSxFfyUficCMIszgtR4b0xEtnpbBRr0Ln
         uy0slYqRAYdPufYoYrpwrsAXWsckSH750W0NsqvHKKYmX/D2NG18Vi1Jt+QMV0XqrBt9
         +EAG5HrgpNokzQJ300RBynyMGwr6P1nqWLyslhheON2Mu9Ex1DHia5dgX7ZrSsU0v9Zt
         0gxcJ1w9p1f+2EPozgVyJBChUm+r/FnAf0GF2oVeMFjY1vPQjisGypiovsnijMOWcySI
         d+UUZYsmV7lOfVt1xK9RhQhuqdpeCaxlHiJ7/fgxvDjKmGjb1UFdcf69XPTBokguA8IU
         /ejQ==
X-Gm-Message-State: AOJu0YwgtsP1ajl65nocOcMbIjIbD2lWCd17Ts1olY9t7HuUjoiyLPbn
        0wD++88XexRRdHqPu+9Dd7rnCn4pjraNE+Gri966/qdA
X-Google-Smtp-Source: AGHT+IECfVvXgKWMsUSyoFZv0kQS0ThxiGkOj/YSSSKLWXpuP4nrGH8LRABzMexeWijEGOKKuAbBEA==
X-Received: by 2002:a17:907:b12:b0:9a1:d29c:6a9d with SMTP id h18-20020a1709070b1200b009a1d29c6a9dmr299441ejl.46.1693354757432;
        Tue, 29 Aug 2023 17:19:17 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id y16-20020a1709064b1000b009929ab17be0sm6487838eju.162.2023.08.29.17.19.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 17:19:16 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so657354166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:19:16 -0700 (PDT)
X-Received: by 2002:a17:906:251:b0:994:4095:3abf with SMTP id
 17-20020a170906025100b0099440953abfmr439145ejl.14.1693354756312; Tue, 29 Aug
 2023 17:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230829213441.310655-1-ulf.hansson@linaro.org>
In-Reply-To: <20230829213441.310655-1-ulf.hansson@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Aug 2023 17:18:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
Message-ID: <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC/genpd driver updates for v6.6
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 14:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Here's a pull-request that introduces the genpd provider subsystem.

I was starting to pull this, and then tried to figure out what the
heck "genpd" is.

Absolutely nothing in the pull request explains what it might be.

Even after actually pulling it, I couldn't really find anything useful.

The closest seems to be the MAINTAINERS file entry that says "GENERIC
PM DOMAIN PROVIDERS", which doesn't actually clarify anything.

Ok, so we have a Kconfig option for PM_GENERIC_DOMAINS, so I looked at
that. It has no help-text, as it is entirely an internal generated
one.

End result: I decided that without any kind of explanation at all,
"genpd" is a completely useless name, and that I don't want to
randomly add a new directory with zero explanation for what the heck
it is.

So I ended up unpulling it, because if I had to google what it is, I
wasn't going to pull it.

Can we please agree that

 (a) five random letters in a row does not documentation make

 (b) if we have a new subsystem, it should damn well have some
explanation for it

And even if you send me a new pull request with an actual explanation
for the term, do we really have to use such a horribly nasty name?

This is not some kind of industry standard shorthand.

Yes, google does find the term "genpd" having been used for a few
years in Linux SoC-land, but are we really so short on diskspace that
we can't use more descriptive names?

Now I look at this disaster area with no documentation, and realize
that it ends up also being part of Arnd's series of SoC pulls.

What a horrible thing this is. Please don't use random letter
combinations that have absolutely no meaning to anybody else, and that
aren't even explained.

               Linus
