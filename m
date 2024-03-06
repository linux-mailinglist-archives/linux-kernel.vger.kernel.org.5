Return-Path: <linux-kernel+bounces-94173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4AA873AE5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0819DB2283A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33740137928;
	Wed,  6 Mar 2024 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="242AI4QF"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864AD13541A;
	Wed,  6 Mar 2024 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739486; cv=none; b=BBsdLs1sTL07G+n5sOwAK1W7YT2e2BksQV7QqD6+hdr4Lk0ZOb98PndHGZ7lUMcrSW6vAhj1iQHvH86fBPk3ptS9PFpsqJnKqTZf9dEQXb8fDZUAFiCGTNmsUR23SM1+FjLMvc6n3J43UygQ9Spwu305MjglwIghVDxD/bKUq/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739486; c=relaxed/simple;
	bh=wm67nJJnh7kXWih0C8pou42fkk9jSa+v66LWMa8Q47k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bid6CoLfRy81SgWN2g/EEXVmwo7YxQpuG6rRVh2POHtj/3dWVgipJvITK3n+HghiehuXSUhv3+STd8E9Ci35CNM8Dqyv2TcEgnAV9Y6YfwCJg5H3Hcew8sayX21haGWBxhoViX3GxvTmygqAZIHOB/c7zFOVEwjIphtEnwL7uvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=242AI4QF; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426A3Hk7012206;
	Wed, 6 Mar 2024 16:37:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=qstRAve
	03QX2RDPXI2xiohBwHTDAxLnNYs7VMSqsGpg=; b=242AI4QFoBfN8HA2pkk9Z0b
	IldQn41koXHItj8gVHkAMUJXvKjaCVZSZtjpm2FMvrKJ7gfUJtr8tvt9vK2Qibf5
	FFMMtUcxR4yliuC3Cmss4+0m0+B1AZTHEbKfKH6/6uDcp7gzsmx1kcCb/0ADOWIH
	zikStUZq07Z+/bXj53Y2kTOj9iYwt+5qht1FSji08CbsIUOeW0IykM3C9f6hB8i6
	Q0fs36qfoTEqze2x/nr3N1Ax65B6zeZKY80H4RX40FjVZXUQFYyJE3fFGH/LQGwx
	cQhqxlu8QbJATdW4NNR1xxEDSwtO6+a30wXt84i57IQWHtl7zzu1BSU5bQAeuJA=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wmej58r3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 16:37:44 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C1DDA4002D;
	Wed,  6 Mar 2024 16:37:37 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 42AF0283682;
	Wed,  6 Mar 2024 16:37:03 +0100 (CET)
Received: from localhost (10.201.22.191) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Mar
 2024 16:37:00 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <syednwaris@gmail.com>, <vigneshr@ti.com>, <jpanis@baylibre.com>,
        <alexandre.torgue@foss.st.com>, <fabrice.gasnier@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6] counter: Introduce the COUNTER_COMP_FREQUENCY() macro
Date: Wed, 6 Mar 2024 16:36:31 +0100
Message-ID: <20240306153631.4051115-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_10,2024-03-05_01,2023-05-22_02

Now that there are two users for the "frequency" extension, introduce a
new COUNTER_COMP_FREQUENCY() macro.
This extension is intended to be a read-only signal attribute.

Suggested-by: William Breathitt Gray <william.gray@linaro.org>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v6
- use COUNTER_COMP_SIGNAL_U64() helper macro.

Changes in v5
- "frequency" extension is read-only, so there's no need to provide
  a write parameter.
- patch sent separately from "counter: Add stm32 timer events support" [1]
[1] https://lore.kernel.org/lkml/20240227173803.53906-2-fabrice.gasnier@foss.st.com/
---
 include/linux/counter.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/counter.h b/include/linux/counter.h
index 702e9108bbb4..ac36f6e799f6 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -602,6 +602,9 @@ struct counter_array {
 #define COUNTER_COMP_FLOOR(_read, _write) \
 	COUNTER_COMP_COUNT_U64("floor", _read, _write)
 
+#define COUNTER_COMP_FREQUENCY(_read) \
+	COUNTER_COMP_SIGNAL_U64("frequency", _read, NULL)
+
 #define COUNTER_COMP_POLARITY(_read, _write, _available) \
 { \
 	.type = COUNTER_COMP_SIGNAL_POLARITY, \
-- 
2.25.1


