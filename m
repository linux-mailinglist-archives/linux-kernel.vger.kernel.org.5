Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69AB7884F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjHYKbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240997AbjHYKbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:31:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2845A9E;
        Fri, 25 Aug 2023 03:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692959464; x=1724495464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wVJ88ABD5p0H2+9hwW3zAACiH9v23ThhILL1RUf5G20=;
  b=ON4UjiYvi6rEoGKjzkMsr/RF1ShOWhtCJnhFdtkdKCW6JsCgQzWbIURf
   rv8zT6SgEDdMXWD8xZfYUp7h1uO6bkfIrNs3OKfHE3iCDifNFzZ60Femj
   eVkSNe53eD802I/yyAeKEVGBgTKZjtCHHHiOLsIN5aJqZfsKeO/w9ziDd
   lBjzUMMjw0EludFu9z4C5APoalQXWmVKtRQhz5eunWTa9kg4Y5CEdoOj4
   f9RoJ7SSvraQJlxTOVBHpvGbLDF3y/VU5o4VG+Cfk55ySh7u2j1vMN1hX
   gcIrGUCFtTc/KNK0Tu2ric2KJ1cMMmEtEC0RRuSxlchmIOdkZMXIy5Wg2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="373554767"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="373554767"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 03:31:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="687259081"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="687259081"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 25 Aug 2023 03:30:50 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZU5Y-0003Rw-15;
        Fri, 25 Aug 2023 10:30:48 +0000
Date:   Fri, 25 Aug 2023 18:29:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v5 10/10] media: v4l2: Add mem2mem helpers for
 DELETE_BUFS ioctl
Message-ID: <202308251828.fSyIXACx-lkp@intel.com>
References: <20230824092133.39510-11-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824092133.39510-11-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20230824]
[also build test ERROR on v6.5-rc7]
[cannot apply to linus/master v6.5-rc7 v6.5-rc6 v6.5-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/media-videobuf2-Rework-offset-cookie-encoding-pattern/20230824-172416
base:   next-20230824
patch link:    https://lore.kernel.org/r/20230824092133.39510-11-benjamin.gaignard%40collabora.com
patch subject: [PATCH v5 10/10] media: v4l2: Add mem2mem helpers for DELETE_BUFS ioctl
config: alpha-randconfig-r005-20230825 (https://download.01.org/0day-ci/archive/20230825/202308251828.fSyIXACx-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230825/202308251828.fSyIXACx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308251828.fSyIXACx-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/media/test-drivers/vim2m.c:963:10: error: 'const struct v4l2_ioctl_ops' has no member named 'vidioc_delete_buf'; did you mean 'vidioc_delete_bufs'?
     963 |         .vidioc_delete_buf      = v4l2_m2m_ioctl_delete_buf,
         |          ^~~~~~~~~~~~~~~~~
         |          vidioc_delete_bufs
>> drivers/media/test-drivers/vim2m.c:963:35: error: 'v4l2_m2m_ioctl_delete_buf' undeclared here (not in a function); did you mean 'v4l2_m2m_ioctl_delete_bufs'?
     963 |         .vidioc_delete_buf      = v4l2_m2m_ioctl_delete_buf,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                   v4l2_m2m_ioctl_delete_bufs


vim +963 drivers/media/test-drivers/vim2m.c

   942	
   943	static const struct v4l2_ioctl_ops vim2m_ioctl_ops = {
   944		.vidioc_querycap	= vidioc_querycap,
   945	
   946		.vidioc_enum_fmt_vid_cap = vidioc_enum_fmt_vid_cap,
   947		.vidioc_enum_framesizes = vidioc_enum_framesizes,
   948		.vidioc_g_fmt_vid_cap	= vidioc_g_fmt_vid_cap,
   949		.vidioc_try_fmt_vid_cap	= vidioc_try_fmt_vid_cap,
   950		.vidioc_s_fmt_vid_cap	= vidioc_s_fmt_vid_cap,
   951	
   952		.vidioc_enum_fmt_vid_out = vidioc_enum_fmt_vid_out,
   953		.vidioc_g_fmt_vid_out	= vidioc_g_fmt_vid_out,
   954		.vidioc_try_fmt_vid_out	= vidioc_try_fmt_vid_out,
   955		.vidioc_s_fmt_vid_out	= vidioc_s_fmt_vid_out,
   956	
   957		.vidioc_reqbufs		= v4l2_m2m_ioctl_reqbufs,
   958		.vidioc_querybuf	= v4l2_m2m_ioctl_querybuf,
   959		.vidioc_qbuf		= v4l2_m2m_ioctl_qbuf,
   960		.vidioc_dqbuf		= v4l2_m2m_ioctl_dqbuf,
   961		.vidioc_prepare_buf	= v4l2_m2m_ioctl_prepare_buf,
   962		.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
 > 963		.vidioc_delete_buf	= v4l2_m2m_ioctl_delete_buf,
   964		.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
   965	
   966		.vidioc_streamon	= v4l2_m2m_ioctl_streamon,
   967		.vidioc_streamoff	= v4l2_m2m_ioctl_streamoff,
   968	
   969		.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
   970		.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
   971	};
   972	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
