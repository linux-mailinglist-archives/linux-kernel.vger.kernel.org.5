Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669E57946D4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 01:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbjIFXKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 19:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjIFXKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 19:10:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C2819AE;
        Wed,  6 Sep 2023 16:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694041814; x=1725577814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fEw9pa/NdSdFIzoYPpsMEnIibMq4wIaQI1Ds5infKOM=;
  b=E5rzABPYSUURtvuKavD2wZ4b1H84KsKUutiZMZiJe3II2r483z5XAlGM
   7WHQIbxwevRaRyqlCp80h4pDIM60/dacXQI+UjnARlHePz1q9tF6g0EAR
   pduio5XivamZs0wulZBJHPrCMmnLa8RpkaNgiORxFJ0A9TSdeQX0JF6g1
   zZFRMS/JovbQH74h/JWerVXby5VYq8Px9cQOroyK9KIC6R3iYHXZBBPGw
   hhz7L0hk5WfLgJKuTX6QhqPpAM4nFRF+EKfxp9XnTQEzzfE5JhIWGsiPS
   NKy0ghWtHHpi49rkPSfHDbbWd2zz8jicA8icHZ34e1zOeto4WCcMoNCWi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="408215572"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="408215572"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 16:10:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="744866586"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="744866586"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 06 Sep 2023 16:10:09 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qe1ew-0000gB-2m;
        Wed, 06 Sep 2023 23:10:06 +0000
Date:   Thu, 7 Sep 2023 07:09:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Andryuk <jandryuk@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Roger Pau Monne <roger.pau@citrix.com>,
        stable@vger.kernel.org, Jason Andryuk <jandryuk@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] acpi/processor: sanitize _PDC buffer bits when
 running as Xen dom0
Message-ID: <202309070625.dJUDcGZg-lkp@intel.com>
References: <20230906182125.48642-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906182125.48642-1-jandryuk@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on v6.5]
[cannot apply to rafael-pm/linux-next linus/master next-20230906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Andryuk/acpi-processor-sanitize-_PDC-buffer-bits-when-running-as-Xen-dom0/20230907-022235
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20230906182125.48642-1-jandryuk%40gmail.com
patch subject: [PATCH v2] acpi/processor: sanitize _PDC buffer bits when running as Xen dom0
config: x86_64-randconfig-r011-20230907 (https://download.01.org/0day-ci/archive/20230907/202309070625.dJUDcGZg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230907/202309070625.dJUDcGZg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309070625.dJUDcGZg-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/acpi/processor_pdc.c: In function 'acpi_processor_eval_pdc':
>> drivers/acpi/processor_pdc.c:147:17: error: implicit declaration of function 'xen_sanitize_pdc' [-Werror=implicit-function-declaration]
     147 |                 xen_sanitize_pdc(buffer);
         |                 ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/xen_sanitize_pdc +147 drivers/acpi/processor_pdc.c

   116	
   117	/*
   118	 * _PDC is required for a BIOS-OS handshake for most of the newer
   119	 * ACPI processor features.
   120	 */
   121	static acpi_status
   122	acpi_processor_eval_pdc(acpi_handle handle, struct acpi_object_list *pdc_in)
   123	{
   124		acpi_status status = AE_OK;
   125		union acpi_object *obj;
   126		u32 *buffer = NULL;
   127	
   128		obj = pdc_in->pointer;
   129		buffer = (u32 *)(obj->buffer.pointer);
   130	
   131		if (boot_option_idle_override == IDLE_NOMWAIT) {
   132			/*
   133			 * If mwait is disabled for CPU C-states, the C2C3_FFH access
   134			 * mode will be disabled in the parameter of _PDC object.
   135			 * Of course C1_FFH access mode will also be disabled.
   136			 */
   137			buffer[2] &= ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
   138		}
   139	
   140		if (xen_initial_domain()) {
   141			/*
   142			 * When Linux is running as Xen dom0, the hypervisor is the
   143			 * entity in charge of the processor power management, and so
   144			 * Xen needs to check the OS capabilities reported in the _PDC
   145			 * buffer matches what the hypervisor driver supports.
   146			 */
 > 147			xen_sanitize_pdc(buffer);
   148		}
   149	
   150		status = acpi_evaluate_object(handle, "_PDC", pdc_in, NULL);
   151	
   152		if (ACPI_FAILURE(status))
   153			acpi_handle_debug(handle,
   154			    "Could not evaluate _PDC, using legacy perf control\n");
   155	
   156		return status;
   157	}
   158	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
