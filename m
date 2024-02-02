Return-Path: <linux-kernel+bounces-49115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499DC846601
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4D31C252E5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11C4E579;
	Fri,  2 Feb 2024 02:49:57 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9665E549
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 02:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706842197; cv=none; b=ghO2SIG0+vI6BtUubyoHwCTejowc2HisCwdZpRzCmvNEtzvz8Tt5OPm7xdbadHYaSNaN0YKj7aATSgF8xjWCrLEqnBiCdj3zuZ0YwU1sJY+wpuAaiWAcyBjKx/AuqD2XJoTdO1Sd+X9dp9IZLIdVr7J1rNaIM40pmJe1pI4yKXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706842197; c=relaxed/simple;
	bh=AUq8Eft6ouqlHqhRqruK5DielG0f+n1wA7wpY1QKcs4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MhSYOncUSMSEZjHutSyUVkEtosFx/T9tV1c6xeyaZu3bozp2S6MxFIVz0bPPq/Plpqtl7GfnxVASMj5uqyd7F2DmL+AG3/sGS2i1wW1g684wlkAk3jSHiR44U/ALsSd5OJxamtOhVFHH+sWwWWKhdTTN5w2XpwC6/nb3m1z0tKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363922a1774so13778325ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 18:49:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706842195; x=1707446995;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRZPofN4bcD8oGnDE7lDYHifNn4X+IS4OvVaqHEDSMs=;
        b=OSFMwhj8X4vW533Vd6+63S5ZEC5aw+tnRMhElfrCOqrzQRMRkdL1lApEEDTTZjvz5q
         hJPVg8sztGcLjPLeeY9Kf0+4u6YGYLz+6l17bDu1vLhtrrJk9IXwXQksfOxUbvtfTMUu
         dkK0UMnOfbNIBxxxGMzI2Cjb+QdjLErjmpLAccYcD8YA5byPhRSQVKOByDQCUWpP9cw2
         IkzGSkKhmCrmuc82Vmhsny58uT8X3oCJjy/ei5UaEif+BC03POT7dcZ9wTjyZLZPtMNM
         704U9VnVf9fdzUrmA4nEpfqLC1TFE/IQJu/1XOjgmohksOdG5SZOjhpX7vw2j28fK2WW
         rDAQ==
X-Gm-Message-State: AOJu0Yz26w3/JhwjmVygYKh3J3HjI2GnMdYKtCR4gHjVVNgkSmCgM1F4
	RMB80m48hent+BPbKYUF2Q8vEyayq4QOX2xplkiB1GwRDkSyivr+dfgrT2MsmAYMJaUlOWkgSJV
	oQqkwpzPqhAvzM69JdJJUyGkHmQWoZ8BRKO34Hq/mQ1+d0+9hnlV8v52AkA==
X-Google-Smtp-Source: AGHT+IFyUh1pXkuz4IkU3iXsVa0hMgNTRK+qpg9N5UlDUC78ZSwgBhsXan0iM3i9/CURXqTp0IdpjKQmbZXJzv+z5wGyTnNQ76+r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e02:b0:361:a33f:36a4 with SMTP id
 g2-20020a056e021e0200b00361a33f36a4mr354105ila.2.1706842194925; Thu, 01 Feb
 2024 18:49:54 -0800 (PST)
Date: Thu, 01 Feb 2024 18:49:54 -0800
In-Reply-To: <00000000000012d4ed0610537e34@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7606506105d2a70@google.com>
Subject: Re: [syzbot] Re: [syzbot] [ntfs3?] KASAN: slab-out-of-bounds Read in mi_enum_attr
From: syzbot <syzbot+a426cde6dee8c2884b0b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [ntfs3?] KASAN: slab-out-of-bounds Read in mi_enum_attr
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 53629b1f65e9..a435df98c2b1 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -243,14 +243,14 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		off += asize;
 	}
 
-	asize = le32_to_cpu(attr->size);
-
 	/* Can we use the first field (attr->type). */
 	if (off + 8 > used) {
 		static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
 		return NULL;
 	}
 
+	asize = le32_to_cpu(attr->size);
+
 	if (attr->type == ATTR_END) {
 		/* End of enumeration. */
 		return NULL;

