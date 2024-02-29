Return-Path: <linux-kernel+bounces-87459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AD686D4AC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648CE1C21844
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3754914BD76;
	Thu, 29 Feb 2024 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvh+rRNn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1700114AD2A;
	Thu, 29 Feb 2024 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239163; cv=none; b=WrSVKFoJ8rC/6x3KappEeqzTDVw6UBkvTnF7uXbGz2qxtq8/S7DJxrQ3n0HkL85GUlpkqrJlwQFFdfLqMtbSmTl/CMN8xB/BTSRWunK5vhkxIYfeTU3Pz5gRuFHYpxYCaUONjmTczStAutDY2z+piWuOedq1DLpEoQXlt45usTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239163; c=relaxed/simple;
	bh=UcED50uCufTBvu/GGCLavtLLeZ66BNIbmhyN6yVGq/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YfdZuv9lP18F68AHNvIoO7Am9SCUvJxdRNuM/Pp+ZLd6/MFmh6V2TxeJ63B+aThfdnlA92r1cqk7nSteGFfgFnYzNnonq7OZMzHbgX2wkA3mzr6UC5W5npBI4sXo6+qN2fHmoCqH6AZ6UBxdA8/I3JvafAijgmTfE0T8ijX+/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvh+rRNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB62C433C7;
	Thu, 29 Feb 2024 20:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239162;
	bh=UcED50uCufTBvu/GGCLavtLLeZ66BNIbmhyN6yVGq/E=;
	h=From:To:Cc:Subject:Date:From;
	b=dvh+rRNnNW1NCX7g1J1r4nd5THpXyP35J4318uD0rm1paoT0TZKVECRM6Yi7YiBIX
	 lhQNDZJWSPhP93bMe02zrv6tYASiYo42jILhhkTb2TSEAaqiI84+huJr2snj8GUcdV
	 IS2h7LNRcJShWwRYocaEIFm3jfhfrSOEucSA9I7nqi8z26nrVl9rB0P4bR4IMekqZS
	 Q8dXChg1mnMpQ0M73gaCWhqq/ynAquEOLMQ58ulHes6iK6vobHiIOg2Oget25GkIIc
	 IlaU8he3bh+AmWd5fzuHeGeI4zO+DmOFLm9HiQr7hmuxFoX6wlu3FnisotQeXvX/Mu
	 x0XDJTRcSACUg==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.8-rc7
Date: Thu, 29 Feb 2024 12:39:21 -0800
Message-ID: <20240229203921.3037023-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

A few hours late, the commit on top fixes an odd "rcu_dereference()
needs to know full type" build issue I can't repro..

The following changes since commit 6714ebb922ab15a209dfc3c1ed29d4bb0abc9f02:

  Merge tag 'net-6.8.0-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-02-22 09:57:58 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8-rc7

for you to fetch changes up to 640f41ed33b5a420e05daf395afae85e6b20c003:

  dpll: fix build failure due to rcu_dereference_check() on unknown type (2024-02-29 12:18:37 -0800)

----------------------------------------------------------------
Including fixes from bluetooth, WiFi and netfilter.

We have one outstanding issue with the stmmac driver, which may
be a LOCKDEP false positive, not a blocker.

Current release - regressions:

 - netfilter: nf_tables: re-allow NFPROTO_INET in
   nft_(match/target)_validate()

 - eth: ionic: fix error handling in PCI reset code

Current release - new code bugs:

 - eth: stmmac: complete meta data only when enabled, fix null-deref

 - kunit: fix again checksum tests on big endian CPUs

Previous releases - regressions:

 - veth: try harder when allocating queue memory

 - Bluetooth:
   - hci_bcm4377: do not mark valid bd_addr as invalid
   - hci_event: fix handling of HCI_EV_IO_CAPA_REQUEST

Previous releases - always broken:

 - info leak in __skb_datagram_iter() on netlink socket

 - mptcp:
   - map v4 address to v6 when destroying subflow
   - fix potential wake-up event loss due to sndbuf auto-tuning
   - fix double-free on socket dismantle

 - wifi: nl80211: reject iftype change with mesh ID change

 - fix small out-of-bound read when validating netlink be16/32 types

 - rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS writing back

 - ipv6: fix potential "struct net" ref-leak in inet6_rtm_getaddr()

 - ip_tunnel: prevent perpetual headroom growth with huge number of
   tunnels on top of each other

 - mctp: fix skb leaks on error paths of mctp_local_output()

 - eth: ice: fixes for DPLL state reporting

 - dpll: rely on rcu for netdev_dpll_pin() to prevent UaF

 - eth: dpaa: accept phy-interface-type = "10gbase-r" in the device tree

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alexander Ofitserov (1):
      gtp: fix use-after-free and null-ptr-deref in gtp_newlink()

Amritha Nambiar (1):
      ice: Fix ASSERT_RTNL() warning during certain scenarios

Andre Werner (1):
      net: smsc95xx: add support for SYS TEC USB-SPEmodule1

Arkadiusz Kubalewski (4):
      ice: fix dpll input pin phase_adjust value updates
      ice: fix dpll and dpll_pin data access on PF reset
      ice: fix dpll periodic work data updates on PF reset
      ice: fix pin phase adjust updates on PF reset

Benjamin Berg (1):
      wifi: iwlwifi: mvm: ensure offloading TID queue exists

Christophe Leroy (1):
      kunit: Fix again checksum tests on big endian CPUs

Davide Caratti (1):
      mptcp: fix double-free on socket dismantle

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: fix the TXF mapping for BZ devices

Eric Dumazet (3):
      ipv6: fix potential "struct net" leak in inet6_rtm_getaddr()
      dpll: rely on rcu for netdev_dpll_pin()
      dpll: fix build failure due to rcu_dereference_check() on unknown type

Felix Fietkau (1):
      wifi: mac80211: only call drv_sta_rc_update for uploaded stations

Florian Westphal (4):
      netlink: add nla be16/32 types to minlen array
      net: ip_tunnel: prevent perpetual headroom growth
      netfilter: bridge: confirm multicast packets before passing them up the stack
      selftests: netfilter: add bridge conntrack + multicast test case

Frédéric Danis (1):
      Bluetooth: mgmt: Fix limited discoverable off timeout

Geliang Tang (3):
      mptcp: map v4 address to v6 when destroying subflow
      selftests: mptcp: rm subflow with v4/v4mapped addr
      selftests: mptcp: join: add ss mptcp support check

Geoff Levand (1):
      ps3/gelic: Fix SKB allocation

Haiyue Wang (1):
      Documentations: correct net_cachelines title for struct inet_sock

Ignat Korchagin (1):
      netfilter: nf_tables: allow NFPROTO_INET in nft_(match/target)_validate()

Jakub Kicinski (9):
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      net: veth: clear GRO when clearing XDP even when down
      selftests: net: veth: test syncing GRO and XDP state while device is down
      Merge branch 'mptcp-more-misc-fixes-for-v6-8'
      veth: try harder when allocating queue memory
      Merge tag 'wireless-2024-02-27' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      tools: ynl: fix handling of multiple mcast groups
      Merge branch 'tls-a-few-more-fixes-for-async-decrypt'
      Merge tag 'for-net-2024-02-28' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth

Jakub Raczynski (1):
      stmmac: Clear variable when destroying workqueue

Janaki Ramaiah Thota (1):
      Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT

Javier Carrasco (1):
      net: usb: dm9601: fix wrong return value in dm9601_mdio_read

Jeff Johnson (2):
      MAINTAINERS: wifi: update Jeff Johnson e-mail address
      MAINTAINERS: wifi: Add N: ath1*k entries to match .yaml files

Jeremy Kerr (1):
      net: mctp: take ownership of skb in mctp_local_output

Johan Hovold (1):
      Bluetooth: hci_bcm4377: do not mark valid bd_addr as invalid

Johannes Berg (1):
      wifi: nl80211: reject iftype change with mesh ID change

Jonas Dreßler (1):
      Bluetooth: hci_sync: Check the correct flag before starting a scan

Justin Iurman (1):
      uapi: in6: replace temporary label with rfc9486

Kai-Heng Feng (1):
      Bluetooth: Enforce validation on max value of connection interval

Kurt Kanzenbach (1):
      net: stmmac: Complete meta data only when enabled

Lin Ma (1):
      rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS writing back

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix accept_list when attempting to suspend
      Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST

Lukasz Majewski (2):
      net: hsr: Fix typo in the hsr_forward_do() function comment
      net: hsr: Use correct offset for HSR TLV values in supervisory HSR frames

Matthieu Baerts (NGI0) (1):
      mptcp: avoid printing warning once on client side

Oleksij Rempel (3):
      lan78xx: enable auto speed configuration for LAN7850 if no EEPROM is detected
      net: lan78xx: fix "softirq work is pending" error
      igb: extend PTP timestamp adjustments to i211

Paolo Abeni (7):
      mptcp: push at DSS boundaries
      mptcp: fix snd_wnd initialization for passive socket
      mptcp: fix potential wake-up event loss
      mptcp: fix possible deadlock in subflow diag
      selftests: mptcp: explicitly trigger the listener diag code-path
      Merge branch 'ionic-pci-error-handling-fixes'
      Merge tag 'nf-24-02-29' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Randy Dunlap (1):
      net: ethernet: adi: move PHYLIB from vendor to driver symbol

Ryosuke Yasuoka (1):
      netlink: Fix kernel-infoleak-after-free in __skb_datagram_iter

Sabrina Dubroca (4):
      tls: decrement decrypt_pending if no async completion will be called
      tls: fix peeking with sync+async decryption
      tls: separate no-async decryption request handling from async
      tls: fix use-after-free on failed backlog decryption

Shannon Nelson (3):
      ionic: check before releasing pci regions
      ionic: check cmd_regs before copying in or out
      ionic: restore netdev feature bits after reset

Vladimir Oltean (1):
      net: dpaa: fman_memac: accept phy-interface-type = "10gbase-r" in the device tree

Ying Hsu (1):
      Bluetooth: Avoid potential use-after-free in hci_error_reset

Yochai Hagvi (1):
      ice: fix connection state of DPLL and out pin

Yunjian Wang (1):
      tun: Fix xdp_rxq_info's queue_index when detaching

Yuxuan Hu (1):
      Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security

Zijun Hu (3):
      Bluetooth: hci_event: Fix wrongly recorded wakeup BD_ADDR
      Bluetooth: qca: Fix wrong event type for patch config command
      Bluetooth: qca: Fix triggering coredump implementation

 .../networking/net_cachelines/inet_sock.rst        |   6 +-
 MAINTAINERS                                        |  11 +-
 drivers/bluetooth/btqca.c                          |   2 +-
 drivers/bluetooth/hci_bcm4377.c                    |   3 +-
 drivers/bluetooth/hci_qca.c                        |  22 ++-
 drivers/dpll/dpll_core.c                           |   7 +-
 drivers/dpll/dpll_core.h                           |   2 +
 drivers/net/ethernet/adi/Kconfig                   |   2 +-
 drivers/net/ethernet/freescale/fman/fman_memac.c   |  18 +-
 drivers/net/ethernet/intel/ice/ice_base.c          |  10 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c          |  91 ++++++++--
 drivers/net/ethernet/intel/ice/ice_lib.c           |  88 ++++++++--
 drivers/net/ethernet/intel/ice/ice_lib.h           |  10 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |   3 +-
 drivers/net/ethernet/intel/igb/igb_ptp.c           |   5 +-
 .../net/ethernet/pensando/ionic/ionic_bus_pci.c    |  15 +-
 drivers/net/ethernet/pensando/ionic/ionic_dev.c    |  10 ++
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |   7 +-
 drivers/net/ethernet/pensando/ionic/ionic_fw.c     |   5 +
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |   5 +-
 drivers/net/ethernet/pensando/ionic/ionic_main.c   |   3 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   7 +-
 drivers/net/ethernet/toshiba/ps3_gelic_net.c       |  12 +-
 drivers/net/gtp.c                                  |  12 +-
 drivers/net/tun.c                                  |   1 +
 drivers/net/usb/dm9601.c                           |   2 +-
 drivers/net/usb/lan78xx.c                          |   5 +-
 drivers/net/usb/smsc95xx.c                         |   5 +
 drivers/net/veth.c                                 |  40 ++---
 drivers/net/wireless/intel/iwlwifi/fw/api/txq.h    |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |  11 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |  28 +++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |   3 +-
 include/linux/dpll.h                               |  11 ++
 include/linux/netdevice.h                          |  11 +-
 include/linux/netfilter.h                          |   1 +
 include/net/mctp.h                                 |   1 +
 include/uapi/linux/in6.h                           |   2 +-
 lib/checksum_kunit.c                               |  17 +-
 lib/nlattr.c                                       |   4 +
 net/bluetooth/hci_core.c                           |   7 +-
 net/bluetooth/hci_event.c                          |  13 +-
 net/bluetooth/hci_sync.c                           |   7 +-
 net/bluetooth/l2cap_core.c                         |   8 +-
 net/bluetooth/mgmt.c                               |   4 +-
 net/bluetooth/rfcomm/core.c                        |   2 +-
 net/bridge/br_netfilter_hooks.c                    |  96 +++++++++++
 net/bridge/netfilter/nf_conntrack_bridge.c         |  30 ++++
 net/core/dev.c                                     |   2 +-
 net/core/rtnetlink.c                               |  11 +-
 net/hsr/hsr_forward.c                              |   4 +-
 net/ipv4/ip_tunnel.c                               |  28 ++-
 net/ipv6/addrconf.c                                |   7 +-
 net/mac80211/rate.c                                |   3 +-
 net/mctp/route.c                                   |  10 +-
 net/mptcp/diag.c                                   |   3 +
 net/mptcp/options.c                                |   2 +-
 net/mptcp/pm_userspace.c                           |  10 ++
 net/mptcp/protocol.c                               |  52 +++++-
 net/mptcp/protocol.h                               |  21 +--
 net/netfilter/nf_conntrack_core.c                  |   1 +
 net/netfilter/nft_compat.c                         |  20 +++
 net/netlink/af_netlink.c                           |   2 +-
 net/tls/tls_sw.c                                   |  40 +++--
 net/wireless/nl80211.c                             |   2 +
 tools/net/ynl/lib/ynl.c                            |   1 +
 tools/testing/selftests/net/mptcp/diag.sh          |  30 +++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  33 ++--
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |   4 +-
 tools/testing/selftests/net/veth.sh                |  14 ++
 tools/testing/selftests/netfilter/Makefile         |   3 +-
 .../selftests/netfilter/bridge_netfilter.sh        | 188 +++++++++++++++++++++
 74 files changed, 974 insertions(+), 211 deletions(-)
 create mode 100644 tools/testing/selftests/netfilter/bridge_netfilter.sh

