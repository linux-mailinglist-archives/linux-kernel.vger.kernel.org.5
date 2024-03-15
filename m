Return-Path: <linux-kernel+bounces-104263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C3E87CB64
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1603E283042
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D9618EAF;
	Fri, 15 Mar 2024 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="msBPhbGZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BB918040
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710498669; cv=none; b=BPKoCGkjfsM7Ll+VjAf7QhHEipQth9nQRSOifkB4naiqhqGnfH43Pult2hD8MfBg82oYHMuPsEaWzf/6lbMEuR/8H86i5Q/p+pPGfYGIEtnT0M4j5kw50C/gZ49Do4NSNO9Ouf3jc/LoO+3kb2bdaIVfSzpQFN0FcvbpUsPrsgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710498669; c=relaxed/simple;
	bh=hY5n8yiSLnK6A5k9B8yt5M2btemk+zy4UubFFwBG4NU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FU8p4R6hTFInG5VFKRmKBJlTNL/JCMtVI00JdfTls5ISlPgrmJdmMxRDMMorNRSxE31AwKrI0WijZerHIU6VpdLUenEabg0+vVDcvc+yxe4Q69syoVrH4Rrwj2WBff9MI1wzduUMyXeefM+dTrUCC/oYT5bIsE0CD/mwvaoOR5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=msBPhbGZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710498667; x=1742034667;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hY5n8yiSLnK6A5k9B8yt5M2btemk+zy4UubFFwBG4NU=;
  b=msBPhbGZPRfbgy1RNDbGMcZI3WmbjKeci4NnnnSv+SZ1FCX0HGt0DXhe
   56AbEpu0B/lOi3+J6UvjCxv3so9Z+FL10yhe4Ea/swPo8j+Jtpy1k/B/y
   ZsIrrMBGqEI/mv9uTYpKYaOMUuBqGUTGKXRywijIe/bMEna4G2UrbodUe
   kXY8XIpKTuQm2eMmAeLYw/14ZHJKIY2jdYKczWpwffbDoGfW1NEJ3vzzh
   odA3sLY1nFUia882g7dAxw3B3HLukKMsLihU7k2lfsQDqZHi0Dyb1Ldo+
   3If/5EeXt49xFKGc1nQsypSlpnr/RZRwFMCOq1uiANM4xCNgeUXUGw5oi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5493376"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5493376"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 03:31:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="17299223"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 15 Mar 2024 03:31:05 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rl4q6-000EKv-1y;
	Fri, 15 Mar 2024 10:31:02 +0000
Date: Fri, 15 Mar 2024 18:30:26 +0800
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: sound/core/compress_offload.c:595:6-12: inconsistent IS_ERR and
 PTR_ERR on line 596.
Message-ID: <202403151855.V0OS6L14-lkp@intel.com>
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
head:   e5eb28f6d1afebed4bb7d740a797d0390bd3a357
commit: 9b02221422a55e834469fdc91dc4d5147f5a1fb9 ALSA: compress_offload: Use automatic cleanup of kfree()
date:   3 weeks ago
config: x86_64-randconfig-103-20240314 (https://download.01.org/0day-ci/archive/20240315/202403151855.V0OS6L14-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403151855.V0OS6L14-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> sound/core/compress_offload.c:595:6-12: inconsistent IS_ERR and PTR_ERR on line 596.

vim +595 sound/core/compress_offload.c

4dc040a0b34890 Vinod Koul          2012-09-17  582  
b21c60a4edd22e Vinod Koul          2011-12-23  583  static int
b21c60a4edd22e Vinod Koul          2011-12-23  584  snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
b21c60a4edd22e Vinod Koul          2011-12-23  585  {
9b02221422a55e Takashi Iwai        2024-02-22  586  	struct snd_compr_params *params __free(kfree) = NULL;
b21c60a4edd22e Vinod Koul          2011-12-23  587  	int retval;
b21c60a4edd22e Vinod Koul          2011-12-23  588  
7ea9ee0064281e Srinivas Kandagatla 2023-06-19  589  	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN || stream->next_track) {
b21c60a4edd22e Vinod Koul          2011-12-23  590  		/*
b21c60a4edd22e Vinod Koul          2011-12-23  591  		 * we should allow parameter change only when stream has been
b21c60a4edd22e Vinod Koul          2011-12-23  592  		 * opened not in other cases
b21c60a4edd22e Vinod Koul          2011-12-23  593  		 */
c2f14ba749c1ce Markus Elfring      2016-08-21  594  		params = memdup_user((void __user *)arg, sizeof(*params));
c2f14ba749c1ce Markus Elfring      2016-08-21 @595  		if (IS_ERR(params))
9b02221422a55e Takashi Iwai        2024-02-22 @596  			return PTR_ERR(no_free_ptr(params));
4dc040a0b34890 Vinod Koul          2012-09-17  597  
4dc040a0b34890 Vinod Koul          2012-09-17  598  		retval = snd_compress_check_input(params);
4dc040a0b34890 Vinod Koul          2012-09-17  599  		if (retval)
9b02221422a55e Takashi Iwai        2024-02-22  600  			return retval;
4dc040a0b34890 Vinod Koul          2012-09-17  601  
b21c60a4edd22e Vinod Koul          2011-12-23  602  		retval = snd_compr_allocate_buffer(stream, params);
9b02221422a55e Takashi Iwai        2024-02-22  603  		if (retval)
9b02221422a55e Takashi Iwai        2024-02-22  604  			return -ENOMEM;
4dc040a0b34890 Vinod Koul          2012-09-17  605  
b21c60a4edd22e Vinod Koul          2011-12-23  606  		retval = stream->ops->set_params(stream, params);
b21c60a4edd22e Vinod Koul          2011-12-23  607  		if (retval)
9b02221422a55e Takashi Iwai        2024-02-22  608  			return retval;
49bb6402f1aa1e Charles Keepax      2013-04-18  609  
7ea9ee0064281e Srinivas Kandagatla 2023-06-19  610  		if (stream->next_track)
9b02221422a55e Takashi Iwai        2024-02-22  611  			return retval;
7ea9ee0064281e Srinivas Kandagatla 2023-06-19  612  
9727b490e543de Jeeja KP            2013-02-14  613  		stream->metadata_set = false;
9727b490e543de Jeeja KP            2013-02-14  614  		stream->next_track = false;
49bb6402f1aa1e Charles Keepax      2013-04-18  615  
49bb6402f1aa1e Charles Keepax      2013-04-18  616  		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
769fab2a41da4b Jesper Juhl         2012-01-23  617  	} else {
b21c60a4edd22e Vinod Koul          2011-12-23  618  		return -EPERM;
769fab2a41da4b Jesper Juhl         2012-01-23  619  	}
b21c60a4edd22e Vinod Koul          2011-12-23  620  	return retval;
b21c60a4edd22e Vinod Koul          2011-12-23  621  }
b21c60a4edd22e Vinod Koul          2011-12-23  622  

:::::: The code at line 595 was first introduced by commit
:::::: c2f14ba749c1ce94aa97c5a84733a89aaaadada4 ALSA: compress: Use memdup_user() rather than duplicating its implementation

:::::: TO: Markus Elfring <elfring@users.sourceforge.net>
:::::: CC: Takashi Iwai <tiwai@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

