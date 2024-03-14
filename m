Return-Path: <linux-kernel+bounces-103186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE0D87BC0F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F003B23F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E436EB73;
	Thu, 14 Mar 2024 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="im0sBbs5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BC46DCF5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710416432; cv=none; b=L3JD6BO65eIAJ0QB7PYhIn5fML93qcql1rnBsOZSHe7o8K96loG6CGgZ5HzkGBqOGPW4/yR8HSLw/DNFD+8sGlm56GQWmNGAdgZ60iENkWf/Nx32sjvniMjINDWt3nhk2hSX9r78ui1hrnsAxFkjHpnCzVKz0b9rZSUrfAGgpz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710416432; c=relaxed/simple;
	bh=gKTcjdFrr1i6/462Q9B2PQQrObiqbNl2aiA7L8ANI+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSg9xpoieOXCHClFNOYjM3kQw+yX4qqmmL3EVYH0bb/wLKdEYtBP/M8HmgaOO9sgyWe/PkW1TIIuGhMNEDuE/YzdX1dfvJW8fAWgNWWm2vJ2/CSoEiIC9FA45JtrejAuvGjuStUCnWFIAJLeZwB6SbX7hqcgL0pPFNKOFrg8jqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=im0sBbs5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710416430; x=1741952430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gKTcjdFrr1i6/462Q9B2PQQrObiqbNl2aiA7L8ANI+o=;
  b=im0sBbs5qfmxawwbed+0O8MRDZXIfnct0GG5g+62oj5hzBMt1FGsVp9Z
   VYT0FaeNIcZ2uQuXB+Z//bWfwoZ6S5fqEX3G6eEfgAYC4CNhgTT0qoWgl
   Naz8gysNiE+WNEY2hjRxAIPJk/R5tQL0RZqGnpU8J5NfLnQx31d7/1LmE
   /HAuO2vbKM8WPurOSGz/knkvOWODEFbVkpPvha95LUG0KIS2/ON6CHyG4
   kv1qMUQBAlPw0P0zIks7+0tjC0zpj8/9RCvHuWXKBQdJTzc6q+GXrByeW
   mvxvcBcfooZ2jQUreA868ntUY9jd24I+f9PnoyxGnQoyK4RiKdfZgQp0h
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="9006089"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="9006089"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 04:40:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="43298849"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Mar 2024 04:40:27 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkjRg-000DNn-0P;
	Thu, 14 Mar 2024 11:40:24 +0000
Date: Thu, 14 Mar 2024 19:40:04 +0800
From: kernel test robot <lkp@intel.com>
To: Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
	jhubbard@nvidia.com, vbabka@suse.cz, mgorman@suse.de,
	linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	dave@stgolabs.net, p.raghav@samsung.com, da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: Re: [PATCH 2/3] mm/compaction: add and use
 for_each_populated_zone_pgdat() helper
Message-ID: <202403141931.2XJWI4fa-lkp@intel.com>
References: <20240314005436.2962962-3-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314005436.2962962-3-mcgrof@kernel.org>

Hi Luis,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Luis-Chamberlain/mm-show_mem-simplify-ifdef-on-si_meminfo_node/20240314-085917
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240314005436.2962962-3-mcgrof%40kernel.org
patch subject: [PATCH 2/3] mm/compaction: add and use for_each_populated_zone_pgdat() helper
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240314/202403141931.2XJWI4fa-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240314/202403141931.2XJWI4fa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403141931.2XJWI4fa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/compaction.c: In function 'fragmentation_score_node':
>> mm/compaction.c:2252:13: warning: unused variable 'zoneid' [-Wunused-variable]
    2252 |         int zoneid;
         |             ^~~~~~


vim +/zoneid +2252 mm/compaction.c

  2240	
  2241	/*
  2242	 * The per-node proactive (background) compaction process is started by its
  2243	 * corresponding kcompactd thread when the node's fragmentation score
  2244	 * exceeds the high threshold. The compaction process remains active till
  2245	 * the node's score falls below the low threshold, or one of the back-off
  2246	 * conditions is met.
  2247	 */
  2248	static unsigned int fragmentation_score_node(pg_data_t *pgdat)
  2249	{
  2250		unsigned int score = 0;
  2251		struct zone *zone;
> 2252		int zoneid;
  2253	
  2254		for_each_populated_zone_pgdat(zone, pgdat)
  2255			score += fragmentation_score_zone_weighted(zone);
  2256	
  2257		return score;
  2258	}
  2259	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

