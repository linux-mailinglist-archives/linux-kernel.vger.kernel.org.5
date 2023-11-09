Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A727E711A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344917AbjKISFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjKISFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:05:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667E33A92
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 10:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699553132; x=1731089132;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w2xMOD9zLy3iS6KSJtJyM0ifiw0lD0LQGechUu0FUEo=;
  b=hBOAdwkJI6a3nHc6E5a5wKKtmbEIqgsynkEEPQ7J4HohyaiYPXl+u17q
   d7TFTE/S0yS+kCYnJpyvAZ+a+j0zy9m7uF8LIgogv0SGR8cVBAFNaIRWO
   S6EmmFxPDP6yg7zD87p527dZt8EvQ+C6U62N0baQkSD84c1pYluOTzs0n
   mQcODRVPl/PQ+Fi2Q/bSTzb+GhRVjFMN7h73Rqc1fUtTG0ZgjxwjJq9bL
   QVNEVzKNbqVkBmiFDDlC9+/5d0RIfuYTxzG5E8gFL64A3JYYIn0vp2RT5
   C8kfUUqSxwqRqFVijfES8VW5yPkJDX/3gB4okY42QRgPt3ym5RJHoFYpm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="3075032"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="3075032"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 10:05:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="887085856"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="887085856"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Nov 2023 10:05:29 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r19PD-000925-0R;
        Thu, 09 Nov 2023 18:05:27 +0000
Date:   Fri, 10 Nov 2023 02:04:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: drivers/nvme/target/tcp.c:1773:27: sparse: sparse: cast to
 restricted __le32
Message-ID: <202311100256.Y1eZwPhd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bc986ab839c844e78a2333a02e55f02c9e57935
commit: 70525e5d82f62407d8436aa2a6c3385829ab5a3e nvmet-tcp: peek icreq before starting TLS
date:   4 weeks ago
config: loongarch-randconfig-r112-20231109 (https://download.01.org/0day-ci/archive/20231110/202311100256.Y1eZwPhd-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231110/202311100256.Y1eZwPhd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311100256.Y1eZwPhd-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/target/tcp.c:1773:27: sparse: sparse: cast to restricted __le32

vim +1773 drivers/nvme/target/tcp.c

  1731	
  1732	#ifdef CONFIG_NVME_TARGET_TCP_TLS
  1733	static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue)
  1734	{
  1735		struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
  1736		int len, ret;
  1737		struct kvec iov = {
  1738			.iov_base = (u8 *)&queue->pdu + queue->offset,
  1739			.iov_len = sizeof(struct nvme_tcp_hdr),
  1740		};
  1741		char cbuf[CMSG_LEN(sizeof(char))] = {};
  1742		struct msghdr msg = {
  1743			.msg_control = cbuf,
  1744			.msg_controllen = sizeof(cbuf),
  1745			.msg_flags = MSG_PEEK,
  1746		};
  1747	
  1748		if (nvmet_port_secure_channel_required(queue->port->nport))
  1749			return 0;
  1750	
  1751		len = kernel_recvmsg(queue->sock, &msg, &iov, 1,
  1752				iov.iov_len, msg.msg_flags);
  1753		if (unlikely(len < 0)) {
  1754			pr_debug("queue %d: peek error %d\n",
  1755				 queue->idx, len);
  1756			return len;
  1757		}
  1758	
  1759		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
  1760		if (ret < 0)
  1761			return ret;
  1762	
  1763		if (len < sizeof(struct nvme_tcp_hdr)) {
  1764			pr_debug("queue %d: short read, %d bytes missing\n",
  1765				 queue->idx, (int)iov.iov_len - len);
  1766			return -EAGAIN;
  1767		}
  1768		pr_debug("queue %d: hdr type %d hlen %d plen %d size %d\n",
  1769			 queue->idx, hdr->type, hdr->hlen, hdr->plen,
  1770			 (int)sizeof(struct nvme_tcp_icreq_pdu));
  1771		if (hdr->type == nvme_tcp_icreq &&
  1772		    hdr->hlen == sizeof(struct nvme_tcp_icreq_pdu) &&
> 1773		    hdr->plen == (__le32)sizeof(struct nvme_tcp_icreq_pdu)) {
  1774			pr_debug("queue %d: icreq detected\n",
  1775				 queue->idx);
  1776			return len;
  1777		}
  1778		return 0;
  1779	}
  1780	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
