Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B186C7FBA9D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344814AbjK1M55 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Nov 2023 07:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344416AbjK1M54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:57:56 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AA0D51;
        Tue, 28 Nov 2023 04:58:02 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-58d9a0ead0cso302593eaf.0;
        Tue, 28 Nov 2023 04:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701176282; x=1701781082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YG0kmMybYYlsW64Xr/XYrAZDTr9Z329CgjHG1/4iHg=;
        b=w3Mf/AfyA2KIwky/anWd2Xvu7hGWIzYDjRkRxCDEufhJQOeqTYWA58FZ7NNt6yGe7a
         WvEIwAMS0KZr2qyN779RDBzXqnG7sr85e8ooPfFnUskQ7m4qPxpyqStGmXX8go0qgOdz
         PB3swlqerWtGQ1eeQMagm4NKZx1aM9f6dCeV/V6bpgB6C09B/TZWMWeAJiJLWaCFbX1g
         xqeq9KeZf9sAQEFfWgIQlIly6dsm96Ji5s3+95xuRlDIOkOxEa0wdDTUJ+wIFOGRNIbQ
         Skp2brWlH+vf9K9VSYm+KcZt8C6jxenW8FcnAkZ1pdbm8/0jMA99BqQ19U8zkdyT7fZN
         onGw==
X-Gm-Message-State: AOJu0Yxey8IMYQDnP+txsBDeWKa5b+u/CXdJoHsSsE5+nygJZCdgRqyU
        ogsv7KPOk2JHeRjPwl4jCY/gKydfGijEe0vV7Yc=
X-Google-Smtp-Source: AGHT+IGcKg7kPyrtbQW75Vb7JRxbMg34PXwVY6aOsGsKNdwtHs3RDwo4eQk03Yl8gZJLM6x7wCGoUKniSmcvU0fQoy4=
X-Received: by 2002:a4a:c691:0:b0:584:1080:f0a5 with SMTP id
 m17-20020a4ac691000000b005841080f0a5mr14243522ooq.1.1701176281795; Tue, 28
 Nov 2023 04:58:01 -0800 (PST)
MIME-Version: 1.0
References: <4892163.31r3eYUQgx@kreacher> <f3b2dc4d-3d20-4f90-95ce-5d62fc7ef685@arm.com>
 <CAJZ5v0iYy90+WPceFrJdv15jBg4NKUz0gj9DsxjCYQr38GznBQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iYy90+WPceFrJdv15jBg4NKUz0gj9DsxjCYQr38GznBQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Nov 2023 13:57:50 +0100
Message-ID: <CAJZ5v0jYx2ssJ4JtzA7EdRUrXJCNVr4=FjnWbHUDB1ZX-NpN5Q@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: trip: Rework thermal_zone_set_trip() and its callers
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
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

On Tue, Nov 28, 2023 at 1:53 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Hi Lukasz,
>
> On Tue, Nov 28, 2023 at 9:16 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >
> > Hi Rafael,
> >
> > On 11/27/23 19:59, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >

[cut]

> > > Index: linux-pm/drivers/thermal/thermal_trip.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/thermal/thermal_trip.c
> > > +++ linux-pm/drivers/thermal/thermal_trip.c
> > > @@ -148,42 +148,61 @@ int thermal_zone_get_trip(struct thermal
> > >   EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
> > >
> > >   int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
> > > -                       const struct thermal_trip *trip)
> > > +                       enum thermal_set_trip_target what, const char *buf)
> > >   {
> > > -     struct thermal_trip t;
> > > -     int ret;
> > > +     struct thermal_trip *trip;
> > > +     int val, ret = 0;
> > >
> > > -     if (!tz->ops->set_trip_temp && !tz->ops->set_trip_hyst && !tz->trips)
> > > -             return -EINVAL;
> >
> > Here we could bail out when there are no callbacks.
>
> Not really, because the trip is updated regardless.

Actually, the condition above is always false after recent changes,
because tz->trips[] is always present, so the if () statement is
redundant.
