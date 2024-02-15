Return-Path: <linux-kernel+bounces-66567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEE3855E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 428ECB2EB91
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E631802A;
	Thu, 15 Feb 2024 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v+q0Q2s/"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC533175AA;
	Thu, 15 Feb 2024 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707990007; cv=none; b=bIl7ISGji6DgA1KTVxj/u6obFxBb4RYWqZvyFzmZKXLxGmy/XKWA3MZlnrDzfavtFYAvombg+FHNrLIijwEjCU8PhWlebWwGdUgxYyJgzMNsvOrckKA32tbnnKh0jOgkd+Tc98VYXHHuXVMggnaRKpVtGbBF4SewG/YCWj5Df2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707990007; c=relaxed/simple;
	bh=9sJ/t8yz8FiGfPdj7FcsLpkudzXIHYEycjw0ff8JTCU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0WdDbeeCoKIV439tIWHiOTRlkBL8Z5UUdOa9Aq9OV16YkDU2VYTOOIiE/AUarCfpcU0CSK8cVtfeYzVnTFyh3m2v3I7VU/AD0nnr9BHJjUrWeF/51M9zmevpqE5KWyBJ7vMxDprE/2pH6Y6vXnPtk+fcnrjZ3jf7cFpwa7C880=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=v+q0Q2s/; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41F9dvEB082270;
	Thu, 15 Feb 2024 03:39:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707989997;
	bh=EkP7vJ1wesG1Us28/BCdSU3PzcUnykpRGLaOIoggQvk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=v+q0Q2s/2CdX+x43yAzcLcnsSbks5hfFCgAbTTGPaRimY8bJ6r8eVc8OmRgB8azY+
	 qJJ8V5AbSG0tmrgoqdsxvnSnBwFmPUnMpk3GCQcof8ShDYYuZGU4khPpvEBfETx8uf
	 VT/oYHLrM0D8Mi35LU7mfcQ1FmaB+/e5hVr+GMHc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41F9dvPn120668
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 03:39:57 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 03:39:56 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 03:39:56 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41F9dtrA120656;
	Thu, 15 Feb 2024 03:39:56 -0600
Date: Thu, 15 Feb 2024 15:09:55 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: <rafael@kernel.org>, <caleb.connolly@linaro.org>, <lina.iyer@linaro.org>,
        <lukasz.luba@arm.com>, <quic_manafm@quicinc.com>,
        <quic_priyjain@quicinc.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vibhore@ti.com>,
        <khilman@baylibre.com>
Subject: Re: [PATCH v1 2/2] PM: QoS: Add a performance QoS
Message-ID: <20240215093955.mgox2yiaidxh3ktq@dhruva>
References: <20231213175818.2826876-1-daniel.lezcano@linaro.org>
 <20231213175818.2826876-2-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231213175818.2826876-2-daniel.lezcano@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Dec 13, 2023 at 18:58:18 +0100, Daniel Lezcano wrote:
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
>  be the performance index computed? (5/2=2 or 5/2=3)? (I would say the
>  minimum otherwise we end up with a performance limit greater than
>  what we actually asked for).
> 
>  2. The conversion from 1024 to a performance index will inevatibly
>  end up to a state above or below the percentage given. Shall it be
>  reflected in the value set? eg. We want to apply a performance limit
>  to be 33% maximum. So it is, 1024 x 0.333333 = 314. If there are 20
>  performance indexes, that will be (20 x 314) / 1024 = 6.13, so index
>  6. Shall we convert this index back to the requested performance
>  limit to (6.13 x 1024) / 20 = 307 ? (So requested is 314 but it is
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
>  extern int dpm_sysfs_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid);
>  
>  #else /* CONFIG_PM */
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index ae0b9d2573ec..a71cff1f8048 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -128,6 +128,14 @@ s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type)
>  		ret = IS_ERR_OR_NULL(qos) ? PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE
>  			: freq_qos_read_value(&qos->freq, FREQ_QOS_MAX);
>  		break;
> +	case DEV_PM_QOS_MIN_PERF:
> +		ret =  IS_ERR_OR_NULL(qos) ? PM_QOS_MIN_PERF_DEFAULT_VALUE
> +			: perf_qos_read_value(&qos->perf, RANGE_QOS_MIN);
> +		break;
> +	case DEV_PM_QOS_MAX_PERF:
> +		ret =  IS_ERR_OR_NULL(qos) ? PM_QOS_MAX_PERF_DEFAULT_VALUE
> +			: perf_qos_read_value(&qos->perf, RANGE_QOS_MAX);
> +		break;
>  	default:
>  		WARN_ON(1);
>  		ret = 0;
> @@ -177,6 +185,10 @@ static int apply_constraint(struct dev_pm_qos_request *req,
>  		ret = pm_qos_update_flags(&qos->flags, &req->data.flr,
>  					  action, value);
>  		break;
> +	case DEV_PM_QOS_MIN_PERF:
> +	case DEV_PM_QOS_MAX_PERF:
> +		ret = perf_qos_apply(&req->data.perf, action, value);
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -223,6 +235,20 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
>  	c->no_constraint_value = PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
>  	c->type = PM_QOS_MIN;
>  
> +	c = &qos->perf.lower_bound;
> +	plist_head_init(&c->list);
> +	c->target_value = PM_QOS_MIN_PERF_DEFAULT_VALUE;
> +	c->default_value = PM_QOS_MIN_PERF_DEFAULT_VALUE;
> +	c->no_constraint_value = PM_QOS_MIN_PERF_DEFAULT_VALUE;
> +	c->type = PM_QOS_MAX;
> +
> +	c = &qos->perf.upper_bound;
> +	plist_head_init(&c->list);
> +	c->target_value = PM_QOS_MAX_PERF_DEFAULT_VALUE;
> +	c->default_value = PM_QOS_MAX_PERF_DEFAULT_VALUE;
> +	c->no_constraint_value = PM_QOS_MAX_PERF_DEFAULT_VALUE;
> +	c->type = PM_QOS_MIN;
> +
>  	freq_constraints_init(&qos->freq);
>  
>  	INIT_LIST_HEAD(&qos->flags.list);
> @@ -299,6 +325,20 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
>  		memset(req, 0, sizeof(*req));
>  	}
>  
> +	c = &qos->perf.lower_bound;
> +	plist_for_each_entry_safe(req, tmp, &c->list, data.freq.pnode) {
> +		apply_constraint(req, PM_QOS_REMOVE_REQ,
> +				 PM_QOS_MIN_PERF_DEFAULT_VALUE);
> +		memset(req, 0, sizeof(*req));
> +	}
> +
> +	c = &qos->perf.upper_bound;
> +	plist_for_each_entry_safe(req, tmp, &c->list, data.freq.pnode) {
> +		apply_constraint(req, PM_QOS_REMOVE_REQ,
> +				 PM_QOS_MAX_PERF_DEFAULT_VALUE);
> +		memset(req, 0, sizeof(*req));
> +	}
> +	
>  	f = &qos->flags;
>  	list_for_each_entry_safe(req, tmp, &f->list, data.flr.node) {
>  		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
> @@ -349,17 +389,32 @@ static int __dev_pm_qos_add_request(struct device *dev,
>  
>  	req->dev = dev;
>  	req->type = type;
> -	if (req->type == DEV_PM_QOS_MIN_FREQUENCY)
> +
> +	switch (type) {
> +	case DEV_PM_QOS_MIN_FREQUENCY:
>  		ret = freq_qos_add_request(&dev->power.qos->freq,
>  					   &req->data.freq,
>  					   FREQ_QOS_MIN, value);
> -	else if (req->type == DEV_PM_QOS_MAX_FREQUENCY)
> +		break;
> +	case DEV_PM_QOS_MAX_FREQUENCY:
>  		ret = freq_qos_add_request(&dev->power.qos->freq,
>  					   &req->data.freq,
>  					   FREQ_QOS_MAX, value);
> -	else
> +		break;
> +	case DEV_PM_QOS_MIN_PERF:
> +		ret = perf_qos_add_request(&dev->power.qos->perf,
> +					   &req->data.perf,
> +					   RANGE_QOS_MIN, value);
> +		break;
> +	case DEV_PM_QOS_MAX_PERF:
> +		ret = perf_qos_add_request(&dev->power.qos->perf,
> +					   &req->data.perf,
> +					   RANGE_QOS_MAX, value);
> +		break;
> +	default:
>  		ret = apply_constraint(req, PM_QOS_ADD_REQ, value);
> -
> +		break;
> +	}
>  	return ret;
>  }
>  
> @@ -427,6 +482,10 @@ static int __dev_pm_qos_update_request(struct dev_pm_qos_request *req,
>  	case DEV_PM_QOS_MAX_FREQUENCY:
>  		curr_value = req->data.freq.pnode.prio;
>  		break;
> +	case DEV_PM_QOS_MIN_PERF:
> +	case DEV_PM_QOS_MAX_PERF:
> +		curr_value = req->data.perf.pnode.prio;
> +		break;
>  	case DEV_PM_QOS_FLAGS:
>  		curr_value = req->data.flr.flags;
>  		break;
> @@ -674,6 +733,14 @@ static void __dev_pm_qos_drop_user_request(struct device *dev,
>  		req = dev->power.qos->flags_req;
>  		dev->power.qos->flags_req = NULL;
>  		break;
> +	case DEV_PM_QOS_MIN_PERF:
> +		req = dev->power.qos->perf_min_req;
> +		dev->power.qos->perf_min_req = NULL;
> +		break;
> +	case DEV_PM_QOS_MAX_PERF:
> +		req = dev->power.qos->perf_max_req;
> +		dev->power.qos->perf_max_req = NULL;
> +		break;
>  	default:
>  		WARN_ON(1);
>  		return;
> @@ -980,3 +1047,86 @@ void dev_pm_qos_hide_latency_tolerance(struct device *dev)
>  	pm_runtime_put(dev);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_qos_hide_latency_tolerance);
> +
> +int dev_pm_qos_expose_perf_limit(struct device *dev)
> +{
> +	struct dev_pm_qos_request *req_min;
> +	struct dev_pm_qos_request *req_max;
> +	int ret;
> +
> +	if (!device_is_registered(dev))
> +		return -EINVAL;
> +
> +	req_min = kzalloc(sizeof(*req_min), GFP_KERNEL);
> +	if (!req_min)
> +		return -ENOMEM;
> +
> +	req_max = kzalloc(sizeof(*req_max), GFP_KERNEL);
> +	if (!req_max) {
> +		kfree(req_min);
> +		return -ENOMEM;
> +	}
> +	

Oops, looks like we forgot to run checkpatch ;)

There are many more errors with these patches and I'd urge you to run
checkpatch and fix and re-spin.
Do keep me in CC from next rev.

> +	ret = dev_pm_qos_add_request(dev, req_min, DEV_PM_QOS_MIN_PERF,
> +				     PM_QOS_MIN_PERF_DEFAULT_VALUE);
> +	if (ret < 0) {
> +		kfree(req_min);
> +		kfree(req_max);
> +		return ret;
> +	}
> +
> +	ret = dev_pm_qos_add_request(dev, req_max, DEV_PM_QOS_MAX_PERF,
> +				     PM_QOS_MAX_PERF_DEFAULT_VALUE);
> +	if (ret < 0) {
> +		dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MIN_PERF);
> +		return ret;
> +	}
> +
> +	mutex_lock(&dev_pm_qos_sysfs_mtx);
> +
> +	mutex_lock(&dev_pm_qos_mtx);
> +
> +	if (IS_ERR_OR_NULL(dev->power.qos))
> +		ret = -ENODEV;
> +	else if (dev->power.qos->perf_min_req || dev->power.qos->perf_max_req)
> +		ret = -EEXIST;
> +
> +	if (ret < 0) {
> +		__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MIN_PERF);
> +		__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MAX_PERF);
> +		mutex_unlock(&dev_pm_qos_mtx);
> +		goto out;
> +	}
> +
> +	dev->power.qos->perf_min_req = req_min;
> +	dev->power.qos->perf_max_req = req_max;
> +
> +	mutex_unlock(&dev_pm_qos_mtx);
> +
> +	ret = pm_qos_sysfs_add_perf_limit(dev);
> +	if (ret) {
> +		dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MIN_PERF);
> +		dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MAX_PERF);
> +	}
> +out:
> +	mutex_unlock(&dev_pm_qos_sysfs_mtx);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_qos_expose_perf_limit);
> +
> +void dev_pm_qos_hide_perf_limit(struct device *dev)
> +{
> +	mutex_lock(&dev_pm_qos_sysfs_mtx);
> +
> +	pm_qos_sysfs_remove_perf_limit(dev);
> +
> +	mutex_lock(&dev_pm_qos_mtx);
> +
> +	__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MIN_PERF);
> +	__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_MAX_PERF);
> +	

whitespace.. ^^

> +	mutex_unlock(&dev_pm_qos_mtx);
> +
> +	mutex_unlock(&dev_pm_qos_sysfs_mtx);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_qos_hide_perf_limit);
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index a1474fb67db9..5a45191006c1 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -317,6 +317,76 @@ static ssize_t pm_qos_no_power_off_store(struct device *dev,
>  
>  static DEVICE_ATTR_RW(pm_qos_no_power_off);
>  
> +
> +static ssize_t pm_qos_perf_limit_min_max_show(struct device *dev,
> +					      struct device_attribute *attr,
> +					      char *buf, bool max)
> +{
> +	s32 value = dev_pm_qos_read_value(dev, max ? DEV_PM_QOS_MAX_PERF :
> +					  DEV_PM_QOS_MIN_PERF);
> +
> +	return sysfs_emit(buf, "%d\n", value);
> +}
> +
> +static ssize_t pm_qos_perf_limit_min_max_store(struct device *dev,
> +					       struct device_attribute *attr,
> +					       const char *buf, size_t n, bool max)
> +{
> +	int ret;

Your function return type is ssize_t,  do you want to change the type of
ret too?

> +	s32 min_value = dev_pm_qos_read_value(dev, DEV_PM_QOS_MIN_PERF);
> +	s32 max_value = dev_pm_qos_read_value(dev, DEV_PM_QOS_MAX_PERF);
> +	s32 new_value;
> +
> +	if (kstrtoint(buf, 0, &new_value))
> +		return -EINVAL;
> +
> +	if (new_value < PM_QOS_MIN_PERF_DEFAULT_VALUE ||
> +	    new_value > PM_QOS_MAX_PERF_DEFAULT_VALUE)
> +		return -EINVAL;
> +
> +	if (max && (new_value < min_value))
> +		return -EINVAL;
> +
> +	if (!max && (new_value > max_value))
> +		return -EINVAL;

No strong opinions, but might help debug better if you print why each
EINVAL was returned?

> +
> +	ret = dev_pm_qos_update_request(max ? dev->power.qos->perf_max_req :
> +					dev->power.qos->perf_min_req, new_value);
> +
> +	return ret < 0 ? ret : n;
> +}
> +
> +static ssize_t pm_qos_perf_limit_min_show(struct device *dev,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	return pm_qos_perf_limit_min_max_show(dev, attr, buf, false);
> +}
> +
> +static ssize_t pm_qos_perf_limit_min_store(struct device *dev,
> +						  struct device_attribute *attr,
> +						  const char *buf, size_t n)
> +{
> +	return pm_qos_perf_limit_min_max_store(dev, attr, buf, n, false);
> +}
> +
> +static ssize_t pm_qos_perf_limit_max_show(struct device *dev,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	return pm_qos_perf_limit_min_max_show(dev, attr, buf, true);
> +}
> +
> +static ssize_t pm_qos_perf_limit_max_store(struct device *dev,
> +						  struct device_attribute *attr,
> +						  const char *buf, size_t n)
> +{
> +	return pm_qos_perf_limit_min_max_store(dev, attr, buf, n, true);
> +}
> +
> +static DEVICE_ATTR_RW(pm_qos_perf_limit_min);
> +static DEVICE_ATTR_RW(pm_qos_perf_limit_max);
> +
[...]

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

