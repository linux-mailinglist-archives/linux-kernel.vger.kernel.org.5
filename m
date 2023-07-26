Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19A9763A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbjGZPJO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 11:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjGZPJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:09:11 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD022D4B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:08:45 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-56475c1b930so822592eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690384059; x=1690988859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9Nll31qore+YMtR2sZzsURUVMpefjPwpueh4FXM8HI=;
        b=O0gvLw3beweVM26ZkVk30ihX1TUX9DqVfUmkNeSX+z0bpqk8tUCaMk33jeK6L0ggEh
         j8aFSPVxpQ0/wIUdxtIc3UB1aCsC3zcxVwrkGeyJ0vkMrtL242BkiqFPxk1dC+tpDz5L
         2PEeIRcUj24tLE+hrCbZVgcu853x8BfEEzWA98zb1voCFppvrWHw4w+F6GqO9NoffyNg
         qDW9m+DgzmnY/VhZl7Yu0JZAriEcdJBebWNHQ/VCqJCuX+rgzX1PRP+K+QMg9AY7ovaF
         FCHBCbZJe8D0E8LgbkmE7ZB+th8elx4TEO+owOkzgzbLaYDw2D0O5GJlWMvPiXQZAZS2
         eQ/A==
X-Gm-Message-State: ABy/qLY1r6+sxrcKC8bwiejQqHFlfMP9AvDbaaKOxF8TKOkm6Ma2wu90
        TJ6+2Df1uPBpA4Dm9KJjLz2e6f/COTumlyOBVc8=
X-Google-Smtp-Source: APBJJlF7iS9sNJuvl+gXErZ+euc64wmKj8tDVovvJ4kTcgykvqZqfTAeGZYIkC8NJCov4/pi5OrmYe4l2ZBcD2v6aHU=
X-Received: by 2002:a4a:c449:0:b0:566:951e:140c with SMTP id
 h9-20020a4ac449000000b00566951e140cmr1704023ooq.1.1690384059027; Wed, 26 Jul
 2023 08:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <80956e8f-761e-b74-1c7a-3966f9e8d934@linutronix.de>
 <CAKfTPtCSsLz+qD-xUnm4N1HyZqtQD+rYVagnSur+hfUHEk0sYg@mail.gmail.com>
 <ad370ab-5694-d6e4-c888-72bdc635824@linutronix.de> <ZL2Z8InSLmI5GU9L@localhost.localdomain>
 <CAJZ5v0ib=j+DHVE1mKCZaoyZ_CHVkA9f90v8b8wSA+3TEG1kHg@mail.gmail.com>
 <8857d035-1c1a-27dd-35cf-7ff68bbf3119@linutronix.de> <CAJZ5v0gJj_xGHcABCDoX2t8aR+9kXr7fvRFF+5KBO5MJz9kFWQ@mail.gmail.com>
 <ZMD8fP36By1KYgkk@localhost.localdomain>
In-Reply-To: <ZMD8fP36By1KYgkk@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Jul 2023 17:07:27 +0200
Message-ID: <CAJZ5v0iZhEcRLM7yRNffYSSfNxQH+MyuF2rMsqqX5O0jOSVG7Q@mail.gmail.com>
Subject: Re: Stopping the tick on a fully loaded system
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 12:59 PM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> Le Tue, Jul 25, 2023 at 04:27:56PM +0200, Rafael J. Wysocki a écrit :
> > On Tue, Jul 25, 2023 at 3:07 PM Anna-Maria Behnsen
> > I'll let Frederic respond to the above, but from my perspective it all
> > just means that the idle governors in use today are not perfect.
> >
> > However, they will never be perfect, because they only have a little
> > time to make a decision, so it's a matter of balancing that with
> > precision.
>
> So, even without considering Anna-Maria's patchset, sparing
> the next timer lookup if we already know we won't stop it would show
> quite a benefit because that lookup involves locking and quite some
> overhead walking through all levels.

You are right.

In principle, this can be done by using TICK_NSEC as the initial
estimation of the idle duration and only calling
tick_nohz_get_sleep_length() if the candidate state ends up in the
higher bins.  Interesting.
