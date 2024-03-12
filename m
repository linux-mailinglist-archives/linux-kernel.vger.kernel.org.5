Return-Path: <linux-kernel+bounces-100296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272BF879538
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D6E285B54
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14EC7A154;
	Tue, 12 Mar 2024 13:41:17 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EEB2AE66
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710250877; cv=none; b=qHqCjSICxJYoT92IXPY+scRlozTEikZR2apDFOJntKlhD7NuZvlpB+i/ABerpUtx6z9DnHOChihvL0PIp167WcEB5G4GE255Mz2EL4BbWGVSuUxWcVIIKjKUv86D/VQeGkSGxbxSAK1IUJA6J0XSQ94mBvxesUahQeFEHpjRBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710250877; c=relaxed/simple;
	bh=PjY9Hx4tOJdG4XqfmaFoKDKo7zwgV5FzXjCGKYeM9Is=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WB87vn59NWrZbq5ramDp8JQjCOK3IT8dPp6CXt7+DMwPqknY3jObpN7HO+jbKGPPndoufeucReWqMSlnvLhB5FIIqJZiQLacTrMz1Qmxdr9n8FG2xiIbXZ/plSCm0sULKxkL2kE3aNd92u5htZw1LUjl1AnM6S03LhdvMZZXpA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3665283d42cso24406915ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 06:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710250875; x=1710855675;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0AA3R38g+NMxfqYoN/vqX14LWr3c0ZeG2Q50m10+nM=;
        b=bbGNC7HzWxi/E9vq1gzgP4VsuSHHsx3SMlhXfrU/E3rywuA0UzOZwdWKW9Q2VLXvfR
         HJaroeIuXzajlK9NqHrjb37+fN5oUa1EjUr4KTKU/biS6pUU1naIIEyvG/+WYCVZowlX
         Zb2vdSo1jtOGOBlsoEXXAlqL2zeCeK5ak0PETlTiTg77pNk2NHracvmcK+NdopxsOKRo
         TzCkQL2ShLmZoj0U395hjFGksNrl/g82vEJgUlmSc1bF2bpxkjXQKZ1B3e8RQOvLOCs4
         cZtJs1ssB2X64TaraJ95/F+nBKEiSNZQ3gP5IwC06xg6U/pnyKlsAMM2BEef7aBTuJpP
         RVoA==
X-Gm-Message-State: AOJu0Ywd6MzWw2KkK5LHcjiQpAmQspGUdVgIP3J/LbJr7Wxxoe0K/uGl
	6tXXvxeUhE6xxEGAorUifJ7Q58/vpunl8yP6DIcXR1vkpFZ33TynUbLveG/6vno6Rzr9AictSLE
	CBWWdaQE1JQzuLcOO6uQVBg36rvQdxjb9JhaV7tHdub1v8Y9nF+KuZdMXCw==
X-Google-Smtp-Source: AGHT+IFsIUqg0/SLj0rWp59RR86LchZSPN/cneAudsbtNkUgubOuZvJ8R30cUXy3lWz6wFNUpQAp1VzQRsMkqNMut2W2DmxvfauX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ec:b0:365:3db4:16eb with SMTP id
 q12-20020a056e0220ec00b003653db416ebmr14652ilv.3.1710250875148; Tue, 12 Mar
 2024 06:41:15 -0700 (PDT)
Date: Tue, 12 Mar 2024 06:41:15 -0700
In-Reply-To: <000000000000169132060fc66db3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3ef32061376cfac@google.com>
Subject: Re: [syzbot] [PATCH] nfc: nci: Fix uninit-value in nci_dev_up
From: syzbot <syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] nfc: nci: Fix uninit-value in nci_dev_up
Author: ryasuoka@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index 994a0a1efb58..56624387e253 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -765,6 +765,9 @@ void nci_ntf_packet(struct nci_dev *ndev, struct sk_buff *skb)
 		 nci_opcode_oid(ntf_opcode),
 		 nci_plen(skb->data));
 
+	if (!nci_plen(skb->data))
+		goto end;
+
 	/* strip the nci control header */
 	skb_pull(skb, NCI_CTRL_HDR_SIZE);


