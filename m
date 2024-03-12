Return-Path: <linux-kernel+bounces-100369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AF7879663
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A5B1C21B00
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFBC7D093;
	Tue, 12 Mar 2024 14:31:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FFE7B3D6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253864; cv=none; b=ghQtQ9wdbVyj4nd3J/lWce65QpwKJ38v0hyY9hDVc4r/TuIKnCShsTX5lg1Y9P2xZBHnfmhasAXL2AvWR2j/06vFNUgkVDX9dZ3EKlT6kNomaZIEtlpByn2CgwHevBaeKCngjB91+DZ4woKOz9YK5k5+1PPxeeg2mMnjddGSIyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253864; c=relaxed/simple;
	bh=WtRSxlno62YXFC5X1E2BoLzYO2qk7CN9sYE1CDg3p/4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W5cepXsn/IJTWGI8QJ5NSmRtgm3Mj6cW6r2shtx5vA7yNNR83y4a7aFrpvnH8yyfN1SGVp29M4C4dHp0ZRvJ/ZBymC6oLjeAjWfnnQ0RBTaYuHAWOWwu7MoAm5zCnkZT0gi5YCQI+kM7nSzLnC5Y6vn9GyDHYcyiimjFypR1JC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c8a7d77806so247408439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710253862; x=1710858662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4htx1YibgBfsHQqkJFPItrgdmh949wL9fFVlvt+n60=;
        b=Q9t1oGX9mmISRre4qNpiAS2jb2/sPMkqWwwSrq93TaliEXXxU1NwfjSKAmoEVBhXiy
         MQo6AGbzNAg6/1llT+vN+nWLYkd0jg+BHfhHsXX9O8dJ4u02rK18WNP75xAwKhRFW5gH
         6O5BpDQ2/AgbMGlVUx5+DsYwejyyVf1giapxvkV+kYcHEXSmFZw1j/YTbIGEpUlSHZR6
         EPk/jc/rq2hAQ9scmkazkdZRna0BV9GjFRGCX5htfZbKbwuX72sLmyDUqkK6/Boq8mLV
         eg6c9264IYXCocdzM+6FxBGRfRkteoKUA7z8panvS2ga6UMbLN1h4DU8i4oe8gAVwjgt
         Dlzg==
X-Gm-Message-State: AOJu0Yw7AJxTt+oTndH0MmbMjnf6RAdP1JWYRoybYW/PHugAc4gyUkwr
	0pvOpZCGLbKRTOG2lv1/BZjV2h/G0Cb5AlvSnd8o0jGMUYTE08QA327z+r9UTc0RG4Olg+3Ts87
	Bg7o12/LcIRMD0F7WB46hl1EQuKM+bRnK7i3POI/6SnI/DOPyk+KuOn1STw==
X-Google-Smtp-Source: AGHT+IH2BuBGWV0LZqyw76z92U0FsQenFiBpRGxj4cDQs1tD/cyxVRI5hBHgsL+T2crcuWcbueYciffm6x64dLxnDZFoSUaSzNUZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218d:b0:363:d7d2:1ddd with SMTP id
 j13-20020a056e02218d00b00363d7d21dddmr217175ila.0.1710253862301; Tue, 12 Mar
 2024 07:31:02 -0700 (PDT)
Date: Tue, 12 Mar 2024 07:31:02 -0700
In-Reply-To: <000000000000169132060fc66db3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0437206137781f0@google.com>
Subject: Re: [syzbot] [PATCH net] nfc: nci: Fix uninit-value in nci_dev_up
From: syzbot <syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH net] nfc: nci: Fix uninit-value in nci_dev_up
Author: ryasuoka@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

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


