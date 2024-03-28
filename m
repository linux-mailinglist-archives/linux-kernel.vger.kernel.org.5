Return-Path: <linux-kernel+bounces-113138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7978881C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FC0281EA9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9189213C3F0;
	Sun, 24 Mar 2024 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2TNCxdZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C329C13C3D2;
	Sun, 24 Mar 2024 22:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319945; cv=none; b=hJayHOyWz4K5JOJtR0Y+9kXFkYRKgV/mftfyuf6HoY3PhkTQN8AIsK8bJKQcj0WVgq9H6T9raym4WBG84GOFFLl/kmCTodweX7BEJYs11NKGlGtDbpOrOe4w4S5txoVke143B9k/LaTTt3iE6U1MoOGlbo3MCF3+PAmExibEpxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319945; c=relaxed/simple;
	bh=ikmk3d//F6F+x4ngv5EXpqUTA6+K6pqxRuJxID3wO00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQxQOHzKuYB0wnjpcjghkshNAbeE5ZZMEC+ohSxW4Yb9I6ElS0lrQ0//awbYTSnBxHppsb5Hi8bDTIAztoHHwlQ9HmQP4/IdV+zqKOT7ymrUu9uSv+11gsWelmBBTZ78Ajzg6A6jkIu6h57+GcGyWR5b7PBq7JvRAcgCNOdOKbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2TNCxdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A9AC433C7;
	Sun, 24 Mar 2024 22:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319945;
	bh=ikmk3d//F6F+x4ngv5EXpqUTA6+K6pqxRuJxID3wO00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M2TNCxdZAe6pu70aIctDst0dFMg8fjDAkBirYe2g1jprJ1TThAibst5JYB6QYeWT3
	 Jzw7jP4AM5Ya+oFung838GhYq0IrLBC2Z7f44NTnCmgznb5WOirLe5y59V8UnQbOzw
	 UoGQh+ajoKMtLG631IUprxLI7j+/5ziNz1Xw/Rw+kpmJCfz0sOVU4fPCO0K4SRceEc
	 5dsDtXxGd8oFYGvx5Bo53xPsairo4kzzJ0ZWpPdc0SNqQeeOr7NwR9eNR7wm/c3Any
	 Eq+OGV7LsKwSovLp6t9o46wO3Io/HSQoL++nijVs2+fiy5ipqmzJ2xSaRs4c8bIogt
	 zdlRhtS4IaWgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Deren Wu <deren.wu@mediatek.com>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 251/715] wifi: mt76: mt7921e: fix use-after-free in free_irq()
Date: Sun, 24 Mar 2024 18:27:10 -0400
Message-ID: <20240324223455.1342824-252-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index dde26f3274783..82cf3ce90b52f 100644
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
index 8fa36b59e738d..5cc2d59b774af 100644
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


