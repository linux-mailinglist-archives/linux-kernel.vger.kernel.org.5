Return-Path: <linux-kernel+bounces-148481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1273C8A8336
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31842830C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0812F84DF6;
	Wed, 17 Apr 2024 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="dAmwnAxB"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F0541C7A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713357278; cv=none; b=kBNYy7q33Nzfh+6jO2aPTe3vk6m+z+WnfRW/b7GhrdqAFYr8WpezBcP8jVnBBWmTQmiAac+C5Hz7WhxG88ppkXWPEJm8+vsBF3Eqam5nm3NWfjWrzv8g1w6xF/jbRVGFG2quFU4gFNXhsQ84mm7lPLDJxoR4G3izcjEjo+h1tdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713357278; c=relaxed/simple;
	bh=E5QZtGU4PZm2is2P+MulDOxW3Rpe7EdfaFk+Lnyb7cU=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=kYrKDlawbjYypgHdWCIt4NpReVhF4fY+1/z36eChgdUSs95vWclTJLU+XrMXLitwzFpRdfmzv33KKLb9pDY7BZZKxJwYJ4kTomnmKNklzEvYYWCbrLEd1lJc6/nyhL8gum2O8DSMxmA873Hlqmwv072544zhER9MkiAUqi8DKrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=dAmwnAxB; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ysZHud6S4cjBQXKHfG/FeblhiB0ojezj19lZpopi0wI=;
  b=dAmwnAxBIKyxhRp9PioBKnPY8GhW/Olu4nx1naLHyF35gRSGUfxWFkvL
   f9Nz6h3AmwCs0LYgFmX8H+1XmVNIA1/FPYYmRjDSbmuAnE1bKJY0MuH6r
   x05nAocOpO4mO0hchE/anudMyyMlDknxLxefckD2YANaEjSOncapHZ2T0
   o=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,209,1708383600"; 
   d="scan'208";a="162061165"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 14:34:27 +0200
Date: Wed, 17 Apr 2024 14:34:27 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Samin Guo <samin.guo@starfivetech.com>, 
    Hal Feng <hal.feng@starfivetech.com>, Andrew Lunn <andrew@lunn.ch>
cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: drivers/net/phy/motorcomm.c:885:12-14: WARNING opportunity for min()
 (fwd)
Message-ID: <2119db14-c2a-9bd3-eae8-4faa5219dbc3@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



---------- Forwarded message ----------
Date: Wed, 17 Apr 2024 20:21:23 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/net/phy/motorcomm.c:885:12-14: WARNING opportunity for min()

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Samin Guo <samin.guo@starfivetech.com>
CC: Hal Feng <hal.feng@starfivetech.com>
CC: Andrew Lunn <andrew@lunn.ch>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   96fca68c4fbf77a8185eb10f7557e23352732ea2
commit: 7a561e9351ae7e3fb1f08584d40b49c1e55dde60 net: phy: motorcomm: Add pad drive strength cfg support
date:   9 months ago
:::::: branch date: 2 days ago
:::::: commit date: 9 months ago
config: i386-randconfig-053-20240417 (https://download.01.org/0day-ci/archive/20240417/202404172059.wU4sM9Qi-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202404172059.wU4sM9Qi-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/net/phy/motorcomm.c:885:12-14: WARNING opportunity for min()

vim +885 drivers/net/phy/motorcomm.c

7a561e9351ae7e3 Samin Guo 2023-07-20  877
7a561e9351ae7e3 Samin Guo 2023-07-20  878  static u32 yt8531_get_ldo_vol(struct phy_device *phydev)
7a561e9351ae7e3 Samin Guo 2023-07-20  879  {
7a561e9351ae7e3 Samin Guo 2023-07-20  880  	u32 val;
7a561e9351ae7e3 Samin Guo 2023-07-20  881
7a561e9351ae7e3 Samin Guo 2023-07-20  882  	val = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);
7a561e9351ae7e3 Samin Guo 2023-07-20  883  	val = FIELD_GET(YT8531_RGMII_LDO_VOL_MASK, val);
7a561e9351ae7e3 Samin Guo 2023-07-20  884
7a561e9351ae7e3 Samin Guo 2023-07-20 @885  	return val <= YT8531_LDO_VOL_1V8 ? val : YT8531_LDO_VOL_1V8;
7a561e9351ae7e3 Samin Guo 2023-07-20  886  }
7a561e9351ae7e3 Samin Guo 2023-07-20  887

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

