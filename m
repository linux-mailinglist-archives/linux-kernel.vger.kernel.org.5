Return-Path: <linux-kernel+bounces-26666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7DE82E4E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A40A1F24943
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D244D1B80C;
	Tue, 16 Jan 2024 00:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lE2oLfsI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E113208BE;
	Tue, 16 Jan 2024 00:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416A5C433C7;
	Tue, 16 Jan 2024 00:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364061;
	bh=sjjdLPsyNBEcfCkG6K7wHcW7nWj7WzfWPamEQ/GvElk=;
	h=From:To:Cc:Subject:Date:From;
	b=lE2oLfsIcFEt9gxSeQc47Wju1oc3k8EVItKoENDlhZJvdLjDiigv7h9A6ikqoZjdW
	 NWqmiDIo51PGmafm6LxHYK7jhXfqk8l3CFIwMaNdwVeRNRxgk5CIjLT7mAJFMBuHNY
	 ReMZ4p9JDoWdG8j8ca9ag/KXHN57L46tv/pI0MA/9zKKFEAWpH/QQ7UU/FkWhNDNGq
	 maM/A79viaFsqffuxdkiUFLPg/E2sqT4TwmWlZhdZF7xmdBaPwc2GOyQdAm7vz1SOL
	 ks8jH/jivWpnGJmK5SfP6SHPCs2WMQn+zwFl/zuug3Vd7eAi1XpbpLoDhLZHqx2kk9
	 YjPoklMFLlplg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rui Zhang <zr.zhang@vivo.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 6.1 1/9] regulator: core: Only increment use_count when enable_count changes
Date: Mon, 15 Jan 2024 19:14:06 -0500
Message-ID: <20240116001418.213635-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Rui Zhang <zr.zhang@vivo.com>

[ Upstream commit 7993d3a9c34f609c02171e115fd12c10e2105ff4 ]

The use_count of a regulator should only be incremented when the
enable_count changes from 0 to 1. Similarly, the use_count should
only be decremented when the enable_count changes from 1 to 0.

In the previous implementation, use_count was sometimes decremented
to 0 when some consumer called unbalanced disable,
leading to unexpected disable even the regulator is enabled by
other consumers. With this change, the use_count accurately reflects
the number of users which the regulator is enabled.

This should make things more robust in the case where a consumer does
leak references.

Signed-off-by: Rui Zhang <zr.zhang@vivo.com>
Link: https://lore.kernel.org/r/20231103074231.8031-1-zr.zhang@vivo.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/core.c | 56 +++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 34d3d8281906..c8702011b761 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2925,7 +2925,8 @@ static int _regulator_enable(struct regulator *regulator)
 		/* Fallthrough on positive return values - already enabled */
 	}
 
-	rdev->use_count++;
+	if (regulator->enable_count == 1)
+		rdev->use_count++;
 
 	return 0;
 
@@ -3000,37 +3001,40 @@ static int _regulator_disable(struct regulator *regulator)
 
 	lockdep_assert_held_once(&rdev->mutex.base);
 
-	if (WARN(rdev->use_count <= 0,
+	if (WARN(regulator->enable_count == 0,
 		 "unbalanced disables for %s\n", rdev_get_name(rdev)))
 		return -EIO;
 
-	/* are we the last user and permitted to disable ? */
-	if (rdev->use_count == 1 &&
-	    (rdev->constraints && !rdev->constraints->always_on)) {
-
-		/* we are last user */
-		if (regulator_ops_is_valid(rdev, REGULATOR_CHANGE_STATUS)) {
-			ret = _notifier_call_chain(rdev,
-						   REGULATOR_EVENT_PRE_DISABLE,
-						   NULL);
-			if (ret & NOTIFY_STOP_MASK)
-				return -EINVAL;
-
-			ret = _regulator_do_disable(rdev);
-			if (ret < 0) {
-				rdev_err(rdev, "failed to disable: %pe\n", ERR_PTR(ret));
-				_notifier_call_chain(rdev,
-						REGULATOR_EVENT_ABORT_DISABLE,
+	if (regulator->enable_count == 1) {
+	/* disabling last enable_count from this regulator */
+		/* are we the last user and permitted to disable ? */
+		if (rdev->use_count == 1 &&
+		    (rdev->constraints && !rdev->constraints->always_on)) {
+
+			/* we are last user */
+			if (regulator_ops_is_valid(rdev, REGULATOR_CHANGE_STATUS)) {
+				ret = _notifier_call_chain(rdev,
+							   REGULATOR_EVENT_PRE_DISABLE,
+							   NULL);
+				if (ret & NOTIFY_STOP_MASK)
+					return -EINVAL;
+
+				ret = _regulator_do_disable(rdev);
+				if (ret < 0) {
+					rdev_err(rdev, "failed to disable: %pe\n", ERR_PTR(ret));
+					_notifier_call_chain(rdev,
+							REGULATOR_EVENT_ABORT_DISABLE,
+							NULL);
+					return ret;
+				}
+				_notifier_call_chain(rdev, REGULATOR_EVENT_DISABLE,
 						NULL);
-				return ret;
 			}
-			_notifier_call_chain(rdev, REGULATOR_EVENT_DISABLE,
-					NULL);
-		}
 
-		rdev->use_count = 0;
-	} else if (rdev->use_count > 1) {
-		rdev->use_count--;
+			rdev->use_count = 0;
+		} else if (rdev->use_count > 1) {
+			rdev->use_count--;
+		}
 	}
 
 	if (ret == 0)
-- 
2.43.0


