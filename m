Return-Path: <linux-kernel+bounces-2133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B7681583E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 08:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80D41C23970
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 07:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519F31947D;
	Sat, 16 Dec 2023 07:29:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B53C19447
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b71f42e504so149744739f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 23:29:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702711793; x=1703316593;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MQhlVgrcS1v19B4b9u6ecaBp6ov42u09g+AcNu+df0=;
        b=CNpdT+OpZQuTDxeNYeFP/ehDDLdiXggbVZJouBp/EeEenp6mei4cuUUlbkV0Rj4bZY
         +8GTKSsMtgvzhqNYJL5ruCYuL9NRGtnrJmBWNE0evakc3gUDMNp28JCQcJDL1bSMk0Kw
         vO0+MlaTNAtO9aawZ4z2GsVvlJPJsMZokDO3tm69K1WLHLI0CIgfChmWOgV/pugrOFyv
         U2tdcuYh4y+Ss3BzWxDVs2KKGi2NUfP0kjXYmFt+/kdJ3N3668gmriVfz5mepIXXY67P
         SNBgKU5vch0EG76OaSKLB4Sf3SZDBJ+VAvVR/i8HpZDyMBafRRQkPyiF50KbXJ8xBk/U
         Thig==
X-Gm-Message-State: AOJu0YycjKW78NDMRk2l1iEwquw2gHE8iOHB94r3vMAMzk57p3d6Iiss
	f31Uxw17B3bzl99Uyn/HYqOOTONue18+OJTYP5Pa2TQYKg7Ub28=
X-Google-Smtp-Source: AGHT+IG7RXrHBWgbl+jpUPIDYa9SQhg6UqUYEsCCCW+7HkfQSIsI+QGQVCnE0YA/+oLgGJHLZWI6xnOBgRI+qU7SXnVbNKIAdDvr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a3:b0:466:4f40:431f with SMTP id
 w35-20020a05663837a300b004664f40431fmr505772jal.1.1702711793835; Fri, 15 Dec
 2023 23:29:53 -0800 (PST)
Date: Fri, 15 Dec 2023 23:29:53 -0800
In-Reply-To: <0000000000006c14cd060c99ac12@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a063d8060c9b7b1d@google.com>
Subject: Re: [syzbot] [block?] general protection fault in bio_first_folio
From: syzbot <syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [block?] general protection fault in bio_first_folio
Author: eadavis@qq.com

please test general protection fault in bio_first_folio

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git abb240f7a2bd

diff --git a/block/blk-map.c b/block/blk-map.c
index 8584babf3ea0..6c6f0ef1407b 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -344,7 +344,8 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 	return 0;
 
  out_unmap:
-	bio_release_pages(bio, false);
+	if (bio->bi_vcnt)
+		bio_release_pages(bio, false);
 	blk_mq_map_bio_put(bio);
 	return ret;
 }


