Return-Path: <linux-kernel+bounces-30081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2028318EB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3701C250D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1281224214;
	Thu, 18 Jan 2024 12:09:11 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ECF241F0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705579750; cv=none; b=n5WmUyU2kUGKIWu6JniBd6TUiG9p2soB6sh4oVo//W68d/zpwMVL0UY++LEyLpJnMgnaStEa5pgqxJTUeC5Bc617Un5Pd86BulQ1ONuYziqP3cKru+wf3twJ25s4dGcNhGi9/hlHI7EF755PfyPa3f2dGplMcP8s3bfyXx6npHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705579750; c=relaxed/simple;
	bh=8fvFgC/7W7KdsiBVC5xx7PmuNOk7MkmPZxNpLSIHg6s=;
	h=X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:X-SMAIL-MID:X-SMAIL-UIID:
	 From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=E9J1pogSZxDAbkvSKuNfEcAsqM1+7ads/Cqc9Oz+V2vg2KiLfeCPfaP4nW5wYKHOmzoG5uQszM7WDamrvAf3+8E1Jgwy4pgj7Endi2JMYzJCotZXXCBrF3KeoSm20VvjTQd1M6F7z7z4qWftT6f5uNoRw3n5gEoZzAAwPaHXGmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.25.116.10])
	by sina.com (10.75.12.45) with ESMTP
	id 65A914B600006B74; Thu, 18 Jan 2024 20:08:24 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 87259431457850
X-SMAIL-UIID: D9DFB641CEB643048A5FBBAD10C821A2-20240118-200824-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
Date: Thu, 18 Jan 2024 20:08:12 +0800
Message-Id: <20240118120812.1575-1-hdanton@sina.com>
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
@@ -2144,6 +2144,7 @@ static int __bpf_redirect_no_mac(struct
 	unsigned int mlen = skb_network_offset(skb);
 
 	if (unlikely(skb->len <= mlen)) {
+out:
 		kfree_skb(skb);
 		return -ERANGE;
 	}
@@ -2159,6 +2160,8 @@ static int __bpf_redirect_no_mac(struct
 		if (!skb_at_tc_ingress(skb))
 			skb_postpull_rcsum(skb, skb_mac_header(skb), mlen);
 	}
+	if (skb->len <= sizeof(struct iphdr))
+		goto out;
 	skb_pop_mac_header(skb);
 	skb_reset_mac_len(skb);
 	return flags & BPF_F_INGRESS ?
@@ -2431,7 +2434,7 @@ enum {
 BPF_CALL_3(bpf_clone_redirect, struct sk_buff *, skb, u32, ifindex, u64, flags)
 {
 	struct net_device *dev;
-	struct sk_buff *clone;
+	struct sk_buff *buf;
 	int ret;
 
 	if (unlikely(flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL)))
@@ -2441,22 +2444,11 @@ BPF_CALL_3(bpf_clone_redirect, struct sk
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

