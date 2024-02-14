Return-Path: <linux-kernel+bounces-64747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D3785423A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDE5282CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63B3C153;
	Wed, 14 Feb 2024 05:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMre4pUM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5749DC121
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 05:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707886997; cv=none; b=rU+yp/MmhjV150MzmUU0nf7GK0Mw90P5fpvMQeVNEABzfDXIYd6h8TsHeCYZr0TB4UDzb7HP5dOpL3zidFRhDf6gYogEmv9MgIFM449PJthzbUabvhDwIDKtPMgwN5kLzrK9Zp2tm9V7s3xv3/9L03ZLA/L/yEpTg/xTjVgeSVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707886997; c=relaxed/simple;
	bh=/xHws/G9bHCaleMZO8eW/k7iIx8FUIMQh3NqaGQ76+g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WjB4braMUdxF4kHPqzHWxyizwehw5nJxg7Xu9L+B5ulX5IgP37BpvHbxLw+rIX7TirQkvyWaxk8/yXuC1BY5DDV/rIG3eVaV1t1MeeLmBsD84RGiBmUd79omlvbkXI6ysOeR8JaWig+NIO5jyJPbewXRm8Q7tIldC7Fr/OosJhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMre4pUM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707886995; x=1739422995;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/xHws/G9bHCaleMZO8eW/k7iIx8FUIMQh3NqaGQ76+g=;
  b=dMre4pUMtWSMAt2Sp+N4S99YLPfrmJ+SD8EtkQC2J4n8rLVuvT3x/VE1
   uD4z4/5JKdMcdYzfkx1V+IbUeid+DIk8jdYbA0Zo1tNzQj7GHVgMCwNxd
   7udbhGO9VLg0HMchvHTozx8WaVE3Hr9RAAwHIhgX9aRND5vRX1EqHXiar
   lbnIoptPtmO5OaN9YPKodnFmT1QpMiSrQxF1mCL6Co/8xGI5CmCWxLDAV
   yL2Iqk/T5vmfAWCR1+dZwMms9hcVz2MdCroWR7wK4YqEntBsvWASiNTMe
   /YMTmn2t/U7h3Yrf7zgqUOPV3Wn2XdD7dNXCQmEmWxrsXr0a10pnQq/pi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="12640673"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="12640673"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 21:03:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="7744447"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 13 Feb 2024 21:03:13 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ra7QM-0008To-1h;
	Wed, 14 Feb 2024 05:03:10 +0000
Date: Wed, 14 Feb 2024 13:02:31 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: pcap-dbus.o:undefined reference to `dbus_message_demarshal'
Message-ID: <202402141220.du4OnWhF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7e90b5c295ec1e47c8ad865429f046970c549a66
commit: 10f4c9b9a33b7df000f74fa0d896351fb1a61e6a x86/asm: Fix build of UML with KASAN
date:   5 months ago
config: um-randconfig-002-20240213 (https://download.01.org/0day-ci/archive/20240214/202402141220.du4OnWhF-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240214/202402141220.du4OnWhF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402141220.du4OnWhF-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_write':
>> pcap-dbus.o:(.text+0x247ff): undefined reference to `dbus_message_demarshal'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24815): undefined reference to `dbus_connection_send'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x2481e): undefined reference to `dbus_connection_flush'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24826): undefined reference to `dbus_message_unref'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24874): undefined reference to `dbus_error_free'
   /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_read':
>> pcap-dbus.o:(.text+0x248c0): undefined reference to `dbus_connection_pop_message'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x248e2): undefined reference to `dbus_connection_pop_message'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x248f8): undefined reference to `dbus_connection_read_write'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24962): undefined reference to `dbus_message_is_signal'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x2497e): undefined reference to `dbus_message_marshal'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x249e6): undefined reference to `dbus_free'
   /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_cleanup':
>> pcap-dbus.o:(.text+0x24a4c): undefined reference to `dbus_connection_unref'
   /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_activate':
>> pcap-dbus.o:(.text+0x24af6): undefined reference to `dbus_connection_open'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24b0e): undefined reference to `dbus_bus_register'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24bfc): undefined reference to `dbus_bus_add_match'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24c04): undefined reference to `dbus_error_is_set'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24c4b): undefined reference to `dbus_bus_get'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24c7c): undefined reference to `dbus_error_free'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24c8d): undefined reference to `dbus_bus_add_match'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24c95): undefined reference to `dbus_error_is_set'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24cce): undefined reference to `dbus_error_free'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24cda): undefined reference to `dbus_connection_unref'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24d06): undefined reference to `dbus_bus_get'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24d42): undefined reference to `dbus_error_free'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24d55): undefined reference to `dbus_connection_set_max_received_size'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24d66): undefined reference to `dbus_connection_unref'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24ddc): undefined reference to `dbus_error_free'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24e1a): undefined reference to `dbus_error_free'
>> collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

