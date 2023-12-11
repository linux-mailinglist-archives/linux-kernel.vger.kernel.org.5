Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0940480D23C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344600AbjLKQk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbjLKQkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:40:22 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC5CBD;
        Mon, 11 Dec 2023 08:40:27 -0800 (PST)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 17F492094C;
        Mon, 11 Dec 2023 17:40:26 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Sean Wang <sean.wang@mediatek.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 2/3] Bluetooth: btmtkuart: fix recv_buf() return value
Date:   Mon, 11 Dec 2023 17:40:19 +0100
Message-Id: <20231211164020.173253-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211164020.173253-1-francesco@dolcini.it>
References: <20231211164020.173253-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Serdev recv_buf() callback is supposed to return the amount of bytes
consumed, therefore an int in between 0 and count.

Do not return negative number in case of issue, just print an error and
return count. This fixes a WARN in ttyport_receive_buf().

Link: https://lore.kernel.org/all/087be419-ec6b-47ad-851a-5e1e3ea5cfcc@kernel.org/
Fixes: 7237c4c9ec92 ("Bluetooth: mediatek: Add protocol support for MediaTek serial devices")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/bluetooth/btmtkuart.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index 935feab815d9..203a000a84e3 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -336,7 +336,7 @@ mtk_stp_split(struct btmtkuart_dev *bdev, const unsigned char *data, int count,
 	return data;
 }
 
-static int btmtkuart_recv(struct hci_dev *hdev, const u8 *data, size_t count)
+static void btmtkuart_recv(struct hci_dev *hdev, const u8 *data, size_t count)
 {
 	struct btmtkuart_dev *bdev = hci_get_drvdata(hdev);
 	const unsigned char *p_left = data, *p_h4;
@@ -375,25 +375,20 @@ static int btmtkuart_recv(struct hci_dev *hdev, const u8 *data, size_t count)
 			bt_dev_err(bdev->hdev,
 				   "Frame reassembly failed (%d)", err);
 			bdev->rx_skb = NULL;
-			return err;
+			return;
 		}
 
 		sz_left -= sz_h4;
 		p_left += sz_h4;
 	}
-
-	return 0;
 }
 
 static int btmtkuart_receive_buf(struct serdev_device *serdev, const u8 *data,
 				 size_t count)
 {
 	struct btmtkuart_dev *bdev = serdev_device_get_drvdata(serdev);
-	int err;
 
-	err = btmtkuart_recv(bdev->hdev, data, count);
-	if (err < 0)
-		return err;
+	btmtkuart_recv(bdev->hdev, data, count);
 
 	bdev->hdev->stat.byte_rx += count;
 
-- 
2.25.1

