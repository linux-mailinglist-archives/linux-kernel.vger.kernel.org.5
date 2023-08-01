Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E361476BD4D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjHATG1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Aug 2023 15:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjHATGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:06:13 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF92E2D67;
        Tue,  1 Aug 2023 12:06:08 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-56475c1b930so873390eaf.0;
        Tue, 01 Aug 2023 12:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690916768; x=1691521568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJCD2j3zR+hnBKx43FGldPbAuyAJyxcsTIbr0Mm4Ahg=;
        b=EgXH7TD62krs+K6rcOxSud/SXMVJDZl40aeO7sXwR+m0LZMtrzip3xbu2b8LUiSoY2
         X+OCq067trRV9ksnH1e0k5mvcy2KojG4TumFJky9TjZ58jIrMA47h9IAop8UZzIXPHQk
         cOvS5Ju6PeEHJUblEhpUI4ysPQh8peyd/uDTdhazV7GEGXAvwqZQiYlUKLRI8UAZHrgH
         LhCM/woaqUMPG207J6q1WZ2JQyLckbP3RLW2dYLds21yns6/vvKbxNhzONDzCCARqS0I
         7/vU16FgceBOWBvZagEe2ggSnovK8VJpKY8pYQwjpv3juCL4NnZKjWrnCcXY/VtWBcAp
         9/SA==
X-Gm-Message-State: ABy/qLbvUaW+WhloxQPXBth3XOFOE3bpRY9TWrCvwk4KCfqbWF83Nx9C
        Ft07C3uvoQBPNRiFnqERW1t4bK68p2mJSjCrvlo=
X-Google-Smtp-Source: APBJJlG3T9Q6+/TNk46zgubm/LFAOmSTHLFrwsZFJES1A+h4KnlW/gML4fqG8P40LStKCUN/vCzEjJZx7cAk1yyTbzs=
X-Received: by 2002:a4a:e251:0:b0:566:951e:140c with SMTP id
 c17-20020a4ae251000000b00566951e140cmr7170827oot.1.1690916767743; Tue, 01 Aug
 2023 12:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher>
 <4822145.GXAFRqVoOG@kreacher> <8ea6d9b1-f8a5-a899-ea30-7ec5d40a0c26@linaro.org>
In-Reply-To: <8ea6d9b1-f8a5-a899-ea30-7ec5d40a0c26@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Aug 2023 21:05:56 +0200
Message-ID: <CAJZ5v0inZBtyVrAvgQ1LaVxZkKZHQJJ7A86ysaMmSKKQ2vmGTw@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] thermal: core: Do not handle trip points with
 invalid temperature
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

On Tue, Aug 1, 2023 at 8:29 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 25/07/2023 14:06, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Trip points with temperature set to THERMAL_TEMP_INVALID are as good as
> > disabled, so make handle_thermal_trip() ignore them.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v2 -> v3: No changes.
> >
> > v1 -> v2: No changes.
> >
> > ---
> >   drivers/thermal/thermal_core.c |    3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -348,7 +348,8 @@ static void handle_thermal_trip(struct t
> >       struct thermal_trip trip;
> >
> >       /* Ignore disabled trip points */
> > -     if (test_bit(trip_id, &tz->trips_disabled))
> > +     if (test_bit(trip_id, &tz->trips_disabled) ||
> > +         trip.temperature == THERMAL_TEMP_INVALID)
> >               return;
>
> This will set the temperature to THERMAL_TEMP_INVALID at each thermal
> zone update.

What do you mean?

It doesn't set anything.

> It would make more sense to set it when setting the disabled bit at init
> time, no?
>
> But is that something we really want to do ? The trip point will be
> reordered due to the temperature change (-273°C)

Again, I'm not sure what you mean.
