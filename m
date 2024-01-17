Return-Path: <linux-kernel+bounces-29518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19024830F89
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97BE5B21822
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436F71E88B;
	Wed, 17 Jan 2024 22:52:09 +0000 (UTC)
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BFD1DA4C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531928; cv=none; b=l1xhvOoORGv2f5JZdxSNjZEAkfa8IFWpyHtqdzSRDyCfR6+f+rpA+y0Cm2QN+kwGzYECZ/TzxnqGHoHvN5IbtZmGa5TnDGA2wHcp8YBRTeNxaJLeNJSBRo+3G4tQ52TrDqVpEO1eLzKYV0FMTvhXRnGpHvSflT+EZAUS5ZCHr54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531928; c=relaxed/simple;
	bh=hxqOcdY5nnRMFd7npMGrrV06xfgTFJ5Vl/wDk4qAM6w=;
	h=X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:X-SMAIL-MID:X-SMAIL-UIID:
	 From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=DcILXf5nBlBv4MdFsMvXC5dTVLT2zxCPjKxVZJ5P+4dQhvdmZKRRTpf/wwB7sQ/13EqlP6mzgnbaS9BXGC1zOYthdMb+3mmOG+ZKDTppi5v2rXBuZiLWbn6UfGJvLd5C6ETQi7+X1gMmH45w5YfaG0qumSFpocqnaRTv7ZThkVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.25.116.10])
	by sina.com (172.16.235.24) with ESMTP
	id 65A859E900001378; Wed, 18 Jan 2024 06:51:23 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 98099045089129
X-SMAIL-UIID: EA8EC4B079434858BA960ECF55158D6A-20240118-065123-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
Date: Thu, 18 Jan 2024 06:51:12 +0800
Message-Id: <20240117225112.1186-1-hdanton@sina.com>
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
--

