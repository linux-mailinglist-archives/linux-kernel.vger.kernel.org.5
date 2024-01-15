Return-Path: <linux-kernel+bounces-26471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E2782E16F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204DE1C221F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534CA1947C;
	Mon, 15 Jan 2024 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPqEnLF5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC4518EB2;
	Mon, 15 Jan 2024 20:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E72C433C7;
	Mon, 15 Jan 2024 20:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705349866;
	bh=hbvF2zJNkvnNPZrMPX0XPRUfiPsnEZS1lIR4xv3NkoU=;
	h=From:Date:Subject:To:Cc:From;
	b=oPqEnLF5Hexfow5DJQAq4T/eH1P+1dujL4Tlv5skvCXd7yDnG3IjP2hKFqspl/85x
	 DzLAqlxJRXoiZQTuG0Tg6stu6PWVrFQNeITf9wAapW7GNZNCfDp8Mh38W3WGc89HHz
	 /zP6pddK5st4IMmlsqq8Y/2105eKYOo6hzcVofk1qP9QEcvAJzbW1PLgxcx8t9Th9b
	 r85jhp4KW0uOALQm04tiuBBZiPcdQgT/2jXZ2TTz7GgQClVVQHxYKE1srm5vrqFm0x
	 kQoTvM4CPOSnFUqUsfCN8RsOpkok7s7wjsmTGJYFxWqkk9ZujOdvAqANKI135+NRPk
	 YnDkdJAARAcFg==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 15 Jan 2024 20:15:46 +0000
Subject: [PATCH] arm64/sme: Always exit sme_alloc() early with existing
 storage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240115-arm64-sme-flush-v1-1-7472bd3459b7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHGSpWUC/x3MTQqAIBBA4avErBtQkaCuEi1SxxzoD4ciCO+et
 PwW770glJkEhuaFTDcLH3uFbhvwad4XQg7VYJSxSmuDc946i7IRxvWShKp3wVvlnI0eanVmivz
 8x3Eq5QOsnnR1YQAAAA==
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hbvF2zJNkvnNPZrMPX0XPRUfiPsnEZS1lIR4xv3NkoU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlpZLnCdbCdkfdcefQ47pJjfDfPa6LkOOGHaTIu1aI
 QVlccIeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZaWS5wAKCRAk1otyXVSH0AKNB/
 4+VX/uyNw6PWsdrgvLLVtIVBln/gopyMmLZWzHYQOqOpAtlmvOUyeZc8TB/bfTLBSOuvtmeQszlGGw
 Mk/7SGEkxrRVo0wVNfM2R5/sH+dIb1+fZ3EtM63SRKsO6nUTxKiXb5tAyng6HzyB/kwrHSwd4ZwA/2
 YI8ACoXNvV5R2cu7qRYhnzI0GOa2CxqhSam0KXFvTvb9ST/LzmAc0qYwppCAvRCacZPG8mPEW7/bsp
 wH+6MEL2sRYseLh8np2x5mT03Dico0+/yRgGekjLn5/wB1UYw+O0piMgpgJ+Sextu8dj/pqvZsyXz+
 TleshIECm9xi+IYUEFp4LTFcB33EcR
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When sme_alloc() is called with existing storage and we are not flushing we
will always allocate new storage, both leaking the existing storage and
corrupting the state. Fix this by separating the checks for flushing and
for existing storage as we do for SVE.

Callers that reallocate (eg, due to changing the vector length) should
call sme_free() themselves.

Fixes: 5d0a8d2fba50 (arm64/ptrace: Ensure that SME is set up for target when writing SSVE state)
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc:  <stable@vger.kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 1559c706d32d..7363f2eb98e8 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1245,8 +1245,10 @@ void fpsimd_release_task(struct task_struct *dead_task)
  */
 void sme_alloc(struct task_struct *task, bool flush)
 {
-	if (task->thread.sme_state && flush) {
-		memset(task->thread.sme_state, 0, sme_state_size(task));
+	if (task->thread.sme_state) {
+		if (flush)
+			memset(task->thread.sme_state, 0,
+			       sme_state_size(task));
 		return;
 	}
 

---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240112-arm64-sme-flush-09bdc40bb4fc

Best regards,
-- 
Mark Brown <broonie@kernel.org>


