Return-Path: <linux-kernel+bounces-23789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B10D382B1C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872A41C21960
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801D54CE12;
	Thu, 11 Jan 2024 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="XknZtJ+h"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314184F1E6;
	Thu, 11 Jan 2024 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40BAFBxP001702;
	Thu, 11 Jan 2024 16:27:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=BPsKvGwCvtumO70J1qmyLApJgoRqO+4A21EFeihpSLQ=; b=Xk
	nZtJ+hCyCb5HWGuYyRfOxV3x1ApcTJlfMknUPtfnkTrv5ACs32wPNE8yjwZEFT0P
	9M64m4vUrAAFRG2ZC7AireZ99e4qZnG9728Dtlcj+lHda7rKFFRNlPwfaFa0kX7X
	Ik7Sm3j7b9tXrzJ6YaXFOjanjhKP7pix1rm1geYl5WjTsTnJELo4q8unza0xMsEd
	x9iUsyfs6fjTQ5N6Qx/iqNKRMoJgujE6G5HEtFYC0t2pPZ+GG0iVGAw1+su0a6ZB
	uB7MjEHpk/Tv4V3wtYY/W0j8sG/4BGGSkbygjnvc35C7rcLk7HlBWHen5KkObE3w
	mRcPhIuSm5tIDZVZhVIA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vfjpp3fex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 16:27:36 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3024B10002A;
	Thu, 11 Jan 2024 16:27:36 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 29013290CC7;
	Thu, 11 Jan 2024 16:27:36 +0100 (CET)
Received: from localhost (10.201.21.102) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 11 Jan
 2024 16:27:35 +0100
From: Valentin Caron <valentin.caron@foss.st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Valentin Caron
	<valentin.caron@foss.st.com>
Subject: [PATCH 2/4] serial: stm32: extend max number of U(S)ART to 9
Date: Thu, 11 Jan 2024 16:27:10 +0100
Message-ID: <20240111152712.1842790-3-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111152712.1842790-1-valentin.caron@foss.st.com>
References: <20240111152712.1842790-1-valentin.caron@foss.st.com>
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
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02

STM32MP25x got 9 instances of U(S)ART. So extend STM32_MAX_PORTS to 9, in
order to handle all instances.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/tty/serial/stm32-usart.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 8cecfdce9386..5ce1d3aae07e 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -183,7 +183,7 @@ struct stm32_usart_info {
 #define USART_PRESC_MAX		0b1011
 
 #define STM32_SERIAL_NAME "ttySTM"
-#define STM32_MAX_PORTS 8
+#define STM32_MAX_PORTS 9
 
 #define RX_BUF_L 4096		 /* dma rx buffer length     */
 #define RX_BUF_P (RX_BUF_L / 2)	 /* dma rx buffer period     */
-- 
2.25.1


