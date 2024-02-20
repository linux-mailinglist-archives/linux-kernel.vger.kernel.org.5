Return-Path: <linux-kernel+bounces-72971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9101E85BB4B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0251F2377E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9918C67E74;
	Tue, 20 Feb 2024 12:00:42 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C053D67C4A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430442; cv=none; b=PfTn1S8l01AOSzGqK4sYv/0tDfqmy4Loo53zo4wRzF495RWp8vpVLe8IWNY2Agn1cUZrrlUs3CU33lAagHfWx5SktY75rpeRJAoOkb7Z5VP63fQc49WCaXlZ9mIc38+KWrMS1coE/cEZC8+U1yubLhxZo/k97qp9Uif2W+Xg2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430442; c=relaxed/simple;
	bh=57atmjnT3zY+ix2E9a1R6TZ4Gq7SHSA9gEfN7Dycg+I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mVEkv2Twn74g7ryN673lXALvDDo4HbZvmenpyINcC0065Ua1Pas0vMrvgFQwD62mXaDV302PKRC9GxRC3WE2kVhe1CM+XyafJlADuZYU6pWRYqGC2MN0sVg3bZ6IWPtPd/1gsLET/18pl9ncklZrY7tL5mVqH3Fyb64cC0XVwgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36512fcf643so29329355ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:00:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708430440; x=1709035240;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHTqvrBQLRZu2h8dv+dbNHkkGj/MJnDanZcc3PLe1mk=;
        b=dIUlXGI6VtTH3vUB1A4GnktIOvjP4qeIph15q+OZiwrdQv9aTwxvPvG5JcQZqKHC6G
         2ymGzcHttOemoPAIMAqnENZHM+WHRQGXRk4NIffw0+ZpcuRqbIFKJX19RmZHvE8ocr2L
         x+9hBpn6Be2jIFR0MFY98obE4wIfd0D8AfiJOG0CU+wncBY8qhuXgZbSCDci6woe/5UK
         k7vslujuNyLu6bnLe7BuCYb7rpqAtgz+NFXh33dX0wmNzIJ4cpfHlYSGpLDy/WmpaWSk
         IVIyo+JSUBpGdwyV9g914+24wlop3TwDMsfrjsf16ug6ETcn+qJpgn+2JAZM7WgPfIpe
         MdQQ==
X-Gm-Message-State: AOJu0YwSHSuxZCHSers1QagS+VCy/ZWDg3JMvr/XP00NeoMyF1vgkgpD
	9yQCaBf+WCg3lNAwlPAIXvUH0MTCrRm2WIPJU5BM6zUyin9B7H0VvxRPhuCvwhOXpY5v7kc1A68
	Tt1YrxjEeVWV/XJzOqF4JC3P2Qw4q/kSqZWF+9lYsY1t54h60HYOm9bOWZg==
X-Google-Smtp-Source: AGHT+IF/sAAmJUP68OLjrCzU/AjT/wU8FhRBnwBxXUA2pYnJfpRLAmVyK+8AuM0m6hSz/+/B1Z26AP23JeIBor+Tk4X7HrWdw4TB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154f:b0:363:9d58:8052 with SMTP id
 j15-20020a056e02154f00b003639d588052mr1194452ilu.2.1708430439929; Tue, 20 Feb
 2024 04:00:39 -0800 (PST)
Date: Tue, 20 Feb 2024 04:00:39 -0800
In-Reply-To: <0000000000002cf4690610660f71@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007edeaa0611cef5cc@google.com>
Subject: Re: [syzbot] [PATCH net] netlink: Fix kernel-infoleak in __skb_datagram_iter()
From: syzbot <syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH net] netlink: Fix kernel-infoleak in __skb_datagram_iter()
Author: ryasuoka@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index eb086b06d60d..8277399d19b3 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -167,7 +167,7 @@ static inline u32 netlink_group_mask(u32 group)
 static struct sk_buff *netlink_to_full_skb(const struct sk_buff *skb,
                                           gfp_t gfp_mask)
 {
-       unsigned int len = skb_end_offset(skb);
+       unsigned int len = skb->len;
        struct sk_buff *new;

        new = alloc_skb(len, gfp_mask);


