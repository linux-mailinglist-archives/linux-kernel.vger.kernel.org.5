Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B47478C8F3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbjH2P4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237326AbjH2P40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:56:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6512412F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693324583; x=1724860583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/FxdMVHaC4P+Iomi2vc/Vmvj9NYMSRb9IOpwkfjphqQ=;
  b=QXJ5P3J5N0bWoQg4krSVa6uRf5bRpeo/dC/kiI69BNZj2OjJ+hN5ZIps
   R0Ok9nuuNA0tdqMi3EvQ3nSmdeEpB9C1Oj94+8C50KlTXxZIY/BxmebNx
   cRVnjIt2p1+br7tfHkenY7z7AfUegw3SnWqXwQuCkXcVNtJpkY6ChgMhK
   NbDB4nkfVkOBPQ8erkmK4k+i4o/Z4dZW8PUG18UvNI2QMsXV/rG4Bv1HC
   fUiHVZUoBr6kRjO4UL0/nXZqIjM7Vz8lf5M4pu0i4KH9OhlBSRsZsQkQk
   f6ViQ6Z4n7uo7CuiXUAUvJmVfjIRWtrAQYwCqtTPVLK7n3Gpj4JWjXBYi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="439359346"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="439359346"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 08:56:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="732258607"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="732258607"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2023 08:56:19 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qb14k-0008sQ-3C;
        Tue, 29 Aug 2023 15:56:18 +0000
Date:   Tue, 29 Aug 2023 23:55:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ALSA: control: Use list_for_each_entry_safe()
Message-ID: <202308292313.7rKiGzpa-lkp@intel.com>
References: <20230829135252.3915124-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829135252.3915124-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on tiwai-sound/for-linus linus/master v6.5 next-20230829]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/ALSA-control-Use-list_for_each_entry_safe/20230829-215501
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20230829135252.3915124-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] ALSA: control: Use list_for_each_entry_safe()
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230829/202308292313.7rKiGzpa-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230829/202308292313.7rKiGzpa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308292313.7rKiGzpa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:779:27: note: in expansion of macro 'list_next_entry'
     779 |              pos = n, n = list_next_entry(n, member))
         |                           ^~~~~~~~~~~~~~~
   sound/core/control_led.c:304:17: note: in expansion of macro 'list_for_each_entry_safe'
     304 |                 list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:564:25: error: invalid type argument of '->' (have 'struct snd_ctl_led_ctl')
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |                         ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:779:27: note: in expansion of macro 'list_next_entry'
     779 |              pos = n, n = list_next_entry(n, member))
         |                           ^~~~~~~~~~~~~~~
   sound/core/control_led.c:304:17: note: in expansion of macro 'list_for_each_entry_safe'
     304 |                 list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:338:27: error: expression in static assertion is not an integer
     338 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:779:27: note: in expansion of macro 'list_next_entry'
     779 |              pos = n, n = list_next_entry(n, member))
         |                           ^~~~~~~~~~~~~~~
   sound/core/control_led.c:304:17: note: in expansion of macro 'list_for_each_entry_safe'
     304 |                 list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:564:47: error: invalid type argument of unary '*' (have 'struct snd_ctl_led_ctl')
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |                                               ^~~~~~
   include/linux/container_of.h:23:11: note: in definition of macro 'container_of'
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |           ^~~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:779:27: note: in expansion of macro 'list_next_entry'
     779 |              pos = n, n = list_next_entry(n, member))
         |                           ^~~~~~~~~~~~~~~
   sound/core/control_led.c:304:17: note: in expansion of macro 'list_for_each_entry_safe'
     304 |                 list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/uapi/linux/sysinfo.h:5,
                    from include/uapi/linux/kernel.h:5,
                    from include/linux/cache.h:5,
                    from include/linux/slab.h:15:
   include/linux/list.h:564:47: error: invalid type argument of unary '*' (have 'struct snd_ctl_led_ctl')
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |                                               ^~~~~~
   include/linux/stddef.h:16:52: note: in definition of macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                                    ^~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:779:27: note: in expansion of macro 'list_next_entry'
     779 |              pos = n, n = list_next_entry(n, member))
         |                           ^~~~~~~~~~~~~~~
   sound/core/control_led.c:304:17: note: in expansion of macro 'list_for_each_entry_safe'
     304 |                 list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/list.h:779:21: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     779 |              pos = n, n = list_next_entry(n, member))
         |                     ^
   sound/core/control_led.c:304:17: note: in expansion of macro 'list_for_each_entry_safe'
     304 |                 list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   sound/core/control_led.c: In function 'snd_ctl_led_reset':
   sound/core/control_led.c:329:62: error: macro "list_for_each_entry" passed 4 arguments, but takes just 3
     329 |         list_for_each_entry(lctl, _lctl, &led->controls, list)
         |                                                              ^
   include/linux/list.h:688: note: macro "list_for_each_entry" defined here
     688 | #define list_for_each_entry(pos, head, member)                          \
         | 
   sound/core/control_led.c:329:9: error: 'list_for_each_entry' undeclared (first use in this function); did you mean 'bus_for_each_drv'?
     329 |         list_for_each_entry(lctl, _lctl, &led->controls, list)
         |         ^~~~~~~~~~~~~~~~~~~
         |         bus_for_each_drv
   sound/core/control_led.c:329:9: note: each undeclared identifier is reported only once for each function it appears in
   sound/core/control_led.c:329:28: error: expected ';' before 'if'
     329 |         list_for_each_entry(lctl, _lctl, &led->controls, list)
         |                            ^
         |                            ;
     330 |                 if (lctl->card == card) {
         |                 ~~          
>> sound/core/control_led.c:315:39: warning: unused variable 'vd' [-Wunused-variable]
     315 |         struct snd_kcontrol_volatile *vd;
         |                                       ^~
>> sound/core/control_led.c:314:39: warning: unused variable '_lctl' [-Wunused-variable]
     314 |         struct snd_ctl_led_ctl *lctl, _lctl;
         |                                       ^~~~~
>> sound/core/control_led.c:314:33: warning: unused variable 'lctl' [-Wunused-variable]
     314 |         struct snd_ctl_led_ctl *lctl, _lctl;
         |                                 ^~~~
>> sound/core/control_led.c:313:29: warning: variable 'led' set but not used [-Wunused-but-set-variable]
     313 |         struct snd_ctl_led *led;
         |                             ^~~


vim +/vd +315 sound/core/control_led.c

22d8de62f11b287 Jaroslav Kysela 2021-03-17  309  
a135dfb5de15013 Jaroslav Kysela 2021-03-17  310  static int snd_ctl_led_reset(int card_number, unsigned int group)
a135dfb5de15013 Jaroslav Kysela 2021-03-17  311  {
a135dfb5de15013 Jaroslav Kysela 2021-03-17  312  	struct snd_card *card;
a135dfb5de15013 Jaroslav Kysela 2021-03-17 @313  	struct snd_ctl_led *led;
8d00c707fea8284 Andy Shevchenko 2023-08-29 @314  	struct snd_ctl_led_ctl *lctl, _lctl;
a135dfb5de15013 Jaroslav Kysela 2021-03-17 @315  	struct snd_kcontrol_volatile *vd;
a135dfb5de15013 Jaroslav Kysela 2021-03-17  316  	bool change = false;
a135dfb5de15013 Jaroslav Kysela 2021-03-17  317  
a135dfb5de15013 Jaroslav Kysela 2021-03-17  318  	card = snd_card_ref(card_number);
a135dfb5de15013 Jaroslav Kysela 2021-03-17  319  	if (!card)
a135dfb5de15013 Jaroslav Kysela 2021-03-17  320  		return -ENXIO;
a135dfb5de15013 Jaroslav Kysela 2021-03-17  321  
a135dfb5de15013 Jaroslav Kysela 2021-03-17  322  	mutex_lock(&snd_ctl_led_mutex);
a135dfb5de15013 Jaroslav Kysela 2021-03-17  323  	if (!snd_ctl_led_card_valid[card_number]) {
a135dfb5de15013 Jaroslav Kysela 2021-03-17  324  		mutex_unlock(&snd_ctl_led_mutex);
a135dfb5de15013 Jaroslav Kysela 2021-03-17  325  		snd_card_unref(card);
a135dfb5de15013 Jaroslav Kysela 2021-03-17  326  		return -ENXIO;
a135dfb5de15013 Jaroslav Kysela 2021-03-17  327  	}
a135dfb5de15013 Jaroslav Kysela 2021-03-17  328  	led = &snd_ctl_leds[group];
8d00c707fea8284 Andy Shevchenko 2023-08-29  329  	list_for_each_entry(lctl, _lctl, &led->controls, list)
a135dfb5de15013 Jaroslav Kysela 2021-03-17  330  		if (lctl->card == card) {
a135dfb5de15013 Jaroslav Kysela 2021-03-17  331  			vd = &lctl->kctl->vd[lctl->index_offset];
a135dfb5de15013 Jaroslav Kysela 2021-03-17  332  			vd->access &= ~group_to_access(group);
a135dfb5de15013 Jaroslav Kysela 2021-03-17  333  			snd_ctl_led_ctl_destroy(lctl);
a135dfb5de15013 Jaroslav Kysela 2021-03-17  334  			change = true;
a135dfb5de15013 Jaroslav Kysela 2021-03-17  335  		}
a135dfb5de15013 Jaroslav Kysela 2021-03-17  336  	mutex_unlock(&snd_ctl_led_mutex);
a135dfb5de15013 Jaroslav Kysela 2021-03-17  337  	if (change)
a135dfb5de15013 Jaroslav Kysela 2021-03-17  338  		snd_ctl_led_set_state(NULL, group_to_access(group), NULL, 0);
a135dfb5de15013 Jaroslav Kysela 2021-03-17  339  	snd_card_unref(card);
a135dfb5de15013 Jaroslav Kysela 2021-03-17  340  	return 0;
a135dfb5de15013 Jaroslav Kysela 2021-03-17  341  }
a135dfb5de15013 Jaroslav Kysela 2021-03-17  342  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
