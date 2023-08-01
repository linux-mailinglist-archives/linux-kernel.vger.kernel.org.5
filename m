Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3235276BD6D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjHATMG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Aug 2023 15:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjHATMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:12:01 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B7C1BF0;
        Tue,  1 Aug 2023 12:12:00 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-56ca74ee539so415448eaf.1;
        Tue, 01 Aug 2023 12:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690917119; x=1691521919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWz8bsi29e5gL7t0ui+qKj7hihevBZdVWgd9oh+EkNg=;
        b=ek65mPDjMkcS5GApwn7+CfS6WUn8phgbObOEL/F7iH8kirj+u9DmOTmsQrj9mok02/
         MXUBZ6LJgkpvQTlfns66uM3ntzH6hM04PZrf2D43jstG9yUExYqTxwD962SJIiOTTOv1
         sLFjEMWu7DnkZdEw4AZ1FrmAToB7h3oUqszy5sz+i2gnouF2aKKe7LP5/qpvVpLn4s7i
         RUJOIJnybhKZwEh782+QyduBlhxa7U+n3LVEid5xeyuumHjW9Sv7Xm9GowwRt7RED+J+
         +TknQA+b2dQSCsWwp+z7OTxiP3dRCGmrMSbJfWQ3qIBxw+5G3h1Bf6y12E2LttLNZXOf
         wOYQ==
X-Gm-Message-State: ABy/qLZDUeK+MZlhVz3oyo8wyWXWzp1dOG95c4CkESqgn3D0aoNXuvPN
        PQVnMe/YMahjbHr1H4B4kTN+5kfXSHqDICg6UoFKWv5R
X-Google-Smtp-Source: APBJJlH2FuOTJREKF1NQYafwrdZN/2+4S2VimJtj7Ddlca9DhFN8hB84Pk+ARfkStnXpWAVoTm/f+Seeh6aVNF7XiCU=
X-Received: by 2002:a05:6820:2201:b0:560:b01a:653d with SMTP id
 cj1-20020a056820220100b00560b01a653dmr10050480oob.0.1690917119453; Tue, 01
 Aug 2023 12:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher>
 <2154273.irdbgypaU6@kreacher> <fee918ad-792c-f4e7-935d-1af9540b7274@linaro.org>
In-Reply-To: <fee918ad-792c-f4e7-935d-1af9540b7274@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Aug 2023 21:11:48 +0200
Message-ID: <CAJZ5v0iQpjLpcSZrnLv=0A9duR4Kf9_cB3kBZxJorfuPZzrGmA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] thermal: core: Add routines for locking and
 unlocking thermal zones
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 8:30 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
>
> On 25/07/2023 14:08, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Add thermal_zone_device_lock() and thermal_zone_device_unlock() for
> > acquiring and releasing the thermal zone lock, respectively.
> >
> > They will be used by the ACPI thermal driver to protect trip point
> > temperature updates against races with accesses from elsewhere.
>
> This change goes to the opposite direction of the previous thermal zone
> cleanup and encapsulation we have done recently.
>
> Here we give the possibility to a driver to act on the thermal core
> internals.
>
> Ideally, we should see tz->lock only in thermal_core.c

There needs to be a way to lock the thing if it needs to be locked.

The thermal zone has been registered by the driver after all, and if
it needs to be updated, the driver needs to be able to do that safely.

I'm guessing that the suggested way is to disable the thermal zone for
the time of the update, but I'm kind of unsure if this is going to
work.

>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v2 -> v3: No changes.
> >
> > v1 -> v2: New patch.
> >
> > ---
> >   drivers/thermal/thermal_core.c |   13 +++++++++++++
> >   include/linux/thermal.h        |    2 ++
> >   2 files changed, 15 insertions(+)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -497,6 +498,18 @@ void thermal_zone_device_update(struct t
> >   }
> >   EXPORT_SYMBOL_GPL(thermal_zone_device_update);
> >
> > +void thermal_zone_device_lock(struct thermal_zone_device *tz)
> > +{
> > +     mutex_lock(&tz->lock);
> > +}
> > +EXPORT_SYMBOL_GPL(thermal_zone_device_lock);
> > +
> > +void thermal_zone_device_unlock(struct thermal_zone_device *tz)
> > +{
> > +     mutex_unlock(&tz->lock);
> > +}
> > +EXPORT_SYMBOL_GPL(thermal_zone_device_unlock);
> > +
> >   static void thermal_zone_device_check(struct work_struct *work)
> >   {
> >       struct thermal_zone_device *tz = container_of(work, struct
> > Index: linux-pm/include/linux/thermal.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/thermal.h
> > +++ linux-pm/include/linux/thermal.h
> > @@ -336,6 +336,8 @@ int thermal_zone_unbind_cooling_device(s
> >                                      struct thermal_cooling_device *);
> >   void thermal_zone_device_update(struct thermal_zone_device *,
> >                               enum thermal_notify_event);
> > +void thermal_zone_device_lock(struct thermal_zone_device *tz);
> > +void thermal_zone_device_unlock(struct thermal_zone_device *tz);
> >
> >   struct thermal_cooling_device *thermal_cooling_device_register(const char *,
> >               void *, const struct thermal_cooling_device_ops *);
> >
> >
> >
