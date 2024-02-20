Return-Path: <linux-kernel+bounces-73295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA5885C093
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B119A1F22D96
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D7A7765F;
	Tue, 20 Feb 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5y9VUbm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D79F7764D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444908; cv=none; b=Eit8LyyyrH8xfQv5KPs5ES3IYfXzgHtao/4A0haN3AGRIgNf4I9xRZx2HvkJNfFpVrQ/fXbgJmB+iktJRSQWhSN8A6YtOBiyKEbGqgcr5t8P5pdBb7Zf1gKn7Mbrn5LewknA4Xxsv4strQwreRDwoEgJEUCJonJ8LuGQt6qg8lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444908; c=relaxed/simple;
	bh=dE659u+PsA/pnXbkHphHYL9rdcftJ4ufBepP1CdHia4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jJScoqoGW0ZtRkkVGF80aNuO2SC5bPrFINst7qXn9pnlWsGTh0iW+y0KbliAUi1u3EHA0xjbwwmN1CNAC3jufEIgxqxie1mlI/dAxJWPfq0xbPWLHyZpiXPp5W/GPvDGB9TeI1u3i+GYxhWcQqTXyiAHRSuEObQQxt42bmIAz+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5y9VUbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1927C433C7;
	Tue, 20 Feb 2024 16:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708444907;
	bh=dE659u+PsA/pnXbkHphHYL9rdcftJ4ufBepP1CdHia4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q5y9VUbm1WjFPmyTZ4HbSgazoNzYEia6GrXLgR72zC7W2Ng+TWYgdZyGdBSBqMv8k
	 bntTj8b8C9hq+S1+iLxK65pmgj0Q3/2XBRt4Gaomd8ZbmLw5+eq3knGvOIw+895H9/
	 t+xg2+paSMwn3KO0C7U5GHpTiTs9tRejaB47YgrP6my1eYVM4zn1X7MekXhjVAns7B
	 m9NjcapMppuxzSQsoCXHQOEafzRcD5QWmtouEAkQXFI3cFIIT/e7y86JQjHINiNg/5
	 S+zIuRIZGktzTFd0KOF15dfl0sqkFdm4iZSp+mLj/bUX3i8CoegkEzSkFPvkpRkXYT
	 DWZXcYFbVCW2g==
From: Oded Gabbay <ogabbay@kernel.org>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 09/13] accel/habanalabs/gaudi2: drain event lacks rd/wr indication
Date: Tue, 20 Feb 2024 18:01:25 +0200
Message-Id: <20240220160129.909714-9-ogabbay@kernel.org>
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

From: Ofir Bitton <obitton@habana.ai>

Due to a H/W issue, AXI drain event does not include a read/write
indication, hence we remove this print.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 189d8da6a624..ba1518f2bf5c 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -9548,25 +9548,17 @@ static int gaudi2_handle_pcie_p2p_msix(struct hl_device *hdev, u16 event_type)
 static int gaudi2_handle_pcie_drain(struct hl_device *hdev,
 			struct hl_eq_pcie_drain_ind_data *drain_data)
 {
-	u64 lbw_rd, lbw_wr, hbw_rd, hbw_wr, cause, error_count = 0;
+	u64 cause, error_count = 0;
 
 	cause = le64_to_cpu(drain_data->intr_cause.intr_cause_data);
-	lbw_rd = le64_to_cpu(drain_data->drain_rd_addr_lbw);
-	lbw_wr = le64_to_cpu(drain_data->drain_wr_addr_lbw);
-	hbw_rd = le64_to_cpu(drain_data->drain_rd_addr_hbw);
-	hbw_wr = le64_to_cpu(drain_data->drain_wr_addr_hbw);
 
 	if (cause & BIT_ULL(0)) {
-		dev_err_ratelimited(hdev->dev,
-			"PCIE AXI drain LBW completed, read_err %u, write_err %u\n",
-			!!lbw_rd, !!lbw_wr);
+		dev_err_ratelimited(hdev->dev, "PCIE AXI drain LBW completed\n");
 		error_count++;
 	}
 
 	if (cause & BIT_ULL(1)) {
-		dev_err_ratelimited(hdev->dev,
-			"PCIE AXI drain HBW completed, raddr %#llx, waddr %#llx\n",
-			hbw_rd, hbw_wr);
+		dev_err_ratelimited(hdev->dev, "PCIE AXI drain HBW completed\n");
 		error_count++;
 	}
 
-- 
2.34.1


