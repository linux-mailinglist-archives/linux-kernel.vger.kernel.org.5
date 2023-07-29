Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD893767DA3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjG2JZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjG2JZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:25:23 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E1535A3;
        Sat, 29 Jul 2023 02:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690622721; x=1722158721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S/3RlvQtNmTMQrZdArWv4udXKUyqBI6whsz5JfZbzp0=;
  b=OhEwUTxF+Q1KzH+Cdt7f9Q0rXsFfgmGoJPndGUUU8OaZv0Fgyy9QmEGv
   K7n7KIvMmW9b64xF8tGDuUA8KAM3lemmqkDiqKdaAmEheIltv+lCAw9VL
   11OxLl2cZ/M0DehlCsbr/PO6rYgurB5H72tYzD38/1FYN3w9qs1n8LLSa
   Z7yaDt+NdeGSKSz1BvInpq2EBy0QHYzgytqRALuwKXizjgK52fia0RI2x
   w398GLW3t+xtxYd78XHB/LzbWr/h0ycg60YgWdz71PP2u1rVvmcDVg2Vz
   QuVhhuCbPA5LQOeXMmNPluNqK9NmRD2o306rPh7v7Trm+xWnWBdg0zMDZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="435038120"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="435038120"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 02:25:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="762828232"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="762828232"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 29 Jul 2023 02:25:18 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPgCL-0003wp-39;
        Sat, 29 Jul 2023 09:25:17 +0000
Date:   Sat, 29 Jul 2023 17:25:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 1/4] interconnect: qcom: icc-rpm: Add AB/IB calculations
 coefficients
Message-ID: <202307291745.0JcdYvBz-lkp@intel.com>
References: <20230726-topic-icc_coeff-v1-1-31616960818c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726-topic-icc_coeff-v1-1-31616960818c@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1e25dd7772483f477f79986d956028e9f47f990a]

url:    https://github.com/intel-lab-lkp/linux/commits/Konrad-Dybcio/interconnect-qcom-icc-rpm-Add-AB-IB-calculations-coefficients/20230727-002710
base:   1e25dd7772483f477f79986d956028e9f47f990a
patch link:    https://lore.kernel.org/r/20230726-topic-icc_coeff-v1-1-31616960818c%40linaro.org
patch subject: [PATCH 1/4] interconnect: qcom: icc-rpm: Add AB/IB calculations coefficients
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230729/202307291745.0JcdYvBz-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307291745.0JcdYvBz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307291745.0JcdYvBz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/interconnect/qcom/icc-rpm.c: In function 'qcom_icc_bus_aggregate':
>> drivers/interconnect/qcom/icc-rpm.c:302:27: warning: variable 'agg_peak_rate' set but not used [-Wunused-but-set-variable]
     302 |         u64 agg_avg_rate, agg_peak_rate, agg_rate;
         |                           ^~~~~~~~~~~~~


vim +/agg_peak_rate +302 drivers/interconnect/qcom/icc-rpm.c

   293	
   294	/**
   295	 * qcom_icc_bus_aggregate - calculate bus clock rates by traversing all nodes
   296	 * @provider: generic interconnect provider
   297	 * @agg_clk_rate: array containing the aggregated clock rates in kHz
   298	 */
   299	static void qcom_icc_bus_aggregate(struct icc_provider *provider, u64 *agg_clk_rate)
   300	{
   301		struct qcom_icc_provider *qp = to_qcom_provider(provider);
 > 302		u64 agg_avg_rate, agg_peak_rate, agg_rate;
   303		struct qcom_icc_node *qn;
   304		struct icc_node *node;
   305		u16 percent;
   306		int i;
   307	
   308		/*
   309		 * Iterate nodes on the provider, aggregate bandwidth requests for
   310		 * every bucket and convert them into bus clock rates.
   311		 */
   312		list_for_each_entry(node, &provider->nodes, node_list) {
   313			qn = node->data;
   314			for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
   315				if (qn->channels)
   316					agg_avg_rate = div_u64(qn->sum_avg[i], qn->channels);
   317				else
   318					agg_avg_rate = qn->sum_avg[i];
   319	
   320				percent = qp->ab_percent ? qp->ab_percent : 100;
   321				agg_avg_rate = mult_frac(percent, agg_avg_rate, 100);
   322	
   323				percent = qn->ib_percent ? qn->ib_percent : 100;
   324				agg_peak_rate = mult_frac(percent, qn->max_peak[i], 100);
   325	
   326				agg_rate = max_t(u64, agg_avg_rate, qn->max_peak[i]);
   327				do_div(agg_rate, qn->buswidth);
   328	
   329				agg_clk_rate[i] = max_t(u64, agg_clk_rate[i], agg_rate);
   330			}
   331		}
   332	}
   333	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
