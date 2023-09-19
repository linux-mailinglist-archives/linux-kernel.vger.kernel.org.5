Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169867A699A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjISR1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjISR1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:27:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682EE9F;
        Tue, 19 Sep 2023 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695144426; x=1726680426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/GfKecIDbouGTE7n4315amFnYOI3c0tRqeNu43t9cFw=;
  b=Cm9dyKwXGdwFPawE+t8KoqNWXi4KrTIsqC8eGmVjqET3QPgOPTHlRJ6B
   8bfMK1Wzkq+kXKBT8kH+7Wu/JaKH1JrsJvBlUsWqOnI+Nza/dUMrOw0qH
   70k4m0cgeu3+GNJ/AEeZwDIZFtSClHYsuUfqlyfn/0psoS2KnZTYddQk/
   KwEi+omLlWFLyNVLu4wx2Xjvt3EjEVtihylxD7Uv/pz0S5LfN1SO2jtc8
   XEkRvDdZvj1ZWT6mgGUphr450FEMD0WhXpjQmyP6bmvn5ZsRdJynhfPkM
   +rHCa6i+8RcWxNN+1ZAyDfT3qoONsB3z5/s4lS1POAlsGrrSJCrtGpgwC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="410936065"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="410936065"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 10:27:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="746316089"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="746316089"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 19 Sep 2023 10:27:00 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qieV0-0007jz-15;
        Tue, 19 Sep 2023 17:26:58 +0000
Date:   Wed, 20 Sep 2023 01:26:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_jackp@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com,
        Harsh Agarwal <quic_harshq@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: Re: [PATCH v11 06/13] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Message-ID: <202309200156.CxQ3yaLY-lkp@intel.com>
References: <20230828133033.11988-7-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828133033.11988-7-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus robh/for-next pza/reset/next linus/master v6.6-rc2 next-20230919]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-Kurapati/dt-bindings-usb-qcom-dwc3-Add-bindings-for-SC8280-Multiport/20230828-214326
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230828133033.11988-7-quic_kriskura%40quicinc.com
patch subject: [PATCH v11 06/13] usb: dwc3: core: Refactor PHY logic to support Multiport Controller
config: x86_64-randconfig-011-20230902 (https://download.01.org/0day-ci/archive/20230920/202309200156.CxQ3yaLY-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309200156.CxQ3yaLY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309200156.CxQ3yaLY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/usb/dwc3/core.c: In function 'dwc3_core_get_phy':
>> drivers/usb/dwc3/core.c:1375:53: warning: '%d' directive writing between 1 and 3 bytes into a region of size 2 [-Wformat-overflow=]
    1375 |                         sprintf(phy_name, "usb2-port%d", i);
         |                                                     ^~
   drivers/usb/dwc3/core.c:1375:43: note: directive argument in the range [0, 254]
    1375 |                         sprintf(phy_name, "usb2-port%d", i);
         |                                           ^~~~~~~~~~~~~
   drivers/usb/dwc3/core.c:1375:25: note: 'sprintf' output between 11 and 13 bytes into a destination of size 11
    1375 |                         sprintf(phy_name, "usb2-port%d", i);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/dwc3/core.c:1390:53: warning: '%d' directive writing between 1 and 3 bytes into a region of size 2 [-Wformat-overflow=]
    1390 |                         sprintf(phy_name, "usb3-port%d", i);
         |                                                     ^~
   drivers/usb/dwc3/core.c:1390:43: note: directive argument in the range [0, 254]
    1390 |                         sprintf(phy_name, "usb3-port%d", i);
         |                                           ^~~~~~~~~~~~~
   drivers/usb/dwc3/core.c:1390:25: note: 'sprintf' output between 11 and 13 bytes into a destination of size 11
    1390 |                         sprintf(phy_name, "usb3-port%d", i);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1375 drivers/usb/dwc3/core.c

  1338	
  1339	static int dwc3_core_get_phy(struct dwc3 *dwc)
  1340	{
  1341		struct device		*dev = dwc->dev;
  1342		struct device_node	*node = dev->of_node;
  1343		char phy_name[11];
  1344		int ret;
  1345		int i;
  1346	
  1347		if (node) {
  1348			dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
  1349			dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
  1350		} else {
  1351			dwc->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
  1352			dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
  1353		}
  1354	
  1355		if (IS_ERR(dwc->usb2_phy)) {
  1356			ret = PTR_ERR(dwc->usb2_phy);
  1357			if (ret == -ENXIO || ret == -ENODEV)
  1358				dwc->usb2_phy = NULL;
  1359			else
  1360				return dev_err_probe(dev, ret, "no usb2 phy configured\n");
  1361		}
  1362	
  1363		if (IS_ERR(dwc->usb3_phy)) {
  1364			ret = PTR_ERR(dwc->usb3_phy);
  1365			if (ret == -ENXIO || ret == -ENODEV)
  1366				dwc->usb3_phy = NULL;
  1367			else
  1368				return dev_err_probe(dev, ret, "no usb3 phy configured\n");
  1369		}
  1370	
  1371		for (i = 0; i < dwc->num_usb2_ports; i++) {
  1372			if (dwc->num_usb2_ports == 1)
  1373				sprintf(phy_name, "usb2-phy");
  1374			else
> 1375				sprintf(phy_name, "usb2-port%d", i);
  1376	
  1377			dwc->usb2_generic_phy[i] = devm_phy_get(dev, phy_name);
  1378			if (IS_ERR(dwc->usb2_generic_phy[i])) {
  1379				ret = PTR_ERR(dwc->usb2_generic_phy[i]);
  1380				if (ret == -ENOSYS || ret == -ENODEV)
  1381					dwc->usb2_generic_phy[i] = NULL;
  1382				else
  1383					return dev_err_probe(dev, ret,
  1384						"failed to lookup phy %s\n", phy_name);
  1385			}
  1386	
  1387			if (dwc->num_usb2_ports == 1)
  1388				sprintf(phy_name, "usb3-phy");
  1389			else
  1390				sprintf(phy_name, "usb3-port%d", i);
  1391	
  1392			dwc->usb3_generic_phy[i] = devm_phy_get(dev, phy_name);
  1393			if (IS_ERR(dwc->usb3_generic_phy[i])) {
  1394				ret = PTR_ERR(dwc->usb3_generic_phy[i]);
  1395				if (ret == -ENOSYS || ret == -ENODEV)
  1396					dwc->usb3_generic_phy[i] = NULL;
  1397				else
  1398					return dev_err_probe(dev, ret,
  1399						"failed to lookup phy %s\n", phy_name);
  1400			}
  1401		}
  1402	
  1403		return 0;
  1404	}
  1405	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
