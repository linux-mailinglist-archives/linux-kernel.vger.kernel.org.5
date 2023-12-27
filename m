Return-Path: <linux-kernel+bounces-11985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC82F81EE81
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3651C22565
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A89446AE;
	Wed, 27 Dec 2023 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U48fcLjr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02105446A4;
	Wed, 27 Dec 2023 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703675500; x=1735211500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=01qI/GBdq6ELgj5bG9Jwe+wf9xtm9z3pjjmaJ3Nm/O0=;
  b=U48fcLjrP1eq/QmHrcHtsaCZXlCzuylD1/VZSKFe/J/8IYrEXGfj1AzN
   ssqcPIh1qsi5ysS6L0XH76fJUWLxJI4koCI+470uRl7Z73iQDghVBDikX
   W6BZDODleq0EQGVl6BS5Wwj7Hu1ZWxu+JqniXI74wseF34C+OlgUHSus2
   sel7Hd+G6MQosACmRA4QRnTRn8DVGjEGJ9lgIkuYW9lLUtnFR7MKNCH2i
   ASKrR+r/DqsQ2iWTeOusIHwkcKSZeTs60rpsWr4S4gihUr+wke0C5679S
   esAeg4md5NlptmcryCR1A0SMKB1dNsIUKjFSIpk+IO/YON7e/XcCM8/EE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="393591067"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="393591067"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 03:11:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="807118544"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="807118544"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 27 Dec 2023 03:11:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rIRp0-000FK1-0L;
	Wed, 27 Dec 2023 11:11:34 +0000
Date: Wed, 27 Dec 2023 19:10:42 +0800
From: kernel test robot <lkp@intel.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] regulator: qcom_smd: Keep one rpm handle for all vregs
Message-ID: <202312271812.C5jldM3L-lkp@intel.com>
References: <20231227-topic-rpm_vreg_cleanup-v1-1-949da0864ac5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227-topic-rpm_vreg_cleanup-v1-1-949da0864ac5@linaro.org>

Hi Konrad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 39676dfe52331dba909c617f213fdb21015c8d10]

url:    https://github.com/intel-lab-lkp/linux/commits/Konrad-Dybcio/regulator-qcom_smd-Keep-one-rpm-handle-for-all-vregs/20231227-093153
base:   39676dfe52331dba909c617f213fdb21015c8d10
patch link:    https://lore.kernel.org/r/20231227-topic-rpm_vreg_cleanup-v1-1-949da0864ac5%40linaro.org
patch subject: [PATCH] regulator: qcom_smd: Keep one rpm handle for all vregs
config: arc-randconfig-001-20231227 (https://download.01.org/0day-ci/archive/20231227/202312271812.C5jldM3L-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231227/202312271812.C5jldM3L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312271812.C5jldM3L-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/regulator/qcom_smd-regulator.c:1395: warning: Excess function parameter 'rpm' description in 'rpm_regulator_init_vreg'


vim +1395 drivers/regulator/qcom_smd-regulator.c

da65e367b67e15 Bjorn Andersson 2015-08-17  1379  
14e2976fbabdac Konrad Dybcio   2021-12-30  1380  /**
14e2976fbabdac Konrad Dybcio   2021-12-30  1381   * rpm_regulator_init_vreg() - initialize all attributes of a qcom_smd-regulator
14e2976fbabdac Konrad Dybcio   2021-12-30  1382   * @vreg:		Pointer to the individual qcom_smd-regulator resource
14e2976fbabdac Konrad Dybcio   2021-12-30  1383   * @dev:		Pointer to the top level qcom_smd-regulator PMIC device
14e2976fbabdac Konrad Dybcio   2021-12-30  1384   * @node:		Pointer to the individual qcom_smd-regulator resource
14e2976fbabdac Konrad Dybcio   2021-12-30  1385   *			device node
14e2976fbabdac Konrad Dybcio   2021-12-30  1386   * @rpm:		Pointer to the rpm bus node
14e2976fbabdac Konrad Dybcio   2021-12-30  1387   * @pmic_rpm_data:	Pointer to a null-terminated array of qcom_smd-regulator
14e2976fbabdac Konrad Dybcio   2021-12-30  1388   *			resources defined for the top level PMIC device
14e2976fbabdac Konrad Dybcio   2021-12-30  1389   *
14e2976fbabdac Konrad Dybcio   2021-12-30  1390   * Return: 0 on success, errno on failure
14e2976fbabdac Konrad Dybcio   2021-12-30  1391   */
14e2976fbabdac Konrad Dybcio   2021-12-30  1392  static int rpm_regulator_init_vreg(struct qcom_rpm_reg *vreg, struct device *dev,
d7cdd450e31088 Konrad Dybcio   2023-12-27  1393  				   struct device_node *node,
14e2976fbabdac Konrad Dybcio   2021-12-30  1394  				   const struct rpm_regulator_data *pmic_rpm_data)
da65e367b67e15 Bjorn Andersson 2015-08-17 @1395  {
da65e367b67e15 Bjorn Andersson 2015-08-17  1396  	struct regulator_config config = {};
14e2976fbabdac Konrad Dybcio   2021-12-30  1397  	const struct rpm_regulator_data *rpm_data;
da65e367b67e15 Bjorn Andersson 2015-08-17  1398  	struct regulator_dev *rdev;
14e2976fbabdac Konrad Dybcio   2021-12-30  1399  	int ret;
14e2976fbabdac Konrad Dybcio   2021-12-30  1400  
14e2976fbabdac Konrad Dybcio   2021-12-30  1401  	for (rpm_data = pmic_rpm_data; rpm_data->name; rpm_data++)
14e2976fbabdac Konrad Dybcio   2021-12-30  1402  		if (of_node_name_eq(node, rpm_data->name))
14e2976fbabdac Konrad Dybcio   2021-12-30  1403  			break;
14e2976fbabdac Konrad Dybcio   2021-12-30  1404  
14e2976fbabdac Konrad Dybcio   2021-12-30  1405  	if (!rpm_data->name) {
14e2976fbabdac Konrad Dybcio   2021-12-30  1406  		dev_err(dev, "Unknown regulator %pOFn\n", node);
14e2976fbabdac Konrad Dybcio   2021-12-30  1407  		return -EINVAL;
14e2976fbabdac Konrad Dybcio   2021-12-30  1408  	}
14e2976fbabdac Konrad Dybcio   2021-12-30  1409  
14e2976fbabdac Konrad Dybcio   2021-12-30  1410  	vreg->dev	= dev;
14e2976fbabdac Konrad Dybcio   2021-12-30  1411  	vreg->type	= rpm_data->type;
14e2976fbabdac Konrad Dybcio   2021-12-30  1412  	vreg->id	= rpm_data->id;
14e2976fbabdac Konrad Dybcio   2021-12-30  1413  
14e2976fbabdac Konrad Dybcio   2021-12-30  1414  	memcpy(&vreg->desc, rpm_data->desc, sizeof(vreg->desc));
14e2976fbabdac Konrad Dybcio   2021-12-30  1415  	vreg->desc.name = rpm_data->name;
14e2976fbabdac Konrad Dybcio   2021-12-30  1416  	vreg->desc.supply_name = rpm_data->supply;
14e2976fbabdac Konrad Dybcio   2021-12-30  1417  	vreg->desc.owner = THIS_MODULE;
14e2976fbabdac Konrad Dybcio   2021-12-30  1418  	vreg->desc.type = REGULATOR_VOLTAGE;
14e2976fbabdac Konrad Dybcio   2021-12-30  1419  	vreg->desc.of_match = rpm_data->name;
14e2976fbabdac Konrad Dybcio   2021-12-30  1420  
14e2976fbabdac Konrad Dybcio   2021-12-30  1421  	config.dev		= dev;
14e2976fbabdac Konrad Dybcio   2021-12-30  1422  	config.of_node		= node;
14e2976fbabdac Konrad Dybcio   2021-12-30  1423  	config.driver_data	= vreg;
14e2976fbabdac Konrad Dybcio   2021-12-30  1424  
14e2976fbabdac Konrad Dybcio   2021-12-30  1425  	rdev = devm_regulator_register(dev, &vreg->desc, &config);
14e2976fbabdac Konrad Dybcio   2021-12-30  1426  	if (IS_ERR(rdev)) {
14e2976fbabdac Konrad Dybcio   2021-12-30  1427  		ret = PTR_ERR(rdev);
14e2976fbabdac Konrad Dybcio   2021-12-30  1428  		dev_err(dev, "%pOFn: devm_regulator_register() failed, ret=%d\n", node, ret);
14e2976fbabdac Konrad Dybcio   2021-12-30  1429  		return ret;
14e2976fbabdac Konrad Dybcio   2021-12-30  1430  	}
14e2976fbabdac Konrad Dybcio   2021-12-30  1431  
14e2976fbabdac Konrad Dybcio   2021-12-30  1432  	return 0;
14e2976fbabdac Konrad Dybcio   2021-12-30  1433  }
14e2976fbabdac Konrad Dybcio   2021-12-30  1434  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

