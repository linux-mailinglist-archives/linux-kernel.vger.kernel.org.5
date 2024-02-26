Return-Path: <linux-kernel+bounces-80707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1CF866B85
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2341C2014F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9B91C6B4;
	Mon, 26 Feb 2024 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzK8CBJx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92481BF47
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708934198; cv=none; b=aKXqZ0yPbWFKxNHS3jMnGnhyUYFoPwy5VbFuf6OAg3OMlxJas1QWUTgSvOeO17mg9KK6zRclx+t/YQB42t1v6rhP3yvwv7NUAFIeW8x0TTv+93GYE/ywjgbhCXX+aUPoV0xO7eJ84jqM7dBL26YVpFwfiMXs+c20b2HMSzxam9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708934198; c=relaxed/simple;
	bh=84cLmzGKsz74YXmtijIhaTWDvHtAQEPl3W7uQ8uYHpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PvDG0q/3dp2VsQc9kNxWTPXof4ISLPXH4a7gtoQOgihJyP7BDyfUU27bLIxTIXVKGRD8N15SsiVzL2pc3ga7GfcAOj5VD/4w8Z58/cNboAFJ2ScwsXX3MDUfcvEpRuuSlD9rqExgZhiAnvaxXpqVqu+CJeE/6VJzwF7kx4miI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzK8CBJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112CFC433F1;
	Mon, 26 Feb 2024 07:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708934197;
	bh=84cLmzGKsz74YXmtijIhaTWDvHtAQEPl3W7uQ8uYHpI=;
	h=From:To:Cc:Subject:Date:From;
	b=tzK8CBJxTk2J4R9IlN5TsZjaPrgKx1GeK2OimIfwbDYCed8dMt0HrpXPd/UPRpQnu
	 6pYQSUO32VZKn4j0AUkpUUqIFrUkTEurrzNAPuVywTBwaHKbZUGG5AVvMamLp0X3fX
	 Lt/MX4dDupkGt37PD1q/GU0yQUXr2gRcAOWtkfP2z6tCAer5s988OJGPyYWXCU/lLb
	 VpLUULLP9DeYlv2Bm+iq4qs2G3hP8FE5xJwC0dJKlGVVbOsN8HnxlG5qp0V1XhVsqC
	 F47lj+MJrWEO7KVmE6oWbi0Pup8hw3CnAZqtZBo9cDndZ1eoyA+EZrh6052LdNO0mk
	 BIRHcdgGSKM4Q==
From: Oded Gabbay <ogabbay@kernel.org>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Carl Vanderlip <quic_carlv@quicinc.com>
Cc: Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 1/3] accel/habanalabs/gaudi2: initialize field in correct function
Date: Mon, 26 Feb 2024 09:56:24 +0200
Message-Id: <20240226075626.1222534-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ohad Sharabi <osharabi@habana.ai>

supports_advanced_cpucp_rc is an asic property which should be
initialized in the gaudi2_set_fixed_properties(), where all of the
asic properties are initialized.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index fa1c4feb9f89..5be3432d29b3 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -2601,6 +2601,8 @@ static int gaudi2_set_fixed_properties(struct hl_device *hdev)
 
 	prop->hbw_flush_reg = mmPCIE_WRAP_SPECIAL_GLBL_SPARE_0;
 
+	prop->supports_advanced_cpucp_rc = true;
+
 	return 0;
 
 free_qprops:
@@ -3308,8 +3310,6 @@ static int gaudi2_late_init(struct hl_device *hdev)
 	struct gaudi2_device *gaudi2 = hdev->asic_specific;
 	int rc;
 
-	hdev->asic_prop.supports_advanced_cpucp_rc = true;
-
 	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_ENABLE_PCI_ACCESS,
 					gaudi2->virt_msix_db_dma_addr);
 	if (rc) {
-- 
2.34.1


