Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFC47A23F1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbjIOQwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbjIOQvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:51:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D68E6E;
        Fri, 15 Sep 2023 09:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694796700; x=1726332700;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hV7ri2QcMrtTel/YBw6177BdZCvTJg4PvROjGVpyhUA=;
  b=Gr/z95WPSGQ6ufwDozoi71y+0gFxmJy47BeCT54kX4B8/mZjZG0+abP1
   YFSnOPnbhUoZ1LmNYLSAzekGWCpWBqS2mXT7L8WTMouTcW216Bjq1ZOvI
   J4cyKGGcHDmZ0Uhij+fpVoda1FSoiKQ1ktNpg4UmTyltic0c95E26j94C
   p7/uylIdx/epOLY2LSzHSJTmIfGYSTcR88P4zp543azdsHqlKbzdeR1Ro
   QGq4WljEu2dcFBDGk9t1HF6ZWeJPKDRLO4Qja/asfCyDc2YMn7xoawGGW
   Y8GEoBugEUuOBE+iUiAMcgtiSG5BEUg4wuUL5feWoEiC7QoP7tf+dbx3n
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="465654679"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="465654679"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 09:51:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="774380992"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="774380992"
Received: from srdoo-mobl1.ger.corp.intel.com ([10.252.38.99])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 09:51:34 -0700
Date:   Fri, 15 Sep 2023 19:51:32 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jithu Joseph <jithu.joseph@intel.com>
cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rostedt@goodmis.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        pengfei.xu@intel.com
Subject: Re: [PATCH 04/10] platform/x86/intel/ifs: Scan test for new
 generations
In-Reply-To: <20230913183348.1349409-5-jithu.joseph@intel.com>
Message-ID: <74882e91-f41e-7672-3835-d74f1364bbdd@linux.intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com> <20230913183348.1349409-5-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023, Jithu Joseph wrote:

> Make changes to scan test flow such that MSRs are populated
> appropriately based on the generation supported by hardware.
> 
> Width of chunk related bitfields is ACTIVATE_SCAN and SCAN_STATUS MSRs
> are different in newer IFS generation compared to gen0.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/ifs.h     | 14 ++++++++++++++
>  drivers/platform/x86/intel/ifs/runtest.c | 23 ++++++++++++++++++-----
>  2 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index 886dc74de57d..3265a6d8a6f3 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -205,6 +205,12 @@ union ifs_scan {
>  		u32	delay	:31;
>  		u32	sigmce	:1;
>  	};
> +	struct {
> +		u16	start;
> +		u16	stop;
> +		u32	delay	:31;
> +		u32	sigmce	:1;
> +	} gen2;

I don't like the way old struct is left without genx naming. It makes the 
code below more confusing as is.

>  };
>  
>  /* MSR_SCAN_STATUS bit fields */
> @@ -219,6 +225,14 @@ union ifs_status {
>  		u32	control_error		:1;
>  		u32	signature_error		:1;
>  	};
> +	struct {
> +		u16	chunk_num;
> +		u16	chunk_stop_index;
> +		u8	error_code;
> +		u32	rsvd1			:22;
> +		u32	control_error		:1;
> +		u32	signature_error		:1;

Again, I don't think the alignment will be correct in this case.

> +	} gen2;
>  };
>  
>  /* MSR_ARRAY_BIST bit fields */
> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
> index 1061eb7ec399..4bbab6be2fa2 100644
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c
> @@ -171,6 +171,8 @@ static void ifs_test_core(int cpu, struct device *dev)
>  	union ifs_status status;
>  	unsigned long timeout;
>  	struct ifs_data *ifsd;
> +	int to_start, to_stop;
> +	int status_chunk;
>  	u64 msrvals[2];
>  	int retries;
>  
> @@ -179,13 +181,21 @@ static void ifs_test_core(int cpu, struct device *dev)
>  	activate.rsvd = 0;
>  	activate.delay = IFS_THREAD_WAIT;
>  	activate.sigmce = 0;
> -	activate.start = 0;
> -	activate.stop = ifsd->valid_chunks - 1;
> +	to_start = 0;
> +	to_stop = ifsd->valid_chunks - 1;
> +
> +	if (ifsd->generation) {
> +		activate.gen2.start = to_start;
> +		activate.gen2.stop = to_stop;
> +	} else {
> +		activate.start = to_start;
> +		activate.stop = to_stop;
> +	}
>  
>  	timeout = jiffies + HZ / 2;
>  	retries = MAX_IFS_RETRIES;
>  
> -	while (activate.start <= activate.stop) {
> +	while (to_start <= to_stop) {
>  		if (time_after(jiffies, timeout)) {
>  			status.error_code = IFS_SW_TIMEOUT;
>  			break;
> @@ -202,7 +212,8 @@ static void ifs_test_core(int cpu, struct device *dev)
>  		if (!can_restart(status))
>  			break;
>  
> -		if (status.chunk_num == activate.start) {
> +		status_chunk = ifsd->generation ? status.gen2.chunk_num : status.chunk_num;
> +		if (status_chunk == to_start) {
>  			/* Check for forward progress */
>  			if (--retries == 0) {
>  				if (status.error_code == IFS_NO_ERROR)
> @@ -211,7 +222,9 @@ static void ifs_test_core(int cpu, struct device *dev)
>  			}
>  		} else {
>  			retries = MAX_IFS_RETRIES;
> -			activate.start = status.chunk_num;
> +			ifsd->generation ? (activate.gen2.start = status_chunk) :
> +			 (activate.start = status_chunk);

Misaligned.

> +			to_start = status_chunk;
>  		}
>  	}
>  
> 

-- 
 i.

