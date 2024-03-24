Return-Path: <linux-kernel+bounces-112991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E68A888052
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5902E2817DC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C171912E1E6;
	Sun, 24 Mar 2024 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iddfvdKM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E694612E1CB;
	Sun, 24 Mar 2024 22:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319804; cv=none; b=k4qRoeXsNJWQriTJ6JNyCf3ajo9YEwWV5yCDwY8tbRYR1C6crcNM/okersm8Y9VUERVnVJhianyqNwLBDMe8I0kveCg/YJYCcDJhU3O/4F+z7AJS2UjMebDV0J1YtkSSz4jdMwtBtBtXjQAF5664F6WvQjWsMdvCOGYGto4e0rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319804; c=relaxed/simple;
	bh=ZHyLupHb1tRjqpeqOZ71dtb6ihCcKfKUiHeXXpOP6+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLUe4PTWrEvsWFuH85XTfPNRJ/avuY6BmBSQ/1AdesxWLEwnF4TySCH0lh91V+ZRdwvE+dgPoQmgXSaGxh7rH277+kpVCeygNGlmCcVBHaZLgrJOxV2qExVRCAPYZKdNa7qdA6htN9pIThWv4/EQlHLRX3UcXs+ksfJNqUCc2ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iddfvdKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1329C43390;
	Sun, 24 Mar 2024 22:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319803;
	bh=ZHyLupHb1tRjqpeqOZ71dtb6ihCcKfKUiHeXXpOP6+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iddfvdKMN4AEwEjI3eFUm2VRKze19xcdHKzrs2FDrhrW9AE9lA2H+wxLmJttN9vYG
	 A+eWc8H6gwVZOd8vZpymf9hOoPgNNC3AtJTPL0rtJPxmgfpd5KSIMfPh4PB3+DSHYd
	 qU0Ft2hNWGCb1rCXhrnf1jm9c6yXcCNXYGd3hFjhmpbXPImdJmrU1Q1By+CsmjjSxO
	 T+/Ehuz2T+OQ2p3Zz5+jblQtitp1BAiZtDKc1ijrJPcNBZY1ajEZ6I5T9RqBtrYWcN
	 UIZnmVozA9hkhRY9zkeXeBS9motrgJSefkGIFFXOdOrAmO4QLKgzTc7qw4jEyQaMuA
	 mkpLr/BMwop5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 104/715] pmdomain: qcom: rpmhpd: Drop SA8540P gfx.lvl
Date: Sun, 24 Mar 2024 18:24:43 -0400
Message-ID: <20240324223455.1342824-105-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
 drivers/pmdomain/qcom/rpmhpd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 47df910645f66..de9121ef4216b 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -217,7 +217,6 @@ static struct rpmhpd *sa8540p_rpmhpds[] = {
 	[SC8280XP_CX] = &cx,
 	[SC8280XP_CX_AO] = &cx_ao,
 	[SC8280XP_EBI] = &ebi,
-	[SC8280XP_GFX] = &gfx,
 	[SC8280XP_LCX] = &lcx,
 	[SC8280XP_LMX] = &lmx,
 	[SC8280XP_MMCX] = &mmcx,
-- 
2.43.0


