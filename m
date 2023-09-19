Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFCA7A5765
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 04:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjISC12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 22:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjISC12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:27:28 -0400
Received: from out-212.mta1.migadu.com (out-212.mta1.migadu.com [IPv6:2001:41d0:203:375::d4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8F410A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 19:27:21 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695090440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GldjsjLN9+yIG261E0aNo5eTT0aAfea0jQrrQue5u00=;
        b=mkZMkq7B3bUpxEPYmu2MMcafJg4hXDsOyrfwPXWWPuo23kQP5p5h2a7nbOPpddUEXUDmhf
        3/dEV+SIuCGVpJMz0JvI/8VFF/lfB5lkXgdH/kllhkpg9ctUeoKO0voCtwe8OJ0D4beMvl
        QehRcZutZVMEFLVcDtA8HLkEmZ4GjXA=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     vadim.fedorenko@linux.dev
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: hinic: Fix warning-hinic_set_vlan_fliter() warn: variable dereferenced before check 'hwdev'
Date:   Tue, 19 Sep 2023 10:27:15 +0800
Message-Id: <20230919022715.6424-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'hwdev' is checked too late and hwdev will not be NULL, so remove the check

Fixes: 2acf960e3be6 ("net: hinic: Add support for configuration of rx-vlan-filter by ethtool")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202309112354.pikZCmyk-lkp@intel.com/
Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
v1->v2: Remove 'hwdev' check directly 
v1 link: https://lore.kernel.org/lkml/20230918123401.6951-1-cai.huoqing@linux.dev/

 drivers/net/ethernet/huawei/hinic/hinic_port.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_port.c b/drivers/net/ethernet/huawei/hinic/hinic_port.c
index 9406237c461e..f81a43d2cdfc 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_port.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_port.c
@@ -456,9 +456,6 @@ int hinic_set_vlan_fliter(struct hinic_dev *nic_dev, u32 en)
 	u16 out_size = sizeof(vlan_filter);
 	int err;
 
-	if (!hwdev)
-		return -EINVAL;
-
 	vlan_filter.func_idx = HINIC_HWIF_FUNC_IDX(hwif);
 	vlan_filter.enable = en;
 
-- 
2.34.1

