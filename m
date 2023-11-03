Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CCC7E00A2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbjKCHO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjKCHO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:14:27 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1783D50;
        Fri,  3 Nov 2023 00:14:23 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6c3443083f2so1094291b3a.0;
        Fri, 03 Nov 2023 00:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698995663; x=1699600463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E8vtWUN6Z2/3cjwlI0yZhln1eNCqNoE/ZCKBzMVnkOQ=;
        b=J0Mwa5BPkjPvuBUMxHR/A9A1uv3e7pUDyxaa1mmSrAwC/v3HKB55ycOissGvDW3BZm
         kT8m8YU5fnJAK3WZhk9MzKP3+X3Vq0lZqMVRMLtjwJvlgE8TWfBbaUmiy45nz9gvbwKq
         xesXl6YpYNrpJVKywo3QFIfH2G6aNDXBPCvdHwgtx1jm1B10Z5tXCCnbK2rO7yD2PTro
         fkknIvj8RWYjmHyx8XvPUkA4yXfDfHXaw1aXEy2SA+zT4qFsiGqWFnF6Gs/CWxl/E2BR
         G/78QWWq7WEzCdKcsD7VmTzSgycomixeS1EVRUuNU9ajglkZj5eaP59oFjOGyGIE9BMC
         81eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698995663; x=1699600463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8vtWUN6Z2/3cjwlI0yZhln1eNCqNoE/ZCKBzMVnkOQ=;
        b=kvY7525b5Y/e4B5sd+sro+22jzqryoTYcaIdNYIFHxT2Ud0R/jG4aqecuBi+SLxykC
         4iNYaLoJ0+Ch7qSIOqYjhbj36qnh+sWvk2xpXhCq+D5fWgPaBsa26z11NFviUZTo4dOB
         OohVeb7D5PfQAczezmoB/KvaIGc+3Z4AaCSVz3x5/pnbm9K2zje8RuCjtGIhbx6PuJuI
         MJmDlwvXN6NbR3LRApgegVTHXg4lPViWrw4LlZOdL6qrL8MEqtAu1T3THHGiowEZdMPg
         HU2d5/YeGB8jq2T7j70uWl6O+Ux9Do4zja8tCny/Dfg8GZNhPk4ycBzDplVk81ZNHmKI
         hJ1g==
X-Gm-Message-State: AOJu0Yx3MbNiMULwfhn8VAue+wxk/y+bHN1McBV7ptkOUGfQkekxcCM7
        Jvetur4gwMTnnx5B90AIVnUk1PRLMwqkCLZnEXs=
X-Google-Smtp-Source: AGHT+IFNoKP67Y2k56CDr4Nh/iNuAUeGuhv/FQb/yzwNO16FWIVeu/Efdfp0xAERzrn3EeWtDRvv84+knAZ5Qimtxfk=
X-Received: by 2002:a05:6a21:193:b0:17a:eddb:acc2 with SMTP id
 le19-20020a056a21019300b0017aeddbacc2mr23977939pzb.46.1698995663277; Fri, 03
 Nov 2023 00:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231101033507.21651-1-qiang.zhang1211@gmail.com> <9f15280f-45a3-4e3f-832d-cea5c77eb449@paulmck-laptop>
In-Reply-To: <9f15280f-45a3-4e3f-832d-cea5c77eb449@paulmck-laptop>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Fri, 3 Nov 2023 15:14:11 +0800
Message-ID: <CALm+0cULD+R1EmWVRi1RZJJgD=CGb2oxxGMZojU7A9z8Wj_QVQ@mail.gmail.com>
Subject: Re: [PATCH] rcu: Force quiescent states only for ongoing grace period
To:     paulmck@kernel.org
Cc:     frederic@kernel.org, joel@joelfernandes.org, boqun.feng@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Wed, Nov 01, 2023 at 11:35:07AM +0800, Zqiang wrote:
> > Currently, when running the rcutorture testing, if the fqs_task
> > kthread was created, the periodic fqs operations will be performed,
> > regardless of whether the grace-period is ongoing. however, if there
> > is no ongoing grace-period, invoke the rcu_force_quiescent_state() has
> > no effect, because when the new grace-period starting, will clear all
> > flags int rcu_state.gp_flags in rcu_gp_init(). this commit therefore add
> > rcu_gp_in_progress() check in rcu_force_quiescent_state(), if there is
> > no ongoing grace-period, return directly.
> >
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>
> Nice optimization, but one question below.
>
>                                                 Thanx, Paul
>
> > ---
> >  kernel/rcu/tree.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index aa4c808978b8..5b4279ef66da 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2338,6 +2338,8 @@ void rcu_force_quiescent_state(void)
> >       struct rcu_node *rnp;
> >       struct rcu_node *rnp_old = NULL;
> >
> > +     if (!rcu_gp_in_progress())
> > +             return;
>
> Suppose that the grace period that was in progress above ends right
> at this point in the code.  We will still do the useless grace
> forcing of quiescent states.  Which means that this code path
> does need to be tested.
>
> So, when you run rcutorture with this change, how often has the
> grace period ended before this function returns?  If that happens
> reasonably often, say more than once per minute or so, then this
> works nicely.  If not, we do need to do something to make sure
> that that code path gets tested.
>
> Thoughts?

Thanks for the suggestion, I will add some debug information to test again.

Thanks
Zqiang

>
> >       /* Funnel through hierarchy to reduce memory contention. */
> >       rnp = raw_cpu_read(rcu_data.mynode);
> >       for (; rnp != NULL; rnp = rnp->parent) {
> > --
> > 2.17.1
> >
