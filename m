Return-Path: <linux-kernel+bounces-106913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8A287F558
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52526B21BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA5764CF2;
	Tue, 19 Mar 2024 02:18:47 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F52F22
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710814727; cv=none; b=r+u+zgU1UEofx0uQ56+UhXC4gUpC192o5G+V6WkFaLNRuaHeMOrVmqHt5hBSf1CHVBjv8G+v68WSZWgO31iMvtqeyjcZOXCImSW42jI0d5L90EeSJa92CjRRsta3JGjz0ECAmah62XYsiVyAUDL+P41AuACIprrmKtRbuVRkxoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710814727; c=relaxed/simple;
	bh=HXKLdL388ATP1x+Bi+eSNo4AL5q14dhPe1cC6n4T8UU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iU6bkJGZB58+VYMiM9jE4L+mk4lDBNUymMT6A0FCdv7FOGzx6Seb3i78+VG3YJ3IqSg+emAXAbbOKDAB/4Ajz0xNMKFA7JvpjUBA+LdcskpyYuo7nuto5QtTZnNWbwajtN2u2p4Jfq13g8ji2Y/duUnPItMzU1J5vLoEHzVI5/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so453251039f.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710814724; x=1711419524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcyfP03YnAHU9fTdFHb9Le6Rp18xT6BHtV9FG9VE+/A=;
        b=uHf1P8hexG1EsTekBfaCI7NI1Kl/I9hFR/jLjpiQcsTgyDs0X+igyZGoqkRtNJCp3I
         isssJf3jbFTp+aGd6mLV7wWjH4DNn+EYa4KoMmr66kSHZXzNFEcF34uOL5RWlJYQ8P6+
         ScFyqEktumsspUxatqHFVJA1ihr9+K0JgvUfeFg629bX9DO8nF3ubnlWT6c63Vt/CkN2
         4oVHWuQloeaf4oaQQeaIBNNdhJT4/fQMqc3iWIm1cWejxJw2Rn2jHVQ/xOPpIaOlSmha
         q6AMr1RPndIEHR16gHMM2QgCD38q77FxAxaWTOphVrke6z/AvH6zO/HOYv+iG4fiSLkM
         c6Zw==
X-Gm-Message-State: AOJu0YxsHxEjNKgPPvr3ujDgVQGUWwpTloqN7r9gggLw+j+dxgKnKt1R
	gP9sHWIYT29P+RHN6lwrfxK3p0wJTjUkQvkL+mu6TaU8L/hs9m187J4nya3+9V6xl5YJa4/PvLd
	im75TRya1TFgg3FYnJMFKsGfTlLQEt43GAhMeMoHIJKlZ0vlF1zZZryS5KA==
X-Google-Smtp-Source: AGHT+IH+SIkJA9OiiAvMxUBaVbyd15sZUiHaxYTatdrgLfT7+NU33T26mdc8HhVw+ssjxH1rkxEWQhH3KaCvQCPqOZ6fd7Le+AWI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3791:b0:474:ecf4:2b71 with SMTP id
 w17-20020a056638379100b00474ecf42b71mr900903jal.4.1710814724787; Mon, 18 Mar
 2024 19:18:44 -0700 (PDT)
Date: Mon, 18 Mar 2024 19:18:44 -0700
In-Reply-To: <0000000000005f31a3060de282e6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f29ebd0613fa175a@google.com>
Subject: Re: [syzbot] [PATCH net v2] nfc: nci: Fix uninit-value in nci_dev_up
From: syzbot <syzbot+29b5ca705d2e0f4a44d2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH net v2] nfc: nci: Fix uninit-value in nci_dev_up
Author: ryasuoka@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 610a9b8f49fbcf1100716370d3b5f6f884a2835a

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


