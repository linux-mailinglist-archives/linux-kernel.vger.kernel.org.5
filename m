Return-Path: <linux-kernel+bounces-108789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1415880FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B08F282E16
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D343D995;
	Wed, 20 Mar 2024 10:32:45 +0000 (UTC)
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD383E47E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930765; cv=none; b=FXefB9I0cgsHsWGfRbCDusO/J+eN0ioTiYzt8/arwrg4VEVLggqHMf7owBt8YaBADIePi+RXu59BhAHZwZbavXx0j8L2KbYw4tPmHQAttE6kaPEKczwRmZq0gRkjm3aIXSwNaNmCNg+oytfTNocKhHdr2KzuMlw0zXZpBCuUkOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930765; c=relaxed/simple;
	bh=T35/JrbAIRlVdb8W3DXMbAHoQbCejoJW0kA8EGF3G7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BOuq2YkGLoB3Nlz+WXPyIDoRNLeT31moRBPhlKPU1A3LfmqAKNoV8xM31hPOlcNm+ySiPVAIDC4hpwOPgZfBabZA7U6QHYgvTKvraPV5drsnxs0ed2Q15NawHKz6lxZt49+hUIvopdxHkEbYQ53RI6EFxJYJE8qVwG6kBKlv+is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.154])
	by sina.com (172.16.235.24) with ESMTP
	id 65FABB3F00004AF8; Wed, 20 Mar 2024 18:32:33 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 65244545089261
X-SMAIL-UIID: 17DCF4DB114A47DDAA77499C7F92291D-20240320-183233-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
Date: Wed, 20 Mar 2024 18:32:24 +0800
Message-Id: <20240320103224.2123-1-hdanton@sina.com>
In-Reply-To: <000000000000adb08b061413919e@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 20 Mar 2024 01:42:21 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    32fa4366cc4d net: phy: fix phy_read_poll_timeout argument ..
> git tree:       net
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1676fc6e180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git  32fa4366cc4d

--- x/kernel/bpf/lpm_trie.c
+++ y/kernel/bpf/lpm_trie.c
@@ -321,7 +321,7 @@ static long trie_update_elem(struct bpf_
 	if (key->prefixlen > trie->max_prefixlen)
 		return -EINVAL;
 
-	spin_lock_irqsave(&trie->lock, irq_flags);
+	spin_lock_irqsave_nested(&trie->lock, irq_flags, 1);
 
 	/* Allocate and fill a new node */
 
@@ -448,7 +448,7 @@ static long trie_delete_elem(struct bpf_
 	if (key->prefixlen > trie->max_prefixlen)
 		return -EINVAL;
 
-	spin_lock_irqsave(&trie->lock, irq_flags);
+	spin_lock_irqsave_nested(&trie->lock, irq_flags, 2);
 
 	/* Walk the tree looking for an exact key/length match and keeping
 	 * track of the path we traverse.  We will need to know the node
--

