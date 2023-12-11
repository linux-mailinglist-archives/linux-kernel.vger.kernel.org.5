Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD75880D4CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345087AbjLKR6H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 12:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344957AbjLKR6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:58:06 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB5193;
        Mon, 11 Dec 2023 09:58:12 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6d9db92bd71so600219a34.1;
        Mon, 11 Dec 2023 09:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317491; x=1702922291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXbiTpVzJfHRl7QZFMGmf1sW13oDT9FBF5f3B7KPSvc=;
        b=AZLuqQHAZbxrleryKoiCa7ycnnmw1g7zBi3m56KgedN562h66X4iIHoeDHcreTH3L7
         naAPTlkORp5uZxqi3KijuaFI1dJbRokHtO70Rom/mxKxEyJUgrZSxcejxdkvPbFDfeC/
         uz78wbaPSfHc+vWdFt1ZMlHyT/eOX6aIhN3lxPeTHNBImwxclVlcyT+eL5NfHTsl2+pM
         Ky8KUIHhkPwsoS0wOi98seZFvjSSs/hAkb1I9Rwwgf5EKMUmRGbn6ICITAtZdRsIzsAH
         p3Dikz61fe51hM8p2RSBkKmpzeZt7R23po+EPt/biQXQpP5fsY04xkLkKXssXdxmJ+7C
         tFLA==
X-Gm-Message-State: AOJu0YzZLDV5C6xY0Y7FwDaYknR0tqSxHkxWjFKi9Q6Qok9pNTnnkvDY
        fRK5sO4z9OM2gqNRNHeDUamcI27p6wynd3wRBlE=
X-Google-Smtp-Source: AGHT+IEB8tbPHG0hpmSXtZbQPu9rCKTmgzM9oTofWHtCzQfwuRW4mAEhOhvFbMf7e2/laCNphcPlfM/B7FB2AK0pBlo=
X-Received: by 2002:a05:6871:2284:b0:1fb:648:5207 with SMTP id
 sd4-20020a056871228400b001fb06485207mr9545202oab.2.1702317491331; Mon, 11 Dec
 2023 09:58:11 -0800 (PST)
MIME-Version: 1.0
References: <1880915.tdWV9SEqCh@kreacher> <8315317.T7Z3S40VBb@kreacher> <03944e4e-d57d-4442-b38d-e36e20cb5ae3@linaro.org>
In-Reply-To: <03944e4e-d57d-4442-b38d-e36e20cb5ae3@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Dec 2023 18:58:00 +0100
Message-ID: <CAJZ5v0hwLcL9UKQs7WA=hb2v31eEY83rv-bQVgSv_EV9AidYZA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] thermal: Drop redundant and confusing
 device_is_registered() checks
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
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

On Mon, Dec 11, 2023 at 6:39 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 08/12/2023 20:19, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Multiple places in the thermal subsystem (most importantly, sysfs
> > attribute callback functions) check if the given thermal zone device is
> > still registered in order to return early in case the device_del() in
> > thermal_zone_device_unregister() has run already.
> >
> > However, after thermal_zone_device_unregister() has been made wait for
> > all of the zone-related activity to complete before returning, it is
> > not necessary to do that any more, because all of the code holding a
> > reference to the thermal zone device object will be waited for even if
> > it does not do anything special to enforce this.
> >
> > Accordingly, drop all of the device_is_registered() checks that are now
> > redundant and get rid of the zone locking that is not necessary any more
> > after dropping them.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
>
> [ ... ]
>
> > @@ -132,11 +120,6 @@ trip_point_temp_store(struct device *dev
> >
> >       mutex_lock(&tz->lock);
> >
> > -     if (!device_is_registered(dev)) {
> > -             ret = -ENODEV;
> > -             goto unlock;
> > -     }
> > -
> >       trip = &tz->trips[trip_id];
> >
> >       if (temp != trip->temperature) {
> > @@ -162,23 +145,12 @@ trip_point_temp_show(struct device *dev,
> >                    char *buf)
> >   {
> >       struct thermal_zone_device *tz = to_thermal_zone(dev);
> > -     int trip_id, temp;
> > +     int trip_id;
> >
> >       if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
> >               return -EINVAL;
> >
> > -     mutex_lock(&tz->lock);
> > -
> > -     if (!device_is_registered(dev)) {
> > -             mutex_unlock(&tz->lock);
> > -             return -ENODEV;
> > -     }
> > -
> > -     temp = tz->trips[trip_id].temperature;
> > -
> > -     mutex_unlock(&tz->lock);
> > -
> > -     return sprintf(buf, "%d\n", temp);
> > +     return sprintf(buf, "%d\n", tz->trips[trip_id].temperature);
>
> Without the lock, could the trip_temp_store() make the value change
> while we read it?

The lock doesn't change that, because the write can occur before
dropping the lock and the printf() and reading an int is atomic on all
architectures supported by Linux.
