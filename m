Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE64D7FC13A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346511AbjK1Rxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346350AbjK1Rxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:53:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5FBC1;
        Tue, 28 Nov 2023 09:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701194038; x=1732730038;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qIrihs3bgqghpQQf+Q4tySVJ/cFlr64il/GtOmU5bi4=;
  b=TNsE2E77M5FDyCbLjfVI1DNVJ0+jqKpcG6ru5Pr7fH9wXcivn6KTXhE+
   2xCoKafdfTc29fXzAnPwKXBDYXFWy0+3tfuz9w1OlasnpgwS92oko39JY
   Qep33jsFzwqUgEj/AxZBhVVGDQbe8gTV0J0bLt0SnXzNV/EmZ0MVhj7Hq
   V8sGe0P5TFVbJg6glR5FTqgJ5Bz2zeVxvWGYXpYbiHTZ+bNBxJHdnvMq+
   flFwU2siDZrRL/w7Fb7bskdSzuvHBg2NRbbL/97jIKoSLX4sRNTCp9Ti0
   wVyRF8pDQMBt3CiCrsCVEmC8xu8D7R7JtPiGlHXNOvU0iEUpiJiEwP9/H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="424127085"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="424127085"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 09:53:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="834715306"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="834715306"
Received: from skumarso-mobl33.amr.corp.intel.com (HELO [10.255.231.208]) ([10.255.231.208])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 09:53:56 -0800
Message-ID: <e43db38a-206d-4ea5-8813-23e1f918dd65@linux.intel.com>
Date:   Tue, 28 Nov 2023 09:35:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: qcom: allow multi-link on newer devices
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
References: <20231128150049.412236-1-krzysztof.kozlowski@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231128150049.412236-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/23 09:00, Krzysztof Kozlowski wrote:
> Newer Qualcomm SoCs like X1E80100 might come with four speakers spread
> over two Soundwire controllers, thus they need a multi-link Soundwire
> stream runtime.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> This is an entirely different approach than my previous try here:
> https://lore.kernel.org/all/20231025144601.268645-1-krzysztof.kozlowski@linaro.org/
> ---
>  drivers/soundwire/qcom.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 412b8e663a0a..57943724f0eb 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -920,6 +920,18 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>  	return 0;
>  }
>  
> +static int qcom_swrm_read_prop(struct sdw_bus *bus)
> +{
> +	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
> +
> +	if (ctrl->version >= SWRM_VERSION_2_0_0) {
> +		bus->multi_link = true;
> +		bus->hw_sync_min_links = 3;
> +	}
> +
> +	return 0;
> +}
> +
>  static enum sdw_command_response qcom_swrm_xfer_msg(struct sdw_bus *bus,
>  						    struct sdw_msg *msg)
>  {
> @@ -1078,6 +1090,7 @@ static const struct sdw_master_port_ops qcom_swrm_port_ops = {
>  };
>  
>  static const struct sdw_master_ops qcom_swrm_ops = {
> +	.read_prop = qcom_swrm_read_prop,

nit-pick: read_prop() literally means "read platform properties".

The functionality implemented in this callback looks more like an
initialization done in a probe, no?

>  	.xfer_msg = qcom_swrm_xfer_msg,
>  	.pre_bank_switch = qcom_swrm_pre_bank_switch,
>  	.post_bank_switch = qcom_swrm_post_bank_switch,
> @@ -1196,6 +1209,15 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
>  
>  	mutex_lock(&ctrl->port_lock);
>  	list_for_each_entry(m_rt, &stream->master_list, stream_node) {

just realizing this now, are you sure the 'port_lock' is the proper
means to protecting the stream->master_list? I don't see this used
anywhere else in stream.c. I think you need to use bus_lock.


> +		/*
> +		 * For streams with multiple masters:
> +		 * Allocate ports only for devices connected to this master.
> +		 * Such devices will have ports allocated by their own master
> +		 * and its qcom_swrm_stream_alloc_ports() call.
> +		 */
> +		if (ctrl->bus.id != m_rt->bus->id)
> +			continue;
> +
>  		if (m_rt->direction == SDW_DATA_DIR_RX) {
>  			maxport = ctrl->num_dout_ports;
>  			port_mask = &ctrl->dout_port_mask;
