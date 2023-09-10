Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E278A799F63
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 21:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjIJTFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 15:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIJTFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 15:05:15 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4E913E
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 12:05:07 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bd6611873aso59125941fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 12:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694372705; x=1694977505; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oqvxcwzpC3/aD7COrxRo/r5ZoCc7FtwXVuKZgiIZ2z8=;
        b=Mm7IMVWXgA67RNaYEq98jXkH566ybs/TTGCY1aOCunwPGZw3aNYc9/4D2ol0AVIreC
         +XxA7Ud7LWf1aohzmfYfnCO9IWwvPc03CFxu2RyArGNMqVllcFlNe9uIeiKwajIDn5tV
         dyis64XrIvZjb6xhQiS367dqoNEey5thUBLrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694372705; x=1694977505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqvxcwzpC3/aD7COrxRo/r5ZoCc7FtwXVuKZgiIZ2z8=;
        b=OdBFaII0q0d7Z2ud7X2GC4T7lq65gjaIIS7Ta666iZWgVkce9tnO8pEIet+4UVqYzc
         4OZcWrpONOZMRZLmfbJsN88OpsAvCqJ5YsQkYVzeKQll+JrxCHVozeR/A83kfeSFs+U7
         KVc0ugpbcAVPEbHprM61oPjc+vC6/DikMAy0IvZwRBod3inRXwgX+5zaikxbDdNWmDeX
         gmBBLDs69E+ASQztSAX3gwFuvVb2/14PKC2EDbbnDtgW8NNBRl7wJN0ckx96tiHx22Uf
         Cud+M7+jgvxkmQiKdBVkuJ5zNsdCgABKK1pqXHgK6vEK50sQat9GXVhei5usLQTzrXxR
         xwew==
X-Gm-Message-State: AOJu0Ywg16ZJDkwzpoVksbTiZiQ2Fz487TA6ohwQWHgMOAxwTi6An/Xb
        6Th9kst3gHqxYgyScBCMPvR6ouR/BdSB7ixtiVEda7GA
X-Google-Smtp-Source: AGHT+IHGPvMGr29lJhYN2cacnx1izOYslLTLCpWNNRI4nHlAygbXb5sPQTh/wDE0UQD4KXEzOrHCVQ==
X-Received: by 2002:a2e:80c6:0:b0:2ba:8127:a2c3 with SMTP id r6-20020a2e80c6000000b002ba8127a2c3mr6419049ljg.34.1694372704988;
        Sun, 10 Sep 2023 12:05:04 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id z20-20020a170906241400b009829d2e892csm4190111eja.15.2023.09.10.12.05.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 12:05:04 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-52c4d3ff424so4902402a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 12:05:04 -0700 (PDT)
X-Received: by 2002:a17:906:3098:b0:9a1:d077:b74f with SMTP id
 24-20020a170906309800b009a1d077b74fmr6557487ejv.49.1694372703888; Sun, 10 Sep
 2023 12:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tz=gx2_zrQ2XD8JNwW1dg6b+Byr5FgYAAq+2f29rydcgg@mail.gmail.com>
In-Reply-To: <CAPM=9tz=gx2_zrQ2XD8JNwW1dg6b+Byr5FgYAAq+2f29rydcgg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Sep 2023 12:04:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7zcmwWwYO=vEVJrTn7fuhpFNmv-6k-MptFYYqFofp4w@mail.gmail.com>
Message-ID: <CAHk-=wg7zcmwWwYO=vEVJrTn7fuhpFNmv-6k-MptFYYqFofp4w@mail.gmail.com>
Subject: Re: [git pull] drm CI integration
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, 30 Aug 2023 at 18:00, Dave Airlie <airlied@gmail.com> wrote:
>
> This is a PR to add drm-ci support files to the upstream tree.

So I finally had no other pull requests pending, and spent some time
looking at this, and I see nothing offensive.

I did wonder how this then expands to having more than one subsystem
using this (and mixing them possibly on the same CI system), but
that's more about my ignorance about how the gitlab CI works than
anything else, so that's certainly not a real concern.

The other side of that "I do wonder" coin is for when others want to
use the same tests but using some other CI infrastructure, whether
it's some AWS or google cloud thing, or github or whatever.

Anyway, considering that both of my idle curiosity reactions were
about "if this is successful", I think me having those questions only
means that I should pull this, rather than questioning the pull
itself.

If it works out so well that others want to actually do this and
integrate our other selftests in similar manners, I think that would
be lovely.

And if - as you say - this is a failure and the whole thing gets
deleted a year from now as "this didn't go anywhere", it doesn't look
like it should cause a ton of problems either.

Anyway, it's in my tree now, let's see where it goes.

                   Linus
