Return-Path: <linux-kernel+bounces-112493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37150887A85
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12771F218AC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 21:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DC35A4CB;
	Sat, 23 Mar 2024 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcYy3NIs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AA059157
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711230082; cv=none; b=Ee40cTq3ASuKOC1XlGAJrcJjbMbbT7kPEg7aDIzW4YGkhb/nIZoDKEuPNnRROzM0fEttpTyRWkXmk/qpjRZ6kqaTAB7Spm/mJHQqcSiKWa4nD9s7LTIyWQwxvBs8PW7dbYN/1wMMmNeK/qMatPs3sOyiwwq5GMSYK4rPWUERlKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711230082; c=relaxed/simple;
	bh=F624kQyYBNbGewSHM34uqP5VWEphP0vFV/t944et3Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dQb/QFUD01e+BBxWu8n60+BIAoDSRrD2zWwUaiepaeLjCdqIj9isGrt74sc7TEfzgVuFuzDvfSZEwwJIWkDjVhq/MIyYcEwLCT5QDrAc712TI+ImuQrJoZOvG8Ob43f+POr+7ICvod6XbczXnfoCc3VyKBg/sw4G/L7xbXv3SVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcYy3NIs; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711230080; x=1742766080;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F624kQyYBNbGewSHM34uqP5VWEphP0vFV/t944et3Gw=;
  b=dcYy3NIsVMEqMnErUjM/4nKB+ZqvBADLNxaAMMfmB1GZdVJS6dCmgPzE
   ayWcPHC+faT6w3eqCB5+Sgz4oSdEQ40u3LS9gckepEyOC9AAYbhnKwT5r
   Q7xU146Ve183d/A4ZecvlzU4oS0n774YgF7QvrCiSC7Y07bJwXX+sAGf6
   23Ck/rfXKFiMAMWUzxX4txK3u1uzQnkuTzvePIjyTBQ/+Ei4Ebds4uezx
   PAUdeJ9i5uwWskIFww5+EVXtnOTzMcRjuU3ytREIAgIx/D6HG2iXU7+Ok
   L2PcI7ebD6effSkD/6uPehmQkeOEAyoZk5KvP8aFectd7/9izIDWm/C70
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11022"; a="16992818"
X-IronPort-AV: E=Sophos;i="6.07,150,1708416000"; 
   d="scan'208";a="16992818"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2024 14:41:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,150,1708416000"; 
   d="scan'208";a="15235353"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 23 Mar 2024 14:41:18 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ro975-000LUZ-07;
	Sat, 23 Mar 2024 21:41:15 +0000
Date: Sun, 24 Mar 2024 05:40:18 +0800
From: kernel test robot <lkp@intel.com>
To: Aswath Govindraju <a-govindraju@ti.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Subject: drivers/mux/mmio.c:76:34: error: storage size of 'field' isn't known
Message-ID: <202403240514.3cg86oop-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   484193fecd2b6349a6fd1554d306aec646ae1a6a
commit: e4d4371253029528c02bfb43a46c252e1c3d035f phy: phy-can-transceiver: Add support for setting mux
date:   1 year, 11 months ago
config: um-randconfig-001-20240323 (https://download.01.org/0day-ci/archive/20240324/202403240514.3cg86oop-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240324/202403240514.3cg86oop-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403240514.3cg86oop-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mux/mmio.c: In function 'mux_mmio_probe':
>> drivers/mux/mmio.c:76:34: error: storage size of 'field' isn't known
      76 |                 struct reg_field field;
         |                                  ^~~~~
   In file included from include/linux/bits.h:22,
                    from include/linux/bitops.h:6,
                    from drivers/mux/mmio.c:8:
>> include/linux/bits.h:24:28: error: first argument to '__builtin_choose_expr' not a constant
      24 |         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
         |                            ^~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |          ^~~~~~~~~~~~~~~~~~~
   drivers/mux/mmio.c:96:29: note: in expansion of macro 'GENMASK'
      96 |                 if (mask != GENMASK(field.msb, field.lsb)) {
         |                             ^~~~~~~
>> include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bits.h:24:10: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
      24 |         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
         |          ^~~~~~~~~~~~~~~~~
   include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |          ^~~~~~~~~~~~~~~~~~~
   drivers/mux/mmio.c:96:29: note: in expansion of macro 'GENMASK'
      96 |                 if (mask != GENMASK(field.msb, field.lsb)) {
         |                             ^~~~~~~
>> drivers/mux/mmio.c:102:29: error: implicit declaration of function 'devm_regmap_field_alloc' [-Werror=implicit-function-declaration]
     102 |                 fields[i] = devm_regmap_field_alloc(dev, regmap, field);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/mux/mmio.c:76:34: warning: unused variable 'field' [-Wunused-variable]
      76 |                 struct reg_field field;
         |                                  ^~~~~
   cc1: some warnings being treated as errors


vim +76 drivers/mux/mmio.c

73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   35  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   36  static int mux_mmio_probe(struct platform_device *pdev)
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   37  {
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   38  	struct device *dev = &pdev->dev;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   39  	struct device_node *np = dev->of_node;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   40  	struct regmap_field **fields;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   41  	struct mux_chip *mux_chip;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   42  	struct regmap *regmap;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   43  	int num_fields;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   44  	int ret;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   45  	int i;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   46  
8ecfaca7926f4b drivers/mux/mmio.c     Pankaj Bansal 2019-06-12   47  	if (of_device_is_compatible(np, "mmio-mux"))
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   48  		regmap = syscon_node_to_regmap(np->parent);
8ecfaca7926f4b drivers/mux/mmio.c     Pankaj Bansal 2019-06-12   49  	else
8ecfaca7926f4b drivers/mux/mmio.c     Pankaj Bansal 2019-06-12   50  		regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   51  	if (IS_ERR(regmap)) {
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   52  		ret = PTR_ERR(regmap);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   53  		dev_err(dev, "failed to get regmap: %d\n", ret);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   54  		return ret;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   55  	}
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   56  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   57  	ret = of_property_count_u32_elems(np, "mux-reg-masks");
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   58  	if (ret == 0 || ret % 2)
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   59  		ret = -EINVAL;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   60  	if (ret < 0) {
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   61  		dev_err(dev, "mux-reg-masks property missing or invalid: %d\n",
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   62  			ret);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   63  		return ret;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   64  	}
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   65  	num_fields = ret / 2;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   66  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   67  	mux_chip = devm_mux_chip_alloc(dev, num_fields, num_fields *
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   68  				       sizeof(*fields));
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   69  	if (IS_ERR(mux_chip))
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   70  		return PTR_ERR(mux_chip);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   71  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   72  	fields = mux_chip_priv(mux_chip);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   73  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   74  	for (i = 0; i < num_fields; i++) {
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   75  		struct mux_control *mux = &mux_chip->mux[i];
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  @76  		struct reg_field field;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   77  		s32 idle_state = MUX_IDLE_AS_IS;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   78  		u32 reg, mask;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   79  		int bits;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   80  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   81  		ret = of_property_read_u32_index(np, "mux-reg-masks",
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   82  						 2 * i, &reg);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   83  		if (!ret)
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   84  			ret = of_property_read_u32_index(np, "mux-reg-masks",
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   85  							 2 * i + 1, &mask);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   86  		if (ret < 0) {
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   87  			dev_err(dev, "bitfield %d: failed to read mux-reg-masks property: %d\n",
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   88  				i, ret);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   89  			return ret;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   90  		}
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   91  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   92  		field.reg = reg;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   93  		field.msb = fls(mask) - 1;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   94  		field.lsb = ffs(mask) - 1;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   95  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   96  		if (mask != GENMASK(field.msb, field.lsb)) {
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   97  			dev_err(dev, "bitfield %d: invalid mask 0x%x\n",
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   98  				i, mask);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   99  			return -EINVAL;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  100  		}
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  101  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14 @102  		fields[i] = devm_regmap_field_alloc(dev, regmap, field);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  103  		if (IS_ERR(fields[i])) {
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  104  			ret = PTR_ERR(fields[i]);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  105  			dev_err(dev, "bitfield %d: failed allocate: %d\n",
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  106  				i, ret);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  107  			return ret;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  108  		}
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  109  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  110  		bits = 1 + field.msb - field.lsb;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  111  		mux->states = 1 << bits;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  112  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  113  		of_property_read_u32_index(np, "idle-states", i,
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  114  					   (u32 *)&idle_state);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  115  		if (idle_state != MUX_IDLE_AS_IS) {
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  116  			if (idle_state < 0 || idle_state >= mux->states) {
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  117  				dev_err(dev, "bitfield: %d: out of range idle state %d\n",
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  118  					i, idle_state);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  119  				return -EINVAL;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  120  			}
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  121  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  122  			mux->idle_state = idle_state;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  123  		}
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  124  	}
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  125  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  126  	mux_chip->ops = &mux_mmio_ops;
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  127  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  128  	return devm_mux_chip_register(dev, mux_chip);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  129  }
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  130  

:::::: The code at line 76 was first introduced by commit
:::::: 73726380a26fa1ed490f30fccee10ed9da28dc0c mux: mmio-based syscon mux controller

:::::: TO: Philipp Zabel <p.zabel@pengutronix.de>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

