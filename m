Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF397B51E8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbjJBL7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbjJBL7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:59:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D25DC;
        Mon,  2 Oct 2023 04:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696247948; x=1727783948;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Wt4lQ+Vn3ccG4DjT09X9x0/9SxVjB8iFicc1DH/dTOI=;
  b=UVxX6Z2bbw5ORchyrQTQX/JBwm728TIswzWm/t6Hh8zUQH3c5B9285tL
   H9i/2uDPtDgAUo5DrOh72xKFcxN5CtQblMnIt+YqJAUmzz66S3mLPbyyI
   HUiwqR2mTEgm2aTfCnTcdxVWKd4ReJEk0BuWWqL81Bi57X9Bw3FLih3RT
   qZHSB5Gr6jvOrM6NkE31JsLoFlQKiXqbrDkCtZo31BQUynPK8SBDzKWma
   51uyQ5FyDdotIAtephBTkePthM40nZyXAcIfY7g+yeJZQfE66/CmJrR02
   FubGk5ZZ9EVQkTZyHCDNaQ+w4Rkb3hSXa772i5iMCVMHFVt7nvmZkNSlx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="413538846"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="413538846"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 04:59:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="816267781"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="816267781"
Received: from roliveir-mobl1.ger.corp.intel.com ([10.251.222.16])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 04:59:04 -0700
Date:   Mon, 2 Oct 2023 14:59:01 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jithu Joseph <jithu.joseph@intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, ashok.raj@intel.com, tony.luck@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: Re: [PATCH v3 9/9] platform/x86/intel/ifs: ARRAY BIST for Sierra
 Forest
In-Reply-To: <20230929202436.2850388-10-jithu.joseph@intel.com>
Message-ID: <b92b44ed-19a7-aec2-615b-1b1755dafdac@linux.intel.com>
References: <20230922232606.1928026-1-jithu.joseph@intel.com> <20230929202436.2850388-1-jithu.joseph@intel.com> <20230929202436.2850388-10-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023, Jithu Joseph wrote:

> Array BIST MSR addresses, bit definition and semantics are different for
> Sierra Forest. Branch into a separate Array BIST flow on Sierra Forest
> when user invokes Array Test.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/ifs.h     |  4 +++
>  drivers/platform/x86/intel/ifs/core.c    | 15 +++++-----
>  drivers/platform/x86/intel/ifs/runtest.c | 37 +++++++++++++++++++++++-
>  3 files changed, 48 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index f0dd849b3400..b183aba3ffdf 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -137,6 +137,8 @@
>  #define MSR_CHUNKS_AUTHENTICATION_STATUS	0x000002c5
>  #define MSR_ACTIVATE_SCAN			0x000002c6
>  #define MSR_SCAN_STATUS				0x000002c7
> +#define MSR_ARRAY_TRIGGER			0x000002d6
> +#define MSR_ARRAY_STATUS			0x000002d7
>  #define MSR_SAF_CTRL				0x000004f0
>  
>  #define SCAN_NOT_TESTED				0
> @@ -272,6 +274,7 @@ struct ifs_test_caps {
>   * @cur_batch: number indicating the currently loaded test file
>   * @generation: IFS test generation enumerated by hardware
>   * @chunk_size: size of a test chunk
> + * @array_gen: test generation of array test
>   */
>  struct ifs_data {
>  	int	loaded_version;
> @@ -283,6 +286,7 @@ struct ifs_data {
>  	u32	cur_batch;
>  	u32	generation;
>  	u32	chunk_size;
> +	u32	array_gen;
>  };
>  
>  struct ifs_work {
> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
> index 0c8927916373..934eaf348f9d 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
> @@ -11,16 +11,16 @@
>  
>  #include "ifs.h"
>  
> -#define X86_MATCH(model)				\
> +#define X86_MATCH(model, array_gen)				\
>  	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,	\
> -		INTEL_FAM6_##model, X86_FEATURE_CORE_CAPABILITIES, NULL)
> +		INTEL_FAM6_##model, X86_FEATURE_CORE_CAPABILITIES, array_gen)
>  
>  static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
> -	X86_MATCH(SAPPHIRERAPIDS_X),
> -	X86_MATCH(EMERALDRAPIDS_X),
> -	X86_MATCH(GRANITERAPIDS_X),
> -	X86_MATCH(GRANITERAPIDS_D),
> -	X86_MATCH(ATOM_CRESTMONT_X),
> +	X86_MATCH(SAPPHIRERAPIDS_X, 0),
> +	X86_MATCH(EMERALDRAPIDS_X, 0),
> +	X86_MATCH(GRANITERAPIDS_X, 0),
> +	X86_MATCH(GRANITERAPIDS_D, 0),
> +	X86_MATCH(ATOM_CRESTMONT_X, 1),

Just a suggestion that would IMO make these easier to understand, you 
could name these array generations with defines so that one does not need 
to look what's defined in X86_MATCH() to understand the purpose of the 
second parameter. But it's up to you.

-- 
 i.

>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
> @@ -100,6 +100,7 @@ static int __init ifs_init(void)
>  			continue;
>  		ifs_devices[i].rw_data.generation = FIELD_GET(MSR_INTEGRITY_CAPS_SAF_GEN_MASK,
>  							      msrval);
> +		ifs_devices[i].rw_data.array_gen = (u32)m->driver_data;
>  		ret = misc_register(&ifs_devices[i].misc);
>  		if (ret)
>  			goto err_exit;
> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
> index 4fe544d79946..a54cd97920c4 100644
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c
> @@ -329,6 +329,38 @@ static void ifs_array_test_core(int cpu, struct device *dev)
>  		ifsd->status = SCAN_TEST_PASS;
>  }
>  
> +#define ARRAY_GEN1_TEST_ALL_ARRAYS	0x0ULL
> +#define ARRAY_GEN1_STATUS_FAIL		0x1ULL
> +
> +static int do_array_test_gen1(void *status)
> +{
> +	int cpu = smp_processor_id();
> +	int first;
> +
> +	first = cpumask_first(cpu_smt_mask(cpu));
> +
> +	if (cpu == first) {
> +		wrmsrl(MSR_ARRAY_TRIGGER, ARRAY_GEN1_TEST_ALL_ARRAYS);
> +		rdmsrl(MSR_ARRAY_STATUS, *((u64 *)status));
> +	}
> +
> +	return 0;
> +}
> +
> +static void ifs_array_test_gen1(int cpu, struct device *dev)
> +{
> +	struct ifs_data *ifsd = ifs_get_data(dev);
> +	u64 status = 0;
> +
> +	stop_core_cpuslocked(cpu, do_array_test_gen1, &status);
> +	ifsd->scan_details = status;
> +
> +	if (status & ARRAY_GEN1_STATUS_FAIL)
> +		ifsd->status = SCAN_TEST_FAIL;
> +	else
> +		ifsd->status = SCAN_TEST_PASS;
> +}
> +
>  /*
>   * Initiate per core test. It wakes up work queue threads on the target cpu and
>   * its sibling cpu. Once all sibling threads wake up, the scan test gets executed and
> @@ -356,7 +388,10 @@ int do_core_test(int cpu, struct device *dev)
>  		ifs_test_core(cpu, dev);
>  		break;
>  	case IFS_TYPE_ARRAY_BIST:
> -		ifs_array_test_core(cpu, dev);
> +		if (ifsd->array_gen == 0)
> +			ifs_array_test_core(cpu, dev);
> +		else
> +			ifs_array_test_gen1(cpu, dev);
>  		break;
>  	default:
>  		return -EINVAL;
> 
