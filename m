Return-Path: <linux-kernel+bounces-146932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDC88A6D29
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74CD285504
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894D312D1FA;
	Tue, 16 Apr 2024 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPCGgbvk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE74F12D1FD;
	Tue, 16 Apr 2024 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275919; cv=none; b=n3IloXmCJCZYv5QTLxrE6LFXtipH1edKfXnolMv3BM3kKqdLYQ8ORlCiVJF8QbTGe94uCZGY7IQgMbmU0E8ta54DKblabIqAjv6+MOQONXHfdiZS8s0y548PcW3t6s/iCXxEEu/lSUyapSdWnNDHrPuJfOo2rxbYCUn++M0kMwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275919; c=relaxed/simple;
	bh=qiMtlWLQBuDJEmarsoWn+0pogGp2imDpo3hzosB4U/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIpPZB4WqIij6a8FgCkA4nkz4JAZYIw6TLOwy2tn1B21P7OOaLIJKVZLDkHziRsQqkW/eCPQplpRmUI1kS9n9rxpeNkKV/kgathkDKJV7K0zYhVfMggi9jVzSAVjWySzk+HQqMD2LeNmNEOcU0lTCEBq0C9hKmRPSXVQiS6oAg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPCGgbvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA52C2BD10;
	Tue, 16 Apr 2024 13:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713275919;
	bh=qiMtlWLQBuDJEmarsoWn+0pogGp2imDpo3hzosB4U/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HPCGgbvkEOPFqFI6YeL8R1B+noFCRQ/PyKU5MX/dFVn6gTtQlrjdOo/WiJKl+pHgA
	 7kuppxjFdcn/f6apjdYFd4MJLa9OhVGq+DOP74+W53BeDMWz4npOLsfy+6YSIQ3RU2
	 UlPnLD0TO9tOO6zOQSQ3uXQvhHwxzuCGRaKg03aI2By3o4HA72OXL/VzviugGMzGlQ
	 IH6aa6UFMK+ljnOptL09mh6NPRPHdRAS0sFFWNjNyZUakqSeVh0K3tT1Fg7NZL/8Yy
	 Khvns+gH1ok5Lay0lKuBGdQrg7yCYCQDiKKuYZk+TftU2fNxARW+sguZ/57lYB3KCK
	 OSfl9PM4bux1g==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-22ed9094168so577634fac.1;
        Tue, 16 Apr 2024 06:58:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+CLnej2qxNULHRbUc+V+/ENNWl791NZ2TfSyOUzpDNjqRAntY6Q00ey4Mv3H+aVkpo0JHmKV0EcvGPc7CxmVYH2gC+iKuZQEx4nbKKhC2Y5iTDDw4wI0f0CeES62yJ5cXM9BcH8w=
X-Gm-Message-State: AOJu0Yzx6gMVwOs8lgI0z/uy57icBNwq3JRdZtbEUhT6hxQk/viNnGlG
	6xBdA1CnhjysTdrgoWmz/ATsU1m6tXZZlPGCwqkRwjSvzmf6y4Rf9EXH6BvYo+LvlHOR4wiNizo
	Pw9e6dicR/PbknX+Y0iCD/dbfvlo=
X-Google-Smtp-Source: AGHT+IEH20d2St6SpAvk8nEebO1LVFSw33YoqUiLhHHQQExfjq6JGxcwqkzm0/Hep3oYP27QmpxJNmCj5o3hHBSChIs=
X-Received: by 2002:a05:6871:7420:b0:234:5785:bca with SMTP id
 nw32-20020a056871742000b0023457850bcamr8585806oac.3.1713275918439; Tue, 16
 Apr 2024 06:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408035141.248644-1-rui.zhang@intel.com> <20240408035141.248644-3-rui.zhang@intel.com>
In-Reply-To: <20240408035141.248644-3-rui.zhang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Apr 2024 15:58:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hDdTS++iWLYDnoVotV3=e=Vn2di4EjUBJzHiNLzrbaig@mail.gmail.com>
Message-ID: <CAJZ5v0hDdTS++iWLYDnoVotV3=e=Vn2di4EjUBJzHiNLzrbaig@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] powercap: intel_rapl: Introduce APIs for PMU support
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 5:52=E2=80=AFAM Zhang Rui <rui.zhang@intel.com> wrot=
e:
>
> Introduce two new APIs rapl_package_add_pmu()/rapl_package_remove_pmu().
>
> RAPL driver can invoke these APIs to expose its supported energy
> counters via perf PMU. The new RAPL PMU is fully compatible with current
> MSR RAPL PMU, including using the same PMU name and events
> name/id/unit/scale, etc.
>
> For example, use below command
>  perf stat -e power/energy-pkg/ -e power/energy-ram/ -e power/energy-core=
s/ FOO
> to get the energy consumption for events in the "perf list" output.
>
> This does not introduce any conflict because TPMI RAPL is the only user
> of these APIs currently, and it never co-exists with MSR RAPL.
>
> Note that, TPMI RAPL is probed dynamically, and the events supported by
> each TPMI RAPL device can be different. Thus, for a new RAPL Package
> device that wants PMU support,
> 1. if PMU has not been registered yet, register the PMU with events
>    supported by current RAPL Package device
> 2. if PMU has been registered and no new events support is needed, do
>    nothing
> 2. or else, unregister current PMU and re-register the PMU with events
>    supported by all probed RAPL Package devices that need PMU support.
>    For example, on a dual-package system using TPMI RAPL, it is possible
>    that Package 1 behaves as TPMI domain root and supports Psys domain.
>    In this case, register PMU without Psys event when probing Package 0,
>    and re-register the PMU with Psys event when probing Package 1.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 537 +++++++++++++++++++++++++++
>  include/linux/intel_rapl.h           |  23 ++
>  2 files changed, 560 insertions(+)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index 1f4a7aa12d77..f51012f023b0 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -15,6 +15,8 @@
>  #include <linux/list.h>
>  #include <linux/log2.h>
>  #include <linux/module.h>
> +#include <linux/nospec.h>
> +#include <linux/perf_event.h>
>  #include <linux/platform_device.h>
>  #include <linux/powercap.h>
>  #include <linux/processor.h>
> @@ -1506,6 +1508,541 @@ static int rapl_detect_domains(struct rapl_packag=
e *rp)
>         return 0;
>  }
>
> +#ifdef CONFIG_PERF_EVENTS
> +
> +/* Support for RAPL PMU */

It would be good to add some details regarding the implementation etc.
to this comment.

> +
> +struct rapl_pmu {
> +       struct pmu pmu;
> +       u64 timer_ms;
> +       cpumask_t cpu_mask;
> +       unsigned long domain_map;       /* Events supported by all regist=
ered RAPL packages */
> +       bool registered;
> +};

The structure fields need to be documented.

> +
> +static struct rapl_pmu rapl_pmu;
> +
> +/* PMU helpers */

A blank like here?

> +static int get_pmu_cpu(struct rapl_package *rp)
> +{
> +       int cpu;
> +
> +       if (!rp->has_pmu)
> +               return nr_cpu_ids;
> +
> +       if (rp->lead_cpu >=3D 0)
> +               return rp->lead_cpu;
> +
> +       /* TPMI RAPL uses any CPU in the package for PMU */
> +       for_each_online_cpu(cpu)
> +               if (topology_physical_package_id(cpu) =3D=3D rp->id)
> +                       return cpu;
> +
> +       return nr_cpu_ids;
> +}
> +
> +static bool is_rp_pmu_cpu(struct rapl_package *rp, int cpu)
> +{
> +       if (!rp->has_pmu)
> +               return false;
> +
> +       if (rp->lead_cpu >=3D 0)
> +               return cpu =3D=3D rp->lead_cpu;

So if the given CPU is not the lead CPU, but it is located in the same
package as the lead CPU, the function will return 'false'.  TBH, this
is somewhat confusing.

> +
> +       /* TPMI RAPL uses any CPU in the package for PMU */
> +       return topology_physical_package_id(cpu) =3D=3D rp->id;
> +}
> +
> +static struct rapl_package_pmu_data *event_to_pmu_data(struct perf_event=
 *event)
> +{
> +       struct rapl_package *rp =3D event->pmu_private;
> +
> +       return &rp->pmu_data;
> +}
> +
> +/* PMU event callbacks */
> +
> +/* Return 0 for unsupported events or failed read */

Can you put this comment into the function body?

> +static u64 event_read_counter(struct perf_event *event)
> +{
> +       struct rapl_package *rp =3D event->pmu_private;
> +       u64 val;
> +       int ret;
> +
> +       if (event->hw.idx < 0)
> +               return 0;
> +
> +       ret =3D rapl_read_data_raw(&rp->domains[event->hw.idx], ENERGY_CO=
UNTER, false, &val);
> +       return ret ? 0 : val;

I would prefer

if (ret)
    return 0;

return val;

> +}
> +
> +static void __rapl_pmu_event_start(struct perf_event *event)
> +{
> +       struct rapl_package_pmu_data *data =3D event_to_pmu_data(event);
> +
> +       if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
> +               return;
> +
> +       event->hw.state =3D 0;
> +
> +       list_add_tail(&event->active_entry, &data->active_list);
> +
> +       local64_set(&event->hw.prev_count, event_read_counter(event));
> +       if (++data->n_active =3D=3D 1)
> +               hrtimer_start(&data->hrtimer, data->timer_interval,
> +                             HRTIMER_MODE_REL_PINNED);
> +}
> +
> +static void rapl_pmu_event_start(struct perf_event *event, int mode)
> +{
> +       struct rapl_package_pmu_data *data =3D event_to_pmu_data(event);
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&data->lock, flags);
> +       __rapl_pmu_event_start(event);
> +       raw_spin_unlock_irqrestore(&data->lock, flags);

Why does it need to be raw_spin_lock_?

What exactly is protected by data->lock?

> +}
> +
> +static u64 rapl_event_update(struct perf_event *event)
> +{
> +       struct hw_perf_event *hwc =3D &event->hw;
> +       struct rapl_package_pmu_data *data =3D event_to_pmu_data(event);
> +       u64 prev_raw_count, new_raw_count;
> +       s64 delta, sdelta;
> +
> +again:
> +       prev_raw_count =3D local64_read(&hwc->prev_count);
> +       new_raw_count =3D event_read_counter(event);
> +
> +       if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
> +                       new_raw_count) !=3D prev_raw_count)
> +               goto again;

It would be somewhat easier to follow if an additional u64 variable were us=
ed:

do {
      prev_raw_count =3D local64_read(&hwc->prev_count);
      new_raw_count =3D event_read_counter(event);
      tmp =3D (local64_cmpxchg(&hwc->prev_count, prev_raw_count, new_raw_co=
unt);
} while (tmp !=3D prev_raw_count);

> +
> +       /*
> +        * Now we have the new raw value and have updated the prev
> +        * timestamp already. We can now calculate the elapsed delta
> +        * (event-)time and add that to the generic event.
> +        */
> +       delta =3D new_raw_count - prev_raw_count;
> +
> +       /*
> +        * Scale delta to smallest unit (2^-32)
> +        * users must then scale back: count * 1/(1e9*2^32) to get Joules
> +        * or use ldexp(count, -32).
> +        * Watts =3D Joules/Time delta
> +        */
> +       sdelta =3D delta * data->scale[event->hw.flags];
> +
> +       local64_add(sdelta, &event->count);
> +
> +       return new_raw_count;
> +}
> +
> +static void rapl_pmu_event_stop(struct perf_event *event, int mode)
> +{
> +       struct rapl_package_pmu_data *data =3D event_to_pmu_data(event);
> +       struct hw_perf_event *hwc =3D &event->hw;
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&data->lock, flags);
> +
> +       /* Mark event as deactivated and stopped */
> +       if (!(hwc->state & PERF_HES_STOPPED)) {
> +               WARN_ON_ONCE(data->n_active <=3D 0);
> +               if (--data->n_active =3D=3D 0)
> +                       hrtimer_cancel(&data->hrtimer);
> +
> +               list_del(&event->active_entry);
> +
> +               WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
> +               hwc->state |=3D PERF_HES_STOPPED;
> +       }
> +
> +       /* Check if update of sw counter is necessary */
> +       if ((mode & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE))=
 {
> +               /*
> +                * Drain the remaining delta count out of a event
> +                * that we are disabling:
> +                */
> +               rapl_event_update(event);
> +               hwc->state |=3D PERF_HES_UPTODATE;
> +       }
> +
> +       raw_spin_unlock_irqrestore(&data->lock, flags);
> +}
> +
> +static int rapl_pmu_event_add(struct perf_event *event, int mode)
> +{
> +       struct rapl_package_pmu_data *data =3D event_to_pmu_data(event);
> +       struct hw_perf_event *hwc =3D &event->hw;
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&data->lock, flags);
> +
> +       hwc->state =3D PERF_HES_UPTODATE | PERF_HES_STOPPED;
> +
> +       if (mode & PERF_EF_START)
> +               __rapl_pmu_event_start(event);
> +
> +       raw_spin_unlock_irqrestore(&data->lock, flags);
> +
> +       return 0;
> +}
> +
> +static void rapl_pmu_event_del(struct perf_event *event, int flags)
> +{
> +       rapl_pmu_event_stop(event, PERF_EF_UPDATE);
> +}
> +
> +/*
> + * RAPL energy status counters
> + */
> +enum perf_rapl_events {
> +       PERF_RAPL_PP0 =3D 0,      /* all cores */
> +       PERF_RAPL_PKG,          /* entire package */
> +       PERF_RAPL_RAM,          /* DRAM */
> +       PERF_RAPL_PP1,          /* gpu */
> +       PERF_RAPL_PSYS,         /* psys */
> +};
> +#define RAPL_EVENT_MASK GENMASK(7, 0)
> +
> +static int event_to_domain(int event)
> +{
> +       switch (event) {
> +       case PERF_RAPL_PP0:
> +               return RAPL_DOMAIN_PP0;
> +       case PERF_RAPL_PKG:
> +               return RAPL_DOMAIN_PACKAGE;
> +       case PERF_RAPL_RAM:
> +               return RAPL_DOMAIN_DRAM;
> +       case PERF_RAPL_PP1:
> +               return RAPL_DOMAIN_PP1;
> +       case PERF_RAPL_PSYS:
> +               return RAPL_DOMAIN_PLATFORM;
> +       default:
> +               return RAPL_DOMAIN_MAX;
> +       }
> +}

IMV it would be somewhat cleaner to use an array instead of this
wrapper around switch ().

> +
> +static int rapl_pmu_event_init(struct perf_event *event)
> +{
> +       struct rapl_package *pos, *rp =3D NULL;
> +       u64 cfg =3D event->attr.config & RAPL_EVENT_MASK;
> +       int domain, idx;
> +
> +       /* Only look at RAPL events */
> +       if (event->attr.type !=3D event->pmu->type)
> +               return -ENOENT;
> +
> +       /* Check only supported bits are set */
> +       if (event->attr.config & ~RAPL_EVENT_MASK)
> +               return -EINVAL;
> +
> +       if (event->cpu < 0)
> +               return -EINVAL;
> +
> +       /* Find out which Package the event belongs to */
> +       list_for_each_entry(pos, &rapl_packages, plist) {
> +               if (is_rp_pmu_cpu(pos, event->cpu)) {
> +                       rp =3D pos;
> +                       break;
> +               }
> +       }
> +       if (!rp)
> +               return -ENODEV;
> +
> +       /* Find out which RAPL Domain the event belongs to */
> +       domain =3D event_to_domain(cfg - 1);
> +       if (domain >=3D RAPL_DOMAIN_MAX)
> +               return -EINVAL;
> +
> +       event->event_caps |=3D PERF_EV_CAP_READ_ACTIVE_PKG;
> +       event->pmu_private =3D rp;        /* Which package */
> +       event->hw.flags =3D domain;       /* Which domain */
> +
> +       event->hw.idx =3D -1;
> +       /* Find out the index in rp->domains[] to get domain pointer */
> +       for (idx =3D 0; idx < rp->nr_domains; idx++) {
> +               if (rp->domains[idx].id =3D=3D domain) {
> +                       event->hw.idx =3D idx;
> +                       break;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static void rapl_pmu_event_read(struct perf_event *event)
> +{
> +       rapl_event_update(event);
> +}
> +
> +static enum hrtimer_restart rapl_hrtimer_handle(struct hrtimer *hrtimer)
> +{
> +       struct rapl_package_pmu_data *data =3D
> +               container_of(hrtimer, struct rapl_package_pmu_data, hrtim=
er);
> +       struct perf_event *event;
> +       unsigned long flags;
> +
> +       if (!data->n_active)
> +               return HRTIMER_NORESTART;
> +
> +       raw_spin_lock_irqsave(&data->lock, flags);
> +
> +       list_for_each_entry(event, &data->active_list, active_entry)
> +               rapl_event_update(event);
> +
> +       raw_spin_unlock_irqrestore(&data->lock, flags);
> +
> +       hrtimer_forward_now(hrtimer, data->timer_interval);
> +
> +       return HRTIMER_RESTART;
> +}
> +
> +/* PMU sysfs attributes */
> +
> +/*
> + * There are no default events, but we need to create "events" group (wi=
th
> + * empty attrs) before updating it with detected events.
> + */
> +static struct attribute *attrs_empty[] =3D {
> +       NULL,
> +};
> +
> +static struct attribute_group pmu_events_group =3D {
> +       .name =3D "events",
> +       .attrs =3D attrs_empty,
> +};
> +
> +static ssize_t cpumask_show(struct device *dev,
> +                           struct device_attribute *attr, char *buf)
> +{
> +       struct rapl_package *rp;
> +       int cpu;
> +
> +       cpus_read_lock();

Is rapl_packages protected by this?

> +       cpumask_clear(&rapl_pmu.cpu_mask);

It doesn't look like rapl_pmu.cpu_mask is used outside this function,
so why is it global?

> +
> +       /* Choose a cpu for each RAPL Package */
> +       list_for_each_entry(rp, &rapl_packages, plist) {
> +               cpu =3D get_pmu_cpu(rp);
> +               if (cpu < nr_cpu_ids)
> +                       cpumask_set_cpu(cpu, &rapl_pmu.cpu_mask);
> +       }
> +       cpus_read_unlock();
> +
> +       return cpumap_print_to_pagebuf(true, buf, &rapl_pmu.cpu_mask);
> +}
> +
> +static DEVICE_ATTR_RO(cpumask);
> +
> +static struct attribute *pmu_cpumask_attrs[] =3D {
> +       &dev_attr_cpumask.attr,
> +       NULL
> +};
> +
> +static struct attribute_group pmu_cpumask_group =3D {
> +       .attrs =3D pmu_cpumask_attrs,
> +};
> +
> +PMU_FORMAT_ATTR(event, "config:0-7");
> +static struct attribute *pmu_format_attr[] =3D {
> +       &format_attr_event.attr,
> +       NULL
> +};
> +
> +static struct attribute_group pmu_format_group =3D {
> +       .name =3D "format",
> +       .attrs =3D pmu_format_attr,
> +};
> +
> +static const struct attribute_group *pmu_attr_groups[] =3D {
> +       &pmu_events_group,
> +       &pmu_cpumask_group,
> +       &pmu_format_group,
> +       NULL
> +};
> +
> +#define RAPL_EVENT_ATTR_STR(_name, v, str)                              =
       \
> +static struct perf_pmu_events_attr event_attr_##v =3D {                 =
         \
> +       .attr           =3D __ATTR(_name, 0444, perf_event_sysfs_show, NU=
LL),     \
> +       .event_str      =3D str,                                         =
         \
> +}
> +
> +RAPL_EVENT_ATTR_STR(energy-cores,      rapl_cores,     "event=3D0x01");
> +RAPL_EVENT_ATTR_STR(energy-pkg,                rapl_pkg,       "event=3D=
0x02");
> +RAPL_EVENT_ATTR_STR(energy-ram,                rapl_ram,       "event=3D=
0x03");
> +RAPL_EVENT_ATTR_STR(energy-gpu,                rapl_gpu,       "event=3D=
0x04");
> +RAPL_EVENT_ATTR_STR(energy-psys,       rapl_psys,      "event=3D0x05");
> +
> +RAPL_EVENT_ATTR_STR(energy-cores.unit, rapl_unit_cores,        "Joules")=
;
> +RAPL_EVENT_ATTR_STR(energy-pkg.unit,   rapl_unit_pkg,          "Joules")=
;
> +RAPL_EVENT_ATTR_STR(energy-ram.unit,   rapl_unit_ram,          "Joules")=
;
> +RAPL_EVENT_ATTR_STR(energy-gpu.unit,   rapl_unit_gpu,          "Joules")=
;
> +RAPL_EVENT_ATTR_STR(energy-psys.unit,  rapl_unit_psys,         "Joules")=
;
> +
> +RAPL_EVENT_ATTR_STR(energy-cores.scale,        rapl_scale_cores,       "=
2.3283064365386962890625e-10");
> +RAPL_EVENT_ATTR_STR(energy-pkg.scale,  rapl_scale_pkg,         "2.328306=
4365386962890625e-10");
> +RAPL_EVENT_ATTR_STR(energy-ram.scale,  rapl_scale_ram,         "2.328306=
4365386962890625e-10");
> +RAPL_EVENT_ATTR_STR(energy-gpu.scale,  rapl_scale_gpu,         "2.328306=
4365386962890625e-10");
> +RAPL_EVENT_ATTR_STR(energy-psys.scale, rapl_scale_psys,        "2.328306=
4365386962890625e-10");
> +
> +#define RAPL_EVENT_GROUP(_name, domain)                        \
> +static struct attribute *pmu_attr_##_name[] =3D {                \
> +       &event_attr_rapl_##_name.attr.attr,             \
> +       &event_attr_rapl_unit_##_name.attr.attr,        \
> +       &event_attr_rapl_scale_##_name.attr.attr,       \
> +       NULL                                            \
> +};                                                     \
> +static umode_t is_visible_##_name(struct kobject *kobj, struct attribute=
 *attr, int event)     \
> +{                                                                       =
               \
> +       return rapl_pmu.domain_map & BIT(domain) ? attr->mode : 0;      \
> +}                                                      \
> +static struct attribute_group pmu_group_##_name =3D {    \
> +       .name  =3D "events",                              \
> +       .attrs =3D pmu_attr_##_name,                      \
> +       .is_visible =3D is_visible_##_name,               \
> +}
> +
> +RAPL_EVENT_GROUP(cores,        RAPL_DOMAIN_PP0);
> +RAPL_EVENT_GROUP(pkg,  RAPL_DOMAIN_PACKAGE);
> +RAPL_EVENT_GROUP(ram,  RAPL_DOMAIN_DRAM);
> +RAPL_EVENT_GROUP(gpu,  RAPL_DOMAIN_PP1);
> +RAPL_EVENT_GROUP(psys, RAPL_DOMAIN_PLATFORM);
> +
> +static const struct attribute_group *pmu_attr_update[] =3D {
> +       &pmu_group_cores,
> +       &pmu_group_pkg,
> +       &pmu_group_ram,
> +       &pmu_group_gpu,
> +       &pmu_group_psys,
> +       NULL
> +};
> +
> +static int rapl_pmu_update(struct rapl_package *rp)
> +{
> +       int ret;
> +
> +       /* Return if PMU already covers all events supported by current R=
APL Package */
> +       if (rapl_pmu.registered && !(rp->domain_map & (~rapl_pmu.domain_m=
ap)))
> +               return 0;
> +
> +       /* Unregister previous registered PMU */
> +       if (rapl_pmu.registered) {
> +               perf_pmu_unregister(&rapl_pmu.pmu);
> +               memset(&rapl_pmu.pmu, 0, sizeof(struct pmu));
> +       }
> +
> +       rapl_pmu.domain_map |=3D rp->domain_map;
> +
> +       memset(&rapl_pmu.pmu, 0, sizeof(struct pmu));
> +       rapl_pmu.pmu.attr_groups =3D pmu_attr_groups;
> +       rapl_pmu.pmu.attr_update =3D pmu_attr_update;
> +       rapl_pmu.pmu.task_ctx_nr =3D perf_invalid_context;
> +       rapl_pmu.pmu.event_init =3D rapl_pmu_event_init;
> +       rapl_pmu.pmu.add =3D rapl_pmu_event_add;
> +       rapl_pmu.pmu.del =3D rapl_pmu_event_del;
> +       rapl_pmu.pmu.start =3D rapl_pmu_event_start;
> +       rapl_pmu.pmu.stop =3D rapl_pmu_event_stop;
> +       rapl_pmu.pmu.read =3D rapl_pmu_event_read;
> +       rapl_pmu.pmu.module =3D THIS_MODULE;
> +       rapl_pmu.pmu.capabilities =3D PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_=
CAP_NO_INTERRUPT;
> +       ret =3D perf_pmu_register(&rapl_pmu.pmu, "power", -1);
> +       if (ret)
> +               pr_warn("Failed to register PMU\n");
> +
> +       rapl_pmu.registered =3D !ret;

Why don't you set rp->has_pmu here?

> +
> +       return ret;

It looks like this could be rearranged overall for more clarity:

ret =3D perf_pmu_register(&rapl_pmu.pmu, "power", -1);
if (ret) {
        pr_warn("Failed to register PMU\n");
        return ret;
}

rapl_pmu.registered =3D true;
rp->has_pmu =3D true;

return 0;

Also, the "Failed to register PMU\n" message is not particularly
useful AFAICS.  It would be good to add some more context to it and
maybe make it pr_info()?

> +}
> +
> +int rapl_package_add_pmu(struct rapl_package *rp)
> +{
> +       struct rapl_package_pmu_data *data =3D &rp->pmu_data;
> +       int idx;
> +       int ret;
> +
> +       if (rp->has_pmu)
> +               return -EEXIST;
> +
> +       guard(cpus_read_lock)();

Why does this lock need to be held around the entire code below?

> +
> +       for (idx =3D 0; idx < rp->nr_domains; idx++) {
> +               struct rapl_domain *rd =3D &rp->domains[idx];
> +               int domain =3D rd->id;
> +               u64 val;
> +
> +               if (!test_bit(domain, &rp->domain_map))
> +                       continue;
> +
> +               /*
> +                * The RAPL PMU granularity is 2^-32 Joules
> +                * data->scale[]: times of 2^-32 Joules for each ENERGY C=
OUNTER increase
> +                */
> +               val =3D rd->energy_unit * (1ULL << 32);
> +               do_div(val, ENERGY_UNIT_SCALE * 1000000);
> +               data->scale[domain] =3D val;
> +
> +               if (!rapl_pmu.timer_ms) {
> +                       struct rapl_primitive_info *rpi =3D get_rpi(rp, E=
NERGY_COUNTER);
> +
> +                       /*
> +                        * Calculate the timer rate:
> +                        * Use reference of 200W for scaling the timeout =
to avoid counter
> +                        * overflows.
> +                        *
> +                        * max_count =3D rpi->mask >> rpi->shift + 1
> +                        * max_energy_pj =3D max_count * rd->energy_unit
> +                        * max_time_sec =3D (max_energy_pj / 1000000000) =
/ 200w
> +                        *
> +                        * rapl_pmu.timer_ms =3D max_time_sec * 1000 / 2
> +                        */
> +                       val =3D (rpi->mask >> rpi->shift) + 1;
> +                       val *=3D rd->energy_unit;
> +                       do_div(val, 1000000 * 200 * 2);
> +                       rapl_pmu.timer_ms =3D val;
> +
> +                       pr_info("%llu ms ovfl timer\n", rapl_pmu.timer_ms=
);

s/ovfl/overflow/

And use pr_debug()?

> +               }
> +
> +               pr_info("Domain %s: hw unit %lld * 2^-32 Joules\n", rd->n=
ame, data->scale[domain]);

pr_debug() here too?

> +       }
> +
> +       /* Initialize per package PMU data */
> +       raw_spin_lock_init(&data->lock);
> +       INIT_LIST_HEAD(&data->active_list);
> +       data->timer_interval =3D ms_to_ktime(rapl_pmu.timer_ms);
> +       hrtimer_init(&data->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +       data->hrtimer.function =3D rapl_hrtimer_handle;
> +
> +       ret =3D rapl_pmu_update(rp);
> +       if (!ret)
> +               rp->has_pmu =3D true;
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(rapl_package_add_pmu);
> +
> +void rapl_package_remove_pmu(struct rapl_package *rp)
> +{
> +       struct rapl_package *pos;
> +
> +       if (!rp->has_pmu)
> +               return;
> +
> +       guard(cpus_read_lock)();
> +
> +       list_for_each_entry(pos, &rapl_packages, plist) {

rp can be used for walking this list, can't it?

> +               /* PMU is still needed */
> +               if (pos->has_pmu)
> +                       return;
> +       }
> +
> +       perf_pmu_unregister(&rapl_pmu.pmu);
> +       memset(&rapl_pmu, 0, sizeof(struct rapl_pmu));
> +}
> +EXPORT_SYMBOL_GPL(rapl_package_remove_pmu);
> +#endif
> +
>  /* called from CPU hotplug notifier, hotplug lock held */
>  void rapl_remove_package_cpuslocked(struct rapl_package *rp)
>  {
> diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
> index f3196f82fd8a..38e43dbb3dac 100644
> --- a/include/linux/intel_rapl.h
> +++ b/include/linux/intel_rapl.h
> @@ -158,6 +158,17 @@ struct rapl_if_priv {
>         void *rpi;
>  };
>
> +#ifdef CONFIG_PERF_EVENTS

Structure fields below need to be documented.

> +struct rapl_package_pmu_data {
> +       u64 scale[RAPL_DOMAIN_MAX];
> +       raw_spinlock_t lock;
> +       int n_active;
> +       struct list_head active_list;
> +       ktime_t timer_interval;
> +       struct hrtimer hrtimer;
> +};
> +#endif
> +
>  /* maximum rapl package domain name: package-%d-die-%d */
>  #define PACKAGE_DOMAIN_NAME_LENGTH 30
>
> @@ -176,6 +187,10 @@ struct rapl_package {
>         struct cpumask cpumask;
>         char name[PACKAGE_DOMAIN_NAME_LENGTH];
>         struct rapl_if_priv *priv;
> +#ifdef CONFIG_PERF_EVENTS
> +       bool has_pmu;
> +       struct rapl_package_pmu_data pmu_data;
> +#endif
>  };
>
>  struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct =
rapl_if_priv *priv,
> @@ -188,4 +203,12 @@ struct rapl_package *rapl_find_package_domain(int id=
, struct rapl_if_priv *priv,
>  struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv,=
 bool id_is_cpu);
>  void rapl_remove_package(struct rapl_package *rp);
>
> +#ifdef CONFIG_PERF_EVENTS
> +int rapl_package_add_pmu(struct rapl_package *rp);
> +void rapl_package_remove_pmu(struct rapl_package *rp);
> +#else
> +static inline int rapl_package_add_pmu(struct rapl_package *rp) { return=
 0; }
> +static inline void rapl_package_remove_pmu(struct rapl_package *rp) { }
> +#endif
> +
>  #endif /* __INTEL_RAPL_H__ */
> --

Thanks!

