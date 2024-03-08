Return-Path: <linux-kernel+bounces-96416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537EA875BD9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD7B3B20C53
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FF4224DD;
	Fri,  8 Mar 2024 01:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="C1ulDhg5"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AC020B35;
	Fri,  8 Mar 2024 01:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860171; cv=none; b=o/9NA9eLcw6CYvle1ytKVz4lgpzRKJr5DfO/g++aKaSepLbmKV3SO4ayfDURMLywTIdymZhMDVitLvrEWQkukl0LRSkL2Tay8Cset1JAsLQAEGPXQSMbcCvd1bF9b002i9ri/UQ1ouOI8jqRz63/9cFxpLeiV43JwhQbYCNteKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860171; c=relaxed/simple;
	bh=S5oTdDbKKJ9uCz6925DSgCk/EUQPohigcFEx7WR6WHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tcnVOiPyyue1sfWQPD1Jy2KgFH8mMlwqT4gnwbI6PUP6QrKfK98pIkybuQ8otq5b+hxOgiY2MpTU2ZTRRri85orsqQbsKGliocOw3CS/Dihp+3JtbDSMbITg6PW8wbrWIzSRQMiAL7CWRfMqfxXWjoMcKu0n+eJjvn2graCLnIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=C1ulDhg5; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1iFaV
	287Y0eGK7s0IO6GL/mOj5DAK8MslBCFLFMR+hg=; b=C1ulDhg5gNEul61gUji6Q
	yG4T4Dl+k4lXFXJdCkH6p3MJefz2DZ4RWxQp2WxbmGlp221QddyucrVywW5RHnlw
	N/UoC6srh1XzJRf8ct5j/Bzseo2RfFVH3oNkjOnp+Ft4ioKJvq9N5Gzpm8YJdSc/
	1WPi0Qxog0pPRqC9Z6mWi8=
Received: from ldingyan9LVDQ.vmware.com.com (unknown [114.250.139.10])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wBH76AxZeplz6ePAw--.49439S2;
	Fri, 08 Mar 2024 09:09:06 +0800 (CST)
From: Dingyan Li <18500469033@163.com>
To: stern@rowland.harvard.edu
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] USB: Use EHCI control transfer pid macros instead of constant values.
Date: Fri,  8 Mar 2024 09:08:59 +0800
Message-Id: <20240308010859.81987-1-18500469033@163.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <1e7f57d6-a4c1-4a3d-8cff-f966c89a8140@rowland.harvard.edu>
References: <1e7f57d6-a4c1-4a3d-8cff-f966c89a8140@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH76AxZeplz6ePAw--.49439S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr43JFyxtr47AF4Uuw1xXwb_yoW7JrWfpF
	W3WrW7tayUJr4YqwnrGrsYyF1rJw13G34UKFy29397Gr4vyr15GF17KFWftr9rXry8ur1Y
	qr45Xr98urs7JFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UiJ5wUUUUU=
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/1tbiVBmay2VOByQVUAABsQ

Macros with good names offer better readability. Besides, also move
the definition to ehci.h.

Signed-off-by: Dingyan Li <18500469033@163.com>
---
 drivers/usb/host/ehci-dbg.c | 10 +++++-----
 drivers/usb/host/ehci-q.c   | 20 ++++++++------------
 drivers/usb/host/ehci.h     |  8 +++++++-
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/host/ehci-dbg.c b/drivers/usb/host/ehci-dbg.c
index c063fb042926..435001128221 100644
--- a/drivers/usb/host/ehci-dbg.c
+++ b/drivers/usb/host/ehci-dbg.c
@@ -430,13 +430,13 @@ static void qh_lines(struct ehci_hcd *ehci, struct ehci_qh *qh,
 				mark = '/';
 		}
 		switch ((scratch >> 8) & 0x03) {
-		case 0:
+		case PID_CODE_OUT:
 			type = "out";
 			break;
-		case 1:
+		case PID_CODE_IN:
 			type = "in";
 			break;
-		case 2:
+		case PID_CODE_SETUP:
 			type = "setup";
 			break;
 		default:
@@ -602,10 +602,10 @@ static unsigned output_buf_tds_dir(char *buf, struct ehci_hcd *ehci,
 	list_for_each_entry(qtd, &qh->qtd_list, qtd_list) {
 		temp++;
 		switch ((hc32_to_cpu(ehci, qtd->hw_token) >> 8)	& 0x03) {
-		case 0:
+		case PID_CODE_OUT:
 			type = "out";
 			continue;
-		case 1:
+		case PID_CODE_IN:
 			type = "in";
 			continue;
 		}
diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index 666f5c4db25a..ba37a9fcab92 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -27,10 +27,6 @@
 
 /*-------------------------------------------------------------------------*/
 
-/* PID Codes that are used here, from EHCI specification, Table 3-16. */
-#define PID_CODE_IN    1
-#define PID_CODE_SETUP 2
-
 /* fill a qtd, returning how much of the buffer we were able to queue up */
 
 static unsigned int
@@ -230,7 +226,7 @@ static int qtd_copy_status (
 			/* fs/ls interrupt xfer missed the complete-split */
 			status = -EPROTO;
 		} else if (token & QTD_STS_DBE) {
-			status = (QTD_PID (token) == 1) /* IN ? */
+			status = (QTD_PID(token) == PID_CODE_IN) /* IN ? */
 				? -ENOSR  /* hc couldn't read data */
 				: -ECOMM; /* hc couldn't write data */
 		} else if (token & QTD_STS_XACT) {
@@ -606,7 +602,7 @@ qh_urb_transaction (
 		/* SETUP pid */
 		qtd_fill(ehci, qtd, urb->setup_dma,
 				sizeof (struct usb_ctrlrequest),
-				token | (2 /* "setup" */ << 8), 8);
+				token | (PID_CODE_SETUP << 8), 8);
 
 		/* ... and always at least one more pid */
 		token ^= QTD_TOGGLE;
@@ -620,7 +616,7 @@ qh_urb_transaction (
 
 		/* for zero length DATA stages, STATUS is always IN */
 		if (len == 0)
-			token |= (1 /* "in" */ << 8);
+			token |= (PID_CODE_IN << 8);
 	}
 
 	/*
@@ -642,7 +638,7 @@ qh_urb_transaction (
 	}
 
 	if (is_input)
-		token |= (1 /* "in" */ << 8);
+		token |= (PID_CODE_IN << 8);
 	/* else it's already initted to "out" pid (0 << 8) */
 
 	maxpacket = usb_endpoint_maxp(&urb->ep->desc);
@@ -709,7 +705,7 @@ qh_urb_transaction (
 
 		if (usb_pipecontrol (urb->pipe)) {
 			one_more = 1;
-			token ^= 0x0100;	/* "in" <--> "out"  */
+			token ^= (PID_CODE_IN << 8);	/* "in" <--> "out"  */
 			token |= QTD_TOGGLE;	/* force DATA1 */
 		} else if (usb_pipeout(urb->pipe)
 				&& (urb->transfer_flags & URB_ZERO_PACKET)
@@ -1203,7 +1199,7 @@ static int ehci_submit_single_step_set_feature(
 		/* SETUP pid, and interrupt after SETUP completion */
 		qtd_fill(ehci, qtd, urb->setup_dma,
 				sizeof(struct usb_ctrlrequest),
-				QTD_IOC | token | (2 /* "setup" */ << 8), 8);
+				QTD_IOC | token | (PID_CODE_SETUP << 8), 8);
 
 		submit_async(ehci, urb, &qtd_list, GFP_ATOMIC);
 		return 0; /*Return now; we shall come back after 15 seconds*/
@@ -1216,7 +1212,7 @@ static int ehci_submit_single_step_set_feature(
 	token ^= QTD_TOGGLE;   /*We need to start IN with DATA-1 Pid-sequence*/
 	buf = urb->transfer_dma;
 
-	token |= (1 /* "in" */ << 8);  /*This is IN stage*/
+	token |= (PID_CODE_IN << 8);  /*This is IN stage*/
 
 	maxpacket = usb_endpoint_maxp(&urb->ep->desc);
 
@@ -1229,7 +1225,7 @@ static int ehci_submit_single_step_set_feature(
 	qtd->hw_alt_next = EHCI_LIST_END(ehci);
 
 	/* STATUS stage for GetDesc control request */
-	token ^= 0x0100;        /* "in" <--> "out"  */
+	token ^= (PID_CODE_IN << 8);        /* "in" <--> "out"  */
 	token |= QTD_TOGGLE;    /* force DATA1 */
 
 	qtd_prev = qtd;
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 1441e3400796..d7a3c8d13f6b 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -321,10 +321,16 @@ struct ehci_qtd {
 	size_t			length;			/* length of buffer */
 } __aligned(32);
 
+/* PID Codes that are used here, from EHCI specification, Table 3-16. */
+#define PID_CODE_OUT   0
+#define PID_CODE_IN    1
+#define PID_CODE_SETUP 2
+
 /* mask NakCnt+T in qh->hw_alt_next */
 #define QTD_MASK(ehci)	cpu_to_hc32(ehci, ~0x1f)
 
-#define IS_SHORT_READ(token) (QTD_LENGTH(token) != 0 && QTD_PID(token) == 1)
+#define IS_SHORT_READ(token) (QTD_LENGTH(token) != 0 && \
+						QTD_PID(token) == PID_CODE_IN)
 
 /*-------------------------------------------------------------------------*/
 
-- 
2.25.1


