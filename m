Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7D07C82BC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjJMKH0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Oct 2023 06:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjJMKHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:07:24 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B65A9;
        Fri, 13 Oct 2023 03:07:22 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-57b83ff7654so174576eaf.1;
        Fri, 13 Oct 2023 03:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697191642; x=1697796442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOcuhgIHNpTnqY6TaX7q3jq2KFxLbfHcdT+gFs7TbNI=;
        b=c2QJAUJ7IxbheoIZ7pu+1VfFgaazPbyALb208I3PUEBG/hyUBByH5L7ne0VpDOHoJ/
         DVSoGHC0SDjJ1YjS2oRM6b4/VrKh288RpYVofKGmVWTqxDZsuMhKshen0TuT0JrqJe7y
         WbpIReDDKSkv+rWlmswiB0Cauq+XP/i1gvKiY/FawBxXL6s+3WqU9xPX5NhHVHGHqVBq
         zJyx/bMHGdot+8lg0j8VECF1kI6UckznT14xM367Q69JQrgikQVvwQjvipkeYiL3LIaP
         MyboyN2bP2RKHqV//LsnZFLs9UTO93qcUcrSc1knd8JtezPjwCY5E+VGZAFnpV9Cwgjb
         aYxw==
X-Gm-Message-State: AOJu0YwGjKwWl3U56hKost3j0TNK+wJy+T/3wSpj8NVQOk7Ks0yH+tWu
        7NZIR459ibad2AAxs9+8vIbYTcZINycYfq7jJBE=
X-Google-Smtp-Source: AGHT+IE3ltssHVi9lRFRJx599Yz5q4IJ63qNWs7X8wpW3568bijOEJvvmsnCF5DLB0UQCGHLOtGZH6/rTbHs9RNf7uc=
X-Received: by 2002:a4a:b588:0:b0:578:c2af:45b5 with SMTP id
 t8-20020a4ab588000000b00578c2af45b5mr24853795ooo.0.1697191641719; Fri, 13 Oct
 2023 03:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <13365827.uLZWGnKmhe@kreacher> <0f6d3d0a-3685-4a0c-b922-b5aa72f20b19@arm.com>
In-Reply-To: <0f6d3d0a-3685-4a0c-b922-b5aa72f20b19@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 13 Oct 2023 12:07:09 +0200
Message-ID: <CAJZ5v0gHYAXDPxOVSuFTz0YSm5NRGsP0HqvvFsvqUXZ3OUMjDw@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] thermal: core: Pass trip pointers to governor
 .throttle() callbacks
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Fri, Oct 13, 2023 at 10:12 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Rafael,
>
>
> On 10/6/23 18:38, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > While working on https://lore.kernel.org/linux-pm/4846448.GXAFRqVoOG@kreacher/
> > I started to change thermal governors so as to reduce the usage of trip
> > indices in them.  At that time, I was concerned that they could not be
> > replaced with trip pointers overall, because they were needed in certain
> > situations (tracing, debug messages, userspace governor) and computing them
> > whenever they were needed would be extra overhead with relatively weak
> > justification.  In the meantime, however, I realized that for a given trip
> > pointer, it is actually trivial to compute the corresponding index: it is
> > sufficient to subtract the start of the trips[] table in the thermal zone
> > containing the trip from that trip pointer for this purpose.  Patch [1/6]
> > modifies thermal_zone_trip_id() in accordance with this observation.
> >
> > Now that the cost of computing a trip index for a given trip pointer and
> > thermal zone is not a concern any more, the governors can be generally
> > switched over to using trip pointers for representing trips.  One of the
> > things they need to do sometimes, though, is to iterate over trips in a
> > given thermal zone (the core needs to do that too, of course) and
> > for_each_thermal_trip() is somewhat inconvenient for this purpose, because
> > it requires callback functions to be defined and in some cases new data
> > types need to be introduced just in order to use it.  For this reason,
> > patch [2/6] adds a macro for iterating over trip points in a given thermal
> > zone with the help of a trip pointer and changes for_each_thermal_trip() to
> > use that macro internally.
> >
> > Patches [3-5/6] change individual governors to prepare them for using trip
> > pointers everywhere for representing trips, except for the trip argument of
> > the .throttle() callback and patch [6/6] finally changes the .throttle()
> > callback definition so that it takes a trip pointer as the argument
> > representing the trip.
> >
> > Please refer to the individual patch changelogs for details.
> >
> > Thanks!
> >
> >
> >
>
> I have issues to apply this series, could you tell me the best
> base branch from your tree?
>
> I will give it a try on my boards and review.

It is there in the thermal-core branch of linux-pm.git.

Thanks!
