Return-Path: <linux-kernel+bounces-39721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B100083D558
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500831F266EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CF460899;
	Fri, 26 Jan 2024 07:51:55 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF4F12E6F;
	Fri, 26 Jan 2024 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706255515; cv=none; b=o1COZYTElVuKZO4cNJWbUklt4k6b3e0hyOTw4kUXjxCvAY7tLcK++NXKNffd5Z5vrvdj6ZaKuG/+fVzplmrNqFQuJ5BteL5hN9PKvzNx4ous0XsRmGUsQ+zXXPKWLE4HZss4YdoD0NGqbwR5nqR6qlIcUzN7iC4Obgcez2DYdIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706255515; c=relaxed/simple;
	bh=9DBU9Gswb97RBzmM1XvhxENDBjdiwrvxJeYFm2Gdu+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C5NE/G96H6CaLbLHR7dkOFTu6w54OsrQ4ow5ff3a6XzmRx0rpIjU0GJ3f1XjqIeSaZO2zbeO53AuNPXWIUYdTMP27hdVVMDAYQMhLSnEbTtm5DxFjMima57dJfg5pIYMuYyJmxjvRdTxvnhM+7GMVyNKhVlcqZ3cm50QAlwWaR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [115.200.227.226])
	by mail-app2 (Coremail) with SMTP id by_KCgDnKKiGZLNlK1TZAA--.20140S2;
	Fri, 26 Jan 2024 15:51:35 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: ipv4: fix a memleak in ip_setup_cork
Date: Fri, 26 Jan 2024 15:51:27 +0800
Message-Id: <20240126075127.2825068-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:by_KCgDnKKiGZLNlK1TZAA--.20140S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1fGF1xJr13Zw4DCw1DGFg_yoW8GFW7pF
	n0ga45JrW8Xr12gFnrtFWrZF1fKw1vyFy8urWaya4ay3Wktry5tF18KrWa9Fya9Fs7Cw1f
	Aa4ft345ur48ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
	6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

When inetdev_valid_mtu fails, cork->opt should be freed if it is
allocated in ip_setup_cork. Otherwise there could be a memleak.

Fixes: 501a90c94510 ("inet: protect against too small mtu values.")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
 net/ipv4/ip_output.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index b06f678b03a1..3215ea07d398 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1282,6 +1282,7 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 {
 	struct ip_options_rcu *opt;
 	struct rtable *rt;
+	int free_opt = 0;
 
 	rt = *rtp;
 	if (unlikely(!rt))
@@ -1297,6 +1298,7 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 					    sk->sk_allocation);
 			if (unlikely(!cork->opt))
 				return -ENOBUFS;
+			free_opt = 1;
 		}
 		memcpy(cork->opt, &opt->opt, sizeof(struct ip_options) + opt->opt.optlen);
 		cork->flags |= IPCORK_OPT;
@@ -1306,8 +1308,13 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 	cork->fragsize = ip_sk_use_pmtu(sk) ?
 			 dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
 
-	if (!inetdev_valid_mtu(cork->fragsize))
+	if (!inetdev_valid_mtu(cork->fragsize)) {
+		if (opt && free_opt) {
+			kfree(cork->opt);
+			cork->opt = NULL;
+		}
 		return -ENETUNREACH;
+	}
 
 	cork->gso_size = ipc->gso_size;
 
-- 
2.34.1


