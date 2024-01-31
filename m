Return-Path: <linux-kernel+bounces-46703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41A68442F0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86221C20894
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEDD84A5C;
	Wed, 31 Jan 2024 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="it3uq7he"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB22379DA6
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714602; cv=none; b=KJ4Arevs/cD5kx5u6b7gEf603D21HiNAyubE6xxfJsH2XWMio5RP5tpRp2wecfO6rHFCF80r+7O4b7YKHX0UEBGMeRHKMZqyIT1whTr0Tltz5cMhd09SpC+JnPhjfVwrgnR5xR2hrrvhQ3ET2pgYKPzPnkIgnR5lKfe/0pSWz0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714602; c=relaxed/simple;
	bh=H1nccFNfdn42C2r0zvD84VGqHMzr9HcNHYAhnkNRzNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QNF3cPjGNDmBofua7de8oTG9dG8qXyTiWJLQSfCyDi6KIlghrq91lGYFRcyDRWsNrdJL+ascXDP7XvLRfQvQ9vkVUpfmAf2cZwnnCHIfV+RovWB1Mk+0E0Z8Mm3lQNXubv+k1PyzEfmnykaOdehX9+nLRyoVW71AX3UVvlDjqtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=it3uq7he; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706714599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=29Eq0yPO86qsr/P0Ue4qqB+L9VNDTQrnB7xU1LyYquc=;
	b=it3uq7heDZsdbh7/axHK14JqYT0xJZMCu0rYEhIDEHemt7ajdSNRwEUrIm9YJsvKbxOtHw
	O9H3i88uncxcgQRkP3rqWZLwypbsPAUPQ0SX/piO5U85vMAqJ0fYjUPDrgYpzzLmKnItPS
	SNeNQ6/dGDa9ECvr1meHZh+HkU7rJBU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-0x6j2cdWOxWuw5HQa1DrIg-1; Wed, 31 Jan 2024 10:23:18 -0500
X-MC-Unique: 0x6j2cdWOxWuw5HQa1DrIg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-295d4a5bf59so977747a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706714597; x=1707319397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=29Eq0yPO86qsr/P0Ue4qqB+L9VNDTQrnB7xU1LyYquc=;
        b=ml3RGDF675VTTwfRcn2nVUef0qygF0xoN4wf7fvbqLfxAiahYUu54YhVm3FjsjlyUa
         oEsD2a76J/RLE9kg3v7w6wDGzS5slaI3AUAUZ+A+ggBrgZzoAUE+zQ/Bua8v/sTU2asc
         VCjpheB09mv2xoRe7x0Ak79IvjFrljIptSyao+N4M2DlWuw+nVMu3tY4kPRkf9tMbplU
         iD4vYrMGzVGQPKe79O18vMaswv7mBRCc5UUtbJzNErhYa/8iA2mtGdmASqDyQfWMsFZf
         p7bWD/qWt3NPXfO9/KJGOI8hl//YuXiYRrBEeSoGQIoK7T6eabXwwc8uj0lM99SnXoS9
         zBBQ==
X-Gm-Message-State: AOJu0YzJrkduHhxYuk5ExGh3u10xpaqo4UXG2t22V2CV5nTHKoO8TDD6
	r1WibhsjPdmbgcWG21ddHPfoPX0U6ANYGRVQC56AqhnX1YjFK7lhJTjZPzZWLtwpspgB3FQC2MY
	ujhYhZUBOTMLvoFLps9pAuM1iVArDFsXTprq8rM7t6bCsO+xGqGBNMVu6oEBq3g==
X-Received: by 2002:a17:90b:60a:b0:295:5273:e0d7 with SMTP id gb10-20020a17090b060a00b002955273e0d7mr2092991pjb.17.1706714596868;
        Wed, 31 Jan 2024 07:23:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1d14mOp2dYcIcv2NIy+pZfb6uuRqZRmRGKRU4Pj7ZVKdnmwIJ4nQJLDdK1uvdMvDZFKtorw==
X-Received: by 2002:a17:90b:60a:b0:295:5273:e0d7 with SMTP id gb10-20020a17090b060a00b002955273e0d7mr2092964pjb.17.1706714596524;
        Wed, 31 Jan 2024 07:23:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXewRb4Xq/i5Lx4akq9sVHlBffsHbVhFYaMq8orAupSUQPOtTwNPGyNelHZxa+jJQiEf7dNwcKA+5e5b9qIO9bmwfo8rDcFMlj842W9Pdul3U4dfo6vNZLEOOJJgdqnj+B3SUX2QkZKBrpzCYuADsi5Vcjc7eoy4VsIriYgNVfmsBnI3dKxWfka3gnb5cQLRiwBbmBkbCuFBTgqbCG7hxeHYWy8dFxg8rZt94z3HTsQ50WLZHsEk0k/MYU0tsgMdZkBl0V+uYVemLXNAWR3apCUTAMcyTdp6HZj31k5lZQ5aBEgCv7SSSJeTrA/zQkITxwf5d0gI0DPYe7BN6PW9Xs3hrCBqTkpPGOzKO20ISJMzElmQnzqZqYMPag3UxthSBsnRWyb7Q==
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id gx18-20020a17090b125200b0029487e5dbc6sm1614142pjb.31.2024.01.31.07.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 07:23:16 -0800 (PST)
From: Shigeru Yoshida <syoshida@redhat.com>
To: jmaloy@redhat.com,
	ying.xue@windriver.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzbot+5142b87a9abc510e14fa@syzkaller.appspotmail.com
Subject: [PATCH net] tipc: Check the bearer type before calling tipc_udp_nl_bearer_add()
Date: Thu,  1 Feb 2024 00:23:09 +0900
Message-ID: <20240131152310.4089541-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported the following general protection fault [1]:

general protection fault, probably for non-canonical address 0xdffffc0000000010: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087]
..
RIP: 0010:tipc_udp_is_known_peer+0x9c/0x250 net/tipc/udp_media.c:291
..
Call Trace:
 <TASK>
 tipc_udp_nl_bearer_add+0x212/0x2f0 net/tipc/udp_media.c:646
 tipc_nl_bearer_add+0x21e/0x360 net/tipc/bearer.c:1089
 genl_family_rcv_msg_doit+0x1fc/0x2e0 net/netlink/genetlink.c:972
 genl_family_rcv_msg net/netlink/genetlink.c:1052 [inline]
 genl_rcv_msg+0x561/0x800 net/netlink/genetlink.c:1067
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2544
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1076
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0x8b7/0xd70 net/netlink/af_netlink.c:1909
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The cause of this issue is that when tipc_nl_bearer_add() is called with
the TIPC_NLA_BEARER_UDP_OPTS attribute, tipc_udp_nl_bearer_add() is called
even if the bearer is not UDP.

tipc_udp_is_known_peer() called by tipc_udp_nl_bearer_add() assumes that
the media_ptr field of the tipc_bearer has an udp_bearer type object, so
the function goes crazy for non-UDP bearers.

This patch fixes the issue by checking the bearer type before calling
tipc_udp_nl_bearer_add() in tipc_nl_bearer_add().

Fixes: ef20cd4dd163 ("tipc: introduce UDP replicast")
Reported-and-tested-by: syzbot+5142b87a9abc510e14fa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5142b87a9abc510e14fa [1]
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/tipc/bearer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 2cde375477e3..878415c43527 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -1086,6 +1086,12 @@ int tipc_nl_bearer_add(struct sk_buff *skb, struct genl_info *info)
 
 #ifdef CONFIG_TIPC_MEDIA_UDP
 	if (attrs[TIPC_NLA_BEARER_UDP_OPTS]) {
+		if (b->media->type_id != TIPC_MEDIA_TYPE_UDP) {
+			rtnl_unlock();
+			NL_SET_ERR_MSG(info->extack, "UDP option is unsupported");
+			return -EINVAL;
+		}
+
 		err = tipc_udp_nl_bearer_add(b,
 					     attrs[TIPC_NLA_BEARER_UDP_OPTS]);
 		if (err) {
-- 
2.41.0


