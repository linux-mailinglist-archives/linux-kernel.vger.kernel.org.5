Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA0D7A781A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjITJzS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Sep 2023 05:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbjITJzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:55:07 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E18EEA;
        Wed, 20 Sep 2023 02:55:01 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5733d11894dso1143853eaf.0;
        Wed, 20 Sep 2023 02:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695203700; x=1695808500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjJLFT8aYZmJIG1InbR35s+9z4+ZwViYLByBPUHAjdo=;
        b=BBb5ag9Pj0Hcxu4vEjItLJlP7vFlsbU7gRkwFRK2psBu7O/tlz2PSlaA5gaGco3p+v
         L8p6CpyEjwDpgGHvP1UEPPP1cFKu7LZki3Rrh96CWn18ARHnqHZp1I42htUGFVQDEOGT
         yOiUUMD4jNSPXyMf0846l1Nor0gphZkW3dYyDJZMPoGyFZNu0hVXSjjnTUBLPX5CrQAm
         /7sUhysqbNne9OzXgPM8Ub5KME7UrMi2DPltmQk3Y5i9sDX0W8pm127MNEDLJbmHIJgU
         ma7X1v3jHzKPPlBTwsm9VAprj4NwAIrq5JWKGD5dvwKxl6lIStSzFmfu/XOdpHw8B1Ip
         LcjA==
X-Gm-Message-State: AOJu0YzbMIZKO+eQA7tWkBBENrveCh1wO5iCyarRrWuSjXMBTbVYztQn
        +oOyQmyvXBPlRq6Y8EKbThuQmUt2pD61wjVQfd052C2T
X-Google-Smtp-Source: AGHT+IFEbSPMkFJJ03xl80+Nht+U2FS4YWwbgo3FHlvuVLSjpIA63OpjiPyOEYLQdTQatBXjAXEin3+br44695wkh+s=
X-Received: by 2002:a4a:2a4e:0:b0:573:3a3b:594b with SMTP id
 x14-20020a4a2a4e000000b005733a3b594bmr1817199oox.1.1695203700711; Wed, 20 Sep
 2023 02:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <12296181.O9o76ZdvQC@kreacher> <ZQqpbSYsUdAZrcrT@shredder>
In-Reply-To: <ZQqpbSYsUdAZrcrT@shredder>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Sep 2023 11:54:48 +0200
Message-ID: <CAJZ5v0i2Fjq8V=fy4TODbQxC5dtFc+rwJ1fuE3PMZeMn0=ttGQ@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: core: Drop trips_disabled bitmask
To:     Ido Schimmel <idosch@nvidia.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 10:12 AM Ido Schimmel <idosch@nvidia.com> wrote:
>
> On Tue, Sep 19, 2023 at 08:54:37PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > After recent changes, thermal_zone_get_trip() cannot fail, as invoked
> > from thermal_zone_device_register_with_trips(), so the only role of
> > the trips_disabled bitmask is struct thermal_zone_device is to make
> > handle_thermal_trip() skip trip points whose temperature was initially
> > zero.  However, since the unit of temperature in the thermal core is
> > millicelsius, zero may very well be a valid temperature value at least
> > in some usage scenarios and the trip temperature may as well change
> > later.  Thus there is no reason to permanently disable trip points
> > with initial temperature equal to zero.
> >
> > Accordingly, drop the trips_disabled bitmask along with the code
> > related to it.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> I guess I was copied because of commit f1b80a3878b2 ("thermal: core:
> Restore behavior regarding invalid trip points").

That's correct.

> Since then we stopped
> relying on this behavior with commit 5601ef91fba8 ("mlxsw: core_thermal:
> Use static trip points for transceiver modules").
>
> Tested your patch and didn't see any regressions:
>
> Tested-by: Ido Schimmel <idosch@nvidia.com>

Thank you!
