Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314BF772B6E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjHGQru convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Aug 2023 12:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjHGQrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:47:49 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA751721;
        Mon,  7 Aug 2023 09:47:48 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-56d0deeca09so732070eaf.0;
        Mon, 07 Aug 2023 09:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426867; x=1692031667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoAePLIfboXCizIZO3iLMpP4Wv3M5byMYzrnW11izx0=;
        b=jABXFhv8mwZ5J2YgbwNAyg470B1dEuDse5Dim1KNj2Bgz2J7EuzrUNCvnVcFBi4+Zz
         gu8wZidLqbVziB6wzXYZTZ1N73o1TUCYcJsVqY12NJ/ql3Gvf9rGK907iI+c+scXfdrD
         hT2a4xHx12c755v5RUyfoJERqrU7rthxnRw9alsBiZeAu1VCyziHLjZClXO0xG2NxjfA
         X7TsboDw7K4quWHubb0ulJ136T6oyH9bZAmK8AEHNfzTvdZpeaYDiGppeVEpqVmemd9I
         aO5EuqR17JyZR1BWMb130P76DOHRPAlwAHF+WZWpqvWb1glIepssHETaGAheC+T5r7Km
         CY7Q==
X-Gm-Message-State: ABy/qLYo375bQ3jskscD+yVKYms8S7+Xd7KldFLDW+P2iYGIU3uyCdBD
        3ujP3fl8cVmROvbw9VqAC2ZbZtvYMMoDJOZaDuA=
X-Google-Smtp-Source: APBJJlHeESdiwSjHbGHne2Z791YC9l9SiiKkVWT+mAOKl06WXmu42KW5Z1OqbYdZGc6M4LO2hInNf022AlXpb6xBv+Q=
X-Received: by 2002:a4a:cf14:0:b0:569:a08a:d9c5 with SMTP id
 l20-20020a4acf14000000b00569a08ad9c5mr20658543oos.0.1691426867329; Mon, 07
 Aug 2023 09:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <5712331.DvuYhMxLoT@kreacher> <CAJZ5v0jTG-oqV+misnP-=W5aq0S9X631kW9EhKNEn1VJQqwL2g@mail.gmail.com>
 <e3dc9417-626d-bae2-c016-36e14914c9b8@linutronix.de>
In-Reply-To: <e3dc9417-626d-bae2-c016-36e14914c9b8@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Aug 2023 18:47:36 +0200
Message-ID: <CAJZ5v0jX1_yTG6CxnPNVEMf8mMEKc33jpoWoHkreMDZLPK8UcA@mail.gmail.com>
Subject: Re: [RFT][PATCH v2 0/3] cpuidle: teo: Do not check timers
 unconditionally every time
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 5:38 PM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> On Thu, 3 Aug 2023, Rafael J. Wysocki wrote:
>
> > On Thu, Aug 3, 2023 at 11:12 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > Hi Folks,
> > >
> > > This is the second iteration of:
> > >
> > > https://lore.kernel.org/linux-pm/4511619.LvFx2qVVIh@kreacher/
> > >
> > > with an additional patch.
> > >
> > > There are some small modifications of patch [1/3] and the new
> > > patch causes governor statistics to play a role in deciding whether
> > > or not to stop the scheduler tick.
> > >
> > > Testing would be much appreciated!
> >
> > For convenience, this series is now available in the following git branch:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >  pm-cpuidle-teo
> >
>
> Gauthams tests and the distribution of idle time durations looks pretty
> good. Also the prevention of calling tick_nohz_get_sleep_length() is very
> nice (21477 calls of tick_nohz_next_event() and the tick was stopped 2670
> times).
>
> Here is the deviation of idle time durations (based on your branch):
>
> Idle Total              2670    100.00%
> x >= 4ms                2537    95.02%
> 4ms> x >= 2ms           19      0.71%
> 2ms > x >= 1ms          10      0.37%
> 1ms > x >= 500us        7       0.26%
> 500us > x >= 250us      6       0.22%
> 250us > x >=100us       13      0.49%
> 100us > x >= 50us       17      0.64%
> 50us > x >= 25us        25      0.94%
> 25us > x >= 10us        22      0.82%
> 10us > x > 5us          9       0.34%
> 5us > x                 5       0.19%

Thanks a lot for the data!

Can I add a Tested-by: tag from you to this series?
