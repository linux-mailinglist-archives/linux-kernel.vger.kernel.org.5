Return-Path: <linux-kernel+bounces-85939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD2686BD05
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5A61C22B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591511EB22;
	Thu, 29 Feb 2024 00:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CUbJ0VlS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246E8620
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168006; cv=none; b=jiiCIiTnbIlV58RqptQV7GMHMm3BwJdS8oUO7XsAG/mlITkZGpEnj+cjlM24At50h+2TB8n0/OGLn6f4/aK5cxebl2Jsn9u7v5OKwd9NRT1ALTZSQanfrXRproOVcoyvEmWNOWp6p2R9kBUHTIBpgw1xZ/dYYVI5or9s+M48h2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168006; c=relaxed/simple;
	bh=GZ6/K3soNquxS65lu5RJtrESy2ITkAQ8xwiS+nmifcI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SJ74e3V5GP7F8kQ5kTuryDYjGonUsBiSoRu4AwC4dO4N7SMGdNLvRI/4mqLaboyv2U0Wyqpj9RTzkPbHPz+H9Cm+cTz9qDtMbLK4Lv08f1beIiZOFbOQ1saQ0oDv0QqsuKq8BXTt/YsgYqHXmIfvYO69139Gp/TUxF6cSXfX52A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CUbJ0VlS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709168005; x=1740704005;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GZ6/K3soNquxS65lu5RJtrESy2ITkAQ8xwiS+nmifcI=;
  b=CUbJ0VlS9cTuhTYpsg/CwlFqwvTCk9YuO5tj/MoxJI1q/E/J+bBTECak
   n8Rb6p3N4EcwoextMLCjWuFqmuAcKyvzjco738WQHljGOf6kN+JS/r7ke
   b4TgqxDp7DcgYMNlZsTytS13eShtbnv0Opyt74B60B7TN978C6IMjVlvt
   BjelXq0xlbAMj61IT0cy3Ae9fitEkf9tNvDxZdoYtozBpcZHjLGn33vsA
   IBqtmyUNKxrtQhwgEydk2CKpHsJHqvoNJkoSRTNPN0c0NVLF3cltcjuRL
   QkUdkpXBJR/M9y+LCssG8NHESkAJJsNJshGSSo0uMvl4Qj6nvxz2my3Qk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14174606"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="14174606"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:53:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="12203525"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 28 Feb 2024 16:53:23 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfUfp-000CW5-0S;
	Thu, 29 Feb 2024 00:53:21 +0000
Date: Thu, 29 Feb 2024 08:53:00 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data4' from
 `drivers/mtd/nand/raw/diskonchip.o' being placed in section
 `.bss..Lubsan_data4'
Message-ID: <202402290803.JP5EWtl4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   805d849d7c3cc1f38efefd48b2480d62b7b5dcb7
commit: c27cd083cfb9d392f304657ed00fcde1136704e7 Compiler attributes: GCC cold function alignment workarounds
date:   1 year, 1 month ago
config: powerpc-randconfig-r025-20220324 (https://download.01.org/0day-ci/archive/20240229/202402290803.JP5EWtl4-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240229/202402290803.JP5EWtl4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402290803.JP5EWtl4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data4' from `drivers/mtd/nand/raw/diskonchip.o' being placed in section `.bss..Lubsan_data4'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data4' from `drivers/mtd/nand/raw/diskonchip.o' being placed in section `.bss..Lubsan_data4'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data4' from `drivers/mtd/nand/raw/diskonchip.o' being placed in section `.bss..Lubsan_data4'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data4' from `drivers/mtd/nand/raw/diskonchip.o' being placed in section `.bss..Lubsan_data4'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

