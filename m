Return-Path: <linux-kernel+bounces-24528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5255082BDF0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9171C25A90
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925FE5DF0A;
	Fri, 12 Jan 2024 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="2IghlVbA"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0893E5DF11;
	Fri, 12 Jan 2024 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40C8bGNe014416;
	Fri, 12 Jan 2024 10:53:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=gqYDRY1M+y29PGSIorc/WBQGH1vOYxwvtXDzkuKQQrM=; b=2I
	ghlVbAGkQnYxvdLj3nwjl223nZpmpUyAmAVjWD8c2b3yReNr+tXxIoe94+zATJcq
	kpqfh7sCPaihTweYHUe4/wWRxgy6Io7xkEzSds5Z6pJC274SN0cZCDUmj9dA4XX+
	V0h+6QTLhvF1Kicvujws4oZafG6I1ssIou+Q0DfjSX6zwD0Ag6AYopxVBeTQA6al
	TedgnTQxtz9dRdiE4cSx3ukO10icaU8wYFHFzRV0oQFIDbOogSIdfC3xJ5q0Lg1H
	Zi/ruAqiyZZkQ6Y4EYQF9+4X5VeZN/XFFn5idSTgYVoUOMLY49hVKovEI/ZtBdBa
	cnmBQFLPGR20J/go8YTQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vk22u8bpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 10:53:26 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E6AD010002A;
	Fri, 12 Jan 2024 10:53:25 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DFBE8208D4E;
	Fri, 12 Jan 2024 10:53:25 +0100 (CET)
Received: from localhost (10.201.21.102) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 12 Jan
 2024 10:53:25 +0100
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
Subject: [PATCH v2 3/4] serial: stm32: change register's offset type from u8 to u16
Date: Fri, 12 Jan 2024 10:52:59 +0100
Message-ID: <20240112095300.2004878-4-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240112095300.2004878-1-valentin.caron@foss.st.com>
References: <20240112095300.2004878-1-valentin.caron@foss.st.com>
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

USART has registers above 0xff offset, so extend variable type to u16.
And change UNDEF_REG to 0xffff.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/tty/serial/stm32-usart.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 5ce1d3aae07e..bf3720948704 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -9,18 +9,18 @@
 #define DRIVER_NAME "stm32-usart"
 
 struct stm32_usart_offsets {
-	u8 cr1;
-	u8 cr2;
-	u8 cr3;
-	u8 brr;
-	u8 gtpr;
-	u8 rtor;
-	u8 rqr;
-	u8 isr;
-	u8 icr;
-	u8 rdr;
-	u8 tdr;
-	u8 presc;
+	u16 cr1;
+	u16 cr2;
+	u16 cr3;
+	u16 brr;
+	u16 gtpr;
+	u16 rtor;
+	u16 rqr;
+	u16 isr;
+	u16 icr;
+	u16 rdr;
+	u16 tdr;
+	u16 presc;
 };
 
 struct stm32_usart_config {
@@ -37,7 +37,7 @@ struct stm32_usart_info {
 	struct stm32_usart_config cfg;
 };
 
-#define UNDEF_REG 0xff
+#define UNDEF_REG 0xffff
 
 /* USART_SR (F4) / USART_ISR (F7) */
 #define USART_SR_PE		BIT(0)
-- 
2.25.1


