Return-Path: <linux-kernel+bounces-23788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0D782B1C4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C382C1F2297C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752BB4CB43;
	Thu, 11 Jan 2024 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="30FRbasu"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313EC4F1E1;
	Thu, 11 Jan 2024 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B9nMTw003690;
	Thu, 11 Jan 2024 16:27:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=1deQdmT
	qX7yvTY+HLhspiIy5iCUdj8XB/YeKjSPXot8=; b=30FRbasu7DkFXJnSlhhw/Rr
	HGATZR/Zg2fPCI4knS8oJzvZYod6BUQfgSbMj8U0qM5EllsAr1VndHTR6X0O/GZM
	8ZnnlSAw/7qaat92mKGAjoqyxnsq/+oqbzfEM1QazRy/vl/2CDz+gGNNOrZqSRhL
	9bdK03aG4VGMfI6GSsHKKqXwvUwXECDsKUZVwQR1YH/DytWqhZ1nByxjnBWoYy1u
	hd9uUgZP9GaZjqgtBpB3Z/9mIFK0kYaY/CMUbL7EWLatmIaR/VWj854O+bhIoHqI
	cVcByap0yrScDsQFbBeY2PyDEyxw4slz3/bjE+CJbJTcSESjhUV2Nex00xKZHsg=
	=
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vfjpp3fer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 16:27:35 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8336B10004D;
	Thu, 11 Jan 2024 16:27:34 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 79AB9290CC6;
	Thu, 11 Jan 2024 16:27:34 +0100 (CET)
Received: from localhost (10.201.21.102) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 11 Jan
 2024 16:27:34 +0100
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
Subject: [PATCH 0/4] serial: stm32: improve driver for stm32mp25
Date: Thu, 11 Jan 2024 16:27:08 +0100
Message-ID: <20240111152712.1842790-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
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

STM32MP25 got the same serial hardware block as STM32MP1x but with two improvements:
 - TX and RX FIFO have been extended to 64 bytes.
 - one instance more than in STM32MP1x series.

Valentin Caron (4):
  serial: stm32: implement prescaler tuning to compute low baudrate
  serial: stm32: extend max number of U(S)ART to 9
  serial: stm32: change register's offset type from u8 to u16
  serial: stm32: get FIFO size from hwcfg register

 drivers/tty/serial/stm32-usart.c | 222 +++++++++++++++++++------------
 drivers/tty/serial/stm32-usart.h |  38 ++++--
 2 files changed, 159 insertions(+), 101 deletions(-)

-- 
2.25.1


