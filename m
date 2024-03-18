Return-Path: <linux-kernel+bounces-106345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5675C87ECCD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196D0280F64
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B956D52F7E;
	Mon, 18 Mar 2024 15:56:11 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA3A524DE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777371; cv=none; b=rQIeHfc3VoJ//2oWat4HhGM0eB7/FZPsReztM/Y/qSy5aMpQSFqJkSbQIwFVOg1qrf+EyN8sutOiYXgbANpsfXENz4f6e7Sp+UraEsuMOMllWJtPdISc3czryRrMxU2praVcvw305bRBut6H1ivyWRUR1xk8wiwR//3PPUlLp4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777371; c=relaxed/simple;
	bh=VI4jxzNgLrtL4yc9lnV2mABn91LpO/tbxJWk0qqgnw4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gSNRhGBIjvY4F8RyP/HQIWexgBBzxdThOWUd6BMU47EwuRfvQmYD0e5zkxwEi8enOVmk74gWoUZ0BEhUFLiBXIxvXezoxdV9Wl4FX+UT4+SWqENj3zEyEpjO/2hTC2FQ8WzjogY1N3sW/JxDldkoXrDcf0TyTa/0yFtbEBuJfIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc70b85c48so84769839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710777369; x=1711382169;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3ezPXJXQwsR7BDGZUJv1LoFcv0GvmsTyFJHfj+hkm0=;
        b=b4aP1uYoGsQiH7RAlQfDO/suGsrC+3TfkBZsuFr4st6QxWiJ4hZj2cqQ3Ekmn/U4+J
         go4AcXm60JQzPCMi8jqLsLJLzqR/elj0LesIvgKd7zBNn2jltHxNHzOlzJ2x9dlA+oLZ
         L+4dvGK+AJU5IczxisLQcx4NmnNTX7B8VIxQJj6SFsFjzAkQaWeDjObmnTImcvQd4yue
         f6ristpwW3iSy+Rjxfz1Wbh6/dDejjVerPLBsaD1JRSOqtkaHhGtK+q39+zA7p5Px9f0
         gsnnolc+bb2S8QR5312fc7bvdX9QZwgWtfpq9ccf0zb+kLe7ZjSOMZ9f2A1uZla0XTPw
         PZ/g==
X-Gm-Message-State: AOJu0YxVgeLVwUkOibUitD06OkBjOZZUwKkYHNbjvUs95hkBk+jK67bx
	RecG7W+ynkUy3VTEIkvIbjetnwVuV5qaBvd7q+r2xsaPY9rCULEvJ8bdP6tMEDi7Y1Jccqtg4SY
	HnSWg7e8zf8zEnymRAzPxnDJnpY/FQlCIFGrMeixRI25zm59QlDdwnnHT+A==
X-Google-Smtp-Source: AGHT+IEUfGLyUpRaWvyNz7rB5R3LkvV/ohITqAazMCUjidNwTQ4B1Nn9/24mZ9rp8ukpiFTV+vDl5bMGJ0Ycv41XgklqDZC0V1TJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2403:b0:474:f25a:6fb with SMTP id
 z3-20020a056638240300b00474f25a06fbmr932843jat.3.1710777369179; Mon, 18 Mar
 2024 08:56:09 -0700 (PDT)
Date: Mon, 18 Mar 2024 08:56:09 -0700
In-Reply-To: <000000000000169132060fc66db3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006148170613f165e2@google.com>
Subject: Re: [syzbot] [PATCH net v2] nfc: nci: Fix uninit-value in nci_dev_up
From: syzbot <syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH net v2] nfc: nci: Fix uninit-value in nci_dev_up
Author: ryasuoka@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 6c9592d05120..f471fc54c6a1 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1512,6 +1512,11 @@ static void nci_rx_work(struct work_struct *work)
 		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
 				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
 
+		if (!nci_plen(skb->data)) {
+			kfree_skb(skb);
+			break;
+		}
+
 		/* Process frame */
 		switch (nci_mt(skb->data)) {
 		case NCI_MT_RSP_PKT:


