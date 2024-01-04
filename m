Return-Path: <linux-kernel+bounces-17088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868FB82481E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872521C24390
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC80128E31;
	Thu,  4 Jan 2024 18:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKVvv4uF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8F628E25;
	Thu,  4 Jan 2024 18:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E172C433CA;
	Thu,  4 Jan 2024 18:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704392573;
	bh=u3B6/+lm72/ITMFg7Rjba0K4aQIqSJxhOwedS+gphmo=;
	h=From:To:Cc:Subject:Date:From;
	b=NKVvv4uF3M787gPt2BtLPimo9aRGBW+9AXt/4O3vb+6vFtHPoMXC9Nu3WM/IP0hKI
	 vQ/P6VHEpHdFIKDOIBsZBEdvvzx8Cid2QNRr4RlRKBe0Q6EXKPcvtl6DIb0LYqYZB3
	 yhHxyJzkAo5T/oEtlhT2CIOTMc+IjudfRjlhNAveoUrQRllS0KQpYfJ43xrwUU1wiK
	 VmUtlkBIVp1yT6IewnzueU6pBHDM5UV60Fn8oY+wxg4UX9Xoo1wWFGctEgAAHeu1vs
	 zHzJhjfwWUssyn/zGpdk+IC8BsTXZVUgeVOPELuPEpChkl354kwNa7tqJHUmW7bo6N
	 kkg1v2dDbjyLg==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.7-rc9
Date: Thu,  4 Jan 2024 10:22:52 -0800
Message-ID: <20240104182252.1963951-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

We haven't accumulated much over the break. If it wasn't for
the uninterrupted stream of fixes for Intel drivers this PR
would be very slim. There was a handful of user reports, however,
either they stood out because of the lower traffic or users
have had more time to test over the break. The ones which are
v6.7-relevant should be wrapped up.

There is one problem in a driver which "the other Linus" is working on.
The bug went into -rc1 as a fix, and made its way to stable already.
The device documentation is lacking so it's taking a bit long to
zero in on the exact solution. The device is old and not one of
the very popular ones, plus we seem to be close to a fix which will
satisfy all use cases, so IMHO no need to wait or rush it. But here's
the latest posting if you'd like to take a look and judge it yourself:
https://lore.kernel.org/all/20240102-new-gemini-ethernet-regression-v5-0-cf61ab3aa8cd@linaro.org/

The following changes since commit 7c5e046bdcb2513f9decb3765d8bf92d604279cf:

  Merge tag 'net-6.7-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-12-21 09:15:37 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.7-rc9

for you to fetch changes up to 4c8530dc7d7da4abe97d65e8e038ce9852491369:

  net/tcp: Only produce AO/MD5 logs if there are any keys (2024-01-04 09:07:04 -0800)

----------------------------------------------------------------
Including fixes from wireless and netfilter.

Current release - regressions:

 - Revert "net: ipv6/addrconf: clamp preferred_lft to the minimum
   required", it caused issues on networks where routers send prefixes
   with preferred_lft=0

 - wifi:
   - iwlwifi: pcie: don't synchronize IRQs from IRQ, prevent deadlock
   - mac80211: fix re-adding debugfs entries during reconfiguration

Current release - new code bugs:

 - tcp: print AO/MD5 messages only if there are any keys

Previous releases - regressions:

 - virtio_net: fix missing dma unmap for resize, prevent OOM

Previous releases - always broken:

 - mptcp: prevent tcp diag from closing listener subflows

 - nf_tables:
   - set transport header offset for egress hook, fix IPv4 mangling
   - skip set commit for deleted/destroyed sets, avoid double deactivation

 - nat: make sure action is set for all ct states, fix openvswitch
   matching on ICMP packets in related state

 - eth: mlxbf_gige: fix receive hang under heavy traffic

 - eth: r8169: fix PCI error on system resume for RTL8168FP

 - net: add missing getsockopt(SO_TIMESTAMPING_NEW) and cmsg handling

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Adrian Cinal (1):
      net: bcmgenet: Fix FCS generation for fragmented skbuffs

Alex Henrie (1):
      Revert "net: ipv6/addrconf: clamp preferred_lft to the minimum required"

Alexander Lobakin (1):
      idpf: fix corrupted frames and skb leaks in singleq mode

Andrii Staikov (1):
      i40e: Restore VF MSI-X state during PCI reset

Arkadiusz Kubalewski (1):
      ice: dpll: fix phase offset value

Benjamin Berg (2):
      wifi: mac80211: do not re-add debugfs entries during resume
      wifi: mac80211: add/remove driver debugfs entries as appropriate

Brad Cowie (1):
      netfilter: nf_nat: fix action not being set for all ct states

Chen Ni (1):
      asix: Add check for usbnet_get_endpoints

Claudiu Beznea (1):
      net: ravb: Wait for operating mode to be applied

David S. Miller (3):
      Merge branch 'nfc-refcounting'
      Merge tag 'wireless-2023-12-19' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge tag 'nf-23-12-20' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

David Thompson (1):
      mlxbf_gige: fix receive packet race condition

Dinghao Liu (1):
      net/qla3xxx: fix potential memleak in ql_alloc_buffer_queues

Dmitry Safonov (2):
      net/tcp_sigpool: Use kref_get_unless_zero()
      net/tcp: Only produce AO/MD5 logs if there are any keys

Hangbin Liu (1):
      selftests: bonding: do not set port down when adding to bond

Hangyu Hua (1):
      net: sched: em_text: fix possible memory leak in em_text_destroy()

Jakub Kicinski (6):
      Merge branch 'mptcp-new-reviewer-and-prevent-a-warning'
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'nf-24-01-03' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue

Johannes Berg (1):
      wifi: iwlwifi: pcie: don't synchronize IRQs from IRQ

Jörn-Thorben Hinz (1):
      net: Implement missing getsockopt(SO_TIMESTAMPING_NEW)

Kai-Heng Feng (1):
      r8169: Fix PCI error on system resume

Katarzyna Wieczerzycka (1):
      ice: Fix link_down_on_close message

Ke Xiao (1):
      i40e: fix use-after-free in i40e_aqc_add_filters()

Kurt Kanzenbach (3):
      igc: Report VLAN EtherType matching back to user
      igc: Check VLAN TCI mask
      igc: Check VLAN EtherType mask

Lukas Bulwahn (1):
      MAINTAINERS: wifi: brcm80211: remove non-existing SHA-cyfmac-dev-list@infineon.com

Marc Dionne (1):
      net: Save and restore msg_namelen in sock_sendmsg

Marcin Wojtas (1):
      MAINTAINERS: Update mvpp2 driver email

Matthieu Baerts (1):
      MAINTAINERS: add Geliang as reviewer for MPTCP

Michael Chan (1):
      bnxt_en: Remove mis-applied code from bnxt_cfg_ntp_filters()

Naveen Mamindlapalli (2):
      octeontx2-af: Always configure NIX TX link credits based on max frame size
      octeontx2-af: Re-enable MAC TX in otx2_stop processing

Ngai-Mint Kwan (1):
      ice: Shut down VSI with "link-down-on-close" enabled

Pablo Neira Ayuso (3):
      netfilter: nf_tables: set transport offset from mac header for netdev/egress
      netfilter: nf_tables: skip set commit for deleted/destroyed sets
      netfilter: nft_immediate: drop chain reference counter on error

Paolo Abeni (1):
      mptcp: prevent tcp diag from closing listener subflows

Paul Greenwalt (1):
      ice: fix Get link status data length

Pavan Kumar Linga (1):
      idpf: avoid compiler introduced padding in virtchnl2_rss_key struct

Radu Pirea (NXP OSS) (1):
      MAINTAINERS: step down as TJA11XX C45 maintainer

Randy Dunlap (1):
      net: phy: linux/phy.h: fix Excess kernel-doc description warning

Rodrigo Cataldo (1):
      igc: Fix hicredit calculation

Sagi Maimon (1):
      ptp: ocp: fix bug in unregistering the DPLL subsystem

Sarannya S (1):
      net: qrtr: ns: Return 0 if server port is not present

Siddh Raman Pant (2):
      nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to llcp_local
      nfc: Do not send datagram if socket state isn't LLCP_BOUND

Sudheer Mogilappagari (1):
      i40e: Fix filter input checks to prevent config with invalid values

Suman Ghosh (1):
      octeontx2-af: Fix marking couple of structure as __packed

Thomas Lange (1):
      net: Implement missing SO_TIMESTAMPING_NEW cmsg support

Wen Gu (1):
      net/smc: fix invalid link access in dumping SMC-R connections

Xuan Zhuo (1):
      virtio_net: fix missing dma unmap for resize

Zhipeng Lu (1):
      sfc: fix a double-free bug in efx_probe_filters

wangkeqi (1):
      connector: Fix proc_event_num_listeners count not cleared

 Documentation/networking/ip-sysctl.rst             |   2 +-
 MAINTAINERS                                        |   6 +-
 drivers/connector/cn_proc.c                        |   5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   4 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  11 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  34 +++++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   3 +
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |   3 +-
 drivers/net/ethernet/intel/ice/ice_common.c        |   4 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  12 ++-
 .../net/ethernet/intel/idpf/idpf_singleq_txrx.c    |   1 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |   2 +-
 drivers/net/ethernet/intel/idpf/virtchnl2.h        |   6 +-
 drivers/net/ethernet/intel/igc/igc.h               |   1 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |  42 +++++++-
 drivers/net/ethernet/intel/igc/igc_tsn.c           |   2 +-
 drivers/net/ethernet/marvell/octeontx2/af/npc.h    |   4 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |  17 +++
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    | 118 ++-------------------
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c   |   9 +-
 drivers/net/ethernet/qlogic/qla3xxx.c              |   2 +
 drivers/net/ethernet/realtek/r8169_main.c          |   2 +-
 drivers/net/ethernet/renesas/ravb_main.c           |  65 ++++++++----
 drivers/net/ethernet/sfc/rx_common.c               |   4 +-
 drivers/net/usb/ax88172a.c                         |   4 +-
 drivers/net/virtio_net.c                           |  60 +++++------
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |   8 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  17 +--
 drivers/ptp/ptp_ocp.c                              |   2 +-
 include/linux/phy.h                                |   1 -
 include/net/netfilter/nf_tables_ipv4.h             |   2 +-
 include/net/tcp.h                                  |   2 -
 include/net/tcp_ao.h                               |  26 ++++-
 net/core/sock.c                                    |  12 ++-
 net/ipv4/tcp_sigpool.c                             |   5 +-
 net/ipv6/addrconf.c                                |  18 +---
 net/mac80211/debugfs_netdev.c                      |   9 +-
 net/mac80211/driver-ops.c                          |  14 ++-
 net/mptcp/subflow.c                                |  13 +++
 net/netfilter/nf_nat_ovs.c                         |   3 +-
 net/netfilter/nf_tables_api.c                      |   2 +-
 net/netfilter/nf_tables_core.c                     |   2 +-
 net/netfilter/nft_immediate.c                      |   2 +-
 net/nfc/llcp_core.c                                |  39 ++++++-
 net/nfc/llcp_sock.c                                |   5 +
 net/qrtr/ns.c                                      |   4 +-
 net/sched/em_text.c                                |   4 +-
 net/smc/smc_diag.c                                 |   3 +-
 net/socket.c                                       |   2 +
 .../net/bonding/bond-arp-interval-causes-panic.sh  |   6 +-
 53 files changed, 373 insertions(+), 260 deletions(-)

