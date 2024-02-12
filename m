Return-Path: <linux-kernel+bounces-62101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01565851B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267E21C21453
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B313EA76;
	Mon, 12 Feb 2024 17:31:00 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43033E487;
	Mon, 12 Feb 2024 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759059; cv=none; b=BFR+6PIvec5yAJabxNUuzFZtacBUv1S4lC5mHLqE78Owx5k0Fjd0GeJlNFikF/fsDJMtF6PtWC0lJlpJGLDSVfSQdZWXGIkafMCB3CGBv4aMBtIXEooS3iIPXCe7yH5N04BBga18Td7obMJIFDCO8vTmVVS59y+xGRAsKMpzkx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759059; c=relaxed/simple;
	bh=AX53D9ke2/g0dZjPbQJwGrjHfZhC1a0v4EZ/QTXHPFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIJEt53qpB3/9S6yHVINPk5I9IkiWBCA130GuD26DE2iO81YaldB3Hk+x5XbKu5qLjY7B5Q1t32rsjyYBF5WWgSv2XhCl9eSEtaIsXmPeyML6A2X0gaUzmtbdCuy27aiHTwt4v4ybugaKxLizjuRHO0vrpx0HKuk/W1tHpdeoM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59a24bf7cadso1157729eaf.0;
        Mon, 12 Feb 2024 09:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707759056; x=1708363856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKWKgXqyq+jbQzxvSQe8NViRjYtszOaNkSBKDRp52+M=;
        b=PwntZ4zJmQliv2M7+M+9XqRs79cYF1F324BVs0xmbjL+2QasnlKF5rQKm1h1SffXlQ
         VbJBU634iqX62B+beIM1gFbHZ0CipwHHFT+2N9E9mbUh+Twb8A6dR/GX0R2qlwEnp9If
         dcjax4EURIi3ocS6Voz49f7vZBDzBPrM124yF1dX2zIpTRYt/SDvC9sIUAd2OORoeRMW
         fRfTIfbvSj60XSkGpGNWjcfjppVW/AXIBgR5F2VpjCZ3PzzQ+C9e/fXuQ2X0PSL+KWPy
         Qgluavmu9gVk4RCT4ky3EF/6laL5VxWmrjYTHpnY8cCTSjUvO62sb7aEveb9KtvSysZG
         DVuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoMWAU4JMfOnd2Mmg0cX5LgLG+K9dtnNU3kz8hfmwgMbeeLKJH0yt8vZy0RdyUZwotr+chdEOlHkPKPulBAG67IwCSbJ/DiGIIF9rHZwldz90eHRGxl7znxC6gA0YgsCVOAf426eg=
X-Gm-Message-State: AOJu0YwLrL0LIz5x1G9yyitB6aQ5MQni+0TGuECwt2uVKlhgYQfgCOBs
	CgT39OA8JAfbtbL9cMH1+szlqo1ePC03dWp5It3zUimYrIArdgYvQwP+vokMbsbPfgeyYcVCp2s
	NVxo2j1Ip5Ift2rrDIiWaEAPaYJE=
X-Google-Smtp-Source: AGHT+IFcU9fjZzIBTN5sGKLoMfIOP7yMvqzrpy/CBqoyLtDXPNr8XcL5pnjkxtih1rTlKGZ4LHDgsrzwDRqV1p4DnkU=
X-Received: by 2002:a05:6820:2b12:b0:59a:bf5:a0da with SMTP id
 dt18-20020a0568202b1200b0059a0bf5a0damr5379413oob.0.1707759055481; Mon, 12
 Feb 2024 09:30:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213175818.2826876-1-daniel.lezcano@linaro.org> <20231213175818.2826876-2-daniel.lezcano@linaro.org>
In-Reply-To: <20231213175818.2826876-2-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 18:30:43 +0100
Message-ID: <CAJZ5v0gfz9Lafz20s2AourmKuqQMS9g4heqj=afLbbp_B-2FMA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] PM: QoS: Add a performance QoS
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, caleb.connolly@linaro.org, lina.iyer@linaro.org, 
	lukasz.luba@arm.com, quic_manafm@quicinc.com, quic_priyjain@quicinc.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 6:58=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Currently cpufreq and devfreq are using the freq QoS to aggregate the
> requests for frequency ranges.
>
> However, there are new devices wanting to act not on a frequency range
> but on a performance index range. Those need also to export to
> userspace the knob to act on their performance limits.
>
> This change provides a performance limiter QoS based on a minimum /
> maximum performance values. At init time, the limits of the interval
> are 0 / 1024. It is up to the backend to convert the 1024 to the
> maximum performance state. So if the performance must be limited to
> 50%, it should set to maximum limit to 512 where the backend will end
> up by converting (max performance index / 2). The same applies for the
> minimum. Obviously, the min can not be greater than the max.
>
>  1. With the example above, if there is a odd number like 5 for the
>  number of performance indexes and we ask for 512 (so 50%), what would
>  be the performance index computed? (5/2=3D2 or 5/2=3D3)? (I would say th=
e
>  minimum otherwise we end up with a performance limit greater than
>  what we actually asked for).
>
>  2. The conversion from 1024 to a performance index will inevatibly
>  end up to a state above or below the percentage given. Shall it be
>  reflected in the value set? eg. We want to apply a performance limit
>  to be 33% maximum. So it is, 1024 x 0.333333 =3D 314. If there are 20
>  performance indexes, that will be (20 x 314) / 1024 =3D 6.13, so index
>  6. Shall we convert this index back to the requested performance
>  limit to (6.13 x 1024) / 20 =3D 307 ? (So requested is 314 but it is
>  actually 307).
>
> The end goal is to make the freq QoS and perf QoS to co-exist together
> in the next changes in the different backends. A change of one of the
> QoS impacts the other. For instance if there are 5 performance states
> and we set a performance limit to 80%, then the maximum state will 4.
>
> For the long term, when those can co-exist, then we can implement a
> cooling device based on the performance Qos which will be generic for
> all devices using this QoS. That will imply the CPUs, the GPUs and any
> devfreq devices. So devfreq and cpufreq cooling devices can be merged
> into a single performance cooling device which will be generic for all
> devices with a performance limit QoS.
>
> In a similar way, in the future, a power QoS could be added also and a
> power based cooling device. So any device with the energy model and a
> power capping feature can become a cooling device and the power
> computation part in the cooling devices will move to the back ends. We
> will end up with a generic power cooling device compatible with all
> power capable devices.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I sent a comment on the first patch in the series and please note that
0-day has reported build issues with this one.  I guess it needs to be
refreshed.

At the general level, I think that it would be good to add at least
one user of this framework along with it, as a matter of illustration
how it is going to (or at least how it is intended to) be used.  For
example, what is going to happen when user space updates one of the
limits via sysfs for a given device?

I also have a couple of technical comments below.

> ---
>  drivers/base/power/power.h |   2 +
>  drivers/base/power/qos.c   | 158 +++++++++++++++++++++++++-
>  drivers/base/power/sysfs.c |  92 +++++++++++++++
>  include/linux/cpufreq.h    |   2 +
>  include/linux/pm_qos.h     |  42 +++++++
>  kernel/power/qos.c         | 225 +++++++++++++++++++++++++++++++++++++
>  6 files changed, 517 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index 922ed457db19..eb1a77a7a0f4 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -78,6 +78,8 @@ extern int pm_qos_sysfs_add_flags(struct device *dev);
>  extern void pm_qos_sysfs_remove_flags(struct device *dev);
>  extern int pm_qos_sysfs_add_latency_tolerance(struct device *dev);
>  extern void pm_qos_sysfs_remove_latency_tolerance(struct device *dev);
> +extern int pm_qos_sysfs_add_perf_limit(struct device *dev);
> +extern void pm_qos_sysfs_remove_perf_limit(struct device *dev);
>  extern int dpm_sysfs_change_owner(struct device *dev, kuid_t kuid, kgid_=
t kgid);
>
>  #else /* CONFIG_PM */
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index ae0b9d2573ec..a71cff1f8048 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -128,6 +128,14 @@ s32 dev_pm_qos_read_value(struct device *dev, enum d=
ev_pm_qos_req_type type)
>                 ret =3D IS_ERR_OR_NULL(qos) ? PM_QOS_MAX_FREQUENCY_DEFAUL=
T_VALUE
>                         : freq_qos_read_value(&qos->freq, FREQ_QOS_MAX);
>                 break;
> +       case DEV_PM_QOS_MIN_PERF:
> +               ret =3D  IS_ERR_OR_NULL(qos) ? PM_QOS_MIN_PERF_DEFAULT_VA=
LUE
> +                       : perf_qos_read_value(&qos->perf, RANGE_QOS_MIN);
> +               break;
> +       case DEV_PM_QOS_MAX_PERF:
> +               ret =3D  IS_ERR_OR_NULL(qos) ? PM_QOS_MAX_PERF_DEFAULT_VA=
LUE
> +                       : perf_qos_read_value(&qos->perf, RANGE_QOS_MAX);
> +               break;
>         default:
>                 WARN_ON(1);
>                 ret =3D 0;
> @@ -177,6 +185,10 @@ static int apply_constraint(struct dev_pm_qos_reques=
t *req,
>                 ret =3D pm_qos_update_flags(&qos->flags, &req->data.flr,
>                                           action, value);
>                 break;
> +       case DEV_PM_QOS_MIN_PERF:
> +       case DEV_PM_QOS_MAX_PERF:
> +               ret =3D perf_qos_apply(&req->data.perf, action, value);
> +               break;
>         default:
>                 ret =3D -EINVAL;
>         }
> @@ -223,6 +235,20 @@ static int dev_pm_qos_constraints_allocate(struct de=
vice *dev)
>         c->no_constraint_value =3D PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT=
;
>         c->type =3D PM_QOS_MIN;
>
> +       c =3D &qos->perf.lower_bound;
> +       plist_head_init(&c->list);
> +       c->target_value =3D PM_QOS_MIN_PERF_DEFAULT_VALUE;
> +       c->default_value =3D PM_QOS_MIN_PERF_DEFAULT_VALUE;
> +       c->no_constraint_value =3D PM_QOS_MIN_PERF_DEFAULT_VALUE;
> +       c->type =3D PM_QOS_MAX;
> +
> +       c =3D &qos->perf.upper_bound;
> +       plist_head_init(&c->list);
> +       c->target_value =3D PM_QOS_MAX_PERF_DEFAULT_VALUE;
> +       c->default_value =3D PM_QOS_MAX_PERF_DEFAULT_VALUE;
> +       c->no_constraint_value =3D PM_QOS_MAX_PERF_DEFAULT_VALUE;
> +       c->type =3D PM_QOS_MIN;
> +
>         freq_constraints_init(&qos->freq);
>
>         INIT_LIST_HEAD(&qos->flags.list);
> @@ -299,6 +325,20 @@ void dev_pm_qos_constraints_destroy(struct device *d=
ev)
>                 memset(req, 0, sizeof(*req));
>         }
>
> +       c =3D &qos->perf.lower_bound;
> +       plist_for_each_entry_safe(req, tmp, &c->list, data.freq.pnode) {
> +               apply_constraint(req, PM_QOS_REMOVE_REQ,
> +                                PM_QOS_MIN_PERF_DEFAULT_VALUE);
> +               memset(req, 0, sizeof(*req));
> +       }
> +
> +       c =3D &qos->perf.upper_bound;
> +       plist_for_each_entry_safe(req, tmp, &c->list, data.freq.pnode) {
> +               apply_constraint(req, PM_QOS_REMOVE_REQ,
> +                                PM_QOS_MAX_PERF_DEFAULT_VALUE);
> +               memset(req, 0, sizeof(*req));
> +       }
> +
>         f =3D &qos->flags;
>         list_for_each_entry_safe(req, tmp, &f->list, data.flr.node) {
>                 apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_V=
ALUE);
> @@ -349,17 +389,32 @@ static int __dev_pm_qos_add_request(struct device *=
dev,
>
>         req->dev =3D dev;
>         req->type =3D type;
> -       if (req->type =3D=3D DEV_PM_QOS_MIN_FREQUENCY)
> +
> +       switch (type) {
> +       case DEV_PM_QOS_MIN_FREQUENCY:
>                 ret =3D freq_qos_add_request(&dev->power.qos->freq,
>                                            &req->data.freq,
>                                            FREQ_QOS_MIN, value);
> -       else if (req->type =3D=3D DEV_PM_QOS_MAX_FREQUENCY)
> +               break;
> +       case DEV_PM_QOS_MAX_FREQUENCY:
>                 ret =3D freq_qos_add_request(&dev->power.qos->freq,
>                                            &req->data.freq,
>                                            FREQ_QOS_MAX, value);
> -       else
> +               break;
> +       case DEV_PM_QOS_MIN_PERF:
> +               ret =3D perf_qos_add_request(&dev->power.qos->perf,
> +                                          &req->data.perf,
> +                                          RANGE_QOS_MIN, value);
> +               break;
> +       case DEV_PM_QOS_MAX_PERF:
> +               ret =3D perf_qos_add_request(&dev->power.qos->perf,
> +                                          &req->data.perf,
> +                                          RANGE_QOS_MAX, value);
> +               break;
> +       default:
>                 ret =3D apply_constraint(req, PM_QOS_ADD_REQ, value);
> -
> +               break;
> +       }
>         return ret;
>  }
>
> @@ -427,6 +482,10 @@ static int __dev_pm_qos_update_request(struct dev_pm=
_qos_request *req,
>         case DEV_PM_QOS_MAX_FREQUENCY:
>                 curr_value =3D req->data.freq.pnode.prio;
>                 break;
> +       case DEV_PM_QOS_MIN_PERF:
> +       case DEV_PM_QOS_MAX_PERF:
> +               curr_value =3D req->data.perf.pnode.prio;
> +               break;
>         case DEV_PM_QOS_FLAGS:
>                 curr_value =3D req->data.flr.flags;
>                 break;
> @@ -674,6 +733,14 @@ static void __dev_pm_qos_drop_user_request(struct de=
vice *dev,
>                 req =3D dev->power.qos->flags_req;
>                 dev->power.qos->flags_req =3D NULL;
>                 break;
> +       case DEV_PM_QOS_MIN_PERF:
> +               req =3D dev->power.qos->perf_min_req;
> +               dev->power.qos->perf_min_req =3D NULL;
> +               break;
> +       case DEV_PM_QOS_MAX_PERF:
> +               req =3D dev->power.qos->perf_max_req;
> +               dev->power.qos->perf_max_req =3D NULL;
> +               break;
>         default:
>                 WARN_ON(1);
>                 return;
> @@ -980,3 +1047,86 @@ void dev_pm_qos_hide_latency_tolerance(struct devic=
e *dev)
>         pm_runtime_put(dev);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_qos_hide_latency_tolerance);
> +
> +int dev_pm_qos_expose_perf_limit(struct device *dev)
> +{
> +       struct dev_pm_qos_request *req_min;
> +       struct dev_pm_qos_request *req_max;
> +       int ret;
> +
> +       if (!device_is_registered(dev))
> +               return -EINVAL;
> +
> +       req_min =3D kzalloc(sizeof(*req_min), GFP_KERNEL);
> +       if (!req_min)
> +               return -ENOMEM;
> +
> +       req_max =3D kzalloc(sizeof(*req_max), GFP_KERNEL);
> +       if (!req_max) {
> +               kfree(req_min);
> +               return -ENOMEM;
> +       }
> +
> +       ret =3D dev_pm_qos_add_request(dev, req_min, DEV_PM_QOS_MIN_PERF,
> +                                    PM_QOS_MIN_PERF_DEFAULT_VALUE);
> +       if (ret < 0) {
> +               kfree(req_min);
> +               kfree(req_max);
> +               return ret;
> +       }
> +
> +       ret =3D dev_pm_qos_add_request(dev, req_max, DEV_PM_QOS_MAX_PERF,
> +                                    PM_QOS_MAX_PERF_DEFAULT_VALUE);
> +       if (ret < 0) {
> +               dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MIN_PERF);
> +               return ret;
> +       }
> +
> +       mutex_lock(&dev_pm_qos_sysfs_mtx);
> +
> +       mutex_lock(&dev_pm_qos_mtx);
> +
> +       if (IS_ERR_OR_NULL(dev->power.qos))
> +               ret =3D -ENODEV;
> +       else if (dev->power.qos->perf_min_req || dev->power.qos->perf_max=
_req)
> +               ret =3D -EEXIST;
> +
> +       if (ret < 0) {
> +               __dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MIN_PERF);
> +               __dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MAX_PERF);
> +               mutex_unlock(&dev_pm_qos_mtx);
> +               goto out;
> +       }
> +
> +       dev->power.qos->perf_min_req =3D req_min;
> +       dev->power.qos->perf_max_req =3D req_max;
> +
> +       mutex_unlock(&dev_pm_qos_mtx);
> +
> +       ret =3D pm_qos_sysfs_add_perf_limit(dev);
> +       if (ret) {
> +               dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MIN_PERF);
> +               dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MAX_PERF);
> +       }
> +out:
> +       mutex_unlock(&dev_pm_qos_sysfs_mtx);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_qos_expose_perf_limit);
> +
> +void dev_pm_qos_hide_perf_limit(struct device *dev)
> +{
> +       mutex_lock(&dev_pm_qos_sysfs_mtx);
> +
> +       pm_qos_sysfs_remove_perf_limit(dev);
> +
> +       mutex_lock(&dev_pm_qos_mtx);
> +
> +       __dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MIN_PERF);
> +       __dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MAX_PERF);
> +
> +       mutex_unlock(&dev_pm_qos_mtx);
> +
> +       mutex_unlock(&dev_pm_qos_sysfs_mtx);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_qos_hide_perf_limit);
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index a1474fb67db9..5a45191006c1 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -317,6 +317,76 @@ static ssize_t pm_qos_no_power_off_store(struct devi=
ce *dev,
>
>  static DEVICE_ATTR_RW(pm_qos_no_power_off);
>
> +
> +static ssize_t pm_qos_perf_limit_min_max_show(struct device *dev,
> +                                             struct device_attribute *at=
tr,
> +                                             char *buf, bool max)

I'm not sure why bool is passed as the last arg.  I'd pass
DEV_PM_QOS_MAX_PERF or DEV_PM_QOS_MIN_PERF directly and then do

return sysfs_emit(buf, "%d\n", dev_pm_qos_read_value(dev, req_type));

> +{
> +       s32 value =3D dev_pm_qos_read_value(dev, max ? DEV_PM_QOS_MAX_PER=
F :
> +                                         DEV_PM_QOS_MIN_PERF);
> +
> +       return sysfs_emit(buf, "%d\n", value);
> +}
> +
> +static ssize_t pm_qos_perf_limit_min_max_store(struct device *dev,
> +                                              struct device_attribute *a=
ttr,
> +                                              const char *buf, size_t n,=
 bool max)

And analogously here, so it is not necessary to use the ternary operator be=
low.

> +{
> +       int ret;
> +       s32 min_value =3D dev_pm_qos_read_value(dev, DEV_PM_QOS_MIN_PERF)=
;
> +       s32 max_value =3D dev_pm_qos_read_value(dev, DEV_PM_QOS_MAX_PERF)=
;
> +       s32 new_value;
> +
> +       if (kstrtoint(buf, 0, &new_value))
> +               return -EINVAL;
> +
> +       if (new_value < PM_QOS_MIN_PERF_DEFAULT_VALUE ||
> +           new_value > PM_QOS_MAX_PERF_DEFAULT_VALUE)
> +               return -EINVAL;
> +
> +       if (max && (new_value < min_value))
> +               return -EINVAL;
> +
> +       if (!max && (new_value > max_value))
> +               return -EINVAL;
> +
> +       ret =3D dev_pm_qos_update_request(max ? dev->power.qos->perf_max_=
req :
> +                                       dev->power.qos->perf_min_req, new=
_value);
> +
> +       return ret < 0 ? ret : n;
> +}
> +
> +static ssize_t pm_qos_perf_limit_min_show(struct device *dev,
> +                                                struct device_attribute =
*attr,
> +                                                char *buf)
> +{
> +       return pm_qos_perf_limit_min_max_show(dev, attr, buf, false);
> +}
> +
> +static ssize_t pm_qos_perf_limit_min_store(struct device *dev,
> +                                                 struct device_attribute=
 *attr,
> +                                                 const char *buf, size_t=
 n)
> +{
> +       return pm_qos_perf_limit_min_max_store(dev, attr, buf, n, false);
> +}
> +
> +static ssize_t pm_qos_perf_limit_max_show(struct device *dev,
> +                                                struct device_attribute =
*attr,
> +                                                char *buf)
> +{
> +       return pm_qos_perf_limit_min_max_show(dev, attr, buf, true);
> +}
> +
> +static ssize_t pm_qos_perf_limit_max_store(struct device *dev,
> +                                                 struct device_attribute=
 *attr,
> +                                                 const char *buf, size_t=
 n)
> +{
> +       return pm_qos_perf_limit_min_max_store(dev, attr, buf, n, true);
> +}
> +
> +static DEVICE_ATTR_RW(pm_qos_perf_limit_min);
> +static DEVICE_ATTR_RW(pm_qos_perf_limit_max);
> +
>  #ifdef CONFIG_PM_SLEEP
>  static const char _enabled[] =3D "enabled";
>  static const char _disabled[] =3D "disabled";
> @@ -686,6 +756,17 @@ static struct attribute *pm_qos_flags_attrs[] =3D {
>         &dev_attr_pm_qos_no_power_off.attr,
>         NULL,
>  };
> +
> +static struct attribute *pm_qos_perf_limit_attrs[] =3D {
> +       &dev_attr_pm_qos_perf_limit_min.attr,
> +       &dev_attr_pm_qos_perf_limit_max.attr,
> +       NULL,
> +};
> +static const struct attribute_group pm_qos_perf_limit_attr_group =3D {
> +       .name   =3D power_group_name,
> +       .attrs  =3D pm_qos_perf_limit_attrs,
> +};
> +
>  static const struct attribute_group pm_qos_flags_attr_group =3D {
>         .name   =3D power_group_name,
>         .attrs  =3D pm_qos_flags_attrs,
> @@ -821,6 +902,17 @@ void pm_qos_sysfs_remove_latency_tolerance(struct de=
vice *dev)
>         sysfs_unmerge_group(&dev->kobj, &pm_qos_latency_tolerance_attr_gr=
oup);
>  }
>
> +int pm_qos_sysfs_add_perf_limit(struct device *dev)
> +{
> +       return sysfs_merge_group(&dev->kobj,
> +                                &pm_qos_perf_limit_attr_group);
> +}
> +
> +void pm_qos_sysfs_remove_perf_limit(struct device *dev)
> +{
> +       sysfs_unmerge_group(&dev->kobj, &pm_qos_perf_limit_attr_group);
> +}
> +
>  void rpm_sysfs_remove(struct device *dev)
>  {
>         sysfs_unmerge_group(&dev->kobj, &pm_runtime_attr_group);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 08a8ba4bfd2d..b33fc4db4277 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -83,6 +83,8 @@ struct cpufreq_policy {
>         struct range_constraints        constraints;
>         struct range_qos_request        *min_freq_req;
>         struct range_qos_request        *max_freq_req;
> +       struct range_qos_request        *min_perf_req;
> +       struct range_qos_request        *max_perf_req;
>
>         struct cpufreq_frequency_table  *freq_table;
>         enum cpufreq_table_sorting freq_table_sorted;
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 5f5d967ede32..ab4412877b59 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -34,6 +34,8 @@ enum pm_qos_flags_status {
>  #define PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE 0
>  #define PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE     0
>  #define PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE     FREQ_QOS_MAX_DEFAULT_VALU=
E
> +#define PM_QOS_MIN_PERF_DEFAULT_VALUE  0
> +#define PM_QOS_MAX_PERF_DEFAULT_VALUE  1024
>  #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT (-1)
>
>  #define PM_QOS_FLAG_NO_POWER_OFF       (1 << 0)
> @@ -102,6 +104,8 @@ enum dev_pm_qos_req_type {
>         DEV_PM_QOS_LATENCY_TOLERANCE,
>         DEV_PM_QOS_MIN_FREQUENCY,
>         DEV_PM_QOS_MAX_FREQUENCY,
> +       DEV_PM_QOS_MIN_PERF,
> +       DEV_PM_QOS_MAX_PERF,
>         DEV_PM_QOS_FLAGS,
>  };
>
> @@ -111,6 +115,7 @@ struct dev_pm_qos_request {
>                 struct plist_node pnode;
>                 struct pm_qos_flags_request flr;
>                 struct range_qos_request freq;
> +               struct range_qos_request perf;
>         } data;
>         struct device *dev;
>  };
> @@ -119,10 +124,13 @@ struct dev_pm_qos {
>         struct pm_qos_constraints resume_latency;
>         struct pm_qos_constraints latency_tolerance;
>         struct range_constraints freq;
> +       struct range_constraints perf;
>         struct pm_qos_flags flags;
>         struct dev_pm_qos_request *resume_latency_req;
>         struct dev_pm_qos_request *latency_tolerance_req;
>         struct dev_pm_qos_request *flags_req;
> +       struct dev_pm_qos_request *perf_min_req;
> +       struct dev_pm_qos_request *perf_max_req;
>  };
>
>  /* Action requested to pm_qos_update_target */
> @@ -192,6 +200,8 @@ s32 dev_pm_qos_get_user_latency_tolerance(struct devi=
ce *dev);
>  int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val=
);
>  int dev_pm_qos_expose_latency_tolerance(struct device *dev);
>  void dev_pm_qos_hide_latency_tolerance(struct device *dev);
> +int dev_pm_qos_expose_perf_limit(struct device *dev);
> +void dev_pm_qos_hide_perf_limit(struct device *dev);
>
>  static inline s32 dev_pm_qos_requested_resume_latency(struct device *dev=
)
>  {
> @@ -228,6 +238,10 @@ static inline s32 dev_pm_qos_read_value(struct devic=
e *dev,
>                 return PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
>         case DEV_PM_QOS_MAX_FREQUENCY:
>                 return PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
> +       case DEV_PM_QOS_MIN_PERF:
> +               return PM_QOS_MIN_PERF_DEFAULT_VALUE;
> +       case DEV_PM_QOS_MAX_PERF:
> +               return PM_QOS_MAX_PERF_DEFAULT_VALUE;
>         default:
>                 WARN_ON(1);
>                 return 0;
> @@ -281,6 +295,10 @@ static inline int dev_pm_qos_expose_latency_toleranc=
e(struct device *dev)
>                         { return 0; }
>  static inline void dev_pm_qos_hide_latency_tolerance(struct device *dev)=
 {}
>
> +static inline int dev_pm_qos_expose_perf_limit(struct device *dev)
> +                       { return 0; }
> +void dev_pm_qos_hide_perf_limit(struct device *dev) {}
> +
>  static inline s32 dev_pm_qos_requested_resume_latency(struct device *dev=
)
>  {
>         return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> @@ -317,4 +335,28 @@ int freq_qos_remove_notifier(struct range_constraint=
s *qos,
>                              enum range_qos_req_type type,
>                              struct notifier_block *notifier);
>
> +static inline int perf_qos_request_active(struct range_qos_request *req)
> +{
> +       return !IS_ERR_OR_NULL(req->qos);
> +}
> +
> +s32 perf_qos_read_value(struct range_constraints *qos,
> +                       enum range_qos_req_type type);
> +
> +int perf_qos_apply(struct range_qos_request *req,
> +                  enum pm_qos_req_action action, s32 value);
> +
> +int perf_qos_add_request(struct range_constraints *qos,
> +                        struct range_qos_request *req,
> +                        enum range_qos_req_type type, s32 value);
> +int perf_qos_update_request(struct range_qos_request *req, s32 new_value=
);
> +int perf_qos_remove_request(struct range_qos_request *req);
> +
> +int perf_qos_add_notifier(struct range_constraints *qos,
> +                         enum range_qos_req_type type,
> +                         struct notifier_block *notifier);
> +int perf_qos_remove_notifier(struct range_constraints *qos,
> +                            enum range_qos_req_type type,
> +                            struct notifier_block *notifier);
> +
>  #endif
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 39919a2eed73..2787473e6048 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -680,3 +680,228 @@ int freq_qos_remove_notifier(struct range_constrain=
ts *qos,
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(freq_qos_remove_notifier);
> +
> +static inline bool perf_qos_value_invalid(s32 value)
> +{
> +       return value < 0 && value !=3D PM_QOS_DEFAULT_VALUE;
> +}
> +
> +/**
> + * perf_qos_apply - Add/modify/remove performance QoS request.
> + * @req: Constraint request to apply.
> + * @action: Action to perform (add/update/remove).
> + * @value: Value to assign to the QoS request.
> + *
> + * This is only meant to be called from inside pm_qos, not drivers.
> + */
> +int perf_qos_apply(struct range_qos_request *req,
> +                  enum pm_qos_req_action action, s32 value)
> +{
> +       int ret;
> +
> +       switch(req->type) {
> +       case RANGE_QOS_MIN:
> +               ret =3D pm_qos_update_target(&req->qos->lower_bound, &req=
->pnode,
> +                                          action, value);
> +               break;
> +       case RANGE_QOS_MAX:
> +               ret =3D pm_qos_update_target(&req->qos->upper_bound, &req=
->pnode,
> +                                          action, value);
> +               break;
> +       default:
> +               ret =3D -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +/**
> + * perf_qos_read_value - Get performance QoS constraint for a given list=
.
> + * @qos: Constraints to evaluate.
> + * @type: QoS request type.
> + */
> +s32 perf_qos_read_value(struct range_constraints *qos,
> +                       enum range_qos_req_type type)
> +{
> +       s32 ret;
> +
> +       switch (type) {
> +       case RANGE_QOS_MIN:
> +               ret =3D IS_ERR_OR_NULL(qos) ?
> +                       PM_QOS_MIN_PERF_DEFAULT_VALUE :
> +                       pm_qos_read_value(&qos->lower_bound);
> +               break;
> +       case RANGE_QOS_MAX:
> +               ret =3D IS_ERR_OR_NULL(qos) ?
> +                       PM_QOS_MAX_PERF_DEFAULT_VALUE :
> +                       pm_qos_read_value(&qos->upper_bound);
> +               break;
> +       default:
> +               ret =3D 0;
> +       }
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(perf_qos_read_value);
> +
> +/**
> + * perf_qos_add_request - Insert new performance QoS request into a give=
n list.
> + * @qos: Constraints to update.
> + * @req: Preallocated request object.
> + * @type: Request type.
> + * @value: Request value.
> + *
> + * Insert a new entry into the @qos list of requests, recompute the effe=
ctive
> + * QoS constraint value for that list and initialize the @req object.  T=
he
> + * caller needs to save that object for later use in updates and removal=
.
> + *
> + * Return 1 if the effective constraint value has changed, 0 if the effe=
ctive
> + * constraint value has not changed, or a negative error code on failure=
s.
> + */
> +int perf_qos_add_request(struct range_constraints *qos,
> +                        struct range_qos_request *req,
> +                        enum range_qos_req_type type, s32 value)
> +{
> +       int ret;
> +
> +       if (IS_ERR_OR_NULL(qos) || !req || perf_qos_value_invalid(value))
> +               return -EINVAL;
> +
> +       if (WARN(perf_qos_request_active(req),
> +                "%s() called for active request\n", __func__))
> +               return -EINVAL;
> +
> +       req->qos =3D qos;
> +       req->type =3D type;
> +       ret =3D perf_qos_apply(req, PM_QOS_ADD_REQ, value);
> +       if (ret < 0) {
> +               req->qos =3D NULL;
> +               req->type =3D 0;
> +       }
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(perf_qos_add_request);
> +
> +/**
> + * perf_qos_update_request - Modify existing performance QoS request.
> + * @req: Request to modify.
> + * @new_value: New request value.
> + *
> + * Update an existing performance QoS request along with the effective
> + * constraint value for the list of requests it belongs to.
> + *
> + * Return 1 if the effective constraint value has changed, 0 if the effe=
ctive
> + * constraint value has not changed, or a negative error code on failure=
s.
> + */
> +int perf_qos_update_request(struct range_qos_request *req, s32 new_value=
)
> +{
> +       if (!req || perf_qos_value_invalid(new_value))
> +               return -EINVAL;
> +
> +       if (WARN(!perf_qos_request_active(req),
> +                "%s() called for unknown object\n", __func__))
> +               return -EINVAL;
> +
> +       if (req->pnode.prio =3D=3D new_value)
> +               return 0;
> +
> +       return perf_qos_apply(req, PM_QOS_UPDATE_REQ, new_value);
> +}
> +EXPORT_SYMBOL_GPL(perf_qos_update_request);
> +
> +/**
> + * perf_qos_remove_request - Remove performance QoS request from its lis=
t.
> + * @req: Request to remove.
> + *
> + * Remove the given performance QoS request from the list of
> + * constraints it belongs to and recompute the effective constraint
> + * value for that list.
> + *
> + * Return 1 if the effective constraint value has changed, 0 if the effe=
ctive
> + * constraint value has not changed, or a negative error code on failure=
s.
> + */
> +int perf_qos_remove_request(struct range_qos_request *req)
> +{
> +       int ret;
> +
> +       if (!req)
> +               return -EINVAL;
> +
> +       if (WARN(!perf_qos_request_active(req),
> +                "%s() called for unknown object\n", __func__))
> +               return -EINVAL;
> +
> +       ret =3D perf_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VAL=
UE);
> +       req->qos =3D NULL;
> +       req->type =3D 0;
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(perf_qos_remove_request);
> +
> +/**
> + * perf_qos_add_notifier - Add performance QoS change notifier.
> + * @qos: List of requests to add the notifier to.
> + * @type: Request type.
> + * @notifier: Notifier block to add.
> + */

Before there are any users of this, it is not clear whether or not
notifiers will be useful.

I'd add them later, when necessary.

> +int perf_qos_add_notifier(struct range_constraints *qos,
> +                         enum range_qos_req_type type,
> +                         struct notifier_block *notifier)
> +{
> +       int ret;
> +
> +       if (IS_ERR_OR_NULL(qos) || !notifier)
> +               return -EINVAL;
> +
> +       switch (type) {
> +       case RANGE_QOS_MIN:
> +               ret =3D blocking_notifier_chain_register(qos->lower_bound=
notifiers,
> +                                                      notifier);
> +               break;
> +       case RANGE_QOS_MAX:
> +               ret =3D blocking_notifier_chain_register(qos->upper_bound=
notifiers,
> +                                                      notifier);
> +               break;
> +       default:
> +               WARN_ON(1);
> +               ret =3D -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(perf_qos_add_notifier);
> +
> +/**
> + * perf_qos_remove_notifier - Remove performance QoS change notifier.
> + * @qos: List of requests to remove the notifier from.
> + * @type: Request type.
> + * @notifier: Notifier block to remove.
> + */
> +int perf_qos_remove_notifier(struct range_constraints *qos,
> +                            enum range_qos_req_type type,
> +                            struct notifier_block *notifier)
> +{
> +       int ret;
> +
> +       if (IS_ERR_OR_NULL(qos) || !notifier)
> +               return -EINVAL;
> +
> +       switch (type) {
> +       case RANGE_QOS_MIN:
> +               ret =3D blocking_notifier_chain_unregister(qos->lower_bou=
nd.notifiers,
> +                                                        notifier);
> +               break;
> +       case RANGE_QOS_MAX:
> +               ret =3D blocking_notifier_chain_unregister(qos->upper_bou=
nd.notifiers,
> +                                                        notifier);
> +               break;
> +       default:
> +               WARN_ON(1);
> +               ret =3D -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(perf_qos_remove_notifier);
> --

