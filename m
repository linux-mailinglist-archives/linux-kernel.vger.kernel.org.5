Return-Path: <linux-kernel+bounces-103891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3468B87C64D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E541C2185A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3653D14AB0;
	Thu, 14 Mar 2024 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Brh++XNl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3BE14A89
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458751; cv=none; b=Hsi2cEGPtrN0JFlemSfwVWGuEdblQtZgUUUOKUbAPcVQ5tTXREQg8GQzCCmcM7Xg9J+RfxmQfnfFZhWLrp79n4blNhSndFbHBYoEJxky7GTZbox1TFQKIdJR9dpyPKMDUozkjDwWKg+PnB1mfFSez66APnlvtPaINPpQ3VHNJH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458751; c=relaxed/simple;
	bh=KJ+O+IzbDJBO+R6eeHjNGFN28Opkb5PBkbe5EXIa9Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UOfKIAP/vkgWs4JR0d7FQalxAa1AeBTaXxDPUNq+DpoeVfjvLPkzxCSvg/CbmJs1AvPlrXTGgDvqTLlZXnIUgXjtnEc0BDRxf0tJWa4X4twQyCxI2Yp1kzYSQ3qMf7GAQiQnhOgYpI94ynxV+CkiBFnr2HVKPQaI9nwc9ZsJf0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Brh++XNl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710458749; x=1741994749;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KJ+O+IzbDJBO+R6eeHjNGFN28Opkb5PBkbe5EXIa9Ec=;
  b=Brh++XNlAQtYXUxkUY1hOE9rXY+7rDsKCpXDkoXhSSkaM/8z79D2JWmW
   qr4oEVR3Mo9fNWL/rXNdl8zNw8x+54RdS16NgjS5cBdVKklNnObcVK/qB
   q2bryLmQxYqiukIQvKcjS+KnTfe40QS09zxO7eL1u13dpzZI7//W0bEDB
   jkNzRpdkoMq/R51ZTIUbd1o3r8k3o0YrHIB/mcY6sR4PU4nQlU76is78z
   PxxcJiidxDCGxfBpcJgsuRxkHy8sPqhAQ0SQIHAqNYEUtMt9OzwnF2TnY
   PA+rxWQihYgQt0xunwNwg/+CpayPqZueibnrgFRwQq161w7oo0FtVyd4v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5513495"
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="5513495"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 16:25:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="12548300"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 14 Mar 2024 16:25:48 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkuSH-000Dsb-1U;
	Thu, 14 Mar 2024 23:25:45 +0000
Date: Fri, 15 Mar 2024 07:25:39 +0800
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: sound/core/control.c:1409:5-11: inconsistent IS_ERR and PTR_ERR on
 line 1410.
Message-ID: <202403150720.IvePtxNs-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Takashi,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fe46a7dd189e25604716c03576d05ac8a5209743
commit: 1052d988226948493eb9730b3424308972eca5f4 ALSA: control: Use automatic cleanup of kfree()
date:   3 weeks ago
config: x86_64-randconfig-103-20240314 (https://download.01.org/0day-ci/archive/20240315/202403150720.IvePtxNs-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403150720.IvePtxNs-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> sound/core/control.c:1409:5-11: inconsistent IS_ERR and PTR_ERR on line 1410.

vim +1409 sound/core/control.c

^1da177e4c3f41 Linus Torvalds   2005-04-16  1400  
82e9bae6fd253a Takashi Iwai     2005-11-17  1401  static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
82e9bae6fd253a Takashi Iwai     2005-11-17  1402  				   struct snd_ctl_elem_value __user *_control)
^1da177e4c3f41 Linus Torvalds   2005-04-16  1403  {
1052d988226948 Takashi Iwai     2024-02-22  1404  	struct snd_ctl_elem_value *control __free(kfree) = NULL;
646494007b48e8 Giuliano Pochini 2006-03-13  1405  	struct snd_card *card;
^1da177e4c3f41 Linus Torvalds   2005-04-16  1406  	int result;
^1da177e4c3f41 Linus Torvalds   2005-04-16  1407  
ef44a1ec6eeef1 Li Zefan         2009-04-10  1408  	control = memdup_user(_control, sizeof(*control));
ef44a1ec6eeef1 Li Zefan         2009-04-10 @1409  	if (IS_ERR(control))
1052d988226948 Takashi Iwai     2024-02-22 @1410  		return PTR_ERR(no_free_ptr(control));
ef44a1ec6eeef1 Li Zefan         2009-04-10  1411  
646494007b48e8 Giuliano Pochini 2006-03-13  1412  	card = file->card;
646494007b48e8 Giuliano Pochini 2006-03-13  1413  	result = snd_ctl_elem_write(card, file, control);
7d8e8292013ab7 Takashi Iwai     2017-08-30  1414  	if (result < 0)
1052d988226948 Takashi Iwai     2024-02-22  1415  		return result;
7d8e8292013ab7 Takashi Iwai     2017-08-30  1416  
^1da177e4c3f41 Linus Torvalds   2005-04-16  1417  	if (copy_to_user(_control, control, sizeof(*control)))
1052d988226948 Takashi Iwai     2024-02-22  1418  		return -EFAULT;
^1da177e4c3f41 Linus Torvalds   2005-04-16  1419  	return result;
^1da177e4c3f41 Linus Torvalds   2005-04-16  1420  }
^1da177e4c3f41 Linus Torvalds   2005-04-16  1421  

:::::: The code at line 1409 was first introduced by commit
:::::: ef44a1ec6eeef189998f84e7230e1d3535b01074 ALSA: sound/core: use memdup_user()

:::::: TO: Li Zefan <lizf@cn.fujitsu.com>
:::::: CC: Takashi Iwai <tiwai@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

