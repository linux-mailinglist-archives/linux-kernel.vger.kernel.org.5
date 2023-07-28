Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3840E7678D5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 01:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbjG1XOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 19:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjG1XOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 19:14:52 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF8B2D7D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 16:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690586091; x=1722122091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fLe4Ct711d/Zn0z3CT2OW6j2I1oNFAQYdsbRkTnNbnQ=;
  b=W4rTl1rO6VtcJ6Dy1luPOzkqWI3DLWs9NBneAedF9MaiqTZjePZyF8uT
   eOrEW+tCzh6oRuG18F/Pxwon8jHjo5WaGegDBMI5kl0y5qE+6CxDPOa3o
   fIc39MNc8zgyZXgXMgxuvpoh2cUKRz2BFPBDIZNZUPHT+88W72KheOP1S
   dq9sFFdLFxhYk/yn7yXHCsmCOeB+e81WYaPz/Uea/kZ6S7JcmxnS6uNdj
   SvQ4Sg8TE/7wQEkNf7sULG6cjVEX09ms0+sXuK1Js39eHA0391HFeLIs/
   gcq/d2pJQn0xNeVn7wSSUX4XPPB6usILhSgtoDAFworA6IwX90Jy0CSYE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="372334225"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="372334225"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 16:14:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="762735849"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="762735849"
Received: from rhedaoo-mobl1.amr.corp.intel.com (HELO desk) ([10.252.141.89])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 16:14:50 -0700
Date:   Fri, 28 Jul 2023 16:14:25 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     x86@kernel.org, bp@alien8.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu/amd: Report zenbleed in sysfs
Message-ID: <20230728231425.mku5wnsgfzx2kyeo@desk>
References: <20230727075446.1749969-1-nik.borisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727075446.1749969-1-nik.borisov@suse.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 10:54:46AM +0300, Nikolay Borisov wrote:
> Initial submission of Zenbleed fix omitted reporting the bug in sysfs.
> There's no reason why it shouldn't be reported so let's add it among
> the other vulnerabilities.
> 
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
>  .../ABI/testing/sysfs-devices-system-cpu          |  1 +
>  arch/x86/kernel/cpu/amd.c                         | 15 +++++++++++++++
>  drivers/base/cpu.c                                |  8 ++++++++
>  include/linux/cpu.h                               |  2 ++
>  4 files changed, 26 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index ecd585ca2d50..30bb4196e451 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -524,6 +524,7 @@ What:		/sys/devices/system/cpu/vulnerabilities
>  		/sys/devices/system/cpu/vulnerabilities/itlb_multihit
>  		/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
>  		/sys/devices/system/cpu/vulnerabilities/retbleed
> +		/sys/devices/system/cpu/vulnerabilities/zenbleed
>  Date:		January 2018
>  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
>  Description:	Information about CPU vulnerabilities
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 26ad7ca423e7..3ab9745eafc5 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1279,6 +1279,21 @@ u32 amd_get_highest_perf(void)
>  }
>  EXPORT_SYMBOL_GPL(amd_get_highest_perf);
>  
> +ssize_t cpu_show_zenbleed(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +

Extra newline.

> +	if (!cpu_has_amd_erratum(&boot_cpu_data, amd_zenbleed) ||
> +	    !boot_cpu_has(X86_FEATURE_AVX) ||
> +	    boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +		return sysfs_emit(buf, "Not affected\n");
> +
> +	if (!cpu_has_zenbleed_microcode()) {

For readability this can check of microcode present case, and drop the
NOT operator.

> +		return sysfs_emit(buf, "Mitigation: Chickenbit\n");

Shouldn't this be checking if the chicken bit is set? And if its not set
then report "Vulnerable".

But, looking at zenbleed_check() it appear that the chicken bit for
zenbleed will always be present, and it will always be set if microcode
is not present.

> +	} else {
> +		return sysfs_emit(buf, "Mitigation: Microcode\n");
> +	}
> +}
