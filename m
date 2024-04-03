Return-Path: <linux-kernel+bounces-130334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 142D18976E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C103D296039
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6DF161315;
	Wed,  3 Apr 2024 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4tfyX95"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E904C16089C;
	Wed,  3 Apr 2024 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164770; cv=none; b=sVscr/rB1ENgdeMLxgaCJ46q3Uu53tNOkqDrrPBOQ4Aak+e25wk3BputD08gg3bWywfZdcLVFZ6nBne/lHfTVmQtqEoelRh2uq6QSACj/ziUaKW63r4kNRwDK84evygLsrLSn3iF6EE2dk3ZPDE6Oiyol3rL0vdZncnK4HbLT2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164770; c=relaxed/simple;
	bh=+molO8qQbX4QeS0LNGvlr/5BUWpD3H1OZtd27L7winI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tN3jsZlAu7uUSs7ymi259pheYAlSmjVzzsgszu+2PsAYSNMcOcCYaGO8+d17oXoVbBvwodzKeeRPYoKcAtFhAm5mDZ27lXgPI04zBzd3Kb8inZDxWrm2exV7yZ+7wQnhsYVzGZwuf7ke3ikDXmd3xgcDOwsGKNIR9h9qd0d8NpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4tfyX95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BCAC43601;
	Wed,  3 Apr 2024 17:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164769;
	bh=+molO8qQbX4QeS0LNGvlr/5BUWpD3H1OZtd27L7winI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N4tfyX9523InZf76ZS28KGIE7ScybkYQvu3ioScsFkk+7C+11r+xPxbqFlufi9C8a
	 3hrdIHCVlWbV1XtT3jRFFKcYjSE0ra6GSOEpKBUXAUuOEgHjH/JmmiirGJf0rxtvke
	 PUd1cl3nzxUGDaLZDflBU96Rm3wdAvJG3Yor2UYfpwQkD7T3oi4VHK/1OK/g3Gcwto
	 4NiVK3jEvogR0n7DSuB20kPJbEnI/HxQKtF6+6xrx9ZiSI1+ufTW/kPVGh0LSqSHCn
	 w0mWhD7veOmpaQZVnCBc1MB5coaO86sngLunZ8p5eBtHzOMkIxrih4UOB9VLbZQjpa
	 IC2UroOmmP+gA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 09/15] thermal/of: Assume polling-delay(-passive) 0 when absent
Date: Wed,  3 Apr 2024 13:18:53 -0400
Message-ID: <20240403171909.345570-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171909.345570-1-sashal@kernel.org>
References: <20240403171909.345570-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.84
Content-Transfer-Encoding: 8bit

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 488164006a281986d95abbc4b26e340c19c4c85b ]

Currently, thermal zones associated with providers that have interrupts
for signaling hot/critical trips are required to set a polling-delay
of 0 to indicate no polling. This feels a bit backwards.

Change the code such that "no polling delay" also means "no polling".

Suggested-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240125-topic-thermal-v1-2-3c9d4dced138@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_of.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 4104743dbc17e..202dce0d2e309 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -337,14 +337,18 @@ static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdel
 	int ret;
 
 	ret = of_property_read_u32(np, "polling-delay-passive", pdelay);
-	if (ret < 0) {
-		pr_err("%pOFn: missing polling-delay-passive property\n", np);
+	if (ret == -EINVAL) {
+		*pdelay = 0;
+	} else if (ret < 0) {
+		pr_err("%pOFn: Couldn't get polling-delay-passive: %d\n", np, ret);
 		return ret;
 	}
 
 	ret = of_property_read_u32(np, "polling-delay", delay);
-	if (ret < 0) {
-		pr_err("%pOFn: missing polling-delay property\n", np);
+	if (ret == -EINVAL) {
+		*delay = 0;
+	} else if (ret < 0) {
+		pr_err("%pOFn: Couldn't get polling-delay: %d\n", np, ret);
 		return ret;
 	}
 
-- 
2.43.0


