Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2C97A49FC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241383AbjIRMnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241523AbjIRMnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:43:05 -0400
X-Greylist: delayed 502 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 05:42:32 PDT
Received: from out-210.mta1.migadu.com (out-210.mta1.migadu.com [IPv6:2001:41d0:203:375::d2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091E910F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:42:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695040445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tzdxyJL0ghA962IZMjb5yhiDtQvWieedpUo2tK/XcEU=;
        b=nQ7NV2ahM6CIzA3I5Z+4WcikmpCuETB9Mx5x/LMHaYRKce4ilfhUEjnANu0TqvP8hZJWsj
        ik8rjMj3RNb7UTDrOPwRIHxIEegG0dqomII6W85MT07xaGZVNRBoXYvdCIyFYvMjrFfrPa
        rJg+BPFJNnQfXJNN+oP4P4mO4P0VAq0=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: hinic: Fix warning-hinic_set_vlan_fliter() warn: variable dereferenced before check 'hwdev'
Date:   Mon, 18 Sep 2023 20:34:01 +0800
Message-Id: <20230918123401.6951-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,TO_EQ_FM_DIRECT_MX autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning, 'hwdev' is checked too late

Fixes: 2acf960e3be6 ("net: hinic: Add support for configuration of rx-vlan-filter by ethtool")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202309112354.pikZCmyk-lkp@intel.com/
Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/net/ethernet/huawei/hinic/hinic_port.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_port.c b/drivers/net/ethernet/huawei/hinic/hinic_port.c
index 9406237c461e..bf920c709f82 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_port.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_port.c
@@ -450,8 +450,8 @@ int hinic_set_rx_vlan_offload(struct hinic_dev *nic_dev, u8 en)
 int hinic_set_vlan_fliter(struct hinic_dev *nic_dev, u32 en)
 {
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
-	struct hinic_hwif *hwif = hwdev->hwif;
-	struct pci_dev *pdev = hwif->pdev;
+	struct hinic_hwif *hwif;
+	struct pci_dev *pdev;
 	struct hinic_vlan_filter vlan_filter;
 	u16 out_size = sizeof(vlan_filter);
 	int err;
@@ -459,6 +459,9 @@ int hinic_set_vlan_fliter(struct hinic_dev *nic_dev, u32 en)
 	if (!hwdev)
 		return -EINVAL;
 
+	hwif = hwdev->hwif;
+	pdev = hwif->pdev;
+
 	vlan_filter.func_idx = HINIC_HWIF_FUNC_IDX(hwif);
 	vlan_filter.enable = en;
 
-- 
2.34.1

