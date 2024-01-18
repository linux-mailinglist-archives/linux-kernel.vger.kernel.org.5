Return-Path: <linux-kernel+bounces-29710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E3E831228
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 05:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5051C21A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 04:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0809461;
	Thu, 18 Jan 2024 04:34:28 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F959444
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 04:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705552468; cv=none; b=TtG1DxsYSMh8mJNNZbXKKRuKNuyuABb4exdegD7rqjG9OaxxwVLooRmG8v8U+Ee7qfdUOvgSWQ3ZSBUnI08UQdwKJNOalwfF8P5sHqH7lA+M6GFstoyRk3OS4KG0iidvNW3uzNPksu3sX7QRWTMrS/EUQ8Ul+6Wva+7nrLqolm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705552468; c=relaxed/simple;
	bh=lA6vE2VxxaPtUv5LjBeeQRfExyiylQC290cZKlzjVX0=;
	h=X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:X-SMAIL-MID:X-SMAIL-UIID:
	 From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=ETFhIG7+GFNjGQzOeVVYYN86PNVnPIGRCpIWGRFuvRMi+oSQwO+ByI8Zv+80+9goJ04/bfLrJ8BDS4+DnW/i7GM/4AdoNECDI4H8or8HpZ0KfQh2j7Hvc28QXBQII8Ifjf7omno5bn7vHBf6sqG33Y6zKe+/UVzUFch3M3os2as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.25.116.10])
	by sina.com (172.16.235.25) with ESMTP
	id 65A8AA41000046E1; Thu, 18 Jan 2024 12:34:11 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 41948334210557
X-SMAIL-UIID: 549C35AC03DE40E0A7A1A3F2995C74DC-20240118-123411-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
Date: Thu, 18 Jan 2024 12:33:59 +0800
Message-Id: <20240118043359.1367-1-hdanton@sina.com>
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
@@ -2159,6 +2159,10 @@ static int __bpf_redirect_no_mac(struct
 		if (!skb_at_tc_ingress(skb))
 			skb_postpull_rcsum(skb, skb_mac_header(skb), mlen);
 	}
+	if (skb->tail - skb->data <= sizeof(struct iphdr)) {
+		kfree_skb(skb);
+		return -ERANGE;
+	}
 	skb_pop_mac_header(skb);
 	skb_reset_mac_len(skb);
 	return flags & BPF_F_INGRESS ?
--

