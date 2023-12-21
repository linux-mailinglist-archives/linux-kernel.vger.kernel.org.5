Return-Path: <linux-kernel+bounces-8839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C40681BCEE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BAEB1F268FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDDC627F5;
	Thu, 21 Dec 2023 17:19:42 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB9627E8;
	Thu, 21 Dec 2023 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-593f182f263so111774eaf.0;
        Thu, 21 Dec 2023 09:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703179179; x=1703783979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhX940bckgA4p1wmjuh48lmqWWaTtJ+9YEEpzwCfa30=;
        b=S7hKJSTGah1a24F5Ax6apMiYkDWfmgdPeOtA9zPyMHM3YguW9I8f3hoUyE3Oy4h2ln
         lvrN/MP7fnFo0mvEXnmt7pYiKcoB2Yp4oYKMjDh6LfUIqCHPDga2Y39okqaxvYZ7e6JK
         E49gZba3yiX5RI6z3EHYvIHt+FX98LChYmvD++tHZ9hDArrRsVjoMm2B0kxEgO5Sb0Qe
         UwV50PUbPRjWKSlmWAi+z+5RVYOVwWSkwQ+9t3f2/oC77QHZDqD3UKTyIkjZkcpSMFLH
         Z8hfHUYlUIwja2on+7JUjD8cAFv4WOR+Sudu9SXJnxQ5OKghV3r2BPZ33gYCAJMvfQYR
         ulfQ==
X-Gm-Message-State: AOJu0YzrwTQT6Xm/H//tNTIispsjgUR/TdZVKDNDjmBriLInEIUZ9lzr
	Z/GUO9nM+d4OIXAPNdpjPVlz7qV3Y2SgbFqBKjo=
X-Google-Smtp-Source: AGHT+IEyk7R7FGhaOPkyVi2aw9cBFHPDCEvCqY+Uzvc63Is+VcBmRtUS+7e3bw/jaXnB1/w59xvCOe1P0xFwQhOFddI=
X-Received: by 2002:a4a:d195:0:b0:594:177d:8bd6 with SMTP id
 j21-20020a4ad195000000b00594177d8bd6mr4157161oor.1.1703179179096; Thu, 21 Dec
 2023 09:19:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219092539.3655172-1-daniel.lezcano@linaro.org>
In-Reply-To: <20231219092539.3655172-1-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Dec 2023 18:19:27 +0100
Message-ID: <CAJZ5v0j+F2uLauRqGZ1nvX3CsoA3+JXyzXFp5VtzvVTQTg6Yvw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] thermal/debugfs: Add thermal cooling device
 debugfs information
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, lukasz.luba@arm.com, rui.zhang@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 10:25=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The thermal framework does not have any debug information except a
> sysfs stat which is a bit controversial. This one allocates big chunks
> of memory for every cooling devices with a high number of states and
> could represent on some systems in production several megabytes of
> memory for just a portion of it. As the sysfs is limited to a page
> size, the output is not exploitable with large data array and gets
> truncated.
>
> The patch provides the same information than sysfs except the
> transitions are dynamically allocated, thus they won't show more
> events than the ones which actually occurred. There is no longer a
> size limitation and it opens the field for more debugging information
> where the debugfs is designed for, not sysfs.
>
> The thermal debugfs directory structure tries to stay consistent with
> the sysfs one but in a very simplified way:
>
> thermal/
>  -- cooling_devices
>     |-- 0
>     |   |-- clear
>     |   |-- time_in_state_ms
>     |   |-- total_trans
>     |   `-- trans_table
>     |-- 1
>     |   |-- clear
>     |   |-- time_in_state_ms
>     |   |-- total_trans
>     |   `-- trans_table
>     |-- 2
>     |   |-- clear
>     |   |-- time_in_state_ms
>     |   |-- total_trans
>     |   `-- trans_table
>     |-- 3
>     |   |-- clear
>     |   |-- time_in_state_ms
>     |   |-- total_trans
>     |   `-- trans_table
>     `-- 4
>         |-- clear
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
>   - v3
>     - Fixed kerneldoc description (kbuild)
>     - Made some functions static

There are a few minor nits still, as far as I'm concerned (see below).

>   - v2
>     - Added parameter names to fix kbuild report
>     - Renamed 'reset' to 'clear' to avoid confusion (Rafael)
>     - Fixed several typos and rephrased some sentences (Rafael)
>     - Renamed structure field name s/list/node/ (Rafael)
>     - Documented structures and exported functions (Rafael)
>     - s/trans_list/transitions/ (Rafael)
>     - s/duration_list/durations/ (Rafael)
>     - Folded 'alloc' and 'insert' into a single function (Rafael)
>     - s/list/lists/ as it is an array of lists (Rafael)
>     - s/pos/entry/ (Rafael)
>     - Introduced a locking in the 'clear' callback function (Rafael)
>     - s/to/new_state/ and s/from/old_state/ (Rafael)
>     - Added some comments in thermal_debug_cdev_transition() (Rafael)
>     - Explained why char[11] (Rafael)
>     - s/Hits/Occurrences/ (Rafael)
>     - s/Time/Residency/ (Rafael)
>     - Constified structure pointer passed to thermal_debug_cdev_transitio=
n()
>     - s/thermal_debug_cdev_transition()/thermal_debug_cdev_state_update()=
/
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
>  drivers/thermal/thermal_debugfs.c | 424 ++++++++++++++++++++++++++++++
>  drivers/thermal/thermal_debugfs.h |  14 +
>  drivers/thermal/thermal_helpers.c |  27 +-
>  include/linux/thermal.h           |   7 +
>  8 files changed, 482 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/thermal/thermal_debugfs.c
>  create mode 100644 drivers/thermal/thermal_debugfs.h

[cut]

All of the above changes look good to me.

> +
> +/**
> + * struct cdev_debugfs - per cooling device statistics structure
> + * A cooling device can have a high number of states. Showing the
> + * transitions on a matrix based representation can be overkill given
> + * most of the transitions won't happen and we end up with a matrix
> + * filled with zero. Instead, we show the transitions which actually
> + * happened.
> + *
> + * Every transition updates the current_state and the timestamp. The
> + * transitions and the durations are stored in lists.
> + *
> + * @total: the number of transitions for this cooling device
> + * @current_state: the current cooling device state
> + * @timestamp: the state change timestamp
> + * @durations: an array of lists containing the residencies of each stat=
e
> + * @transitions: an array of lists containing the state transitions

I would use the same ordering as for the fields below.

> + */
> +struct cdev_debugfs {
> +       u32 total;
> +       int current_state;
> +       ktime_t timestamp;
> +       struct list_head transitions[CDEVSTATS_HASH_SIZE];
> +       struct list_head durations[CDEVSTATS_HASH_SIZE];
> +};
> +
> +/**
> + * struct cdev_value - Common structure for cooling device entry
> + *
> + * The following common structure allows to store the information
> + * related to the transitions and to the state residencies. They are
> + * identified with a id which is associated to a value. It is used as
> + * nodes for the "transitions" and "durations" above.
> + *
> + * @node: node to insert the structure in a list
> + * @id: identifier of the value which can be a state or a transition
> + * @value: the id associated value which can be a duration or an occurre=
nce

s/an occurrence/a number of occurrences/  IIUC.

> + */
> +struct cdev_value {

I'm not sure about the name here.  I would rather call it cdev_record,
because it consists of two items, the id and the value.

> +       struct list_head node;
> +       int id;
> +       u64 value;

This is kind of a union, but sort of in disguise.

Why not make it a union proper, that is

struct cdev_record {
        struct list_head node;
        int id;
        union {
                krime_t residency; /* for duration records */
                u64 count; /* for occurrences records */
        } data;
};

which then would result in a bit cleaner code in some places below, if
I'm not mistaken?

> +};
> +
> +/**
> + * struct thermal_debugfs - High level structure for a thermal object in=
 debugfs
> + *
> + * The thermal_debugfs structure is the common structure used by the
> + * cooling device to compute the statistics.
> + *
> + * @d_top: top directory of the thermal object directory
> + * @lock: per object lock to protect the internals
> + *
> + * @cdev: a cooling device debug structure
> + */
> +struct thermal_debugfs {
> +       struct dentry *d_top;
> +       struct mutex lock;
> +       union {
> +               struct cdev_debugfs cdev;

I would call this cdev_dbg so it is not confused with a cooling device obje=
ct.

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

I'm not sure about the "fs" parts of the variable names here and
below.  It doesn't seem to mean anything in particular, so it would be
better to use something more meaningful IMV.  For example, this
particular pointer could be called thermdbg and pointers to the cdev
or thermal zone (in the next patch) data sets could be called cdev_dbg
and tz_dbg, respectively.

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
> +static struct cdev_value *thermal_debugfs_cdev_value_alloc(struct therma=
l_debugfs *dfs,
> +                                                          struct list_he=
ad *list, int id)

The analogous list_head pointer in the next function is called lists,
so this one could be called lists either.

> +{
> +       struct cdev_value *cdev_value;
> +
> +       cdev_value =3D kzalloc(sizeof(*cdev_value), GFP_KERNEL);
> +       if (cdev_value) {
> +               cdev_value->id =3D id;
> +               INIT_LIST_HEAD(&cdev_value->node);
> +               list_add_tail(&cdev_value->node, &list[cdev_value->id % C=
DEVSTATS_HASH_SIZE]);
> +       }

What about (using the names suggested above)

cdev_record =3D kzalloc(sizeof(*cdev_record), GFP_KERNEL);
if (!cdev_record)
        return NULL;

cdev_record->id =3D id;
list_add_tail(&cdev_record->node, &lists[cdev_record->id %
CDEVSTATS_HASH_SIZE]);

> +
> +       return cdev_value;
> +}

BTW, a list_head need not be initialized before adding it to an existing li=
st.

> +
> +static struct cdev_value *thermal_debugfs_cdev_value_find(struct thermal=
_debugfs *dfs,
> +                                                         struct list_hea=
d *lists, int id)
> +{
> +       struct cdev_value *entry;
> +
> +       list_for_each_entry(entry, &lists[id % CDEVSTATS_HASH_SIZE], node=
)
> +               if (entry->id =3D=3D id)
> +                       return entry;
> +
> +       return NULL;
> +}
> +
> +static struct cdev_value *thermal_debugfs_cdev_value_get(struct thermal_=
debugfs *dfs,
> +                                                        struct list_head=
 *list, int id)

And here?

> +{
> +       struct cdev_value *cdev_value;
> +
> +       cdev_value =3D thermal_debugfs_cdev_value_find(dfs, list, id);
> +       if (cdev_value)
> +               return cdev_value;
> +
> +       return thermal_debugfs_cdev_value_alloc(dfs, list, id);
> +}
> +
> +static void thermal_debugfs_cdev_clear(struct cdev_debugfs *cfs)
> +{
> +       int i;
> +       struct cdev_value *entry, *tmp;
> +
> +       for (i =3D 0; i < CDEVSTATS_HASH_SIZE; i++) {
> +
> +               list_for_each_entry_safe(entry, tmp, &cfs->transitions[i]=
, node) {
> +                       list_del(&entry->node);
> +                       kfree(entry);
> +               }
> +
> +               list_for_each_entry_safe(entry, tmp, &cfs->durations[i], =
node) {
> +                       list_del(&entry->node);
> +                       kfree(entry);
> +               }
> +       }
> +
> +       cfs->total =3D 0;
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
> +       struct list_head *transitions =3D cfs->transitions;
> +       struct cdev_value *entry;
> +       int i =3D *(loff_t *)v;
> +
> +       if (!i)
> +               seq_puts(s, "Transition\tOccurences\n");
> +
> +       list_for_each_entry(entry, &transitions[i], node) {
> +               /*
> +                * Assuming maximum cdev states is 1024, the longer
> +                * string for a transition would be "1024->1024\0"
> +                */
> +               char buffer[11];
> +
> +               snprintf(buffer, ARRAY_SIZE(buffer), "%d->%d",
> +                        entry->id >> 16, entry->id & 0xFFFF);
> +
> +               seq_printf(s, "%-10s\t%-10llu\n", buffer, entry->value);
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
> +       struct thermal_debugfs *dfs =3D s->private;
> +       struct cdev_debugfs *cfs =3D &dfs->cdev;
> +       struct list_head *durations =3D cfs->durations;
> +       struct cdev_value *entry;
> +       int i =3D *(loff_t *)v;
> +
> +       if (!i)
> +               seq_puts(s, "State\tResidency\n");
> +
> +       list_for_each_entry(entry, &durations[i], node) {
> +               s64 duration =3D entry->value;
> +
> +               if (entry->id =3D=3D cfs->current_state)
> +                       duration +=3D ktime_ms_delta(ktime_get(), cfs->ti=
mestamp);
> +
> +               seq_printf(s, "%-5d\t%-10llu\n", entry->id, duration);
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
> +
> +static int cdev_clear_set(void *data, u64 val)
> +{
> +       struct thermal_debugfs *dfs =3D data;
> +
> +       if (!val)
> +               return -EINVAL;
> +
> +       mutex_lock(&dfs->lock);
> +
> +       thermal_debugfs_cdev_clear(&dfs->cdev);
> +
> +       mutex_unlock(&dfs->lock);
> +
> +       return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(cdev_clear_fops, NULL, cdev_clear_set, "%llu\n"=
);
> +
> +/**
> + * thermal_debug_cdev_state_update - Update a cooling device state chang=
e
> + *
> + * Computes a transition and the duration of the previous state residenc=
y.
> + *
> + * @cdev : a pointer to a cooling device
> + * @new_state: an integer corresponding to the new cooling device state
> + */
> +void thermal_debug_cdev_state_update(const struct thermal_cooling_device=
 *cdev,
> +                                    int new_state)
> +{
> +       struct thermal_debugfs *dfs =3D cdev->debugfs;
> +       struct cdev_debugfs *cfs;
> +       struct cdev_value *cdev_value;
> +       ktime_t now =3D ktime_get();

I'd call ktime_get() right before using now for the first time.

> +       int transition, old_state;
> +
> +       if (!dfs || (dfs->cdev.current_state =3D=3D new_state))
> +               return;
> +
> +       mutex_lock(&dfs->lock);
> +
> +       cfs =3D &dfs->cdev;
> +
> +       old_state =3D cfs->current_state;

Because new_state and transition are only used later, after the
duration record has been processed, I would move the next two lines
after the if () below.

> +       cfs->current_state =3D new_state;
> +       transition =3D (old_state << 16) | new_state;
> +
> +       /*
> +        * Get the old state information in the durations list. If
> +        * this one does not exist, a new allocated one will be
> +        * returned. Recompute the total duration in the old state and
> +        * get a new timestamp for the new state.
> +        */
> +       cdev_value =3D thermal_debugfs_cdev_value_get(dfs, cfs->durations=
, old_state);
> +       if (cdev_value) {
> +               cdev_value->value +=3D ktime_ms_delta(now, cfs->timestamp=
);

Use ktime_add() here and convert to ms when printing the record?

> +               cfs->timestamp =3D now;
> +       }
> +
> +       /*
> +        * Get the transition in the transitions list. If this one
> +        * does not exist, a new allocated one will be returned.
> +        * Increment the occurrence of this transition which is stored
> +        * in the value field.
> +        */
> +       cdev_value =3D thermal_debugfs_cdev_value_get(dfs, cfs->transitio=
ns,
> +                                                   transition);
> +       if (cdev_value)
> +               cdev_value->value++;
> +
> +       cfs->total++;
> +
> +       mutex_unlock(&dfs->lock);
> +}
> +
> +/**
> + * thermal_debug_cdev_add - Add a cooling device debugfs entry
> + *
> + * Allocates a cooling device object for debug, initializes the
> + * statistics and create the entries in sysfs.
> + * @cdev: a pointer to a cooling device
> + */
> +void thermal_debug_cdev_add(struct thermal_cooling_device *cdev)
> +{
> +       struct thermal_debugfs *dfs;
> +       struct cdev_debugfs *cfs;
> +       int i;
> +
> +       dfs =3D thermal_debugfs_add_id(d_cdev, cdev->id);
> +       if (!dfs)
> +               return;
> +
> +       cfs =3D &dfs->cdev;
> +
> +       for (i =3D 0; i < CDEVSTATS_HASH_SIZE; i++) {
> +               INIT_LIST_HEAD(&cfs->transitions[i]);
> +               INIT_LIST_HEAD(&cfs->durations[i]);
> +       }
> +
> +       cfs->current_state =3D 0;
> +       cfs->timestamp =3D ktime_get();
> +
> +       debugfs_create_file("trans_table", 0400, dfs->d_top, dfs, &tt_fop=
s);
> +
> +       debugfs_create_file("time_in_state_ms", 0400, dfs->d_top, dfs, &d=
t_fops);
> +
> +       debugfs_create_file("clear", 0200, dfs->d_top, dfs, &cdev_clear_f=
ops);
> +
> +       debugfs_create_u32("total_trans", 0400, dfs->d_top, &cfs->total);
> +
> +       cdev->debugfs =3D dfs;
> +}
> +
> +/**
> + * thermal_debug_cdev_remove - Remove a cooling device debugfs entry
> + *
> + * Frees the statistics memory data and remove the debugfs entry
> + *
> + * @cdev: a pointer to a cooling device
> + */
> +void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev)
> +{
> +       struct thermal_debugfs *dfs =3D cdev->debugfs;
> +
> +       if (!dfs)
> +               return;
> +
> +       mutex_lock(&dfs->lock);
> +
> +       thermal_debugfs_cdev_clear(&dfs->cdev);
> +       cdev->debugfs =3D NULL;
> +       thermal_debugfs_remove_id(dfs);
> +
> +       mutex_unlock(&dfs->lock);
> +}
> diff --git a/drivers/thermal/thermal_debugfs.h b/drivers/thermal/thermal_=
debugfs.h
> new file mode 100644
> index 000000000000..341499388448
> --- /dev/null
> +++ b/drivers/thermal/thermal_debugfs.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifdef CONFIG_THERMAL_DEBUGFS
> +void thermal_debug_init(void);
> +void thermal_debug_cdev_add(struct thermal_cooling_device *cdev);
> +void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev);
> +void thermal_debug_cdev_state_update(const struct thermal_cooling_device=
 *cdev, int state);
> +#else
> +static inline void thermal_debug_init(void) {}
> +static inline void thermal_debug_cdev_add(struct thermal_cooling_device =
*cdev) {}
> +static inline void thermal_debug_cdev_remove(struct thermal_cooling_devi=
ce *cdev) {}
> +static inline void thermal_debug_cdev_state_update(const struct thermal_=
cooling_device *cdev,
> +                                                  int state) {}
> +#endif /* CONFIG_THERMAL_DEBUGFS */
> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_=
helpers.c
> index 69e8ea4aa908..435c123b721b 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -151,14 +151,29 @@ int thermal_zone_get_temp(struct thermal_zone_devic=
e *tz, int *temp)
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
>
> -static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cd=
ev,
> -                                      int target)
> +void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_m=
s)
>  {
> -       if (cdev->ops->set_cur_state(cdev, target))
> -               return;
> +       *delay_jiffies =3D msecs_to_jiffies(delay_ms);
> +       if (delay_ms > 1000)
> +               *delay_jiffies =3D round_jiffies(*delay_jiffies);
> +}

This adds a function that's never used AFAICS.  I suppose the next
patch will use it?

The rest of the patch LGTM.

Thanks!

