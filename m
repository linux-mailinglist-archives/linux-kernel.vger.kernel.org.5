Return-Path: <linux-kernel+bounces-159677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA318B3205
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF7A1C22214
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8351013C91E;
	Fri, 26 Apr 2024 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jze/LJ6Q"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B33A13A3E7;
	Fri, 26 Apr 2024 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118968; cv=none; b=QfBfk9D7KzZOUwjD+BsObtvi4RwCihGnEPAmOo0NILkjDI07n6p9Z7cDWQ1aoBJMVzJY04VUKp6BOW33eNAMC0x/7gkUraXjHstGCiq0pEff5Vo2UNnyUJ5orjVqi6x7Q1xXJgCXlQ6mXDDAOBWInRpXLXXufuJPt7g5zlV+Feg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118968; c=relaxed/simple;
	bh=dqexjYVG/TRkkiRk3X4lAKrAzhWMuPT98yCFL7d1i0M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GwrE+JA1ycyehYPnrErsWDDA4nZ6lLn5I+hvs39ghg2aVKuWAmYVhixynAdCPbg2zSo0xILRiBzfb5hUr3F12C2L9ichZE5cY5fWvmv57VPUUxYNBzfQq00spjIBWpDVU7gAx7PRBLZDbAijOPV3jpKfx8OnQKwFJF6srjQkIzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jze/LJ6Q; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4ZX3C
	2yV/g45GL3DnetD0/tBcmwuj74la9gUgdxLngs=; b=jze/LJ6Q9A3vEKrrQxIoU
	gW/j8DkkC2mduhZzYHZ4zR1iLvOsk4MYU3CHKzTk27uMZU3GQifvRn50T3Hvjirn
	r8SPUU+89foHJnloA7zNko9HpfMZSWfCUl9ls061xJ+WncdVxhPSuglyrBWJ2Ix6
	eWyeiSvEtu3zvEdoIpbtGA=
Received: from localhost.localdomain (unknown [112.97.48.208])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wDnPprJYCtmjTm8CQ--.11148S2;
	Fri, 26 Apr 2024 16:07:39 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>
Subject: [PATCH net] net: wwan: Add net device name for error message print
Date: Fri, 26 Apr 2024 16:07:33 +0800
Message-Id: <20240426080733.819633-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnPprJYCtmjTm8CQ--.11148S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXry5KFW7XFyrCr15KF1ftFb_yoW5AF4DpF
	W7K3sxZr1UJay7X3WUJrWkZFWYywn5ta47Kry2v3WSvF1ayrWUWa4fJF95uw43ta1rAr17
	tF4S9anxW3ZrG3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piH5l8UUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiowvLZGVODFttogABs1

In my local, I got an error print in dmesg like below:
"sequence number glitch prev=487 curr=0"
After checking, it belongs to mhi_wwan_mbim.c. Refer to the usage
of this API in other files, I think we should add net device name
print before message context.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/net/wwan/mhi_wwan_mbim.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index 3f72ae943b29..6cefee25efc4 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -186,14 +186,14 @@ static int mbim_rx_verify_nth16(struct mhi_mbim_context *mbim, struct sk_buff *s
 
 	if (skb->len < sizeof(struct usb_cdc_ncm_nth16) +
 			sizeof(struct usb_cdc_ncm_ndp16)) {
-		net_err_ratelimited("frame too short\n");
+		net_err_ratelimited("mbim: frame too short\n");
 		return -EINVAL;
 	}
 
 	nth16 = (struct usb_cdc_ncm_nth16 *)skb->data;
 
 	if (nth16->dwSignature != cpu_to_le32(USB_CDC_NCM_NTH16_SIGN)) {
-		net_err_ratelimited("invalid NTH16 signature <%#010x>\n",
+		net_err_ratelimited("mbim: invalid NTH16 signature <%#010x>\n",
 				    le32_to_cpu(nth16->dwSignature));
 		return -EINVAL;
 	}
@@ -201,7 +201,7 @@ static int mbim_rx_verify_nth16(struct mhi_mbim_context *mbim, struct sk_buff *s
 	/* No limit on the block length, except the size of the data pkt */
 	len = le16_to_cpu(nth16->wBlockLength);
 	if (len > skb->len) {
-		net_err_ratelimited("NTB does not fit into the skb %u/%u\n",
+		net_err_ratelimited("mbim: NTB does not fit into the skb %u/%u\n",
 				    len, skb->len);
 		return -EINVAL;
 	}
@@ -209,7 +209,7 @@ static int mbim_rx_verify_nth16(struct mhi_mbim_context *mbim, struct sk_buff *s
 	if (mbim->rx_seq + 1 != le16_to_cpu(nth16->wSequence) &&
 	    (mbim->rx_seq || le16_to_cpu(nth16->wSequence)) &&
 	    !(mbim->rx_seq == 0xffff && !le16_to_cpu(nth16->wSequence))) {
-		net_err_ratelimited("sequence number glitch prev=%d curr=%d\n",
+		net_err_ratelimited("mbim: sequence number glitch prev=%d curr=%d\n",
 				    mbim->rx_seq, le16_to_cpu(nth16->wSequence));
 	}
 	mbim->rx_seq = le16_to_cpu(nth16->wSequence);
@@ -222,7 +222,7 @@ static int mbim_rx_verify_ndp16(struct sk_buff *skb, struct usb_cdc_ncm_ndp16 *n
 	int ret;
 
 	if (le16_to_cpu(ndp16->wLength) < USB_CDC_NCM_NDP16_LENGTH_MIN) {
-		net_err_ratelimited("invalid DPT16 length <%u>\n",
+		net_err_ratelimited("mbim: invalid DPT16 length <%u>\n",
 				    le16_to_cpu(ndp16->wLength));
 		return -EINVAL;
 	}
@@ -233,7 +233,7 @@ static int mbim_rx_verify_ndp16(struct sk_buff *skb, struct usb_cdc_ncm_ndp16 *n
 
 	if (sizeof(struct usb_cdc_ncm_ndp16) +
 	     ret * sizeof(struct usb_cdc_ncm_dpe16) > skb->len) {
-		net_err_ratelimited("Invalid nframes = %d\n", ret);
+		net_err_ratelimited("mbim: Invalid nframes = %d\n", ret);
 		return -EINVAL;
 	}
 
-- 
2.25.1


