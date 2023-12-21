Return-Path: <linux-kernel+bounces-8996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A572181BF19
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49D61C23B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE88651B8;
	Thu, 21 Dec 2023 19:26:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393D6745D4;
	Thu, 21 Dec 2023 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-593f182f263so128400eaf.0;
        Thu, 21 Dec 2023 11:26:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703186772; x=1703791572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWgzpQApys4U3Bq6QV4nRe0vzTfDqO2Pi7dkYG63D58=;
        b=ovEyBfucyU6RzrR7h8jmwLLecu5etPWzjZM8/KjPv2PiKo+bLN0nEpF3Zrv92slUuS
         Ak11dly2GSJobHeCqwyrPwvoPeYi23E/yBFt1ZJZE1IGqmj+bem1tY6S8z4exVvo9h+U
         5WOXcX/1nzd4B56aVDUEBsXsKvP88gfbPhnDFIGm8CUUJDYrY5XtYhkgzpjlyJPgXwep
         dPkQmzCHeD9tUFFSDKY1NBTKf8V+nsJ30CytD4e3ldVQVylDKfq4hVMCnNpreu/qYjw6
         xGNjmSIeOlX+UIekH2WcHmDDGVEnFozP8T7VBLFiB6IeEKaZ5oUZK/gdVEUNhNvidhrU
         dbqw==
X-Gm-Message-State: AOJu0YwXKFc7GLip28YRuGuFlgpoqKQdebKtAT+08AFKuK9GvN7Ebws6
	MnuXKMCTSzMQq6bGNJCFLVdKd1VMji8VDQMU/rM=
X-Google-Smtp-Source: AGHT+IEi/5itzLoRlY/nRqZnYWW1E+8rxnZd1EIRzkRhJYS6C5vz6eGo90u4JN6gCBcyaVVRscGJ8sV+pVSmoSZff+w=
X-Received: by 2002:a4a:d2cb:0:b0:594:33c:f126 with SMTP id
 j11-20020a4ad2cb000000b00594033cf126mr325536oos.0.1703186771987; Thu, 21 Dec
 2023 11:26:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219092539.3655172-1-daniel.lezcano@linaro.org> <20231219092539.3655172-2-daniel.lezcano@linaro.org>
In-Reply-To: <20231219092539.3655172-2-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Dec 2023 20:26:00 +0100
Message-ID: <CAJZ5v0gPHwJ+02hYbp5dRx1r69BdLWr_QDKautu-RXy1MEC5LQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] thermal/debugfs: Add thermal debugfs information
 for mitigation episodes
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, lukasz.luba@arm.com, rui.zhang@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 10:25=E2=80=AFAM Daniel Lezcano
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
> Please note this code is immune against trip ordering.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> Changelog:
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
>  drivers/thermal/thermal_debugfs.c | 367 +++++++++++++++++++++++++++++-
>  drivers/thermal/thermal_debugfs.h |  14 ++
>  3 files changed, 387 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 33332d401b13..a0cbe8d7b945 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c

[cut]

The changes above LGTM.

> diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_=
debugfs.c
> index 8fceddb5f6d2..5fd2553260b2 100644
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
> @@ -77,22 +80,84 @@ struct cdev_value {
>         u64 value;
>  };
>
> +/**
> + * struct trip_stats - Thermal trip statistics
> + *
> + * The trip_stats structure has the relevant information to show the
> + * statistics related to a trip point violation during a mitigation
> + * episode.

I wouldn't use the term "violation" here, it feels  too strong.

I looked for a replacement word, but I couldn't find a suitable one.
In the sentence above I would just say "related to going above a trip
point".

> + *
> + * @timestamp: the trip crossing timestamp
> + * @duration: the total duration of trip point violation

"total time when the zone temperature was above the trip point"

> + * @count: the number of occurrences of the trip point violation

"the number of times the zone temperature was above the trip point"

> + * @max: maximum temperature during the trip point violation

"maximum recorded temperature above the trip point"

> + * @min: min temperature during the trip point violation

"minimum recorded temperature above the trip point"

> + * @avg: average temperature during the trip point violation

"average temperature above the trip point"

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
> + * struct tz_events - Store all events related to a mitigation episode
> + *
> + * The tz_events structure describes a mitigation episode.

So why not call it tz_mitigation?

> A
> + * mitigation episode is when the mitigation begins and ends. During
> + * this episode we can have multiple trip points crossed the way up
> + * and down if there are multiple trip describes in the firmware.
> + *
> + * @node: a list element to be added to the list of tz events
> + * @trip_stats: per trip point statistics
> + * @timestamp: First trip point crossed the way up
> + * @duration: total duration of the mitigation episode
> + */
> +struct tz_events {
> +       struct list_head node;
> +       struct trip_stats *trip_stats;
> +       ktime_t timestamp;
> +       ktime_t duration;
> +};
> +
> +/**
> + * struct tz_debugfs - Store all mitigations episodes for a thermal zone

"Collection of all mitigation episodes for a thermal zone"

> + *
> + * The tz_debugfs structure contains the list of the mitigation
> + * episodes and has to track which trip point has been crossed in
> + * order to handle correctly nested trip point mitigation episodes.
> + *
> + * @tz_events: a list of thermal mitigation episodes
> + * @trips_crossed: an array of trip point crossed by id

This requires a bit more explanation IMV.

From the patch reverse-engineering I gather that this is used for
working around a possible issue with the trips being not sorted.  It
is also unclear what id means at this point.

> + * @trip_index: the current trip point crossed

I'm not sure what this means.

> + */
> +struct tz_debugfs {
> +       struct list_head tz_events;
> +       int *trips_crossed;
> +       int trip_index;
> +};
> +
>  /**
>   * struct thermal_debugfs - High level structure for a thermal object in=
 debugfs
>   *
>   * The thermal_debugfs structure is the common structure used by the
> - * cooling device to compute the statistics.
> + * cooling device and the thermal zone to store the statistics.

s/and/or/ ?  Because it can't be both at the same time.

>   *
>   * @d_top: top directory of the thermal object directory
>   * @lock: per object lock to protect the internals
>   *
>   * @cdev: a cooling device debug structure
> + * @tz: a thermal zone debug structure
>   */
>  struct thermal_debugfs {
>         struct dentry *d_top;
>         struct mutex lock;
>         union {
>                 struct cdev_debugfs cdev;
> +               struct tz_debugfs tz;

tz_dbg so as to avoid confusing this with a thermal zone object?

>         };
>  };
>
> @@ -103,6 +168,10 @@ void thermal_debug_init(void)
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
> @@ -422,3 +491,299 @@ void thermal_debug_cdev_remove(struct thermal_cooli=
ng_device *cdev)
>
>         mutex_unlock(&dfs->lock);
>  }
> +
> +static struct tz_events *thermal_debugfs_tz_event_alloc(struct thermal_z=
one_device *tz,

thermal_debugfs_tz_mitigation_alloc() ?

> +                                                       ktime_t now)
> +{
> +       struct tz_events *tze;
> +       struct trip_stats *trip_stats;
> +       int i;
> +
> +       tze =3D kzalloc(sizeof(*tze), GFP_KERNEL);
> +       if (!tze)
> +               return NULL;
> +
> +       INIT_LIST_HEAD(&tze->node);
> +       tze->timestamp =3D now;
> +
> +       trip_stats =3D kzalloc(sizeof(struct trip_stats) * tz->num_trips,=
 GFP_KERNEL);
> +       if (!trip_stats) {
> +               kfree(tze);
> +               return NULL;
> +       }

The memory allocations can be combined into one:

tze =3D kzalloc(sizeof(*tze) + sizeof(*trip_stats) * tz->num_trips, GFP_KER=
NEL);
if (!tze)
        return NULL;

trip_stats =3D (struct trip_stats *)(tze + 1);

Or if you defined trip_stats[] as a flexible array, you could use
struct_size() (see overflow.h).

> +
> +       for (i =3D 0; i < tz->num_trips; i++) {
> +               trip_stats[i].min =3D INT_MAX;
> +               trip_stats[i].max =3D INT_MIN;
> +       }
> +
> +       tze->trip_stats =3D trip_stats;
> +
> +       return tze;
> +}
> +
> +void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
> +                             const struct thermal_trip *trip)
> +{
> +       struct tz_events *tze;
> +       struct thermal_debugfs *dfs =3D tz->debugfs;

As per the comments on the previous patch this would be

struct thermal_debugfs *thermdbg =3D tz->debugfs;

I would add

struct tz_debugfs *tz_dbg =3D&thermdbg->tz_dbg;

and use it instead of dereferencing thermdbg every time to get to tz_dbg.

> +       int temperature =3D tz->temperature;
> +       int trip_id =3D thermal_zone_trip_id(tz, trip);
> +       ktime_t now =3D ktime_get();
> +
> +       if (!dfs)
> +               return;
> +
> +       mutex_lock(&dfs->lock);
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
> +       if (dfs->tz.trip_index < 0) {
> +               tze =3D thermal_debugfs_tz_event_alloc(tz, now);
> +               if (!tze)
> +                       return;
> +
> +               list_add(&tze->node, &dfs->tz.tz_events);
> +       }
> +
> +       dfs->tz.trip_index++;
> +       dfs->tz.trips_crossed[dfs->tz.trip_index] =3D trip_id;

So trip_index is an index into trips_crossed[] and the value is the ID
of the trip passed by thermal_debug_tz_trip_up() IIUC, so the trip IDs
in trips_crossed[] are always sorted by the trip temperature, in the
ascending order.

It would be good to write this down somewhere in a comment.

And what if trip temperatures change during a mitigation episode such
that the order by the trip temperature changes?

> +
> +       tze =3D list_first_entry(&dfs->tz.tz_events, struct tz_events, no=
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
> +       mutex_unlock(&dfs->lock);
> +}
> +
> +void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
> +                               const struct thermal_trip *trip)
> +{
> +       struct thermal_debugfs *dfs =3D tz->debugfs;
> +       struct tz_events *tze;
> +       int trip_id =3D thermal_zone_trip_id(tz, trip);
> +       ktime_t delta, now =3D ktime_get();
> +
> +       if (!dfs)
> +               return;
> +
> +       /*
> +        * The temperature crosses the way down but there was not
> +        * mitigation detected before. That may happen when the
> +        * temperature is greater than a trip point when registering a
> +        * thermal zone, which is a common use case as the kernel has
> +        * no mitigation mechanism yet at boot time.
> +        */
> +       if (dfs->tz.trip_index < 0)
> +               return;
> +
> +       mutex_lock(&dfs->lock);
> +
> +       tze =3D list_first_entry(&dfs->tz.tz_events, struct tz_events, no=
de);
> +
> +       delta =3D ktime_sub(now, tze->trip_stats[trip_id].timestamp);
> +       tze->trip_stats[trip_id].duration =3D ktime_add(delta,
> +                                                     tze->trip_stats[tri=
p_id].duration);
> +
> +       dfs->tz.trip_index--;
> +
> +       /*
> +        * This event closes the mitigation as we are crossing the
> +        * last trip point the way down.
> +        */
> +       if (dfs->tz.trip_index < 0)
> +               tze->duration =3D ktime_sub(now, tze->timestamp);
> +
> +       mutex_unlock(&dfs->lock);
> +}
> +
> +void thermal_debug_update_temp(struct thermal_zone_device *tz)
> +{
> +       struct thermal_debugfs *dfs =3D tz->debugfs;
> +       struct tz_events *tze;
> +       int trip;

trip_id, please.

> +
> +       if (!dfs)
> +               return;
> +
> +       mutex_lock(&dfs->lock);
> +
> +       if (dfs->tz.trip_index >=3D 0) {
> +               trip =3D dfs->tz.trip_index;
> +               tze =3D list_first_entry(&dfs->tz.tz_events, struct tz_ev=
ents, node);
> +               tze->trip_stats[trip].count++;
> +               tze->trip_stats[trip].max =3D max(tze->trip_stats[trip].m=
ax, tz->temperature);
> +               tze->trip_stats[trip].min =3D min(tze->trip_stats[trip].m=
in, tz->temperature);
> +               tze->trip_stats[trip].avg =3D tze->trip_stats[trip].avg +
> +                       (tz->temperature - tze->trip_stats[trip].avg) /
> +                       tze->trip_stats[trip].count;
> +       }
> +
> +       mutex_unlock(&dfs->lock);
> +}
> +
> +static void *tze_seq_start(struct seq_file *s, loff_t *pos)
> +{
> +       struct thermal_zone_device *tz =3D s->private;
> +       struct thermal_debugfs *dfs =3D tz->debugfs;
> +       struct tz_debugfs *tzd =3D &dfs->tz;
> +
> +       mutex_lock(&dfs->lock);
> +
> +       return seq_list_start(&tzd->tz_events, *pos);
> +}
> +
> +static void *tze_seq_next(struct seq_file *s, void *v, loff_t *pos)
> +{
> +       struct thermal_zone_device *tz =3D s->private;
> +       struct thermal_debugfs *dfs =3D tz->debugfs;
> +       struct tz_debugfs *tzd =3D &dfs->tz;
> +
> +       return seq_list_next(v, &tzd->tz_events, pos);
> +}
> +
> +static void tze_seq_stop(struct seq_file *s, void *v)
> +{
> +       struct thermal_zone_device *tz =3D s->private;
> +       struct thermal_debugfs *dfs =3D tz->debugfs;
> +
> +       mutex_unlock(&dfs->lock);
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

Please use for_each_trip(), here and thermal_zone_trip_id() to get to the I=
Ds.

> +
> +               struct thermal_trip trip;
> +               const char *type;
> +
> +               if (__thermal_zone_get_trip(tz, i, &trip))
> +                       continue;
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
> +       struct thermal_debugfs *dfs;
> +       struct tz_debugfs *tzd;
> +
> +       dfs =3D thermal_debugfs_add_id(d_tz, tz->id);
> +       if (!dfs)
> +               return;
> +
> +       tzd =3D &dfs->tz;
> +
> +       tzd->trips_crossed =3D kzalloc(sizeof(int) * tz->num_trips, GFP_K=
ERNEL);
> +       if (!tzd->trips_crossed) {
> +               thermal_debugfs_remove_id(dfs);
> +               return;
> +       }
> +
> +       /*
> +        * Trip index '-1' means no mitigation
> +        */
> +       tzd->trip_index =3D -1;
> +       INIT_LIST_HEAD(&tzd->tz_events);
> +
> +       debugfs_create_file("mitigations", 0400, dfs->d_top, tz, &tze_fop=
s);
> +
> +       tz->debugfs =3D dfs;
> +}
> +
> +void thermal_debug_tz_remove(struct thermal_zone_device *tz)
> +{
> +       struct thermal_debugfs *dfs =3D tz->debugfs;
> +
> +       if (!dfs)
> +               return;
> +
> +       mutex_lock(&dfs->lock);
> +
> +       tz->debugfs =3D NULL;
> +       thermal_debugfs_remove_id(dfs);
> +
> +       mutex_unlock(&dfs->lock);
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

It overall seems to have a problem with a possible change of trip
temperatures during a mitigation episode.

