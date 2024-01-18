Return-Path: <linux-kernel+bounces-29664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4A9831173
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266202879AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F138FAD5A;
	Thu, 18 Jan 2024 02:34:50 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75387AD32
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 02:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705545290; cv=none; b=a626vBDJ8Q/3NmSvmql0lbGjxsLesU4YKpX7lnaA0o5Cc6wR9NwbKxiUcqMGnPtmj0i2uFjTL9hv5YOhFfr3yNCQEvpi3vd84CiH4zOrsnrobpmKgVatvTLmNUMJOcbB3+RBc//0VC/qfelD/hkGSEGob0/asMw9lzOp06Bhf6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705545290; c=relaxed/simple;
	bh=CnA0w49IF8enfhXEes0dk7a/PKOBy+B/UoVjYJQjNYM=;
	h=X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:X-SMAIL-MID:X-SMAIL-UIID:
	 From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=FMXHPNondHRNMQSTFvAj/CgTOji6edr+x6/O9lrj7YuQUnY9C4Cr75bnUPo8k4tCHXpPkMLBV3lQ1eVlqS62kCdSxIEOpm9oX2L//E2+F2IXRYf6acyk3HLHRHLWNNvfWN+jKKwvPeKN5Zp8pui2ZL4b6GG2wLc+PD/ib5r4rzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.25.116.10])
	by sina.com (10.75.12.45) with ESMTP
	id 65A88E160000728F; Thu, 18 Jan 2024 10:34:01 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 26839831458093
X-SMAIL-UIID: CE22F8317646437A9919901293FEC241-20240118-103401-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
Date: Thu, 18 Jan 2024 10:33:48 +0800
Message-Id: <20240118023348.1310-1-hdanton@sina.com>
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
@@ -2147,6 +2147,10 @@ static int __bpf_redirect_no_mac(struct
 		kfree_skb(skb);
 		return -ERANGE;
 	}
+	if (skb_headlen(skb) <= mlen + sizeof(struct iphdr)) {
+		kfree_skb(skb);
+		return -ERANGE;
+	}
 
 	if (mlen) {
 		__skb_pull(skb, mlen);
--

