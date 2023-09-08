Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2782B798CFA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344173AbjIHSTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343869AbjIHSSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:18:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057DC2114;
        Fri,  8 Sep 2023 11:18:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA928C43395;
        Fri,  8 Sep 2023 18:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196977;
        bh=VDWwr2fmsHE/DSkU4U+g3Jy6guLZMB6mAI4l8yVfuUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gdVFKSIzK3WaGa6PXh37Z659rScD3nDwzNY9UvLG9BbsHH5Csx8gic8ck/GKIOBPH
         bVDmHDLQM1HngzN+fNhMx3rwKkwvH+5Q0eGR18WAjVsnqS8gA/xDHgldymwUh+O4Fi
         6+/ELUrK7Dj42HIy6+KOh0dy3FD+TIlfPJ0pB9xMFYITAO7V+Y5a0BQ6yCe57ycW2m
         J4NawEu/sISvnrxpquPxPwNpTNPyAk5IBgtLurZwgAxF4Lp3yCsp/HCRiOJ8sWU/Of
         VDlvRUqqxrl3+wvCVrcl3oPluIBt8RSF2CZXB0/AqSxdCdsWUt7CLMwESyQCKjcXJK
         UaWyRdMZDcusA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matt Whitlock <kernel@mattwhitlock.name>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>,
        lorenzo@kernel.org, ryder.lee@mediatek.com, kvalo@kernel.org,
        matthias.bgg@gmail.com, deren.wu@mediatek.com,
        sean.wang@mediatek.com, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.4 09/41] mt76: mt7921: don't assume adequate headroom for SDIO headers
Date:   Fri,  8 Sep 2023 14:15:23 -0400
Message-Id: <20230908181555.3459640-9-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181555.3459640-1-sashal@kernel.org>
References: <20230908181555.3459640-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Whitlock <kernel@mattwhitlock.name>

[ Upstream commit 98c4d0abf5c478db1ad126ff0c187dbb84c0803c ]

mt7921_usb_sdio_tx_prepare_skb() calls mt7921_usb_sdio_write_txwi() and
mt7921_skb_add_usb_sdio_hdr(), both of which blindly assume that
adequate headroom will be available in the passed skb. This assumption
typically is satisfied when the skb was allocated in the net core for
transmission via the mt7921 netdev (although even that is only an
optimization and is not strictly guaranteed), but the assumption is
sometimes not satisfied when the skb originated in the receive path of
another netdev and was passed through to the mt7921, such as by the
bridge layer. Blindly prepending bytes to an skb is always wrong.

This commit introduces a call to skb_cow_head() before the call to
mt7921_usb_sdio_write_txwi() in mt7921_usb_sdio_tx_prepare_skb() to
ensure that at least MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE bytes can be
pushed onto the skb.

Without this fix, I can trivially cause kernel panics by bridging an
MT7921AU-based USB 802.11ax interface with an Ethernet interface on an
Intel Atom-based x86 system using its onboard RTL8169 PCI Ethernet
adapter and also on an ARM-based Raspberry Pi 1 using its onboard
SMSC9512 USB Ethernet adapter. Note that the panics do not occur in
every system configuration, as they occur only if the receiving netdev
leaves less headroom in its received skbs than the mt7921 needs for its
SDIO headers.

Here is an example stack trace of this panic on Raspberry Pi OS Lite
2023-02-21 running kernel 6.1.24+ [1]:

 skb_panic from skb_push+0x44/0x48
 skb_push from mt7921_usb_sdio_tx_prepare_skb+0xd4/0x190 [mt7921_common]
 mt7921_usb_sdio_tx_prepare_skb [mt7921_common] from mt76u_tx_queue_skb+0x94/0x1d0 [mt76_usb]
 mt76u_tx_queue_skb [mt76_usb] from __mt76_tx_queue_skb+0x4c/0xc8 [mt76]
 __mt76_tx_queue_skb [mt76] from mt76_txq_schedule.part.0+0x13c/0x398 [mt76]
 mt76_txq_schedule.part.0 [mt76] from mt76_txq_schedule_all+0x24/0x30 [mt76]
 mt76_txq_schedule_all [mt76] from mt7921_tx_worker+0x58/0xf4 [mt7921_common]
 mt7921_tx_worker [mt7921_common] from __mt76_worker_fn+0x9c/0xec [mt76]
 __mt76_worker_fn [mt76] from kthread+0xbc/0xe0
 kthread from ret_from_fork+0x14/0x34

After this fix, bridging the mt7921 interface works fine on both of my
previously problematic systems.

[1] https://github.com/raspberrypi/firmware/tree/5c276f55a4b21345cd4d6200a504ee991851ff7a

Link: https://github.com/openwrt/openwrt/issues/11796
Signed-off-by: Matt Whitlock <kernel@mattwhitlock.name>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 1675bf5204812..a671c601c5836 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1180,6 +1180,10 @@ int mt7921_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (unlikely(tx_info->skb->len <= ETH_HLEN))
 		return -EINVAL;
 
+	err = skb_cow_head(skb, MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE);
+	if (err)
+		return err;
+
 	if (!wcid)
 		wcid = &dev->mt76.global_wcid;
 
-- 
2.40.1

