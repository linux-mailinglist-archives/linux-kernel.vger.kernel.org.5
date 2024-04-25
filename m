Return-Path: <linux-kernel+bounces-157946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D40E98B1911
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AD9AB21702
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FC81946F;
	Thu, 25 Apr 2024 02:55:28 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A809C1BF3F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714013728; cv=none; b=tJqklUOsRwORTOBVDKGkk3smm+cBokEpCjb4C8UkYC4kaGtNgLmaw4R+S1cWbFpm10rSyuWq2p94CqU1Qwa9kH1AVqvKTN7v9xEd951W+4CJ38Ev6V2F/NUvjY2ZAJCKUVtY1YCBdwj0syIt3XTOBUBk4uLAI1Bh7okyami9xmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714013728; c=relaxed/simple;
	bh=JUttkMhVGh1IJWiY5r5DtRaZW5vUZuTnUDQ3g+bjlkM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xwd55zXhDnr0lr5uMY9/AyGr6c1WwHWTElj8EfHX50ZdCht2vDA6dZk03GaIXK0HeRSXKoaTuk9tZoBW6M5+tWb5ywOKWKLuy1BpQpGBTPPukA3Dr7jiqCq6+5Zm8fpLooyDK/CHvXQXiOVWSDCZ7ZcL15TkOJNkewNoGV/XurQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7de9b67cdc7so53292939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 19:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714013726; x=1714618526;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrQKuB3M9ukVnC0f/ytlqb4Wz/dbQHYq9+q2gTngm1k=;
        b=UUeVqumPTmqJ0X5FtJsktU2GVFr3kRDXoH+Kl9reAi+n9sPztLVnpK3zpUkuP+yM7F
         Zc12ajDcEO6PJYUJKVq4zkuyz9sARUQkI88YUaKPyYSzDcCi1gHcGu7/azNbcNsByOJO
         7/f1Ky2OaMhfSgwVQ9x4v0dEn7+Pv2qheaBiXKfZabbalSwpnxYL/dzMQpIKnGVLt2Pm
         M/dcQNPm8UcXGZhZQ39BKkD7rwzlUgsHViZf1tfXZbqyla7vSgLvqIlf4iFWpIHHRBqz
         YOHZTNtPDiTIbFkfA2SB1cBcDzwfhH6c1XlqbP7kOOsCjZAIukw8C1QMzjLRYxXHbupM
         lxgA==
X-Gm-Message-State: AOJu0YyX3iDPuHvWve//cie3ATerjbgC5tHlvSuWbYKFLGoQ/qy2yLLn
	FpMYicv/OAnLBW0OxJmX5qfCKyogyWeiRxEpn/F0JZoEWcAWiI9PIgFTDjV1zMUoTP/ifA88hHV
	QfHVhs2J7pNT9DOt/hF892EeCfyIU+C9SR3QSI7MQTPeXG3e8d7QxlE0=
X-Google-Smtp-Source: AGHT+IHQ+OsfRmagohOb+rFlENxqgD2EM0CvudJDHTpFmDoiTWsjAtnHhsVSlpinvmwz+LufSi8XdMmssNKaUNzcrDc+RWYFqHF/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8521:b0:482:fc24:b74c with SMTP id
 is33-20020a056638852100b00482fc24b74cmr366918jab.0.1714013725968; Wed, 24 Apr
 2024 19:55:25 -0700 (PDT)
Date: Wed, 24 Apr 2024 19:55:25 -0700
In-Reply-To: <00000000000003b4af060de27f6b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046d6190616e2ebc3@google.com>
Subject: Re: [syzbot] [PATCH net v2] nfc: nci: Fix uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH net v2] nfc: nci: Fix uninit-value in nci_rx_work
Author: ryasuoka@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 0d26c8ec9993..ab07b5f69664 100644
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
@@ -1516,30 +1526,36 @@ static void nci_rx_work(struct work_struct *work)
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
 			break;
 
 		case NCI_MT_NTF_PKT:
+			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
+				goto invalid_pkt_free;
 			nci_ntf_packet(ndev, skb);
 			break;
 
 		case NCI_MT_DATA_PKT:
+			if (!nci_valid_size(skb, NCI_DATA_HDR_SIZE))
+				goto invalid_pkt_free;
 			nci_rx_data_packet(ndev, skb);
 			break;
 
 		default:
 			pr_err("unknown MT 0x%x\n", nci_mt(skb->data));
-			kfree_skb(skb);
-			break;
+			goto invalid_pkt_free;
 		}
+invalid_pkt_free:
+		kfree_skb(skb);
+		break;
 	}
 
 	/* check if a data exchange timeout has occurred */


