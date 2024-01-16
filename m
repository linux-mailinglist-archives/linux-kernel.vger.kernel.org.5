Return-Path: <linux-kernel+bounces-27941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6D982F81D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6442885A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665E112D298;
	Tue, 16 Jan 2024 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6ED+2Cv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C6012D281;
	Tue, 16 Jan 2024 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434628; cv=none; b=cwsBWW9DqwRPXrTqTDUn4gysmLNCtpmmaGocJYvej5RA8M3oQU3RgOnRIIGk+o9FC8uQUO7iyBhufqDHNHABNx9eHtYpTt780G9MuZYSCtvURbV4vODklwCYmx17NkXPzx/KurISGaoBtMsxnw7hiiRbilzS5T35QjyrePZDbFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434628; c=relaxed/simple;
	bh=6IgYL5SnuaELuOcHIBQzCwdSCyfs6lnHzt0aCcaMJZ4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=ckyYCJYqy+QJCAtFzlqcGa/DQse37EEoRRh8qj/O3CpLh3npP/n26xVg8jsUIMtqUJEhJu/4lh3t4D7EfveK5M0cHaRzFFDiq/K5s18UUmN+wpQYVUNlUeneil5xUxRY05iTnqvEIB9obU3aENTzs/I/We+fbjjQxjsfXujc2C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6ED+2Cv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853C6C433F1;
	Tue, 16 Jan 2024 19:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434628;
	bh=6IgYL5SnuaELuOcHIBQzCwdSCyfs6lnHzt0aCcaMJZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j6ED+2CvSCHPJPu17BZPwBwoGzlH7fijr6X3d2kdNQ1L2AKU6AiC7U0xy459RQZOP
	 Xi1411c+t2UoYAI+aFu1Vq4n3/Tdq53zCCOtyh8KK+nE968qc5rBGFt/PegEIUFfRJ
	 VAKkWd00xZ9Cx78cjIc2+lHS1QCzqZAWgmydQGz/w/xYsEU4BfhgdcAPvdJGp3gF81
	 a3ljS9jzIw772G/E6VSTCV6SsKr2IdSG+LlWjJvNVH9bSUdkXUQtCO+DCYnmZEdlYI
	 4D9DAWRsa9g933gddSUH0ldmjkX2UaoTdFB2ZkbcbM9ORY8JLfMk7Pz0Y34y9W+X9v
	 KHmXhcLkaoplw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 033/104] wifi: ath11k: fix race due to setting ATH11K_FLAG_EXT_IRQ_ENABLED too early
Date: Tue, 16 Jan 2024 14:45:59 -0500
Message-ID: <20240116194908.253437-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit 5082b3e3027eae393a4e86874bffb4ce3f83c26e ]

We are seeing below error randomly in the case where only
one MSI vector is configured:

kernel: ath11k_pci 0000:03:00.0: wmi command 16387 timeout

The reason is, currently, in ath11k_pcic_ext_irq_enable(),
ATH11K_FLAG_EXT_IRQ_ENABLED is set before NAPI is enabled.
This results in a race condition: after
ATH11K_FLAG_EXT_IRQ_ENABLED is set but before NAPI enabled,
CE interrupt breaks in. Since IRQ is shared by CE and data
path, ath11k_pcic_ext_interrupt_handler() is also called
where we call disable_irq_nosync() to disable IRQ. Then
napi_schedule() is called but it does nothing because NAPI
is not enabled at that time, meaning
ath11k_pcic_ext_grp_napi_poll() will never run, so we have
no chance to call enable_irq() to enable IRQ back. Finally
we get above error.

Fix it by setting ATH11K_FLAG_EXT_IRQ_ENABLED after all
NAPI and IRQ work are done. With the fix, we are sure that
by the time ATH11K_FLAG_EXT_IRQ_ENABLED is set, NAPI is
enabled.

Note that the fix above also introduce some side effects:
if ath11k_pcic_ext_interrupt_handler() breaks in after NAPI
enabled but before ATH11K_FLAG_EXT_IRQ_ENABLED set, nothing
will be done by the handler this time, the work will be
postponed till the next time the IRQ fires.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20231117003919.26218-1-quic_bqiang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/pcic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index c63083633b37..011cf5fb8023 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -460,8 +460,6 @@ void ath11k_pcic_ext_irq_enable(struct ath11k_base *ab)
 {
 	int i;
 
-	set_bit(ATH11K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags);
-
 	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
 		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
 
@@ -471,6 +469,8 @@ void ath11k_pcic_ext_irq_enable(struct ath11k_base *ab)
 		}
 		ath11k_pcic_ext_grp_enable(irq_grp);
 	}
+
+	set_bit(ATH11K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags);
 }
 EXPORT_SYMBOL(ath11k_pcic_ext_irq_enable);
 
-- 
2.43.0


