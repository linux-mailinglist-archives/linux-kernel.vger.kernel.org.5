Return-Path: <linux-kernel+bounces-115847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4FD88983D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3798329E5A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37D0226935;
	Mon, 25 Mar 2024 03:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kn8QLplt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9152145B34;
	Sun, 24 Mar 2024 23:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322035; cv=none; b=Q0WCSC/01ymnlfGduQWsLuPDaouyldhqTyYr0c9Agnjk1j+IwZDdNg6ru/oCR8N5bIGfvm3pMSPLeCqkRKsB83Q8TJ4lpKGA4L9fEkd0V5OBPa6opfLZHLm/V8EcIYSj1YnhQxU5ChEFYBQdh9t06rIw+GKx63BeEYTDb7uZ6bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322035; c=relaxed/simple;
	bh=PBNNIx8LWar5cbDoBeRTvKcB+cXMQt3unzNSrboVD4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDNYtzRlmN0WeOxqaBEfDRPYULurrAl58jFvJyZhfoEi0puM2PUgT3mHuIKv8d49jyvngeYJARhD0q84YkmFti+afrMtFZBSJ8aP7Cnqr9K4K8AeeXELwFfToNzsBo4XBBS1NUTN1Zhknxr3d9Lf1XS3+a0cpqNsF8/Ybwslq04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kn8QLplt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E61C43394;
	Sun, 24 Mar 2024 23:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322034;
	bh=PBNNIx8LWar5cbDoBeRTvKcB+cXMQt3unzNSrboVD4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kn8QLplt7Ngtq0zHYB1gsyJOIMRywd+TvUI4oDOxQ7keFRfgUxLRsnp2FQFf1CpJA
	 1j7R32DsGv9rLudewsjHUhsffcwSAKEwqw7Bb77nAFFQIHn24m4WzOr16lVYKtmruG
	 ssgbTuEpxmb1N1S6e4JTxbnn7BERyYsbuXbpghBeGkh98Ewm7cjCmxGtiV+grUohM0
	 GCN1sYLTrTq6DUizqU3LInerpGlC6+OvQ999NEKtpAPkH/pk2XCkxTWBb32eS2G8mS
	 UjOmZ+aUyKIEIlgBo5GieHPGD3JEwH4cLd2OLeBdpxO7K/jpV6oI48fQ6iG8U0WOAW
	 blLEQyXPw5mkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 106/451] pmdomain: qcom: rpmhpd: Drop SA8540P gfx.lvl
Date: Sun, 24 Mar 2024 19:06:22 -0400
Message-ID: <20240324231207.1351418-107-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Bjorn Andersson <quic_bjorande@quicinc.com>

[ Upstream commit 883957bee580b723fd87d49ac73e0c84fc03a446 ]

On SA8295P and SA8540P gfx.lvl is not provdied by rpmh, but rather is
handled by an external regulator (max20411). Drop gfx.lvl from the list
of power-domains exposed on this platform.

Fixes: f68f1cb3437d ("soc: qcom: rpmhpd: add sc8280xp & sa8540p rpmh power-domains")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240125-sa8295p-gpu-v4-4-7011c2a63037@quicinc.com
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/rpmhpd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 9a90f241bb97f..6efe36aeb48e9 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -195,7 +195,6 @@ static struct rpmhpd *sa8540p_rpmhpds[] = {
 	[SC8280XP_CX] = &cx,
 	[SC8280XP_CX_AO] = &cx_ao,
 	[SC8280XP_EBI] = &ebi,
-	[SC8280XP_GFX] = &gfx,
 	[SC8280XP_LCX] = &lcx,
 	[SC8280XP_LMX] = &lmx,
 	[SC8280XP_MMCX] = &mmcx,
-- 
2.43.0


