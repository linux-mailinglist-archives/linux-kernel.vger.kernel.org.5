Return-Path: <linux-kernel+bounces-30046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A75831852
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86DE1C20FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C259F2377B;
	Thu, 18 Jan 2024 11:18:14 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1D723760
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576694; cv=none; b=jT29JwxJ0gXBzjp5O2R6f1HVeVKuZ6vi353Ei6GXNHb1euGV3NA/IjYeLB+rkdB6EsmHwWZfP/OXKb/qE+rYOI2vct8niPQe/4ZGBP3rmIrGsrymxqeAX5Si61GmV1kY4rCzq0xSLgGDwvN/k/GpbSYIZJR+Fg/Gx0V2APyjqUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576694; c=relaxed/simple;
	bh=EzIFRQntpfnEsY3JipXcSeq9Zj3ML31Df14pi43TAyQ=;
	h=X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:X-SMAIL-MID:X-SMAIL-UIID:
	 From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=U5Q/VuzdEks2+yjqe245CokGB4HqxBfA1jHO6pwwf/KrOdM44F/hObKJLyYJiBxsYYJOTdyWN6JUmB9dD4VFJkh+5PAR7UNrDm5dqMVOiLD4RYCNOP8H6RJMjLmluh7ZA0Qb1jz8LNsbDoHhpPXovnDBUaULGNogynYUIHdDL9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.25.116.10])
	by sina.com (172.16.235.25) with ESMTP
	id 65A908E900005930; Thu, 18 Jan 2024 19:18:03 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 39138134210283
X-SMAIL-UIID: 4BFB07016F5D4985971B788877A21106-20240118-191803-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
Date: Thu, 18 Jan 2024 19:17:51 +0800
Message-Id: <20240118111751.1426-1-hdanton@sina.com>
In-Reply-To: <000000000000498a02060de59162@google.com>
References: <000000000000498a02060de59162@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 01 Jan 2024 09:18:16 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    f5837722ffec Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122dfc65e80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/net/core/filter.c
+++ y/net/core/filter.c
@@ -2431,7 +2431,7 @@ enum {
 BPF_CALL_3(bpf_clone_redirect, struct sk_buff *, skb, u32, ifindex, u64, flags)
 {
 	struct net_device *dev;
-	struct sk_buff *clone;
+	struct sk_buff *buf;
 	int ret;
 
 	if (unlikely(flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL)))
@@ -2441,22 +2441,11 @@ BPF_CALL_3(bpf_clone_redirect, struct sk
 	if (unlikely(!dev))
 		return -EINVAL;
 
-	clone = skb_clone(skb, GFP_ATOMIC);
-	if (unlikely(!clone))
+	buf = skb_copy(skb, GFP_ATOMIC);
+	if (unlikely(!buf))
 		return -ENOMEM;
 
-	/* For direct write, we need to keep the invariant that the skbs
-	 * we're dealing with need to be uncloned. Should uncloning fail
-	 * here, we need to free the just generated clone to unclone once
-	 * again.
-	 */
-	ret = bpf_try_make_head_writable(skb);
-	if (unlikely(ret)) {
-		kfree_skb(clone);
-		return -ENOMEM;
-	}
-
-	return __bpf_redirect(clone, dev, flags);
+	return __bpf_redirect(buf, dev, flags);
 }
 
 static const struct bpf_func_proto bpf_clone_redirect_proto = {
--

