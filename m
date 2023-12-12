Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F7280F5F8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjLLTFW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 14:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbjLLTFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:05:18 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19310D2;
        Tue, 12 Dec 2023 11:05:23 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b8652c0bd2so476252b6e.1;
        Tue, 12 Dec 2023 11:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702407909; x=1703012709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acI53ybdHT2Ybz8qt+m1BvwwM9zmui8Iu0a8RDnCHxk=;
        b=SlhSFn2bKYKv0v+sGQveSqnRWymzPtVFgumTRPWhI3qM8GAGQSeV19ZnSs4cp2+0ts
         qeH4PevC8r4pYuXZBZSqVCppEabeF6nTCyYenN2GUFtXBFot1h6rMGYPvNvq8Z1sfYc2
         LEMUU+vaD3YBifKYYM7lZ57HSg3cOQaXBMYULdGENtzjNYHF4AOWMfAT1J9c6W1aHeaf
         tp2ZXjpwjgB2YMFKGRzkugMjmvJZD7ZBIY3CkMu3uttxdT1EzfDvmOkJMtj+kr5egHmp
         UUildqRqlq0WSn5LFQIp350a2yEPUx1RbQaQSZ1/B6AO3JkEjsD0MaCXzqidzW+9G9hP
         nijw==
X-Gm-Message-State: AOJu0YwqwmO75MFah4O7lNoJTvDjxGK4H7SKQEoJBAol/PK6H8dQtmwI
        5zMmcDOxfzzntkcfLCcv+F52DrALHJHffy9QJgQ=
X-Google-Smtp-Source: AGHT+IHA5aPq73KlqjHsWJe8UGDHVApy8ClQPEGpXkcVl3Yaj8XAdN3OGN+Mn2ZiVnLPVAe8J1MXkUfUG6cgn1J2gsM=
X-Received: by 2002:a4a:a7c4:0:b0:590:6585:5c41 with SMTP id
 n4-20020a4aa7c4000000b0059065855c41mr10944482oom.0.1702407909102; Tue, 12 Dec
 2023 11:05:09 -0800 (PST)
MIME-Version: 1.0
References: <5737811.DvuYhMxLoT@kreacher> <cf055d45-8970-4657-ab86-d28636645c81@linaro.org>
 <CAJZ5v0ic_=2wvge1T7YmGe5icR5dPxrvKy2N4gXP+KMievobmA@mail.gmail.com>
In-Reply-To: <CAJZ5v0ic_=2wvge1T7YmGe5icR5dPxrvKy2N4gXP+KMievobmA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Dec 2023 20:04:58 +0100
Message-ID: <CAJZ5v0gkBZh42obB-g95T2DBFntYrnidjAeUoFN+e-CqGrSQCw@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: trip: Send trip change notifications on all
 trip updates
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 5:01 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Hi Daniel,
>
> On Wed, Dec 6, 2023 at 3:38 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >
> >
> > Hi Rafael,
> >
> > On 05/12/2023 20:18, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > The _store callbacks of the trip point temperature and hysteresis sysfs
> > > attributes invoke thermal_notify_tz_trip_change() to send a notification
> > > regarding the trip point change, but when trip points are updated by the
> > > platform firmware, trip point change notifications are not sent.
> > >
> > > To make the behavior after a trip point change more consistent,
> > > modify all of the 3 places where trip point temperature is updated
> > > to use a new function called thermal_zone_set_trip_temp() for this
> > > purpose and make that function call thermal_notify_tz_trip_change().
> > >
> > > Note that trip point hysteresis can only be updated via sysfs and
> > > trip_point_hyst_store() calls thermal_notify_tz_trip_change() already,
> > > so this code path need not be changed.
> >
> > Why the ACPI driver is not calling thermal_zone_device_update() after
> > changing the trip point like the other drivers?
>
> It calls that function, but because it may update multiple trips in
> one go, it does that after all of the updates are done, via
> acpi_thermal_check_fn().
>
> > It would make sense to have the thermal framework to be notified about
> > this change and check if there is a trip violation, no ?
>
> It is notified as noted above, but not synchronously.

I believe that the question above has been answered, so are there any
other comments or concerns regarding this patch?
