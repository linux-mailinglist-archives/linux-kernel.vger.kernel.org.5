Return-Path: <linux-kernel+bounces-163349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5C68B69B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3252817E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AD416426;
	Tue, 30 Apr 2024 05:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pV0+jd+d"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967C91863B;
	Tue, 30 Apr 2024 05:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714453751; cv=none; b=WA0UzfCPlxH9421/g4z0Wau594mLyKo6UJ51mZ8CsmGhB+15AJqmeA2UDZiaOq4R1ZKckutlyHMG2QtvYfXPpIVLNgvyBsRNCVteHUytSThtxV3e9zcdM6jUQjNkWGKPz/8KQJI23MhhHaGf7eeFf11jnGJxqX1N5JpHxQw5a2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714453751; c=relaxed/simple;
	bh=rajPX0iLeGJ7tihYHYpJ3BqiDgnmd6Uozx+b2NmThOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NPMvMpFzF5njwjngsFPCAI4kHtkM/dKlAePZc2JtHjBCbkV0Xap40fAGApHjUuNh1l4g6U3xTn2rvB75bQGRl8zyo1Lm4K2PhEPNzLklEnQBIV9q3VkZQQQcGX+EiMqm7PiNFeOwouU2hyMpR6d+WaXAO59EfOIwtEftVHMLV1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pV0+jd+d; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43U5956b045715;
	Tue, 30 Apr 2024 00:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714453745;
	bh=UYVNtjeJt9uaMDsZWyZRF6NmvnAypTge/4ixYT3NUtI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=pV0+jd+do5GrqBwUwPDZdTomBTiMRSxIRhma0xU2MsQwJ2mGcXl5GgBO+g1EfN14Z
	 ImN6euM3KcikLYs7QUVWG2z9cCAmpI44l+3QIh5QJcEgitJ+5Od3q7SA7hfOg2P5pr
	 ZY59BM7FQx1Q9IlOqEoymkmveiOU8mxy2EID5LCI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43U595AX001890
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Apr 2024 00:09:05 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 00:09:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 00:09:04 -0500
Received: from [10.24.69.66] (uda0510294.dhcp.ti.com [10.24.69.66])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43U591f7010411;
	Tue, 30 Apr 2024 00:09:02 -0500
Message-ID: <03662f93-e770-4f9e-b7ec-21ad4992e951@ti.com>
Date: Tue, 30 Apr 2024 10:39:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v2 1/2] remoteproc: k3-r5: Wait for core0
 power-up before powering up core1
To: Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <andersson@kernel.org>, <s-anna@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <nm@ti.com>, <devarsht@ti.com>, <hnagalla@ti.com>
References: <20240424130504.494916-1-b-padhi@ti.com>
 <20240424130504.494916-2-b-padhi@ti.com> <Zivf4Bhi8zqEQh7p@p14s>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <Zivf4Bhi8zqEQh7p@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello,

On 26/04/24 22:39, Mathieu Poirier wrote:
> Good day, On Wed, Apr 24, 2024 at 06: 35: 03PM +0530, Beleswar Padhi wrote: >
> From: Apurva Nandan <a-nandan@ ti. com> > > PSC controller has a limitation that
> it can only power-up the second core > when the first core is in ON
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source of this
> email and know the content is safe. If you wish to report this message to IT
> Security, please forward the message as an attachment to phishing@list.ti.com
> ZjQcmQRYFpfptBannerEnd
>
> Good day,
>
> On Wed, Apr 24, 2024 at 06:35:03PM +0530, Beleswar Padhi wrote:
> > From: Apurva Nandan <a-nandan@ti.com>
> > 
> > PSC controller has a limitation that it can only power-up the second core
> > when the first core is in ON state. Power-state for core0 should be equal
> > to or higher than core1, else the kernel is seen hanging during rproc
> > loading.
> > 
> > Make the powering up of cores sequential, by waiting for the current core
> > to power-up before proceeding to the next core, with a timeout of 2sec.
> > Add a wait queue event in k3_r5_cluster_rproc_init call, that will wait
> > for the current core to be released from reset before proceeding with the
> > next core.
> > 
> > Fixes: 6dedbd1d5443 ("remoteproc: k3-r5: Add a remoteproc driver for R5F subsystem")
> > 
> > Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>
> You need to add your own SoB as well.
>
> > ---
> >  drivers/remoteproc/ti_k3_r5_remoteproc.c | 28 ++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > index ad3415a3851b..5a9bd5d4a2ea 100644
> > --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > @@ -103,12 +103,14 @@ struct k3_r5_soc_data {
> >   * @dev: cached device pointer
> >   * @mode: Mode to configure the Cluster - Split or LockStep
> >   * @cores: list of R5 cores within the cluster
> > + * @core_transition: wait queue to sync core state changes
> >   * @soc_data: SoC-specific feature data for a R5FSS
> >   */
> >  struct k3_r5_cluster {
> >  	struct device *dev;
> >  	enum cluster_mode mode;
> >  	struct list_head cores;
> > +	wait_queue_head_t core_transition;
> >  	const struct k3_r5_soc_data *soc_data;
> >  };
> >  
> > @@ -128,6 +130,7 @@ struct k3_r5_cluster {
> >   * @atcm_enable: flag to control ATCM enablement
> >   * @btcm_enable: flag to control BTCM enablement
> >   * @loczrama: flag to dictate which TCM is at device address 0x0
> > + * @released_from_reset: flag to signal when core is out of reset
> >   */
> >  struct k3_r5_core {
> >  	struct list_head elem;
> > @@ -144,6 +147,7 @@ struct k3_r5_core {
> >  	u32 atcm_enable;
> >  	u32 btcm_enable;
> >  	u32 loczrama;
> > +	bool released_from_reset;
> >  };
> >  
> >  /**
> > @@ -460,6 +464,8 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
> >  			ret);
> >  		return ret;
> >  	}
> > +	core->released_from_reset = true;
> > +	wake_up_interruptible(&cluster->core_transition);
> >  
> >  	/*
> >  	 * Newer IP revisions like on J7200 SoCs support h/w auto-initialization
> > @@ -1140,6 +1146,7 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
> >  		return ret;
> >  	}
> >  
> > +	core->released_from_reset = c_state;
>
> I understand why this is needed but it line could be very cryptic for people
> trying to understand this driver.  Please add a comment to describe what is
> happening here.
Thanks for the review. I will send v3 addressing these comments shortly!
>
> >  	ret = ti_sci_proc_get_status(core->tsp, &boot_vec, &cfg, &ctrl,
> >  				     &stat);
> >  	if (ret < 0) {
> > @@ -1280,6 +1287,26 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
> >  		    cluster->mode == CLUSTER_MODE_SINGLECPU ||
> >  		    cluster->mode == CLUSTER_MODE_SINGLECORE)
> >  			break;
> > +
> > +		/*
> > +		 * R5 cores require to be powered on sequentially, core0
> > +		 * should be in higher power state than core1 in a cluster
> > +		 * So, wait for current core to power up before proceeding
> > +		 * to next core and put timeout of 2sec for each core.
> > +		 *
> > +		 * This waiting mechanism is necessary because
> > +		 * rproc_auto_boot_callback() for core1 can be called before
> > +		 * core0 due to thread execution order.
> > +		 */
> > +		ret = wait_event_interruptible_timeout(cluster->core_transition,
> > +						       core->released_from_reset,
> > +						       msecs_to_jiffies(2000));
> > +		if (ret <= 0) {
> > +			dev_err(dev,
> > +				"Timed out waiting for %s core to power up!\n",
> > +				rproc->name);
> > +			return ret;
> > +		}
> >  	}
> >  
> >  	return 0;
> > @@ -1709,6 +1736,7 @@ static int k3_r5_probe(struct platform_device *pdev)
> >  	cluster->dev = dev;
> >  	cluster->soc_data = data;
> >  	INIT_LIST_HEAD(&cluster->cores);
> > +	init_waitqueue_head(&cluster->core_transition);
> >  
> >  	ret = of_property_read_u32(np, "ti,cluster-mode", &cluster->mode);
> >  	if (ret < 0 && ret != -EINVAL) {
> > -- 
> > 2.34.1
> > 
>

