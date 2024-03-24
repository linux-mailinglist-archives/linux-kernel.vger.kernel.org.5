Return-Path: <linux-kernel+bounces-114196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5072A888905
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F3D1F2CC8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C732024DBAB;
	Sun, 24 Mar 2024 23:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYvwMGLH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34421514F7;
	Sun, 24 Mar 2024 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321533; cv=none; b=WOBA4O4CIIIUvdrFBmcRXejW8SEqsg4/8S9BR4MEtRm5EDtt5omWpb0m0T5ZhNHZ21+/GTmuxTw5vCGlawbgQkxx/b29oDriItzA4jopZs9J1AXJEyZbn4bv5Akbjam0Wefzrjghy9IgPd1RmJ4Pq1H4Aasm/2/j+n53FgT1xr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321533; c=relaxed/simple;
	bh=hyROmaA6Q7+b/zmxeASSX3HaH0N+z82aRXBd1lKaYLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGcnx0PJuQ052UBPNecUj0uAj76NkcQWgU5vytpUKW5pErx/vsLzNJAsM/rv/a4ULyIB8Ao3+EHp0jv5VkwbgODWBTS1M9bJk6fNqsdzoUB0Y+wwT+x7wOut5Iai86IbiQQHrSF40Eoeju8z/mOdxMtTgpcJ8D2huY16FELxMXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYvwMGLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80F2C433F1;
	Sun, 24 Mar 2024 23:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321531;
	bh=hyROmaA6Q7+b/zmxeASSX3HaH0N+z82aRXBd1lKaYLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VYvwMGLHfOm0wekZsMZPB5oJKh/DozDbjWjkSWgFK1hJFBl+FAS7uVeRBYnyUgNdm
	 fSgfR3RDPCjNyIrRstp7JYwliR7SYYD7leMmmngiY7/bVkcquHWDyDkkopLbg9TPqS
	 /kMpvdHDTTErLrRmBTy3zdJCfGw+wihm2zEW9KIfVhZObGpLNanREml3JeU7DSWmxF
	 Yux6rbBbOC69bYwfpiYpQ2EFFSfACAcsHHeNgLcHYY8eVO+r+gb+bTxO4jEs84wt6T
	 m+yXNSezmm1dvBScAQfWuex3x6f6ok8wiCJgrZtEa0Jpe8onQ6WVviWMoAk1GhAFv5
	 2obbM9epKEutQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Deren Wu <deren.wu@mediatek.com>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 258/638] wifi: mt76: mt7921e: fix use-after-free in free_irq()
Date: Sun, 24 Mar 2024 18:54:55 -0400
Message-ID: <20240324230116.1348576-259-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Deren Wu <deren.wu@mediatek.com>

[ Upstream commit c957280ef6ab6bdf559a91ae693a6b34310697e3 ]

From commit a304e1b82808 ("[PATCH] Debug shared irqs"), there is a test
to make sure the shared irq handler should be able to handle the unexpected
event after deregistration. For this case, let's apply MT76_REMOVED flag to
indicate the device was removed and do not run into the resource access
anymore.

BUG: KASAN: use-after-free in mt7921_irq_handler+0xd8/0x100 [mt7921e]
Read of size 8 at addr ffff88824a7d3b78 by task rmmod/11115
CPU: 28 PID: 11115 Comm: rmmod Tainted: G        W    L    5.17.0 #10
Hardware name: Micro-Star International Co., Ltd. MS-7D73/MPG B650I
EDGE WIFI (MS-7D73), BIOS 1.81 01/05/2024
Call Trace:
 <TASK>
 dump_stack_lvl+0x6f/0xa0
 print_address_description.constprop.0+0x1f/0x190
 ? mt7921_irq_handler+0xd8/0x100 [mt7921e]
 ? mt7921_irq_handler+0xd8/0x100 [mt7921e]
 kasan_report.cold+0x7f/0x11b
 ? mt7921_irq_handler+0xd8/0x100 [mt7921e]
 mt7921_irq_handler+0xd8/0x100 [mt7921e]
 free_irq+0x627/0xaa0
 devm_free_irq+0x94/0xd0
 ? devm_request_any_context_irq+0x160/0x160
 ? kobject_put+0x18d/0x4a0
 mt7921_pci_remove+0x153/0x190 [mt7921e]
 pci_device_remove+0xa2/0x1d0
 __device_release_driver+0x346/0x6e0
 driver_detach+0x1ef/0x2c0
 bus_remove_driver+0xe7/0x2d0
 ? __check_object_size+0x57/0x310
 pci_unregister_driver+0x26/0x250
 __do_sys_delete_module+0x307/0x510
 ? free_module+0x6a0/0x6a0
 ? fpregs_assert_state_consistent+0x4b/0xb0
 ? rcu_read_lock_sched_held+0x10/0x70
 ? syscall_enter_from_user_mode+0x20/0x70
 ? trace_hardirqs_on+0x1c/0x130
 do_syscall_64+0x5c/0x80
 ? trace_hardirqs_on_prepare+0x72/0x160
 ? do_syscall_64+0x68/0x80
 ? trace_hardirqs_on_prepare+0x72/0x160
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/CABXGCsOdvVwdLmSsC8TZ1jF0UOg_F_W3wqLECWX620PUkvNk=A@mail.gmail.com/
Fixes: 9270270d6219 ("wifi: mt76: mt7921: fix PCI DMA hang after reboot")
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index f04e7095e1810..49d4f3c4829ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -387,6 +387,7 @@ static void mt7921_pci_remove(struct pci_dev *pdev)
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 
 	mt7921e_unregister_device(dev);
+	set_bit(MT76_REMOVED, &mdev->phy.state);
 	devm_free_irq(&pdev->dev, pdev->irq, dev);
 	mt76_free_device(&dev->mt76);
 	pci_free_irq_vectors(pdev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
index a3dbd3865b2f5..be3119aa9afa1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
@@ -12,6 +12,8 @@ irqreturn_t mt792x_irq_handler(int irq, void *dev_instance)
 {
 	struct mt792x_dev *dev = dev_instance;
 
+	if (test_bit(MT76_REMOVED, &dev->mt76.phy.state))
+		return IRQ_NONE;
 	mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
 
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
-- 
2.43.0


