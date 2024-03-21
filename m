Return-Path: <linux-kernel+bounces-109519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C00881A79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445D128376E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA08EA23;
	Thu, 21 Mar 2024 00:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jWIFPPYB"
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0C5622
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 00:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710981220; cv=none; b=CBuFcTsXovzuWBxGUpsmfuXIUdzw8AQkmYWUn6ToyzxY2gFGZrvWffj5pFfNMs+BZxjyGuRBzXc4z0wkd8DFSoXXuh6PPXDp+5Y9eoze0tZzUMICbBWfcv9EAQdsLCSzU8m5Flmny0IaiWzZOZbbHPgvTfUtegUXiQuGWnIJkHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710981220; c=relaxed/simple;
	bh=icTzWMm/jZfbs4IWylSbdVlwomZNmUW+ivXpDxdP6DE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hg1t72aEKUy4riXzz1LJ8r677PMeSKfBnFOiTl7a1+96r0NbXp5hUysgCPIqW7uaUZU6Y2zPSzvqNgCYZW5Fea3MMrvdH8flvWfhX7rPT8huTLBaDBHLc2yuiNScUaa0J/bqTBc7QoMS0iTxFNjl2VDD4Pb2c49pDzIy0o2M8fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jWIFPPYB; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710981210; bh=DVW9HEeOUZYrzHnwJ3iwSm7neYClFpHDJd5HmqxBL58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jWIFPPYB+dZB+RHQEFD69paM3JtpDtAdqOAJj7xp0TSdvI/v9oS6rSPF9iAAyTl/y
	 1gfi+hOYtsrTQjz1QzbsyS6DHoW6K8x6K9ZwzitXN2oPS9A4wGAO/oIGT6ug0vmJ3n
	 Enf10OFqvOUgaB8M+Wrf7TXQUy+LFeKuyJZB+D0A=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 654B6EBB; Thu, 21 Mar 2024 08:25:20 +0800
X-QQ-mid: xmsmtpt1710980720txlhm9ymz
Message-ID: <tencent_C086D8D2CB0650C9932EECAECC0CBFE7EB06@qq.com>
X-QQ-XMAILINFO: OCYbvBDBNb9recLWAKveYWo5j8iPs0u+wBbp96GvP8BqjGodIoa/kzNr3gUxNj
	 L+dXsyDPAuotNHGlY4YkVExiFYpQ3t326N5vsZ5AmAsYyEpIgYDkvUBo4tn+7+/7Jk0yTMxLQtOI
	 u6qBxhyeyHHpRKw3DSjxzOiJBEF6J1L7zLz7eO+qigWDPBxiSYRWt0ZbjMXxnRot7kr/Nh6wZhxN
	 luGksJKkMgoRuigKS68pNhNgCaZ6OUeLkwD2GWxZFwln85Gc6+FUcxBsutB+UnC9zVADXhWp6kbC
	 wqivSRRqmEF3kL/rV+novF22CDSccPrZBCLB8MhJaM1Jn/VSFce3RX10DJ3QZTbO5vJWmPJvxjL1
	 Q1atV5pGzhISJ0FXVBYjxWXQovID67mDuyMiocZTY6tEAxlO0S+MBa/dZKj+oGcCefxsDDHNAIBt
	 AZ30mjTDzySE/oCDlsj1tZ8Mzjqk6zo9t3W3kGUQlmjqkJBqRIARV5o6mjcURoQBHgqu7mvvuN0G
	 3JIsHXPO9jJsWvlOERehpv3GAVIJTuLKYWM3Pn25wFQ87U7vfNs4kNJ55l52TlSaQJdlahlGE+cl
	 rcGd7gzRId6kpFU89Z5hkg/XuTOHu8eDBdvx+IW1DFxgX7Udl5MEzGEy9WruRZx012BeJPuYfRaB
	 qTMxkJcaWdPY8Ih4dcQSohWfQx1pCDLRQjWeFjAF+wGGoZTrwd7MR06sLE4mwg1ElH/+KmWw78ay
	 eqmhyaMCHVgvtAkT+JZQ7KJl2DJ2Uy/czPCyCJCNBW3jNABZ2/oLdQG3fnv20mHc4ETDt8MH81HN
	 XM3w9UTEDu0IxHLTS/M4X6sU1XmOxSFGt+rqubWPnPsByke69a+1CT2TCHZuorQv69O+REl9Uact
	 +1YRjdqeOJaxLlcL1/FJdoWrj85duQlIyYOn14dmarD0DGW4FJZ6YX+u7dfSAtE6j/RphGeUDMDR
	 6fhM/2+tK+9BMwBZkEsLw9LMgrcw6YTn/HDOFMuHdk79m6989Qkkq6lVrp6Pxj
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c4f4d25859c2e5859988@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in rcu_report_exp_cpu_mult
Date: Thu, 21 Mar 2024 08:25:21 +0800
X-OQ-MSGID: <20240321002520.1714012-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000dc9aca0613ec855c@google.com>
References: <000000000000dc9aca0613ec855c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test dl in rcu_report_exp_cpu_mult

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 27d733c0f65e..8a21a59eb599 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -932,11 +932,12 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 	struct bpf_shtab_bucket *bucket;
 	struct bpf_shtab_elem *elem;
 	int ret = -ENOENT;
+	unsigned long flags;
 
 	hash = sock_hash_bucket_hash(key, key_size);
 	bucket = sock_hash_select_bucket(htab, hash);
 
-	spin_lock_bh(&bucket->lock);
+	spin_lock_irqsave(&bucket->lock, flags);
 	elem = sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_size);
 	if (elem) {
 		hlist_del_rcu(&elem->node);
@@ -944,7 +945,7 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 		sock_hash_free_elem(htab, elem);
 		ret = 0;
 	}
-	spin_unlock_bh(&bucket->lock);
+	spin_unlock_irqrestore(&bucket->lock, flags);
 	return ret;
 }
 


