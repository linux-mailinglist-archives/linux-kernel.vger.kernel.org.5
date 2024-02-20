Return-Path: <linux-kernel+bounces-72269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CDD85B15C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 110CEB231E1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA29482D0;
	Tue, 20 Feb 2024 03:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJL1krAJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D767C45009;
	Tue, 20 Feb 2024 03:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708399734; cv=none; b=XVOE6mzG5/yimUuTVwE7yF2PZVnjz81Yl0Am9nTlD42F39gy7VFF6VY3LPeipd6P9LsslqEX675g54yOXHiFjx54qJP6guLbxDxN8xlJ1rYr4v9HpiwfAHNH95fXuBZhNvd8CKwrORCfbi4sxZvveBPwmGh9ccykcmnUw7BuVBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708399734; c=relaxed/simple;
	bh=BQlHpa273SuRCqvblXi5OnaVTNFf5TN8Nfvq3Uk5gu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvwRQoex6r9eio7dGvZNM5hRlDSXkCBSni0jg4ZcN0z9bYywBXaYHviAZxcpkTpUoIj98hzry4ENHrIrW782qFsFl3EuG2ZkNGABBCUhQ3ZhHEiyZ0VuQijT2TUc3jUNO5Odenr5DiUgmJcUOYk+dz5u+41PlU3eK1Xw+w0C0nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJL1krAJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708399732; x=1739935732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BQlHpa273SuRCqvblXi5OnaVTNFf5TN8Nfvq3Uk5gu4=;
  b=QJL1krAJhE1LBYg2JHUwfmylUQy81N6H4ECaBlCm83P3S9HO74Ugrs0b
   hx4ivp6Ux8QWX5BybcC1MpymthWU8vpgEDiq9SRUQx3ZmfMQ3C0peW/vm
   +rXAnPN/xffs8e21V76jnLsPautP3r1SJKSMzyzr8MKel28lo2b6CGw3m
   ymaGzQbbKtNLp3nOhRbuPYQb1RzUcvTxTvF4LWgNNxY/9bI+1/iGFTO0t
   +/xF9rErn+T3KZQDcTd2JMBK123zn3oGcGJzie7Lb4YbUYW0+mcMKc9qz
   pY7EqnKYYtOA17KsNPa0dgkOtORdy7V/+JnENHRvNZ9hc1IR4tmCJBtmH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2351346"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="2351346"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 19:28:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936382961"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="936382961"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 19:28:46 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcGoG-0004EC-1z;
	Tue, 20 Feb 2024 03:28:44 +0000
Date: Tue, 20 Feb 2024 11:28:43 +0800
From: kernel test robot <lkp@intel.com>
To: Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	Jeff LaBundy <jeff@labundy.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	catalin.popescu@leica-geosystems.com,
	mark.satterthwaite@touchnetix.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	bsp-development.geo@leica-geosystems.com,
	Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v8 3/3] Input: Add TouchNetix axiom i2c touchscreen driver
Message-ID: <202402201157.BKo97uWl-lkp@intel.com>
References: <20240219101221.129750-4-kamel.bouhara@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219101221.129750-4-kamel.bouhara@bootlin.com>

Hi Kamel,

kernel test robot noticed the following build errors:

[auto build test ERROR on dtor-input/next]
[also build test ERROR on dtor-input/for-linus robh/for-next krzk-dt/for-next linus/master v6.8-rc5 next-20240219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kamel-Bouhara/dt-bindings-vendor-prefixes-Add-TouchNetix-AS/20240219-181550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20240219101221.129750-4-kamel.bouhara%40bootlin.com
patch subject: [PATCH v8 3/3] Input: Add TouchNetix axiom i2c touchscreen driver
config: arm64-randconfig-002-20240220 (https://download.01.org/0day-ci/archive/20240220/202402201157.BKo97uWl-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 36adfec155de366d722f2bac8ff9162289dcf06c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240220/202402201157.BKo97uWl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402201157.BKo97uWl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/input/touchscreen/touchnetix_axiom.c:332:18: error: use of undeclared identifier 'slot'; did you mean 'sget'?
     332 |                 target->index, slot, target->present,
         |                                ^~~~
         |                                sget
   include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
     163 |                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
         |                                                             ^
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
     129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
         |                                                ^
   include/linux/fs.h:2272:21: note: 'sget' declared here
    2272 | struct super_block *sget(struct file_system_type *type,
         |                     ^
   1 error generated.


vim +332 drivers/input/touchscreen/touchnetix_axiom.c

   289	
   290	/*
   291	 * Support function to axiom_process_u41_report.
   292	 * Generates input-subsystem events for every target.
   293	 * After calling this function the caller shall issue
   294	 * a Sync to the input sub-system.
   295	 */
   296	static bool axiom_process_u41_report_target(struct axiom_data *ts,
   297						    struct axiom_target_report *target)
   298	{
   299		struct input_dev *input_dev = ts->input_dev;
   300		struct axiom_u41_target *target_prev_state;
   301		enum axiom_target_state current_state;
   302		int id;
   303	
   304		/* Verify the target index */
   305		if (target->index >= AXIOM_U41_MAX_TARGETS) {
   306			dev_err(ts->dev, "Invalid target index! %u\n", target->index);
   307			return false;
   308		}
   309	
   310		target_prev_state = &ts->targets[target->index];
   311	
   312		current_state = AXIOM_TARGET_STATE_NOT_PRESENT;
   313	
   314		if (target->present) {
   315			if (target->z >= 0)
   316				current_state = AXIOM_TARGET_STATE_TOUCHING;
   317			else if (target->z > AXIOM_PROX_LEVEL && target->z < 0)
   318				current_state = AXIOM_TARGET_STATE_HOVER;
   319			else if (target->z == AXIOM_PROX_LEVEL)
   320				current_state = AXIOM_TARGET_STATE_PROX;
   321		}
   322	
   323		if (target_prev_state->state == current_state &&
   324		    target_prev_state->x == target->x &&
   325		    target_prev_state->y == target->y &&
   326		    target_prev_state->z == target->z)
   327			return false;
   328	
   329		id = target->index;
   330	
   331		dev_dbg(ts->dev, "U41 Target T%u, slot:%u present:%u, x:%u, y:%u, z:%d\n",
 > 332			target->index, slot, target->present,
   333			target->x, target->y, target->z);
   334	
   335		switch (current_state) {
   336		case AXIOM_TARGET_STATE_NOT_PRESENT:
   337		case AXIOM_TARGET_STATE_PROX:
   338			if (!target_prev_state->insert)
   339				break;
   340			target_prev_state->insert = false;
   341	
   342			if (!id)
   343				input_report_key(input_dev, BTN_TOUCH, 0);
   344	
   345			input_mt_report_slot_inactive(input_dev);
   346			/*
   347			 * make sure the previous coordinates are
   348			 * all off screen when the finger comes back
   349			 */
   350			target->x = 65535;
   351			target->y = 65535;
   352			target->z = AXIOM_PROX_LEVEL;
   353			break;
   354		case AXIOM_TARGET_STATE_HOVER:
   355		case AXIOM_TARGET_STATE_TOUCHING:
   356			target_prev_state->insert = true;
   357			input_report_abs(input_dev, ABS_MT_TRACKING_ID, id);
   358			input_report_abs(input_dev, ABS_MT_POSITION_X, target->x);
   359			input_report_abs(input_dev, ABS_MT_POSITION_Y, target->y);
   360	
   361			if (current_state == AXIOM_TARGET_STATE_TOUCHING) {
   362				input_report_abs(input_dev, ABS_MT_DISTANCE, 0);
   363				input_report_abs(input_dev, ABS_DISTANCE, 0);
   364				input_report_abs(input_dev, ABS_MT_PRESSURE, target->z);
   365				input_report_abs(input_dev, ABS_PRESSURE, target->z);
   366			} else {
   367				input_report_abs(input_dev, ABS_MT_DISTANCE, -target->z);
   368				input_report_abs(input_dev, ABS_DISTANCE, -target->z);
   369				input_report_abs(input_dev, ABS_MT_PRESSURE, 0);
   370				input_report_abs(input_dev, ABS_PRESSURE, 0);
   371			}
   372	
   373			if (!id)
   374				input_report_key(input_dev, BTN_TOUCH, (current_state ==
   375						 AXIOM_TARGET_STATE_TOUCHING));
   376			break;
   377		default:
   378			break;
   379		}
   380	
   381		target_prev_state->state = current_state;
   382		target_prev_state->x = target->x;
   383		target_prev_state->y = target->y;
   384		target_prev_state->z = target->z;
   385	
   386		return true;
   387	}
   388	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

