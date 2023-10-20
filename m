Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655937D0BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376703AbjJTJZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376811AbjJTJZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:25:34 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 83D7219B1;
        Fri, 20 Oct 2023 02:25:06 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 2B9B0604FCB31;
        Fri, 20 Oct 2023 17:25:01 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     Su Hui <suhui@nfschina.com>, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] igb: e1000_82575: add an error code check in igb_set_d0_lplu_state_82575
Date:   Fri, 20 Oct 2023 17:24:31 +0800
Message-Id: <20231020092430.209765-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

igb_set_d0_lplu_state_82575() check all phy->ops.read_reg()'s return value
except this one, just fix this.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/ethernet/intel/igb/e1000_82575.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index 8d6e44ee1895..e765d5ee3661 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -978,6 +978,9 @@ static s32 igb_set_d0_lplu_state_82575(struct e1000_hw *hw, bool active)
 		/* When LPLU is enabled, we should disable SmartSpeed */
 		ret_val = phy->ops.read_reg(hw, IGP01E1000_PHY_PORT_CONFIG,
 						&data);
+		if (ret_val)
+			goto out;
+
 		data &= ~IGP01E1000_PSCFR_SMART_SPEED;
 		ret_val = phy->ops.write_reg(hw, IGP01E1000_PHY_PORT_CONFIG,
 						 data);
-- 
2.30.2

