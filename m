Return-Path: <linux-kernel+bounces-21001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F52828850
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9FC1C244DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20FE39FC5;
	Tue,  9 Jan 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z40cdBGK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CC139AF2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 14:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806ADC433C7;
	Tue,  9 Jan 2024 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704811021;
	bh=Q9+aVUqVDr+Q791RDmzkgndLwzfe16JaEUEnnyw/38M=;
	h=From:To:Cc:Subject:Date:From;
	b=Z40cdBGKjRdZl/tWmkplbOIb1taPpCpKZpgf7BeUzvcCJh99ebnqg7S/kVRWO//9w
	 0p/I1K3q/GUSp0CUnDwjHBAYVej8F/LCMgbeeKpxMRjN0N0PkuBUT8GRMT6i4d6AjW
	 5szgaKuf0ZUMSD0gqclPeHUx3Ox5ZJlwBdNubQ8oM3TxvsJwbuwC8xRJT8pUEZO1PH
	 VVhW/35Dg0XQoES6NI7iyzP38G8cvA3RP4HRRjN7v9TJLNq41nEYj2735ORcemT9zh
	 WFRvHfym5rWi0ph+GkPgxIllzLSst4goHM7CD1+8HHJXMYrrd5CG351W27QIvA0QrC
	 J1HLC611vYHaw==
From: Oded Gabbay <ogabbay@kernel.org>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 1/2] accel/habanalabs: remove call to deprecated function
Date: Tue,  9 Jan 2024 16:36:55 +0200
Message-Id: <20240109143656.768980-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dani Liberman <dliberman@habana.ai>

In newer kernel versions, irq_set_affinity_hint() is deprecated.
Instead, use the newer version which is irq_set_affinity_and_hint().

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/device.c | 2 +-
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index bc66ad227aa5..493b4a4294a3 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -2839,6 +2839,6 @@ void hl_set_irq_affinity(struct hl_device *hdev, int irq)
 		return;
 	}
 
-	if (irq_set_affinity_hint(irq, &hdev->irq_affinity_mask))
+	if (irq_set_affinity_and_hint(irq, &hdev->irq_affinity_mask))
 		dev_err(hdev->dev, "Failed setting irq %d affinity\n", irq);
 }
diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 5863c9049134..05e2170c815e 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -4395,7 +4395,7 @@ static int gaudi2_enable_msix(struct hl_device *hdev)
 			i < GAUDI2_IRQ_NUM_USER_FIRST + user_irq_init_cnt ; i++, j++) {
 
 		irq = pci_irq_vector(hdev->pdev, i);
-		irq_set_affinity_hint(irq, NULL);
+		irq_set_affinity_and_hint(irq, NULL);
 		free_irq(irq, &hdev->user_interrupt[j]);
 	}
 	irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_UNEXPECTED_ERROR);
@@ -4476,7 +4476,7 @@ static void gaudi2_disable_msix(struct hl_device *hdev)
 			k < hdev->asic_prop.user_interrupt_count ; i++, j++, k++) {
 
 		irq = pci_irq_vector(hdev->pdev, i);
-		irq_set_affinity_hint(irq, NULL);
+		irq_set_affinity_and_hint(irq, NULL);
 		free_irq(irq, &hdev->user_interrupt[j]);
 	}
 
-- 
2.34.1


