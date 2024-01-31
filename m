Return-Path: <linux-kernel+bounces-46382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BB6843ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC2F1F2E8B7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2BB762DC;
	Wed, 31 Jan 2024 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SUtOwy4D"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DFE76040;
	Wed, 31 Jan 2024 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701880; cv=none; b=hqqr1XdWZdiEOSiOg1P7CPHHQ9yIQa4tdjtZq/yM3f/5VcfBPGSuAIdNgUFZKQFAoUShirEHieHnOjCe4VpOzxLIXmMHQnFyBr63LHTMviQ67nTMH7nMV5dPUvwvo02qYmOgtVvNlnN/fa6gCgkyyNMMSxiBL4dsaXrDTGbae7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701880; c=relaxed/simple;
	bh=CuCh2cxo9xnL4HtIF/woYQx9LoBHjPmfaYxw3p9oUIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aq6bU7AZdrsm8/illLQre+1oaAWPO20t2iNU6WGQGLgUM/1nRb0bdy36LsfgSgjfxprO1y/0haGfrlMqvYf2kBCiBsyopeUh8dMEnFXg3LP0+uvNnB/ATyau0OzWW773lUUgdd4EHszQAJwAj4zWIffkB2Kgwvy1HHakJMY3HFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SUtOwy4D; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706701878; x=1738237878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CuCh2cxo9xnL4HtIF/woYQx9LoBHjPmfaYxw3p9oUIg=;
  b=SUtOwy4DEbWBJg5RybyOyJ0XHfIM7BVy39BaVpORLfeK5pZLDJPVvRPP
   9x/LvoEsGLr6Zh2RWhPrMzMne2xzzlGNzpAVe65Onq9k+R9K24KzHEruF
   feLLL8BAo5jyqqzGnp06LFq7kQu9OXB0GOrv8CoNjGZT4KFS2R6ZJAsiw
   A+G8Rvm8BeQifMqvM8+7j9ypJrx5iaFIl3CEWmiGXdGnQEKRPzm/jGfN5
   2xme6PqNSdJmwaRCK3NSDSDhrw2uSCfWGPvsovlPdE59LOC0LsmLkctOK
   lZJ0Q+GAMbA3AHJZSmd/6z2FBs05OepNTmhg0/LeMM/oZitdRZJfwD7wi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22086101"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="22086101"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:51:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="907861041"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="907861041"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 31 Jan 2024 03:51:14 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rV97Y-0001WW-14;
	Wed, 31 Jan 2024 11:51:12 +0000
Date: Wed, 31 Jan 2024 19:50:34 +0800
From: kernel test robot <lkp@intel.com>
To: Lee Duncan <leeman.duncan@gmail.com>, linux-scsi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	hare@suse.de, Lee Duncan <lduncan@suse.com>
Subject: Re: [PATCH 2/2] fnic: move fnic_fnic_flush_tx() to a work queue
Message-ID: <202401311947.cPDhv2xa-lkp@intel.com>
References: <9c51ef07a04413fb2f2bd20f1534f96e004e4e59.1706632031.git.lduncan@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c51ef07a04413fb2f2bd20f1534f96e004e4e59.1706632031.git.lduncan@suse.com>

Hi Lee,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jejb-scsi/for-next]
[also build test WARNING on mkp-scsi/for-next linus/master v6.8-rc2 next-20240131]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lee-Duncan/Revert-scsi-fcoe-Fix-potential-deadlock-on-fip-ctlr_lock/20240131-004656
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
patch link:    https://lore.kernel.org/r/9c51ef07a04413fb2f2bd20f1534f96e004e4e59.1706632031.git.lduncan%40suse.com
patch subject: [PATCH 2/2] fnic: move fnic_fnic_flush_tx() to a work queue
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20240131/202401311947.cPDhv2xa-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240131/202401311947.cPDhv2xa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401311947.cPDhv2xa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/scsi/fnic/fnic_fcs.c:1194: warning: Function parameter or struct member 'work' not described in 'fnic_flush_tx'
>> drivers/scsi/fnic/fnic_fcs.c:1194: warning: Excess function parameter 'fnic' description in 'fnic_flush_tx'


vim +1194 drivers/scsi/fnic/fnic_fcs.c

5df6d737dd4b0fe Abhijeet Joglekar 2009-04-17  1182  
78112e5558064cb Joe Eykholt       2009-11-03  1183  /**
78112e5558064cb Joe Eykholt       2009-11-03  1184   * fnic_flush_tx() - send queued frames.
78112e5558064cb Joe Eykholt       2009-11-03  1185   * @fnic: fnic device
78112e5558064cb Joe Eykholt       2009-11-03  1186   *
78112e5558064cb Joe Eykholt       2009-11-03  1187   * Send frames that were waiting to go out in FC or Ethernet mode.
78112e5558064cb Joe Eykholt       2009-11-03  1188   * Whenever changing modes we purge queued frames, so these frames should
78112e5558064cb Joe Eykholt       2009-11-03  1189   * be queued for the stable mode that we're in, either FC or Ethernet.
78112e5558064cb Joe Eykholt       2009-11-03  1190   *
78112e5558064cb Joe Eykholt       2009-11-03  1191   * Called without fnic_lock held.
78112e5558064cb Joe Eykholt       2009-11-03  1192   */
7ea34b1ffb4e1aa Hannes Reinecke   2024-01-30  1193  void fnic_flush_tx(struct work_struct *work)
78112e5558064cb Joe Eykholt       2009-11-03 @1194  {
7ea34b1ffb4e1aa Hannes Reinecke   2024-01-30  1195  	struct fnic *fnic = container_of(work, struct fnic, flush_work);
78112e5558064cb Joe Eykholt       2009-11-03  1196  	struct sk_buff *skb;
78112e5558064cb Joe Eykholt       2009-11-03  1197  	struct fc_frame *fp;
5df6d737dd4b0fe Abhijeet Joglekar 2009-04-17  1198  
d9e9ab56b687da0 Brian Uchino      2010-04-09  1199  	while ((skb = skb_dequeue(&fnic->tx_queue))) {
78112e5558064cb Joe Eykholt       2009-11-03  1200  		fp = (struct fc_frame *)skb;
78112e5558064cb Joe Eykholt       2009-11-03  1201  		fnic_send_frame(fnic, fp);
78112e5558064cb Joe Eykholt       2009-11-03  1202  	}
78112e5558064cb Joe Eykholt       2009-11-03  1203  }
5df6d737dd4b0fe Abhijeet Joglekar 2009-04-17  1204  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

