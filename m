Return-Path: <linux-kernel+bounces-37989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD72E83B957
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7181F24D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49E91097B;
	Thu, 25 Jan 2024 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3UCW1q/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36357D533
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706162432; cv=none; b=KBHLTiX2USa9ZeIxdqZRQ5g83+XWe5RSm3SR1/GMSeVnuutiBJG6q3WeVU3a4p06MHJdEj9rL7wyBbuh1/XjHjtRAoNbZVdQa2JKBE5SjdUg8oFbSLNF/pUHxloHPn+pbZ5Xau3fEjRV+vEWNG13ja6dYqX8f8jQHneQfYjIdsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706162432; c=relaxed/simple;
	bh=3lodQRCPmp7mKyG56AS3ewvIJIEBZ4t8IlIjCbIpl3M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WyXM/3ivgKEKP6oLDGVTa0+nuPGJrHy2TIp7hanC9hPBOeORlBBY/4fna4O6h9p2wN62XzVZZWFzt2pNDHzke9sD4vsg3Tqnxnsfjvwk74+ksMnKzokdLJM4R3xRidjl7ycg8yWPUrI6HuPUvYJn7yz2PM5gpvHqUAv2l8rioI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3UCW1q/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706162430; x=1737698430;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3lodQRCPmp7mKyG56AS3ewvIJIEBZ4t8IlIjCbIpl3M=;
  b=W3UCW1q/df8aBI0bUaGyBt6CZZs897RXPLs1yBxRVokZRp39MzqFqVwo
   uaO/J5W8znoUYLLX8wDGeL5UAxI7ktzcRo35paeBl/RW/xoL8BuKx7ZfQ
   mZLLGPSy42ACagsTkNSvtV3+dy/PUkPyGfNT9jYUUcEJIODnPMMYWfSxo
   357RdHlu9W9RydO8aAyh9IV+8UX18EKqdAvS+luxbIMD8MrBzca3AmjT6
   EAtQEYVUwH9mo0JIVIY2NxfOJi2BldUlB6VZVaDCXOfw8aoxyqf1lGUgs
   H1rkKtwN9LjgH4d6oZswCPysPsLkJkQfpnrdNnolohgTGXsifHwnL2b4r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1913837"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1913837"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 22:00:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="820693470"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="820693470"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2024 22:00:26 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rSsmm-0008l7-1W;
	Thu, 25 Jan 2024 06:00:24 +0000
Date: Thu, 25 Jan 2024 14:00:09 +0800
From: kernel test robot <lkp@intel.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>
Subject: drivers/net/wireless/realtek/rtw89/pci.c:211:5-8: Unneeded variable:
 "cnt". Return "  1" on line 273
Message-ID: <202401251333.zQQf7lDL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6098d87eaf31f48153c984e2adadf14762520a87
commit: 7ba49f4c6896d83b3841c0b046a0a7b1e97cc0dd rtw89: 8852c: add 8852ce to Makefile and Kconfig
date:   1 year, 9 months ago
config: parisc-randconfig-r053-20240114 (https://download.01.org/0day-ci/archive/20240125/202401251333.zQQf7lDL-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401251333.zQQf7lDL-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/net/wireless/realtek/rtw89/pci.c:211:5-8: Unneeded variable: "cnt". Return "  1" on line 273

vim +211 drivers/net/wireless/realtek/rtw89/pci.c

e3ec7017f6a20d Ping-Ke Shih 2021-10-11  200  
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  201  static u32 rtw89_pci_rxbd_deliver_skbs(struct rtw89_dev *rtwdev,
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  202  				       struct rtw89_pci_rx_ring *rx_ring)
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  203  {
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  204  	struct rtw89_pci_dma_ring *bd_ring = &rx_ring->bd_ring;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  205  	struct rtw89_pci_rx_info *rx_info;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  206  	struct rtw89_rx_desc_info *desc_info = &rx_ring->diliver_desc;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  207  	struct sk_buff *new = rx_ring->diliver_skb;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  208  	struct sk_buff *skb;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  209  	u32 rxinfo_size = sizeof(struct rtw89_pci_rxbd_info);
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  210  	u32 offset;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11 @211  	u32 cnt = 1;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  212  	bool fs, ls;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  213  	int ret;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  214  
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  215  	skb = rx_ring->buf[bd_ring->wp];
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  216  	rtw89_pci_sync_skb_for_cpu(rtwdev, skb);
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  217  
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  218  	ret = rtw89_pci_rxbd_info_update(rtwdev, skb);
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  219  	if (ret) {
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  220  		rtw89_err(rtwdev, "failed to update %d RXBD info: %d\n",
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  221  			  bd_ring->wp, ret);
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  222  		goto err_sync_device;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  223  	}
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  224  
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  225  	rx_info = RTW89_PCI_RX_SKB_CB(skb);
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  226  	fs = rx_info->fs;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  227  	ls = rx_info->ls;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  228  
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  229  	if (fs) {
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  230  		if (new) {
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  231  			rtw89_err(rtwdev, "skb should not be ready before first segment start\n");
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  232  			goto err_sync_device;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  233  		}
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  234  		if (desc_info->ready) {
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  235  			rtw89_warn(rtwdev, "desc info should not be ready before first segment start\n");
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  236  			goto err_sync_device;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  237  		}
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  238  
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  239  		rtw89_core_query_rxdesc(rtwdev, desc_info, skb->data, rxinfo_size);
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  240  
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  241  		new = dev_alloc_skb(desc_info->pkt_size);
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  242  		if (!new)
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  243  			goto err_sync_device;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  244  
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  245  		rx_ring->diliver_skb = new;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  246  
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  247  		/* first segment has RX desc */
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  248  		offset = desc_info->offset;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  249  		offset += desc_info->long_rxdesc ? sizeof(struct rtw89_rxdesc_long) :
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  250  			  sizeof(struct rtw89_rxdesc_short);
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  251  	} else {
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  252  		offset = sizeof(struct rtw89_pci_rxbd_info);
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  253  		if (!new) {
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  254  			rtw89_warn(rtwdev, "no last skb\n");
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  255  			goto err_sync_device;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  256  		}
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  257  	}
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  258  	if (!rtw89_skb_put_rx_data(rtwdev, fs, ls, new, skb, offset, rx_info, desc_info))
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  259  		goto err_sync_device;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  260  	rtw89_pci_sync_skb_for_device(rtwdev, skb);
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  261  	rtw89_pci_rxbd_increase(rx_ring, 1);
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  262  
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  263  	if (!desc_info->ready) {
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  264  		rtw89_warn(rtwdev, "no rx desc information\n");
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  265  		goto err_free_resource;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  266  	}
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  267  	if (ls) {
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  268  		rtw89_core_rx(rtwdev, desc_info, new);
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  269  		rx_ring->diliver_skb = NULL;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  270  		desc_info->ready = false;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  271  	}
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  272  
e3ec7017f6a20d Ping-Ke Shih 2021-10-11 @273  	return cnt;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  274  
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  275  err_sync_device:
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  276  	rtw89_pci_sync_skb_for_device(rtwdev, skb);
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  277  	rtw89_pci_rxbd_increase(rx_ring, 1);
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  278  err_free_resource:
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  279  	if (new)
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  280  		dev_kfree_skb_any(new);
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  281  	rx_ring->diliver_skb = NULL;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  282  	desc_info->ready = false;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  283  
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  284  	return cnt;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  285  }
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  286  

:::::: The code at line 211 was first introduced by commit
:::::: e3ec7017f6a20d12ddd9fe23d345ebb7b8c104dd rtw89: add Realtek 802.11ax driver

:::::: TO: Ping-Ke Shih <pkshih@realtek.com>
:::::: CC: Kalle Valo <kvalo@codeaurora.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

