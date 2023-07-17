Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC7B7559DF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 05:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjGQDLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 23:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjGQDLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 23:11:09 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 326EF10D;
        Sun, 16 Jul 2023 20:11:04 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 470006012605B;
        Mon, 17 Jul 2023 11:11:02 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     irusskikh@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     yunchuan@nfschina.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next v3 1/9] net: atlantic: Remove unnecessary (void*) conversions
Date:   Mon, 17 Jul 2023 11:10:55 +0800
Message-Id: <20230717031055.54266-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void*) to (struct hw_atl2_priv *).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 .../net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c | 12 ++++++------
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c     |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index 5dfc751572ed..220400a633f5 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
@@ -93,7 +93,7 @@ static u32 hw_atl2_sem_act_rslvr_get(struct aq_hw_s *self)
 
 static int hw_atl2_hw_reset(struct aq_hw_s *self)
 {
-	struct hw_atl2_priv *priv = (struct hw_atl2_priv *)self->priv;
+	struct hw_atl2_priv *priv = self->priv;
 	int err;
 
 	err = hw_atl2_utils_soft_reset(self);
@@ -378,8 +378,8 @@ static int hw_atl2_hw_init_tx_path(struct aq_hw_s *self)
 
 static void hw_atl2_hw_init_new_rx_filters(struct aq_hw_s *self)
 {
-	struct hw_atl2_priv *priv = (struct hw_atl2_priv *)self->priv;
 	u8 *prio_tc_map = self->aq_nic_cfg->prio_tc_map;
+	struct hw_atl2_priv *priv = self->priv;
 	u16 action;
 	u8 index;
 	int i;
@@ -433,7 +433,7 @@ static void hw_atl2_hw_new_rx_filter_vlan_promisc(struct aq_hw_s *self,
 	u16 off_action = (!promisc &&
 			  !hw_atl_rpfl2promiscuous_mode_en_get(self)) ?
 				HW_ATL2_ACTION_DROP : HW_ATL2_ACTION_DISABLE;
-	struct hw_atl2_priv *priv = (struct hw_atl2_priv *)self->priv;
+	struct hw_atl2_priv *priv = self->priv;
 	u8 index;
 
 	index = priv->art_base_index + HW_ATL2_RPF_VLAN_PROMISC_OFF_INDEX;
@@ -445,7 +445,7 @@ static void hw_atl2_hw_new_rx_filter_vlan_promisc(struct aq_hw_s *self,
 static void hw_atl2_hw_new_rx_filter_promisc(struct aq_hw_s *self, bool promisc)
 {
 	u16 off_action = promisc ? HW_ATL2_ACTION_DISABLE : HW_ATL2_ACTION_DROP;
-	struct hw_atl2_priv *priv = (struct hw_atl2_priv *)self->priv;
+	struct hw_atl2_priv *priv = self->priv;
 	bool vlan_promisc_enable;
 	u8 index;
 
@@ -539,8 +539,8 @@ static int hw_atl2_hw_init(struct aq_hw_s *self, const u8 *mac_addr)
 		[AQ_HW_IRQ_MSIX]    = { 0x20000022U, 0x20000026U },
 	};
 
-	struct hw_atl2_priv *priv = (struct hw_atl2_priv *)self->priv;
 	struct aq_nic_cfg_s *aq_nic_cfg = self->aq_nic_cfg;
+	struct hw_atl2_priv *priv = self->priv;
 	u8 base_index, count;
 	int err;
 
@@ -770,7 +770,7 @@ static struct aq_stats_s *hw_atl2_utils_get_hw_stats(struct aq_hw_s *self)
 static int hw_atl2_hw_vlan_set(struct aq_hw_s *self,
 			       struct aq_rx_filter_vlan *aq_vlans)
 {
-	struct hw_atl2_priv *priv = (struct hw_atl2_priv *)self->priv;
+	struct hw_atl2_priv *priv = self->priv;
 	u32 queue;
 	u8 index;
 	int i;
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
index 674683b54304..52e2070a4a2f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
@@ -413,8 +413,8 @@ do { \
 
 static int aq_a2_fw_update_stats(struct aq_hw_s *self)
 {
-	struct hw_atl2_priv *priv = (struct hw_atl2_priv *)self->priv;
 	struct aq_stats_s *cs = &self->curr_stats;
+	struct hw_atl2_priv *priv = self->priv;
 	struct statistics_s stats;
 	struct version_s version;
 	int err;
-- 
2.30.2

