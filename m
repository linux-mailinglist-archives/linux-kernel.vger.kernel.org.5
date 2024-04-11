Return-Path: <linux-kernel+bounces-140539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4330A8A15F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87F49B27301
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AF4153BE8;
	Thu, 11 Apr 2024 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1R5VjJt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E508215350D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842753; cv=none; b=bdQgKrBhLwr+ubPH8AsLY6nD0fQOhlHfZuXQwD276me8lBvuv7ICUF0M/MDGjLa96wJozVFJE+m3cER72UceqnjUH2zZBZ0KF+OtC5oNFI6w+IYYiakQiMovFSbsQ7Fw+O0qYsm/N9xmSeOb79zY4mDvh4KiGa85KmB3+AuuU+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842753; c=relaxed/simple;
	bh=gl/TZqKhNlPxbhhYj+dqKK2EeNBanNdavqsbonWFKfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KEVTju85eU/A95bF+7I1NltC2ozC0V7GN7kf8ktMnRyEPJ1ZE/a+aaWIUlvNvKeAWvjzco2NBNYnRRzZyIic/89NrCVrNpVC2u3K3xJnXjIuZlxkTA1qmWx5gNA2LOe/dZFOxqHhrrqWqCRwvlDW3daWGnhMHRP3/umODdP0+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1R5VjJt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712842749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=41m65qlnX/Xth1Xt2o246aE/MD66qa6i29VrrYDMYZI=;
	b=e1R5VjJtU2ImPrqbtRcaHkKCLMyYbWNfEyUEyiTPDnUNe10OOSQ/r+9nVrkpJ4dPMowDqt
	KgfoXme2S2l3CBOnuYGNPokoydw58eRuiBG7se+5gXnqH0ohFe0QlfUHrpS7nnPQwGdQFQ
	KXU5YqZEuZRql1jAdGolg7Xk1FNW6fw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-JYx1QNnMOEyX9ixn4l7YIg-1; Thu, 11 Apr 2024 09:39:06 -0400
X-MC-Unique: JYx1QNnMOEyX9ixn4l7YIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4878410499A2;
	Thu, 11 Apr 2024 13:39:05 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E40753C21;
	Thu, 11 Apr 2024 13:39:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.9-rc4
Date: Thu, 11 Apr 2024 15:38:37 +0200
Message-ID: <20240411133837.86880-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Hi Linus!

The following changes since commit c88b9b4cde17aec34fb9bfaf69f9f72a1c44f511:

  Merge tag 'net-6.9-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-04-04 14:49:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.9-rc4

for you to fetch changes up to 4e1ad31ce3205d9400816e08cf14b7c96295d22e:

  Merge branch 'ena-driver-bug-fixes' (2024-04-11 11:21:05 +0200)

----------------------------------------------------------------
Including fixes from bluetooth.

Current release - new code bugs:

  - netfilter: complete validation of user input

  - mlx5: disallow SRIOV switchdev mode when in multi-PF netdev

Previous releases - regressions:

  - core: fix u64_stats_init() for lockdep when used repeatedly in one file

  - ipv6: fix race condition between ipv6_get_ifaddr and ipv6_del_addr

  - bluetooth: fix memory leak in hci_req_sync_complete()

  - batman-adv: avoid infinite loop trying to resize local TT

  - drv: geneve: fix header validation in geneve[6]_xmit_skb

  - drv: bnxt_en: fix possible memory leak in bnxt_rdma_aux_device_init()

  - drv: mlx5: offset comp irq index in name by one

  - drv: ena: avoid double-free clearing stale tx_info->xdpf value

  - drv: pds_core: fix pdsc_check_pci_health deadlock

Previous releases - always broken:

  - xsk: validate user input for XDP_{UMEM|COMPLETION}_FILL_RING

  - bluetooth: fix setsockopt not validating user input

  - af_unix: clear stale u->oob_skb.

  - nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies

  - drv: virtio_net: fix guest hangup on invalid RSS update

  - drv: mlx5e: Fix mlx5e_priv_init() cleanup flow

  - dsa: mt7530: trap link-local frames regardless of ST Port State

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Archie Pusaka (1):
      Bluetooth: l2cap: Don't double set the HCI_CONN_MGMT_CONNECTED bit

Arnd Bergmann (4):
      lib: checksum: hide unused expected_csum_ipv6_magic[]
      ipv6: fib: hide unused 'pn' variable
      ipv4/route: avoid unused-but-set-variable warning
      net/mlx5: fix possible stack overflows

Arınç ÜNAL (2):
      net: dsa: mt7530: fix enabling EEE on MT7531 switch on all boards
      net: dsa: mt7530: trap link-local frames regardless of ST Port State

Breno Leitao (1):
      virtio_net: Do not send RSS key if it is not supported

Brett Creeley (1):
      pds_core: Fix pdsc_check_pci_health function to use work thread

Carolina Jubran (4):
      net/mlx5e: RSS, Block changing channels number when RXFH is configured
      net/mlx5e: Fix mlx5e_priv_init() cleanup flow
      net/mlx5e: HTB, Fix inconsistencies with QoS SQs number
      net/mlx5e: RSS, Block XOR hash with over 128 channels

Cosmin Ratiu (2):
      net/mlx5: Properly link new fs rules into the tree
      net/mlx5: Correctly compare pkt reformat ids

Daniel Machon (1):
      net: sparx5: fix wrong config being used when reconfiguring PCS

David Arinzon (4):
      net: ena: Fix potential sign extension issue
      net: ena: Wrong missing IO completions check order
      net: ena: Fix incorrect descriptor free behavior
      net: ena: Set tx_info->xdpf value to NULL

David S. Miller (3):
      Merge tag 'batadv-net-pullrequest-20240405' of git://git.open-mesh.org/linux-merge
      Merge branch 'bnxt_en-fixes'
      Merge branch 'stmmac-missing-stats-DW-GMAC'

Dmitry Antipov (1):
      Bluetooth: Fix memory leak in hci_req_sync_complete()

Eric Dumazet (6):
      xsk: validate user input for XDP_{UMEM|COMPLETION}_FILL_RING
      geneve: fix header validation in geneve[6]_xmit_skb
      net: add copy_safe_from_sockptr() helper
      mISDN: fix MISDN_TIME_STAMP handling
      nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies
      netfilter: complete validation of user input

Geetha sowjanya (1):
      octeontx2-af: Fix NIX SQ mode and BP config

Gerd Bayer (2):
      s390/ism: fix receive message buffer allocation
      Revert "s390/ism: fix receive message buffer allocation"

Hariprasad Kelam (1):
      octeontx2-pf: Fix transmit scheduler resource leak

Heiner Kallweit (2):
      r8169: fix LED-related deadlock on module removal
      r8169: add missing conditional compiling for call to r8169_remove_leds

Ilya Maximets (1):
      net: openvswitch: fix unwanted error log on timeout policy probing

Jakub Kicinski (2):
      Merge branch 'net-start-to-replace-copy_from_sockptr'
      Merge branch 'mlx5-misc-fixes'

Jiri Benc (1):
      ipv6: fix race condition between ipv6_get_ifaddr and ipv6_del_addr

Kuniyuki Iwashima (1):
      af_unix: Clear stale u->oob_skb.

Luiz Augusto von Dentz (7):
      Bluetooth: ISO: Don't reject BT_ISO_QOS if parameters are unset
      Bluetooth: hci_sync: Fix using the same interval and window for Coded PHY
      Bluetooth: SCO: Fix not validating setsockopt user input
      Bluetooth: RFCOMM: Fix not validating setsockopt user input
      Bluetooth: L2CAP: Fix not validating setsockopt user input
      Bluetooth: ISO: Fix not validating setsockopt user input
      Bluetooth: hci_sock: Fix not validating setsockopt user input

Marek Vasut (2):
      net: ks8851: Inline ks8851_rx_skb()
      net: ks8851: Handle softirqs at the end of IRQ thread to fix hang

Michael Liang (1):
      net/mlx5: offset comp irq index in name by one

Michal Luczaj (1):
      af_unix: Fix garbage collector racing against connect()

Minda Chen (2):
      net: stmmac: mmc_core: Add GMAC LPI statistics
      net: stmmac: mmc_core: Add GMAC mmc tx/rx missing statistics

Paolo Abeni (2):
      Merge tag 'for-net-2024-04-10' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'ena-driver-bug-fixes'

Pavan Chebbi (1):
      bnxt_en: Reset PTP tx_avail after possible firmware reset

Petr Tesarik (1):
      u64_stats: fix u64_stats_init() for lockdep when used repeatedly in one file

Rahul Rameshbabu (1):
      net/mlx5e: Do not produce metadata freelist entries in Tx port ts WQE xmit

Shay Drory (2):
      net/mlx5: E-switch, store eswitch pointer before registering devlink_param
      net/mlx5: Register devlink first under devlink lock

Sven Eckelmann (1):
      batman-adv: Avoid infinite loop trying to resize local TT

Tariq Toukan (1):
      net/mlx5: Disallow SRIOV switchdev mode when in multi-PF netdev

Uwe Kleine-König (1):
      MAINTAINERS: Drop Li Yang as their email address stopped working

Vikas Gupta (2):
      bnxt_en: Fix possible memory leak in bnxt_rdma_aux_device_init()
      bnxt_en: Fix error recovery for RoCE ulp client

 MAINTAINERS                                        |  11 +-
 drivers/isdn/mISDN/socket.c                        |  10 +-
 drivers/net/dsa/mt7530.c                           | 246 +++++++++++++++++----
 drivers/net/dsa/mt7530.h                           |   6 +
 drivers/net/ethernet/amazon/ena/ena_com.c          |   2 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |  35 ++-
 drivers/net/ethernet/amazon/ena/ena_xdp.c          |   4 +-
 drivers/net/ethernet/amd/pds_core/core.c           |  13 +-
 drivers/net/ethernet/amd/pds_core/core.h           |   2 +
 drivers/net/ethernet/amd/pds_core/dev.c            |   3 +
 drivers/net/ethernet/amd/pds_core/main.c           |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |   6 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  20 +-
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c   |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h   |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c   |  33 +--
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c   |   7 +
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h   |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/selq.c  |   2 +
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  45 +++-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   2 -
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |   7 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   9 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  11 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  17 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  37 ++--
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |   4 +-
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c    |   1 -
 .../ethernet/mellanox/mlx5/core/steering/dr_dbg.c  |  82 +++----
 drivers/net/ethernet/micrel/ks8851.h               |   3 -
 drivers/net/ethernet/micrel/ks8851_common.c        |  16 +-
 drivers/net/ethernet/micrel/ks8851_par.c           |  11 -
 drivers/net/ethernet/micrel/ks8851_spi.c           |  11 -
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |   4 +-
 drivers/net/ethernet/realtek/r8169.h               |   6 +-
 drivers/net/ethernet/realtek/r8169_leds.c          |  35 ++-
 drivers/net/ethernet/realtek/r8169_main.c          |   9 +-
 drivers/net/ethernet/stmicro/stmmac/mmc.h          |   2 +
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c     |  15 ++
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   2 +
 drivers/net/geneve.c                               |   4 +-
 drivers/net/virtio_net.c                           |  26 ++-
 include/linux/sockptr.h                            |  25 +++
 include/linux/u64_stats_sync.h                     |   9 +-
 include/net/addrconf.h                             |   4 +
 include/net/bluetooth/bluetooth.h                  |   9 +
 include/net/ip_tunnels.h                           |  33 +++
 lib/checksum_kunit.c                               |   5 +-
 net/batman-adv/translation-table.c                 |   2 +-
 net/bluetooth/hci_request.c                        |   4 +-
 net/bluetooth/hci_sock.c                           |  21 +-
 net/bluetooth/hci_sync.c                           |   6 +-
 net/bluetooth/iso.c                                |  46 ++--
 net/bluetooth/l2cap_core.c                         |   3 +-
 net/bluetooth/l2cap_sock.c                         |  52 ++---
 net/bluetooth/rfcomm/sock.c                        |  14 +-
 net/bluetooth/sco.c                                |  23 +-
 net/ipv4/netfilter/arp_tables.c                    |   4 +
 net/ipv4/netfilter/ip_tables.c                     |   4 +
 net/ipv4/route.c                                   |   4 +-
 net/ipv6/addrconf.c                                |   7 +-
 net/ipv6/ip6_fib.c                                 |   7 +-
 net/ipv6/netfilter/ip6_tables.c                    |   4 +
 net/nfc/llcp_sock.c                                |  12 +-
 net/openvswitch/conntrack.c                        |   5 +-
 net/unix/af_unix.c                                 |   4 +-
 net/unix/garbage.c                                 |  18 +-
 net/xdp/xsk.c                                      |   2 +
 69 files changed, 743 insertions(+), 356 deletions(-)


