Return-Path: <linux-kernel+bounces-30144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D644A831A61
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707AD1F28D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5627B25541;
	Thu, 18 Jan 2024 13:18:21 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E672425105
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705583900; cv=none; b=OC6Zuaq3x4WRYi9/Obmin5gQ/A3sfYwYB3RFEpBmn/cj3OCDNU0XbMTh9S0cVjWMOoC+uyKND4U1RYHft5kOKopok6UjeIGYt317YE60K3xgbY6PvJXipCqfBIBX0pW+CHTD/qzBX8WSf72fN88R3Rmg5CxixEmpNT+pFL64OHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705583900; c=relaxed/simple;
	bh=sq0s2ZlNlijNKAG327fa7nRqaPyj5VhfBHv2puH2NzI=;
	h=X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:X-SMAIL-MID:X-SMAIL-UIID:
	 From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=mJQbFV73aS8issWwa5DrovLgBFMGNFd/k8lvVnOwu0aCL4Ls6Yq3IADgWBgkCWCtDrwbbSS8SicyshsWKB6RNlmi95ACR5nUGblyxyMQjtH6ja2HuJjvj6NsdT/OS16gRx4nFIflpMUQvS9jZhrm/fIM7HDmVDYORNJj0x9B5oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.25.116.10])
	by sina.com (172.16.235.25) with ESMTP
	id 65A9250800004A35; Thu, 18 Jan 2024 21:18:04 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 87036134209805
X-SMAIL-UIID: 8D4A113887E4421F9B1D8F9C17FDFC6B-20240118-211804-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
Date: Thu, 18 Jan 2024 21:17:50 +0800
Message-Id: <20240118131750.1688-1-hdanton@sina.com>
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

--- x/net/core/flow_dissector.c
+++ y/net/core/flow_dissector.c
@@ -1163,10 +1163,8 @@ proto_again:
 
 	switch (proto) {
 	case htons(ETH_P_IP): {
-		const struct iphdr *iph;
-		struct iphdr _iph;
+		const struct iphdr *iph = (struct iphdr *) skb_network_header(skb);
 
-		iph = __skb_header_pointer(skb, nhoff, sizeof(_iph), data, hlen, &_iph);
 		if (!iph || iph->ihl < 5) {
 			fdret = FLOW_DISSECT_RET_OUT_BAD;
 			break;
--

