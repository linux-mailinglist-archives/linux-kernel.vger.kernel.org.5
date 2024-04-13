Return-Path: <linux-kernel+bounces-143755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265558A3D0C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966971F21995
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 14:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57B742A96;
	Sat, 13 Apr 2024 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BfkK5Ob8"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457902F873
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713020037; cv=none; b=GDHxe/gIg0DfkY5VE1C9NyPuaeYI570+OeTbY1WMvc4wQDwVN99hxVUd9ag3bQvMaym6tZeF0zIGrlbSVS/vVw336oSH0p0Y90ZI2vnuwkyS1TssTSw8PxZHDE/3J1oAYF12qYag1a3uuTygxoJ5YGgWd47qGOpk75psUlz+px0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713020037; c=relaxed/simple;
	bh=a5q8nw0XgVR6N756cgpGAaeVwSwtSM1RleiWbr+/9M4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=mK/MwBEOxntotrLZ7tnYtwOEJdOz55PfCwc6OszcvukuVKHQOC22SjHx0qJMDvzOTXinl6vqw8zKMkUOaQ4VIPqBQg9tDLjSevyOAbg40xZAbmaJUzIsOWBCnzU3QpEBlxVCsbmwC4dhitEeUYMQk1+uLuphMXDc3DFeZQM2EiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BfkK5Ob8; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1713019724; bh=XLWYnmUp+Hs8di2CsOJWUPH+JTczqKrjI/H+CiBfNzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BfkK5Ob8Pm3bdAA0L0vN4c9SUTR/Z0Gst4FSuX4SC5+HltbhBlKxDHrTcg2ljB2xK
	 ZiAgNNNRduVC4JXoHw0I5HXaxh1VcyiA8d7jHWA2B1vj+QJ2VaCaB0m8qeIRrEfXIR
	 XhkeeRxum8GU6VFPzMm2/VlGfOSiiO+mWk1psvxs=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id C2A24241; Sat, 13 Apr 2024 22:48:42 +0800
X-QQ-mid: xmsmtpt1713019722tuzea4s0c
Message-ID: <tencent_9625BABA15BB89336B9E491B6A4BA61B2808@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMmaP+1mcOH883vq/+M6jorP66N5F3Sb416cbQudDuTLHkjKwFd8kS
	 VUkPV2D0j97I+EpemOboq9QPC1pG5aoAYx3NwYBLyfb5Gcnzrpjk3eqbpznqMKv1xixcYKUpEGu4
	 sg4V3OvIqrNUqYMEFR0+Eh1mqINODEePxyrCnsd1UB+1rwKiu5yKZmdUNJgeq0fYIu1HS9keH8+5
	 ABW8ihq0Ss5+YHle4u45XT62iegLb/YHRtM/JQPV1ckH/0ywWy053cdHmW0C8ZrbY+GgAZcl/QYV
	 BiKnm7W2dkEY4RzYhjiWptZXqTmqiS+XCfH612i87Vrv4DaBS7Gkb3cCHQOFgC3pDxliXP42CEuC
	 hNux5rtX0zksHrz1ccnKLsZrRVXsp9X66GXnGQM8LvvqTgA8YVOkJgg8AscE1pT4cbmVXIBjcyrO
	 rttvjn4A3ch4jq0BLmg68UKZkBbUgNXIZxpeMRTPLLhMz1lG4o6KEKwHEiuiLZkoVdo1IGRPYUCe
	 A5HfewCuRPuuLOSiSNyyzU2JhdW68/zK6g6VS3V79p4DM1ILu/9DhfrSci3i8RvJTzwiDNoAbfCN
	 dariEAFqJMdN0BxhY94X7fyX3gdex/vMV3tRjuadOajMOddLzsWZIdnmX9WVFuKxDalELY22IUO+
	 ioPH6opziyqaX1np+Z3/2/nkXnK+69dUrz8tDOqtl4CH12lg40wU5HEKj/4824im74OlRifRZNcp
	 kZqp3Rc6tatLCv6EEbrgKfKlk8AVt1Twr+xN2hsXo4hzXZ9Obi8s2pp39/nLIGkHxJwPl9Q6Xyk7
	 TqJNMQAVFuFoqDspCo99xAAnTIGnkUm5joamA/PUGVyIqunw85jCMGMTYxD4ppZq6ObNPHENvGlV
	 ZgSIGdbyPHHt9n73ywC032F0MyXVtrEfCaL7Q79XoUTLyYOsYZpT/eeVt72cjHlzkJdUmyNMmFSe
	 F1o3y6Y94=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+3a36aeabd31497d63f6e@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] KASAN: slab-use-after-free Read in gfs2_invalidate_folio
Date: Sat, 13 Apr 2024 22:48:43 +0800
X-OQ-MSGID: <20240413144842.2770371-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000004f557c0615d47e6d@google.com>
References: <0000000000004f557c0615d47e6d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uaf in gfs2_invalidate_folio

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e8c39d0f57f3

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 974aca9c8ea8..4ae5e73b6992 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -613,6 +613,7 @@ static void gfs2_discard(struct gfs2_sbd *sdp, struct buffer_head *bh)
 	gfs2_log_lock(sdp);
 	clear_buffer_dirty(bh);
 	bd = bh->b_private;
+	printk("bh: %p, bd: %p, %s\n", bh, bd, __func__);
 	if (bd) {
 		if (!list_empty(&bd->bd_list) && !buffer_pinned(bh))
 			list_del_init(&bd->bd_list);
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 8cddf955ebc0..d05decef6af5 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1007,6 +1007,7 @@ static void trans_drain(struct gfs2_trans *tr)
 {
 	struct gfs2_bufdata *bd;
 	struct list_head *head;
+	struct buffer_head *bh;
 
 	if (!tr)
 		return;
@@ -1022,6 +1023,9 @@ static void trans_drain(struct gfs2_trans *tr)
 	head = &tr->tr_databuf;
 	while (!list_empty(head)) {
 		bd = list_first_entry(head, struct gfs2_bufdata, bd_list);
+		bh = container_of((void *)bd, struct buffer_head, b_private);
+		printk("bh: %p, bd: %p, %s\n", bh, bd, __func__);
+		bh->b_private = NULL;
 		list_del_init(&bd->bd_list);
 		if (!list_empty(&bd->bd_ail_st_list))
 			gfs2_remove_from_ail(bd);


