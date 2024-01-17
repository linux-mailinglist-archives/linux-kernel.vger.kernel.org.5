Return-Path: <linux-kernel+bounces-29556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C7C831026
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E1B1C21BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FE028DA7;
	Wed, 17 Jan 2024 23:43:30 +0000 (UTC)
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2124028DA0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705535010; cv=none; b=ECEFWqyUwm3IxlykcAvPNaG83+iIi3dk5Rg6RE99V/JZDejuVIuLOfbluOEBIwRjxXSRZu+TmCEKYen1Du9r3C3o0uFQWqlrSBtD03SRsnlkzMrBimqUIeEG80GByKeKViFzMtKDNQmkV6MX5Zk/ecRDsbC/8feQdgZuhESlz9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705535010; c=relaxed/simple;
	bh=7ElkhRgi1G5t6xj9IeZJpskpCfmhNWVSMnOnS02p4k0=;
	h=X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:X-SMAIL-MID:X-SMAIL-UIID:
	 From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=vBQFxAXTN7ATjvGaydyHgVxtVRNygpB0dQdflG/3NsB92tIwd5RF4XmebatePW0GcS2Wjsm9ihKPsyb+LAWxa+KQIi4Z+qSs3R2bTZqorWnuqK/kBIaFl5PZpB9Ryyz3L7FrWRLHWohsi4pdfdz9+firdo0bCUo0X1YiYu9+bv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.25.116.10])
	by sina.com (10.75.12.45) with ESMTP
	id 65A8661200009086; Wed, 18 Jan 2024 07:43:16 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 65845131457298
X-SMAIL-UIID: 52380B1C20FA4ED8A66B13FC86A7A2E9-20240118-074316-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
Date: Thu, 18 Jan 2024 07:43:04 +0800
Message-Id: <20240117234304.1250-1-hdanton@sina.com>
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
+			iph = (void *) skb_network_header(skb);
+		else
+			iph = NULL;
 		if (!iph || iph->ihl < 5) {
 			fdret = FLOW_DISSECT_RET_OUT_BAD;
 			break;
--- x/net/netfilter/nf_conntrack_core.c
+++ y/net/netfilter/nf_conntrack_core.c
@@ -346,9 +346,11 @@ static int ipv4_get_l4proto(const struct
 {
 	int dataoff = -1;
 	const struct iphdr *iph;
-	struct iphdr _iph;
 
-	iph = skb_header_pointer(skb, nhoff, sizeof(_iph), &_iph);
+	if (pskb_network_may_pull(skb, sizeof(struct iphdr)))
+		iph = (void *) skb_network_header(skb);
+	else
+		iph = NULL;
 	if (!iph)
 		return -1;
 
--

