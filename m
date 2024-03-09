Return-Path: <linux-kernel+bounces-97755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BC6876EFD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 04:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DF02823BA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 03:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C613218B;
	Sat,  9 Mar 2024 03:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fYB27GqT"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C1FED0;
	Sat,  9 Mar 2024 03:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709955466; cv=none; b=cEAlP+eV2lKxvKj8QH4xtqHz7ofxHsbl37gguyrXavELh6D4g7353PlKSEvPlnEtGgrqWA/iITGVtIVtelk4Xvvtd+VN+fdZWDrvym4cr6YFTWqZm+snpL5JMtVviNUY+bIzqGB6nJ5uVJf0G8BeeJcmxzY8v1b1iBWjsHnwi2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709955466; c=relaxed/simple;
	bh=1FYbja82FTU8HCW9uc0z5iqRvunm/kHPVJfoSsZP5UI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lE3RlKpLUvMgpv7Lc9nQB7NhXeXpEK7F+vsKJH2D9Tbw43D0qTTajNxgTIwCXbSHEsLh62y8ydko6c8JNScW4EpZoJQSgcwhxKuUnZR2Bu/mEO5Wj7AJ6zJnY+1Ii3HRo2nId/O+bgrJl7HhDkGRcoDrhQ+DvWbGU266nBRPh+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fYB27GqT; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5/rIc
	vEhPjb1hIWBYIV+lNtwrQQdU5YUkrMLCb2G0GA=; b=fYB27GqTGbn1gJcg5yHgA
	snxH6Q65TpyCKL6yXeRGsJKzQszE7ygxbicmAzggLqBfkjnfqMf5szWDmN743dKu
	b0ow2lW03r2oTDI9Q9qKfsMw+Fbb3piAf3i9Hh1g/SY2NIkiSfYU/Ju/SMmAe+7d
	4dtJFZJAVGfV6qCPp/wnBE=
Received: from ldingyan9LVDQ.vmware.com.com (unknown [114.250.139.10])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wDnz15n2etl5U9ZBA--.409S2;
	Sat, 09 Mar 2024 11:37:12 +0800 (CST)
From: Dingyan Li <18500469033@163.com>
To: stern@rowland.harvard.edu
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] USB: Use EHCI control transfer pid macros instead of constant values.
Date: Sat,  9 Mar 2024 11:37:09 +0800
Message-Id: <20240309033709.14604-1-18500469033@163.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <37bdd932-07a4-4514-a5cc-b70d48c962a6@rowland.harvard.edu>
References: <37bdd932-07a4-4514-a5cc-b70d48c962a6@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnz15n2etl5U9ZBA--.409S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtF1fAryUXw47ury3Zr4fZrb_yoW7GrWxpF
	W3WrW7tayUJr4YqwnrGrsYyF1rJw13Ja4UKFW29397Cr4vyr15GF17KFWftr9rXry8Wr1Y
	qr45Xr98urs7JFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UE9aPUUUUU=
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/1tbiVB+cy2VOBzqYMgABsh

Macros with good names offer better readability. Besides, also move
the definition to ehci.h.

Signed-off-by: Dingyan Li <18500469033@163.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
---
V1 -> V2: Replacement in more places where Alan pointed out.

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


