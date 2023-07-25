Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49BF76101F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjGYKDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjGYKDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:03:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3EA10C7;
        Tue, 25 Jul 2023 03:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690279359; x=1721815359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nRox8bHxS/39eurF4RvG/G/NsD5J1/KSWjHQMAHx2Iw=;
  b=hJbp/KoxPdxIAFE3pe5pmYJiBWE+tC2XE/+OTVkCGIooYC7ji59uYt2G
   hifdjvh/9rPVvis+2jMuGCwCE5V7nzZOxSmrRLt1SrCnKKYtjvuWf2YXv
   aMU8UO1k4lOkl73/YttIkl81gNpGm/sZAjkcg5/m2E1kvHTGOSz3vp8Tz
   7bjkyFRR9wVqPVuZgmUwRzbgqSySsdKQciz1lxHwmAA+3VWyUBbfxnTdr
   6S7Vedx6dZ/h1iimH9hJsI/DZ3Yn4LW7IeEFEY78Ts4KPM8f+wXak24D6
   3WfaU1KCLhNQAuGGarvy7fuDq2GKIqtPsM346KY1fs7cWjaDr2za7FXZ4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="366558548"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="366558548"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 03:02:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="972607892"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="972607892"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2023 03:02:30 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOEs9-000AWl-2Z;
        Tue, 25 Jul 2023 10:02:29 +0000
Date:   Tue, 25 Jul 2023 18:01:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org,
        dmitry.baryshkov@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_fenglinw@quicinc.com, quic_kamalw@quicinc.com,
        jestar@qti.qualcomm.com
Subject: Re: [PATCH v3 1/3] input: pm8xxx-vib: refactor to easily support new
 SPMI vibrator
Message-ID: <202307251741.PMtlVAgD-lkp@intel.com>
References: <20230725054138.129497-2-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725054138.129497-2-quic_fenglinw@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenglin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on dtor-input/for-linus linus/master v6.5-rc3 next-20230725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fenglin-Wu/input-pm8xxx-vib-refactor-to-easily-support-new-SPMI-vibrator/20230725-134504
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20230725054138.129497-2-quic_fenglinw%40quicinc.com
patch subject: [PATCH v3 1/3] input: pm8xxx-vib: refactor to easily support new SPMI vibrator
config: x86_64-buildonly-randconfig-r002-20230725 (https://download.01.org/0day-ci/archive/20230725/202307251741.PMtlVAgD-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230725/202307251741.PMtlVAgD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307251741.PMtlVAgD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/input/misc/pm8xxx-vibrator.c:190:17: warning: cast to smaller integer type 'enum pm8xxx_vib_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
           vib->hw_type = (enum pm8xxx_vib_type)of_device_get_match_data(dev);
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +190 drivers/input/misc/pm8xxx-vibrator.c

   163	
   164	static int pm8xxx_vib_probe(struct platform_device *pdev)
   165	{
   166		struct pm8xxx_vib *vib;
   167		struct input_dev *input_dev;
   168		struct device *dev = &pdev->dev;
   169		struct regmap *regmap;
   170		struct reg_field *regs;
   171		int error, i;
   172		unsigned int val;
   173		u32 reg_base;
   174	
   175		vib = devm_kzalloc(dev, sizeof(*vib), GFP_KERNEL);
   176		if (!vib)
   177			return -ENOMEM;
   178	
   179		regmap = dev_get_regmap(dev->parent, NULL);
   180		if (!regmap)
   181			return -ENODEV;
   182	
   183		input_dev = devm_input_allocate_device(dev);
   184		if (!input_dev)
   185			return -ENOMEM;
   186	
   187		INIT_WORK(&vib->work, pm8xxx_work_handler);
   188		vib->vib_input_dev = input_dev;
   189	
 > 190		vib->hw_type = (enum pm8xxx_vib_type)of_device_get_match_data(dev);
   191	
   192		regs = ssbi_vib_regs;
   193		if (vib->hw_type != SSBI_VIB) {
   194			error = fwnode_property_read_u32(dev->fwnode, "reg", &reg_base);
   195			if (error < 0) {
   196				dev_err(dev, "Failed to read reg address, rc=%d\n", error);
   197				return error;
   198			}
   199	
   200			if (vib->hw_type == SPMI_VIB_GEN1)
   201				regs = spmi_vib_gen1_regs;
   202	
   203			for (i = 0; i < VIB_MAX_REG; i++)
   204				if (regs[i].reg != 0)
   205					regs[i].reg += reg_base;
   206		}
   207	
   208		error = devm_regmap_field_bulk_alloc(dev, regmap, vib->r_fields, regs, VIB_MAX_REG);
   209		if (error < 0)
   210		{
   211			dev_err(dev, "Failed to allocate regmap failed, rc=%d\n", error);
   212			return error;
   213		}
   214	
   215		error = regmap_field_read(vib->r_fields[VIB_DRV_REG], &val);
   216		if (error < 0)
   217			return error;
   218	
   219		/* operate in manual mode */
   220		if (vib->hw_type == SSBI_VIB) {
   221			val &= SSBI_VIB_DRV_EN_MANUAL_MASK;
   222			error = regmap_field_write(vib->r_fields[VIB_DRV_REG], val);
   223			if (error < 0)
   224				return error;
   225		}
   226	
   227		vib->reg_vib_drv = val;
   228	
   229		input_dev->name = "pm8xxx_vib_ffmemless";
   230		input_dev->id.version = 1;
   231		input_dev->close = pm8xxx_vib_close;
   232		input_set_drvdata(input_dev, vib);
   233		input_set_capability(vib->vib_input_dev, EV_FF, FF_RUMBLE);
   234	
   235		error = input_ff_create_memless(input_dev, NULL,
   236						pm8xxx_vib_play_effect);
   237		if (error) {
   238			dev_err(dev, "couldn't register vibrator as FF device\n");
   239			return error;
   240		}
   241	
   242		error = input_register_device(input_dev);
   243		if (error) {
   244			dev_err(dev, "couldn't register input device\n");
   245			return error;
   246		}
   247	
   248		platform_set_drvdata(pdev, vib);
   249		return 0;
   250	}
   251	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
