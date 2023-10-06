Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5666D7BB67B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjJFLeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjJFLeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:34:17 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945F283;
        Fri,  6 Oct 2023 04:34:16 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3af8b4a557dso1295382b6e.0;
        Fri, 06 Oct 2023 04:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696592056; x=1697196856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dJsxnKbNCk5+leHeFY97ByEqS+w0KsvjXISdSLAodbo=;
        b=OhAg2G9Kjkzn/G8ndHZMWchsbx9UHVwQAbNFCbdUNU6he9Y55E+f2Zk0r8yCeQPAGR
         OuWryjEIO3PUCKxnFbbNrqRh/zPvrVVLqERw01pO7C7lLfULPJh/dGM/pmDzLRV1VWw2
         GAjyvWs0XiJ4A5mkmt0Xi+z8qJc/jBwzVHQL/dIXT6bexKk+uZRTJLSJ8bdIh5uVxO9x
         LRtFyitVPSVMGbKp56pfuigJfLE4+EjQh4IyFi2SckYAM3ESVZEP9L0lGwJLCyjqDpwG
         zT3/mvu41+XMK2qaAIDlw4bAorsBDDl1SY0EnPLYyTGYLEbyMvyKOCF2YbDDEMmHhsSR
         kv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696592056; x=1697196856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJsxnKbNCk5+leHeFY97ByEqS+w0KsvjXISdSLAodbo=;
        b=Ym5m1XkXM+isBC2RTXl1A29CzYnmjdrlFRlggAtAvPOnFIKP/pq+uyF7gXAWusaQBa
         oEiDsuh8BWmSy2Gb5fTWiPfeFtpncgWcUt9BiJtm1h0HgxuMpBWocitC7YEmtR1RWV32
         GXqIhCHOqH1ZzjpB76wDFT6c2QtOVEYhSdGjY78wkMAUN2VGwYBtywADDCqyy26lcdrX
         xaj8IVF6+RQ06dku4O1g1dzQ+aNENjWUSbERageTISqlJ4RS4kVF0RIMMvlvcD+2Z+g2
         cT7ai/Ki3t+mAswzcacoG+IqRx4cVGN6tY3GuzNOjt6e/MhPxaBkHyqxglUhrfPu2T2+
         9z/g==
X-Gm-Message-State: AOJu0YxbVm0Bl2S7fN21BwGTa1LAOGQy/8caqF5ktwjx4kPUlUQCWZ8J
        ZIcV1Y23RL1kQMekNoH3LBI1xOhvHxMGkaCM7+I=
X-Google-Smtp-Source: AGHT+IGAJ3BibdIq1ke5w9ifC5KyliflY6aMcg/KldPfF0vwK+o2On/uXzQwQnujdp9hfWZnytiJ+ut6KHsEX9eTBsE=
X-Received: by 2002:a05:6358:618c:b0:145:6e16:fa86 with SMTP id
 w12-20020a056358618c00b001456e16fa86mr9433411rww.22.1696592055772; Fri, 06
 Oct 2023 04:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230910083418.8990-1-jonas.gorski@gmail.com> <ZQQ2Cv1uL/YVxNBb@gondor.apana.org.au>
In-Reply-To: <ZQQ2Cv1uL/YVxNBb@gondor.apana.org.au>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Fri, 6 Oct 2023 13:34:04 +0200
Message-ID: <CAOiHx=nCfU22yd9-KommKMEnKq+VpQROOfKwyb9kbRWzY3azhg@mail.gmail.com>
Subject: Re: [PATCH] hwrng: geode: fix accessing registers
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Andres Salomon <dilinger@queued.net>,
        Olivia Mackall <olivia@selenic.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        "Timur I . Davletshin" <timur.davletshin@gmail.com>,
        Jo-Philipp Wich <jo@mein.io>, linux-geode@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Fri, 15 Sept 2023 at 12:46, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Sun, Sep 10, 2023 at 10:34:17AM +0200, Jonas Gorski wrote:
> > When the membase and pci_dev pointer were moved to a new struct in priv,
> > the actual membase users were left untouched, and they started reading
> > out arbitrary memory behind the struct instead of registers. This
> > unfortunately turned the RNG into a constant number generator, depending
> > on the content of what was at that offset.
> >
> > To fix this, update geode_rng_data_{read,present}() to also get the
> > membase via amd_geode_priv, and properly read from the right addresses
> > again.
> >
> > Fixes: 9f6ec8dc574e ("hwrng: geode - Fix PCI device refcount leak")
> > Reported-by: Timur I. Davletshin <timur.davletshin@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217882
> > Tested-by: Timur I. Davletshin <timur.davletshin@gmail.com>
> > Suggested-by: Jo-Philipp Wich <jo@mein.io>
> > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> > ---
> >  drivers/char/hw_random/geode-rng.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
>
> Patch applied.  Thanks.

Where was it applied? I don't see it neither in linus' tree nor in
char-misc. Wondering if it got stuck somewhere.

Best Regards,
Jonas
