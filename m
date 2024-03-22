Return-Path: <linux-kernel+bounces-111716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1787E886FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24CE2843DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5657353E2E;
	Fri, 22 Mar 2024 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTyp4skf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FFD53390
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122270; cv=none; b=B8xyAwPA/lwfv1GEFRouBYv4lpq+wiA7tEK1xSil1XkTqib61SnZ3cZl8j5b+bzQtXNirRfrKVtrcjW1vWU2WNTFHyu5T/Fktsqhy7E50RkrRfhWphoPDoiMmd1g6VVptz4E2BOtsHOZLH8qB0bWIkJsuG7o9zwVXe7EOO+2FWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122270; c=relaxed/simple;
	bh=EBSp52PjCAuRW5z/ds8x/472clJaJsQSTj5GfzJFE+c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AMUhumqyMpYsPpSV4mVip3EGLzNTevJf7QnHXBZNT1fO8PCW/eudulPf0MCPxBRMP109oU+/0Tzu7Mwi8ZleawBxF2T3rWP8gOEC5l6dGq0kD+GpzVTAm5x1aFz8siYnxXQAf6qmWVRJE+rX+UvFYfOsG/EZ2dcYapzWoHBNO8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTyp4skf; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711122269; x=1742658269;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EBSp52PjCAuRW5z/ds8x/472clJaJsQSTj5GfzJFE+c=;
  b=HTyp4skfjt2iOt1bu3SsyQKUdeHpi4xLbCZFcNXJ7qoiT8HvuT37lfU3
   MXfSIDCjLTszfpSJqd5r06gltzNMXVxfCuwLn6+CkUeQ13KVWdaRwtzU3
   B81YIcAHBkArhWjf71Dgzfot+2/IY3OmQyceAMxBRsAFz2tx4n3uP1zXW
   TfdkO1hbAKMh01jubZBYEqTQ+R4adQp68fEpIV/KKgNNJLed6Ilg8UAlN
   YgXB8PVk8I4qM72KlfWVGrEo+ar0ct0EH3MvcB7Fb2s8B0oQJYOOc1z2M
   wjB6TBSPzoKaFqL99rk9AUe/fvA9oDf6Gm1YA5xfz1Z/ALFomKn7BWmJs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="16812322"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="16812322"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 08:44:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="14858194"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 22 Mar 2024 08:44:27 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rnh4C-000KP1-1f;
	Fri, 22 Mar 2024 15:44:24 +0000
Date: Fri, 22 Mar 2024 23:44:04 +0800
From: kernel test robot <lkp@intel.com>
To: Anna Schumaker <Anna.Schumaker@netapp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/nfs/read.c:51:2-7: WARNING: NULL check before some freeing
 functions is not needed.
Message-ID: <202403222313.MSx9nW9B-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8e938e39866920ddc266898e6ae1fffc5c8f51aa
commit: 303a78052091c81e9003915c521fdca1c7e117af NFSv4.2: Rework scratch handling for READ_PLUS (again)
date:   7 months ago
config: x86_64-randconfig-101-20240322 (https://download.01.org/0day-ci/archive/20240322/202403222313.MSx9nW9B-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403222313.MSx9nW9B-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/nfs/read.c:51:2-7: WARNING: NULL check before some freeing functions is not needed.

vim +51 fs/nfs/read.c

    47	
    48	static void nfs_readhdr_free(struct nfs_pgio_header *rhdr)
    49	{
    50		if (rhdr->res.scratch != NULL)
  > 51			kfree(rhdr->res.scratch);
    52		kmem_cache_free(nfs_rdata_cachep, rhdr);
    53	}
    54	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

