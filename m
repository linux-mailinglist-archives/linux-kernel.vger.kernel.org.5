Return-Path: <linux-kernel+bounces-95945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B5787553A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A340E285042
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C0F130E30;
	Thu,  7 Mar 2024 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cv9Cizq7"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0587C130AC4;
	Thu,  7 Mar 2024 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832759; cv=none; b=nNSlRl/nyFD+Y3MM8gzuLC3VVFaK57sFJpO44brnrleMoco85KdrfVFvDtLuSSLU7Dbw7peJS7VQizxIAOz5WEc0Bvmo1Fj30f8ZScBlTbQzrvpqM/25wD1i6JAMVlWPJU5Eir624INA8o2aHCG+dfCojnsrz4SNAURir6FpCl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832759; c=relaxed/simple;
	bh=os7MvWdKXLSw9AkDhcPRjA7sgslEH0TCOsCPjkfdKLY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z1QwIDoKWAQ+EvP2bo5Edwpc8TpGEdqJh5UlUKEPPwFRNvzuwY+0EIMeh+4VQ2lgnnaJ5RC2p1Y0ZopzJabVrOTM5wKGgaEe2XZ4xTdCShcPX8qaZpgZB2Heq+iEUjDu0A6CUhXGwNQ79iiwhPk+A071FrMAvrIMEQjEFgj9ylg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cv9Cizq7; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=56j5n
	tVzigxy+mWlLsPQSN6BzY98TlaoAkW9sN3oqa4=; b=cv9Cizq73AGnBDEaxElb1
	SZFxJSelIbZILxPmvoaqsKryhbwOIwXTZoBLfvUYRcAlMkhQa+q+ndZtqPxxCdMR
	VmLW09v9jqlM4Mo15gaeV16a+nVeM0TzUs9JIoAjUVD+Bc0d3eTHCTFaLmDnHw6B
	PBBQEPqz91uCZdoMOE/8Bg=
Received: from sc9-mailhost1.vmware.com (unknown [114.250.139.10])
	by gzga-smtp-mta-g2-0 (Coremail) with SMTP id _____wD3f2Al+ullk2FrAA--.14028S2;
	Fri, 08 Mar 2024 01:32:22 +0800 (CST)
From: Dingyan Li <18500469033@163.com>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] USB: Use EHCI control transfer pid macros instead of constant values.
Date: Fri,  8 Mar 2024 01:31:59 +0800
Message-Id: <20240307173159.318384-1-18500469033@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f2Al+ullk2FrAA--.14028S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF13KF1fAFyfJw47AFWkWFg_yoW5JF15pr
	W3WF47trWUJr4aqr9rArs5JF1rJw13JFyUKFy7W3y8CF40y3WUGF17KFWfJr9rXry8Gr1Y
	qF45WryUurs7JFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UE9aPUUUUU=
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/xtbBzxKay2V4IHY5PgABsB

Macros with good names offer better readability. Besides, also move
the definition to ehci.h.

Signed-off-by: Dingyan Li <18500469033@163.com>
---
 drivers/usb/host/ehci-q.c | 10 +++-------
 drivers/usb/host/ehci.h   |  8 +++++++-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index 666f5c4db25a..51b46001e344 100644
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
@@ -642,7 +638,7 @@ qh_urb_transaction (
 	}
 
 	if (is_input)
-		token |= (1 /* "in" */ << 8);
+		token |= (PID_CODE_IN << 8);
 	/* else it's already initted to "out" pid (0 << 8) */
 
 	maxpacket = usb_endpoint_maxp(&urb->ep->desc);
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 1441e3400796..dafa6628e134 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -321,10 +321,16 @@ struct ehci_qtd {
 	size_t			length;			/* length of buffer */
 } __aligned(32);
 
+/* PID Codes that are used here, from EHCI specification, Table 3-16. */
+/* #define PID_CODE_OUT   0 */
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


