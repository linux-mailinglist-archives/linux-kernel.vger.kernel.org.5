Return-Path: <linux-kernel+bounces-37914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B3183B78E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9B31C2443E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166B65680;
	Thu, 25 Jan 2024 03:09:09 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D010A0A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706152148; cv=none; b=CmIYOXGUFa2EfmAT4lzAO7pnPjVi6z25QHlHGh9PH8N8mK0mqBkZnf/CpxnznnXInSY50iDdKI5ImrbvChHpWt+TUYE/noOfzS2VYivqPIvNzoBoIChdEcUpovKOl3pr36sK+vu16oyC9bqeVSaOhh5gCxIHBcQv2MRnl2GTnwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706152148; c=relaxed/simple;
	bh=+HxDaiSN4fpd2HAPliDEpKUcx7oxWusM6UlFtpvLUiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvfHwOfQ2tdKAhqjnmdJxkpu1zQ9f7iJNdqZAomnwCpXXW8n1TAL9jdjxEBy3E37OVsrkc0aO5ENJ83EAs4Gy7ClzK0QAh3NY0wY8nFE7f6UoTOMgrtXrYYi7ldP8K5Fdmj5m+VfdUDbV5G+Lm+KkVOBI0lx0O31PMy/pGPr0tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40P38dAg061552;
	Thu, 25 Jan 2024 11:08:39 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TL5F60P66z2Rq2lv;
	Thu, 25 Jan 2024 11:01:14 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 25 Jan
 2024 11:08:37 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Wenhua
 Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
        zhaochen
 su <zhaochen.su29@gmail.com>,
        Zhaochen Su <Zhaochen.Su@unisoc.com>,
        Xiaolong
 Wang <Xiaolong.Wang@unisoc.com>
Subject: [PATCH V2 3/6] pwm: sprd: Optimize the calculation method of duty
Date: Thu, 25 Jan 2024 10:55:30 +0800
Message-ID: <20240125025533.10315-4-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240125025533.10315-1-Wenhua.Lin@unisoc.com>
References: <20240125025533.10315-1-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 40P38dAg061552

Use DIV_ROUND_CLOSEST_ULL to avoid overflow and improve accuracy
when calculating duty.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 drivers/pwm/pwm-sprd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
index cc54aa77c7e6..8de3f9e154ce 100644
--- a/drivers/pwm/pwm-sprd.c
+++ b/drivers/pwm/pwm-sprd.c
@@ -156,7 +156,8 @@ static int sprd_pwm_config(struct sprd_pwm_chip *spc, struct pwm_device *pwm,
 	 * given settings (MOD and input clock).
 	 */
 	mod = spc->mod[pwm->hwpwm];
-	duty = duty_ns * mod / period_ns;
+	tmp = (u64)duty_ns * mod;
+	duty = DIV_ROUND_CLOSEST_ULL(tmp, period_ns);
 
 	tmp = (u64)chn->clk_rate * period_ns;
 	do_div(tmp, NSEC_PER_SEC);
-- 
2.17.1


