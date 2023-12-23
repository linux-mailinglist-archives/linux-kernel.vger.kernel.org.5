Return-Path: <linux-kernel+bounces-10215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B4881D159
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E492850D1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085691109;
	Sat, 23 Dec 2023 02:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YKtzgLR/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE7C1FB0;
	Sat, 23 Dec 2023 02:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300284; x=1734836284;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=97pO/YlarLZGpmpMeSstT9cUYD1KWSch4pdQIvRSQLc=;
  b=YKtzgLR/sn3KujLES3RwGIhEneMGLrm8+gpxTkmENBgjiq48zny2bFdK
   9ZCUAAdhMftQHtZqYKsrpQS0bm56LmNVMvp1/rOrk1uce2XDmFO8fMcMQ
   pCTvNNaYn5VWth4opu6Py254X9rW/kB/6+vltK1KDgBzQxMZYiY/0YrNz
   soXadQqWEMwndRetPQmHxh9WCKjJPMNb0OCUJ2RcfVQFb7IdJcG/1wxL6
   luaCFmDvvm2ToArLQcDa53eXTDn58ZpQsv4G5OfhQxwIIpbwV28lIN6Nj
   nJWtAS2pFeWc4WiAiZMV2k4pJx9XDKgp0oSvybnKIQd5QZk7Z3+6pNOpU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386610752"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386610752"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:58:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537368"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:58:00 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next 00/34] Christmas 3-serie XDP for idpf (+generic stuff)
Date: Sat, 23 Dec 2023 03:55:20 +0100
Message-ID: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I was highly asked to send this WIP before the holidays to trigger
some discussions at least for the generic parts.

This all depends on libie[0] and WB-on-ITR fix[1]. The RFC does not
guarantee to work perfectly, but at least regular XDP seems to work
for me...

In fact, here are 3 separate series:
* 01-08: convert idpf to libie and make it more sane;
* 09-25: add XDP to idpf;
* 26-34: add XSk to idpf.

Most people may want to be interested only in the following generic
changes:
* 11: allow attaching already registered memory models to XDP RxQ info;
* 12-13: generic helpers for adding a frag to &xdp_buff and converting
  it to an skb;
* 14: get rid of xdp_frame::mem.id, allow mixing pages from different
  page_pools within one &xdp_buff/&xdp_frame;
* 15: some Page Pool helper;
* 18: it's for libie, but I wanted to talk about XDP_TX bulking;
* 26: same as 13, but for converting XSK &xdp_buff to skb.

The rest is up to you, driver-specific stuff is pretty boring sometimes.

I'll be polishing and finishing this all starting January 3rd and then
preparing and sending sane series, some early feedback never hurts tho.

Merry Yule!

[0] https://lore.kernel.org/netdev/20231213112835.2262651-1-aleksander.lobakin@intel.com
[1] https://lore.kernel.org/netdev/20231215193721.425087-1-michal.kubiak@intel.com

Alexander Lobakin (23):
  idpf: reuse libie's definitions of parsed ptype structures
  idpf: pack &idpf_queue way more efficiently
  idpf: remove legacy Page Pool Ethtool stats
  libie: support different types of buffers for Rx
  idpf: convert header split mode to libie + napi_build_skb()
  idpf: use libie Rx buffer management for payload buffer
  libie: add Tx buffer completion helpers
  idpf: convert to libie Tx buffer completion
  bpf, xdp: constify some bpf_prog * function arguments
  xdp: constify read-only arguments of some static inline helpers
  xdp: allow attaching already registered memory model to xdp_rxq_info
  xdp: add generic xdp_buff_add_frag()
  xdp: add generic xdp_build_skb_from_buff()
  xdp: get rid of xdp_frame::mem.id
  page_pool: add inline helper to sync VA for device (for XDP_TX)
  jump_label: export static_key_slow_{inc,dec}_cpuslocked()
  libie: support native XDP and register memory model
  libie: add a couple of XDP helpers
  idpf: stop using macros for accessing queue descriptors
  idpf: use generic functions to build xdp_buff and skb
  idpf: add support for XDP on Rx
  idpf: add support for .ndo_xdp_xmit()
  xdp: add generic XSk xdp_buff -> skb conversion

Michal Kubiak (11):
  idpf: make complq cleaning dependent on scheduling mode
  idpf: prepare structures to support xdp
  idpf: implement XDP_SETUP_PROG in ndo_bpf for splitq
  idpf: add support for sw interrupt
  idpf: add relative queue id member to idpf_queue
  idpf: add vc functions to manage selected queues
  idpf: move search rx and tx queues to header
  idpf: add XSk pool initialization
  idpf: implement Tx path for AF_XDP
  idpf: implement Rx path for AF_XDP
  idpf: enable XSk features and ndo_xsk_wakeup

 .../net/ethernet/freescale/dpaa/dpaa_eth.c    |    2 +-
 drivers/net/ethernet/intel/Kconfig            |    3 +-
 drivers/net/ethernet/intel/idpf/Makefile      |    3 +
 drivers/net/ethernet/intel/idpf/idpf.h        |   91 +-
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |    3 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   74 +-
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |    6 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   40 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |    1 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  221 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 1142 ++++++++--------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  451 +++----
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |    3 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1132 ++++++++++------
 drivers/net/ethernet/intel/idpf/idpf_xdp.c    |  522 ++++++++
 drivers/net/ethernet/intel/idpf/idpf_xdp.h    |   38 +
 drivers/net/ethernet/intel/idpf/idpf_xsk.c    | 1181 +++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_xsk.h    |   30 +
 drivers/net/ethernet/intel/libie/Makefile     |    3 +
 drivers/net/ethernet/intel/libie/rx.c         |  135 +-
 drivers/net/ethernet/intel/libie/tx.c         |   16 +
 drivers/net/ethernet/intel/libie/xdp.c        |   50 +
 drivers/net/ethernet/intel/libie/xsk.c        |   49 +
 drivers/net/veth.c                            |    4 +-
 include/linux/bpf.h                           |   12 +-
 include/linux/filter.h                        |    9 +-
 include/linux/net/intel/libie/rx.h            |   25 +-
 include/linux/net/intel/libie/tx.h            |   94 ++
 include/linux/net/intel/libie/xdp.h           |  586 ++++++++
 include/linux/net/intel/libie/xsk.h           |  172 +++
 include/linux/netdevice.h                     |    6 +-
 include/linux/skbuff.h                        |   14 +-
 include/net/page_pool/helpers.h               |   32 +
 include/net/page_pool/types.h                 |    6 +-
 include/net/xdp.h                             |  109 +-
 kernel/bpf/cpumap.c                           |    2 +-
 kernel/bpf/devmap.c                           |    8 +-
 kernel/jump_label.c                           |    2 +
 net/bpf/test_run.c                            |    6 +-
 net/core/dev.c                                |    8 +-
 net/core/filter.c                             |   27 +-
 net/core/page_pool.c                          |   31 +-
 net/core/xdp.c                                |  189 ++-
 43 files changed, 4971 insertions(+), 1567 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_xdp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_xdp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_xsk.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_xsk.h
 create mode 100644 drivers/net/ethernet/intel/libie/tx.c
 create mode 100644 drivers/net/ethernet/intel/libie/xdp.c
 create mode 100644 drivers/net/ethernet/intel/libie/xsk.c
 create mode 100644 include/linux/net/intel/libie/tx.h
 create mode 100644 include/linux/net/intel/libie/xdp.h
 create mode 100644 include/linux/net/intel/libie/xsk.h

-- 
2.43.0


