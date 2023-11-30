Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752AE7FEF33
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345327AbjK3Mgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345388AbjK3Mgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:36:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8587C10DE;
        Thu, 30 Nov 2023 04:36:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B0CD1042;
        Thu, 30 Nov 2023 04:37:27 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AA393F5A1;
        Thu, 30 Nov 2023 04:36:39 -0800 (PST)
Date:   Thu, 30 Nov 2023 12:36:36 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     sudeep.holla@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
        linux-arm-kernel@lists.infradead.org, quic_asartor@quicinc.com,
        quic_lingutla@quicinc.com
Subject: Re: [PATCH 1/3] firmware: arm_scmi: Fix null pointer dereference
 during fastchannel init
Message-ID: <ZWiB1ATQF4dAxUHj@pluto>
References: <20231129065748.19871-1-quic_sibis@quicinc.com>
 <20231129065748.19871-2-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129065748.19871-2-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 12:27:46PM +0530, Sibi Sankar wrote:
> The scmi_perf_domain_lookup requires the protocol handle to have the
> private data set, which is yet to happen during the fastchannel init
> scenario. This results in a null pointer dereference. Fix this by using
> the pre-populated perf_dom_info to pass on the required information
> instead.
> 
> Call trace:
> scmi_perf_protocol_init+0x434/0x678
> scmi_get_protocol_instance+0x168/0x29c
> scmi_devres_protocol_instance_get+0x50/0xa0
> scmi_devm_protocol_get+0x20/0x50
> scmi_cpufreq_probe+0x34/0xd4
> scmi_dev_probe+0x28/0x3c
> really_probe+0x148/0x2ac
> __driver_probe_device+0x78/0x12c
> driver_probe_device+0x40/0x160
> __device_attach_driver+0xb8/0x134
> bus_for_each_drv+0x80/0xdc
> __device_attach+0xa8/0x1b0
> device_initial_probe+0x14/0x20
> bus_probe_device+0xa8/0xac
> device_add+0x5cc/0x778
> device_register+0x20/0x30
> __scmi_device_create.part.0+0xec/0x1cc
> scmi_device_create+0x180/0x1c4
> scmi_create_protocol_devices+0x4c/0xb0
> scmi_probe+0x660/0x738
> platform_probe+0x68/0xdc
> really_probe+0x148/0x2ac
> __driver_probe_device+0x78/0x12c
> driver_probe_device+0x40/0x160
> __device_attach_driver+0xb8/0x134
> bus_for_each_drv+0x80/0xdc
> __device_attach+0xa8/0x1b0
> device_initial_probe+0x14/0x20
> bus_probe_device+0xa8/0xac
> deferred_probe_work_func+0x88/0xc0
> process_one_work+0x13c/0x264
> worker_thread+0x32c/0x438
> kthread+0x118/0x11c
> ret_from_fork+0x10/0x20
> 
> Fixes: 619bc6e034f3 ("firmware: arm_scmi: Populate fastchannel info only if set operations are allowed")
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---

Yes indeed, I made this same error in the past and then I missed it when
reviewing the offending patch :< ...

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

>  drivers/firmware/arm_scmi/perf.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index d1323c5d9c27..a648521e04a3 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -759,40 +759,35 @@ static int scmi_perf_level_limits_notify(const struct scmi_protocol_handle *ph,
>  }
>  
>  static void scmi_perf_domain_init_fc(const struct scmi_protocol_handle *ph,
> -				     u32 domain, struct scmi_fc_info **p_fc)
> +				     struct perf_dom_info *dom)
>  {
>  	struct scmi_fc_info *fc;
> -	struct perf_dom_info *dom;
> -
> -	dom = scmi_perf_domain_lookup(ph, domain);
> -	if (IS_ERR(dom))
> -		return;
>  
>  	fc = devm_kcalloc(ph->dev, PERF_FC_MAX, sizeof(*fc), GFP_KERNEL);
>  	if (!fc)
>  		return;
>  
>  	ph->hops->fastchannel_init(ph, PERF_DESCRIBE_FASTCHANNEL,
> -				   PERF_LEVEL_GET, 4, domain,
> +				   PERF_LEVEL_GET, 4, dom->id,
>  				   &fc[PERF_FC_LEVEL].get_addr, NULL);
>  
>  	ph->hops->fastchannel_init(ph, PERF_DESCRIBE_FASTCHANNEL,
> -				   PERF_LIMITS_GET, 8, domain,
> +				   PERF_LIMITS_GET, 8, dom->id,
>  				   &fc[PERF_FC_LIMIT].get_addr, NULL);
>  
>  	if (dom->info.set_perf)
>  		ph->hops->fastchannel_init(ph, PERF_DESCRIBE_FASTCHANNEL,
> -					   PERF_LEVEL_SET, 4, domain,
> +					   PERF_LEVEL_SET, 4, dom->id,
>  					   &fc[PERF_FC_LEVEL].set_addr,
>  					   &fc[PERF_FC_LEVEL].set_db);
>  
>  	if (dom->set_limits)
>  		ph->hops->fastchannel_init(ph, PERF_DESCRIBE_FASTCHANNEL,
> -					   PERF_LIMITS_SET, 8, domain,
> +					   PERF_LIMITS_SET, 8, dom->id,
>  					   &fc[PERF_FC_LIMIT].set_addr,
>  					   &fc[PERF_FC_LIMIT].set_db);
>  
> -	*p_fc = fc;
> +	dom->fc_info = fc;
>  }
>  
>  static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
> @@ -1102,7 +1097,7 @@ static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
>  		scmi_perf_describe_levels_get(ph, dom, version);
>  
>  		if (dom->perf_fastchannels)
> -			scmi_perf_domain_init_fc(ph, dom->id, &dom->fc_info);
> +			scmi_perf_domain_init_fc(ph, dom);
>  	}
>  
>  	ret = devm_add_action_or_reset(ph->dev, scmi_perf_xa_destroy, pinfo);
> -- 
> 2.17.1
> 
