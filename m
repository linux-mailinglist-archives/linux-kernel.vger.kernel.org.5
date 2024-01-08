Return-Path: <linux-kernel+bounces-19716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE0E8271AA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F5DEB21FE7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8020647787;
	Mon,  8 Jan 2024 14:42:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBAF4777F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98F00C15;
	Mon,  8 Jan 2024 06:42:50 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E19813F64C;
	Mon,  8 Jan 2024 06:42:02 -0800 (PST)
Message-ID: <82e9dbed-281c-4a87-8c0b-a2b1cb0a2247@arm.com>
Date: Mon, 8 Jan 2024 14:42:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] coresight: Remove the 'enable' field.
Content-Language: en-US
To: James Clark <james.clark@arm.com>, coresight@lists.linaro.org
Cc: Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, Tao Zhang
 <quic_taozha@quicinc.com>, Mao Jinlong <quic_jinlmao@quicinc.com>
References: <20231212155407.1429121-1-james.clark@arm.com>
 <20231212155407.1429121-6-james.clark@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20231212155407.1429121-6-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James

+Cc: Tao Zhang <quic_taozha@quicinc.com>
+Cc: Mao Jinlong <quic_jinlmao@quicinc.com>

On 12/12/2023 15:54, James Clark wrote:
> 'enable', which probably should have been 'enabled', is only ever read
> in the core code in relation to controlling sources, and specifically
> only sources in sysfs mode. Confusingly it's not labelled as such and
> relying on it can be a source of bugs like the one fixed by
> commit 078dbba3f0c9 ("coresight: Fix crash when Perf and sysfs modes are
> used concurrently").
> 
> Most importantly, it can only be used when the coresight_mutex is held
> which is only done when enabling and disabling paths in sysfs mode, and
> not Perf mode.


I think we may be able to relax this a bit for the syfs. The sole reason
for holding the mutex is for the "build_path" (and get_enabled_sink)
where we need to make sure that no devices are removed/added. We hold
necessary refcount on the device and the module (via 
coresight_grab_device()). After which, we should be able to release the
mutex and perform the rest without it in coresight_enable()

> So to prevent its usage spreading and leaking out to
> other devices, remove it.
> 
> It's use is equivalent to checking if the mode is currently sysfs, as
> due to the coresight_mutex lock, mode == CS_MODE_SYSFS can only become
> true or untrue when that lock is held, and when mode == CS_MODE_SYSFS
> the device is both enabled and in sysfs mode.

All of the above makes sense and looks good to me.

> 
> The one place it was used outside of the core code is in TPDA, but that
> pattern is more appropriately represented using refcounts inside the
> device's own spinlock.

But, I think we can clean up this code a bit more better. See below.

> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c | 86 +++++++-------------
>   drivers/hwtracing/coresight/coresight-tpda.c | 12 ++-
>   include/linux/coresight.h                    |  2 -
>   3 files changed, 38 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index ab226441e5f4..1d0bd1586590 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -279,29 +279,18 @@ EXPORT_SYMBOL_GPL(coresight_add_helper);
>   static int coresight_enable_sink(struct coresight_device *csdev,
>   				 enum cs_mode mode, void *data)
>   {
> -	int ret = sink_ops(csdev)->enable(csdev, mode, data);
> -
> -	if (ret)
> -		return ret;
> -
> -	csdev->enable = true;
> -
> -	return 0;
> +	return sink_ops(csdev)->enable(csdev, mode, data);
>   }
>   
>   static void coresight_disable_sink(struct coresight_device *csdev)
>   {
> -	int ret = sink_ops(csdev)->disable(csdev);
> -	if (ret)
> -		return;
> -	csdev->enable = false;
> +	sink_ops(csdev)->disable(csdev);
>   }
>   
>   static int coresight_enable_link(struct coresight_device *csdev,
>   				 struct coresight_device *parent,
>   				 struct coresight_device *child)
>   {
> -	int ret = 0;
>   	int link_subtype;
>   	struct coresight_connection *inconn, *outconn;
>   
> @@ -317,19 +306,13 @@ static int coresight_enable_link(struct coresight_device *csdev,
>   	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT && IS_ERR(outconn))
>   		return PTR_ERR(outconn);
>   
> -	ret = link_ops(csdev)->enable(csdev, inconn, outconn);
> -	if (!ret)
> -		csdev->enable = true;
> -
> -	return ret;
> +	return link_ops(csdev)->enable(csdev, inconn, outconn);
>   }
>   
>   static void coresight_disable_link(struct coresight_device *csdev,
>   				   struct coresight_device *parent,
>   				   struct coresight_device *child)
>   {
> -	int i;
> -	int link_subtype;
>   	struct coresight_connection *inconn, *outconn;
>   
>   	if (!parent || !child)
> @@ -337,26 +320,8 @@ static void coresight_disable_link(struct coresight_device *csdev,
>   
>   	inconn = coresight_find_out_connection(parent, csdev);
>   	outconn = coresight_find_out_connection(csdev, child);
> -	link_subtype = csdev->subtype.link_subtype;
>   
>   	link_ops(csdev)->disable(csdev, inconn, outconn);
> -
> -	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG) {
> -		for (i = 0; i < csdev->pdata->nr_inconns; i++)
> -			if (atomic_read(&csdev->pdata->in_conns[i]->dest_refcnt) !=
> -			    0)
> -				return;
> -	} else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT) {
> -		for (i = 0; i < csdev->pdata->nr_outconns; i++)
> -			if (atomic_read(&csdev->pdata->out_conns[i]->src_refcnt) !=
> -			    0)
> -				return;
> -	} else {
> -		if (atomic_read(&csdev->refcnt) != 0)
> -			return;
> -	}
> -
> -	csdev->enable = false;
>   }
>   
>   int coresight_enable_source(struct coresight_device *csdev, enum cs_mode mode,
> @@ -364,11 +329,16 @@ int coresight_enable_source(struct coresight_device *csdev, enum cs_mode mode,
>   {
>   	int ret;
>   
> -	if (!csdev->enable) {
> +	/*
> +	 * Comparison with CS_MODE_SYSFS works without taking any device
> +	 * specific spinlock because the truthyness of that comparison can only
> +	 * change with coresight_mutex held, which we already have here.
> +	 */
> +	lockdep_assert_held(&coresight_mutex);
> +	if (local_read(&csdev->mode) != CS_MODE_SYSFS) {
>   		ret = source_ops(csdev)->enable(csdev, data, mode);
>   		if (ret)
>   			return ret;
> -		csdev->enable = true;
>   	}
>   
>   	atomic_inc(&csdev->refcnt);
> @@ -385,22 +355,12 @@ static bool coresight_is_helper(struct coresight_device *csdev)
>   static int coresight_enable_helper(struct coresight_device *csdev,
>   				   enum cs_mode mode, void *data)
>   {
> -	int ret = helper_ops(csdev)->enable(csdev, mode, data);
> -
> -	if (ret)
> -		return ret;
> -
> -	csdev->enable = true;
> -	return 0;
> +	return helper_ops(csdev)->enable(csdev, mode, data);
>   }
>   
>   static void coresight_disable_helper(struct coresight_device *csdev)
>   {
> -	int ret = helper_ops(csdev)->disable(csdev, NULL);
> -
> -	if (ret)
> -		return;
> -	csdev->enable = false;
> +	helper_ops(csdev)->disable(csdev, NULL);
>   }
>   
>   static void coresight_disable_helpers(struct coresight_device *csdev)
> @@ -445,11 +405,15 @@ EXPORT_SYMBOL_GPL(coresight_disable_source);
>   static bool coresight_disable_source_sysfs(struct coresight_device *csdev,
>   					   void *data)
>   {
> +	lockdep_assert_held(&coresight_mutex);
> +	if (local_read(&csdev->mode) != CS_MODE_SYSFS)
> +		return false;
> +
>   	if (atomic_dec_return(&csdev->refcnt) == 0) {
>   		coresight_disable_source(csdev, data);
> -		csdev->enable = false;
> +		return true;
>   	}
> -	return !csdev->enable;
> +	return false;
>   }
>   
>   /*
> @@ -1097,7 +1061,13 @@ int coresight_enable(struct coresight_device *csdev)
>   	if (ret)
>   		goto out;
>   
> -	if (csdev->enable) {
> +	/*
> +	 * mode == SYSFS implies that it's already enabled. Don't look at the
> +	 * refcount to determine this because we don't claim the source until
> +	 * coresight_enable_source() so can still race with Perf mode which
> +	 * doesn't hold coresight_mutex.
> +	 */
> +	if (local_read(&csdev->mode) == CS_MODE_SYSFS) {
>   		/*
>   		 * There could be multiple applications driving the software
>   		 * source. So keep the refcount for each such user when the
> @@ -1183,7 +1153,7 @@ void coresight_disable(struct coresight_device *csdev)
>   	if (ret)
>   		goto out;
>   
> -	if (!csdev->enable || !coresight_disable_source_sysfs(csdev, NULL))
> +	if (!coresight_disable_source_sysfs(csdev, NULL))
>   		goto out;
>   
>   	switch (csdev->subtype.source_subtype) {
> @@ -1249,7 +1219,9 @@ static ssize_t enable_source_show(struct device *dev,
>   {
>   	struct coresight_device *csdev = to_coresight_device(dev);
>   
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", csdev->enable);
> +	guard(mutex)(&coresight_mutex);
> +	return scnprintf(buf, PAGE_SIZE, "%u\n",
> +			 local_read(&csdev->mode) == CS_MODE_SYSFS);
>   }
>   
>   static ssize_t enable_source_store(struct device *dev,
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> index 5f82737c37bb..65c70995ab00 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.c
> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> @@ -148,7 +148,11 @@ static int __tpda_enable(struct tpda_drvdata *drvdata, int port)
>   
>   	CS_UNLOCK(drvdata->base);
>   
> -	if (!drvdata->csdev->enable)
> +	/*
> +	 * Only do pre-port enable for first port that calls enable when the
> +	 * device's main refcount is still 0
> +	 */
> +	if (!atomic_read(&drvdata->csdev->refcnt))
>   		tpda_enable_pre_port(drvdata);

Relying on the "csdev->enable" to do pre-port configuration looks like
a complete hack to me. This could have been performed once and for all
during the probe time, at say, tpda_init_default_data(). That value is
(drvdata->atid) never updated and need not be re-written  unless the
value is lost during a power idle.

Mao, Tao, are you able to confirm this ? If that is the case, we don't 
need this csdev->refcnt.

>   
>   	ret = tpda_enable_port(drvdata, port);
> @@ -169,6 +173,7 @@ static int tpda_enable(struct coresight_device *csdev,
>   		ret = __tpda_enable(drvdata, in->dest_port);
>   		if (!ret) {
>   			atomic_inc(&in->dest_refcnt);
> +			atomic_inc(&csdev->refcnt);
>   			dev_dbg(drvdata->dev, "TPDA inport %d enabled.\n", in->dest_port);
>   		}
>   	}
> @@ -197,9 +202,10 @@ static void tpda_disable(struct coresight_device *csdev,
>   	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>   
>   	spin_lock(&drvdata->spinlock);
> -	if (atomic_dec_return(&in->dest_refcnt) == 0)
> +	if (atomic_dec_return(&in->dest_refcnt) == 0) {
>   		__tpda_disable(drvdata, in->dest_port);
> -
> +		atomic_dec(&csdev->refcnt);

If we need this, then: This should be performed outside the if () isn't it ?

e.g.,

Operation:		in_conn->refcnt		csdev->refcnt
port_enable : port0	0 - > 1			0 - > 1
port_enable : port0 	1 - > 2			1 - > 2
port_disable: port0	2 - > 1			2 (no change)
port_disable: port0	1 - > 0			2 - > 1

As you can see the csdev->refcnt skipped a dec.

Suzuki


> +	}
>   	spin_unlock(&drvdata->spinlock);
>   
>   	dev_dbg(drvdata->dev, "TPDA inport %d disabled\n", in->dest_port);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index ba817f563ff7..46e6667f72ce 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -233,7 +233,6 @@ struct coresight_sysfs_link {
>    *		a non-atomic read would also work.
>    * @refcnt:	keep track of what is in use.
>    * @orphan:	true if the component has connections that haven't been linked.
> - * @enable:	'true' if component is currently part of an active path.
>    * @sysfs_sink_activated: 'true' when a sink has been selected for use via sysfs
>    *		by writing a 1 to the 'enable_sink' file.  A sink can be
>    *		activated but not yet enabled.  Enabling for a _sink_ happens
> @@ -260,7 +259,6 @@ struct coresight_device {
>   	local_t	mode;
>   	atomic_t refcnt;
>   	bool orphan;
> -	bool enable;
>   	/* sink specific fields */
>   	bool sysfs_sink_activated;
>   	struct dev_ext_attribute *ea;


