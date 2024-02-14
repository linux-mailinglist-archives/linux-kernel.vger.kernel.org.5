Return-Path: <linux-kernel+bounces-65447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F13854D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 013CCB2192D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887625EE78;
	Wed, 14 Feb 2024 15:45:00 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62945DF1A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925500; cv=none; b=OoN2e7+7iNa/5j2LCDeZGxvI6cpMPo5dGgv7X9CQnUnUwzyWXI9+3dTKrXuhIwr8JLu9hhaYB9fnLNUEZnAIsh2iRIqTQflrL9Sym/5KYetoPLH6mb0Bf6/EgiI+Xy+vuFCi81AhRpE2xHxPqVl0RidyF3ij5EaTSWDzaFz9S9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925500; c=relaxed/simple;
	bh=vHkfigtEZavspuOcCNskDMPyHZpvQCjJCBHTOfW+AZc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IOK7JZBP+kQl2wZ47z8RBohgZ3ud+HNi9gAYlzTPW4KXlv4r+Lk/XUXKuS3z2fZ75ooWZqjCFka1qRaCUPuBpWo9qdbeQx/l0fgrvw7hhkA3+gSxY/MaF+OROqPrGIZE188fAEMHa7jWDZrMh5deoXl9vMex73wkffJmduSIDDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363da08fc19so50848665ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 07:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707925498; x=1708530298;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEI0SxmdYZ2iPlDp6P5GYelkJ+oJQochxbvuWq4qiQU=;
        b=oHLTiZNgy8/qkds7X0+tkDdS92nkATBjh9IwQWI8pI0dU6ClPpu6DzMr2Zr09PobN9
         CeL0pfmM4qEEr3ZEWexVGg7W6NOEODr79oZ517hvPPBLJIaE1NyCoxQpQnUfAHng91nv
         qFYndDmtW6q1G/rYVrOiuOsiN3dQ2+PJf5alBfaLBocK4lQgASORNEEbnooQzr30BzRf
         iPpWvP3jQXT3bEeHHkMWg621yyetV1q9rD3WreWwKEvjA7v6CxS/XiEelkrm4y3Dx5Mh
         q6EWKiTGH7vtU3nYVRmVRC5EE8BL0PUH65AQEyWyX+V+KjF41XQblsnHhrBydBdW3wyj
         72OA==
X-Gm-Message-State: AOJu0YyNdYPJMHLU5yzDAxDYKV3QxnL1fZUFHsYo3aVO+LUiZA/HdSgU
	OI1ppD9a9PDli+NzoJniilvOgcZBc9t+PZI/FPsydsQPU1jfzm076Pw/Qlli9u/Aq8AXyhdbObV
	QBGipQEkOaNV/iVWw4s7oCRoY7p9f502ODd64iomJIBWyTY6V9hB8UsZiSA==
X-Google-Smtp-Source: AGHT+IGxlMYWdNQAarObVV1SZ502fpC6TiroOxysYsET5kRszuYBv/VUVYXf2UPdHx3fbYy95aADoqB8AR5nvNghvdmEy8BSLOQa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cd:b0:363:ca65:7d12 with SMTP id
 13-20020a056e0216cd00b00363ca657d12mr225444ilx.6.1707925497874; Wed, 14 Feb
 2024 07:44:57 -0800 (PST)
Date: Wed, 14 Feb 2024 07:44:57 -0800
In-Reply-To: <000000000000b8f8610609479fa3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a97cf06115964d8@google.com>
Subject: Re: [syzbot] Test for fd7b34375c1c8ce29c93
From: syzbot <syzbot+fd7b34375c1c8ce29c93@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Test for fd7b34375c1c8ce29c93
Author: syoshida@redhat.com

#syz test

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 93ecfceac1bc..4d75ef9d24bf 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1226,8 +1226,11 @@ static void sk_psock_verdict_data_ready(struct sock *sk)
 
 		rcu_read_lock();
 		psock = sk_psock(sk);
-		if (psock)
-			psock->saved_data_ready(sk);
+		if (psock) {
+			read_lock_bh(&sk->sk_callback_lock);
+			sk_psock_data_ready(sk, psock);
+			read_unlock_bh(&sk->sk_callback_lock);
+		}
 		rcu_read_unlock();
 	}
 }


