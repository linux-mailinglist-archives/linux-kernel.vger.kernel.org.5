Return-Path: <linux-kernel+bounces-108288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A438808C9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFBC71F230DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E6D138C;
	Wed, 20 Mar 2024 00:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhNR9jib"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BBE17557
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710896088; cv=none; b=nk1oUkS59soHtdcwnMZ3MPi1aPHfy/yLVi+oEdVHsIJ0Gbbgi32PYHgWT4IrWUIWeZTCCGY14SilGKiizjKdvuoY0BUshBrP7HgHfaLR5UHUhxGyH5xUtbUW2pExda4hnhUwDtDrQN7TCUMNvT6cCaTSUWEhdQ/4ockW1hFFg+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710896088; c=relaxed/simple;
	bh=hI29TnLqevS7PcWbHvWEJ+jNKTHTeHWrGoYRTW4jkKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JsoWQ7SVq7JCtzV7T2JkZC2Dv86UZ9+7VmnVC9oXFsHreBOh+Xs8bBZiVe9pDQmy784C4CCnzOnBxslHybL3ynMIPW+/um/vsoQ0Ox+pCHzqyekBp8tdM6OZJq0Kr1eJIwhAmMcHaC3Wjd/uL/3oqmsO9cvZ1zp+2+pr8jHkdVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NhNR9jib; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710896085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DDfWr7ytquRAp7SJnhj8Ai1ZuxYoyisaFQVN3t6MjXU=;
	b=NhNR9jibx0zfKnloMMwpbQgPywYdoBmqHuFH0qDEN6YNjRLerEhCtg7e3NlByH1VLZp+0m
	0goyTUoH3/k2McPFiAN/yxPdJU7Xb4LdsI9kwIBuEG2t4TpgjAMFMgtx0AaZG6cv9zpcra
	Ij/2EFaQQnhIYk+3qxDZkqhI/xqO6DY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568--R8P_UcKMJqMsGhIU8YBhA-1; Tue, 19 Mar 2024 20:54:42 -0400
X-MC-Unique: -R8P_UcKMJqMsGhIU8YBhA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5d8dbe37d56so4198616a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710896081; x=1711500881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDfWr7ytquRAp7SJnhj8Ai1ZuxYoyisaFQVN3t6MjXU=;
        b=iSpCFdAI+pTm7esZ2d3I5d0ktdeIA4gLuW24JRcbj0BMWW5Xfisil0f9y3kLvcP56R
         odrfPy8y26ASnphbQmvKUtRjYe3pLPfvayA95BBxUhazP/EXRtyRpfqA3pvPcc3kcpWN
         ihdHlXDIVp4MdZxuYdg56RhevM0RM8/vnQOrbPBMauyGgSKlqcnWCK7pDOxm0OqfbTtn
         2Tp8T3UIScGNKnt2vX2siZ+/Q+4Th+Kiy1dvziGuxB+6/KdbrTFe0xD81FIDSBNBv9uB
         dVaUNc0rNnPJM42hLU+kBAQ1Xo9v54Z+y4YZ46Casq7sCCFtI9B1qAQ7MnmlFOudMW0q
         ufBw==
X-Forwarded-Encrypted: i=1; AJvYcCU65yNtp6EBuSMS2qNVXBV6xnKeUktoSDvN1p1oSwXje7d4HQYR4gUj+qDmobPWaa016DGvj6oqHQPE+kNMaDDjVheydCkE5J2NJavp
X-Gm-Message-State: AOJu0Yy7pSJAIv5mSpBFWAxowqUAXO1w/0lfMntcxXGjJdCmzxwh/e/w
	e713pg9u1qGJpCpRjnC3fW+aNrRZ9xNuOTo8EPEV2+VpwRNoifaRSLHLMFx4l43xSjjXmJoaoWB
	Z0/um4HwT5F6r53absXjv70W3RRd8fys+7tLqyKshxVGfzAj5B6SOwbZQ8jxg8A==
X-Received: by 2002:a05:6a20:5483:b0:1a3:6c9e:1e31 with SMTP id i3-20020a056a20548300b001a36c9e1e31mr5610408pzk.19.1710896081314;
        Tue, 19 Mar 2024 17:54:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENYtPVh7vmsDL0GAanLVrtGFe3eu5YV+lT2aK37wfmruHK0XxNxDJKFalOxxceGwZn/KY84g==
X-Received: by 2002:a05:6a20:5483:b0:1a3:6c9e:1e31 with SMTP id i3-20020a056a20548300b001a36c9e1e31mr5610397pzk.19.1710896080974;
        Tue, 19 Mar 2024 17:54:40 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902d34400b001dd63a468c7sm12124793plk.292.2024.03.19.17.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 17:54:40 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: krzysztof.kozlowski@linaro.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jeremy@jcline.org
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syoshida@redhat.com,
	syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com,
	syzbot+29b5ca705d2e0f4a44d2@syzkaller.appspotmail.com
Subject: [PATCH net v2] nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet
Date: Wed, 20 Mar 2024 09:54:10 +0900
Message-ID: <20240320005412.905060-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported the following uninit-value access issue [1][2]:

nci_rx_work() parses and processes received packet. When the payload
length is zero, each message type handler reads uninitialized payload
and KMSAN detects this issue. The receipt of a packet with a zero-size
payload is considered unexpected, and therefore, such packets should be
silently discarded.

This patch resolved this issue by checking payload size before calling
each message type handler codes.

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Reported-and-tested-by: syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com
Reported-and-tested-by: syzbot+29b5ca705d2e0f4a44d2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7ea9413ea6749baf5574 [1]
Closes: https://syzkaller.appspot.com/bug?extid=29b5ca705d2e0f4a44d2 [2]
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---

v2
- Fix typo in commit message
- Remove Call Trace from commit message that syzbot reported. Make it
  shorter than the previous version.
- Check the payload length in earlier code path. And it can address
  another reported syzbot bug too. [2]

v1
https://lore.kernel.org/all/20240312145658.417288-1-ryasuoka@redhat.com/


 net/nfc/nci/core.c | 5 +++++
 1 file changed, 5 insertions(+)

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
-- 
2.44.0


