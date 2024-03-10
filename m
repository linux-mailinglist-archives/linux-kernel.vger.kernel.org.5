Return-Path: <linux-kernel+bounces-98134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A4A877580
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 07:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3981B21F81
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 06:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883EA1427B;
	Sun, 10 Mar 2024 06:12:39 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58C611CA1
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 06:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710051159; cv=none; b=EMTzsC10MkPFGud2XpApGWsCWI+zKkFw9k/paxump9vzm84xAi0K4bg37JZSilfO4f7QSBieVjbJTg/SziSvtGwQSUIKPZki/QnaGNI4M/N71GuzlGtUYWTwNHXuz2dE1zU5WbjEy2JnD271JJnaIcgkbyKscDNmFapguIpBT6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710051159; c=relaxed/simple;
	bh=qyv+3bFpMsnOWu4GkWao8mUjvPOobkOEDpIQmoQI3wM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mw9RxWRxIMx8x6HqmI+vuFJ3xJK7w7z1HdBcNCfDuqafcm7cjmDgmkb7BRLmTCob2AaFRFhKTF9OU4zPFsXfd4PwHjqFjVN3T3n523PLjvQs9jCeFs5nlEGt5xjcoHDDtpp41Mq0P8chb8Rjn0ZcyGY78DyMrDbAxWFxoFfpGCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c8a7e92815so58808539f.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 22:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710051157; x=1710655957;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j042LY744r6SWA/GKdXvGpeG3Iax2CVpuA1/grVDnkE=;
        b=CzC7PqllalfjSeVjYgdo2e0dA2NvZ9NEfi5NxvFgY9Bar6bJG+WCpiyhH1rHr0AnBn
         FTZmUt+M4hDzmiT5FrCnp1zDGLqlw1w3qEcvMASHUYwoEwfk+MJCixwVEVbHM6x5uaJ+
         zT61SJWk7h2i7nvqrdvPoP9J+XtVVdAlZJrbwPEcFqV33XASfzaosY5Dt0Bo/lRzB6xz
         BiL025pUcH2eyp+KVSmC6VQc4LNcOEm9MsI42qRHUoyxUG8wMSdxtORD5NiedFlTHwDS
         SfCs2S9jwYrB9be9jhWBxySGYzk3N+ZwAye/dtToJUlEwwtKvIW/MqgqGTPtgiiJwr0I
         4O4g==
X-Gm-Message-State: AOJu0YwJPawjhiZts+YmuSkF1vqKvyzMO+8N3FZ4TrPAKekJAsJgvrlk
	f5SJmxSuKsYxs7RU901DCbybhpgMUJ+ztAX7az8gDjkOv9V1vCu9bU/aytxBPTIZYM7hcC3bova
	MZsliVwr+2SzWWIzZJYfh5HuO83uvm6pxkgBGW7FBCYkWShc3/0w41GBvNA==
X-Google-Smtp-Source: AGHT+IH193EDJbatGmXDiPcezS3dkKG0DTNraN023YTOATKeSdOM8JeYy1ETm26FK3X6a63MtlrGTihGnHDGyEsgovKPZhjcxYzN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2109:b0:474:edd2:1ffe with SMTP id
 n9-20020a056638210900b00474edd21ffemr205173jaj.3.1710051156898; Sat, 09 Mar
 2024 22:12:36 -0800 (PST)
Date: Sat, 09 Mar 2024 22:12:36 -0800
In-Reply-To: <000000000000169132060fc66db3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c148a70613484f3b@google.com>
Subject: Re: [syzbot] [PATCH net] nfc: nci: Fix uninit-value in nci_dev_up
From: syzbot <syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH net] nfc: nci: Fix uninit-value in nci_dev_up
Author: ryasuoka@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index 994a0a1efb58..efdd733fc676 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -759,6 +759,9 @@ void nci_ntf_packet(struct nci_dev *ndev, struct sk_buff *skb)
 {
 	__u16 ntf_opcode = nci_opcode(skb->data);
 
+	if (unlikely(!nci_plen(skb->data)))
+		goto end;
+
 	pr_debug("NCI RX: MT=ntf, PBF=%d, GID=0x%x, OID=0x%x, plen=%d\n",
 		 nci_pbf(skb->data),
 		 nci_opcode_gid(ntf_opcode),


