Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A50751FEB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjGMLan convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 07:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbjGMLak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:30:40 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457A518E;
        Thu, 13 Jul 2023 04:30:39 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-98502b12fd4so17946066b.1;
        Thu, 13 Jul 2023 04:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689247838; x=1689852638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdSP6ezbFiKCfroZ5GX5zt/8h3KSlShTUnj+xRO1MX0=;
        b=aDMfvld0Ajhf8X3DQxGr9+CTBVW1lYUBMVE570P8XBstUwqnwF+VapnUTfmSunwWnS
         wJmKgBlZx5KTk6XWLFZMSd9iNEjKdv7XYAZHxIbxeno2O79tRDrpPF6ZCUvQ+hUG6AbM
         bbKOAaXMnbvBsEmK4LexCIsreGs6/4+j1hRAZJK3q0UmaMOw9Lm3/iJK/lP0KJMnEIBe
         qYDyHAviPAcdGx1tjVK77+wnVJGqLgSY46VFqnCTLpjdoaHFgHXl8U/nzs+MlCiEa5xr
         QRcizstT2sJsJX/Qqfn0isCKWZXolPkcaZzGnMdTBBhLKlTE362DgDccoA37nPwZsWN5
         +OLw==
X-Gm-Message-State: ABy/qLbJe/lVT/2VzfdYw5awL46M5bxXkE2tX8wbzD9OGlidDX5RSlCO
        niX4/kuYO1/w1tYR1cT/GoihCAL4KqZTOg+xh2s=
X-Google-Smtp-Source: APBJJlEzNhHSm7/nas6ZGwAjLZGhL0q93TMstSkMzTvTz6R71uHqjNwcqtmwYNUZpOhi5hSE7bPSkAWEwq2ez+7AKgA=
X-Received: by 2002:a17:906:73d3:b0:993:eed1:904 with SMTP id
 n19-20020a17090673d300b00993eed10904mr997537ejl.3.1689247837448; Thu, 13 Jul
 2023 04:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230707203731.848188-1-daniel.lezcano@linaro.org> <82b2d4dc-4583-925a-9e3c-77ae30d0d261@linaro.org>
In-Reply-To: <82b2d4dc-4583-925a-9e3c-77ae30d0d261@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Jul 2023 13:30:25 +0200
Message-ID: <CAJZ5v0iUyPjsyfcE6MB1gqeRvb8aM0d6TsrB1Oehw4p58SnFYQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] One more step to the thermal zone structure encapsulation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        thierry.reding@gmail.com, linux-kernel@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com
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

On Thu, Jul 13, 2023 at 11:33 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 07/07/2023 22:37, Daniel Lezcano wrote:
> > The series provides more changes to self-encapsulate the thermal zone device
> > structure in order to protect wild accesses to the thermal zone device
> > internals, especially the trip points and the locks.
> >
> > The first patch adds a macro to warn at compilation time if the
> > thermal_core.h is included in a file not belonging to the thermal core
> > code. One warning will happen with the nvidia drivers but this is in
> > the way to be solved.
> >
> > The second patch reorders the headers inclusion in the core code.
> >
> > The next patches makes the int340x drivers to use the thermal trip
> > update above and the different accessors for thermal zone structure.
> >
> > Daniel Lezcano (4):
> >    thermal/core: Hardening the self-encapsulation
> >    thermal/core: Reorder the headers inclusion
> >    thermal/drivers/int3400: Use thermal zone device wrappers
> >    thermal/drivers/int340x: Do not check the thermal zone state
> >
> >   drivers/thermal/gov_bang_bang.c               |  1 +
> >   drivers/thermal/gov_fair_share.c              |  1 +
> >   drivers/thermal/gov_power_allocator.c         |  7 +--
> >   drivers/thermal/gov_step_wise.c               |  1 +
> >   drivers/thermal/gov_user_space.c              |  1 +
> >   .../intel/int340x_thermal/int3400_thermal.c   | 44 +++++++++----------
> >   drivers/thermal/thermal_acpi.c                |  1 +
> >   drivers/thermal/thermal_core.c                |  7 +--
> >   drivers/thermal/thermal_core.h                |  4 ++
> >   drivers/thermal/thermal_helpers.c             |  1 +
> >   drivers/thermal/thermal_hwmon.c               |  1 +
> >   drivers/thermal/thermal_netlink.c             |  1 +
> >   drivers/thermal/thermal_of.c                  |  1 +
> >   drivers/thermal/thermal_sysfs.c               |  1 +
> >   drivers/thermal/thermal_trip.c                |  1 +
> >   15 files changed, 45 insertions(+), 28 deletions(-)
>
> Applied

OK
