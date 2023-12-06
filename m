Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA882807AAF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377272AbjLFVnW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 16:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377221AbjLFVnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:43:19 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC21D3;
        Wed,  6 Dec 2023 13:43:24 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1fb00ea5e5fso43360fac.1;
        Wed, 06 Dec 2023 13:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701899004; x=1702503804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAy8WXK1y/31ZcmDbDHvravRz16tZjNVV5jZfuVw9MU=;
        b=sLHm/jJgT6oxCuqinKO2dc+uq2hnVYPvIbnoxtROIyRuNyczckm+JaaOQ94arphigK
         n2rzvcOu3L1OyzzmaQYIab69c+0s+icEbwgeS6VQR8OuWNGOwnsVq3YSacz7opWLljfW
         SdnVg1wnzX0/LV5+TFDuTeWAyzrI2DIl/enpsYU6K3erUgkJ0aygHyT52PBgISbJf/wf
         RwDoOLENZC38CQ0Pwp96SlPzl4s9HTGBEm7zzNsxiSMjG8+WVo0xPygkf8QNDA7+Imqi
         bplabhKt+nk4LD6O4iUTXQRWkF5XufjQoC0LQY3dlNcXoXBvF5IgejhN/3GXkkujuRoL
         QcWw==
X-Gm-Message-State: AOJu0Yx3L6kvezf85Xj2DumCVxDqlf0Sj9GJxkbmvkajwHjsA71O+WEA
        2ZoMAy+oJDuR4RYLcGf0RUa+7gGcpEiB3WxBCxGyseWQ
X-Google-Smtp-Source: AGHT+IGX2SjeOPKr1wRijnA9TN18mHSGLHqXZ3IQkI3BDTgkcXhuM3GPNRv3zCMC0LUMS0RrAQU5jlMdb+rUCGv5z0Q=
X-Received: by 2002:a05:6870:b4a0:b0:1fb:5e42:5096 with SMTP id
 y32-20020a056870b4a000b001fb5e425096mr2731765oap.5.1701899004068; Wed, 06 Dec
 2023 13:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20231110181123.2389186-1-daniel.lezcano@linaro.org>
In-Reply-To: <20231110181123.2389186-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Dec 2023 22:43:13 +0100
Message-ID: <CAJZ5v0h8CTbDrq1wUOMpKpnKs6Ey7H1onkfKGRS15Gj_AnepAg@mail.gmail.com>
Subject: Re: [RFC PATCH] thermal/debugfs: Add thermal debugfs information
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
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

On Fri, Nov 10, 2023 at 8:37 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The thermal framework does not have any debug information except a
> sysfs stat which is a bit controversial. This one allocates big chunks
> of memory for every cooling devices with a high number of states and
> could represent on some systems in production several megabytes of
> memory for just a portion of it. As the syfs is limited to a page
> size, the output is not exploitable with large data array and gets
> truncated.
>
> The patch provides the same information than sysfs except the
> transitions are dynamically allocated, thus they won't show more
> events than the ones which actually occured. There is no longer a size

occurred

> limitation and it opens the field for more debugging information where
> the debugfs is designed for, not sysfs.
>
> On the thermal zone temperature side, the mitigation episodes are
> recorded. A mitigation episode happens when the first trip point is
> crossed the way up and then the way down. During this episode other
> trip points can be crossed also and are accounted for this mitigation
> episode. The interesting information is the average temperature at the
> trip point, the undershot and the overshot. The standard deviation of
> the mitigated temperature will be added later.
>
> The thermal debugfs directory structure tries to stay consistent with
> the sysfs one but in a very simplified way:
>
> thermal/
> |-- cooling_devices
> |   |-- 0
> |   |   |-- reset
> |   |   |-- time_in_state_ms
> |   |   |-- total_trans
> |   |   `-- trans_table
> |   |-- 1
> |   |   |-- reset
> |   |   |-- time_in_state_ms
> |   |   |-- total_trans
> |   |   `-- trans_table
> |   |-- 2
> |   |   |-- reset
> |   |   |-- time_in_state_ms
> |   |   |-- total_trans
> |   |   `-- trans_table
> |   |-- 3
> |   |   |-- reset
> |   |   |-- time_in_state_ms
> |   |   |-- total_trans
> |   |   `-- trans_table
> |   `-- 4
> |       |-- reset
> |       |-- time_in_state_ms
> |       |-- total_trans
> |       `-- trans_table
> `-- thermal_zones
>     |-- 0
>     |   `-- mitigations
>     `-- 1
>         `-- mitigations
>
> The content of the files in the cooling devices directory is the same
> as the sysfs one except for the trans_table which has the following
> format:
>
> Transition      Hits
> 1->0            246
> 0->1            246
> 2->1            632
> 1->2            632
> 3->2            98
> 2->3            98
>
> And finally the content of the mitigations file has the following
> format:
>
> ,-Mitigation at 349988258us, duration=130136ms
> | trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |
> |    0 |  passive |     65000 |      2000 |     130136 |     68227 |     62500 |     75625 |
> |    1 |  passive |     75000 |      2000 |     104209 |     74857 |     71666 |     77500 |
> ,-Mitigation at 272451637us, duration=75000ms
> | trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |
> |    0 |  passive |     65000 |      2000 |      75000 |     68561 |     62500 |     75000 |
> |    1 |  passive |     75000 |      2000 |      60714 |     74820 |     70555 |     77500 |
> ,-Mitigation at 238184119us, duration=27316ms
> | trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |
> |    0 |  passive |     65000 |      2000 |      27316 |     73377 |     62500 |     75000 |
> |    1 |  passive |     75000 |      2000 |      19468 |     75284 |     69444 |     77500 |
> ,-Mitigation at 39863713us, duration=136196ms
> | trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |
> |    0 |  passive |     65000 |      2000 |     136196 |     73922 |     62500 |     75000 |
> |    1 |  passive |     75000 |      2000 |      91721 |     74386 |     69444 |     78125 |
>
> More information for a better understanding of the thermal behavior
> will be added after. The idea is to give detailed statistics
> information about the undershots and overshots, the temperature speed,
> etc... As all the information in a single file is too much, the idea
> would be to create a directory named with the mitigation timestamp
> where all data could be added.
>
> Please note this code is immune against trip ordering.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/Kconfig           |   7 +
>  drivers/thermal/Makefile          |   3 +
>  drivers/thermal/thermal_core.c    |  23 +-
>  drivers/thermal/thermal_core.h    |   1 +
>  drivers/thermal/thermal_debugfs.c | 679 ++++++++++++++++++++++++++++++
>  drivers/thermal/thermal_debugfs.h |  23 +
>  drivers/thermal/thermal_helpers.c |  27 +-
>  include/linux/thermal.h           |   7 +
>  8 files changed, 758 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/thermal/thermal_debugfs.c
>  create mode 100644 drivers/thermal/thermal_debugfs.h
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index c81a00fbca7d..b78800e512a8 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -33,6 +33,13 @@ config THERMAL_STATISTICS
>
>           If in doubt, say N.
>
> +config THERMAL_DEBUGFS
> +       bool "Thermal debugging file system"

This isn't really a file system

I'd just say "Thermal subsystem debug support"

> +       depends on DEBUG_FS
> +       help
> +         This option provides a debugfs entry giving useful
> +         information about the thermal framework internals.

And here "Say Y to allow the thermal subsystem to collect diagnostic
information that can be accessed via debugfs."

> +
>  config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
>         int "Emergency poweroff delay in milli-seconds"
>         default 0
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index c934cab309ae..234f19f7efe3 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -10,6 +10,9 @@ thermal_sys-y                 += thermal_trip.o thermal_helpers.o
>  # netlink interface to manage the thermal framework
>  thermal_sys-$(CONFIG_THERMAL_NETLINK)          += thermal_netlink.o
>
> +# debugfs interface to investigate the behavior and statistics

I'm not sure about the value of this comment.

> +thermal_sys-$(CONFIG_THERMAL_DEBUGFS)  += thermal_debugfs.o
> +
>  # interface to/from other layers providing sensors
>  thermal_sys-$(CONFIG_THERMAL_HWMON)            += thermal_hwmon.o
>  thermal_sys-$(CONFIG_THERMAL_OF)               += thermal_of.o
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 3fe9232e355d..635cd08882c8 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -355,17 +355,17 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
>                 if (tz->temperature >= trip->temperature)
>                         trip->threshold -= trip->hysteresis;
>         } else {
> +               int trip_id = thermal_zone_trip_id(tz, trip);
> +
>                 if (tz->last_temperature < trip->threshold &&
>                     tz->temperature >= trip->threshold) {
> -                       thermal_notify_tz_trip_up(tz->id,
> -                                                 thermal_zone_trip_id(tz, trip),
> -                                                 tz->temperature);
> +                       thermal_notify_tz_trip_up(tz->id, trip_id, tz->temperature);
> +                       thermal_debugfs_handle_way_up(tz, trip_id, tz->temperature);

I would prefer to pass trip here (I have a similar change for
thermal_notify_tz_trip_up() in the works) and why not just call it
thermal_debug_tz_trip_up()?  And _tz_trip_down() for consistency
below?

Also if tz is passed, tz->temperature can be retrieved by the function
itself, so no need to pass it.

>                         trip->threshold = trip->temperature - trip->hysteresis;
>                 } else if (tz->last_temperature >= trip->threshold &&
>                            tz->temperature < trip->threshold) {
> -                       thermal_notify_tz_trip_down(tz->id,
> -                                                   thermal_zone_trip_id(tz, trip),
> -                                                   tz->temperature);
> +                       thermal_notify_tz_trip_down(tz->id, trip_id, tz->temperature);
> +                       thermal_debugfs_handle_way_down(tz, trip_id, tz->temperature);

Same here.

>                         trip->threshold = trip->temperature;
>                 }
>         }
> @@ -395,6 +395,7 @@ static void update_temperature(struct thermal_zone_device *tz)
>         trace_thermal_temperature(tz);
>
>         thermal_genl_sampling_temp(tz->id, temp);
> +       thermal_debugfs_update_temp(tz);

thermal_debug_update_temp()?

>  }
>
>  static void thermal_zone_device_init(struct thermal_zone_device *tz)
> @@ -923,6 +924,8 @@ __thermal_cooling_device_register(struct device_node *np,
>
>         mutex_unlock(&thermal_list_lock);
>
> +       thermal_debugfs_cdev_register(cdev);

I'd call this thermal_debug_cdev_add(), and the one below analogously.

> +
>         return cdev;
>
>  out_cooling_dev:
> @@ -1129,6 +1132,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>         if (!cdev)
>                 return;
>
> +       thermal_debugfs_cdev_unregister(cdev);
> +
>         mutex_lock(&thermal_list_lock);
>
>         if (!thermal_cooling_device_present(cdev)) {
> @@ -1370,6 +1375,8 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>
>         thermal_notify_tz_create(tz->id, tz->type);
>
> +       thermal_debugfs_tz_register(tz);

thermal_debug_tz_add() ?  And __debug_tz_remove() below?

> +
>         return tz;
>
>  unregister:
> @@ -1435,6 +1442,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>         if (!tz)
>                 return;
>
> +       thermal_debugfs_tz_unregister(tz);
> +
>         tz_id = tz->id;
>
>         mutex_lock(&thermal_list_lock);
> @@ -1548,6 +1557,8 @@ static int __init thermal_init(void)
>  {
>         int result;
>
> +       thermal_debugfs_init();
> +
>         result = thermal_netlink_init();
>         if (result)
>                 goto error;
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 0a3b3ec5120b..809d37d0aa28 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -13,6 +13,7 @@
>  #include <linux/thermal.h>
>
>  #include "thermal_netlink.h"
> +#include "thermal_debugfs.h"
>
>  /* Default Thermal Governor */
>  #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)

The change below is large and rather hard to grasp as a whole.

It would be easier to process if it is split into a few smaller
changes building on top of each other IMO.

Personally, I would start with stubs of the functions that are called
from the core and subsequently add more and more code to them.

> diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
> new file mode 100644
> index 000000000000..4053fd2fe16f
> --- /dev/null
> +++ b/drivers/thermal/thermal_debugfs.c
> @@ -0,0 +1,679 @@

[cut]
