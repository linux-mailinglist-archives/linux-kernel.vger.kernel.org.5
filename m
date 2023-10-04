Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A747B815D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242704AbjJDNvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjJDNvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:51:17 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B69CA1;
        Wed,  4 Oct 2023 06:51:13 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 394Dp9Ug082441;
        Wed, 4 Oct 2023 08:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696427469;
        bh=sDX674YVDpcJ9C64VYaIERStKJa6MZgCxWcYILeJiJA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Va+S6yX6BjnokyETkvOkHPNuPSjydnAj2tQMaLabRRabLUni3tLJuxBn/NpZfYwBv
         rTg1tRczCn1SfR03wYaddz4feHcjN4+hZEbCbhecpr2c8pCcapi7PSzqNckyRMeLLV
         o6ve5wel/Wosn0oQHuJQtHJR8SSe4dZYR4SuiUts=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 394Dp90o110458
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Oct 2023 08:51:09 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Oct 2023 08:51:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Oct 2023 08:51:09 -0500
Received: from [10.24.69.34] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 394Dp6C5026023;
        Wed, 4 Oct 2023 08:51:06 -0500
Message-ID: <6605ac2e-6217-e554-2456-20f35500683d@ti.com>
Date:   Wed, 4 Oct 2023 19:21:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] remoteproc: k3-r5: Wait for core0 power-up before
 powering up core1
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Nishanth Menon <nm@ti.com>, Bjorn Andersson <andersson@kernel.org>,
        Suman Anna <s-anna@ti.com>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>,
        Hari Nagalla <hnagalla@ti.com>, Udit Kumar <u-kumar1@ti.com>
References: <20230906124756.3480579-1-a-nandan@ti.com> <ZP9ELdOQ9WMj2Rxd@p14s>
From:   Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <ZP9ELdOQ9WMj2Rxd@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 11/09/23 22:15, Mathieu Poirier wrote:
> Hi Apurva,
>
> On Wed, Sep 06, 2023 at 06:17:56PM +0530, Apurva Nandan wrote:
>> PSC controller has a limitation that it can only power-up the second core
>> when the first core is in ON state. Power-state for core0 should be equal
>> to or higher than core1, else the kernel is seen hanging during rproc
>> loading.
>>
>> Make the powering up of cores sequential, by waiting for the current core
>> to power-up before proceeding to the next core, with a timeout of 2sec.
>> Add a wait queue event in k3_r5_cluster_rproc_init call, that will wait
>> for the current core to be released from reset before proceeding with the
>> next core.
>>
>> Fixes: 6dedbd1d5443 ("remoteproc: k3-r5: Add a remoteproc driver for R5F subsystem")
>>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
>>
>>   kpv report: https://gist.githubusercontent.com/apurvanandan1997/feb3b304121c265b7827be43752b7ae8/raw
>>
>>   drivers/remoteproc/ti_k3_r5_remoteproc.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
>> index ad3415a3851b..ba5e503f7c9c 100644
>> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
>> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
>> @@ -103,12 +103,14 @@ struct k3_r5_soc_data {
>>    * @dev: cached device pointer
>>    * @mode: Mode to configure the Cluster - Split or LockStep
>>    * @cores: list of R5 cores within the cluster
>> + * @core_transition: wait queue to sync core state changes
>>    * @soc_data: SoC-specific feature data for a R5FSS
>>    */
>>   struct k3_r5_cluster {
>>   	struct device *dev;
>>   	enum cluster_mode mode;
>>   	struct list_head cores;
>> +	wait_queue_head_t core_transition;
>>   	const struct k3_r5_soc_data *soc_data;
>>   };
>>   
>> @@ -128,6 +130,7 @@ struct k3_r5_cluster {
>>    * @atcm_enable: flag to control ATCM enablement
>>    * @btcm_enable: flag to control BTCM enablement
>>    * @loczrama: flag to dictate which TCM is at device address 0x0
>> + * @released_from_reset: flag to signal when core is out of reset
>>    */
>>   struct k3_r5_core {
>>   	struct list_head elem;
>> @@ -144,6 +147,7 @@ struct k3_r5_core {
>>   	u32 atcm_enable;
>>   	u32 btcm_enable;
>>   	u32 loczrama;
>> +	bool released_from_reset;
>>   };
>>   
>>   /**
>> @@ -460,6 +464,8 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
>>   			ret);
>>   		return ret;
>>   	}
>> +	core->released_from_reset = true;
>> +	wake_up_interruptible(&cluster->core_transition);
>>   
>>   	/*
>>   	 * Newer IP revisions like on J7200 SoCs support h/w auto-initialization
>> @@ -1140,6 +1146,7 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
>>   		return ret;
>>   	}
>>   
>> +	core->released_from_reset = c_state;
>>   	ret = ti_sci_proc_get_status(core->tsp, &boot_vec, &cfg, &ctrl,
>>   				     &stat);
>>   	if (ret < 0) {
>> @@ -1280,6 +1287,21 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
>>   		    cluster->mode == CLUSTER_MODE_SINGLECPU ||
>>   		    cluster->mode == CLUSTER_MODE_SINGLECORE)
>>   			break;
>> +
>> +		/* R5 cores require to be powered on sequentially, core0
>> +		 * should be in higher power state than core1 in a cluster
>> +		 * So, wait for current core to power up before proceeding
>> +		 * to next core and put timeout of 2sec for each core.
>> +		 */
> Wrong multi-line comment format.
Okay will fix this.
>> +		ret = wait_event_interruptible_timeout(cluster->core_transition,
>> +						       core->released_from_reset,
>> +						       msecs_to_jiffies(2000));
>> +		if (ret <= 0) {
>> +			dev_err(dev,
>> +				"Timed out waiting for %s core to power up!\n",
>> +				rproc->name);
>> +			return ret;
>> +		}
>  From my perspective, this is needed because rproc_auto_boot_callback() for core1
> can be called before core0 due to thread execution order.  Am I correct?
Yes
> If so please add this explanation to the comment you have above.  Also, let's
> say a user decides to switch both cores off after reboot.  At that time, what
> prevents a user from switching on core1 before core0 via sysfs?
Okay, will add the explanation.
Currently, adding support for graceful shutdown is in progress. As of 
now in order
to stop/start core or change firmware, we recommend users to restart the 
OS.
> Thanks,
> Mathieu
>
>>   	}
>>   
>>   	return 0;
>> @@ -1709,6 +1731,7 @@ static int k3_r5_probe(struct platform_device *pdev)
>>   	cluster->dev = dev;
>>   	cluster->soc_data = data;
>>   	INIT_LIST_HEAD(&cluster->cores);
>> +	init_waitqueue_head(&cluster->core_transition);
>>   
>>   	ret = of_property_read_u32(np, "ti,cluster-mode", &cluster->mode);
>>   	if (ret < 0 && ret != -EINVAL) {
>> -- 
>> 2.34.1
>>
