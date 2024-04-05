Return-Path: <linux-kernel+bounces-133284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0C489A1B8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6131C22B9C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68449171079;
	Fri,  5 Apr 2024 15:46:52 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93114171065
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332012; cv=none; b=kPAV2dq+4oRTkZ4tCHar5kmuYgzVTy9yd/xVEtOFZcOMZAKjCbi+0srLaK5QtieTeQshm1lsCBgS0wMX/Mm1H+SNOu1ZizjLspGuRdhSkDeesW1WusH0YRo6w2DmL1V0T97lffZHTa0dvR+wS4IsvRkqSdj/qvDRmqpFTFJXn/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332012; c=relaxed/simple;
	bh=Cetg4OJSNRVbxOgEDST8sFZ/+xbB0Z55fdPod+6/III=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Kf1vfnnEadeIA/4rNdA4qKLerM07HSxDYk8n6SGbpU+Zmyqz5HwJdyLEzYIF1kdQTBmNcFEo/chdFLIUCHucdMbu9EPKLadw6qvI+jbnW/otOhBxrUchKKJWGbCqeZcYiWl3VCWs8/UM/mXLIo4Wx7WBvkyNx0alaMmKBmH6y78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so236769839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712332010; x=1712936810;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A68bmHKEizwZFzsYAasj3lqwBy9ZBvAbavQZhExDaJQ=;
        b=M5apNBnWoprvjhTnL9lfJDqfJI1hdZnqiwQLC/TIoWEV1LLTqoJjv45nbjP17nFPu1
         4UAjmZdUYNs9Wh1LJl45wloCw1iu8HNRfGdKPhCRy7W12vUpsxsKHgYHzJCR2stsYvKt
         efYlIIsAiSzpDHYkdNFR+PTkoTvj+yNs0Y94zkcB2KBj97xYTPRmon3wRQ+ajJk7QYhZ
         hMPcqKl++bzkZGdjZ+ARUxmJEk9jSTnReIJAVszrgbDl1lird5Kp/jtZ32iu/EwGc1+4
         k6uw9VgOoDyj6u68YUKf2jMJ8LskqIzJad3oacUxXvtJWnmxBKaO8yXxLA3ofpq4t/5Q
         jlvA==
X-Gm-Message-State: AOJu0YyVlnDP5panxNhMU45309Vo1AgLTLFMDBH7vyx8aJmDABiYIVRq
	HSJAztuL9R2H6ibgvbR9jXsoY6k/SqoAfDoTtELZAmP5tQQZwkdHS7VS7dqcOGFIWRPprcVS1Dr
	lCPeeStKIRz4nGMKzEE6YybPbS4FO6q742fX7v8oJpPaEVKFvHapJn9CBiA==
X-Google-Smtp-Source: AGHT+IGT+TUYP5Pp44yEPfn1AzJpz/tSnDm3ChWW8uywi0ug5zw85AVBP3X13E4WvndyHx/ghAJiDlMLWQztFsN3+v5G1KYPNEqt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1687:b0:7c8:d517:1008 with SMTP id
 s7-20020a056602168700b007c8d5171008mr33930iow.0.1712332009909; Fri, 05 Apr
 2024 08:46:49 -0700 (PDT)
Date: Fri, 05 Apr 2024 08:46:49 -0700
In-Reply-To: <00000000000003b4af060de27f6b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000030411406155b5d2d@google.com>
Subject: Re: [syzbot] [PATCH net] nfc: nci: Fix uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH net] nfc: nci: Fix uninit-value in nci_rx_work
Author: ryasuoka@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 58c806d867bf265c6fd16fc3bc62e2d3c156b5c9

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index cdad47b140fa..b7a020484131 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1516,6 +1516,11 @@ static void nci_rx_work(struct work_struct *work)
 		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
 				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
 
+		if (!skb->len || !nci_plen(skb->data)) {
+			kfree_skb(skb);
+			break;
+		}
+
 		/* Process frame */
 		switch (nci_mt(skb->data)) {
 		case NCI_MT_RSP_PKT:


