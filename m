Return-Path: <linux-kernel+bounces-26407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A6882E031
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E161F2296D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987A018AE1;
	Mon, 15 Jan 2024 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0v+juD4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76CE18646
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 18:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBD9C433C7;
	Mon, 15 Jan 2024 18:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705344162;
	bh=0e9tVn+FNGLr7RXH+YBjqOTRWHfqCyuIDty9nT2Bl60=;
	h=From:Date:Subject:To:Cc:From;
	b=g0v+juD4ISQdgkUQajGj2XCROOqOnR/D2whSJF2Vd6PDbiSW/TlS0LDy7T1CaY1Q9
	 HGNqBw43eG3DWBUJjGdseR5E6X4BOuJlGREvNztVLl5zpl2QSi59SXyziI6gsIKaIa
	 4Los9dHGdX7ocyxr+LA092EtuQg9aEnWQdMvao+DaYJXP8vRkWhTjCfJiUvG0d2BVj
	 CtH6f15gLETgV5mc/cIUGPcixTuU4rfNTtgWKGhBWDJqkYb/39ymSRCcYFgVHVmi0t
	 nmNjiWQZxx6jTWuykpWe4/Aww6xjlVb/8ACx3kmSjiaIGBoepT8kJXxV0WCgOv9c4f
	 X0U/im7fQuucw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 15 Jan 2024 18:42:38 +0000
Subject: [PATCH] arm64/ptrace: Don't flush ZA/ZT storage when writing ZA
 via ptrace
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240115-arm64-fix-ptrace-za-zt-v1-1-48617517028a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJ18pWUC/x2MMQqAMAwAvyKZDbSldvAr4hA01QxqSUVE6d8tj
 gd390JmFc7QNy8oX5Ll2CvYtoFppX1hlLkyOOO8saZD0i14jHJjOpUmxofwObGLwVOwcQ7WQY2
 TcnX+8TCW8gHB9a9SaAAAAA==
To: Oleg Nesterov <oleg@redhat.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1637; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0e9tVn+FNGLr7RXH+YBjqOTRWHfqCyuIDty9nT2Bl60=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlpXygOHcQfoBfSOoQVEOrxzFQdYkeOWc3cp8j/aXr
 0O/ZlimJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZaV8oAAKCRAk1otyXVSH0FP+B/
 9Il7QHh2iaP+xU3Vz6qvGOneH3frjzkoSsXoVw71qDmN5VAOsQQ2VgeKBLR/XA9u4tTL7E0ikOvK/r
 5K38Nc0Lyk/8f5g5cgd9ogBWnSCqoPKqELdwGbZDU1UpYELQe7UbmXvpLnqfw3af/9uEnXwZpjW7Rv
 kzGwjzrOwwD4Kup9OVzm1VWIWHbg4XgqQxWVA5LqGaiswQyt2jphqojlnhYIubHCiyUntNYhC4wtAU
 vAIzvdpbiJbKVlOS4pu5Db0TCZgDAl/IocDarXm2e30mPVK8oUMnTJrbam3CE9vkzIFLeTo6b50ElP
 uJXnX3cD932BWbQY6SH7YJE97MffOB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When writing ZA we currently unconditionally flush the buffer used to store
it as part of ensuring that it is allocated. Since this buffer is shared
with ZT0 this means that a write to ZA when PSTATE.ZA is already set will
corrupt the value of ZT0 on a SME2 system. Fix this by only flushing the
backing storage if PSTATE.ZA was not previously set.

This will mean that short or failed writes may leave stale data in the
buffer, this seems as correct as our current behaviour and unlikely to be
something that userspace will rely on.

Fixes: f90b529bcbe5 ("arm64/sme: Implement ZT0 ptrace support")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/ptrace.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 20d7ef82de90..b3f64144b5cd 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1107,12 +1107,13 @@ static int za_set(struct task_struct *target,
 		}
 	}
 
-	/* Allocate/reinit ZA storage */
-	sme_alloc(target, true);
-	if (!target->thread.sme_state) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	/*
+	 * Only flush the storage if PSTATE.ZA was not already set,
+	 * otherwise preserve any existing data.
+	 */
+	sme_alloc(target, !thread_za_enabled(&target->thread));
+	if (!target->thread.sme_state)
+		return -ENOMEM;
 
 	/* If there is no data then disable ZA */
 	if (!count) {

---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240105-arm64-fix-ptrace-za-zt-5f64a61fd612

Best regards,
-- 
Mark Brown <broonie@kernel.org>


