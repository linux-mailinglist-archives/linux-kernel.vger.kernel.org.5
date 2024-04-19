Return-Path: <linux-kernel+bounces-151448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B05BD8AAF15
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F19A1F21B37
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684EB86131;
	Fri, 19 Apr 2024 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USHfQonJ"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895F98565F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713531798; cv=none; b=cOw2Y5Po6asG2ZEbPTPpjRXDepcasXBoJfMpsX8m/1hTKsoLBXFiHiXTRTzrG25+mAM/jP7Br36r7+UVgxGE42163TwFuoCgFqcVeW2HFhUfq1mkI7PnbA/2iCzEZ0d1EsC8D88ZczSLNeumigAFzmDos46YtezcLyRt4Wh7KSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713531798; c=relaxed/simple;
	bh=vd+AcK5ckksnYCIMHwfQ2gDT4wZhygIoCWlzp7J9Dxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OV5n5w6C3BG5xq48UGxoKW4ZF16EeOAtOPsVE+CUbUbneU5d+fK64SZ0PKMiCyaANsPsaGmdcnuodNdNCsQ2X+6TZIBvzAen6euCIASeL5EFLdv2DqkWb1VnK1gF4E4hkQQ9uUWUkd3Tvi9W+c7g28ozt/CaoT+4RD5Bll6zhNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USHfQonJ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a68a2b3747so1485556a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713531797; x=1714136597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvxO7y+2XjuTmbb5qoDXzefwmiRqcSOPTAVy3uVNsOg=;
        b=USHfQonJat8+/5k06/+LcJ9Xv4Q7R8M+/hLKLig46gCAcbQ27A4J4w3s/5OfI3EzRV
         acxiz9BpJwdOo1vIRt4JSWSVzT8Hnna2Q74mpQThXkHrjmfslXHzEN1snwNoT4Bs+8vh
         8AuHB8uctz4T4UmFDx8LuXM0OjGgb64Kv91TazQ84UP/GzZ2sOVpqQhd7CWgCgW2j+nu
         Pb54BfzzL+NxRstVFE7HZEfXGayWzsMXllhCD54XHMpZ9KyDveC03AHNLQyuQic/8Tft
         kuQEzT1K4WDTuPsgzkLOrQJXimUrBPCrRDJ95lgubIIsdKY/I+Kw33sSzQVRRETcpwRU
         3boQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713531797; x=1714136597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvxO7y+2XjuTmbb5qoDXzefwmiRqcSOPTAVy3uVNsOg=;
        b=He5K1sY1LHb3DnRBwOTWqI/NDzIObca3WruLIgrVJFe7jgLt8d1YSJb8jYN8dDgH/9
         oSnVMfqdE8IXclloMoKeyEaLc9K8gjUP/WZZQoVjj2pQRGgznoUU0x4/hovNuXZfcKim
         pGygzlvewomTF+zoqmUAfEAePrqBLjRoD7JwVCLnQw0VdS8l2zlYa4BSWqawYfuRDeU6
         HJPDxymu7/n+yfjCGKGSv53bBPLr93n/KengpXnHHRiB3gBlg6jPu6WiasEIg4UjZJnl
         ip6MBX9XOJXxgfc80zHWiG6cJpsxBAm5wJdZRHaw+E1IsaH5kir66F105y8djk3luB/y
         XwsQ==
X-Gm-Message-State: AOJu0Ywfky/3/DwifIMy8Q6BwoRmSKJf/6C6BpXtcULLOHebHGbBq6QO
	HszG5fjV5VoBlPghW8oOOZfUoVWnBW7pzv81UdWkeMZqXeLVY8Bb
X-Google-Smtp-Source: AGHT+IF1wKU5GoUO+bPo/sRLjEusZ6KtjDMSWzc4UpF5CkBBOaTHsg5jLm6SM+wzBxqGlXDNN+36sA==
X-Received: by 2002:a17:90a:fb43:b0:2aa:9ae9:31ac with SMTP id iq3-20020a17090afb4300b002aa9ae931acmr1856163pjb.28.1713531796665;
        Fri, 19 Apr 2024 06:03:16 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id z17-20020a17090a541100b002a2979a8651sm3074774pjh.54.2024.04.19.06.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 06:03:16 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
Date: Fri, 19 Apr 2024 22:03:12 +0900
Message-Id: <20240419130312.11392-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000004a86bf0616571fc7@google.com>
References: <0000000000004a86bf0616571fc7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


please test uninit-value in hsr_get_node

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 0963689a5950..847233e8f3e6 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2920,7 +2920,7 @@ bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp)
 		/* Avoid direct reclaim but allow kswapd to wake */
 		pfrag->page = alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
 					  __GFP_COMP | __GFP_NOWARN |
-					  __GFP_NORETRY,
+					  __GFP_NORETRY | __GFP_ZERO,
 					  SKB_FRAG_PAGE_ORDER);
 		if (likely(pfrag->page)) {
 			pfrag->size = PAGE_SIZE << SKB_FRAG_PAGE_ORDER;
-- 
2.34.1


