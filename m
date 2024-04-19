Return-Path: <linux-kernel+bounces-151939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC7E8AB60E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB3ADB22567
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6916C15E90;
	Fri, 19 Apr 2024 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FHGa/hhi"
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553D3232;
	Fri, 19 Apr 2024 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713559203; cv=none; b=jxUc65iGH1bSDVMDie+wK/qP+mM+Knfn3JoEmt7xchAe9l9pZe+idhtfO1Mqi03P/NHcRAIom/gjrZWl+IbN3pV1b2q7He/8u2PTBSiYp86uk9wzWIbxdj87a++Y34JqzyW8A49DRhqx0P02kk27geRsZKyOwhIP1d5ORUNGQJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713559203; c=relaxed/simple;
	bh=daj69iQuPmHlidj57wnECNVMqOAzumWf8ig+6xOnVlk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G7ixomxWIBAK0RoItfZvyCo42gogSMAfTE1kOsdtHkhci8EegNpfXvfuZdYxn91oWGmdAk6/ImDLAJIT96CYeKvsUvAjo+uxv/EsWyZJ2MKd3P9Cg3X1Va5UjdbAAaofClQAuN8tMGnO1hoeQUJEH/35Fde1wg186Z06TPrQ3X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FHGa/hhi; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713559202; x=1745095202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IRuBkaMcszXg+KTdvnEUlTUzHHfrN+PqN5MSTK6YgWM=;
  b=FHGa/hhiDRMTtdjL9Og9qb9Hvg8QRZ75EEr0FKx75JySEegqDVgjYcxE
   HusD6VPgFxqJpFANH35TMUzBIAJV+mhhLWzcFbhr7L2vY/WhuaWui2Dvf
   HKqxfF01yLouKvvR66qDvufZcrq0QYmx0GSMUrnT86ZYXsDPQDH0DQ4bf
   k=;
X-IronPort-AV: E=Sophos;i="6.07,214,1708387200"; 
   d="scan'208";a="401460617"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 20:39:58 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:36091]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.238:2525] with esmtp (Farcaster)
 id 8d75b2de-2a2e-4d6e-9655-a255832ceedf; Fri, 19 Apr 2024 20:39:57 +0000 (UTC)
X-Farcaster-Flow-ID: 8d75b2de-2a2e-4d6e-9655-a255832ceedf
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 19 Apr 2024 20:39:57 +0000
Received: from 88665a182662.ant.amazon.com (10.119.231.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 19 Apr 2024 20:39:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+f3f3eef1d2100200e593@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_del_edges
Date: Fri, 19 Apr 2024 13:39:45 -0700
Message-ID: <20240419203945.2526-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <000000000000c1fa0506166fdcfe@google.com>
References: <000000000000c1fa0506166fdcfe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+f3f3eef1d2100200e593@syzkaller.appspotmail.com>
Date: Fri, 19 Apr 2024 02:39:21 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7b4f2bc91c15 Add linux-next specific files for 20240418
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14a54a53180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ae644165a243bf62
> dashboard link: https://syzkaller.appspot.com/bug?extid=f3f3eef1d2100200e593
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155e53af180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128b1d53180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/524a18e6c5be/disk-7b4f2bc9.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/029f1b84d653/vmlinux-7b4f2bc9.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c02d1542e886/bzImage-7b4f2bc9.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f3f3eef1d2100200e593@syzkaller.appspotmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 95240a59808f..039c1c8c73f4 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -158,11 +158,14 @@ static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 	unix_update_graph(unix_edge_successor(edge));
 }
 
+static bool gc_in_progress;
+
 static void unix_del_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 {
 	struct unix_vertex *vertex = edge->predecessor->vertex;
 
-	unix_update_graph(unix_edge_successor(edge));
+	if (!gc_in_progress)
+		unix_update_graph(unix_edge_successor(edge));
 
 	list_del(&edge->vertex_entry);
 	vertex->out_degree--;
@@ -237,8 +240,10 @@ void unix_del_edges(struct scm_fp_list *fpl)
 		unix_del_edge(fpl, edge);
 	} while (i < fpl->count_unix);
 
-	receiver = fpl->edges[0].successor;
-	receiver->scm_stat.nr_unix_fds -= fpl->count_unix;
+	if (!gc_in_progress) {
+		receiver = fpl->edges[0].successor;
+		receiver->scm_stat.nr_unix_fds -= fpl->count_unix;
+	}
 	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - fpl->count_unix);
 out:
 	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight - fpl->count);
@@ -550,8 +555,6 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 }
 
-static bool gc_in_progress;
-
 static void __unix_gc(struct work_struct *work)
 {
 	struct sk_buff_head hitlist;

