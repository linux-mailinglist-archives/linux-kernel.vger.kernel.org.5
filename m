Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FBB7ACE13
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjIYC0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIYC0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:26:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A92ED3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695608786; x=1727144786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IQrxVgl8y8yaPgVD3QfYOV/eCDXVY3Nhh6n5sv8QaGQ=;
  b=dbgm7cwYxaJI/nvez/upTeTh/cm9/daIKUW0XK9YWaKFW6M4RMuGqOAJ
   27EC0CvdoBfRkpzooPJbDleieBo06+CdIvi7t20LvhqECYBGWV5v477p1
   oQxbwmWv8cXcDVhGGtE8T8kgv9Y2KPUh1P3d0CqFH/hU7V941SMlYRQAk
   36dWIaDSuAixAGGYJH+CWUZdRkehvI662gGImEmFMB03fBUJNHCr3XoTg
   DafDV/EXbewdhgP85xoq6Nv8vg4EdDdOtpOwzEMc7Zh5/bfBMYuin7pA1
   +yFc1WYoJeg2z6sjhWGfiGDEUQ6VEp4zR0yFAgNjGtN6juAwkH+V4pBBE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="384980186"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="384980186"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 19:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="891494260"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="891494260"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 24 Sep 2023 19:25:15 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qkbIc-0000nF-26;
        Mon, 25 Sep 2023 02:26:14 +0000
Date:   Mon, 25 Sep 2023 10:25:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ma Ke <make_ruc2021@163.com>, perex@perex.cz, tiwai@suse.com,
        cujomalainey@chromium.org, maciej.szmigiero@oracle.com,
        clecigne@google.com
Cc:     oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: control: do not access controls without possession
 of r_w lock
Message-ID: <202309251036.Yjiuc0Lq-lkp@intel.com>
References: <20230912084530.3307329-1-make_ruc2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912084530.3307329-1-make_ruc2021@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ma,

kernel test robot noticed the following build errors:

[auto build test ERROR on tiwai-sound/for-next]
[also build test ERROR on tiwai-sound/for-linus linus/master v6.6-rc3 next-20230921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-Ke/ALSA-control-do-not-access-controls-without-possession-of-r_w-lock/20230912-164832
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20230912084530.3307329-1-make_ruc2021%40163.com
patch subject: [PATCH] ALSA: control: do not access controls without possession of r_w lock
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20230925/202309251036.Yjiuc0Lq-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230925/202309251036.Yjiuc0Lq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309251036.Yjiuc0Lq-lkp@intel.com/

All errors (new ones prefixed by >>):

   sound/core/control.c: In function '__snd_ctl_remove':
>> sound/core/control.c:593:9: error: 'count' undeclared (first use in this function); did you mean 'd_count'?
     593 |         count = kcontrol->count;
         |         ^~~~~
         |         d_count
   sound/core/control.c:593:9: note: each undeclared identifier is reported only once for each function it appears in


vim +593 sound/core/control.c

   576	
   577	static int __snd_ctl_remove(struct snd_card *card,
   578				    struct snd_kcontrol *kcontrol,
   579				    bool remove_hash)
   580	{
   581		unsigned int idx;
   582	
   583		lockdep_assert_held_write(&card->controls_rwsem);
   584	
   585		if (snd_BUG_ON(!card || !kcontrol))
   586			return -EINVAL;
   587		list_del(&kcontrol->list);
   588	
   589		if (remove_hash)
   590			remove_hash_entries(card, kcontrol);
   591	
   592		card->controls_count -= kcontrol->count;
 > 593		count = kcontrol->count;
   594		for (idx = 0; idx < count; idx++)
   595			snd_ctl_notify_one(card, SNDRV_CTL_EVENT_MASK_REMOVE, kcontrol, idx);
   596		snd_ctl_free_one(kcontrol);
   597		return 0;
   598	}
   599	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
