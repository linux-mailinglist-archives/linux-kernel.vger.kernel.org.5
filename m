Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185937AC3E2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjIWRPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIWRPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:15:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9E0AF
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 10:14:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6540C433C7;
        Sat, 23 Sep 2023 17:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695489296;
        bh=EuVsv2tlU9o8DmKKBXMpj3xUJ9z4L1a+8FYv8fqzqu8=;
        h=Date:From:To:Cc:Subject:From;
        b=Z2f4hgH6UXOg91xj2yBfgIHuyACZzO5/It6i860EHYT5BZLiktiVLcH1tK5/B5iWh
         RxZxp14WC1tV6nK0B3iMFRyp3jCjfYeKPoQ1Y3W2O5LmeBipWznV+xOtQXdEiey9ft
         iXg3OuZEEhaG/g8uDKXqwGaMSi6vS7uCSgM+FD270DhCgXaCAglb8haCyxYYZgQsBn
         ITX/G9nAn+Iku4Ez7BxdKYo021ipMcTAsslJBOm3+qHInvVjPw2E7NRvzpaGoZwSHL
         WUQWu+LCJr5TtkcLBAnKyDnZMmVJc7lsvQFNAUSStM6YLkkosPd4+kCHcuX4Kiof0g
         Ncod8A+B469Hg==
Date:   Sat, 23 Sep 2023 19:15:59 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH] qed/red_ll2: Fix undefined behavior bug in struct
 qed_ll2_info
Message-ID: <ZQ+Nz8DfPg56pIzr@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flexible structure (a structure that contains a flexible-array member
at the end) `qed_ll2_tx_packet` is nested within the second layer of
`struct qed_ll2_info`:

struct qed_ll2_tx_packet {
	...
        /* Flexible Array of bds_set determined by max_bds_per_packet */
        struct {
                struct core_tx_bd *txq_bd;
                dma_addr_t tx_frag;
                u16 frag_len;
        } bds_set[];
};

struct qed_ll2_tx_queue {
	...
	struct qed_ll2_tx_packet cur_completing_packet;
};

struct qed_ll2_info {
	...
	struct qed_ll2_tx_queue tx_queue;
        struct qed_ll2_cbs cbs;
};

The problem is that member `cbs` in `struct qed_ll2_info` is placed just
after an object of type `struct qed_ll2_tx_queue`, which is in itself
an implicit flexible structure, which by definition ends in a flexible
array member, in this case `bds_set`. This causes an undefined behavior
bug at run-time when dynamic memory is allocated for `bds_set`, which
could lead to a serious issue if `cbs` in `struct qed_ll2_info` is
overwritten by the contents of `bds_set`. Notice that the type of `cbs`
is a structure full of function pointers (and a cookie :) ):

include/linux/qed/qed_ll2_if.h:
107 typedef
108 void (*qed_ll2_complete_rx_packet_cb)(void *cxt,
109                                       struct qed_ll2_comp_rx_data *data);
110
111 typedef
112 void (*qed_ll2_release_rx_packet_cb)(void *cxt,
113                                      u8 connection_handle,
114                                      void *cookie,
115                                      dma_addr_t rx_buf_addr,
116                                      bool b_last_packet);
117
118 typedef
119 void (*qed_ll2_complete_tx_packet_cb)(void *cxt,
120                                       u8 connection_handle,
121                                       void *cookie,
122                                       dma_addr_t first_frag_addr,
123                                       bool b_last_fragment,
124                                       bool b_last_packet);
125
126 typedef
127 void (*qed_ll2_release_tx_packet_cb)(void *cxt,
128                                      u8 connection_handle,
129                                      void *cookie,
130                                      dma_addr_t first_frag_addr,
131                                      bool b_last_fragment, bool b_last_packet);
132
133 typedef
134 void (*qed_ll2_slowpath_cb)(void *cxt, u8 connection_handle,
135                             u32 opaque_data_0, u32 opaque_data_1);
136
137 struct qed_ll2_cbs {
138         qed_ll2_complete_rx_packet_cb rx_comp_cb;
139         qed_ll2_release_rx_packet_cb rx_release_cb;
140         qed_ll2_complete_tx_packet_cb tx_comp_cb;
141         qed_ll2_release_tx_packet_cb tx_release_cb;
142         qed_ll2_slowpath_cb slowpath_cb;
143         void *cookie;
144 };

Fix this by moving the declaration of `cbs` to the  middle of its
containing structure `qed_ll2_info`, preventing it from being
overwritten by the contents of `bds_set` at run-time.

This bug was introduced in 2017, when `bds_set` was converted to a
one-element array, and started to be used as a Variable Length Object
(VLO) at run-time.

Fixes: f5823fe6897c ("qed: Add ll2 option to limit the number of bds per packet")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_ll2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.h b/drivers/net/ethernet/qlogic/qed/qed_ll2.h
index 0bfc375161ed..a174c6fc626a 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.h
@@ -110,9 +110,9 @@ struct qed_ll2_info {
 	enum core_tx_dest tx_dest;
 	u8 tx_stats_en;
 	bool main_func_queue;
+	struct qed_ll2_cbs cbs;
 	struct qed_ll2_rx_queue rx_queue;
 	struct qed_ll2_tx_queue tx_queue;
-	struct qed_ll2_cbs cbs;
 };
 
 extern const struct qed_ll2_ops qed_ll2_ops_pass;
-- 
2.34.1

