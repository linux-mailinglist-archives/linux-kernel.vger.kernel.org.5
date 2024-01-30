Return-Path: <linux-kernel+bounces-45235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF395842D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D912869EB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFC66F08E;
	Tue, 30 Jan 2024 19:58:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ED569DF3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644684; cv=none; b=TEMm691m2y6CImV7hlMDUEwn24ZXTFcWhsfp0KVGE7z1Zgu9yUoRd0RU2EyLxmf3J8Kbadp6x0h0gNZkdPHSZejnU+djlDtzx/b58ei7e6zQktAdkPErOsga3N9vhE7j0Na3CZ2zrkMmkiSI2kibgrI6Yjw6wjWJnVbXEz7BdLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644684; c=relaxed/simple;
	bh=f/MebH2b2jSBjTB0KRrS1cd8sHlEaDxMcPziANwY62g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EazNq/Z0Oh8ekGEeBwGxjTM464tCKWiE4HqP246nfcmghK/9rV3HQCtPxX5J+rs8fmsePWNG8Yrhuj7R/XCw47wHGFMPktvQnvZNhr7eGJ1UbY6SgctexU70Yl6EB+30WhmOO3ohG6CITHlB2O6AMyXZrSrqbUSmlY7JuhZ5Wos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bf36117dfbso363237239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706644682; x=1707249482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kCTHMFnUOMNlnoeUtQoC8k4LvqVjWI0iNpgcPFc9Rrc=;
        b=D5+9q1vRh6LjXFcpVFVdFV8ksabpuYPCP01XlVlESLwGd5emmFXDvCu3u289HAMnOc
         tHaukO94UHOqSmIYZbVK0D1ScvE0kHVToAJ5JpjE3+RfwuqRgHtg4BTX/a7OdDo+kxdy
         8r30D+zXiynk+OiXlHEUbHZlgcHZCgmsDCZ8b81JNzPHKN/Q8djk2ybIgeQ0iu5ujng7
         St+ZuunljwSdUVRnWmu2guK03n/MuvCoPp4I7i7nNJ5ad5S6QNE9S4GzFYz6L9B7mPa3
         B8gHANaRGbVKu/2srOIAdC62JShjP07o+2N/Z4nC5V25yKxaDQAc2G3Yk8sSftfbjB8W
         eTIg==
X-Gm-Message-State: AOJu0YzNZxSEcmhzDQi/HA349XZe9rD9S96z1lZJRP7NNwLLHg6YVt9u
	wE4jA9rMuGRHtTTIhEvqmI1KlMhUh9bBjPI890m0RuwjE2Ub74wik2RjKEhY91aOlXNuQAFc5VP
	s/A+6SZeizKLhmHx8hp0MpwNqWWpNAy2F8ppjmFWh+DJ2BtzWixvbrUQEFA==
X-Google-Smtp-Source: AGHT+IFHngem2F0uqzT5vHiRSiu07gA8PvHRf8BQSaQVXbPvdpBRGvBtKIBScPqaoHbBUZtWzK+frQMRnixnXpRm6uygthlIrBku
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184e:b0:361:a872:157a with SMTP id
 b14-20020a056e02184e00b00361a872157amr1147213ilv.6.1706644682190; Tue, 30 Jan
 2024 11:58:02 -0800 (PST)
Date: Tue, 30 Jan 2024 11:58:02 -0800
In-Reply-To: <0000000000005315c105f1652480@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a3ba706102f2ed9@google.com>
Subject: Re: [syzbot] Test possible deadlock in rds_message_put
From: syzbot <syzbot+f9db6ff27b9bfdcfeca0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Test possible deadlock in rds_message_put
Author: allison.henderson@oracle.com

#syz test
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
c183e6c3ec34

diff --git a/net/rds/recv.c b/net/rds/recv.c
index c71b923764fd..5627f80013f8 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -425,6 +425,7 @@ static int rds_still_queued(struct rds_sock *rs,
struct rds_incoming *inc,
 	struct sock *sk = rds_rs_to_sk(rs);
 	int ret = 0;
 	unsigned long flags;
+	struct rds_incoming *to_drop = NULL;
 
 	write_lock_irqsave(&rs->rs_recv_lock, flags);
 	if (!list_empty(&inc->i_item)) {
@@ -435,11 +436,14 @@ static int rds_still_queued(struct rds_sock *rs,
struct rds_incoming *inc,
 					      -be32_to_cpu(inc-
>i_hdr.h_len),
 					      inc->i_hdr.h_dport);
 			list_del_init(&inc->i_item);
-			rds_inc_put(inc);
+			to_drop = inc;
 		}
 	}
 	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
 
+	if (to_drop)
+		rds_inc_put(to_drop);
+
 	rdsdebug("inc %p rs %p still %d dropped %d\n", inc, rs, ret,
drop);
 	return ret;
 }
@@ -758,16 +762,21 @@ void rds_clear_recv_queue(struct rds_sock *rs)
 	struct sock *sk = rds_rs_to_sk(rs);
 	struct rds_incoming *inc, *tmp;
 	unsigned long flags;
+	LIST_HEAD(to_drop);
 
 	write_lock_irqsave(&rs->rs_recv_lock, flags);
 	list_for_each_entry_safe(inc, tmp, &rs->rs_recv_queue, i_item)
{
 		rds_recv_rcvbuf_delta(rs, sk, inc->i_conn->c_lcong,
 				      -be32_to_cpu(inc->i_hdr.h_len),
 				      inc->i_hdr.h_dport);
+		list_move(&inc->i_item, &to_drop);
+	}
+	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
+
+	list_for_each_entry_safe(inc, tmp, &to_drop, i_item) {
 		list_del_init(&inc->i_item);
 		rds_inc_put(inc);
 	}
-	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
 }
 
 /*
-- 
2.34.1


