Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC3F7BA8F8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjJESVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjJESVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:21:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B81593
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:21:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86497C433C7;
        Thu,  5 Oct 2023 18:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696530101;
        bh=Uwwu4K2VHWoS/fvXuZ3uyl1hDi62Ly3JMsYML8fabKs=;
        h=From:To:Cc:Subject:Date:From;
        b=A3MO/418N5mS9G862Vp1Itg6zStzh0iQGmUcsvCrR6jDSkas5h1Yud0zvclR60eQh
         /mjTdnpoSa76LHCueUCk3+rX/NVKJ5Y03EH1UnWyU84F+QOQfmR0j1cAp6FyjH6bcV
         CShABBC85gfx89yxvH9HOHGeWRkQP6DzA7+PpXv6MadxuWRcS8/Bt5tmIAWiiQsROd
         sn9CeHQZlbVyhz268TLLab9GDijfpfJnXYn+En9UbkeK+q0JNpQHjaM/2cTwo8hzVF
         C2sTBK3QhXgTN0xnxvnZdLeEKtypP0GfJpGN+43Nb2uD9dqkrX0ZD5xpkJed5kfr8a
         OHK/jCZWaYraw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.6-rc5
Date:   Thu,  5 Oct 2023 11:21:40 -0700
Message-ID: <20231005182140.3847567-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

The following changes since commit 27bbf45eae9ca98877a2d52a92a188147cd61b07:

  Merge tag 'net-6.6-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-09-21 11:28:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.6-rc5

for you to fetch changes up to c29d984580212f8a5e75b65c99a745f29511f83a:

  Merge branch 'mptcp-fixes-and-maintainer-email-update-for-v6-6' (2023-10-05 09:34:34 -0700)

----------------------------------------------------------------
Including fixes from Bluetooth, netfilter, BPF and WiFi.

I didn't collect precise data but feels like we've got a lot
of 6.5 fixes here. WiFi fixes are most user-awaited.

Current release - regressions:

 - Bluetooth: fix hci_link_tx_to RCU lock usage

Current release - new code bugs:

 - bpf: mprog: fix maximum program check on mprog attachment

 - eth: ti: icssg-prueth: fix signedness bug in prueth_init_tx_chns()

Previous releases - regressions:

 - ipv6: tcp: add a missing nf_reset_ct() in 3WHS handling

 - vringh: don't use vringh_kiov_advance() in vringh_iov_xfer(),
   it doesn't handle zero length like we expected

 - wifi:
   - cfg80211: fix cqm_config access race, fix crashes with brcmfmac
   - iwlwifi: mvm: handle PS changes in vif_cfg_changed
   - mac80211: fix mesh id corruption on 32 bit systems
   - mt76: mt76x02: fix MT76x0 external LNA gain handling

 - Bluetooth: fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER

 - l2tp: fix handling of transhdrlen in __ip{,6}_append_data()

 - dsa: mv88e6xxx: avoid EEPROM timeout when EEPROM is absent

 - eth: stmmac: fix the incorrect parameter after refactoring

Previous releases - always broken:

 - net: replace calls to sock->ops->connect() with kernel_connect(),
   prevent address rewrite in kernel_bind(); otherwise BPF hooks may
   modify arguments, unexpectedly to the caller

 - tcp: fix delayed ACKs when reads and writes align with MSS

 - bpf:
   - verifier: unconditionally reset backtrack_state masks on global
     func exit
   - s390: let arch_prepare_bpf_trampoline return program size,
     fix struct_ops offsets
   - sockmap: fix accounting of available bytes in presence of PEEKs
   - sockmap: reject sk_msg egress redirects to non-TCP sockets

 - ipv4/fib: send netlink notify when delete source address routes

 - ethtool: plca: fix width of reads when parsing netlink commands

 - netfilter: nft_payload: rebuild vlan header on h_proto access

 - Bluetooth: hci_codec: fix leaking memory of local_codecs

 - eth: intel: ice: always add legacy 32byte RXDID in supported_rxdids

 - eth: stmmac:
   - dwmac-stm32: fix resume on STM32 MCU
   - remove buggy and unneeded stmmac_poll_controller, depend on NAPI

 - ibmveth: always recompute TCP pseudo-header checksum, fix use
   of the driver with Open vSwitch

 - wifi:
   - rtw88: rtw8723d: fix MAC address offset in EEPROM
   - mt76: fix lock dependency problem for wed_lock
   - mwifiex: sanity check data reported by the device
   - iwlwifi: ensure ack flag is properly cleared
   - iwlwifi: mvm: fix a memory corruption due to bad pointer arithm
   - iwlwifi: mvm: fix incorrect usage of scan API

Misc:

 - wifi: mac80211: work around Cisco AP 9115 VHT MPDU length

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aditya Kumar Singh (1):
      wifi: cfg80211: validate AP phy operation before starting it

Alexandra Diupina (1):
      drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()

Alexei Starovoitov (1):
      Merge branch 's390-bpf-fix-arch_prepare_bpf_trampoline'

Andrii Nakryiko (1):
      bpf: unconditionally reset backtrack_state masks on global func exit

Arnd Bergmann (1):
      wifi: iwlwifi: dbg_ini: fix structure packing

Ben Greear (1):
      wifi: iwlwifi: Ensure ack flag is properly cleared.

Ben Wolsieffer (1):
      net: stmmac: dwmac-stm32: fix resume on STM32 MCU

Benjamin Berg (2):
      wifi: cfg80211: avoid leaking stack data into trace
      wifi: mac80211: Create resources for disabled links

Benjamin Poirier (1):
      ipv4: Set offload_failed flag in fibmatch results

Chengfeng Ye (1):
      tipc: fix a potential deadlock on &tx->lock

Christian Marangi (1):
      net: ethernet: mediatek: disable irq before schedule napi

Christophe JAILLET (1):
      wifi: iwlwifi: mvm: Fix a memory corruption issue

Clark Wang (1):
      net: stmmac: platform: fix the incorrect parameter

Dan Carpenter (3):
      net: ethernet: ti: am65-cpsw: Fix error code in am65_cpsw_nuss_init_tx_chns()
      net: ti: icssg-prueth: Fix signedness bug in prueth_init_tx_chns()
      dmaengine: ti: k3-udma-glue: clean up k3_udma_glue_tx_get_irq() return

Daniel Borkmann (2):
      bpf, mprog: Fix maximum program check on mprog attachment
      selftest/bpf: Add various selftests for program limits

David Howells (1):
      ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()

David S. Miller (1):
      Merge tag 'for-net-2023-09-20' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth

David Wilder (1):
      ibmveth: Remove condition to recompute TCP header checksum.

Dinghao Liu (1):
      ptp: ocp: Fix error handling in ptp_ocp_device_init

Eric Dumazet (3):
      net: fix possible store tearing in neigh_periodic_work()
      neighbour: fix data-races around n->output
      netlink: annotate data-races around sk->sk_err

Fabio Estevam (1):
      net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent

Felix Fietkau (2):
      wifi: mac80211: fix mesh id corruption on 32 bit systems
      wifi: mt76: mt76x02: fix MT76x0 external LNA gain handling

Florian Westphal (2):
      netfilter: nft_payload: rebuild vlan header on h_proto access
      netfilter: nf_tables: nft_set_rbtree: fix spurious insertion failure

Geliang Tang (1):
      mptcp: userspace pm allow creating id 0 subflow

Gregory Greenman (1):
      iwlwifi: mvm: handle PS changes in vif_cfg_changed

Gustavo A. R. Silva (4):
      wifi: mwifiex: Fix tlv_buf_left calculation
      wifi: mwifiex: Replace one-element array with flexible-array member in struct mwifiex_ie_types_rxba_sync
      wifi: mwifiex: Sanity check tlv_len and tlv_bitmap_len
      qed/red_ll2: Fix undefined behavior bug in struct qed_ll2_info

Haiyang Zhang (3):
      net: mana: Fix TX CQE error handling
      net: mana: Fix the tso_bytes calculation
      net: mana: Fix oversized sge0 for GSO packets

Hangbin Liu (1):
      ipv4/fib: send notify when delete source address routes

Hou Tao (1):
      bpf: Use kmalloc_size_roundup() to adjust size_index

Ilan Peer (2):
      wifi: cfg80211: Fix 6GHz scan configuration
      wifi: iwlwifi: mvm: Fix incorrect usage of scan API

Ilya Maximets (1):
      ipv6: tcp: add a missing nf_reset_ct() in 3WHS handling

Jakub Kicinski (4):
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge tag 'wireless-2023-09-27' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge tag 'nf-23-10-04' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'mptcp-fixes-and-maintainer-email-update-for-v6-6'

Jakub Sitnicki (1):
      bpf, sockmap: Reject sk_msg egress redirects to non-TCP sockets

Jeff Johnson (1):
      MAINTAINERS: wifi: ath12k: add wiki link

Jeremy Cline (1):
      net: nfc: llcp: Add lock when modifying device list

Johannes Berg (6):
      wifi: cfg80211: fix cqm_config access race
      wifi: cfg80211: add missing kernel-doc for cqm_rssi_work
      rfkill: sync before userspace visibility/changes
      wifi: mac80211: fix potential key use-after-free
      wifi: mac80211: fix potential key leak
      wifi: mac80211: work around Cisco AP 9115 VHT MPDU length

John Fastabend (3):
      bpf: tcp_read_skb needs to pop skb regardless of seq
      bpf, sockmap: Do not inc copied_seq when PEEK flag set
      bpf, sockmap: Add tests for MSG_F_PEEK

Jordan Rife (3):
      net: replace calls to sock->ops->connect() with kernel_connect()
      net: prevent rewrite of msg_name in sock_sendmsg()
      net: prevent address rewrite in kernel_bind()

Juerg Haefliger (1):
      wifi: brcmfmac: Replace 1-element arrays with flexible arrays

Kalle Valo (5):
      MAINTAINERS: wifi: remove generic wiki links from drivers
      MAINTAINERS: wifi: rtlwifi: remove git tree
      MAINTAINERS: wifi: rtl8xxxu: remove git tree
      MAINTAINERS: wifi: wl12xx: remove git tree
      MAINTAINERS: wifi: hostap: remove maintainer and web page

Kees Cook (1):
      sky2: Make sure there is at least one frag_addr available

Leon Hwang (1):
      bpf: Fix tr dereferencing

Lorenzo Bianconi (1):
      wifi: mt76: fix lock dependency problem for wed_lock

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER
      Bluetooth: ISO: Fix handling of listen for unicast
      Bluetooth: hci_core: Fix build warnings
      Bluetooth: hci_codec: Fix leaking content of local_codecs

Matthieu Baerts (1):
      MAINTAINERS: update Matthieu's email address

Michal Schmidt (1):
      ice: always add legacy 32byte RXDID in supported_rxdids

Neal Cardwell (2):
      tcp: fix quick-ack counting to count actual ACKs of new data
      tcp: fix delayed ACKs for MSS boundary condition

Paolo Abeni (2):
      Merge branch 'net-mana-fix-some-tx-processing-bugs'
      mptcp: fix delegated action races

Parthiban Veerasooran (1):
      ethtool: plca: fix plca enable data type while parsing the value

Phil Sutter (2):
      selftests: netfilter: Extend nft_audit.sh
      netfilter: nf_tables: Deduplicate nft_register_obj audit logs

Pin-yen Lin (1):
      wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet

Randy Dunlap (2):
      page_pool: fix documentation typos
      net: lan743x: also select PHYLIB

Remi Pommarel (1):
      net: stmmac: remove unneeded stmmac_poll_controller

Rocky Liao (1):
      Bluetooth: btusb: add shutdown function for QCA6174

Sascha Hauer (1):
      wifi: rtw88: rtw8723d: Fix MAC address offset in EEPROM

Shigeru Yoshida (1):
      net: usb: smsc75xx: Fix uninit-value access in __smsc75xx_read_reg

Song Liu (2):
      s390/bpf: Let arch_prepare_bpf_trampoline return program size
      selftests/bpf: Check bpf_cubic_acked() is called via struct_ops

Stefano Garzarella (1):
      vringh: don't use vringh_kiov_advance() in vringh_iov_xfer()

Wen Gong (2):
      wifi: cfg80211/mac80211: hold link BSSes when assoc fails for MLO connection
      wifi: mac80211: allow transmitting EAPOL frames with tainted key

Xin Long (4):
      netfilter: handle the connecting collision properly in nf_conntrack_proto_sctp
      selftests: netfilter: test for sctp collision processing in nf_conntrack
      sctp: update transport state when processing a dupcook packet
      sctp: update hb timer immediately after users change hb_interval

Yao Xiao (1):
      Bluetooth: Delete unused hci_req_prepare_suspend() declaration

Ying Hsu (2):
      Bluetooth: Fix hci_link_tx_to RCU lock usage
      Bluetooth: Avoid redundant authentication

Yoshihiro Shimoda (1):
      rswitch: Fix PHY station management clock setting

 .mailmap                                           |   1 +
 MAINTAINERS                                        |  12 +-
 arch/s390/net/bpf_jit_comp.c                       |   2 +-
 drivers/bluetooth/btusb.c                          |   1 +
 drivers/dma/ti/k3-udma-glue.c                      |   3 +
 drivers/net/dsa/mv88e6xxx/chip.c                   |   6 +-
 drivers/net/dsa/mv88e6xxx/global1.c                |  31 ---
 drivers/net/dsa/mv88e6xxx/global1.h                |   1 -
 drivers/net/dsa/mv88e6xxx/global2.c                |   2 +-
 drivers/net/dsa/mv88e6xxx/global2.h                |   1 +
 drivers/net/ethernet/ibm/ibmveth.c                 |  25 ++-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |  12 +-
 drivers/net/ethernet/marvell/sky2.h                |   2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   4 +-
 drivers/net/ethernet/microchip/Kconfig             |   1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c      | 219 ++++++++++++++-------
 drivers/net/ethernet/qlogic/qed/qed_ll2.h          |   2 +-
 drivers/net/ethernet/renesas/rswitch.c             |  13 +-
 drivers/net/ethernet/renesas/rswitch.h             |   2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |   7 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  30 ---
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   3 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |   6 +-
 drivers/net/usb/smsc75xx.c                         |   4 +-
 drivers/net/wan/fsl_ucc_hdlc.c                     |  12 +-
 .../broadcom/brcm80211/brcmfmac/fwil_types.h       |   9 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  | 117 +++++------
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   3 +
 .../net/wireless/marvell/mwifiex/11n_rxreorder.c   |  22 ++-
 drivers/net/wireless/marvell/mwifiex/fw.h          |   2 +-
 drivers/net/wireless/marvell/mwifiex/sta_rx.c      |  16 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |   8 +-
 .../net/wireless/mediatek/mt76/mt76x02_eeprom.c    |   7 -
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c |  13 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.h      |   1 +
 drivers/ptp/ptp_ocp.c                              |   1 -
 drivers/vhost/vringh.c                             |  12 +-
 include/linux/bpf.h                                |   2 +-
 include/linux/netfilter/nf_conntrack_sctp.h        |   1 +
 include/net/bluetooth/hci_core.h                   |   2 +-
 include/net/cfg80211.h                             |   6 +-
 include/net/ip_fib.h                               |   1 +
 include/net/mana/mana.h                            |   5 +-
 include/net/neighbour.h                            |   2 +-
 include/net/page_pool/helpers.h                    |   6 +-
 include/net/tcp.h                                  |   6 +-
 kernel/bpf/memalloc.c                              |  44 ++---
 kernel/bpf/mprog.c                                 |   3 +
 kernel/bpf/verifier.c                              |   8 +-
 net/bluetooth/hci_conn.c                           |  63 +++---
 net/bluetooth/hci_core.c                           |  14 +-
 net/bluetooth/hci_event.c                          |   1 +
 net/bluetooth/hci_request.h                        |   2 -
 net/bluetooth/hci_sync.c                           |  14 +-
 net/bluetooth/iso.c                                |   9 +-
 net/bridge/br_netfilter_hooks.c                    |   2 +-
 net/core/neighbour.c                               |  14 +-
 net/core/sock_map.c                                |   4 +
 net/ethtool/plca.c                                 |  45 +++--
 net/ipv4/fib_semantics.c                           |   1 +
 net/ipv4/fib_trie.c                                |   4 +
 net/ipv4/route.c                                   |   2 +
 net/ipv4/tcp.c                                     |  10 +-
 net/ipv4/tcp_bpf.c                                 |   4 +-
 net/ipv4/tcp_input.c                               |  13 ++
 net/ipv4/tcp_output.c                              |   7 +-
 net/ipv6/tcp_ipv6.c                                |  10 +-
 net/l2tp/l2tp_ip6.c                                |   2 +-
 net/mac80211/cfg.c                                 |   6 +-
 net/mac80211/ibss.c                                |   2 +-
 net/mac80211/ieee80211_i.h                         |   3 +-
 net/mac80211/key.c                                 |  22 ++-
 net/mac80211/mesh.c                                |   8 +-
 net/mac80211/mesh_plink.c                          |   2 +-
 net/mac80211/mlme.c                                |  45 ++++-
 net/mac80211/tx.c                                  |   3 +-
 net/mac80211/vht.c                                 |  16 +-
 net/mptcp/pm_userspace.c                           |   6 -
 net/mptcp/protocol.c                               |  28 +--
 net/mptcp/protocol.h                               |  35 ++--
 net/mptcp/subflow.c                                |  10 +-
 net/netfilter/ipvs/ip_vs_sync.c                    |   8 +-
 net/netfilter/nf_conntrack_proto_sctp.c            |  43 +++-
 net/netfilter/nf_tables_api.c                      |  44 +++--
 net/netfilter/nft_payload.c                        |  13 +-
 net/netfilter/nft_set_rbtree.c                     |  46 +++--
 net/netlink/af_netlink.c                           |   8 +-
 net/nfc/llcp_core.c                                |   2 +
 net/rds/tcp_connect.c                              |   4 +-
 net/rds/tcp_listen.c                               |   2 +-
 net/rfkill/core.c                                  |  32 ++-
 net/sctp/associola.c                               |   3 +-
 net/sctp/socket.c                                  |   1 +
 net/socket.c                                       |  36 +++-
 net/tipc/crypto.c                                  |   4 +-
 net/wireless/core.c                                |  14 +-
 net/wireless/core.h                                |   7 +-
 net/wireless/mlme.c                                |   3 +-
 net/wireless/nl80211.c                             | 116 +++++++----
 net/wireless/scan.c                                |   4 +
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  |   2 +
 .../selftests/bpf/prog_tests/sockmap_basic.c       |  51 +++++
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   |  84 ++++++++
 tools/testing/selftests/bpf/progs/bpf_cubic.c      |   3 +
 tools/testing/selftests/netfilter/Makefile         |   5 +-
 .../netfilter/conntrack_sctp_collision.sh          |  89 +++++++++
 tools/testing/selftests/netfilter/nft_audit.sh     | 117 +++++++++--
 tools/testing/selftests/netfilter/sctp_collision.c |  99 ++++++++++
 112 files changed, 1358 insertions(+), 600 deletions(-)
 create mode 100755 tools/testing/selftests/netfilter/conntrack_sctp_collision.sh
 create mode 100644 tools/testing/selftests/netfilter/sctp_collision.c
