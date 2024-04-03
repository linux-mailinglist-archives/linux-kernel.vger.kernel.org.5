Return-Path: <linux-kernel+bounces-130290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94F7897675
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB041C29309
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318F0157493;
	Wed,  3 Apr 2024 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRiBhLBC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E9415747E;
	Wed,  3 Apr 2024 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164652; cv=none; b=hi/IdSl/KfpZeyWlNxKwPa4o1TazlAyJiiOsHWYThJcFFiAuBt0YtLoyTYJgFmB3negf4/tlOi+1k2YrSmbsr6nLKHS6yf5z0aMU41UVid+PymckwLQnDbo6hM2APZcNzqiNZhTbUHNcny6i/4W+OqY+21merHLZtjHrx1P+T20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164652; c=relaxed/simple;
	bh=LRtxW9+b/yvQ8uXaMpgy8K8yy1lCpLxqsVwoUZLH2dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAUdrz6mPK5Nd9LxKYCN2PM/topEDucECPKPIwcynB3KxJ59KapQXAN2JQCvLUOhEdWO6VuVnsAtKaMTL+HTJeq6dflLYOgli3moNRg1s4VKKpOEC6l6iWM78xOD81Pr6Rqns859STacjRd0ux5a4cJJUpUloQ2camFEBGiSkms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRiBhLBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C66C433A6;
	Wed,  3 Apr 2024 17:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164652;
	bh=LRtxW9+b/yvQ8uXaMpgy8K8yy1lCpLxqsVwoUZLH2dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dRiBhLBCSnRPD9myjYPKEbM9Q65j9wlmjNGZg4pn3RaKqBV38rKI4IYCDfJYk6aaX
	 iYJAC//eQwykPGzH9E2BaANIDlsplA+5N7PVfnHNueaY4UVuTneX5ihZ55UcrQQJSU
	 2c/7xOOC56n7bJcsYhSFOmSUbhS17gnP/oPfN10ugR1u4gC1emKxdJzP/pEEaHXyMo
	 HUdz6dUL9obf09byrJCijiroWErtXFhfI7psdehex0QJ9kRoP1Jo9uBAB6njpfcLZj
	 JV0YJBs326hYSo6lBBia7tP2zjlfIYS134wp3NpGnQvDFpTXm8fbhWwxCq9pVwigQF
	 Qv5R0Tavk0hNg==
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
Subject: [PATCH AUTOSEL 6.8 16/28] thermal/of: Assume polling-delay(-passive) 0 when absent
Date: Wed,  3 Apr 2024 13:16:18 -0400
Message-ID: <20240403171656.335224-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171656.335224-1-sashal@kernel.org>
References: <20240403171656.335224-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.3
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
index 4d6c22e0ed85b..61bbd42aa2cb4 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -225,14 +225,18 @@ static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdel
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


