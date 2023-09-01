Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07C078F76D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 05:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345048AbjIADT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 23:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjIADT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 23:19:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCBAE7C;
        Thu, 31 Aug 2023 20:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693538366; x=1725074366;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=45Ga15B/3bjXqa8OloILxWs7X2USBAT3xYhk+ZH+m1A=;
  b=Rg5DGiJ4F+DAVAsp7Chzeg2hD5hOQrUdrYhWVppChqPVpYnX3IjcWPwX
   RXYHw+/cnK5Is9RFLN4FeV+95vnIVg8l7NklWH3cEBuDsxuZpa+w3Hnbs
   4qA2MwZszW2y6eWNkkBUDE5blID6Q645oPJnr3Pef8Uz32aJ999SuvmHm
   QH9X4nBSEFyds8/lvwBCSikVWBVW6qshi0PZwzJJvBPSR553y0dNAL6ww
   MoTexteP/68TX/l/9TdHBk6zf4SmouuBSv74E7E5aS1FdR1ZUVG88jX0K
   y/r+HIAuJxMTFBGrgeiaXfyRRpAJNeuVVLg9QDkFx6HT8uSHahrGyoy3t
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="366353813"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="366353813"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 20:19:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="854534351"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="854534351"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 31 Aug 2023 20:19:20 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbugo-0000ow-0Q;
        Fri, 01 Sep 2023 03:19:18 +0000
Date:   Fri, 1 Sep 2023 11:18:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukasz Majewski <lukma@denx.de>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, Tristram.Ha@microchip.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        George McCollister <george.mccollister@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v2 2/4] net: dsa: Extend ksz9477 TAG setup to support HSR
 frames duplication
Message-ID: <202309011105.2lJFeNbJ-lkp@intel.com>
References: <20230831111827.548118-3-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831111827.548118-3-lukma@denx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.5]
[also build test ERROR on next-20230831]
[cannot apply to net-next/main net/main linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lukasz-Majewski/net-dsa-Extend-the-ksz_device-structure-to-hold-info-about-HSR-ports/20230831-192012
base:   v6.5
patch link:    https://lore.kernel.org/r/20230831111827.548118-3-lukma%40denx.de
patch subject: [PATCH v2 2/4] net: dsa: Extend ksz9477 TAG setup to support HSR frames duplication
config: csky-randconfig-r011-20230901 (https://download.01.org/0day-ci/archive/20230901/202309011105.2lJFeNbJ-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230901/202309011105.2lJFeNbJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309011105.2lJFeNbJ-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/charlcd.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/hd44780_common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/line-display.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/phy/phy-am335x-control.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/phy/phy-am335x.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/host/ohci-exynos.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/host/xhci-pci-renesas.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/class/usbtmc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/storage/uas.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/misc/ezusb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/misc/isight_firmware.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/mon/usbmon.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/ch341.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb-serial-simple.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/symbolserial.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/i2c/busses/i2c-qup.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/tuners/tda9887.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/common/uvc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/usb/dvb-usb/dvb-usb-dibusb-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/usb/dvb-usb/dvb-usb-dibusb-mc-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/dvb-frontends/au8522_decoder.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/dvb-frontends/mb86a16.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/v4l2-core/v4l2-async.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/v4l2-core/v4l2-fwnode.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/corsair-cpro.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/watchdog/omap_wdt.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/watchdog/ts4800_wdt.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/leds/flash/leds-rt4505.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-a4tech.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-cherry.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-evision.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-kensington.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-lcpower.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-lenovo.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-maltron.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-mf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-microsoft.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-ortek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-pl.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-petalynx.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-primax.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-speedlink.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-steam.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-sunplus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-gaff.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-tivo.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-twinhan.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-xinmo.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-zpff.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-zydacron.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-viewsonic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-waltop.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vhost/vringh.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/adc/xilinx-ams.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm-ccn.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem-apple-efuses.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem_brcm_nvram.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-ast-cf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-scom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mq-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mn-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/parport/parport.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/ata/sata_gemini.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spmi/hisi-spmi-controller.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/atm/atmtcp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/pcmcia_rsrc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/rpmsg/rpmsg_char.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/core/dev_addr_lists_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/netlink/netlink_diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/esp4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/xfrm/xfrm_user.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/tunnel6.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_ar9331.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_brcm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_dsa.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_gswip.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_hellcreek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_ksz.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_lan9303.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_mtk.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_none.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_ocelot.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_ocelot_8021q.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_qca.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_rtl4_a.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_rtl8_4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_rzn1_a5psw.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_trailer.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_xrs700x.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/packet/af_packet.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/packet/af_packet_diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/key/af_key.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/atm/atm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/caif/caif.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/caif/chnl_net.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/caif/caif_socket.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/caif/caif_usb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ieee802154/ieee802154_socket.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/hsr/hsr.o
>> ERROR: modpost: "ksz_hsr_get_ports" [net/dsa/tag_ksz.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
