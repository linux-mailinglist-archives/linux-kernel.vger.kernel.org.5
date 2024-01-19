Return-Path: <linux-kernel+bounces-30764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9217C83241C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720A42853F7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1BC4A08;
	Fri, 19 Jan 2024 04:50:19 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1F94691
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 04:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705639819; cv=none; b=IaHN4Kf6n+Y7DVLkdN94mE6FFSQE+qqmC12E24SbAsUqhMqxpqef7UkqsHDyj/Ew5Zbm8JSvZ/icwk+YtW7DPJ0EbXhI0S2xcH03DFhryRMKb8knBzUXpavKRbZCZtSLPLK4+9BpF/ksbhC2ky0KAR7BIrs7lYQD7l2fhsjMqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705639819; c=relaxed/simple;
	bh=ofWLBSeEYg3Rp0NyXVGODyR0RTz8wnyHsSZayNkRPPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ED3z5auDoDHlYXM9+6KPzAXeqjJn5oK0etZy6YdRsJMC3k/ysv2N6bYsRSqZ+TADrkoFUjijdvVBX0KrOUv81ogt74emphGPSm/P0d3Fird0Hi4F4JbnSkUqdiVHJjLiBNowDIHkb6Biq66MHkbAJO/VYPUDJI2X3Zb1j90bf6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.220])
	by sina.com (172.16.235.25) with ESMTP
	id 65A9FF8000003C01; Fri, 19 Jan 2024 12:50:10 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 68043334210552
X-SMAIL-UIID: 4C2E0D85AF144995AC690654A874E535-20240119-125010-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
Date: Fri, 19 Jan 2024 12:49:58 +0800
Message-Id: <20240119044958.1809-1-hdanton@sina.com>
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
@@ -1165,9 +1165,13 @@ proto_again:
 	case htons(ETH_P_IP): {
 		const struct iphdr *iph;
 		struct iphdr _iph;
+		const unsigned char *buf = data;
+
+		if (2 != buf[0])
+			_iph.ihl = 1;
 
 		iph = __skb_header_pointer(skb, nhoff, sizeof(_iph), data, hlen, &_iph);
-		if (!iph || iph->ihl < 5) {
+		if (nhoff < 0 || !iph || iph->ihl < 5) {
 			fdret = FLOW_DISSECT_RET_OUT_BAD;
 			break;
 		}
--

