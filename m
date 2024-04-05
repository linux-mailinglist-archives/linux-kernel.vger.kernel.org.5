Return-Path: <linux-kernel+bounces-133294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BF189A1DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F721C238C7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C5B171664;
	Fri,  5 Apr 2024 15:50:54 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0351171063
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332254; cv=none; b=M+DnjhoUN2MWoxD4LtitOWzefWou2jFA67ADK1fEWhY9ksBqxdFqGbKScorEZoNu9Sl+RtyhjxUa4/wLE66/jBB2mqJDXvFCS05vzu+9RUw618haetMk+3sIrEKBvpRKyv9Rr6uucEDB4Mit6dntFeWCV1Yw2BQOI06edmzIprY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332254; c=relaxed/simple;
	bh=t5Thu64Kz3nh7OCwdy/gx8xlBkgWJp2lex4k0XHGFTY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eKMjC4AvGkgmwsZIMBEjeH7bhX281livYwvBC7eJhv8BnvfYqEUzlfshv0uS+X9VUpCFn668LEe9prfgZSpxIqpRVqUsctboyTgSDC38RJ9/ketEqrn/vd1INVqxoCKksg5I8f+A5Cg5DjeyujUTvRIT/tzSvtyRfyuH08ca3gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc0a422d43so229901839f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712332252; x=1712937052;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q43kO6t/8BwfhJ9p2HK/8wPVXJ0IFuqPzoRhn/Eoops=;
        b=b+34iIdOyCYp0SFQmrFI0yTl5TV7xti3/JhUL25FqQ0vFN8Y5rt3xTYlFJ0iD0Yk/M
         lnbZHv97Bfm7stWdqEeRfPn9cEaGZasmUzbOCl80E7q5qm9g1Q+zyTeGKT5q5lr43KaU
         CtuIKBsRRbE+XpbPHtaAMdVn+/Evh5qdSGRDimeHX6sEEqUBn7MYxHJZVJTjwl2u2dZZ
         Y+42qI35Ixz9Jizoihm1P+CSyuL/9PHIwVkctVhAysEigecOFOmvCyMxXx39aYiYUW37
         jPOgVMvWuErQ3sn1xi/3MVxsRrEGDZ0tZp71eD+Az7WAHkwxcKsMzcHTGELqTf6e/7+2
         1Sqw==
X-Gm-Message-State: AOJu0Yw43XeJyUN+lmy/KDOPJ1zgjFar1mkxwhDWEgB3L0QMjzuXZLFY
	g4VnHltlCX0j9Y5D++nybJpwx6FLXUlbXOdBfZzcDzD7y/6V6Jt8wwYY2Uh2Ej4K6YslnE7E0N5
	llQRalYuCEVcfyWaizDgMPC3NKPnVw3IEuyctXtkVOMmIBYpWFglIE5TEtw==
X-Google-Smtp-Source: AGHT+IFy4gzjioWskKsUTbuMktiG5TS6K0QAiDAnliF7gwa80xoh86Pj9gS4q/9OJ2Y76GzgTrcunTKJf1p7/UcW66j+GqJRRWaN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:27c4:b0:7cc:ce74:4280 with SMTP id
 l4-20020a05660227c400b007ccce744280mr70208ios.1.1712332251907; Fri, 05 Apr
 2024 08:50:51 -0700 (PDT)
Date: Fri, 05 Apr 2024 08:50:51 -0700
In-Reply-To: <00000000000003b4af060de27f6b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009cd77c06155b6b78@google.com>
Subject: Re: [syzbot] [PATCH net] nfc: nci: Fix uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH net] nfc: nci: Fix uninit-value in nci_rx_work
Author: ryasuoka@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 0d26c8ec9993..b7a020484131 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1516,7 +1516,7 @@ static void nci_rx_work(struct work_struct *work)
 		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
 				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
 
-		if (!nci_plen(skb->data)) {
+		if (!skb->len || !nci_plen(skb->data)) {
 			kfree_skb(skb);
 			break;
 		}


