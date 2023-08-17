Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECF37800E5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355686AbjHQWMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355745AbjHQWLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:11:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296CC3AB0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:11:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B863B667A0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 22:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B6FC433C7;
        Thu, 17 Aug 2023 22:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692310290;
        bh=xYkc9kOTCIcKeJ+8XW4auGZeMtraRnqcSt+nuDUw4HQ=;
        h=From:To:Cc:Subject:Date:From;
        b=bv6RTULYWvWSGgSFuVY4zIo7zIpF1+qyvDrZJqpu/LzsqRjKFxyI8znvYl/bc8C+l
         oDMSL3NCHjH0CnnPOXHH/ZBWSGiZK4vYNydZHqw5tNf09yhMrhW2kbeSTC2ntxQFMQ
         Lu5WKmYRM0TOV+0fpHxvMBBMW/p3+atl/tspXyjh+KBaHC8MSix56Jrt1PwuMVeEcF
         rnG6WKnGbyOXty9mSPaQ1yQKF/whG8FFnP7eKtY9esww3yX2PgnZLIAGMHSX1PXqLD
         Y1lWj8QFItqExZ5zZ6oXqBdqd9EdnpMB0R072Cm9BcpmJG4ZRutESMwa0VEgBbsAXc
         8ra6pjwMgifHg==
From:   Jakub Kicinski <kuba@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.5-rc7
Date:   Thu, 17 Aug 2023 15:11:29 -0700
Message-ID: <20230817221129.1014945-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

The diffstat is a little massaged here, it's generated from the merge
of x86/bugs, I merged x86/bugs on top of our previous merge point, and
you already have those, so I _think_ this is exactly the diffstat
you'll see when pulling..

The following changes since commit 9ebbb29db9cae23e29881b9a268767d4baa53cdb:

  Merge branch 'x86/bugs' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2023-08-10 18:18:25 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc7

for you to fetch changes up to 820a38d8f2cb3a749ffb7bbde206acec9a387411:

  Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue (2023-08-17 14:35:34 -0700)

----------------------------------------------------------------
Including fixes from ipsec and netfilter.

No known outstanding regressions.

Fixes to fixes:

 - virtio-net: set queues after driver_ok, avoid a potential race
   added by recent fix

 - Revert "vlan: Fix VLAN 0 memory leak", it may lead to a warning
   when VLAN 0 is registered explicitly

 - nf_tables:
   - fix false-positive lockdep splat in recent fixes
   - don't fail inserts if duplicate has expired (fix test failures)
   - fix races between garbage collection and netns dismantle

Current release - new code bugs:

 - mlx5: Fix mlx5_cmd_update_root_ft() error flow

Previous releases - regressions:

 - phy: fix IRQ-based wake-on-lan over hibernate / power off

Previous releases - always broken:

 - sock: fix misuse of sk_under_memory_pressure() preventing system
   from exiting global TCP memory pressure if a single cgroup is under
   pressure

 - fix the RTO timer retransmitting skb every 1ms if linear option
   is enabled

 - af_key: fix sadb_x_filter validation, amment netlink policy

 - ipsec: fix slab-use-after-free in decode_session6()

 - macb: in ZynqMP resume always configure PS GTR for non-wakeup source

Misc:

 - netfilter: set default timeout to 3 secs for sctp shutdown send and
   recv state (from 300ms), align with protocol timers

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Abel Wu (1):
      sock: Fix misuse of sk_under_memory_pressure()

Alfred Lee (1):
      net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset

Andrii Staikov (1):
      i40e: fix misleading debug logs

Artem Chernyshev (1):
      broadcom: b44: Use b44_writephy() return value

David S. Miller (2):
      Merge tag 'ipsec-2023-08-15' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge tag 'nf-23-08-16' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Dragos Tatulea (1):
      net/mlx5e: XDP, Fix fifo overrun on XDP_REDIRECT

Edward Cree (2):
      sfc: don't unregister flow_indr if it was never registered
      sfc: don't fail probe if MAE/TC setup fails

Eric Dumazet (1):
      net: do not allow gso_size to be set to GSO_BY_FRAGS

Florian Westphal (4):
      netfilter: nf_tables: fix false-positive lockdep splat
      netfilter: nf_tables: fix kdoc warnings after gc rework
      netfilter: nf_tables: deactivate catchall elements in next generation
      netfilter: nf_tables: don't fail inserts if duplicate has expired

Herbert Xu (1):
      xfrm: Silence warnings triggerable by bad packets

Jakub Kicinski (4):
      Merge branch 'octeon_ep-fixes-for-error-and-remove-paths'
      net: openvswitch: reject negative ifindex
      Merge tag 'mlx5-fixes-2023-08-16' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue

Jason Wang (1):
      virtio-net: set queues after driver_ok

Jason Xing (1):
      net: fix the RTO timer retransmitting skb every 1ms if linear option is enabled

Justin Chen (1):
      net: phy: broadcom: stub c45 read/write for 54810

Leon Romanovsky (2):
      xfrm: delete offloaded policy
      xfrm: don't skip free of empty state in acquire policy

Liang Chen (1):
      net: veth: Page pool creation error handling for existing pools only

Lin Ma (5):
      net: xfrm: Fix xfrm_address_filter OOB read
      net: af_key: fix sadb_x_filter validation
      net: xfrm: Amend XFRMA_SEC_CTX nla_policy structure
      xfrm: add NULL check in xfrm_update_ae_params
      xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH

Manish Chopra (1):
      qede: fix firmware halt over suspend and resume

Marcin Szycik (1):
      ice: Block switchdev mode when ADQ is active and vice versa

Michal Schmidt (4):
      octeon_ep: fix timeout value for waiting on mbox response
      octeon_ep: cancel tx_timeout_task later in remove sequence
      octeon_ep: cancel ctrl_mbox_task after intr_poll_task
      octeon_ep: cancel queued works in probe error path

Pablo Neira Ayuso (3):
      netfilter: nf_tables: fix GC transaction races with netns and netlink event exit path
      netfilter: nf_tables: GC transaction race with netns dismantle
      netfilter: nft_dynset: disallow object maps

Petr Machata (1):
      selftests: mirror_gre_changes: Tighten up the TTL test match

Piotr Gardocki (1):
      iavf: fix FDIR rule fields masks validation

Prasad Pandit (1):
      ipv6: fix indentation of a config attribute

Radhey Shyam Pandey (1):
      net: macb: In ZynqMP resume always configure PS GTR for non-wakeup source

Russell King (Oracle) (1):
      net: phy: fix IRQ-based wake-on-lan over hibernate / power off

Shay Drory (1):
      net/mlx5: Fix mlx5_cmd_update_root_ft() error flow

Simon Horman (1):
      mailmap: add entries for Simon Horman

Sishuai Gong (1):
      ipvs: fix racy memcpy in proc_do_sync_threshold

Vlad Buslov (1):
      Revert "vlan: Fix VLAN 0 memory leak"

Xiang Yang (1):
      net: pcs: Add missing put_device call in miic_create

Xin Long (1):
      netfilter: set default timeout to 3 secs for sctp shutdown send and recv state

Zhengchao Shao (3):
      xfrm: fix slab-use-after-free in decode_session6
      ip6_vti: fix slab-use-after-free in decode_session6
      ip_vti: fix potential slab-use-after-free in decode_session6

Ziyang Xuan (1):
      team: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves

 .mailmap                                           |  2 +
 Documentation/networking/nf_conntrack-sysctl.rst   |  4 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |  8 +++
 drivers/net/ethernet/broadcom/b44.c                |  8 +--
 drivers/net/ethernet/cadence/macb_main.c           |  9 ++-
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         | 16 ++---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     | 10 +++
 drivers/net/ethernet/intel/iavf/iavf_fdir.c        | 77 ++++++++++++++++++++--
 drivers/net/ethernet/intel/iavf/iavf_fdir.h        |  2 +
 drivers/net/ethernet/intel/ice/ice_eswitch.c       |  6 ++
 drivers/net/ethernet/intel/ice/ice_main.c          |  5 ++
 .../ethernet/marvell/octeon_ep/octep_ctrl_net.c    |  2 +-
 .../net/ethernet/marvell/octeon_ep/octep_main.c    |  9 +--
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h   |  2 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  8 ++-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   | 10 ++-
 drivers/net/ethernet/qlogic/qede/qede_main.c       | 10 +++
 drivers/net/ethernet/sfc/ef100_nic.c               |  2 +-
 drivers/net/ethernet/sfc/tc.c                      |  2 +-
 drivers/net/pcs/pcs-rzn1-miic.c                    | 10 ++-
 drivers/net/phy/broadcom.c                         | 13 ++++
 drivers/net/phy/phy_device.c                       | 13 +---
 drivers/net/team/team.c                            |  4 +-
 drivers/net/veth.c                                 |  3 +-
 drivers/net/virtio_net.c                           |  4 +-
 include/linux/virtio_net.h                         |  4 ++
 include/net/netfilter/nf_tables.h                  |  1 +
 include/net/sock.h                                 |  6 ++
 include/net/xfrm.h                                 |  1 +
 net/8021q/vlan.c                                   |  3 +-
 net/core/sock.c                                    |  2 +-
 net/ipv4/ip_vti.c                                  |  4 +-
 net/ipv4/tcp_timer.c                               |  4 +-
 net/ipv6/Kconfig                                   |  2 +-
 net/ipv6/ip6_vti.c                                 |  4 +-
 net/key/af_key.c                                   |  4 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |  4 ++
 net/netfilter/nf_conntrack_proto_sctp.c            |  6 +-
 net/netfilter/nf_tables_api.c                      | 44 +++++++++++--
 net/netfilter/nft_dynset.c                         |  3 +
 net/netfilter/nft_set_pipapo.c                     | 38 +++++------
 net/openvswitch/datapath.c                         |  8 +--
 net/xfrm/xfrm_compat.c                             |  2 +-
 net/xfrm/xfrm_input.c                              | 22 +++----
 net/xfrm/xfrm_interface_core.c                     |  4 +-
 net/xfrm/xfrm_state.c                              |  8 +--
 net/xfrm/xfrm_user.c                               | 15 ++++-
 .../selftests/net/forwarding/mirror_gre_changes.sh |  3 +-
 48 files changed, 313 insertions(+), 118 deletions(-)
