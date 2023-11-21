Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA257F3665
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbjKUSp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjKUSpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:45:54 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BC5D1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:45:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9cb79eb417so6406367276.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700592349; x=1701197149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VvYHc/KEKM/xuCRf4EcqYf87I/nkTFGOCvMPmcnWHCY=;
        b=B+Y7uN+/QzA0E/rXAVjF4KvmgO+hfbsQtgbdoVFHyZ+H0BuB76R5sfcjf9Dl0wPizy
         oeAS9Lehez/EPBbuwlAuFS6wKeoNwOIzVgbHJhfS2QZIch/T1ZyYy46V059lQQ6jUv97
         Vd9S/eIWiVvQSz82AHVkw1LHkPbKUqUXcMUNyQXZ8ywkYUFGfxEwR7aK9ry23nM0NP1J
         iQ4JjlAb3ytdlkFnEn/twvP4hCHfBnQOaVZMIw0XQNRTXuL3x0NRW/IfJ2DQc+R0FAJJ
         mI0F0B/Aku1SDSYJW1yqU5cx5a/rjOOCmnzNbdP3+C0pH4/wuOGqIaDN7c2X3NKkOPgd
         aHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700592349; x=1701197149;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VvYHc/KEKM/xuCRf4EcqYf87I/nkTFGOCvMPmcnWHCY=;
        b=Bux1YytT1fttgdPNch5WaWRs6CVJH1/xK6nbVK0kUfZa324CbAd51L9hDKvh+fL1QS
         f7lVO/RRuGfmnwOVBOER5zTShb7zb1lSEXn7i8dIDVE/6GM9fajLxcWNNp5oBSSIeO6o
         bYaYgRSBCDH5Dy/Umns8p5umMas3vlLt8zLXVil5rk0pDlockvrnZWqnSVAxOb3b2bnc
         gaM51kF8tOOWUkiCRK/TPGWUvnSEzPi42/ur0gsKI/tYfsOu75+GV6894NbnQ/MvO7i2
         QibZEuZ3PSMIhfJtJyz+d5WG3LmF0P3ledwszXFtYMlOH7yALnfNndE9bz/tE3KIl8Mi
         R/Mg==
X-Gm-Message-State: AOJu0YyCu3WPMpLxxD0T3pdAaG4kuwFDFD8nRQEaqb8+bfWiJI5D8Lw6
        NkKQnEG4exj9mFrifx9n/IYOmQmxy/aZ
X-Google-Smtp-Source: AGHT+IGoz3b1YR3yosBQJz6gTUpOZcWdPVV24Qg92U1q0Mp18x5C0S7XIgT1G3GbyKUwQc1/g1E4VRI3tm/t
X-Received: from sgzhang.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d89])
 (user=sgzhang job=sendgmr) by 2002:a25:38f:0:b0:d9a:6007:223a with SMTP id
 137-20020a25038f000000b00d9a6007223amr237009ybd.8.1700592348988; Tue, 21 Nov
 2023 10:45:48 -0800 (PST)
Date:   Tue, 21 Nov 2023 18:45:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231121184543.3433940-1-sgzhang@google.com>
Subject: [PATCH] net: stmmac: fix out-of-bounds read via memcpy detected by KASAN
From:   Ray Zhang <sgzhang@google.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ray Zhang <sgzhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_KASAN detected out-of-bounds read via memcpy in stmmac_get_strings.
The fix is to change memcpy to strscpy.

Tested:
<machine_obfuscated>:~# ethtool -i <interface_obfuscated>
driver: st_gmac
<machine_obfuscated>:~# ethtool -S <interface_obfuscated>
NIC statistics:
     ATPES: 0
     TPES: 0
     RDPES: 0
     MPES: 0
     MTSPES: 0
     ARPES: 0
     CWPES: 0
     ASRPES: 0
     TTES: 0
     RTES: 0
     CTES: 0
     ATES: 0
     PTES: 0
     T125ES: 0
     R125ES: 0
     RVCTES: 0
     MSTTES: 0
     SLVTES: 0
     ATITES: 0
     ARITES: 0
     FSMPES: 0
     TXCES: 0
     TXAMS: 0
     TXUES: 0
     RXCES: 0
     RXAMS: 0
     RXUES: 0
     ECES: 0
     EAMS: 0
     EUES: 0
     RPCES: 0
     RPAMS: 0
     RPUES: 0
     TCES: 0
     TAMS: 0
     TUES: 0
     mmc_tx_octetcount_gb: 11612
     mmc_tx_framecount_gb: 100
     mmc_tx_broadcastframe_g: 0
     mmc_tx_multicastframe_g: 42
     mmc_tx_64_octets_gb: 0
     mmc_tx_65_to_127_octets_gb: 62
     mmc_tx_128_to_255_octets_gb: 38
     mmc_tx_256_to_511_octets_gb: 0
     mmc_tx_512_to_1023_octets_gb: 0
     mmc_tx_1024_to_max_octets_gb: 0
     mmc_tx_unicast_gb: 58
     mmc_tx_multicast_gb: 42
     mmc_tx_broadcast_gb: 0
     mmc_tx_underflow_error: 0
     mmc_tx_singlecol_g: 0
     mmc_tx_multicol_g: 0
     mmc_tx_deferred: 0
     mmc_tx_latecol: 0
     mmc_tx_exesscol: 0
     mmc_tx_carrier_error: 0
     mmc_tx_octetcount_g: 11612
     mmc_tx_framecount_g: 100
     mmc_tx_excessdef: 0
     mmc_tx_pause_frame: 0
     mmc_tx_vlan_frame_g: 0
     mmc_rx_framecount_gb: 64
     mmc_rx_octetcount_gb: 30235
     mmc_rx_octetcount_g: 30235
     mmc_rx_broadcastframe_g: 0
     mmc_rx_multicastframe_g: 0
     mmc_rx_crc_error: 0
     mmc_rx_align_error: 0
     mmc_rx_run_error: 0
     mmc_rx_jabber_error: 0
     mmc_rx_undersize_g: 0
     mmc_rx_oversize_g: 0
     mmc_rx_64_octets_gb: 0
     mmc_rx_65_to_127_octets_gb: 9
     mmc_rx_128_to_255_octets_gb: 22
     mmc_rx_256_to_511_octets_gb: 21
     mmc_rx_512_to_1023_octets_gb: 2
     mmc_rx_1024_to_max_octets_gb: 10
     mmc_rx_unicast_g: 64
     mmc_rx_length_error: 0
     mmc_rx_autofrangetype: 0
     mmc_rx_pause_frames: 0
     mmc_rx_fifo_overflow: 0
     mmc_rx_vlan_frames_gb: 0
     mmc_rx_watchdog_error: 0
     mmc_rx_ipc_intr_mask: 0
     mmc_rx_ipc_intr: 0
     mmc_rx_ipv4_gd: 0
     mmc_rx_ipv4_hderr: 0
     mmc_rx_ipv4_nopay: 0
     mmc_rx_ipv4_frag: 0
     mmc_rx_ipv4_udsbl: 0
     mmc_rx_ipv4_gd_octets: 0
     mmc_rx_ipv4_hderr_octets: 0
     mmc_rx_ipv4_nopay_octets: 0
     mmc_rx_ipv4_frag_octets: 0
     mmc_rx_ipv4_udsbl_octets: 0
     mmc_rx_ipv6_gd_octets: 0
     mmc_rx_ipv6_hderr_octets: 0
     mmc_rx_ipv6_nopay_octets: 0
     mmc_rx_ipv6_gd: 0
     mmc_rx_ipv6_hderr: 0
     mmc_rx_ipv6_nopay: 0
     mmc_rx_udp_gd: 0
     mmc_rx_udp_err: 0
     mmc_rx_tcp_gd: 0
     mmc_rx_tcp_err: 0
     mmc_rx_icmp_gd: 0
     mmc_rx_icmp_err: 0
     mmc_rx_udp_gd_octets: 0
     mmc_rx_udp_err_octets: 0
     mmc_rx_tcp_gd_octets: 0
     mmc_rx_tcp_err_octets: 0
     mmc_rx_icmp_gd_octets: 0
     mmc_rx_icmp_err_octets: 0
     mmc_tx_fpe_fragment_cntr: 0
     mmc_tx_hold_req_cntr: 0
     mmc_rx_packet_assembly_err_cntr: 0
     mmc_rx_packet_smd_err_cntr: 0
     mmc_rx_packet_assembly_ok_cntr: 0
     mmc_rx_fpe_fragment_cntr: 0
     tx_underflow: 0
     tx_carrier: 0
     tx_losscarrier: 0
     vlan_tag: 0
     tx_deferred: 0
     tx_vlan: 0
     tx_jabber: 0
     tx_frame_flushed: 0
     tx_payload_error: 0
     tx_ip_header_error: 0
     rx_desc: 0
     sa_filter_fail: 0
     overflow_error: 0
     ipc_csum_error: 0
     rx_collision: 0
     rx_crc_errors: 0
     dribbling_bit: 0
     rx_length: 0
     rx_mii: 0
     rx_multicast: 0
     rx_gmac_overflow: 0
     rx_watchdog: 0
     da_rx_filter_fail: 0
     sa_rx_filter_fail: 0
     rx_missed_cntr: 0
     rx_overflow_cntr: 0
     rx_vlan: 0
     rx_split_hdr_pkt_n: 0
     tx_undeflow_irq: 0
     tx_process_stopped_irq: 0
     tx_jabber_irq: 0
     rx_overflow_irq: 0
     rx_buf_unav_irq: 0
     rx_process_stopped_irq: 0
     rx_watchdog_irq: 0
     tx_early_irq: 0
     fatal_bus_error_irq: 0
     rx_early_irq: 0
     threshold: 64
     tx_pkt_n: 100
     rx_pkt_n: 64
     normal_irq_n: 62
     rx_normal_irq_n: 58
     napi_poll: 215
     tx_normal_irq_n: 4
     tx_clean: 157
     tx_set_ic_bit: 4
     irq_receive_pmt_irq_n: 0
     mmc_tx_irq_n: 0
     mmc_rx_irq_n: 0
     mmc_rx_csum_offload_irq_n: 0
     irq_tx_path_in_lpi_mode_n: 0
     irq_tx_path_exit_lpi_mode_n: 0
     irq_rx_path_in_lpi_mode_n: 0
     irq_rx_path_exit_lpi_mode_n: 0
     phy_eee_wakeup_error_n: 0
     ip_hdr_err: 0
     ip_payload_err: 0
     ip_csum_bypassed: 0
     ipv4_pkt_rcvd: 0
     ipv6_pkt_rcvd: 64
     no_ptp_rx_msg_type_ext: 64
     ptp_rx_msg_type_sync: 0
     ptp_rx_msg_type_follow_up: 0
     ptp_rx_msg_type_delay_req: 0
     ptp_rx_msg_type_delay_resp: 0
     ptp_rx_msg_type_pdelay_req: 0
     ptp_rx_msg_type_pdelay_resp: 0
     ptp_rx_msg_type_pdelay_follow_up: 0
     ptp_rx_msg_type_announce: 0
     ptp_rx_msg_type_management: 0
     ptp_rx_msg_pkt_reserved_type: 0
     ptp_frame_type: 0
     ptp_ver: 0
     timestamp_dropped: 0
     av_pkt_rcvd: 0
     av_tagged_pkt_rcvd: 0
     vlan_tag_priority_val: 0
     l3_filter_match: 0
     l4_filter_match: 0
     l3_l4_filter_no_match: 0
     irq_pcs_ane_n: 0
     irq_pcs_link_n: 0
     irq_rgmii_n: 0
     mtl_tx_status_fifo_full: 0
     mtl_tx_fifo_not_empty: 0
     mmtl_fifo_ctrl: 0
     mtl_tx_fifo_read_ctrl_write: 0
     mtl_tx_fifo_read_ctrl_wait: 0
     mtl_tx_fifo_read_ctrl_read: 0
     mtl_tx_fifo_read_ctrl_idle: 0
     mac_tx_in_pause: 0
     mac_tx_frame_ctrl_xfer: 0
     mac_tx_frame_ctrl_idle: 0
     mac_tx_frame_ctrl_wait: 0
     mac_tx_frame_ctrl_pause: 0
     mac_gmii_tx_proto_engine: 0
     mtl_rx_fifo_fill_level_full: 0
     mtl_rx_fifo_fill_above_thresh: 0
     mtl_rx_fifo_fill_below_thresh: 0
     mtl_rx_fifo_fill_level_empty: 0
     mtl_rx_fifo_read_ctrl_flush: 0
     mtl_rx_fifo_read_ctrl_read_data: 0
     mtl_rx_fifo_read_ctrl_status: 0
     mtl_rx_fifo_read_ctrl_idle: 0
     mtl_rx_fifo_ctrl_active: 0
     mac_rx_frame_ctrl_fifo: 0
     mac_gmii_rx_proto_engine: 0
     tx_tso_frames: 0
     tx_tso_nfrags: 0
     mtl_est_cgce: 0
     mtl_est_hlbs: 0
     mtl_est_hlbf: 0
     mtl_est_btre: 0
     mtl_est_btrlm: 0
     q0_tx_pkt_n: 100
     q0_tx_irq_n: 4
     q0_rx_pkt_n: 64
     q0_rx_irq_n: 58

Signed-off-by: Ray Zhang <sgzhang@google.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index f628411ae4ae..127cde8f976e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -749,23 +749,24 @@ static void stmmac_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 				if (!stmmac_safety_feat_dump(priv,
 							&priv->sstats, i,
 							NULL, &desc)) {
-					memcpy(p, desc, ETH_GSTRING_LEN);
+					strscpy(p, desc, ETH_GSTRING_LEN);
 					p += ETH_GSTRING_LEN;
 				}
 			}
 		}
 		if (priv->dma_cap.rmon)
 			for (i = 0; i < STMMAC_MMC_STATS_LEN; i++) {
-				memcpy(p, stmmac_mmc[i].stat_string,
-				       ETH_GSTRING_LEN);
+				strscpy(p, stmmac_mmc[i].stat_string,
+					ETH_GSTRING_LEN);
 				p += ETH_GSTRING_LEN;
 			}
 		for (i = 0; i < STMMAC_STATS_LEN; i++) {
-			memcpy(p, stmmac_gstrings_stats[i].stat_string, ETH_GSTRING_LEN);
+			strscpy(p, stmmac_gstrings_stats[i].stat_string,
+				ETH_GSTRING_LEN);
 			p += ETH_GSTRING_LEN;
 		}
 		for (i = 0; i < STMMAC_QSTATS; i++) {
-			memcpy(p, stmmac_qstats_string[i], ETH_GSTRING_LEN);
+			strscpy(p, stmmac_qstats_string[i], ETH_GSTRING_LEN);
 			p += ETH_GSTRING_LEN;
 		}
 		stmmac_get_qstats_string(priv, p);
-- 
2.43.0.rc1.413.gea7ed67945-goog

