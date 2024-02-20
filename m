Return-Path: <linux-kernel+bounces-73294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5788585C092
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087401F22D96
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF40E77636;
	Tue, 20 Feb 2024 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/U4xc0o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4245277625
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444906; cv=none; b=Le5p6aT/PeS9Aikuelxw3582Uif91Q5tBIgqvBj1TQMryGrB25tvmAxr25AbgcecH6VOgXeGQyxVZ3ooEIdaBOvzMnIRAE3N5xDnBxDWOqtORBJx3Kf1NcrI13q98M+QPR5cus7za20deoOqcj5xxjQFkQZHHXJjy0Z5t0hwvVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444906; c=relaxed/simple;
	bh=2chqzJLlGnaDjPT3os8qGNEAIFqkHbeg9jiI4JJjOYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kgC4+Y3u7XaMn4aWV1gw6RpvUcrVHwWYJjjYNVQZwgj3So+Z0YRCT3baWeAJi+qZvC7w77PS2b6r3++hQ5xkUPu/xrsSd/ak2od7SFUIwF9EOzIXt0yajfIcwytkbAhTlipf2h7LYe0Fy+Yd71UC539YyUPmIZ0ml3GgmnkcRHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/U4xc0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A70AC433C7;
	Tue, 20 Feb 2024 16:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708444906;
	bh=2chqzJLlGnaDjPT3os8qGNEAIFqkHbeg9jiI4JJjOYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C/U4xc0oWdp1jZ7HhF+yTrGSflZaG3L5aV03rhLyEHRbNAi34ym8Zgllx3N5QAq7N
	 9g0NsjIfQLbc17Ddfe0C0rxC19Kc68lzie5JXsRya2Tft7DFBEH51b9E68LU64Vba7
	 RMUwYZW7MV046BNH9wMCx14bXHuha8DzGm+N3XHG4uKPjkQkg1TADMCkFZOMVZAR+n
	 pj9K2DGxNtq5oZeD/mYATxoyfLW2+ib0BAm07oA6UXRkxRxMNeTDdPU69M5V9t8v6t
	 0/0E6MnrGg/FApVx3OmXSBcgczSlDK/tQsiCz187kWeny47nkrgqe6xgOostK7KyYl
	 aUnbV9U4i3arg==
From: Oded Gabbay <ogabbay@kernel.org>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 08/13] accel/habanalabs: fix error print
Date: Tue, 20 Feb 2024 18:01:24 +0200
Message-Id: <20240220160129.909714-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220160129.909714-1-ogabbay@kernel.org>
References: <20240220160129.909714-1-ogabbay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dani Liberman <dliberman@habana.ai>

The unmasking is for event and it can be other event than RAZWI.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/firmware_if.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/common/firmware_if.c b/drivers/accel/habanalabs/common/firmware_if.c
index 364d292c76fa..a3df7cf162d8 100644
--- a/drivers/accel/habanalabs/common/firmware_if.c
+++ b/drivers/accel/habanalabs/common/firmware_if.c
@@ -526,7 +526,7 @@ int hl_fw_unmask_irq(struct hl_device *hdev, u16 event_type)
 						0, &result);
 
 	if (rc)
-		dev_err(hdev->dev, "failed to unmask RAZWI IRQ %d", event_type);
+		dev_err(hdev->dev, "failed to unmask event %d", event_type);
 
 	return rc;
 }
@@ -565,7 +565,7 @@ int hl_fw_unmask_irq_arr(struct hl_device *hdev, const u32 *irq_arr,
 						total_pkt_size, 0, &result);
 
 	if (rc)
-		dev_err(hdev->dev, "failed to unmask IRQ array\n");
+		dev_err(hdev->dev, "failed to unmask event array\n");
 
 	kfree(pkt);
 
-- 
2.34.1


