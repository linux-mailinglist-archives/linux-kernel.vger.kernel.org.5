Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCC17ECAE9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjKOTA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjKOTAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:00:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7EDD56
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700074819; x=1731610819;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RbfB0ZGkhYRqW4QZA7aVOGXCT2F/bcJXMOiBzTdbGqE=;
  b=ZIzpHvugWS114ljVmx2L32/H2OMkzdf29Cww4vMuISG2cMIuakRJgqPx
   vznJkU7EbAz2lgXn/plbLFelpoCG8DUuTO7NQRPK7daHQN5dZKxz3s/u1
   yl+cf8E9bYbGrmoBYFASexFLU7hqUdnSf+U02150ZffGb+3/tTBpH1S4D
   JC/dzd+zTZ/LOcP/pAdPp9jvLxbRYBiTmJ2BnGyh0+hsBA8T8iKUZ48jg
   I6joUGaUkljadfQqbhTK38vrFZiSZeIP5AtYPNu9Tjf0nzASHXhGem/tK
   TPMtk73qALlN4Fuv5ryW2TOlg1ople250xFi6ifaCJn9ub+7V4++nNfzr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="390733049"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="390733049"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:00:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="714956002"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="714956002"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:00:18 -0800
Received: from [10.212.65.57] (kliang2-mobl1.ccr.corp.intel.com [10.212.65.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id AD25E580D77;
        Wed, 15 Nov 2023 11:00:17 -0800 (PST)
Message-ID: <ceb47045-3188-49ff-85b2-b37c9d0721e1@linux.intel.com>
Date:   Wed, 15 Nov 2023 14:00:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix NULL pointer dereference issue
 in upi_fill_topology()
Content-Language: en-US
To:     alexander.antonov@linux.intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kyle.meyer@hpe.com, alexey.v.bayduraev@linux.intel.com
References: <20231115151327.1874060-1-alexander.antonov@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231115151327.1874060-1-alexander.antonov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-15 10:13 a.m., alexander.antonov@linux.intel.com wrote:
> From: Alexander Antonov <alexander.antonov@linux.intel.com>
> 
> The NULL dereference happens inside upi_fill_topology() procedure in
> case of disabling one of the sockets on the system.
> 
> For example, if you disable the 2nd socket on a 4-socket system then
> uncore_max_dies() returns 3 and inside pmu_alloc_topology() memory will
> be allocated only for 3 sockets and stored in type->topology.
> In discover_upi_topology() memory is accessed by socket id from CPUNODEID
> registers which contain physical ids (from 0 to 3) and on the line:
> 
>     upi = &type->topology[nid][idx];
> 
> out-of-bound access will happen and the 'upi' pointer will be passed to
> upi_fill_topology() where it will be dereferenced.
> 
> To avoid this issue update the code to convert physical socket id to
> logical socket id in discover_upi_topology() before accessing memory.
> 
> Fixes: f680b6e6062e ("perf/x86/intel/uncore: Enable UPI topology discovery for Icelake Server")
> Reported-by: Kyle Meyer <kyle.meyer@hpe.com>
> Tested-by: Kyle Meyer <kyle.meyer@hpe.com>
> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
> ---
>  arch/x86/events/intel/uncore_snbep.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 8250f0f59c2b..49bc27ab26ad 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -5596,7 +5596,7 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
>  	struct pci_dev *ubox = NULL;
>  	struct pci_dev *dev = NULL;
>  	u32 nid, gid;
> -	int i, idx, ret = -EPERM;
> +	int i, idx, lgc_pkg, ret = -EPERM;
>  	struct intel_uncore_topology *upi;
>  	unsigned int devfn;
>  
> @@ -5614,8 +5614,13 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
>  		for (i = 0; i < 8; i++) {
>  			if (nid != GIDNIDMAP(gid, i))
>  				continue;
> +			lgc_pkg = topology_phys_to_logical_pkg(i);
> +			if (lgc_pkg < 0) {
> +				ret = -EPERM;
> +				goto err;
> +			}

In the snbep_pci2phy_map_init(), there are similar codes to find the
logical die id. Can we factor a common function for both of them?

Thanks,
Kan

>  			for (idx = 0; idx < type->num_boxes; idx++) {
> -				upi = &type->topology[nid][idx];
> +				upi = &type->topology[lgc_pkg][idx];
>  				devfn = PCI_DEVFN(dev_link0 + idx, ICX_UPI_REGS_ADDR_FUNCTION);
>  				dev = pci_get_domain_bus_and_slot(pci_domain_nr(ubox->bus),
>  								  ubox->bus->number,
> @@ -5626,6 +5631,7 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
>  						goto err;
>  				}
>  			}
> +			break;
>  		}
>  	}
>  err:
> 
> base-commit: 9bacdd8996c77c42ca004440be610692275ff9d0
