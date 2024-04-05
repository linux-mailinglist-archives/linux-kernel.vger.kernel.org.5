Return-Path: <linux-kernel+bounces-132529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D55B3899645
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887391F28713
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC142C688;
	Fri,  5 Apr 2024 07:11:23 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375D526AFD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712301083; cv=none; b=uQKfQGAJq2OJtyKTVpjdo68bAI3bsZbAvoD0A2S2g4oYiri4GRzmFxO8Tu7wbpp8YoWPg31xL7kGc4aovi4TypWsPg337/TLCoXRVA2UsD3TYORGmW11S4zckY2p47Tn951AJ578yzXodGEHlYwX6imUsBhMycOR+SRWtkKLrKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712301083; c=relaxed/simple;
	bh=Dmljw7Ht/EdxSFtaZ+cNEc5rd8nUb2S5gELcaZh4maQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qlCZ8TMryONmwZ1x0MCPg18Zp2Elh5G9BPYdpbvdGCGQSgWj8q4BmlOxWPa4twgoWq2vkxeqaIqaOfXerhBvi4V1RU7psjBa+bbY/v72Q7C0xx+r0qYCFkrGyp+9LEMU+3soc5IueUoc0CmeeDomYwp69adUOM21wCil5qSms5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c88a694b46so173282839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712301081; x=1712905881;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VI6tj/4+5h+8NlfXYKt2wu0xWUe1QHq5I82BNG3HMc8=;
        b=Ij/hVpqtJQqsLbj3N3/23esP6Td7DHRLs7jnzOq3Mz2kcN3am2D+iVkFYKTT+8mHcE
         YQbebzH5avOeOs2cQOqYu99YYN/zVUFHcDSsK8/Ys7onzGYQQqGO3YWwzCC2uLQMwfLP
         yk80ZrTdfGJZiXrSD6uZMXB+PmpwnlsZqWvO5S3GeVjH14COOVFYqmYGq8QoeaTKmo/s
         xHYqEbwaBk8n2uekQvOvrcTX1RTAnR3FL4UJ+sH0KqWO5ERocaYitwbkBIpppCLxX+w4
         eso0wVfLaGehLO6SpIiY/NYyQMz8yloXjW9R8E571l4HbfPzg7TTvAifXMuEc5G/b4o/
         Pagg==
X-Gm-Message-State: AOJu0Yw3zzJO06ZYnKGdaxKnM9S9PPk/Fj/x+RMSmiJQzmqUHwgQUDjV
	6HyETy4J3ww3Py/zj6b+vSSjZ50HqRAnasMT/pXJz/YAOlnDj6neAYzZDT359ClZfpCL08UeNkZ
	el+rBexD2sGGjjAD/vqx0rSj/N225q9UegrXM6sE5eg/n7M4Oxv2sbfKCsg==
X-Google-Smtp-Source: AGHT+IFjFcyIZkGLKt+EGudnSbFptm3lmfY625/0RfGAzQA0W4uPaRLp5nZes1oiJg6WYriBrLCstjpm+jWzazZNsftMGJLft6Dq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1302:b0:47f:1e72:246b with SMTP id
 r2-20020a056638130200b0047f1e72246bmr21632jad.4.1712301081454; Fri, 05 Apr
 2024 00:11:21 -0700 (PDT)
Date: Fri, 05 Apr 2024 00:11:21 -0700
In-Reply-To: <00000000000003b4af060de27f6b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6390106155429c5@google.com>
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
index 0d26c8ec9993..b7a020484131 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1516,7 +1516,7 @@ static void nci_rx_work(struct work_struct *work)
                nfc_send_to_raw_sock(ndev->nfc_dev, skb,
                                     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);

-               if (!nci_plen(skb->data)) {
+               if (!skb->len || !nci_plen(skb->data)) {
                        kfree_skb(skb);
                        break;
                }


