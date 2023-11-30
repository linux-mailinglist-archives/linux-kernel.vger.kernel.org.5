Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB5F7FEEC9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345219AbjK3MUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjK3MUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:20:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6758A10C9;
        Thu, 30 Nov 2023 04:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701346826; x=1732882826;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=80xyuBnDByo3SNKylZdSIJWjNtZ3epFaIxomWH6eRuM=;
  b=RppGfpEyEejRr/49ZDLtY/mWBZc4ZPK+Z7HxUowNBmaqK8CDlxUf1Dic
   OWT++B5W24UftkTv9VyEz1LqOZhSBLdNV6pC5bYsUHuMu+uC8yi2ZQDPz
   s0YI92W6Q6QSIhPhE/FPsVaKDk3qOPviz8WNdlazM6Q1zh3lU0UpLFgSL
   1C1OowW0kqYIexEBagKGas0VZVPdZi4YwpBjnoiwypj2gYwfE3hi1Xg/P
   B5DuZ1aRb870Fny7FwvE4SaqeM+MzubpOMvW9T8ZFLECLfMpYAFgk94kq
   kYn65a8GJ2Tu+rMErNR2GM3IkPo3FARIH3oDaAPb7XNHtM7PTZZpUoo03
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="390477926"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="390477926"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 04:20:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="803678892"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="803678892"
Received: from bergler-mobl.ger.corp.intel.com ([10.249.33.30])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 04:20:22 -0800
Date:   Thu, 30 Nov 2023 14:20:21 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] platform/x86: ISST: Process read/write blocked
 feature status
In-Reply-To: <20231128185605.3027653-6-srinivas.pandruvada@linux.intel.com>
Message-ID: <853032f0-f49-465b-f164-d49baca51c7b@linux.intel.com>
References: <20231128185605.3027653-1-srinivas.pandruvada@linux.intel.com> <20231128185605.3027653-6-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023, Srinivas Pandruvada wrote:

> When a feature is read blocked, don't continue to read SST information
> and register with SST core.
> 
> When the feature is write blocked, continue to offer read interface for
> SST parameters, but don't allow any operation to change state. A state
> change results from SST level change, feature change or class of service
> change.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../intel/speed_select_if/isst_tpmi_core.c    | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> index 0b6d2c864437..ed3a04d6c99c 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> @@ -514,6 +516,9 @@ static long isst_if_clos_param(void __user *argp)
>  	if (!power_domain_info)
>  		return -EINVAL;
>  
> +	if (power_domain_info->write_blocked)
> +		return -EPERM;
> +

I don't understand this, doesn't this now -EPERM both _write_cp_info() AND
_read_cp_info()??? Does _read_cp_info() also change state??

>  	if (clos_param.get_set) {
>  		_write_cp_info("clos.min_freq", clos_param.min_freq_mhz,
>  			       (SST_CLOS_CONFIG_0_OFFSET + clos_param.clos * SST_REG_SIZE),
> @@ -602,6 +607,9 @@ static long isst_if_clos_assoc(void __user *argp)
>  
>  		power_domain_info = &sst_inst->power_domain_info[punit_id];
>  
> +		if (power_domain_info->write_blocked)
> +			return -EPERM;

Same here, this blocks also the get path?


-- 
 i.

