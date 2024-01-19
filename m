Return-Path: <linux-kernel+bounces-30850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A23E832517
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C41428643C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80AFD518;
	Fri, 19 Jan 2024 07:39:19 +0000 (UTC)
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BE5C2D6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705649959; cv=none; b=JGKUsrfTBiB5rqdieD6fdgEsNGu2j5EyvL5HYOlHaHp6/q9CGoSt4dl+RO7ptYIuzPlHp04oa+6FbIqt3I+GVEUdcVzUS+k1BdHK3C0Zq+RTbJ0Q032DKS0TrBOnYBcVaPQUlJcHHsGvpYedU8l38YNphY124blOOqVoTAoF2TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705649959; c=relaxed/simple;
	bh=W/Jmw46U4UnoF6+JA4rYtU5Rvk2VYGhd7GxWe4Bfr+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nYavQc+TOXCgiV7yIXSCIUl0NQFt+70l16OSAf+cJvAo15dKLrAJpFPCuqmK7btWcJQX32UIhFTXZhKZLU5NFkht8bPHcNdJ++3xevPIBlLyRQCX/o5cUL5PC4ZWCKbYamVQg7YNEDz4SC8yuN71mvneds5fHtxGOV+ybxSolWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.220])
	by sina.com (10.75.12.45) with ESMTP
	id 65AA271500007C24; Fri, 19 Jan 2024 15:39:04 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 20076631457703
X-SMAIL-UIID: CAB9F0B1D5F04DBDB5F7CA5C3D28E3A1-20240119-153904-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
Date: Fri, 19 Jan 2024 15:38:50 +0800
Message-Id: <20240119073850.1878-1-hdanton@sina.com>
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
@@ -2161,6 +2161,10 @@ static int __bpf_redirect_no_mac(struct
 	}
 	skb_pop_mac_header(skb);
 	skb_reset_mac_len(skb);
+
+	if (skb->data[0] < 2)
+		flags = 0;
+
 	return flags & BPF_F_INGRESS ?
 	       __bpf_rx_skb_no_mac(dev, skb) : __bpf_tx_skb(dev, skb);
 }
--

