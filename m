Return-Path: <linux-kernel+bounces-97797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D27F876F86
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF791C20CA9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 07:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D40837169;
	Sat,  9 Mar 2024 07:29:53 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7262E64C;
	Sat,  9 Mar 2024 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709969393; cv=none; b=lpnA4hsjcHY9VncfIjNXA+lKTXcRnb59a/H+OLXylQfUNObN67KzxQ1Hp0vqAFCrO5VKg69lnPuIBmtAOckvUA+FelE4FQ8zq0dndYhHq9T8LiX6rKoP0/GErNHX3Fw1O55RqDPJFz1JNywGUbNCLjGD5s9s516lsaLTGosqoSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709969393; c=relaxed/simple;
	bh=IipyU9kP82Sm/RNw9p0vGM6fRgiNOM3/GrVwZPio/u4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PT1mNVED4KV68lwj7ToXmX8uE0JXQwkdSrXWwgzNanT6wruhSo4yXvEVvpSQ/druECY6VuYpk6fUH3e0/tIG3N2NqEG2ge36pZkO7GmwQ4jG7SFpm4jN7ErdjlH1JZZfr/HARZIINU0DqNaYeqKfuVndoDVOCIfMKG9+RHTuvt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id FAL00131;
        Sat, 09 Mar 2024 15:28:31 +0800
Received: from localhost.localdomain (10.94.4.69) by
 jtjnmail201621.home.langchao.com (10.100.2.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 9 Mar 2024 15:28:32 +0800
From: wangkaiyuan <wangkaiyuan@inspur.com>
To: <krzysztof.kozlowski@linaro.org>, <andersson@kernel.org>,
	<konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	wangkaiyuan <wangkaiyuan@inspur.com>
Subject: [PATCH] soc: qcom: icc-bwmon: Convert to use maple tree register cache
Date: Sat, 9 Mar 2024 15:28:25 +0800
Message-ID: <20240309072825.45385-1-wangkaiyuan@inspur.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201614.home.langchao.com (10.100.2.14) To
 jtjnmail201621.home.langchao.com (10.100.2.21)
tUid: 20243091528313fcaa2262ccfc0804e20f92720baef1e
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: wangkaiyuan <wangkaiyuan@inspur.com>
---
 drivers/soc/qcom/icc-bwmon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index 656706259353..fb323b3364db 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -282,7 +282,7 @@ static const struct regmap_config msm8998_bwmon_regmap_cfg = {
 	 * Cache is necessary for using regmap fields with non-readable
 	 * registers.
 	 */
-	.cache_type		= REGCACHE_RBTREE,
+	.cache_type		= REGCACHE_MAPLE,
 };
 
 static const struct regmap_config msm8998_bwmon_global_regmap_cfg = {
@@ -301,7 +301,7 @@ static const struct regmap_config msm8998_bwmon_global_regmap_cfg = {
 	 * Cache is necessary for using regmap fields with non-readable
 	 * registers.
 	 */
-	.cache_type		= REGCACHE_RBTREE,
+	.cache_type		= REGCACHE_MAPLE,
 };
 
 static const struct reg_field sdm845_cpu_bwmon_reg_fields[] = {
@@ -369,7 +369,7 @@ static const struct regmap_config sdm845_cpu_bwmon_regmap_cfg = {
 	 * Cache is necessary for using regmap fields with non-readable
 	 * registers.
 	 */
-	.cache_type		= REGCACHE_RBTREE,
+	.cache_type		= REGCACHE_MAPLE,
 };
 
 /* BWMON v5 */
@@ -446,7 +446,7 @@ static const struct regmap_config sdm845_llcc_bwmon_regmap_cfg = {
 	 * Cache is necessary for using regmap fields with non-readable
 	 * registers.
 	 */
-	.cache_type		= REGCACHE_RBTREE,
+	.cache_type		= REGCACHE_MAPLE,
 };
 
 static void bwmon_clear_counters(struct icc_bwmon *bwmon, bool clear_all)
-- 
2.27.0


