Return-Path: <linux-kernel+bounces-157945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA398B1910
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED3C284EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524DF17550;
	Thu, 25 Apr 2024 02:55:27 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700CB1AACC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714013726; cv=none; b=CeX7RvpWF4NAGGefMChJYB9Jc9FX7gCRpgwjiQI8LZAY7JzbcFa9Pgmn/tgNT4OkolSqvdp/9kSM7K5zq5wIy/cEeyI1kRfYqdH7RoLuPp+kVu2JhHt9TgBQSrUxha8d9SqWY8jkb6T6DWgsMVl7kMmhlrHhlWfogu88HWUu958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714013726; c=relaxed/simple;
	bh=JUttkMhVGh1IJWiY5r5DtRaZW5vUZuTnUDQ3g+bjlkM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oWmwqmHekJznhi4sV0IPWas2biCAya6a3hlpUKvKobctNeFiiTbxliacPUmNSEuGHRmU1kAcIdhnqSAEcv3q+tC5GJqnNkH6DbtZHflxLb/i07LTolrkSnwNhKWiE4qiK+XGKdo3NCMrIXGPFMYevUQ0/dqwPbTHFt/ah9lv3bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so55694739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 19:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714013724; x=1714618524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrQKuB3M9ukVnC0f/ytlqb4Wz/dbQHYq9+q2gTngm1k=;
        b=i1xq4wTUr3+kCmRDKjYJeVV0QJdg2MpWfrDhVGxuok08nhx1jo9AQTLZpChq9Xbks2
         25mfXA+j5/mlPX1xnHkwm46TT0qg4mR0WQf4jAMBhVog/Jj5bPWReTNhqVcy1w8caifa
         fAtxTbZ6aDMF5WwpkSX4x2WfVUrvkjx+nEo/N5S5aRv5f5wPBtg+CvfKUnO7bDwDrloh
         8YX/N/rVgMkj/u0ziOp7ZNbrGbtMR6M44Gq/MKsPsTToeh3H0uTNduhUrqUdChNxZHVX
         CkZKOxUf3BeyFX7G41na+ZuFQu43PtDH5CqSJBW4A8E2zItzDL2wP445ODfFSJoBgZGS
         ud3A==
X-Gm-Message-State: AOJu0Yy6l4APccOql83jwdAPwtedmGeLIgQQKUZJ9kBkNU6nnj+ylzV3
	dD49tOh91QTeSMYiXan4QqIhTsnx1brBE+fol0/qS94DXfTG1bKOQhnczoLisTw6S2YZ13CEdex
	hXx3prypMKdityL3RS2g4xLuB5g4omCEkbmwfWrRoVfP2+k4Fo/aCfzo=
X-Google-Smtp-Source: AGHT+IEs79DcwuscxRV2lPeV9jEl9EcpTHMMJO1JtMaYc2wySdsjbreDBvVI/3Ybt0nEYpFo/1uOXkOiTZCtd5CabY8p9EIXin+x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8502:b0:487:ecc:6f2f with SMTP id
 is2-20020a056638850200b004870ecc6f2fmr56868jab.0.1714013724642; Wed, 24 Apr
 2024 19:55:24 -0700 (PDT)
Date: Wed, 24 Apr 2024 19:55:24 -0700
In-Reply-To: <00000000000003b4af060de27f6b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000329e380616e2eb40@google.com>
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


