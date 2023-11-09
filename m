Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF547E7509
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 00:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345370AbjKIXO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 18:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjKIXO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 18:14:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751604231;
        Thu,  9 Nov 2023 15:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=h0f/DlHStT+Oyt0mkJL4GO5ZZL6rW4mBRECnrVDau8I=; b=uubL0Kl4vqUGiJtp+YKEl0GDvY
        WGApZsqfrOP4vF8YHxKUBN2tcD7DmhYBp9K7Mrm62ZBBZE3BNO2xswyOyPg3VxVwL9XvDgmAZiefi
        A5yqCtWsgtAFss6+9hhSOKPVC8D5oxtxYUPmaVL6CiiizmyLB5J9/eBWztqSH0C7/jcT6lenmw9pk
        D+2j+X08MbkPV7r3/GeTjYFm0h22DrUlPK+i0TaaIVwTAb8N8JpT+qFhum+b93DXT9pXe62GXhUq8
        JCoE7XQl4/CraPP3UgwgorTBtne0FBgd3/UpdGPnepCmICX6pW7NoXCEV6fy/5wfp6DgUAP7EeLEo
        xX1e3tLA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r1EEW-007PiG-2T;
        Thu, 09 Nov 2023 23:14:44 +0000
Message-ID: <932eed52-fd9a-4617-84a4-9376861d1c86@infradead.org>
Date:   Thu, 9 Nov 2023 15:14:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/8] x86/resctrl: Update documentation with Sub-NUMA
 cluster changes
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, patches@lists.linux.dev
References: <20231031211708.37390-1-tony.luck@intel.com>
 <20231109230915.73600-1-tony.luck@intel.com>
 <20231109230915.73600-9-tony.luck@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231109230915.73600-9-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

If you make any updates to this:
(but not critical)

On 11/9/23 15:09, Tony Luck wrote:
> With Sub-NUMA Cluster mode enabled the scope of monitoring resources is
> per-NODE instead of per-L3 cache. Suffixes of directories with "L3" in
> their name refer to Sub-NUMA nodes instead of L3 cache ids.
> 
> Users should be aware that SNC mode also affects the amount of L3 cache
> available for allocation within each SNC node.
> 
> Reviewed-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  Documentation/arch/x86/resctrl.rst | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index a6279df64a9d..d1db200db5f9 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -366,9 +366,9 @@ When control is enabled all CTRL_MON groups will also contain:
>  When monitoring is enabled all MON groups will also contain:
>  
>  "mon_data":
> -	This contains a set of files organized by L3 domain and by
> -	RDT event. E.g. on a system with two L3 domains there will
> -	be subdirectories "mon_L3_00" and "mon_L3_01".	Each of these
> +	This contains a set of files organized by L3 domain or by NUMA
> +	node (depending on whether Sub-NUMA Cluster (SNC) mode is disabled
> +	or enabled respectively) and by RDT event.  Each of these
>  	directories have one file per event (e.g. "llc_occupancy",

	            has

>  	"mbm_total_bytes", and "mbm_local_bytes"). In a MON group these
>  	files provide a read out of the current value of the event for
> @@ -478,6 +478,23 @@ if non-contiguous 1s value is supported. On a system with a 20-bit mask
>  each bit represents 5% of the capacity of the cache. You could partition
>  the cache into four equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
>  
> +Notes on Sub-NUMA Cluster mode
> +==============================
> +When SNC mode is enabled Linux may load balance tasks between Sub-NUMA
> +nodes much more readily than between regular NUMA nodes since the CPUs
> +on Sub-NUMA nodes share the same L3 cache and the system may report
> +the NUMA distance between Sub-NUMA nodes with a lower value than used
> +for regular NUMA nodes.  Users who do not bind tasks to the CPUs of a
> +specific Sub-NUMA node must read the "llc_occupancy", "mbm_total_bytes",
> +and "mbm_local_bytes" for all Sub-NUMA nodes where the tasks may execute
> +to get the full view of traffic for which the tasks were the source.
> +
> +The cache allocation feature still provides the same number of
> +bits in a mask to control allocation into the L3 cache. But each

                                                    cache, but each

> +of those ways has its capacity reduced because the cache is divided
> +between the SNC nodes. The values reported in the resctrl
> +"size" files are adjusted accordingly.
> +
>  Memory bandwidth Allocation and monitoring
>  ==========================================
>  

-- 
~Randy
