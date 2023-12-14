Return-Path: <linux-kernel+bounces-133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5808813CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E861F226B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30D76ABA9;
	Thu, 14 Dec 2023 21:33:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2E5282E7;
	Thu, 14 Dec 2023 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6d9d6f8485eso10987a34.0;
        Thu, 14 Dec 2023 13:33:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702589604; x=1703194404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyiITulSGJ6z0yR6WmJOtdmQHG8M3ey/V4bXZitn1js=;
        b=ku8kQDF4rCl78gIiQzfo/OO+sph5mmXtSXxNNBPsNCFK0WVlibdnwOSi/13Z1iuYJv
         e33jlrQexIrI33Gviy8O8whwc/jwoX2c0VacHeNod8+vgJw9fLMaqHkz3DwSqjQXiR23
         eXXtO5pAgQIFvmOiYQi/AeIMieJGl6drnZlPLzOTNrysaNrnmVttAnrg6TueNg9MBc7F
         Fxw4ipNLNOD9HrzcX952svIF+u/eRAkOU0okknkgu2tfZxr8IoocNW/OfNVP2t3gEWkB
         VY/NXvPQK0R4HKB7uhNF8Ou+HAPwCAWLs1Tva6UAo3EtL70pKCYK+NhtFEviLZyySiyl
         Wosw==
X-Gm-Message-State: AOJu0YzcnSXNkSH6Wp1blyJHe41+aJZYODmUX/+2Yk/Tm8O//8+zuHx1
	JtrjndURBLkOWEWNcrjG7jXrsxzLVunezXsuMzQ=
X-Google-Smtp-Source: AGHT+IH5hsr/q+yqI92mtvLZskqC4J0sikSyA8d7LTGeebgrgl9f42TfOGlJP4Gb1oDUUYtiRJTibxb7QEgTopashrc=
X-Received: by 2002:a05:6871:7589:b0:1fa:db26:78a6 with SMTP id
 nz9-20020a056871758900b001fadb2678a6mr19687793oac.1.1702589603714; Thu, 14
 Dec 2023 13:33:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212161047.1631077-1-daniel.lezcano@linaro.org>
In-Reply-To: <20231212161047.1631077-1-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 Dec 2023 22:33:12 +0100
Message-ID: <CAJZ5v0gy+DGnsCQRaHVpvuASLytp9E+v-sDhRgrXvi6nPi2Ukg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] thermal/debugfs: Add thermal cooling device
 debugfs information
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, lukasz.luba@arm.com, rui.zhang@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 5:11=E2=80=AFPM Daniel Lezcano
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
> events than the ones which actually occurred. There is no longer a
> size limitation and it opens the field for more debugging information
> where the debugfs is designed for, not sysfs.

Note: My comments are aside from the 0-day reports.

> The thermal debugfs directory structure tries to stay consistent with
> the sysfs one but in a very simplified way:
>
> thermal/
>  -- cooling_devices
>     |-- 0
>     |   |-- reset

This may be confused with a device reset.  I would call it "clear" or simil=
ar.

>     |   |-- time_in_state_ms
>     |   |-- total_trans
>     |   `-- trans_table
>     |-- 1
>     |   |-- reset
>     |   |-- time_in_state_ms
>     |   |-- total_trans
>     |   `-- trans_table
>     |-- 2
>     |   |-- reset
>     |   |-- time_in_state_ms
>     |   |-- total_trans
>     |   `-- trans_table
>     |-- 3
>     |   |-- reset
>     |   |-- time_in_state_ms
>     |   |-- total_trans
>     |   `-- trans_table
>     `-- 4
>         |-- reset
>         |-- time_in_state_ms
>         |-- total_trans
>         `-- trans_table
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
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> Changelog:
>   - v1 (from RFC):
>     - Fixed typo "occurred"
>     - Changed Kconfig option name and description
>     - Removed comment in the Makefile
>     - Renamed exported function name s/debugfs/debug/
>     - Replaced thermal_debug_cdev_[unregister|register] by [add|remove]
> ---
>  drivers/thermal/Kconfig           |   7 +
>  drivers/thermal/Makefile          |   2 +
>  drivers/thermal/thermal_core.c    |   6 +
>  drivers/thermal/thermal_core.h    |   1 +
>  drivers/thermal/thermal_debugfs.c | 354 ++++++++++++++++++++++++++++++
>  drivers/thermal/thermal_debugfs.h |  13 ++
>  drivers/thermal/thermal_helpers.c |  27 ++-
>  include/linux/thermal.h           |   7 +
>  8 files changed, 411 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/thermal/thermal_debugfs.c
>  create mode 100644 drivers/thermal/thermal_debugfs.h

[ cut - part looking good ]

> diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_=
debugfs.c
> new file mode 100644
> index 000000000000..295f7a2a7d0d
> --- /dev/null
> +++ b/drivers/thermal/thermal_debugfs.c
> @@ -0,0 +1,354 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2023 Linaro Limited
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + * Debug filesystem for the thermal framework

I would say "Thermal subsystem debug support" here.

> + */
> +#include <linux/debugfs.h>
> +#include <linux/ktime.h>
> +#include <linux/list.h>
> +#include <linux/minmax.h>
> +#include <linux/mutex.h>
> +#include <linux/thermal.h>
> +
> +static struct dentry *d_root;
> +static struct dentry *d_cdev;
> +
> +/*
> + * Length of the string containing the thermal zone id, including the
> + * ending null character.

This would be "nul", not "null".  Also it also applies to cdev IDs AFAICS.

> We can reasonably assume there won't be more
> + * than 256 thermal zones as the maximum observed today is around 32.
> + */
> +#define IDSLENGTH 4
> +
> +/*
> + * The cooling device transition list is stored in a hash table where
> + * the size is CDEVSTATS_HASH_SIZE. The majority of cooling devices
> + * have dozen of states but some can have much more, so a hash table
> + * is more adequate in this case because browsing the entire list when
> + * storing the transitions could have a non neglictible cost

"... in this case, because the cost of browsing the entire list when
storing the transitions may not be negligible".

But it really depends on which IDs come into play.  Due to the way the
hash table is implemented, you may end up with having all of them in
one list anyway.

> + */
> +#define CDEVSTATS_HASH_SIZE 16
> +
> +struct cdev_value {
> +       struct list_head list;

This is used for adding the entry to the list, so I would call it
"node", for instance.  Otherwise it is easily confused with other
entities that really are lists.

> +       int id;
> +       u64 value;
> +};

The above could be described.  I had to reverse-engineer the patch to
figure this out.

> +
> +/*
> + * A cooling device can have a high number of states. Showing the
> + * transitions on a matrix based representation can be overkill given
> + * most of the transitions won't happen and we end up with a matrix
> + * filled with zero. Instead, we show the transitions which actually
> + * happened.

This could be a proper kerneldoc comment with the struct members
documented.  It would help quite a bit to understand the code.

> + */
> +struct cdev_debugfs {
> +       u32 total;
> +       int current_state;
> +       ktime_t timestamp;
> +       struct list_head trans_list[CDEVSTATS_HASH_SIZE];
> +       struct list_head duration_list[CDEVSTATS_HASH_SIZE];

I would call the above "transitions" and "durations", respectively.
IMO the "list" part doesn't add any value and is a bit confusing.

> +};
> +
> +/*
> + * The thermal_debugfs structure is the common structure used by the
> + * cooling device to compute the statistics and the thermal to measure
> + * the temperature at mitigation time.

This also could be a proper kerneldoc comment with the struct members
documented.

> + */
> +struct thermal_debugfs {
> +       struct dentry *d_top;
> +       struct mutex lock;
> +       union {
> +               struct cdev_debugfs cdev;
> +       };
> +};
> +
> +void thermal_debug_init(void)
> +{
> +       d_root =3D debugfs_create_dir("thermal", NULL);
> +       if (!d_root)
> +               return;
> +
> +       d_cdev =3D debugfs_create_dir("cooling_devices", d_root);
> +}
> +
> +static struct thermal_debugfs *thermal_debugfs_add_id(struct dentry *d, =
int id)
> +{
> +       struct thermal_debugfs *dfs;
> +       char ids[IDSLENGTH];
> +
> +       dfs =3D kzalloc(sizeof(*dfs), GFP_KERNEL);
> +       if (!dfs)
> +               return NULL;
> +
> +       mutex_init(&dfs->lock);
> +
> +       snprintf(ids, IDSLENGTH, "%d", id);
> +
> +       dfs->d_top =3D debugfs_create_dir(ids, d);
> +       if (!dfs->d_top) {
> +               kfree(dfs);
> +               return NULL;
> +       }
> +
> +       return dfs;
> +}
> +
> +static void thermal_debugfs_remove_id(struct thermal_debugfs *dfs)
> +{
> +       if (!dfs)
> +               return;
> +
> +       debugfs_remove(dfs->d_top);
> +
> +       kfree(dfs);
> +}
> +
> +static struct cdev_value *thermal_debugfs_cdev_value_alloc(int id)
> +{
> +       struct cdev_value *cdev_value;
> +
> +       cdev_value =3D kzalloc(sizeof(*cdev_value), GFP_KERNEL);
> +       if (cdev_value) {
> +               cdev_value->id =3D id;
> +               INIT_LIST_HEAD(&cdev_value->list);
> +       }
> +
> +       return cdev_value;
> +}

"alloc" and "insert" (below) can be done in one function I suppose?
Especially given that the latter is a one-liner and they are only
called back-to-back in one place.

> +
> +static struct cdev_value *thermal_debugfs_cdev_value_find(struct thermal=
_debugfs *dfs,
> +                                                         struct list_hea=
d *list, int id)

The "list" argument here doesn't really represent a list.  It is an
array of lists, or a hash table if you will.  I would call it
something less confusing like "lists".

> +{
> +       struct cdev_value *pos;

Why not "entry"?

> +
> +       list_for_each_entry(pos, &list[id % CDEVSTATS_HASH_SIZE], list)
> +               if (pos->id =3D=3D id)
> +                       return pos;
> +
> +       return NULL;
> +}
> +
> +static void thermal_debugfs_cdev_value_insert(struct thermal_debugfs *df=
s,
> +                                             struct list_head *list,
> +                                             struct cdev_value *cdev_val=
ue)
> +{
> +       list_add_tail(&cdev_value->list, &list[cdev_value->id % CDEVSTATS=
_HASH_SIZE]);
> +}
> +
> +struct cdev_value *thermal_debugfs_cdev_value_get(struct thermal_debugfs=
 *dfs,
> +                                                 struct list_head *list,=
 int id)
> +{
> +       struct cdev_value *cdev_value;
> +
> +       cdev_value =3D thermal_debugfs_cdev_value_find(dfs, list, id);
> +       if (cdev_value)
> +               return cdev_value;
> +
> +       cdev_value =3D thermal_debugfs_cdev_value_alloc(id);
> +       if (cdev_value)
> +               thermal_debugfs_cdev_value_insert(dfs, list, cdev_value);
> +
> +       return cdev_value;
> +}
> +
> +static void thermal_debugfs_cdev_reset(struct cdev_debugfs *cfs)
> +{
> +       int i;
> +       struct cdev_value *pos, *tmp;
> +
> +       for (i =3D 0; i < CDEVSTATS_HASH_SIZE; i++) {
> +
> +               list_for_each_entry_safe(pos, tmp, &cfs->trans_list[i], l=
ist) {
> +                       list_del(&pos->list);
> +                       kfree(pos);
> +               }
> +
> +               list_for_each_entry_safe(pos, tmp, &cfs->duration_list[i]=
, list) {
> +                       list_del(&pos->list);
> +                       kfree(pos);
> +               }
> +       }

Does this need to be synchronized with the file operations below?
What if someone triggers it while a transitions file read is in
progress, for instance?

> +
> +       cfs->total =3D 0;
> +}
> +
> +void thermal_debug_cdev_transition(struct thermal_cooling_device *cdev, =
int to)

to -> new_state ?

> +{
> +       struct thermal_debugfs *dfs =3D cdev->debugfs;
> +       struct cdev_debugfs *cfs;
> +       struct cdev_value *cdev_value;
> +       ktime_t now =3D ktime_get();
> +       int transition, from;

from -> old_state ?

> +
> +       if (!dfs || (dfs->cdev.current_state =3D=3D to))
> +               return;
> +
> +       mutex_lock(&dfs->lock);
> +
> +       cfs =3D &dfs->cdev;
> +
> +       from =3D cfs->current_state;
> +       cfs->current_state =3D to;
> +       transition =3D (from << 16) | to;
> +
> +       cdev_value =3D thermal_debugfs_cdev_value_get(dfs, cfs->duration_=
list, from);
> +       if (cdev_value) {
> +               cdev_value->value +=3D ktime_ms_delta(now, cfs->timestamp=
);
> +               cfs->timestamp =3D now;
> +       }
> +
> +       cdev_value =3D thermal_debugfs_cdev_value_get(dfs, cfs->trans_lis=
t, transition);
> +       if (cdev_value)
> +               cdev_value->value++;

Some concise comments describing what is going on here wouldn't hurt.

> +
> +       cfs->total++;
> +
> +       mutex_unlock(&dfs->lock);
> +}
> +
> +static void *cdev_seq_start(struct seq_file *s, loff_t *pos)
> +{
> +       struct thermal_debugfs *dfs =3D s->private;
> +
> +       mutex_lock(&dfs->lock);
> +
> +       return (*pos < CDEVSTATS_HASH_SIZE) ? pos : NULL;
> +}
> +
> +static void *cdev_seq_next(struct seq_file *s, void *v, loff_t *pos)
> +{
> +       (*pos)++;
> +
> +       return (*pos < CDEVSTATS_HASH_SIZE) ? pos : NULL;
> +}
> +
> +static void cdev_seq_stop(struct seq_file *s, void *v)
> +{
> +       struct thermal_debugfs *dfs =3D s->private;
> +
> +       mutex_unlock(&dfs->lock);
> +}
> +
> +static int cdev_tt_seq_show(struct seq_file *s, void *v)
> +{
> +       struct thermal_debugfs *dfs =3D s->private;
> +       struct cdev_debugfs *cfs =3D &dfs->cdev;
> +       struct list_head *trans_list =3D cfs->trans_list;
> +       struct cdev_value *pos;

pos -> entry? (and elsewhere too)

> +       char buffer[11];

Why 11?

> +       int i =3D *(loff_t *)v;
> +
> +       if (!i)
> +               seq_puts(s, "Transition\tHits\n");

I think that the "Hits" column represents the number of times the
given transition has occurred, so I would rather call it
"Occurrences".

> +
> +       list_for_each_entry(pos, &trans_list[i], list) {
> +
> +               snprintf(buffer, ARRAY_SIZE(buffer), "%d->%d",
> +                        pos->id >> 16, pos->id & 0xFFFF);
> +
> +               seq_printf(s, "%-10s\t%-10llu\n", buffer, pos->value);
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct seq_operations tt_sops =3D {
> +       .start =3D cdev_seq_start,
> +       .next =3D cdev_seq_next,
> +       .stop =3D cdev_seq_stop,
> +       .show =3D cdev_tt_seq_show,
> +};
> +
> +DEFINE_SEQ_ATTRIBUTE(tt);
> +
> +static int cdev_dt_seq_show(struct seq_file *s, void *v)
> +{
> +       struct cdev_debugfs *cfs =3D s->private;
> +       struct list_head *duration_list =3D cfs->duration_list;
> +       struct cdev_value *pos;

pos -> entry ?

> +       int i =3D *(loff_t *)v;
> +
> +       if (!i)
> +               seq_puts(s, "State\tTime\n");

I think that the "Time" column will contain state residencies, so why
not label it as "Residency"?

> +
> +       list_for_each_entry(pos, &duration_list[i], list) {
> +               s64 duration =3D pos->value;
> +
> +               if (pos->id =3D=3D cfs->current_state)
> +                       duration +=3D ktime_ms_delta(ktime_get(), cfs->ti=
mestamp);
> +
> +               seq_printf(s, "%-5d\t%-10llu\n", pos->id, duration);
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct seq_operations dt_sops =3D {
> +       .start =3D cdev_seq_start,
> +       .next =3D cdev_seq_next,
> +       .stop =3D cdev_seq_stop,
> +       .show =3D cdev_dt_seq_show,
> +};
> +
> +DEFINE_SEQ_ATTRIBUTE(dt);

And I have no comments on the part below.

Thanks!

