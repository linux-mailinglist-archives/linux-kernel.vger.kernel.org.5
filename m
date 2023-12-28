Return-Path: <linux-kernel+bounces-12852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9127681FB2B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06544B23F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B112B10795;
	Thu, 28 Dec 2023 20:18:39 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3710510780;
	Thu, 28 Dec 2023 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6dc08cc6b9cso96503a34.1;
        Thu, 28 Dec 2023 12:18:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703794716; x=1704399516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5tkneLwW2X8RQJXfG2chdOGqSWhBQMGM3cbgDxJc80=;
        b=bFtfYsREXynNseFv3dXoZSM+tY0IhrrvrjFHXiZOI1VaZCW9EVqdcZ0AsYwOdBziaL
         fsqDpL5/POXMF8MtfZKfEwIzPy+Od71PacSPIy6A+g5PQ8Fl3xhCcK/wgdKEgaiWMniy
         WtjOhHPdAvl7fXS6nJ61ADcdqzPfQvn6Yfu2TBp6CXurL7mNzqQx0Lm8MTJGQnSRjhI5
         jdBdAEWa5Gw8QZxjfWIkd8gz3DxMcm1zhXRSQUj866me4Zh4eXIcSkfI0IKEuEwv9PNh
         5aK3RcA3AxbI/hFanBvXEfyvA/ODjvDfFviJo2sIfvZnFM5kGPRX23TyRziMgsJVqaT2
         YWTg==
X-Gm-Message-State: AOJu0YxXL6D5r7nGATPVdbiGukbZlVcR0GFUcGTWWdVlBY7Rr5bQ3X6y
	0RABWiZxtZil1+Zi5LtsgbeZIF0wLO0vz3QYePk=
X-Google-Smtp-Source: AGHT+IFAH5M4YANKdsVNETuP4FfYtXeZpGYEDd3I/+Jhr1eJ4fAeiDNIFF5Oyu77MpOzdUoHbC5MK1I3wgnd5DIFRc8=
X-Received: by 2002:a05:6820:1f90:b0:594:8f66:bca8 with SMTP id
 eq16-20020a0568201f9000b005948f66bca8mr9836004oob.0.1703794716081; Thu, 28
 Dec 2023 12:18:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227104532.2671761-1-daniel.lezcano@linaro.org> <20231227104532.2671761-2-daniel.lezcano@linaro.org>
In-Reply-To: <20231227104532.2671761-2-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 28 Dec 2023 21:18:24 +0100
Message-ID: <CAJZ5v0g0BEF3-UbjqFTEHOkggLvK=4AiYnS-Bnd5xbCNH77VFQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] thermal/debugfs: Add thermal debugfs information
 for mitigation episodes
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, lukasz.luba@arm.com, rui.zhang@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 11:46=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The mitigation episodes are recorded. A mitigation episode happens
> when the first trip point is crossed the way up and then the way
> down. During this episode other trip points can be crossed also and
> are accounted for this mitigation episode. The interesting information
> is the average temperature at the trip point, the undershot and the
> overshot. The standard deviation of the mitigated temperature will be
> added later.
>
> The thermal debugfs directory structure tries to stay consistent with
> the sysfs one but in a very simplified way:
>
> thermal/
>  `-- thermal_zones
>      |-- 0
>      |   `-- mitigations
>      `-- 1
>          `-- mitigations
>
> The content of the mitigations file has the following format:
>
> ,-Mitigation at 349988258us, duration=3D130136ms
> | trip |     type | temp(=C2=B0mC) | hyst(=C2=B0mC) |  duration  |  avg(=
=C2=B0mC) |  min(=C2=B0mC) |  max(=C2=B0mC) |
> |    0 |  passive |     65000 |      2000 |     130136 |     68227 |     =
62500 |     75625 |
> |    1 |  passive |     75000 |      2000 |     104209 |     74857 |     =
71666 |     77500 |
> ,-Mitigation at 272451637us, duration=3D75000ms
> | trip |     type | temp(=C2=B0mC) | hyst(=C2=B0mC) |  duration  |  avg(=
=C2=B0mC) |  min(=C2=B0mC) |  max(=C2=B0mC) |
> |    0 |  passive |     65000 |      2000 |      75000 |     68561 |     =
62500 |     75000 |
> |    1 |  passive |     75000 |      2000 |      60714 |     74820 |     =
70555 |     77500 |
> ,-Mitigation at 238184119us, duration=3D27316ms
> | trip |     type | temp(=C2=B0mC) | hyst(=C2=B0mC) |  duration  |  avg(=
=C2=B0mC) |  min(=C2=B0mC) |  max(=C2=B0mC) |
> |    0 |  passive |     65000 |      2000 |      27316 |     73377 |     =
62500 |     75000 |
> |    1 |  passive |     75000 |      2000 |      19468 |     75284 |     =
69444 |     77500 |
> ,-Mitigation at 39863713us, duration=3D136196ms
> | trip |     type | temp(=C2=B0mC) | hyst(=C2=B0mC) |  duration  |  avg(=
=C2=B0mC) |  min(=C2=B0mC) |  max(=C2=B0mC) |
> |    0 |  passive |     65000 |      2000 |     136196 |     73922 |     =
62500 |     75000 |
> |    1 |  passive |     75000 |      2000 |      91721 |     74386 |     =
69444 |     78125 |
>
> More information for a better understanding of the thermal behavior
> will be added after. The idea is to give detailed statistics
> information about the undershots and overshots, the temperature speed,
> etc... As all the information in a single file is too much, the idea
> would be to create a directory named with the mitigation timestamp
> where all data could be added.
>
> Please note this code is immune against trip ordering but not against
> a trip temperature change while a mitigation is happening. However,
> this situation should be extremely rare, perhaps not happening and we
> might question ourselves if something should be done in the core
> framework for other components first.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> Changelog:
>   - v5
>     - No changes
>   - v4
>     - Reworded "trip violation" (Rafael)
>     - Reworded some comments and clarified other ones (Rafael)
>     - Renamed s/tz/tz_dbg/ for clarity (Rafael)
>     - Used flexible array and struct_size for allocation (Rafael)
>     - Renamed s/dfs/thermal_dbg/ for clarity (Rafael)
>     - Used intermediate variable to prevent dereferencing multiple times =
a structure (Rafael)
>     - Renamed variable s/trip/trip_id/ (Rafael)
>     - Clarified trip_index usage in the comment (Rafael)
>   - v3
>     - Fixed kerneldoc (kbuild)
>     - Fixed wrong indentation s/<space>/<tab>/
>   - v2
>     - Applied changes based on comments from patch 1/2
>     - Constified structure in function parameters
>   - v1 (from RFC):
>     - Replaced exported function name s/debugfs/debug/
>     - Used "struct thermal_trip" parameter instead of "trip_id"
>     - Renamed handle_way_[up|down] by tz_trip_[up|down]
>     - Replaced thermal_debug_tz_[unregister|register] by [add|remove]
> ---
>  drivers/thermal/thermal_core.c    |   7 +
>  drivers/thermal/thermal_debugfs.c | 383 +++++++++++++++++++++++++++++-
>  drivers/thermal/thermal_debugfs.h |  14 ++
>  3 files changed, 403 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 33332d401b13..a0cbe8d7b945 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -367,6 +367,7 @@ static void handle_thermal_trip(struct thermal_zone_d=
evice *tz,
>                         thermal_notify_tz_trip_up(tz->id,
>                                                   thermal_zone_trip_id(tz=
, trip),
>                                                   tz->temperature);
> +                       thermal_debug_tz_trip_up(tz, trip);
>                         trip->threshold =3D trip->temperature - trip->hys=
teresis;
>                 } else {
>                         trip->threshold =3D trip->temperature;
> @@ -386,6 +387,7 @@ static void handle_thermal_trip(struct thermal_zone_d=
evice *tz,
>                         thermal_notify_tz_trip_down(tz->id,
>                                                     thermal_zone_trip_id(=
tz, trip),
>                                                     tz->temperature);
> +                       thermal_debug_tz_trip_down(tz, trip);
>                         trip->threshold =3D trip->temperature;
>                 } else {
>                         trip->threshold =3D trip->temperature - trip->hys=
teresis;
> @@ -417,6 +419,7 @@ static void update_temperature(struct thermal_zone_de=
vice *tz)
>         trace_thermal_temperature(tz);
>
>         thermal_genl_sampling_temp(tz->id, temp);
> +       thermal_debug_update_temp(tz);
>  }
>
>  static void thermal_zone_device_init(struct thermal_zone_device *tz)
> @@ -1396,6 +1399,8 @@ thermal_zone_device_register_with_trips(const char =
*type, struct thermal_trip *t
>
>         thermal_notify_tz_create(tz->id, tz->type);
>
> +       thermal_debug_tz_add(tz);
> +
>         return tz;
>
>  unregister:
> @@ -1461,6 +1466,8 @@ void thermal_zone_device_unregister(struct thermal_=
zone_device *tz)
>         if (!tz)
>                 return;
>
> +       thermal_debug_tz_remove(tz);
> +
>         tz_id =3D tz->id;
>
>         mutex_lock(&thermal_list_lock);
> diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_=
debugfs.c
> index 84e5ef3dc16c..0f0f0e603428 100644
> --- a/drivers/thermal/thermal_debugfs.c
> +++ b/drivers/thermal/thermal_debugfs.c
> @@ -14,8 +14,11 @@
>  #include <linux/mutex.h>
>  #include <linux/thermal.h>
>
> +#include "thermal_core.h"
> +
>  static struct dentry *d_root;
>  static struct dentry *d_cdev;
> +static struct dentry *d_tz;
>
>  /*
>   * Length of the string containing the thermal zone id or the cooling
> @@ -81,22 +84,87 @@ struct cdev_record {
>          };
>  };
>
> +/**
> + * struct trip_stats - Thermal trip statistics
> + *
> + * The trip_stats structure has the relevant information to show the
> + * statistics related to temperature going above a trip point.
> + *
> + * @timestamp: the trip crossing timestamp
> + * @duration: total time when the zone temperature was above the trip po=
int
> + * @count: the number of times the zone temperature was above the trip p=
oint
> + * @max: maximum recorded temperature above the trip point
> + * @min: minimum recorded temperature above the trip point
> + * @avg: average temperature above the trip point
> + */
> +struct trip_stats {
> +       ktime_t timestamp;
> +       ktime_t duration;
> +       int count;
> +       int max;
> +       int min;
> +       int avg;
> +};
> +
> +/**
> + * struct tz_events - Collection of all mitigation episodes for a therma=
l zone
> + *
> + * The tz_events structure describes a mitigation episode.

This sentence kind of contradicts the one-line description above: if
it represents one episode (which I think is the case), it cannot be a
collection of all of them at the same time.

Also, I still think that the name of this structure is not quite
adequate, because it is not clear what events it refers to.  It would
be better to call it tz_episode, for example.

> + * A mitigation episode is when the mitigation begins and ends. During
> + * this episode we can have multiple trip points crossed the way up
> + * and down if there are multiple trip describes in the firmware.
> + *
> + * @timestamp: First trip point crossed the way up
> + * @duration: total duration of the mitigation episode
> + * @node: a list element to be added to the list of tz events
> + * @trip_stats: per trip point statistics, flexible array
> + */
> +struct tz_events {
> +       ktime_t timestamp;
> +       ktime_t duration;
> +       struct list_head node;
> +       struct trip_stats trip_stats[];
> +};
> +
> +/**
> + * struct tz_debugfs - Store all mitigations episodes for a thermal zone
> + *
> + * The tz_debugfs structure contains the list of the mitigation
> + * episodes and has to track which trip point has been crossed in
> + * order to handle correctly nested trip point mitigation episodes.
> + *
> + * We keep the history of the trip point crossed in an array and as we
> + * can go back and forth inside this history, eg. trip 0,1,2,1,2,1,0,
> + * we keep track of the current position in the history array.
> + *
> + * @tz_events: a list of thermal mitigation episodes

The name of this field could be more specific IMO, like "mitigations".
As is, the connection between the "events" (whatever they are) and
mitigation episodes for the given tz is not clear.

> + * @trips_crossed: an array of trip points crossed by id
> + * @trip_index: the current trip point index in the trip points history
> + */
> +struct tz_debugfs {
> +       struct list_head tz_events;
> +       int *trips_crossed;
> +       int trip_index;
> +};

As mentioned earlier, thermal_debug_tz_trip_down() assumes that the
temperature ordering of trip points will not change during a
mitigation episode, which is not guaranteed in general and the
assumption is not even necessary.

To avoid making this assumption, I would instead make
thermal_debug_tz_trip_down() always walk trips_crossed[] top-down
until the trip passed to it is found (see below) and I would use
nr_trips ("the number of trips engaged so far in the current
mitigation episode").

> +
>  /**
>   * struct thermal_debugfs - High level structure for a thermal object in=
 debugfs
>   *
>   * The thermal_debugfs structure is the common structure used by the
> - * cooling device to compute the statistics.
> + * cooling device or the thermal zone to store the statistics.
>   *
>   * @d_top: top directory of the thermal object directory
>   * @lock: per object lock to protect the internals
>   *
>   * @cdev: a cooling device debug structure
> + * @tz: a thermal zone debug structure

These are cdev_dbg and tz_dbg now.

>   */
>  struct thermal_debugfs {
>         struct dentry *d_top;
>         struct mutex lock;
>         union {
>                 struct cdev_debugfs cdev_dbg;
> +               struct tz_debugfs tz_dbg;
>         };
>  };
>
> @@ -107,6 +175,10 @@ void thermal_debug_init(void)
>                 return;
>
>         d_cdev =3D debugfs_create_dir("cooling_devices", d_root);
> +       if (!d_cdev)
> +               return;
> +
> +       d_tz =3D debugfs_create_dir("thermal_zones", d_root);
>  }
>
>  static struct thermal_debugfs *thermal_debugfs_add_id(struct dentry *d, =
int id)
> @@ -443,3 +515,312 @@ void thermal_debug_cdev_remove(struct thermal_cooli=
ng_device *cdev)
>
>         mutex_unlock(&thermal_dbg->lock);
>  }
> +
> +static struct tz_events *thermal_debugfs_tz_event_alloc(struct thermal_z=
one_device *tz,
> +                                                       ktime_t now)
> +{
> +       struct tz_events *tze;
> +       int i;
> +
> +       tze =3D kzalloc(struct_size(tze, trip_stats, tz->num_trips), GFP_=
KERNEL);
> +       if (!tze)
> +               return NULL;
> +
> +       INIT_LIST_HEAD(&tze->node);
> +       tze->timestamp =3D now;
> +
> +       for (i =3D 0; i < tz->num_trips; i++) {
> +               tze->trip_stats[i].min =3D INT_MAX;
> +               tze->trip_stats[i].max =3D INT_MIN;
> +       }
> +
> +       return tze;
> +}
> +
> +void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
> +                             const struct thermal_trip *trip)
> +{
> +       struct tz_events *tze;
> +       struct tz_debugfs *tz_dbg;
> +       struct thermal_debugfs *thermal_dbg =3D tz->debugfs;
> +       int temperature =3D tz->temperature;
> +       int trip_id =3D thermal_zone_trip_id(tz, trip);
> +       ktime_t now =3D ktime_get();
> +
> +       if (!thermal_dbg)
> +               return;
> +
> +       mutex_lock(&thermal_dbg->lock);
> +
> +       tz_dbg =3D &thermal_dbg->tz_dbg;
> +
> +       /*
> +        * The mitigation is starting. A mitigation can contain
> +        * several episodes where each of them is related to a
> +        * temperature crossing a trip point. The episodes are
> +        * nested. That means when the temperature is crossing the
> +        * first trip point, the duration begins to be measured. If
> +        * the temperature continues to increase and reaches the
> +        * second trip point, the duration of the first trip must be
> +        * also accumulated.
> +        *
> +        * eg.
> +        *
> +        * temp
> +        *   ^
> +        *   |             --------
> +        * trip 2         /        \         ------
> +        *   |           /|        |\      /|      |\
> +        * trip 1       / |        | `----  |      | \
> +        *   |         /| |        |        |      | |\
> +        * trip 0     / | |        |        |      | | \
> +        *   |       /| | |        |        |      | | |\
> +        *   |      / | | |        |        |      | | | `--
> +        *   |     /  | | |        |        |      | | |
> +        *   |-----   | | |        |        |      | | |
> +        *   |        | | |        |        |      | | |
> +        *    --------|-|-|--------|--------|------|-|-|-----------------=
-> time
> +        *            | | |<--t2-->|        |<-t2'>| | |
> +        *            | |                            | |
> +        *            | |<------------t1------------>| |
> +        *            |                                |
> +        *            |<-------------t0--------------->|
> +        *
> +        */
> +       if (tz_dbg->trip_index < 0) {
> +               tze =3D thermal_debugfs_tz_event_alloc(tz, now);
> +               if (!tze)
> +                       return;
> +
> +               list_add(&tze->node, &tz_dbg->tz_events);
> +       }
> +
> +       /*
> +        * The trip_index points to the current position in the
> +        * trip_crossed[] array. Each time a trip point is crossed the
> +        * way up, the trip_id is stored in the array and the
> +        * trip_index is incremented. A negative trip_index means we
> +        * are entering a mitigation episode.
> +        *
> +        * The trip ids may not be in the ascending order but the
> +        * result in the array trips_crossed will be in the ascending
> +        * temperature order.
> +        */

As I said above, I would use nr_trips instead of trip_index and so I
would adjust the comment above for that.

> +       tz_dbg->trip_index++;
> +       tz_dbg->trips_crossed[tz_dbg->trip_index] =3D trip_id;

 +       tz_dbg->trips_crossed[tz_dbg->nr_trips++] =3D trip_id;

> +
> +       tze =3D list_first_entry(&tz_dbg->tz_events, struct tz_events, no=
de);
> +       tze->trip_stats[trip_id].timestamp =3D now;
> +       tze->trip_stats[trip_id].max =3D max(tze->trip_stats[trip_id].max=
, temperature);
> +       tze->trip_stats[trip_id].min =3D min(tze->trip_stats[trip_id].min=
, temperature);
> +       tze->trip_stats[trip_id].avg =3D tze->trip_stats[trip_id].avg +
> +               (temperature - tze->trip_stats[trip_id].avg) /
> +               tze->trip_stats[trip_id].count;
> +
> +       mutex_unlock(&thermal_dbg->lock);
> +}
> +
> +void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
> +                               const struct thermal_trip *trip)
> +{
> +       struct thermal_debugfs *thermal_dbg =3D tz->debugfs;
> +       struct tz_events *tze;
> +       struct tz_debugfs *tz_dbg;
> +

This blank line is redundant.

> +       int trip_id =3D thermal_zone_trip_id(tz, trip);
> +       ktime_t delta, now =3D ktime_get();

+       int i;

> +
> +       if (!thermal_dbg)
> +               return;
> +
> +       mutex_lock(&thermal_dbg->lock);
> +
> +       tz_dbg =3D &thermal_dbg->tz_dbg;
> +
> +       /*
> +        * The temperature crosses the way down but there was not
> +        * mitigation detected before. That may happen when the
> +        * temperature is greater than a trip point when registering a
> +        * thermal zone, which is a common use case as the kernel has
> +        * no mitigation mechanism yet at boot time.
> +        */
> +       if (tz_dbg->trip_index < 0)
> +               goto out;

+       if (!tz_dbg->nr_trips)
+               goto out;
+
+       for (i =3D tz_dbg->nr_trips - 1; i >=3D 0; i--) {
+             if (tz_dbg->trips_crossed[i] =3D=3D trip_id)
+                    break;
+       }
+       if (i < 0)
+              goto out;
+
+       tz_dbg->nr_trips--;
+
+       if (i < tz_dbg->nr_trips)
+             tz_dbg->trips_crossed[i] =3D
tz_dbg->trips_crossed[tz_dbg->nr_trips];

> +
> +       tze =3D list_first_entry(&tz_dbg->tz_events, struct tz_events, no=
de);
> +
> +       delta =3D ktime_sub(now, tze->trip_stats[trip_id].timestamp);
> +       tze->trip_stats[trip_id].duration =3D ktime_add(delta,
> +                                                     tze->trip_stats[tri=
p_id].duration);
> +

The above does not depend on trip_index, so OK.

> +       tz_dbg->trip_index--;

The above goes away.

> +
> +       /*
> +        * This event closes the mitigation as we are crossing the
> +        * last trip point the way down.
> +        */
> +       if (tz_dbg->trip_index < 0)

+       if (!tz_dbg->nr_trips)

> +               tze->duration =3D ktime_sub(now, tze->timestamp);
> +
> +out:
> +       mutex_unlock(&thermal_dbg->lock);
> +}

With the above modifications, it should work regardless of what
happens to the trip points during the mitigation episode so long as
the core reports the trip crossing events correctly.

> +
> +void thermal_debug_update_temp(struct thermal_zone_device *tz)
> +{
> +       struct thermal_debugfs *thermal_dbg =3D tz->debugfs;
> +       struct tz_events *tze;
> +       struct tz_debugfs *tz_dbg;
> +       int trip_id;
> +
> +       if (!thermal_dbg)
> +               return;
> +
> +       mutex_lock(&thermal_dbg->lock);
> +
> +       tz_dbg =3D &thermal_dbg->tz_dbg;
> +
> +       if (tz_dbg->trip_index >=3D 0) {

This would become

+       if (tz_dbg->nr_trips > 0) {

> +               trip_id =3D tz_dbg->trip_index;

but is this correct?

AFAICS, if anything, it should be

+               trip_id =3D tz_dbg->trips_crossed[tz_dbg->trip_index];

and this assumes that the last trip in the array is the one whose
stats need to be updated, but why would it be the only one?

Shouldn't the stats be updated for all of them?  After all, they all
are still engaged in the current mitigation episode, so

+       for (i =3D 0; i < tz_dbg->nr_trips; i++) {
+             trip_id =3D tz_dbg->trips_crossed[i];

> +               tze =3D list_first_entry(&tz_dbg->tz_events, struct tz_ev=
ents, node);
> +               tze->trip_stats[trip_id].count++;
> +               tze->trip_stats[trip_id].max =3D max(tze->trip_stats[trip=
_id].max, tz->temperature);
> +               tze->trip_stats[trip_id].min =3D min(tze->trip_stats[trip=
_id].min, tz->temperature);
> +               tze->trip_stats[trip_id].avg =3D tze->trip_stats[trip_id]=
.avg +
> +                       (tz->temperature - tze->trip_stats[trip_id].avg) =
/
> +                       tze->trip_stats[trip_id].count;
> +       }
> +
> +       mutex_unlock(&thermal_dbg->lock);
> +}
> +
> +static void *tze_seq_start(struct seq_file *s, loff_t *pos)
> +{
> +       struct thermal_zone_device *tz =3D s->private;
> +       struct thermal_debugfs *thermal_dbg =3D tz->debugfs;
> +       struct tz_debugfs *tz_dbg =3D &thermal_dbg->tz_dbg;
> +
> +       mutex_lock(&thermal_dbg->lock);
> +
> +       return seq_list_start(&tz_dbg->tz_events, *pos);
> +}
> +
> +static void *tze_seq_next(struct seq_file *s, void *v, loff_t *pos)
> +{
> +       struct thermal_zone_device *tz =3D s->private;
> +       struct thermal_debugfs *thermal_dbg =3D tz->debugfs;
> +       struct tz_debugfs *tz_dbg =3D &thermal_dbg->tz_dbg;
> +
> +       return seq_list_next(v, &tz_dbg->tz_events, pos);
> +}
> +
> +static void tze_seq_stop(struct seq_file *s, void *v)
> +{
> +       struct thermal_zone_device *tz =3D s->private;
> +       struct thermal_debugfs *thermal_dbg =3D tz->debugfs;
> +
> +       mutex_unlock(&thermal_dbg->lock);
> +}
> +
> +static int tze_seq_show(struct seq_file *s, void *v)
> +{
> +       struct thermal_zone_device *tz =3D s->private;
> +       struct tz_events *tze;
> +       int i;
> +
> +       tze =3D list_entry((struct list_head *)v, struct tz_events, node)=
;
> +
> +       seq_printf(s, ",-Mitigation at %lluus, duration=3D%llums\n",
> +                  ktime_to_us(tze->timestamp),
> +                  ktime_to_ms(tze->duration));
> +
> +       seq_printf(s, "| trip |     type | temp(=C2=B0mC) | hyst(=C2=B0mC=
) |  duration  |  avg(=C2=B0mC) |  min(=C2=B0mC) |  max(=C2=B0mC) |\n");
> +
> +       for (i =3D 0; i < tz->num_trips; i++) {

Why can't for_each_trip() be used here?

> +
> +               struct thermal_trip trip;
> +               const char *type;
> +
> +               if (__thermal_zone_get_trip(tz, i, &trip))
> +                       continue;

So this would not be necessary?

> +
> +               /*
> +                * There is no possible mitigation happening at the
> +                * critical trip point, so the stats will be always
> +                * zero, skip this trip point
> +                */
> +               if (trip.type =3D=3D THERMAL_TRIP_CRITICAL)
> +                       continue;
> +
> +               if (trip.type =3D=3D THERMAL_TRIP_PASSIVE)
> +                       type =3D "passive";
> +               else if (trip.type =3D=3D THERMAL_TRIP_ACTIVE)
> +                       type =3D "active";
> +               else
> +                       type =3D "hot";
> +
> +               seq_printf(s, "| %*d | %*s | %*d | %*d | %*lld | %*d | %*=
d | %*d |\n",
> +                          4 , i,
> +                          8, type,
> +                          9, trip.temperature,
> +                          9, trip.hysteresis,
> +                          10, ktime_to_ms(tze->trip_stats[i].duration),
> +                          9, tze->trip_stats[i].avg,
> +                          9, tze->trip_stats[i].min,
> +                          9, tze->trip_stats[i].max);
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct seq_operations tze_sops =3D {
> +       .start =3D tze_seq_start,
> +       .next =3D tze_seq_next,
> +       .stop =3D tze_seq_stop,
> +       .show =3D tze_seq_show,
> +};
> +
> +DEFINE_SEQ_ATTRIBUTE(tze);
> +
> +void thermal_debug_tz_add(struct thermal_zone_device *tz)
> +{
> +       struct thermal_debugfs *thermal_dbg;
> +       struct tz_debugfs *tz_dbg;
> +
> +       thermal_dbg =3D thermal_debugfs_add_id(d_tz, tz->id);
> +       if (!thermal_dbg)
> +               return;
> +
> +       tz_dbg =3D &thermal_dbg->tz_dbg;
> +
> +       tz_dbg->trips_crossed =3D kzalloc(sizeof(int) * tz->num_trips, GF=
P_KERNEL);
> +       if (!tz_dbg->trips_crossed) {
> +               thermal_debugfs_remove_id(thermal_dbg);
> +               return;
> +       }
> +
> +       /*
> +        * Trip index '-1' means no mitigation
> +        */
> +       tz_dbg->trip_index =3D -1;

+       tz_dbg->nr_trips =3D 0;

or it can be dropped even.

> +       INIT_LIST_HEAD(&tz_dbg->tz_events);
> +
> +       debugfs_create_file("mitigations", 0400, thermal_dbg->d_top, tz, =
&tze_fops);
> +
> +       tz->debugfs =3D thermal_dbg;
> +}
> +
> +void thermal_debug_tz_remove(struct thermal_zone_device *tz)
> +{
> +       struct thermal_debugfs *thermal_dbg =3D tz->debugfs;
> +
> +       if (!thermal_dbg)
> +               return;
> +
> +       mutex_lock(&thermal_dbg->lock);
> +
> +       tz->debugfs =3D NULL;
> +       thermal_debugfs_remove_id(thermal_dbg);
> +
> +       mutex_unlock(&thermal_dbg->lock);
> +}
> diff --git a/drivers/thermal/thermal_debugfs.h b/drivers/thermal/thermal_=
debugfs.h
> index 341499388448..155b9af5fe87 100644
> --- a/drivers/thermal/thermal_debugfs.h
> +++ b/drivers/thermal/thermal_debugfs.h
> @@ -5,10 +5,24 @@ void thermal_debug_init(void);
>  void thermal_debug_cdev_add(struct thermal_cooling_device *cdev);
>  void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev);
>  void thermal_debug_cdev_state_update(const struct thermal_cooling_device=
 *cdev, int state);
> +void thermal_debug_tz_add(struct thermal_zone_device *tz);
> +void thermal_debug_tz_remove(struct thermal_zone_device *tz);
> +void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
> +                             const struct thermal_trip *trip);
> +void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
> +                               const struct thermal_trip *trip);
> +void thermal_debug_update_temp(struct thermal_zone_device *tz);
>  #else
>  static inline void thermal_debug_init(void) {}
>  static inline void thermal_debug_cdev_add(struct thermal_cooling_device =
*cdev) {}
>  static inline void thermal_debug_cdev_remove(struct thermal_cooling_devi=
ce *cdev) {}
>  static inline void thermal_debug_cdev_state_update(const struct thermal_=
cooling_device *cdev,
>                                                    int state) {}
> +static inline void thermal_debug_tz_add(struct thermal_zone_device *tz) =
{}
> +static inline void thermal_debug_tz_remove(struct thermal_zone_device *t=
z) {}
> +static inline void thermal_debug_tz_trip_up(struct thermal_zone_device *=
tz,
> +                                           const struct thermal_trip *tr=
ip) {};
> +static inline void thermal_debug_tz_trip_down(struct thermal_zone_device=
 *tz,
> +                                             const struct thermal_trip *=
trip) {}
> +static inline void thermal_debug_update_temp(struct thermal_zone_device =
*tz) {}
>  #endif /* CONFIG_THERMAL_DEBUGFS */
> --

