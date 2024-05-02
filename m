Return-Path: <linux-kernel+bounces-165983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B898B9434
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0331C20B31
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEC720323;
	Thu,  2 May 2024 05:26:54 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EF0200AE
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 05:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714627614; cv=none; b=TrtxU50BeZVp5cOA7Z9Ds7d/hdYpqg0t9ZHbFAsajfwhanwZTGll0RjtNIEOe6ZMqab/+lmkWh0JTyREpcSZbY3fP3t9kHY3askqc4LRzmdH0iltbhDm/fNubwoRHhv3opJKBACxHWDBPmVsAfkaOJUMOgIwbBb/gGM8maroJv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714627614; c=relaxed/simple;
	bh=ur4DataS8Qz4POhEel9+H4ZT5TcvZk29GHrmk2UzQ6U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TFbaVPK4aIZomAHKEaBp4jXftjwrpnytitxX68QWT/pb+uFTUfDA/49qyK6dFmT/K+pRYlEEAzfd2P1HbxrFtJK9TgqkZNbViXpPwGwOyjleym/uVWf6/cs9GcwPaDOCSUx/qgTXszatN9+wLqxBxbvMmmyGuutxicOLK0dAbP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36b2eee85edso84016645ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 22:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714627612; x=1715232412;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsmQu2hL+uNfDham3bKnHxWZBKYThIolennTn7iKw28=;
        b=YJ07DM7HMmaRmwtLuX3dl/w3Nv8GIOiz+eVMxjAPv7Yg3SOcfgnqWYDNsce+U7TIHM
         yIQ6bPT6B9Yk/a/gfjEPlI26gZETblQIC0S9zLjhQnl8zKjnhfWKRXWj0xpuw0YWOZHX
         t4WLM3Wzqa/FlNgNOOejDHJt/CLIbq9CyOZd7P1gY7BA3gZjDc8KQshuvH9Po9Fo/W7c
         w1e1PM7IVTfT7S7wxXysr3bTBf7Zyf2Xn3YP214TJzOAy9yk8IP/BI/LXq8EWi3OxIuT
         CFbBZxqoebUOKzEj+og0m04d939UbkrtE+PnETauJkL7YyKb4FZje9Ufv1XvGtYfnX2e
         7Jew==
X-Gm-Message-State: AOJu0YwCsMEg6aeEBT0LXK1vhBrB/hc+T95yzyM4avIjcpip+K8gtRoc
	9o9gvo/mFiXiaWVeyuEUH6T8K6R7+EcjFcu0RtaoaDuyWj0OvmXpX7HY9EKgcfxlL5DKcBnZ3Rh
	YJikuSESsaJko48gmWM6TMZIr7PDlSD0HI4WLLNi3pcS4NmfBELY5Io4=
X-Google-Smtp-Source: AGHT+IE6LUqsCGxhCFMOlIRl4yqKtn1etpUE4ROY3yBI+hIgZl3iGevndby5VPNo/g0lwQFE5PR2UoRdAL+/PV5OxXBaeGS8Kvm7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214d:b0:36b:3b10:7425 with SMTP id
 d13-20020a056e02214d00b0036b3b107425mr318667ilv.6.1714627611960; Wed, 01 May
 2024 22:26:51 -0700 (PDT)
Date: Wed, 01 May 2024 22:26:51 -0700
In-Reply-To: <00000000000003b4af060de27f6b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bbb92f061771d92a@google.com>
Subject: Re: [syzbot] [PATCH net v3] nfc: nci: Fix uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH net v3] nfc: nci: Fix uninit-value in nci_rx_work
Author: ryasuoka@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e88c4cfcb7b888ac374916806f86c17d8ecaeb67

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


