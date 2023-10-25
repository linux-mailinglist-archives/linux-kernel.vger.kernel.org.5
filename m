Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5FF7D7328
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbjJYSVj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 14:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjJYSVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:21:34 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE032128;
        Wed, 25 Oct 2023 11:21:31 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-582050ce2d8so11856eaf.0;
        Wed, 25 Oct 2023 11:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698258091; x=1698862891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJP3exTpHoNYEw/4xkY7H/xfld7IzY+KbGZCq5/4uIM=;
        b=ONBLqJfkMyaZ+OpKk84lHLTNcKe/yiokwxRbeyvHgM8CeCIf7cGim2PJ0obpPHTNvc
         5TPoRpnyesGmh1dC00UGZDS7h1Yl99g7eD9vJQxE9To+zfV4kpoGpJ+z9tl/020ZrgYy
         Q6nRSptTPEd92hAXhcs7CZdiojk028Kyvf2KFyUkEutdKUXtprmpxiIQUtwbvq6Ohmdk
         DXTGB2i2tOHFszEzI0UJWMHjJptxk4N9mfOAEBp63jRFkUK/2zzVScEDbW763b6my8e6
         B3jTqVfHzBhCXSzvEx+Yt4GvR6ys16nDT/I7Vsi1aNML2T0c8LXFnqeyIaPc/VYTjbb5
         1sdA==
X-Gm-Message-State: AOJu0YzUbJXw1w4i0opvJmBeHpEN2KDQ+wfarH9c/oZ0OkuN+MkURBiQ
        V2evNGEfp4ZFmdvdNhJHLHff0VjA1+7O2HRxv4cf3VEF
X-Google-Smtp-Source: AGHT+IE+CaOUFZcFyjiAi786fFQlNLiN1pR6zgonMuMC+C3tqb97Fo8IXQNJTHsDlFw3uFwIgFs2fQ0e3icA23qUFGc=
X-Received: by 2002:a05:6870:fb86:b0:1e9:e605:27a1 with SMTP id
 kv6-20020a056870fb8600b001e9e60527a1mr17719277oab.2.1698258091022; Wed, 25
 Oct 2023 11:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230916113327.85693-1-bo.ye@mediatek.com> <542a64a842d715329b35654db908681e074b0db5.camel@mediatek.com>
 <148c8e2d10bbb932177f732dfc44230681dc4d91.camel@mediatek.com>
In-Reply-To: <148c8e2d10bbb932177f732dfc44230681dc4d91.camel@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Oct 2023 20:21:20 +0200
Message-ID: <CAJZ5v0hSeCcpOr4qOpji8sbN89GnsYYc1pYBhV+LmS=TiJQMnA@mail.gmail.com>
Subject: Re: [PATCH] thermal: Fix potential race condition in suspend/resume
To:     =?UTF-8?B?Qm8gWWUgKOWPtuazoik=?= <Bo.Ye@mediatek.com>
Cc:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        =?UTF-8?B?WW9uZ2RvbmcgWmhhbmcgKOW8oOawuOS4nCk=?= 
        <Yongdong.Zhang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?QnJvd3NlIFpoYW5nICjlvKDno4op?= 
        <Browse.Zhang@mediatek.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        =?UTF-8?B?WXVnYW5nIFdhbmcgKOeOi+eOieWImik=?= 
        <Yugang.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
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

On Mon, Oct 23, 2023 at 3:20 AM Bo Ye (叶波) <Bo.Ye@mediatek.com> wrote:
>
> Yes, it is observed issue.

It does happen, so it's not just "potential" and the subject of the
patch is slightly misleading.  Please adjust it.

> Firstly, it needs to be clarified that this issue occurs in a real-
> world environment. By analyzing the logs, we inferred that the issue
> occurred just as the system was entering suspend mode, and the user was
> switching the thermal policy (this action causes all thermal zones to
> unregister/register). In addition, we conducted degradation tests and
> also reproduced this issue. The specific method is to first switch the
> thermal policy through a command, and then immediately put the system
> into suspend state through another command. This method can also
> reproduce the issue.

OK, so please add this information to the patch changelog.

> On Thu, 2023-10-12 at 07:35 +0000, Bo Ye (叶波) wrote:
> > On Sat, 2023-09-16 at 19:33 +0800, Bo Ye wrote:
> >
> > Correct mail title format: remove "Subject:" from mail title.
> >
> > > From: "yugang.wang" <yugang.wang@mediatek.com>
> > >
> > > Body:
> > > This patch fixes a race condition during system resume. It occurs
> > > if
> > > the system is exiting a suspend state and a user is trying to
> > > register/unregister a thermal zone concurrently. The root cause is
> > > that both actions access the `thermal_tz_list`.
> > >
> > > In detail:
> > >
> > > 1. At PM_POST_SUSPEND during the resume, the system reads all
> > > thermal
> > >    zones in `thermal_tz_list`, then resets and updates their
> > >    temperatures.
> > > 2. When registering/unregistering a thermal zone, the
> > >    `thermal_tz_list` gets manipulated.
> > >
> > > These two actions might occur concurrently, causing a race
> > > condition.
> > > To solve this issue, we introduce a mutex lock to protect
> > > `thermal_tz_list` from being modified while it's being read and
> > > updated during the resume from suspend.
> > >
> > > Kernel oops excerpt related to this fix:
> > >
> > > [ 5201.869845] [T316822] pc: [0xffffffeb7d4876f0]
> > > mutex_lock+0x34/0x170
> > > [ 5201.869856] [T316822] lr: [0xffffffeb7ca98a84]
> > > thermal_pm_notify+0xd4/0x26c
> > > [... cut for brevity ...]
> > > [ 5201.871061] [T316822]  suspend_prepare+0x150/0x470
> > > [ 5201.871067] [T316822]  enter_state+0x84/0x6f4
> > > [ 5201.871076] [T316822]  state_store+0x15c/0x1e8

Well, the connection between the above log snippet and the issue
addressed by the patch is rather hard to establish.  Please include
more of the oops information.

> > >
> > > Change-Id: Ifdbdecba17093f91eab7e36ce04b46d311ca6568
> > > Signed-off-by: yugang.wang <yugang.wang@mediatek.com>
> > > Signed-off-by: Bo Ye <bo.ye@mediatek.com>
> > > ---
> > >  drivers/thermal/thermal_core.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/thermal/thermal_core.c
> > > b/drivers/thermal/thermal_core.c
> > > index 8717a3343512..a7a18ed57b6d 100644
> > > --- a/drivers/thermal/thermal_core.c
> > > +++ b/drivers/thermal/thermal_core.c
> > > @@ -1529,12 +1529,14 @@ static int thermal_pm_notify(struct
> > > notifier_block *nb,
> > >     case PM_POST_HIBERNATION:
> > >     case PM_POST_RESTORE:
> > >     case PM_POST_SUSPEND:
> > > +           mutex_lock(&thermal_list_lock);
> > >             atomic_set(&in_suspend, 0);

It is not clear to me why the above statement needs to be under the lock.

> > >             list_for_each_entry(tz, &thermal_tz_list, node) {
> > >                     thermal_zone_device_init(tz);
> > >                     thermal_zone_device_update(tz,
> > >                                                THERMAL_EVENT_UNSPEC
> > > IFIED);
> > >             }
> > > +           mutex_unlock(&thermal_list_lock);
> > >             break;
> > >     default:
> > >             break;
