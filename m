Return-Path: <linux-kernel+bounces-165672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0C48B8F50
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B491F23701
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060A71474AD;
	Wed,  1 May 2024 18:00:46 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF7D1384B1
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714586445; cv=none; b=mRlZ3kHfe9/bpuBmY9cgbgKG6s0GT5G8WqHAPNGXm59zkbp9QIbk13uWfTUg9+IRPiTWwTR/sLjPwfc5q2QxyZENNhpJptlMqR+lpxx3ctTByTkpAqKfmENIeX6unVqz2dFroAZc+VImVJMIAuygjA8F2winnwSXVhnig2OlED0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714586445; c=relaxed/simple;
	bh=zUm2mz7vlyO2X/Zw/kb5eSC3GNO8p3NhZ+BwvbdKjJg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ru5qyjFw1wSoHIuJy3YE/QO8CiCT+GYE4MBB1Gp+v+uUv7FXVuCSixKc2eemRb/UxWf1xyKh3VVaVtAz4Ao/pXceXcoPyRg9zwOUur9xI32Yfzs0f+tg6X4GpbbWZLtCk4iYjg6yHNDYFQGI7KEdzd8Dtr3l3NzUHLppo7ok5Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da7d4ccb67so756794039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 11:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714586443; x=1715191243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZnet9X3XAB5zOp6ShaIsnBpDIJDTNZCMwS7jegTrZA=;
        b=evefkwLieowscypanQ1fhdyGV2raesWOHgSdsNqBpfnmyq2ekIfubQ7Y3EFlFwEroT
         D7jCfgBhOAE21uEKqGdUbn61DDLDFMjtTn/ZA6jXFWrxVmAj5AQJ9AZ3MtxMH+Itfr9Q
         RAFDNo7XQDHxv2V8b7BP6D1dvuwJHJjlruFlcmX2WkEo9IV5Cw8z6sVOdJtzI+UZi5PT
         0QxxNjZoyb4qDtjS21P3+BmnzZrKAW1I9L9i6SK9wese6j5AZBPt30ycYvHQRucY1UQP
         BX2Ui5jLAQ44YwJF6k9LGV0dHjDXfJ35Q4QVKNEdYmjgZxmyoOToIxKTvQNHIgqeLwuG
         CgiA==
X-Gm-Message-State: AOJu0Yz5AZSxTnBmyhZ4yoAWNvzev1WDlfhfAI388LtBc6pmFo0yWGKT
	/J/XPOb+3L+fFS3KfsKz9x8BSuLwGiFlijocia+oH3iwZ4j6GLnWLu5t3U9iFgieL4v6BXmKsSf
	QdjJd1oddd9bT5rCjY0oPRgh+WRpxaeLmDVW0x3w7YE90Q2Kyhv75Ryk=
X-Google-Smtp-Source: AGHT+IHJOTVW+BiItJLl26yyFvyZ3uR/dOijvYva1ZzT4C80ivo63O55JlUQeMoc3YPO8PR1GQMiCyo7W0Afd1KgGbdY8klCee1W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8d:b0:36c:852:9dc with SMTP id
 h13-20020a056e021d8d00b0036c085209dcmr264622ila.6.1714586443072; Wed, 01 May
 2024 11:00:43 -0700 (PDT)
Date: Wed, 01 May 2024 11:00:43 -0700
In-Reply-To: <00000000000003b4af060de27f6b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e058dc061768436a@google.com>
Subject: Re: [syzbot] [PATCH net v3] nfc: nci: Fix uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH net v3] nfc: nci: Fix uninit-value in nci_rx_work
Author: ryasuoka@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 0d26c8ec9993..e4f92a090022 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1463,6 +1463,16 @@ int nci_core_ntf_packet(struct nci_dev *ndev, __u16 opcode,
 				 ndev->ops->n_core_ops);
 }
 
+static bool nci_valid_size(struct sk_buff *skb, unsigned int header_size)
+{
+	if (skb->len < header_size ||
+	    !nci_plen(skb->data) ||
+	    skb->len < header_size + nci_plen(skb->data)) {
+		return false;
+	}
+	return true;
+}
+
 /* ---- NCI TX Data worker thread ---- */
 
 static void nci_tx_work(struct work_struct *work)
@@ -1516,30 +1526,35 @@ static void nci_rx_work(struct work_struct *work)
 		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
 				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
 
-		if (!nci_plen(skb->data)) {
-			kfree_skb(skb);
-			break;
-		}
+		if (!skb->len)
+			goto invalid_pkt_free;
 
 		/* Process frame */
 		switch (nci_mt(skb->data)) {
 		case NCI_MT_RSP_PKT:
+			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
+				goto invalid_pkt_free;
 			nci_rsp_packet(ndev, skb);
-			break;
+			continue;
 
 		case NCI_MT_NTF_PKT:
+			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
+				goto invalid_pkt_free;
 			nci_ntf_packet(ndev, skb);
-			break;
+			continue;
 
 		case NCI_MT_DATA_PKT:
+			if (!nci_valid_size(skb, NCI_DATA_HDR_SIZE))
+				goto invalid_pkt_free;
 			nci_rx_data_packet(ndev, skb);
-			break;
+			continue;
 
 		default:
 			pr_err("unknown MT 0x%x\n", nci_mt(skb->data));
-			kfree_skb(skb);
-			break;
+			goto invalid_pkt_free;
 		}
+invalid_pkt_free:
+		kfree_skb(skb);
 	}
 
 	/* check if a data exchange timeout has occurred */


