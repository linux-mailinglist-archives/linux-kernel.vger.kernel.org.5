Return-Path: <linux-kernel+bounces-56339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D4B84C8E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A03A1F26C23
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00BD168DD;
	Wed,  7 Feb 2024 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="bVW5X8A7"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E96114AA8;
	Wed,  7 Feb 2024 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302789; cv=none; b=QFKfffjUQFyBueY6jIbsyhwmSHU/x4M46mbcjYsPeo2OJce/aAMRk8BiivjNaP4jg+HwS53WpZOKh918l0a2/kJAk2zgZzvr312C9RdJen4/ZqH+O8W8O7n3yuW4qxFrFQuuJL282U8hwKsT7G+RupNBuSmQp6jCQ14eWzaOdB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302789; c=relaxed/simple;
	bh=TPnfcICgI4g3grUmcA2X1ujtIdIPQQJkpPLYySJnthk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YwWAn+ORD6xlbQPxTWE6xAEmiA9H7pDj9TqpOWD0eXiPRpkyVwrENo5FtbFEH9OAMHDoqyYqh7Scr61kYYW15mrg+Yqv0bEre7ChOLCA1e/+t54gLi9j203wsQoLBMwTAkKTYVQ4s6fByFW1hvLysUQjbNWyUglXJCoSayyypcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=bVW5X8A7; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4176FQnZ003091;
	Wed, 7 Feb 2024 11:46:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=PIc5fr4
	3l23sf01s2fsMtu9PxKCMeqeCBi0nksf6Bds=; b=bVW5X8A7Obp8CGLSsz7WyBu
	kXC3XvjBa2ggJ63H1GVCUnIcvfTspUTDb0VJ8FaNlUYIQKd4XZxYFapca+pB6jyw
	YlCkuKXgnni4D7RHUUjOrzFHSpJ2I6ioMgShTCUcUvP0tds4yvEF24VFog55M9s+
	JoIr8ioX6q/CDcUevO29NdoHWMXuIweh511oEy3hV13SxGYJloRNz/AN2RxeyktJ
	+A85TU2Q/7XK0B9ir28liEE1ynMfa8gj60c96ybXOcna20KHm6FDFAlRsPehgUVF
	t7Sj9fpT58VPI9Ht0AoLYGE2MBFW5wx1vPedZNLkYPsvYKMpupL5wkrApDw1rbw=
	=
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w1yx45j5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 11:46:16 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F1E1D100058;
	Wed,  7 Feb 2024 11:46:15 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EBD4922D181;
	Wed,  7 Feb 2024 11:46:15 +0100 (CET)
Received: from localhost (10.252.26.183) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 7 Feb
 2024 11:46:15 +0100
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-gpio@vger.kernel.org>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] pinctrl: stm32: fix PM support for stm32mp257
Date: Wed, 7 Feb 2024 11:46:04 +0100
Message-ID: <20240207104604.174843-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_04,2024-01-31_01,2023-05-22_02

The driver for stm32mp257 is missing the suspend callback in
struct dev_pm_ops.

Add the callback, using the common stm32_pinctrl_suspend()
function.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Fixes: 619f8ca4a73d ("pinctrl: stm32: add stm32mp257 pinctrl support")
---
 drivers/pinctrl/stm32/pinctrl-stm32mp257.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32mp257.c b/drivers/pinctrl/stm32/pinctrl-stm32mp257.c
index 73f091cd827e..23aebd4695e9 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32mp257.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32mp257.c
@@ -2562,7 +2562,7 @@ static const struct of_device_id stm32mp257_pctrl_match[] = {
 };
 
 static const struct dev_pm_ops stm32_pinctrl_dev_pm_ops = {
-	 SET_LATE_SYSTEM_SLEEP_PM_OPS(NULL, stm32_pinctrl_resume)
+	 SET_LATE_SYSTEM_SLEEP_PM_OPS(stm32_pinctrl_suspend, stm32_pinctrl_resume)
 };
 
 static struct platform_driver stm32mp257_pinctrl_driver = {

base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.34.1


