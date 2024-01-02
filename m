Return-Path: <linux-kernel+bounces-14073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E7A821799
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD481F21BA9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B75D20F8;
	Tue,  2 Jan 2024 06:11:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCB94431;
	Tue,  2 Jan 2024 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VzmJOCt_1704175877;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VzmJOCt_1704175877)
          by smtp.aliyun-inc.com;
          Tue, 02 Jan 2024 14:11:21 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	coreteam@netfilter.org,
	netfilter-devel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org
Subject: [RFC nf-next v5 0/2] netfilter: bpf: support prog update
Date: Tue,  2 Jan 2024 14:11:15 +0800
Message-Id: <1704175877-28298-1-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

This patches attempt to implements updating of progs within
bpf netfilter link, allowing user update their ebpf netfilter
prog in hot update manner.

Besides, a corresponding test case has been added to verify
whether the update works.
--
v1:
1. remove unnecessary context, access the prog directly via rcu.
2. remove synchronize_rcu(), dealloc the nf_link via kfree_rcu.
3. check the dead flag during the update.
--
v1->v2:
1. remove unnecessary nf_prog, accessing nf_link->link.prog in direct.
--
v2->v3:
1. access nf_link->link.prog via rcu_dereference_raw to avoid warning.
--
v3->v4:
1. remove mutex for link update, as it is unnecessary and can be replaced
by atomic operations.
--
v4->v5:
1. fix error retval check on cmpxhcg

D. Wythe (2):
  netfilter: bpf: support prog update
  selftests/bpf: Add netfilter link prog update test

 net/netfilter/nf_bpf_link.c                        | 50 ++++++++-----
 .../bpf/prog_tests/netfilter_link_update_prog.c    | 83 ++++++++++++++++++++++
 .../bpf/progs/test_netfilter_link_update_prog.c    | 24 +++++++
 3 files changed, 141 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/netfilter_link_update_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_netfilter_link_update_prog.c

-- 
1.8.3.1


