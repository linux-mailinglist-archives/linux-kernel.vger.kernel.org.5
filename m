Return-Path: <linux-kernel+bounces-33287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AE783685E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FA78B23B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9375C604;
	Mon, 22 Jan 2024 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rva5Fze+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD7E5C5E1;
	Mon, 22 Jan 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935618; cv=none; b=mg+mXFATAMH8eL3KyD1MmDVHKAPN8YWucIJ5HH/8Wky+7Aitw3mY4/Ntxy390raQqvFB015jykPciPMJxnqLXIGHzWtfzIsHTp4K075H+Xy/spOSmfwyJvV7rPTekZVVhEm0EkyVF5Iks6h698E8f/m3OXlaWGaUGxkNAfa//OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935618; c=relaxed/simple;
	bh=A/TAgBJ5S5ecaDYVh/AFraU1HRZT/Ni7tZ1z5SbonRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LiBqFpGPQ05dN+qakgUF+7l3iyQyk8BtW4pRXSfRMwTiUqGytjo4++hX7QaT8/M3YcyynxzHlRfVnjT9lp+pSpkTifGrwXR7N8JUhoU9A9Ro+ba5un/fa7TOQzvDCaL512glpKcGpZyG+VENq+3GDaELFMX/PAp5NRv5mY6Ow5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rva5Fze+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F22C433B2;
	Mon, 22 Jan 2024 15:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935618;
	bh=A/TAgBJ5S5ecaDYVh/AFraU1HRZT/Ni7tZ1z5SbonRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rva5Fze+at2e9tFOQNipgKgKvmiXEph2CNTxMnE0G2Jk8iB4Q7Gf1rXZzNIjnkp6g
	 a5yoAw0XjIGIW0jazdALoeEbjCZtBN5QIJXBTX5+5Ee9EToK8Og8Ky0DUjL9HCNr5R
	 V4Mcngj75R5ygRW287MXDyjY95YtI+YrZBtVsUrrmtX5aGgQnXPyZ5mcRi43mKHICR
	 NH532Ip8R4F8CUpgB4/sNiRCY5KpTZ2f3cv1SA/SWX7Dybgu0hTBPRHBSoDlVYady0
	 tuaV+vzkKVDIWJ57UI+14oTAjW1mPFPvKdWcxvGYE3rOwk+mbLMMvJG3GHmf3zfcZc
	 xLd4aiiXawXeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dafna Hirschfeld <dhirschfeld@habana.ai>,
	Oded Gabbay <ogabbay@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	obitton@habana.ai,
	dliberman@habana.ai,
	ttayar@habana.ai,
	kelbaz@habana.ai,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 65/88] accel/habanalabs/gaudi2: fix undef opcode reporting
Date: Mon, 22 Jan 2024 09:51:38 -0500
Message-ID: <20240122145608.990137-65-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

[ Upstream commit 0ec346779644039c4c05cfa7f071b1a24e54d8d9 ]

currently the undefined opcode event bit in set only for lower cp and
only if 'write_enable' is true. It should be set anyway and for all
streams in order to report that event to userspace.

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 819660c684cf..bc6e338ef2fd 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -7929,21 +7929,19 @@ static int gaudi2_handle_qman_err_generic(struct hl_device *hdev, u16 event_type
 				error_count++;
 			}
 
-		if (i == QMAN_STREAMS && error_count) {
-			/* check for undefined opcode */
-			if (glbl_sts_val & PDMA0_QM_GLBL_ERR_STS_CP_UNDEF_CMD_ERR_MASK &&
-					hdev->captured_err_info.undef_opcode.write_enable) {
+		/* check for undefined opcode */
+		if (glbl_sts_val & PDMA0_QM_GLBL_ERR_STS_CP_UNDEF_CMD_ERR_MASK) {
+			*event_mask |= HL_NOTIFIER_EVENT_UNDEFINED_OPCODE;
+			if (hdev->captured_err_info.undef_opcode.write_enable) {
 				memset(&hdev->captured_err_info.undef_opcode, 0,
 						sizeof(hdev->captured_err_info.undef_opcode));
-
-				hdev->captured_err_info.undef_opcode.write_enable = false;
 				hdev->captured_err_info.undef_opcode.timestamp = ktime_get();
 				hdev->captured_err_info.undef_opcode.engine_id =
 							gaudi2_queue_id_to_engine_id[qid_base];
-				*event_mask |= HL_NOTIFIER_EVENT_UNDEFINED_OPCODE;
 			}
 
-			handle_lower_qman_data_on_err(hdev, qman_base, *event_mask);
+			if (i == QMAN_STREAMS)
+				handle_lower_qman_data_on_err(hdev, qman_base, *event_mask);
 		}
 	}
 
-- 
2.43.0


