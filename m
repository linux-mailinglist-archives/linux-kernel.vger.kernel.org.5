Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F937CA192
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjJPI2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJPI2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:28:48 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8372A1;
        Mon, 16 Oct 2023 01:28:45 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0DF594000E;
        Mon, 16 Oct 2023 08:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697444924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SVxISp8EXisyvjENbAcGjSMMTvh4tZlsbQG1yYDAdZ0=;
        b=BSPXJVwX5YVN5V39vWwzgM8VgRieb1KreLtKFZHvCcHcZQAX74m393ugWyZWSJhPA4z6Ii
        mjJVi5I2z11VmdhhwjZX/8tUhrYM02lbDkemLGRWm0yk8SiL/4HlYqc++Ec80X6FWL3FS1
        HK1VEilQaX0k3PciT650WUqBW5lR6fs/i0HFFx28Gg82QIdA/QRjVHj52ZinkFMgc9O+bk
        xlV4wcIDQJXISdC9WaVc2JV+9hlRv9kQoI0HK6Jx8nvpv5M8LEmG2+LAumIO2I0R0DFufM
        i57mWA/9dtul5a9Z2wuFzK2tqLcg2a2HGg/CAXxZdWmtPpzh+R6Y3FBpugxHnA==
From:   =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date:   Mon, 16 Oct 2023 10:29:52 +0200
Subject: [PATCH v2] wifi: wilc1000: use vmm_table as array in wilc struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231016-wilc1000_tx_oops-v2-1-8d1982a29ef1@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAH/0LGUC/2WNQQ6CMBBFr0JmbU2nFRVW3sMQImWUSbBDWoIYw
 t2tJK5cvpf89xeIFJgilNkCgSaOLD6B2WXgupt/kOI2MRhtLGo06sW9Q611Pc61yBBVfnZUIJG
 lwkKaDYHuPG/Ja5W44zhKeG8PE37tL2b/YxMqVPZ0xIaaIjeH9tKIjD37vZMnVOu6fgBHdRWEs
 gAAAA==
To:     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Kalle Valo <kvalo@kernel.org>,
        Michael Walle <mwalle@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ajay Singh <ajay.kathat@microchip.com>, stable@vger.kernel.org,
        =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: alexis.lothore@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Enabling KASAN and running some iperf tests raises some memory issues with
vmm_table:

BUG: KASAN: slab-out-of-bounds in wilc_wlan_handle_txq+0x6ac/0xdb4
Write of size 4 at addr c3a61540 by task wlan0-tx/95

KASAN detects that we are writing data beyond range allocated to vmm_table.
There is indeed a mismatch between the size passed to allocator in
wilc_wlan_init, and the range of possible indexes used later: allocation
size is missing a multiplication by sizeof(u32)

Fixes: 40b717bfcefa ("wifi: wilc1000: fix DMA on stack objects")
Cc: stable@vger.kernel.org
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
Changes in v2:
- keep dedicated dynamic allocation for vmm_table
- Link to v1: https://lore.kernel.org/r/20231013-wilc1000_tx_oops-v1-1-3761beb9524d@bootlin.com
---
 drivers/net/wireless/microchip/wilc1000/wlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 58bbf50081e4..e4113f2dfadf 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1492,7 +1492,7 @@ int wilc_wlan_init(struct net_device *dev)
 	}
 
 	if (!wilc->vmm_table)
-		wilc->vmm_table = kzalloc(WILC_VMM_TBL_SIZE, GFP_KERNEL);
+		wilc->vmm_table = kzalloc(WILC_VMM_TBL_SIZE * sizeof(u32), GFP_KERNEL);
 
 	if (!wilc->vmm_table) {
 		ret = -ENOBUFS;

---
base-commit: ea12d85cbfd6b08fff40a4fefccc011b6cfadf8e
change-id: 20231012-wilc1000_tx_oops-58ce91ee3e93

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

