Return-Path: <linux-kernel+bounces-73290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D518F85C08D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65753B2467E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BD9768ED;
	Tue, 20 Feb 2024 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRUGaNxT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4CA76419
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444899; cv=none; b=gtk9gzh7X23R4vG+FqZSFZpf+2NEXWBjMS4B8Tf/RNAfvU0aMu1BmDKZQkT0i+OPuWrGQNvb8FS/Dh5SthQbIREOx5mTeg4TDofBHPBFsshEl+XCvrGkPecm9d9oz/pGDwQeYxLyaL6H4VVnX4o0S8QbxLkoPbvGatSAMrVYQqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444899; c=relaxed/simple;
	bh=MXw5mtakAsN2KGERNoMcdt1TmIcnXzEjipcYgllps+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sVdw3WVToEMXPmLdkqJLdXqyceUVHRddl5FdlPF6so5/IH1VgztCW3tklQ0rSHLGL0wZbYcOXP8rXANWq6yNRi6MC1Mj+egnzzSikTAdpUz/UsG/T+VvzAAThTm9s6pARjr5u2JlOUcAPQOMeNk3JBUCneGYwC6jhZlvn2zDFR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRUGaNxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF41C433F1;
	Tue, 20 Feb 2024 16:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708444899;
	bh=MXw5mtakAsN2KGERNoMcdt1TmIcnXzEjipcYgllps+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fRUGaNxTDlkcl38NZlpwehCkkIrZuPrjZDmW8Od+5xiNnTLg1HG/1/Mxb/br07tR5
	 W+sPskKHRJjdNMTDNiJP0+jRggx+ESudVC/VEoz0qQkC+5GPqE3uXvuT7kaxQfX+8e
	 3kpDpOaVAoylHiawikSyEVsBqgSneWiGvwftk+AEn8OVchTEeKEp/sEAb69KcQnfRx
	 OtYvwJ1t1+t1jwcnrXdje5WBmmJLCkf3RJ3ur4twpjAKcmJwFFRiFziDR0x44HvRMy
	 g8KQpaE26rfNbkU/qLhmMKZMYe5+28jbr7pDNyB8tpQL+EkDxRn/AUJ8yE5/v8FsRE
	 J2MpN+9NEepMw==
From: Oded Gabbay <ogabbay@kernel.org>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 04/13] accel/habanalabs/gaudi2: check extended errors according to PCIe addr_dec interrupt info
Date: Tue, 20 Feb 2024 18:01:20 +0200
Message-Id: <20240220160129.909714-4-ogabbay@kernel.org>
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

From: Tomer Tayar <ttayar@habana.ai>

The FW interrupt info for a PCIe addr_dec event is set correctly, so
check for either global errors or razwi according to the indications
there.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 26975179763a..671241735a6e 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -8942,9 +8942,6 @@ static int gaudi2_print_pcie_addr_dec_info(struct hl_device *hdev, u16 event_typ
 	u32 error_count = 0;
 	int i;
 
-	gaudi2_print_event(hdev, event_type, true,
-		"intr_cause_data: %#llx", intr_cause_data);
-
 	for (i = 0 ; i < GAUDI2_NUM_OF_PCIE_ADDR_DEC_ERR_CAUSE ; i++) {
 		if (!(intr_cause_data & BIT_ULL(i)))
 			continue;
@@ -8953,15 +8950,16 @@ static int gaudi2_print_pcie_addr_dec_info(struct hl_device *hdev, u16 event_typ
 			"err cause: %s", gaudi2_pcie_addr_dec_error_cause[i]);
 		error_count++;
 
-		/*
-		 * Always check for LBW and HBW additional info as the indication itself is
-		 * sometimes missing
-		 */
+		switch (intr_cause_data & BIT_ULL(i)) {
+		case PCIE_WRAP_PCIE_IC_SEI_INTR_IND_AXI_LBW_ERR_INTR_MASK:
+			hl_check_for_glbl_errors(hdev);
+			break;
+		case PCIE_WRAP_PCIE_IC_SEI_INTR_IND_BAD_ACCESS_INTR_MASK:
+			gaudi2_print_pcie_mstr_rr_mstr_if_razwi_info(hdev, event_mask);
+			break;
+		}
 	}
 
-	hl_check_for_glbl_errors(hdev);
-	gaudi2_print_pcie_mstr_rr_mstr_if_razwi_info(hdev, event_mask);
-
 	return error_count;
 }
 
-- 
2.34.1


