Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820F3793A05
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbjIFKhe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Sep 2023 06:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjIFKhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:37:32 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43CDCF2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 03:37:28 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-78caeb69125so1453979241.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 03:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693996648; x=1694601448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2L0tLiH3k96+x6hynIK9EC6cn8v2zeufIiRWPjfBx2Q=;
        b=LY3QsNO4KqI9fCrdF1oVqrt6PhNlmo3DFW1r3qt2NSUTa7gNthHNqvObGXK0mBlw6N
         iqdazOyxlZatMbInA/N5kBNH4Xn8o5VMH2rjFQ/o2g4y7QGryhWmfCZ5FEdgt2UP2WoX
         rqAXHubVlDcvx3LbW0je3pz+w1Hnui2rKvv6GPRg8OzvbNwQFzNEAmXHvYf/OIuRlenS
         v52I/g14EzjoMB1uvqsERTW80yqgta608a2tY0R8IXBmYiOyFgfCrSoJrSNtOLJJyC1c
         BHY9vKzFJPBxIMWMZ+MAnoCYY20Vath33lwQA/I+y9dVlRUeQDItopRFmmeITfbfX9tD
         4Rzg==
X-Gm-Message-State: AOJu0Yxvx+b6X8j+zK0U74/uk640TfHQzKxM3D3YFiuBH5+urN9S6CG7
        gSM9EyeGNG2raOYue6w4D1uBqv1ovIM9tA==
X-Google-Smtp-Source: AGHT+IF13w+VHrnnvSxxc/aj1LwmeHLoIQnyFmKRdnLpzgs3S1mjLhMFbEcsZUxjzEF+GLUQSsZSYQ==
X-Received: by 2002:a67:f482:0:b0:44e:83fc:9df2 with SMTP id o2-20020a67f482000000b0044e83fc9df2mr2561007vsn.5.1693996647817;
        Wed, 06 Sep 2023 03:37:27 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id q1-20020a67b041000000b0044e9e4a6e9esm2496010vsh.6.2023.09.06.03.37.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 03:37:27 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-44d4c3fa5beso1542708137.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 03:37:27 -0700 (PDT)
X-Received: by 2002:a67:e913:0:b0:44e:b457:75e5 with SMTP id
 c19-20020a67e913000000b0044eb45775e5mr2689444vso.19.1693996646970; Wed, 06
 Sep 2023 03:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230822114914.340359-1-ckeepax@opensource.cirrus.com>
 <20230904144008.GG13143@google.com> <87zg20cfkm.fsf@mail.lhotse>
In-Reply-To: <87zg20cfkm.fsf@mail.lhotse>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Sep 2023 12:37:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUzYgB2hxBfYAD5+syWq9JSRxFKsGOA4PJHh2Ld8GrwKg@mail.gmail.com>
Message-ID: <CAMuHMdUzYgB2hxBfYAD5+syWq9JSRxFKsGOA4PJHh2Ld8GrwKg@mail.gmail.com>
Subject: Re: [PATCH] mfd: cs42l43: Use correct macro for new-style PM runtime ops
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Lee Jones <lee@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 6, 2023 at 2:26 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Lee Jones <lee@kernel.org> writes:
> > On Tue, 22 Aug 2023, Charles Keepax wrote:
> >> The code was accidentally mixing new and old style macros, update the
> >> macros used to remove an unused function warning whilst building with
> >> no PM enabled in the config.
> >>
> >> Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
> >> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> >> ---
> >>  drivers/mfd/cs42l43.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
> >> index 37b23e9bae823..7b6d07cbe6fc6 100644
> >> --- a/drivers/mfd/cs42l43.c
> >> +++ b/drivers/mfd/cs42l43.c
> >> @@ -1178,8 +1178,8 @@ static int cs42l43_runtime_resume(struct device *dev)
> >>  }
> >>
> >>  EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) = {
> >> -    SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
> >> -    SET_RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
> >> +    SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
> >> +    RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
> >>  };
> >>
> >>  MODULE_DESCRIPTION("CS42L43 Core Driver");
> >
> > Acked-by: Lee Jones <lee@kernel.org>
> >
> > If anyone wants to submit this directly to Linus before -rc1, please, be
> > my guest.
>
> But you're the MFD maintainer, aren't you? So I think everyone is
> expecting you to send it to Linus.

+1 ;-)

And:

    commit ace6d14481386ec6c1b63cc2b24c71433a583dc2
    Author:     Charles Keepax <ckeepax@opensource.cirrus.com>
    AuthorDate: Fri Aug 4 11:45:59 2023 +0100
    Commit:     Lee Jones <lee@kernel.org>
                ^^^^^^^^^^^^^^^^^^^^^^^^^^
    CommitDate: Thu Aug 17 12:06:11 2023 +0100

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
