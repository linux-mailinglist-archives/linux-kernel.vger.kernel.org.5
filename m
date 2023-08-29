Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E7578BDF8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbjH2Ffe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbjH2FfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:35:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF471B7;
        Mon, 28 Aug 2023 22:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693287273; x=1724823273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qGHFG31yPIV/M/L9zSY0cHEpW0ZoFDwWk16fm7jJJqA=;
  b=IDLPxF35VaEk3P32eMVNTyaD3O7I94m8e0OuQ9sjXeu35cwIhz6wI3Yn
   cFfRBevmGXJml9H531u4BVinoNSBcKSWqrS0FX61HZEnWUhGY+B1A/qh3
   wjCbIdam5BRKzmWmnrM41ZyV0f0LcAOkaRqcLY3QAFdbZ3qaqf5jCC3lO
   60DGdJbXhdounY8UzrHwSR8Y+Qt8J3HdsbST+Ra3RiM0revYxDw/2D+Fz
   1ihHfLoWAS8O1t6rwlBYiLZ2EnsaNWAgChc2ayCgmLAvpMaiX3CFeYZaF
   k3iwQp1ffD25uWpfL9I5chiZ2uwAo+2XUa6Zn63+c5U6mAq7PbafP9AAP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="372697847"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="372697847"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:33:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="732077943"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="732077943"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 28 Aug 2023 22:33:21 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qarLs-0008Qx-1e;
        Tue, 29 Aug 2023 05:33:20 +0000
Date:   Tue, 29 Aug 2023 13:32:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, kernel@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 07/11] firmware: qcom-scm: use SHM bridge if available
Message-ID: <202308291359.QP042fIw-lkp@intel.com>
References: <20230828192507.117334-8-bartosz.golaszewski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828192507.117334-8-bartosz.golaszewski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on arm64/for-next/core linus/master v6.5]
[cannot apply to next-20230828]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/firmware-qcom-scm-drop-unneeded-extern-specifiers/20230829-032930
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230828192507.117334-8-bartosz.golaszewski%40linaro.org
patch subject: [PATCH 07/11] firmware: qcom-scm: use SHM bridge if available
config: m68k-randconfig-r006-20230829 (https://download.01.org/0day-ci/archive/20230829/202308291359.QP042fIw-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230829/202308291359.QP042fIw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308291359.QP042fIw-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/firmware/qcom_scm-smc.o: in function `__scm_smc_call':
>> drivers/firmware/qcom_scm-smc.c:179:(.text+0xa8): undefined reference to `qcom_shm_bridge_alloc'
>> m68k-linux-ld: drivers/firmware/qcom_scm-smc.c:221:(.text+0x1ac): undefined reference to `qcom_shm_bridge_free'
   m68k-linux-ld: drivers/firmware/qcom_scm-smc.c:206:(.text+0x23a): undefined reference to `qcom_shm_bridge_free'


vim +179 drivers/firmware/qcom_scm-smc.c

   148	
   149	
   150	int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
   151			   enum qcom_scm_convention qcom_convention,
   152			   struct qcom_scm_res *res, bool atomic)
   153	{
   154		int arglen = desc->arginfo & 0xf;
   155		int i, ret;
   156		dma_addr_t args_phys = 0;
   157		void *args_virt = NULL;
   158		size_t alloc_len;
   159		gfp_t flag = atomic ? GFP_ATOMIC : GFP_KERNEL;
   160		u32 smccc_call_type = atomic ? ARM_SMCCC_FAST_CALL : ARM_SMCCC_STD_CALL;
   161		u32 qcom_smccc_convention = (qcom_convention == SMC_CONVENTION_ARM_32) ?
   162					    ARM_SMCCC_SMC_32 : ARM_SMCCC_SMC_64;
   163		struct arm_smccc_res smc_res;
   164		struct arm_smccc_args smc = {0};
   165		bool using_shm_bridge = qcom_scm_shm_bridge_available();
   166	
   167		smc.args[0] = ARM_SMCCC_CALL_VAL(
   168			smccc_call_type,
   169			qcom_smccc_convention,
   170			desc->owner,
   171			SCM_SMC_FNID(desc->svc, desc->cmd));
   172		smc.args[1] = desc->arginfo;
   173		for (i = 0; i < SCM_SMC_N_REG_ARGS; i++)
   174			smc.args[i + SCM_SMC_FIRST_REG_IDX] = desc->args[i];
   175	
   176		if (unlikely(arglen > SCM_SMC_N_REG_ARGS)) {
   177			alloc_len = SCM_SMC_N_EXT_ARGS * sizeof(u64);
   178			if (using_shm_bridge)
 > 179				args_virt = qcom_shm_bridge_alloc(NULL,
   180								  PAGE_ALIGN(alloc_len),
   181								  flag);
   182			else
   183				args_virt = kzalloc(PAGE_ALIGN(alloc_len), flag);
   184			if (!args_virt)
   185				return -ENOMEM;
   186	
   187			if (qcom_smccc_convention == ARM_SMCCC_SMC_32) {
   188				__le32 *args = args_virt;
   189	
   190				for (i = 0; i < SCM_SMC_N_EXT_ARGS; i++)
   191					args[i] = cpu_to_le32(desc->args[i +
   192							      SCM_SMC_FIRST_EXT_IDX]);
   193			} else {
   194				__le64 *args = args_virt;
   195	
   196				for (i = 0; i < SCM_SMC_N_EXT_ARGS; i++)
   197					args[i] = cpu_to_le64(desc->args[i +
   198							      SCM_SMC_FIRST_EXT_IDX]);
   199			}
   200	
   201			args_phys = dma_map_single(dev, args_virt, alloc_len,
   202						   DMA_TO_DEVICE);
   203	
   204			if (dma_mapping_error(dev, args_phys)) {
   205				if (using_shm_bridge)
   206					qcom_shm_bridge_free(args_virt);
   207				else
   208					kfree(args_virt);
   209				return -ENOMEM;
   210			}
   211	
   212			smc.args[SCM_SMC_LAST_REG_IDX] = args_phys;
   213		}
   214	
   215		/* ret error check follows after args_virt cleanup*/
   216		ret = __scm_smc_do(dev, &smc, &smc_res, atomic);
   217	
   218		if (args_virt) {
   219			dma_unmap_single(dev, args_phys, alloc_len, DMA_TO_DEVICE);
   220			if (using_shm_bridge)
 > 221				qcom_shm_bridge_free(args_virt);
   222			else
   223				kfree(args_virt);
   224		}
   225	
   226		if (ret)
   227			return ret;
   228	
   229		if (res) {
   230			res->result[0] = smc_res.a1;
   231			res->result[1] = smc_res.a2;
   232			res->result[2] = smc_res.a3;
   233		}
   234	
   235		return (long)smc_res.a0 ? qcom_scm_remap_error(smc_res.a0) : 0;
   236	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
