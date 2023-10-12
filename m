Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BC87C739E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379551AbjJLRDn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 13:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378915AbjJLRDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:03:42 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00399C0;
        Thu, 12 Oct 2023 10:03:40 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6bc57401cb9so256583a34.0;
        Thu, 12 Oct 2023 10:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697130220; x=1697735020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQ+0aHw6sQMmsRhISm2t/oJY7lh7N5E9AbFnFFga21k=;
        b=JvV+IFeMmEvHin7JS3QYivIRwrYZIiZyCrPHWe/1Fh5j3xmRF5FFCKeM5dgTuHXnp0
         q6ZGC7kAlU9jIifPM0P5DCN5qyoTroJzy5oN6jDW9j9Ga5s0XsT1hk0y6eWHzxk5PtOR
         TkUUyF0Cl3nlW541Mmv/md/xbuqKtFfBNTyiedpwYZGkrVYXHOLX1izozaHN5LiqES/s
         ELfNdeHIBsX2QapkzTVaGUWjUlxAU19MggRJj0pY3W88AYUwuLOjPat7jA2/WIr0kSjb
         3xAFhIOfeLs6fQUhHTO6TPNE2TC1c72Gyudoy2FXu8oMzVcCavpwM89WjnwZfbgT8gNg
         FqjQ==
X-Gm-Message-State: AOJu0YzbSAh1jjhqmyEtkz42xJ/2Gd88+L7BjeHdl1MltVMa5wnfW85W
        1VXEY3f/RYGnyAGrx9wfDGYYmiepd88mGBvzf8U=
X-Google-Smtp-Source: AGHT+IGBZDKyJD0i4Rb6WrCw/7nCmvRCRZiPDHCjEHSYH2ay0b2U53TEfTm6dOdP4vl4qt1PTdMgxQtx16k2IVf+oXk=
X-Received: by 2002:a4a:df07:0:b0:57b:73f6:6f80 with SMTP id
 i7-20020a4adf07000000b0057b73f66f80mr24752122oou.0.1697130220076; Thu, 12 Oct
 2023 10:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230916113327.85693-1-bo.ye@mediatek.com> <a3255da4-b2af-4403-af68-3067a5fd49bf@linaro.org>
In-Reply-To: <a3255da4-b2af-4403-af68-3067a5fd49bf@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Oct 2023 19:03:28 +0200
Message-ID: <CAJZ5v0i0Yk+juOQthy2dh89L9RdOBRHcSk43KLEGMeJszTXBVQ@mail.gmail.com>
Subject: Re: [PATCH] Subject: thermal: Fix potential race condition in suspend/resume
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Bo Ye <bo.ye@mediatek.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        yugang.wang@mediatek.com, yongdong.zhang@mediatek.com,
        browse.zhang@mediatek.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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

On Thu, Oct 12, 2023 at 5:39 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 16/09/2023 13:33, Bo Ye wrote:
> > From: "yugang.wang" <yugang.wang@mediatek.com>
> >
> > Body:
> > This patch fixes a race condition during system resume. It occurs if
> > the system is exiting a suspend state and a user is trying to
> > register/unregister a thermal zone concurrently. The root cause is
> > that both actions access the `thermal_tz_list`.
>
> I'm not sure the tasks are already thawed during POST_RESTORE, so no
> user can unload a driver and then reaching the race window.

Yes, they are.

> Is that an observed issue?

Good question, but the patch looks correct to me.

> > In detail:
> >
> > 1. At PM_POST_SUSPEND during the resume, the system reads all thermal
> >     zones in `thermal_tz_list`, then resets and updates their
> >     temperatures.
> > 2. When registering/unregistering a thermal zone, the
> >     `thermal_tz_list` gets manipulated.
> >
> > These two actions might occur concurrently, causing a race condition.
> > To solve this issue, we introduce a mutex lock to protect
> > `thermal_tz_list` from being modified while it's being read and
> > updated during the resume from suspend.
> >
> > Kernel oops excerpt related to this fix:
> >
> > [ 5201.869845] [T316822] pc: [0xffffffeb7d4876f0] mutex_lock+0x34/0x170
> > [ 5201.869856] [T316822] lr: [0xffffffeb7ca98a84] thermal_pm_notify+0xd4/0x26c
> > [... cut for brevity ...]
> > [ 5201.871061] [T316822]  suspend_prepare+0x150/0x470
> > [ 5201.871067] [T316822]  enter_state+0x84/0x6f4
> > [ 5201.871076] [T316822]  state_store+0x15c/0x1e8
> >
> > Change-Id: Ifdbdecba17093f91eab7e36ce04b46d311ca6568
> > Signed-off-by: yugang.wang <yugang.wang@mediatek.com>
> > Signed-off-by: Bo Ye <bo.ye@mediatek.com>
> > ---
> >   drivers/thermal/thermal_core.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > index 8717a3343512..a7a18ed57b6d 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -1529,12 +1529,14 @@ static int thermal_pm_notify(struct notifier_block *nb,
> >       case PM_POST_HIBERNATION:
> >       case PM_POST_RESTORE:
> >       case PM_POST_SUSPEND:
> > +             mutex_lock(&thermal_list_lock);
> >               atomic_set(&in_suspend, 0);
> >               list_for_each_entry(tz, &thermal_tz_list, node) {
> >                       thermal_zone_device_init(tz);
> >                       thermal_zone_device_update(tz,
> >                                                  THERMAL_EVENT_UNSPECIFIED);
> >               }
> > +             mutex_unlock(&thermal_list_lock);
> >               break;
> >       default:
> >               break;
>
> --
