Return-Path: <linux-kernel+bounces-72222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A4B85B0ED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3CB9B20A50
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DD82E400;
	Tue, 20 Feb 2024 02:42:48 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B024C200C8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708396968; cv=none; b=fPfXQDZtxw4iJYBwsykGDs+MlSKMBbVc9k5U4XATU1+ep/lZrPQIS4uXYJrVdz9qHPoohhmgI8nDQKBBulkrgnPal0dS4+OZAWNHT85MlKFraQ4vQkyxybL8HpzBDN2/40hUPLzNHxa3ThTruSSW552FBUS7aMKXGRmC+gSgQCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708396968; c=relaxed/simple;
	bh=bPGL4DR5/T5nV7Ygj70klp3+0HEcUZ6mjR/W9tmknR0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RgC2CSj3BLji49zRPES9UaRQsIu+0e26UstTHdl2DTu0UYRUKaQazCW8SScBDri7kgkHr6YIQFAwOnBLmtpMspL2NrO29Y71iO1xsN8Ubds1peFoc6HIeBB1A7ZNX9SdC7GIP6eUP+PTnXEkDpjBpjX6tvPlEfaaCd6smRtdN9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3651fd50053so24875135ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 18:42:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708396966; x=1709001766;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqKNwUgQARd0uzFreu8cK9Jo9mTd8aPg8U4OsgzcT1A=;
        b=s3QBFe+5tj9KuwXakzxfE2DpxbR3aI3BrHV1HGCpgt14PQGGFmhY6S0QGa5jHgCRHE
         LXB8jeXJXEN0c5d61XLSYCFVEdoSiFj+39R8gCyWU0Ef4N7HNhuXHpFv1rs1yjMYLSzP
         f4ZM0r8TJPDIsmgp7iBs6URRsdTFsR6v69f5wNyhwY29/ZCHwx5S6VtDjyeyfQN0UfsG
         QibAOtG3ue7t+5txnqNOpUVHDh/36XDYDIkVeuNm3AUivb+C5zbURD7RajNC/r9u9UK/
         Sn4Dv/957hs8q/pf4ygocqZI5k3EmSI2HNUmxvsAobfIj44mC/V9VK9THRkCw+mMonob
         VJlQ==
X-Gm-Message-State: AOJu0Yy+gsWrr4zrnQDFstQbPZU4OqHiCnDJRIZfT7URCr3cVItxDQhE
	6QS6KP/WXKRpfASCT9+vtaykaJ0SphvVEDsN2nRSfvb8f5yBRaSqprawRqalE7/hNLhdXEEYEi/
	zQ2dcaoTXQCi5/d1q0Gs6r5osAZUjA1xsSLGmdzoJfaBgRCZZUy7zzvQgXg==
X-Google-Smtp-Source: AGHT+IGICC1BIXQWJWrKsbpNLEsu88TMyV5aehs5xeMuc5kvGoYcIAgtMNWukmen5rVI05TU8pcmmHjwVNXTQxjWdgMBHWi7MBGQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4f:b0:365:2f19:e597 with SMTP id
 u15-20020a056e021a4f00b003652f19e597mr485349ilv.5.1708396965906; Mon, 19 Feb
 2024 18:42:45 -0800 (PST)
Date: Mon, 19 Feb 2024 18:42:45 -0800
In-Reply-To: <0000000000002cf4690610660f71@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000049cf240611c72a13@google.com>
Subject: Re: [syzbot] [PATCH net] netlink: Fix kernel-infoleak in __skb_datagram_iter()
From: syzbot <syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH net] netlink: Fix kernel-infoleak in __skb_datagram_iter()
Author: ryasuoka@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5bd7ef53ffe5

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


