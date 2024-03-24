Return-Path: <linux-kernel+bounces-113402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C6F88840A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365F11F24DC4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D165139D1B;
	Sun, 24 Mar 2024 22:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZpYYZ4X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1BB139CFC;
	Sun, 24 Mar 2024 22:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320203; cv=none; b=rnMkRPA/ve7XmHeWNcHwal1xw7srrTIen2hxpT+BZoJ0hNK2Y+MgIWPC3VhQuGERCIPSTGOQjMqCvGncwAaeZwFg1GMbGXHFrNB10CiQ+At0vuouzJcLx5itVl6PxNziou6ktBtVv8tCv2qpK1i4oZGhZfI2mKveOLAiVMCgOJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320203; c=relaxed/simple;
	bh=3rXJbAmGGvocxHf7KOmSNply9V1bPn2jO8NDocdobiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/qTAVgqHZteU37XgqazxexFk2kBttUc8PHCIoW5QCZ9vYL3BynEl+gnrruXVPvo3dbN3wOwbOe4gDVO9tj5KEqvYfMdFV0ek8dWpGf2DzRA9wWj6XQDEhHpwwu14LW6L7aWWsBv1DiQO0lzGzkNW3lDTEb3tUERDE3AmI0c5Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZpYYZ4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D49C43390;
	Sun, 24 Mar 2024 22:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320203;
	bh=3rXJbAmGGvocxHf7KOmSNply9V1bPn2jO8NDocdobiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZpYYZ4XYaAan7RlFoR+6CEyrw1QrCklRedguNDAIWCZZJYz8pmlrrVJI4TLGWmlD
	 lAd4t76LiO7Q2j4pEnOX2Zb1qNHG8Fcyk8EQwuuYEec2ft9j8dsQ9IaiONph0+/esg
	 sXYJCsYlakm1SzdDYBhwSphTkWiV7shvh9YYHOVCU7UQwytcLD8AagkQAE+YIbqMJw
	 DjHIPnGOCnd9pN3jYvDTUkq4lZixGvp12ZcucCMQn7A9Wsp6embmM5Cdu9aB1KtuNW
	 5nKKD6uTBLH+7p/ih8/falJC1XxOChWhJBuTLt3Yb6oukfuzSjo31SV7XPGdvuI95c
	 E87tAn0v1gaoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dafna Hirschfeld <dhirschfeld@habana.ai>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 511/715] drm/xe: Replace 'grouped target' in Makefile with pattern rule
Date: Sun, 24 Mar 2024 18:31:30 -0400
Message-ID: <20240324223455.1342824-512-sashal@kernel.org>
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

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

[ Upstream commit e62d2e00780b4a465c77d2229837495fcbc480d3 ]

Since 'grouped target' is used only in 'make' 4.3, it should
be avoided. Replace it with 'multi-target pattern rule' which
has the same behavior.

Fixes: 9616e74b796c ("drm/xe: Add support for OOB workarounds")
Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240302153927.2602241-1-dhirschfeld@habana.ai
[ reword commit message ]
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit 5224ed586ba7f9bba956655a1bfe5b75df7394d4)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index efcf0ab7a1a69..802c807c782cc 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -42,7 +42,8 @@ generated_oob := $(obj)/generated/xe_wa_oob.c $(obj)/generated/xe_wa_oob.h
 quiet_cmd_wa_oob = GEN     $(notdir $(generated_oob))
       cmd_wa_oob = mkdir -p $(@D); $^ $(generated_oob)
 
-$(generated_oob) &: $(obj)/xe_gen_wa_oob $(srctree)/$(src)/xe_wa_oob.rules
+$(obj)/generated/%_wa_oob.c $(obj)/generated/%_wa_oob.h: $(obj)/xe_gen_wa_oob \
+		 $(srctree)/$(src)/xe_wa_oob.rules
 	$(call cmd,wa_oob)
 
 uses_generated_oob := \
-- 
2.43.0


