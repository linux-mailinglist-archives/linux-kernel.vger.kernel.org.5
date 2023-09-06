Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197B87943DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244228AbjIFTgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjIFTgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:36:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B5413E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 12:36:38 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a5be3166a2so11953066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 12:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694028996; x=1694633796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mtg/nQGifsLU9qENmxHQ00cXrbdcS8vGgWh6gQnrcGw=;
        b=T6ThRm66IWmdaFXMf60iEREX9Ykq0DkcVyyAIGuu32RbuubRDBWAaUBpmyA42in7iG
         BnSGXorXHnPGBXV9zRy2nTOcZUzKP9fZD9DB3QARcdnjIrlihkmTH/tVfkUo9t4NWjSm
         u0cU13paXB2tDxyuI1jSQ4TFoX94Re93q22tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694028996; x=1694633796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtg/nQGifsLU9qENmxHQ00cXrbdcS8vGgWh6gQnrcGw=;
        b=GQW8wIC79n9JaNk+rgXZJ2+CUOZW3oAQszudWUjAWX3bXll1FtA3llA2nH7/Z95YJZ
         uxrsi2t5LHNdf/+Hui6WbLvtyQhzNN1bmDNsnING79eMxnTj6/kyvZqzo+QZJSq0U6pq
         yDmcs49ao4W9PUOj5x0TB7shqZ/ToTVUuq1flfpPnGM2oDl+Eo3ZFNHfssx60mQdWA4o
         8eR9LBXBTR+kmHWMc6mw/0E1Go41a3ZeZ2fQssUAbPVLVEgMDENlAadKo0IjpvI3SFPF
         KXMRXUli8dr8R/jAsFKoOFFFO7WgptvndPbYesAZCZ+4D1ehWWi7c72CJB0iAy18xWP/
         IJNA==
X-Gm-Message-State: AOJu0Yz5jR86DdlkXUt2s0woT6HNX19Z3iDWgAobGyb+D7bHWopdCimT
        LqpJXZwG8AgYOVxTGeji73qmoImx8pwo98HZx+MYMw==
X-Google-Smtp-Source: AGHT+IHljzLwnQnB6l6tPinT3FqD3V+4DGl4wDj0z9foh8J7HOmvpyh0hANUXoDI7hY/slDk5S/SGA==
X-Received: by 2002:a17:906:2101:b0:99d:6ca6:7a8c with SMTP id 1-20020a170906210100b0099d6ca67a8cmr2775431ejt.63.1694028996488;
        Wed, 06 Sep 2023 12:36:36 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id g4-20020a170906594400b0099b76c3041csm9400770ejr.7.2023.09.06.12.36.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 12:36:36 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-52a1ce52ef4so143827a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 12:36:35 -0700 (PDT)
X-Received: by 2002:a05:6402:334:b0:525:6d6e:ed4a with SMTP id
 q20-20020a056402033400b005256d6eed4amr3250657edw.23.1694028995634; Wed, 06
 Sep 2023 12:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
In-Reply-To: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Sep 2023 12:36:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com>
Message-ID: <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
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

So I'm starting to look at this because I have most other pull
requests done, and while I realize there's no universal support for it
I suspect any further changes are better done in-tree. The out-of-tree
thing has been done.

However, while I'll continue to look at it in this form, I just
realized that it's completely unacceptable for one very obvious
reason:

On Sat, 2 Sept 2023 at 20:26, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
>   https://evilpiepirate.org/git/bcachefs.git bcachefs-for-upstream

No way am I pulling that without a signed tag and a pgp key with a
chain of trust. You've been around for long enough that having such a
key shouldn't be a problem for you, so make it happen.

There are a few other issues that I have with this, and Christoph did
mention a big one: it's not been in linux-next. I don't know why I
thought it had been, it's just such an obvious thing for any new "I
want this merged upstream" tree.

So these kinds of "I'll just ignore _all_ basic rules" kinds of issues
do annoy me.

I need to know that you understand that if you actually want this
upstream, you need to work with upstream.

That very much means *NOT* continuing this "I'll just do it my way".
You need to show that you can work with others, that you can work
within the framework of upstream, and that not every single thread you
get into becomes an argument.

This, btw, is not negotiable.  If you feel uncomfortable with that
basic notion, you had better just continue doing development outside
the main kernel tree for another decade.

The fact that I only now notice that you never submitted this to
linux-next is obviously on me. My bad.

But at the same time it worries me that it might be a sign of you just
thinking that your way is special.

                Linus
