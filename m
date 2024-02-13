Return-Path: <linux-kernel+bounces-63653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 418FB8532D0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49938B221B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6195786B;
	Tue, 13 Feb 2024 14:17:13 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7856257336
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833833; cv=none; b=JWob8b3nbnKEMTIOJJj5XuVASY4uZD1jMRCsori293EstUrnZ59N5Ukx7oEYJje2nsDIaUqJyGrud91TT37IlcwMgJ9xA6pXBFklvCHML0BJsA37e8idFbBLk6IIJpX+MXU6ctS0RkeoPxTcqze8CWvn8yyats+FjDhwyVAw3X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833833; c=relaxed/simple;
	bh=OlADzKaQFHNc+OnrntUozCVgaotzI8NWL1elB9zCvnI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cBXgGyAoNGoZnBDLu8IWSJw1nx6Z6SkOf1G4wCg79gcamn5TUGUlQsCHFqx4MO8BuXtaWSsUlRapQhYlYfeGGMBLmtG5H95bQK6YKQOrpLWwZaTgIkdW+Q3Hc62HYSNzJtrUgnDw0bP8liej5w9Ead32hKtrRWF1vUy54pNZWBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c0257e507cso385141939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707833830; x=1708438630;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tuo3Vrb1R/xT0UHpdtrhRI2sNBd1K2/E55A2CShS3ow=;
        b=ehQBCDbeWepApTJxFAHcxKDkiDAXStOaRInlZzENyte/QDZwLtnfXBZYVR0N10WIIz
         GnLHSmTd74CBg65UOmjpS8zi+da5TAIl3aqckhu6Z76jX8CyvMzV2qcnN9GW+Fur5P+Q
         hXzh68HyYrDGRMi7GLYRiU6VBUeDBNG9G8m4emQrQD66mkGscpJsbOM5Zh8KxNBa4kwR
         0g0+ILOnsow4l0cDQhJRrv5D4qTIt6RoMJBkTE4n53QSKi5+yUJFuPV+uJedf16I9Z9J
         6PwvqOKl5GQJ/JAPex02EsEyIoO0LNHWH6+WuDnZaZRnVqBzlCfY8P6sbGY/9woHtFc3
         quwQ==
X-Gm-Message-State: AOJu0YydSoid5ST5QExfP8WX3uYAomr7wRLqeK4qqG9KvyfXYDLvhgK3
	BRTFjhxGSXw34h+syDe2BtI0ewF00G41udK6ImutGOlwpoatoR/v2te/yKcKi6Fd5xSFmeys2vL
	6k/bBGQCHKZZ/i1lkzrlT7cpVhhTBgGur4edfAEmSM+pyBKNuaZFuXlp7FQ==
X-Google-Smtp-Source: AGHT+IE5XvLb1VtsflxRDJyldXBqsWaU3zguIiKlrPfnSsxDIUQsOvIH0tbLtzZZYq/scjWltN4L4ubGeequFwU/P3g/J/QFdoaW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4903:b0:471:42c7:d0d3 with SMTP id
 cx3-20020a056638490300b0047142c7d0d3mr134403jab.6.1707833830745; Tue, 13 Feb
 2024 06:17:10 -0800 (PST)
Date: Tue, 13 Feb 2024 06:17:10 -0800
In-Reply-To: <000000000000708723060df6ab96@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d130e10611440ccb@google.com>
Subject: Re: [syzbot] [syzbot] [wpan?] KMSAN: uninit-value in
 ieee802154_hdr_push (2)
From: syzbot <syzbot+60a66d44892b66b56545@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [wpan?] KMSAN: uninit-value in ieee802154_hdr_push (2)
Author: n.zhandarovich@fintech.ru

If cb->secen_override == 0 but cb->secen == 1
mac802154_set_header_security() will not finish with error yet some
values in sec header will remain uninited. Fix the issue by only
checking cb->secen.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
---
 net/mac802154/iface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index c0e2da5072be..ad799d349625 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -328,7 +328,7 @@ static int mac802154_set_header_security(struct ieee802154_sub_if_data *sdata,
 
 	mac802154_llsec_get_params(&sdata->sec, &params);
 
-	if (!params.enabled && cb->secen_override && cb->secen)
+	if (!params.enabled && cb->secen)
 		return -EINVAL;
 	if (!params.enabled ||
 	    (cb->secen_override && !cb->secen) ||

