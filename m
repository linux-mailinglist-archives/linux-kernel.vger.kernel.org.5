Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E96C7E2198
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjKFMcF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Nov 2023 07:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjKFMcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:32:03 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1C8A6;
        Mon,  6 Nov 2023 04:32:00 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6d3099818c0so844715a34.1;
        Mon, 06 Nov 2023 04:32:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699273920; x=1699878720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CLVxleqpC3jykHoWGx0Ji2wnYrlU1c1ECpgQ5J60lY=;
        b=SlE0L7/5utAhSVPh5TTvmmhNce6lbAo5O+ObBHZ2ES1F3kgjDMZnjwV+AErtHYwiAs
         ST7jKDJj7zw8s8WH4xJi8yNXM2sHBDdBgxLre8NMSRZdo6ZB+CFD4vc+A0mll+jRACl0
         1vmXLAj5nfCJG+hO6blws3PpTnVa1hl7vRZGLYmzTBrp5LHfJrjTH4zMTUbPeRAuSfFH
         jjFv4TG3e62C1LuoAQjrdjIjalnM6UREjl8NDuCN047wSWar5ZprOcGvzAPU5E0qDlNt
         LJulLZcMMMUFKyUvsbsDiLiGX++occLjv5tPjU4tfOlY3tZ2Sc6r5XqtWxJ0HwINxD9g
         QAng==
X-Gm-Message-State: AOJu0YxMY1xfrNu+TvEaCmUKxIT5AhjhVDwkFn8QlyhZkaDzBYrl+GsS
        GLHriOebtcSOiqJ5iv1eNn6IxncB1qPDyWhlU98=
X-Google-Smtp-Source: AGHT+IFQoW2nVBuX929i+dbzG3KeetbDlK3NJUcu72+xfX4/rzo7XvmH22n8MppWzSLj8pP4kshs++1RdDUvwBlC/iQ=
X-Received: by 2002:a05:6820:1899:b0:581:e7b8:dd77 with SMTP id
 bm25-20020a056820189900b00581e7b8dd77mr33128497oob.1.1699273919708; Mon, 06
 Nov 2023 04:31:59 -0800 (PST)
MIME-Version: 1.0
References: <12317335.O9o76ZdvQC@kreacher> <283d4abe-885b-415d-a24d-681408a23845@linaro.org>
In-Reply-To: <283d4abe-885b-415d-a24d-681408a23845@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Nov 2023 13:31:41 +0100
Message-ID: <CAJZ5v0g3C=wV-4s+hFae5cNrTwLXdXScn40oEp6=Ju6-pKptPQ@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: core: Add trip thresholds for trip crossing detection
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
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

Hi Daniel,

On Mon, Nov 6, 2023 at 1:02 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
>
> On 03/11/2023 15:56, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The trip crossing detection in handle_thermal_trip() does not work
> > correctly in the cases when a trip point is crossed on the way up and
> > then the zone temperature stays above its low temperature (that is, its
> > temperature decreased by its hysteresis).  The trip temperature may
> > be passed by the zone temperature subsequently in that case, even
> > multiple times, but that does not count as the trip crossing as long as
> > the zone temperature does not fall below the trip's low temperature or,
> > in other words, until the trip is crossed on the way down.
> >
> > |-----------low--------high------------|
> >               |<--------->|
> >               |    hyst   |
> >               |           |
> >               |          -|--> crossed on the way up
> >               |
> >           <---|-- crossed on the way down
> >
> > However, handle_thermal_trip() will invoke thermal_notify_tz_trip_up()
> > every time the trip temperature is passed by the zone temperature on
> > the way up regardless of whether or not the trip has been crossed on
> > the way down yet.  Moreover, it will not call thermal_notify_tz_trip_down()
> > if the last zone temperature was between the trip's temperature and its
> > low temperature, so some "trip crossed on the way down" events may not
> > be reported.
> >
> > To address this issue, introduce trip thresholds equal to either the
> > temperature of the given trip, or its low temperature, such that if
> > the trip's threshold is passed by the zone temperature on the way up,
> > its value will be set to the trip's low temperature and
> > thermal_notify_tz_trip_up() will be called, and if the trip's threshold
> > is passed by the zone temperature on the way down, its value will be set
> > to the trip's temperature (high) and thermal_notify_tz_trip_down() will
> > be called.  Accordingly, if the threshold is passed on the way up, it
> > cannot be passed on the way up again until its passed on the way down
> > and if it is passed on the way down, it cannot be passed on the way down
> > again until it is passed on the way up which guarantees correct
> > triggering of trip crossing notifications.
> >
> > If the last temperature of the zone is invalid, the trip's threshold
> > will be set depending of the zone's current temperature: If that
> > temperature is above the trip's temperature, its threshold will be
> > set to its low temperature or otherwise its threshold will be set to
> > its (high) temperature.  Because the zone temperature is initially
> > set to invalid and tz->last_temperature is only updated by
> > update_temperature(), this is sufficient to set the correct initial
> > threshold values for all trips.
> >
> > Link: https://lore.kernel.org/all/20220718145038.1114379-4-daniel.lezcano@linaro.org
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 (RFC) -> v2: Add missing description of a new struct thermal_trip field.
> >
> > And because no comments have been sent for a week, this is not an RFC
> > any more.
>
> Can you give me a few days to review this patch and test it with some
> debugfs code planned to be submitted?

Sure, I'm not going to do anything with it until 6.7-rc1 is out anyway.

Thanks!
