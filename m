Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E4F76BCA8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjHASkg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Aug 2023 14:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjHASke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:40:34 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B77268E;
        Tue,  1 Aug 2023 11:40:09 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-56c9f7830c2so333245eaf.0;
        Tue, 01 Aug 2023 11:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915188; x=1691519988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJ1fhbjpQoUWJT3y2RKGjKyUCNoTdwOyxERwVOCkTxo=;
        b=N6gu8jE5JuuhvFAYbXXxxUstouZk5wB6+Gf+kpZPpN+U2jHKlKMnTgRghK0FxzvSBT
         tbsXzIE+j5m9FAQ23GPFhGrmER6VsTXuGhCMccTbZsD81vJukJQWe3a+G6ShqWGkX2G3
         99hXVO61woFfn1tofZnUvwa9rwrYgNGvnMe6XB+mBgWbKB4cy0PB4G4HxwGBulgHX+Qy
         7V8elqI5AENWpJX1b1/yaUxwGnGqeOKYsUv2vVDYrtN50OkXsuCnSxggJ6h8KD9tfLdL
         Gf0DqPJ5nnU+Oy2wZHpXTEFWEBKugtY+3/ahH5ceNBbCgltvZiYdrUz0AyGwXZ7gf8mx
         Y1NA==
X-Gm-Message-State: ABy/qLaHZqak5cP4DYixqgmafeSjx5tPHaOfRHv4dHSx0gSpNxRPkg0Y
        5bFPU5llSiR95sDQkIxJQbSSBdk4gbJl1Fadpro=
X-Google-Smtp-Source: APBJJlEYNeQWwYNjM3S5UGIXL9wfbs//d2C8oFPBCLE8r61i/VBaBggtYASvgmQe9RctlGfL9l57JU8piJoIGVsllbg=
X-Received: by 2002:a05:6820:1686:b0:56c:5e21:c730 with SMTP id
 bc6-20020a056820168600b0056c5e21c730mr9457475oob.1.1690915187929; Tue, 01 Aug
 2023 11:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher> <728e22ab-f68c-a891-f4d0-3d66cd03e9ec@linaro.org>
In-Reply-To: <728e22ab-f68c-a891-f4d0-3d66cd03e9ec@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Aug 2023 20:39:36 +0200
Message-ID: <CAJZ5v0hdFFnx2kUuVN+Quytw+tz2qsNtQstOOreoFKQ3aMv3Gw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] ACPI: thermal: Use trip point table to register
 thermal zones
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

On Tue, Aug 1, 2023 at 8:27 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> On 25/07/2023 14:02, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > This is the second iteration of the $subject patch series and its original
> > description below is still applicable
> >
> > On Tuesday, July 18, 2023 8:01:20 PM CEST Rafael J. Wysocki wrote:
> >>
> >> This patch series makes the ACPI thermal driver register thermal zones
> >> with the help of thermal_zone_device_register_with_trips(), so it
> >> doesn't need to use the thermal zone callbacks related to trip points
> >> any more (and they are dropped in the last patch).
> >>
> >> The approach presented here is quite radically different from the
> >> previous attempts, as it doesn't really rearrange the driver's
> >> internal data structures, but adds the trip table support on top of
> >> them.  For this purpose, it uses an additional field in struct thermal_trip
> >> introduced in the first patch.
> >
> > This update is mostly related to the observation that the critical and hot trip
> > points never change after initialization, so they don't really need to be
> > connected back to the corresponding thermal_trip structures.  It also fixes
> > an error code path memory leak in patch [5/8].
>
> I've been through the series. It is really cool that we can get rid of
> the ops usage at the end of the series.
>
> However, the series introduces a wrapper to the thermal zone lock and
> exports that in the public header. That goes in the opposite direction
> of the recent cleanups and obviously will give the opportunity to
> drivers to do silly things [again].

Because it is necessary to update the trip points in the table under
the zone lock, the driver needs to somehow make that happen.

I suppose I can pass a callback to thermal_zone_device_update() or
similar, but I'm not sure if that's better.

> On the other side, the structure thermal_trip introduces a circular
> reference, which is usually something to avoid.

What do you mean by "a circular reference"?

> Apart those two points, the ACPI changes look ok.
>
> Comments in the different patches will follow

Thanks!
