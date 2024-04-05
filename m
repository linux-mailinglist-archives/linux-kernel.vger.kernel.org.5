Return-Path: <linux-kernel+bounces-133240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5C489A10F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0916FB22205
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AB516F902;
	Fri,  5 Apr 2024 15:28:15 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A09B16F83A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330894; cv=none; b=tV0ILLGjOVVqLy9mirVjN0BN0SFglvPyoiIrC28T0KHK+ur5Zyrlyt1cSvz6l0u9Olb2bC1z0af4g3GZW5Ctv2wr03YebBwHuFwY5iXsQ6iDuqzlN7fcT4ZsMfraCax69Umq3O48jwGn2QKvQMj3WtFxqRjJarBhSq0WpjMw1BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330894; c=relaxed/simple;
	bh=Ua4UH4I4k/JeMFUwY40iLcsmX8BFMt/ki6Da//Nmsic=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GU2MUTUYKTnL3Al2QZKSLsD0fdCCtPsTOFkZSl6t9DnmMFzla599kgFYE453I27tpsLuZlGP8GqlUW+mF/ZI74mAvuQjt5/NEd8tJ8/za5ek9YcY3tlLohpXhoo1E8O6kZ+q30WiSlLCOGvWgWkJdoeG02pjyPpKvDfghnT5fB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so234925939f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712330892; x=1712935692;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42yxhYql2V3Voi1huQg+HWg+/wPkrovGkKGYzhUjPcg=;
        b=Y5uhpWje7tb3htHWYXge7giZwqNmCUEsRxpkuqco45iplVnHoUFIK4fxJ6l22PK3/C
         C/kLneVOdx0rSXnCl2HBjSS7nRI/V+RM7bRzbBYmyzb3g3U8/9ks8gYxThxc8Qbq6vdY
         8qcLgxvgkkYkhw6xpAUC2ci5ufM3IM3mUdMmh6RWl+GZ+Q0BTcDDUCNbeIjEdGr29kXD
         6nrqja0AFNvEE9zQPvQbEwxh3llaEEobSaUfbGScgAEdSY2ZP8KIvJnnHz2d72oHEDSP
         9K34NhfivxPqaYUDzVzzN/+PBDuPg0aXPKJsk1Sw0iw/FHm9/m63MdQGQUCbZZIpgANO
         mY2A==
X-Gm-Message-State: AOJu0YyVnn8o3dmv5IO3Y0gyk+XKTRz1TAazxNKT6ecDw/pd2d+kaCR8
	R/BAy8H/225PQTTPkiaaoMMo9wDxnaoSvd9+KVgcJBDInK98BEBRzO17lOBUlqup+Z7RrbWw0WJ
	GoAHwiRoEncNId9eb4nJLel42u/WJENxDElHZAiHm4zvFxAnEZj+plXEAeg==
X-Google-Smtp-Source: AGHT+IFiVliGLH/CsHssqeRbqQj+tT3bVSC1Mc2+PPB4jxYcGYCdFEHXyhA97uZLAaUfspN2bkW4128na2xZIrx8jlIiZ7nvlt0N
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1501:b0:480:ee35:85fa with SMTP id
 b1-20020a056638150100b00480ee3585famr66397jat.1.1712330892524; Fri, 05 Apr
 2024 08:28:12 -0700 (PDT)
Date: Fri, 05 Apr 2024 08:28:12 -0700
In-Reply-To: <00000000000003b4af060de27f6b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096521906155b1ad2@google.com>
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
 
-		if (!nci_plen(skb->data)) {
+		if (!skb->len || !nci_plen(skb->data)) {
 			kfree_skb(skb);
 			break;
 		}


