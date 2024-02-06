Return-Path: <linux-kernel+bounces-55678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23B784BFDF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C360AB234A7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB9D1BF27;
	Tue,  6 Feb 2024 22:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVoKtWei"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252DE1BC30
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 22:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257665; cv=none; b=t7SkXGwmhVWYKByhtqz3bAZGbuj0o8FmP6IRymlFsY0OQTXpIUqkbPvg9f/vMICDCGWh0BU75yG0ptXLsgZAtqH2FC084MSh6vAOV+OTF4EKjJfx5UlaMdZz8h0yKh6SgZsInk90RA0i3HTvLcUV5VLG7J+dk9HYu3mjzQjxA7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257665; c=relaxed/simple;
	bh=EdNMuL823nKxznGXv0hHFdrFCk7K/tjRGRJ5rhHIQ30=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J3b/eG44KKOHJKdw+bOLmgPlTYqKxsW2+9FMtO1V7636UF8vjBoX6iuu31rvfFGPS3K8Xw+IHxc4Kzhnhss/U+hYXyNaXKOf6AFbN3d6h4ZYo7RmvolC6ih1qjx95gslWdRXBBhldBywcj1w86sCvMvF/+RL2SODebzRZGHXqxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVoKtWei; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707257663; x=1738793663;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EdNMuL823nKxznGXv0hHFdrFCk7K/tjRGRJ5rhHIQ30=;
  b=KVoKtWeiZ46qR7/hZI98ArlYWSUefBMeGaueMvNioSuZdMg967kKW4pB
   qJ1/ZSAwjpu7lGWvFCyooq1+fzyyciXcwZrUMgf/m4oQAmP8cJpDSfe7m
   6sMqztd8nzxNmhNAseQJ206mBsDY6+u3L7h8C8v6Uu6x5/BG0wS6tBRuF
   Cy0MpqzSJyzXKKKC+oLylGQMWzuTx0e2YQdRdH2x+SuTPa329erskIrLX
   mgNcXQKJj/AJzWxUHA73x9X+0oaGoxZQcS3tUoOlVm8H41Rhro00+yhVF
   l/36oC/5Vdi0pyaPswh2WLuxE7hHD2Y2yx/sBTsVYW/wEseo7BckzQzT+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="1018113"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="1018113"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 14:14:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="1146800"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 06 Feb 2024 14:14:20 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXThq-0001pg-2m;
	Tue, 06 Feb 2024 22:14:18 +0000
Date: Wed, 7 Feb 2024 06:13:24 +0800
From: kernel test robot <lkp@intel.com>
To: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Subject: security/landlock/ruleset.c:644: warning: Function parameter or
 struct member '' not described in 'landlock_init_layer_masks'
Message-ID: <202402070653.ovMJd41U-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   99bd3cb0d12e85d5114425353552121ec8f93adc
commit: 0e7410112964168a65578002269ae3b80b207936 landlock: Move and rename layer helpers
date:   3 months ago
config: i386-randconfig-141-20240206 (https://download.01.org/0day-ci/archive/20240207/202402070653.ovMJd41U-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240207/202402070653.ovMJd41U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402070653.ovMJd41U-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Use of uninitialized value $param in regexp compilation at scripts/kernel-doc line 1518, <IN_FILE> line 182.
   Use of uninitialized value $actual in substitution (s///) at scripts/kernel-doc line 1470, <IN_FILE> line 182.
   Use of uninitialized value $actual in substitution (s///) at scripts/kernel-doc line 1470, <IN_FILE> line 182.
   Use of uninitialized value $param in substitution (s///) at scripts/kernel-doc line 1576, <IN_FILE> line 182.
   Use of uninitialized value $param in pattern match (m//) at scripts/kernel-doc line 1605, <IN_FILE> line 182.
   Use of uninitialized value $param in hash element at scripts/kernel-doc line 1615, <IN_FILE> line 182.
   Use of uninitialized value $param in pattern match (m//) at scripts/kernel-doc line 1615, <IN_FILE> line 182.
   Use of uninitialized value $param in hash element at scripts/kernel-doc line 1616, <IN_FILE> line 182.
   Use of uninitialized value $param in pattern match (m//) at scripts/kernel-doc line 1618, <IN_FILE> line 182.
   Use of uninitialized value $param in concatenation (.) or string at scripts/kernel-doc line 1619, <IN_FILE> line 182.
   security/landlock/ruleset.c:182: warning: Function parameter or struct member '' not described in 'insert_rule'
   Use of uninitialized value $param in hash element at scripts/kernel-doc line 1634, <IN_FILE> line 182.
   Use of uninitialized value $parameterlist[2] in join or string at scripts/kernel-doc line 1793, <IN_FILE> line 182.
   security/landlock/ruleset.c:182: warning: Excess function parameter 'layers' description in 'insert_rule'
   Use of uninitialized value $param in regexp compilation at scripts/kernel-doc line 1518, <IN_FILE> line 644.
   Use of uninitialized value $actual in substitution (s///) at scripts/kernel-doc line 1470, <IN_FILE> line 644.
   Use of uninitialized value $actual in substitution (s///) at scripts/kernel-doc line 1470, <IN_FILE> line 644.
   Use of uninitialized value $param in substitution (s///) at scripts/kernel-doc line 1576, <IN_FILE> line 644.
   Use of uninitialized value $param in pattern match (m//) at scripts/kernel-doc line 1605, <IN_FILE> line 644.
   Use of uninitialized value $param in hash element at scripts/kernel-doc line 1615, <IN_FILE> line 644.
   Use of uninitialized value $param in pattern match (m//) at scripts/kernel-doc line 1615, <IN_FILE> line 644.
   Use of uninitialized value $param in hash element at scripts/kernel-doc line 1616, <IN_FILE> line 644.
   Use of uninitialized value $param in pattern match (m//) at scripts/kernel-doc line 1618, <IN_FILE> line 644.
   Use of uninitialized value $param in concatenation (.) or string at scripts/kernel-doc line 1619, <IN_FILE> line 644.
>> security/landlock/ruleset.c:644: warning: Function parameter or struct member '' not described in 'landlock_init_layer_masks'
   Use of uninitialized value $param in hash element at scripts/kernel-doc line 1634, <IN_FILE> line 644.
   Use of uninitialized value $parameterlist[2] in join or string at scripts/kernel-doc line 1793, <IN_FILE> line 644.
>> security/landlock/ruleset.c:644: warning: Excess function parameter 'layer_masks' description in 'landlock_init_layer_masks'


vim +644 security/landlock/ruleset.c

   626	
   627	/**
   628	 * landlock_init_layer_masks - Initialize layer masks from an access request
   629	 *
   630	 * Populates @layer_masks such that for each access right in @access_request,
   631	 * the bits for all the layers are set where this access right is handled.
   632	 *
   633	 * @domain: The domain that defines the current restrictions.
   634	 * @access_request: The requested access rights to check.
   635	 * @layer_masks: The layer masks to populate.
   636	 *
   637	 * Returns: An access mask where each access right bit is set which is handled
   638	 * in any of the active layers in @domain.
   639	 */
   640	access_mask_t landlock_init_layer_masks(
   641		const struct landlock_ruleset *const domain,
   642		const access_mask_t access_request,
   643		layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
 > 644	{

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

