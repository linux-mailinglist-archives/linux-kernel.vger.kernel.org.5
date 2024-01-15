Return-Path: <linux-kernel+bounces-26448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9B182E0FE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE461F22CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6858718E2E;
	Mon, 15 Jan 2024 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ptn/wBvo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92C118E27
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 19:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E468EC433F1;
	Mon, 15 Jan 2024 19:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705348412;
	bh=jx6MCcQ7uLIq8gq6+Ob0A16MFAG6K9KviDKmyys205A=;
	h=From:Date:Subject:To:Cc:From;
	b=Ptn/wBvo5xbUZOzh6lqMrmovB1iRTtg+LINTmsgRhJ4/kuaAeh1rYjhOOA0uzgQ/j
	 EGK4E4HyV3PflDA1cyx6WjQTkSwM3GWJX/k93PgNVdutTo0bCaMU9Fm/0UhNdX3GT/
	 AEMY0MHVJOc+oq3bXQHGDdbj9KUxWT20paqXKKlJTucDmhW2HS++8bIvfU6p6DJ7+S
	 I1U+lSjck7cvLOLqxq8IHXVMVKDD6xH6B6TsMuLcv9LJODEWBl/Y889gN+kU9IADEr
	 OI6mJCZnuNusDe795yjl7I/7wTigJ/SbrcCmG/hfR7bum89bXdUNd8HvxE70znWuGv
	 P0P9RhI4gYLkw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 15 Jan 2024 19:53:01 +0000
Subject: [PATCH] arm64/fpsimd: Remove spurious check for SVE support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240115-arm64-sve-enabled-check-v1-1-a26360b00f6d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAByNpWUC/x3MQQqDMBBG4avIrB1IrGjtVcRFnPzWQRslgVAQ7
 97Q5bd476KEqEj0qi6KyJr0CAW2rkhWF95g9cXUmKY11hp28dO1nDIYwc07PMsK2bh/iBcz934
 YnlTqM2LR7/88Tvf9AyrqSjVpAAAA
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jx6MCcQ7uLIq8gq6+Ob0A16MFAG6K9KviDKmyys205A=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlpY05ck2UycHnpMpz8rLd+exIRRY88PsowdptD/Ug
 zDSIo0OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZaWNOQAKCRAk1otyXVSH0Ny+B/
 42mb7gVgMzJLswC7zdZzsbCjSl5ICwzLm8NWeEoCRwGXH9SlQv3DXSEZOhsuaIYF8ISu8e+aS2P96Z
 NGpbWknp6nDV+4efFn0Q0rNCMo0lVWUg+2FjKNmNZkrhGOz/uQr+VeFavkLZvoL9FNFwNrCLEw/72g
 X3x66f5/aumf6C3nxQcCuAmoqvY3FL0cYJcxv8oEio2k6qvwsBTiMe4eJ2L/vjv4r+yK3+mz9vYlZD
 JBdAQ6g5RhonLPxIm9D+s4pnm7GFM4kebSF1nOAdyuoxZPMOqnjAMhej4V51/xv29J+Y/AhzarLO8v
 sF7d2yU3V4pEjsBvfnpt/ryOJK0pvU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

There is no need to check for SVE support when changing vector lengths,
even if the system is SME only we still need SVE storage for the streaming
SVE state.

Fixes: d4d5be94a878 (arm64/fpsimd: Ensure SME storage is allocated after SVE VL changes)
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 1559c706d32d..66b31cebead8 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -924,10 +924,8 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 	 * allocate SVE now in case it is needed for use in streaming
 	 * mode.
 	 */
-	if (system_supports_sve()) {
-		sve_free(task);
-		sve_alloc(task, true);
-	}
+	sve_free(task);
+	sve_alloc(task, true);
 
 	if (free_sme)
 		sme_free(task);

---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240110-arm64-sve-enabled-check-73cdc0b7d998

Best regards,
-- 
Mark Brown <broonie@kernel.org>


