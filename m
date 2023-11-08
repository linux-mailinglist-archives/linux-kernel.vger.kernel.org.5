Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAD37E5D27
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 19:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjKHSZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 13:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKHSZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 13:25:24 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387851FFD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 10:25:22 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7a66aa8ebb7so284670539f.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 10:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1699467921; x=1700072721; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1RX3+j4H1LZ9VGKq/u5AJmWjNVd+q5xbY7KEqXQdkMs=;
        b=aGRLcYUdkNa2hK0g1KaVjgDpcn8Ld1DlJGvqCfNF5URP5mZsXhGcmvMiTnACGpFeWm
         +iod8yD6teypdAJDjbRXMi3Ca5ai97738Xkp8eM8G/p4rWpwEgbGNlp98R/fOiy5QlAv
         esYzLYqTQePDMuqsGPytxNmciINRar7fFjOJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699467921; x=1700072721;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RX3+j4H1LZ9VGKq/u5AJmWjNVd+q5xbY7KEqXQdkMs=;
        b=RonosTucdG17lWEOxeH4pz8+KUV8PjLNUkWFJYOFqozQ11wAhZ+GOb+VTv3ntD+BNI
         wvH1ZJn4M+fdl5eH6ShIuM3kU2VyFOYsmUr5f93Ort6kVB5IRfV1rJqHXbe7tp2GQDb5
         Ho7jpD+whSFirfZpNPd7pkBlATM2fqlkiub/CQyhxh6Fs4MagmpgyCEGqWDcEp3XXmbI
         Qrm8q2OVYsi1k/mXr1vbKLTUejDQIYkHm79QClYTw1hdffHHWkCb/9Gy7SuIfbUdhmc4
         6otr3rLvAXtZkDRiE+A2PpsZcb3TRFqzbYguefrpMgNHq3ZN6gSNLMkK3vCy3vIq5Oam
         dHSA==
X-Gm-Message-State: AOJu0YxWgubDRUr20D3ARBG1K99CO7dk0Y2kGZW10dFDSyan84nc9FmP
        vSeh1Vm156SAyfKAksJUMla9ow==
X-Google-Smtp-Source: AGHT+IFDGfBjC0DoVmppKMHmtXnvp8MRqJTflWZah7YfhYKhkAdeoKqQQTGD5/CpveBRBkm4PNhuzw==
X-Received: by 2002:a05:6602:3812:b0:786:25a3:ef30 with SMTP id bb18-20020a056602381200b0078625a3ef30mr3712415iob.7.1699467921466;
        Wed, 08 Nov 2023 10:25:21 -0800 (PST)
Received: from localhost (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id g37-20020a028528000000b00463f8b3e34asm3090404jai.23.2023.11.08.10.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 10:25:21 -0800 (PST)
Date:   Wed, 8 Nov 2023 18:25:20 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
Message-ID: <20231108182520.GD2992223@google.com>
References: <cover.1699095159.git.bristot@kernel.org>
 <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
 <CAEXW_YS=PrWDx+YGVR7bmq0_SoKNztzGrreApCd9qk1yBLA5bA@mail.gmail.com>
 <CAEXW_YQ8kv3tXQJexLSguPuWi0bXiReKDyYNo9+A-Hgp=Zo1vA@mail.gmail.com>
 <CAEXW_YSjsZSrJK_RbGmbLNy4UrLCgu+7NPZjg-wiLuNbGOGr+w@mail.gmail.com>
 <20231107114732.5dd350ec@gandalf.local.home>
 <7d1ea71b-5218-4ee0-bc89-f02ee6bd5154@redhat.com>
 <3e58fad7-7f66-4e48-adcc-0fda9e9d0d07@kernel.org>
 <CAEXW_YT-d4uNr4eyfXeCdUCmYu8LgYtMXTQVN=RXkjmxPz9d0g@mail.gmail.com>
 <cc7d1140-1190-4f04-b6e6-9754aba96218@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc7d1140-1190-4f04-b6e6-9754aba96218@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 09:01:17AM +0100, Daniel Bristot de Oliveira wrote:
> On 11/8/23 04:20, Joel Fernandes wrote:
> > Hi Daniel,
> > 
> > On Tue, Nov 7, 2023 at 1:50 PM Daniel Bristot de Oliveira
> > <bristot@kernel.org> wrote:
> >>
> >>> The code is not doing what I intended because I thought it was doing overload
> >>> control on the replenishment, but it is not (my bad).
> >>>
> >>
> >> I am still testing but... it is missing something like this (famous last words).
> >>
> >> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> >> index 1092ca8892e0..6e2d21c47a04 100644
> >> --- a/kernel/sched/deadline.c
> >> +++ b/kernel/sched/deadline.c
> >> @@ -842,6 +842,8 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
> >>   * runtime, or it just underestimated it during sched_setattr().
> >>   */
> >>  static int start_dl_timer(struct sched_dl_entity *dl_se);
> >> +static bool dl_entity_overflow(struct sched_dl_entity *dl_se, u64 t);
> >> +
> >>  static void replenish_dl_entity(struct sched_dl_entity *dl_se)
> >>  {
> >>         struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
> >> @@ -852,9 +854,18 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
> >>         /*
> >>          * This could be the case for a !-dl task that is boosted.
> >>          * Just go with full inherited parameters.
> >> +        *
> >> +        * Or, it could be the case of a zerolax reservation that
> >> +        * was not able to consume its runtime in background and
> >> +        * reached this point with current u > U.
> >> +        *
> >> +        * In both cases, set a new period.
> >>          */
> >> -       if (dl_se->dl_deadline == 0)
> >> -               replenish_dl_new_period(dl_se, rq);
> >> +       if (dl_se->dl_deadline == 0 ||
> >> +               (dl_se->dl_zerolax_armed && dl_entity_overflow(dl_se, rq_clock(rq)))) {
> >> +                       dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
> >> +                       dl_se->runtime = pi_of(dl_se)->dl_runtime;
> >> +       }
> >>
> >>         if (dl_se->dl_yielded && dl_se->runtime > 0)
> >>                 dl_se->runtime = 0;
> > 
> > I was wondering does this mean GRUB needs to be enabled? Otherwise I
> > can see that "runtime / (deadline - t) > dl_runtime / dl_deadline"
> > will be true almost all the time due to the constraint of executing at
> > the 0-lax time.
> 
> No grub needed. It will only happen if the fair server did not have any chance to run.
> 
> If it happens, it is not a problem, see that timeline I replied in the previous
> email.

Ah you're right, I mistakenly read your diff assuming you were calling
replenish_dl_new_period() on dl_entity_overflow(). Indeed the diff is needed
(I was actually wondering about why that was not done in my initial review as
well -- so its good we found it in discussion).

> We do not want a zerolax scheduler, because it breaks everything else. It is
> a deferred EDF, that looking from wall clock, composes an "zerolaxish" timeline.

Indeed. I was not intending that we do zerolax scheduler, I was merely
misreading the diff assuming you were throttling the DL-server once again at
the zerolax time.

thanks,

 - Joel

