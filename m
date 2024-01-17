Return-Path: <linux-kernel+bounces-29009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146188306C3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63F428833E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6961F602;
	Wed, 17 Jan 2024 13:14:48 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D501F5E4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705497288; cv=none; b=Tz0C4l7Ocvx4H/NR4SP8h+KsrWyYGoW19u05Ja9GqhdMFBSMajJXcWOJ4c7aVk+c+XAgU8ifa7oDujSkdZozivoTQxQZvylw1seXmFxapK9D2ZhjX/gRmg6yc7dbms6lveshN114UsSAgwPoormCLTvYAi69xi8SFiF0mQS0JtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705497288; c=relaxed/simple;
	bh=UjOXDsSAnTHmivBnROBsEpKyAZIZ96ZfbwkUoX7BKdk=;
	h=X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:X-SMAIL-MID:X-SMAIL-UIID:
	 From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=nyv/FtJlQlchshjastxHk/Eh3HMZjPQCrwNiJbidkV/Ed58uh+UojyQnesehSUVVMBdX34D1/pN2fbFmZoc9Sgh6PQyqgp2vbsCBZIqtsO8YWnKtQWoFs6SY79nDcwwvr0ZOJvX7x8BKWhbhFVKratk6D95vHcxAIVQ6EoFDLa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.226])
	by sina.com (172.16.235.25) with ESMTP
	id 65A7D2B200002EFA; Wed, 17 Jan 2024 21:14:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 75504034210326
X-SMAIL-UIID: E9C1D74C5D7142DBA3E3ACA5ACF47908-20240117-211430-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
Date: Wed, 17 Jan 2024 21:14:17 +0800
Message-Id: <20240117131417.1132-1-hdanton@sina.com>
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
@@ -1164,9 +1164,11 @@ proto_again:
 	switch (proto) {
 	case htons(ETH_P_IP): {
 		const struct iphdr *iph;
-		struct iphdr _iph;
 
-		iph = __skb_header_pointer(skb, nhoff, sizeof(_iph), data, hlen, &_iph);
+		if (pskb_network_may_pull(skb, sizeof(struct iphdr)))
+			iph = skb_network_header(skb);
+		else
+			iph = NULL;
 		if (!iph || iph->ihl < 5) {
 			fdret = FLOW_DISSECT_RET_OUT_BAD;
 			break;
--

