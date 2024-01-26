Return-Path: <linux-kernel+bounces-39470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D626483D1A9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076681C22B81
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2443EC3;
	Fri, 26 Jan 2024 00:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJFBbkpO"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78254385
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706230170; cv=none; b=UaBXpHWjstkhBEKn7d+5Abc4DEZOHQpdHMdtuKBCXLoTy1YkGbhdDIGEIna0d/R1uYDXYXUUWa/b66Ah88KWhg2LpP+0PaeZDo9M72hIX7EiUoXLVTWDbXAsZiG2W+a4Q/fawfRpVu2SN4N0dm1z/qbUF2JpDCxBJ11lDkspdLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706230170; c=relaxed/simple;
	bh=U68y3oeJZukE5W8FOxln4yLjZ0wYPo+XGdxFJlzYL2I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WpLU/6o5sIpzVQJg7/Y0gyceTvzkCpY5WE74JP4y3jF9ONv1Tac+TR0Y3qwx8bxO6MxTPhTDejgswYJ2IJLp1TZymOYR8uPQoEMajjf5anKBOslTA0kaWMaj4HQPZmma35mCq1V0SuYrgiOs7HDHuQEd9HMmMTOaqrvP2Zhg7ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJFBbkpO; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706230168; x=1737766168;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=U68y3oeJZukE5W8FOxln4yLjZ0wYPo+XGdxFJlzYL2I=;
  b=MJFBbkpODCqrM80Nn99yJSq38fE2q3/rUaRM67/jb5iStMbzCq2a54Ba
   MqEzXJ1N3RbZbXvldlhGrYn10VRnwF3Hh3VBjIik4ivqXMmIDobd7KwWp
   wd5ss6ie916gVuIv6MIL7+0Tld2nCl9EeDUZebOn0PWHtSBf5XA2XK8QP
   y7RzJ0DpF29JAQ3cYt1xJeG3mzlriaq0KHftUaM/kaDRzMFLXmM7s3wPU
   mJnj/+e3ym1UvLdgc8OhrbNR6p2qqXiVXazX4CNqgO4GRNLSJLwuZx9EK
   Y5GkEsCTfa4HguThudRUktibX6PoOwYrOP6bD8MU9ybpwm3HRwiDyLWF8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="433503440"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="433503440"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 16:49:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2523690"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 25 Jan 2024 16:49:26 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTAPL-0000X8-36;
	Fri, 26 Jan 2024 00:49:23 +0000
Date: Fri, 26 Jan 2024 08:48:42 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: drivers/video/fbdev/sis/init301.c:239:28: warning: 'SiS_Part2CLVX_6'
 defined but not used
Message-ID: <202401260803.Vrb32JZu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
commit: 5908986ef3481b7ac783642733a4ab91c15c7550 video: fbdev: sis: avoid mismatched prototypes
date:   6 years ago
config: i386-randconfig-012-20240107 (https://download.01.org/0day-ci/archive/20240126/202401260803.Vrb32JZu-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240126/202401260803.Vrb32JZu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401260803.Vrb32JZu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/video/fbdev/sis/init301.c: In function 'SiS_SetCRT2ModeRegs':
   drivers/video/fbdev/sis/init301.c:2690:24: warning: variable 'modeflag' set but not used [-Wunused-but-set-variable]
    2690 |   unsigned short i, j, modeflag, tempah=0;
         |                        ^~~~~~~~
   drivers/video/fbdev/sis/init301.c: In function 'SiS_SetGroup1':
   drivers/video/fbdev/sis/init301.c:6236:52: warning: variable 'resinfo' set but not used [-Wunused-but-set-variable]
    6236 |   unsigned short  pushbx=0, CRT1Index=0, modeflag, resinfo=0;
         |                                                    ^~~~~~~
   drivers/video/fbdev/sis/init301.c: At top level:
>> drivers/video/fbdev/sis/init301.c:239:28: warning: 'SiS_Part2CLVX_6' defined but not used [-Wunused-const-variable=]
     239 | static const unsigned char SiS_Part2CLVX_6[] = {   /* 1080i */
         |                            ^~~~~~~~~~~~~~~
>> drivers/video/fbdev/sis/init301.c:230:28: warning: 'SiS_Part2CLVX_5' defined but not used [-Wunused-const-variable=]
     230 | static const unsigned char SiS_Part2CLVX_5[] = {   /* 750p */
         |                            ^~~~~~~~~~~~~~~
>> drivers/video/fbdev/sis/init301.c:211:28: warning: 'SiS_Part2CLVX_4' defined but not used [-Wunused-const-variable=]
     211 | static const unsigned char SiS_Part2CLVX_4[] = {   /* PAL */
         |                            ^~~~~~~~~~~~~~~
>> drivers/video/fbdev/sis/init301.c:192:28: warning: 'SiS_Part2CLVX_3' defined but not used [-Wunused-const-variable=]
     192 | static const unsigned char SiS_Part2CLVX_3[] = {  /* NTSC, 525i, 525p */
         |                            ^~~~~~~~~~~~~~~
>> drivers/video/fbdev/sis/init301.c:184:28: warning: 'SiS_Part2CLVX_2' defined but not used [-Wunused-const-variable=]
     184 | static const unsigned char SiS_Part2CLVX_2[] = {
         |                            ^~~~~~~~~~~~~~~
>> drivers/video/fbdev/sis/init301.c:176:28: warning: 'SiS_Part2CLVX_1' defined but not used [-Wunused-const-variable=]
     176 | static const unsigned char SiS_Part2CLVX_1[] = {
         |                            ^~~~~~~~~~~~~~~
   In file included from drivers/video/fbdev/sis/sis.h:31,
                    from drivers/video/fbdev/sis/init301.h:66,
                    from drivers/video/fbdev/sis/init301.c:72:
   drivers/video/fbdev/sis/init.h:1445:38: warning: 'SiS_LVDSCRT1640x480_1_H' defined but not used [-Wunused-const-variable=]
    1445 | static const struct SiS_LVDSCRT1Data SiS_LVDSCRT1640x480_1_H[] =
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1423:38: warning: 'SiS_LVDSCRT1640x480_1' defined but not used [-Wunused-const-variable=]
    1423 | static const struct SiS_LVDSCRT1Data SiS_LVDSCRT1640x480_1[] =
         |                                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1398:38: warning: 'SiS_LVDSCRT1320x240_3_H' defined but not used [-Wunused-const-variable=]
    1398 | static const struct SiS_LVDSCRT1Data SiS_LVDSCRT1320x240_3_H[] =
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1373:38: warning: 'SiS_LVDSCRT1320x240_3' defined but not used [-Wunused-const-variable=]
    1373 | static const struct SiS_LVDSCRT1Data SiS_LVDSCRT1320x240_3[] =
         |                                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1348:38: warning: 'SiS_LVDSCRT1320x240_2_H' defined but not used [-Wunused-const-variable=]
    1348 | static const struct SiS_LVDSCRT1Data SiS_LVDSCRT1320x240_2_H[] =
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1318:38: warning: 'SiS_LVDSCRT1320x240_2' defined but not used [-Wunused-const-variable=]
    1318 | static const struct SiS_LVDSCRT1Data SiS_LVDSCRT1320x240_2[] =
         |                                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1293:38: warning: 'SiS_LVDSCRT1320x240_1' defined but not used [-Wunused-const-variable=]
    1293 | static const struct SiS_LVDSCRT1Data SiS_LVDSCRT1320x240_1[] =
         |                                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1280:34: warning: 'SiS_CHTVONTSCData' defined but not used [-Wunused-const-variable=]
    1280 | static const struct SiS_LVDSData SiS_CHTVONTSCData[]=
         |                                  ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1269:34: warning: 'SiS_CHTVUNTSCData' defined but not used [-Wunused-const-variable=]
    1269 | static const struct SiS_LVDSData SiS_CHTVUNTSCData[]=
         |                                  ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1258:34: warning: 'SiS_LVDS1024x768Data_1' defined but not used [-Wunused-const-variable=]
    1258 | static const struct SiS_LVDSData SiS_LVDS1024x768Data_1[]=
         |                                  ^~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1247:34: warning: 'SiS_LVDS1024x600Data_1' defined but not used [-Wunused-const-variable=]
    1247 | static const struct SiS_LVDSData SiS_LVDS1024x600Data_1[] =
         |                                  ^~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1237:34: warning: 'SiS_LVDS800x600Data_1' defined but not used [-Wunused-const-variable=]
    1237 | static const struct SiS_LVDSData SiS_LVDS800x600Data_1[]=
         |                                  ^~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1228:34: warning: 'SiS_LVDS640x480Data_1' defined but not used [-Wunused-const-variable=]
    1228 | static const struct SiS_LVDSData SiS_LVDS640x480Data_1[]=
         |                                  ^~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1217:34: warning: 'SiS_LVDS320x240Data_2' defined but not used [-Wunused-const-variable=]
    1217 | static const struct SiS_LVDSData SiS_LVDS320x240Data_2[]=
         |                                  ^~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1206:34: warning: 'SiS_LVDS320x240Data_1' defined but not used [-Wunused-const-variable=]
    1206 | static const struct SiS_LVDSData SiS_LVDS320x240Data_1[]=
         |                                  ^~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1163:33: warning: 'SiS_NoScaleData' defined but not used [-Wunused-const-variable=]
    1163 | static const struct SiS_LCDData SiS_NoScaleData[] =
         |                                 ^~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1143:33: warning: 'SiS_ExtLCD1600x1200Data' defined but not used [-Wunused-const-variable=]
    1143 | static const struct SiS_LCDData SiS_ExtLCD1600x1200Data[] =
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1125:33: warning: 'SiS_StLCD1600x1200Data' defined but not used [-Wunused-const-variable=]
    1125 | static const struct SiS_LCDData SiS_StLCD1600x1200Data[] =
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1107:33: warning: 'SiS_LCD1680x1050Data' defined but not used [-Wunused-const-variable=]
    1107 | static const struct SiS_LCDData SiS_LCD1680x1050Data[] =
         |                                 ^~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1086:33: warning: 'SiS_ExtLCD1400x1050Data' defined but not used [-Wunused-const-variable=]
    1086 | static const struct SiS_LCDData SiS_ExtLCD1400x1050Data[] =
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1068:33: warning: 'SiS_StLCD1400x1050Data' defined but not used [-Wunused-const-variable=]
    1068 | static const struct SiS_LCDData SiS_StLCD1400x1050Data[] =
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1050:33: warning: 'SiS_LCD1280x960Data' defined but not used [-Wunused-const-variable=]
    1050 | static const struct SiS_LCDData SiS_LCD1280x960Data[] =
         |                                 ^~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1032:33: warning: 'SiS_LCD1280x854Data' defined but not used [-Wunused-const-variable=]
    1032 | static const struct SiS_LCDData SiS_LCD1280x854Data[] = /* 2.21.00CS (LVDS) */
         |                                 ^~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1000:33: warning: 'SiS_LCD1280x800_2Data' defined but not used [-Wunused-const-variable=]
    1000 | static const struct SiS_LCDData SiS_LCD1280x800_2Data[] = /* 2.03.00 (LVDS) */
         |                                 ^~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:985:33: warning: 'SiS_LCD1280x800Data' defined but not used [-Wunused-const-variable=]
     985 | static const struct SiS_LCDData SiS_LCD1280x800Data[] = /* 0.93.12a (TMDS) */
         |                                 ^~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:953:33: warning: 'SiS_ExtLCD1280x768_2Data' defined but not used [-Wunused-const-variable=]
     953 | static const struct SiS_LCDData SiS_ExtLCD1280x768_2Data[] = /* 2.03.00 */
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:938:33: warning: 'SiS_StLCD1280x768_2Data' defined but not used [-Wunused-const-variable=]
     938 | static const struct SiS_LCDData SiS_StLCD1280x768_2Data[] = /* 2.03.00 */
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:916:33: warning: 'SiS_LCD1280x720Data' defined but not used [-Wunused-const-variable=]
     916 | static const struct SiS_LCDData SiS_LCD1280x720Data[] =  /* 2.03.00 */
         |                                 ^~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:902:32: warning: 'SiS_Ext750pData' defined but not used [-Wunused-const-variable=]
     902 | static const struct SiS_TVData SiS_Ext750pData[] =
         |                                ^~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:893:32: warning: 'SiS_St750pData' defined but not used [-Wunused-const-variable=]
     893 | static const struct SiS_TVData SiS_St750pData[] =
         |                                ^~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:884:32: warning: 'SiS_St525pData' defined but not used [-Wunused-const-variable=]
     884 | static const struct SiS_TVData SiS_St525pData[] =
         |                                ^~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:868:32: warning: 'SiS_ExtHiTVData' defined but not used [-Wunused-const-variable=]
     868 | static const struct SiS_TVData SiS_ExtHiTVData[] =


vim +/SiS_Part2CLVX_6 +239 drivers/video/fbdev/sis/init301.c

   175	
 > 176	static const unsigned char SiS_Part2CLVX_1[] = {
   177	    0x00,0x00,
   178	    0x00,0x20,0x00,0x00,0x7F,0x20,0x02,0x7F,0x7D,0x20,0x04,0x7F,0x7D,0x1F,0x06,0x7E,
   179	    0x7C,0x1D,0x09,0x7E,0x7C,0x1B,0x0B,0x7E,0x7C,0x19,0x0E,0x7D,0x7C,0x17,0x11,0x7C,
   180	    0x7C,0x14,0x14,0x7C,0x7C,0x11,0x17,0x7C,0x7D,0x0E,0x19,0x7C,0x7E,0x0B,0x1B,0x7C,
   181	    0x7E,0x09,0x1D,0x7C,0x7F,0x06,0x1F,0x7C,0x7F,0x04,0x20,0x7D,0x00,0x02,0x20,0x7E
   182	};
   183	
 > 184	static const unsigned char SiS_Part2CLVX_2[] = {
   185	    0x00,0x00,
   186	    0x00,0x20,0x00,0x00,0x7F,0x20,0x02,0x7F,0x7D,0x20,0x04,0x7F,0x7D,0x1F,0x06,0x7E,
   187	    0x7C,0x1D,0x09,0x7E,0x7C,0x1B,0x0B,0x7E,0x7C,0x19,0x0E,0x7D,0x7C,0x17,0x11,0x7C,
   188	    0x7C,0x14,0x14,0x7C,0x7C,0x11,0x17,0x7C,0x7D,0x0E,0x19,0x7C,0x7E,0x0B,0x1B,0x7C,
   189	    0x7E,0x09,0x1D,0x7C,0x7F,0x06,0x1F,0x7C,0x7F,0x04,0x20,0x7D,0x00,0x02,0x20,0x7E
   190	};
   191	
 > 192	static const unsigned char SiS_Part2CLVX_3[] = {  /* NTSC, 525i, 525p */
   193	    0xE0,0x01,
   194	    0x04,0x1A,0x04,0x7E,0x03,0x1A,0x06,0x7D,0x01,0x1A,0x08,0x7D,0x00,0x19,0x0A,0x7D,
   195	    0x7F,0x19,0x0C,0x7C,0x7E,0x18,0x0E,0x7C,0x7E,0x17,0x10,0x7B,0x7D,0x15,0x12,0x7C,
   196	    0x7D,0x13,0x13,0x7D,0x7C,0x12,0x15,0x7D,0x7C,0x10,0x17,0x7D,0x7C,0x0E,0x18,0x7E,
   197	    0x7D,0x0C,0x19,0x7E,0x7D,0x0A,0x19,0x00,0x7D,0x08,0x1A,0x01,0x7E,0x06,0x1A,0x02,
   198	    0x58,0x02,
   199	    0x07,0x14,0x07,0x7E,0x06,0x14,0x09,0x7D,0x05,0x14,0x0A,0x7D,0x04,0x13,0x0B,0x7E,
   200	    0x03,0x13,0x0C,0x7E,0x02,0x12,0x0D,0x7F,0x01,0x12,0x0E,0x7F,0x01,0x11,0x0F,0x7F,
   201	    0x00,0x10,0x10,0x00,0x7F,0x0F,0x11,0x01,0x7F,0x0E,0x12,0x01,0x7E,0x0D,0x12,0x03,
   202	    0x7E,0x0C,0x13,0x03,0x7E,0x0B,0x13,0x04,0x7E,0x0A,0x14,0x04,0x7D,0x09,0x14,0x06,
   203	    0x00,0x03,
   204	    0x09,0x0F,0x09,0x7F,0x08,0x0F,0x09,0x00,0x07,0x0F,0x0A,0x00,0x06,0x0F,0x0A,0x01,
   205	    0x06,0x0E,0x0B,0x01,0x05,0x0E,0x0B,0x02,0x04,0x0E,0x0C,0x02,0x04,0x0D,0x0C,0x03,
   206	    0x03,0x0D,0x0D,0x03,0x02,0x0C,0x0D,0x05,0x02,0x0C,0x0E,0x04,0x01,0x0B,0x0E,0x06,
   207	    0x01,0x0B,0x0E,0x06,0x00,0x0A,0x0F,0x07,0x00,0x0A,0x0F,0x07,0x00,0x09,0x0F,0x08,
   208	    0xFF,0xFF
   209	};
   210	
 > 211	static const unsigned char SiS_Part2CLVX_4[] = {   /* PAL */
   212	    0x58,0x02,
   213	    0x05,0x19,0x05,0x7D,0x03,0x19,0x06,0x7E,0x02,0x19,0x08,0x7D,0x01,0x18,0x0A,0x7D,
   214	    0x00,0x18,0x0C,0x7C,0x7F,0x17,0x0E,0x7C,0x7E,0x16,0x0F,0x7D,0x7E,0x14,0x11,0x7D,
   215	    0x7D,0x13,0x13,0x7D,0x7D,0x11,0x14,0x7E,0x7D,0x0F,0x16,0x7E,0x7D,0x0E,0x17,0x7E,
   216	    0x7D,0x0C,0x18,0x7F,0x7D,0x0A,0x18,0x01,0x7D,0x08,0x19,0x02,0x7D,0x06,0x19,0x04,
   217	    0x00,0x03,
   218	    0x08,0x12,0x08,0x7E,0x07,0x12,0x09,0x7E,0x06,0x12,0x0A,0x7E,0x05,0x11,0x0B,0x7F,
   219	    0x04,0x11,0x0C,0x7F,0x03,0x11,0x0C,0x00,0x03,0x10,0x0D,0x00,0x02,0x0F,0x0E,0x01,
   220	    0x01,0x0F,0x0F,0x01,0x01,0x0E,0x0F,0x02,0x00,0x0D,0x10,0x03,0x7F,0x0C,0x11,0x04,
   221	    0x7F,0x0C,0x11,0x04,0x7F,0x0B,0x11,0x05,0x7E,0x0A,0x12,0x06,0x7E,0x09,0x12,0x07,
   222	    0x40,0x02,
   223	    0x04,0x1A,0x04,0x7E,0x02,0x1B,0x05,0x7E,0x01,0x1A,0x07,0x7E,0x00,0x1A,0x09,0x7D,
   224	    0x7F,0x19,0x0B,0x7D,0x7E,0x18,0x0D,0x7D,0x7D,0x17,0x10,0x7C,0x7D,0x15,0x12,0x7C,
   225	    0x7C,0x14,0x14,0x7C,0x7C,0x12,0x15,0x7D,0x7C,0x10,0x17,0x7D,0x7C,0x0D,0x18,0x7F,
   226	    0x7D,0x0B,0x19,0x7F,0x7D,0x09,0x1A,0x00,0x7D,0x07,0x1A,0x02,0x7E,0x05,0x1B,0x02,
   227	    0xFF,0xFF
   228	};
   229	
 > 230	static const unsigned char SiS_Part2CLVX_5[] = {   /* 750p */
   231	    0x00,0x03,
   232	    0x05,0x19,0x05,0x7D,0x03,0x19,0x06,0x7E,0x02,0x19,0x08,0x7D,0x01,0x18,0x0A,0x7D,
   233	    0x00,0x18,0x0C,0x7C,0x7F,0x17,0x0E,0x7C,0x7E,0x16,0x0F,0x7D,0x7E,0x14,0x11,0x7D,
   234	    0x7D,0x13,0x13,0x7D,0x7D,0x11,0x14,0x7E,0x7D,0x0F,0x16,0x7E,0x7D,0x0E,0x17,0x7E,
   235	    0x7D,0x0C,0x18,0x7F,0x7D,0x0A,0x18,0x01,0x7D,0x08,0x19,0x02,0x7D,0x06,0x19,0x04,
   236	    0xFF,0xFF
   237	};
   238	
 > 239	static const unsigned char SiS_Part2CLVX_6[] = {   /* 1080i */
   240	    0x00,0x04,
   241	    0x04,0x1A,0x04,0x7E,0x02,0x1B,0x05,0x7E,0x01,0x1A,0x07,0x7E,0x00,0x1A,0x09,0x7D,
   242	    0x7F,0x19,0x0B,0x7D,0x7E,0x18,0x0D,0x7D,0x7D,0x17,0x10,0x7C,0x7D,0x15,0x12,0x7C,
   243	    0x7C,0x14,0x14,0x7C,0x7C,0x12,0x15,0x7D,0x7C,0x10,0x17,0x7D,0x7C,0x0D,0x18,0x7F,
   244	    0x7D,0x0B,0x19,0x7F,0x7D,0x09,0x1A,0x00,0x7D,0x07,0x1A,0x02,0x7E,0x05,0x1B,0x02,
   245	    0xFF,0xFF,
   246	};
   247	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

