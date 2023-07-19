Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B1A759FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjGSU2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjGSU1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:27:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9C6273E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:27:14 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so276955e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1689798430; x=1692390430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/W9xFvX6fMqz70zcOle30rc8tQkMB+vSAf+sEu95vI=;
        b=XKt8aGB8PdiAwwcyY81ecRZPo6IrpswgA4powIO3gp8FpVR8yPbiCoq8zaRlo5TWsK
         UI0mUBm40XyVsirvoa/ju94qQMOmeZbuidXAP3VRSUjaqnebzbAzgj/voF+LQxGVWT/D
         8QFkK4lc3qB2nUrJfU8uYcKQ2LJRHQoIrcrt313iDIMbHPW6XmLAVlVwDNV44AmI10ob
         ZwtS5TLIX5vgIQtdgBuWcRZjqiimqjCjkSbMB8EBYHUajgg4gY+LJXwJIk3JTZF+ej7z
         BqM98a+jgLQ2yPFE7MCZ5v8F2+thQ8ppFYQbnZrGD6dCF6ktGTQS0fKugx4d5WAtmLsq
         fNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689798430; x=1692390430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/W9xFvX6fMqz70zcOle30rc8tQkMB+vSAf+sEu95vI=;
        b=EY2oJqShKalbo0easiuNtmpLeXGY8BPulZGvZ/dHBtO+jbWRElPx3WN/t2eQJzbcLr
         qzvSWmjR75G87wTFZ1mAthHV+tQ9PaqUnxHNdMR3IdTUorb5pdO3xRIBF8ErCRyU/5oR
         kzC9+7KHk2XKOQauZuBUA/kOkAdteE514mz+xrFa83BgLNT/yLipaHePE1zZ6PMaPY9d
         H0UFfnS+D656pk8piyJjxnYjaNn0zHCA3cyo6T2YkfBvRgto98JXWbdMYP/lu5lvb3Ld
         ++qc+e/3r2Qb5x+k1bMeupePIfZjrHlIfYerWv7OBLngnapB1jsmGb4yy4119L1Q7l21
         tBAQ==
X-Gm-Message-State: ABy/qLatQqB8JD/mM61h4HurXZQLtHeBCc1N3zwtpaEqsHC8kPVKUafT
        tKUQAjOvlPi18Cr8xKoPV76NqA==
X-Google-Smtp-Source: APBJJlHpGFgV5i4JCVzYiuIhbujJ6W5k/VvDCe07swCu7E1PRQSueJU3L2iTuhjmwx7s033XMR2tGQ==
X-Received: by 2002:a05:600c:21ca:b0:3fb:ef86:e30 with SMTP id x10-20020a05600c21ca00b003fbef860e30mr2611460wmj.10.1689798430398;
        Wed, 19 Jul 2023 13:27:10 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c234300b003fc04d13242sm2432319wmq.0.2023.07.19.13.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 13:27:10 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        "Gaillardetz, Dominik" <dgaillar@ciena.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Subject: [PATCH v8 19/23] net/tcp: Allow asynchronous delete for TCP-AO keys (MKTs)
Date:   Wed, 19 Jul 2023 21:26:24 +0100
Message-ID: <20230719202631.472019-20-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719202631.472019-1-dima@arista.com>
References: <20230719202631.472019-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete becomes very, very fast - almost free, but after setsockopt()
syscall returns, the key is still alive until next RCU grace period.
Which is fine for listen sockets as userspace needs to be aware of
setsockopt(TCP_AO) and accept() race and resolve it with verification
by getsockopt() after TCP connection was accepted.

The benchmark results (on non-loaded box, worse with more RCU work pending):
> ok 33    Worst case delete    16384 keys: min=5ms max=10ms mean=6.93904ms stddev=0.263421
> ok 34        Add a new key    16384 keys: min=1ms max=4ms mean=2.17751ms stddev=0.147564
> ok 35 Remove random-search    16384 keys: min=5ms max=10ms mean=6.50243ms stddev=0.254999
> ok 36         Remove async    16384 keys: min=0ms max=0ms mean=0.0296107ms stddev=0.0172078

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/uapi/linux/tcp.h |  3 ++-
 net/ipv4/tcp_ao.c        | 21 ++++++++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 1109093bbb24..979ff960fddb 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -383,7 +383,8 @@ struct tcp_ao_del { /* setsockopt(TCP_AO_DEL_KEY) */
 	__s32	ifindex;		/* L3 dev index for VRF */
 	__u32   set_current	:1,	/* corresponding ::current_key */
 		set_rnext	:1,	/* corresponding ::rnext */
-		reserved	:30;	/* must be 0 */
+		del_async	:1,	/* only valid for listen sockets */
+		reserved	:29;	/* must be 0 */
 	__u16	reserved2;		/* padding, must be 0 */
 	__u8	prefix;			/* peer's address prefix */
 	__u8	sndid;			/* SendID for outgoing segments */
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index faa6c5c0db28..567aa9400f7d 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1606,7 +1606,7 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 }
 
 static int tcp_ao_delete_key(struct sock *sk, struct tcp_ao_info *ao_info,
-			     struct tcp_ao_key *key,
+			     bool del_async, struct tcp_ao_key *key,
 			     struct tcp_ao_key *new_current,
 			     struct tcp_ao_key *new_rnext)
 {
@@ -1614,11 +1614,24 @@ static int tcp_ao_delete_key(struct sock *sk, struct tcp_ao_info *ao_info,
 
 	hlist_del_rcu(&key->node);
 
+	/* Support for async delete on listening sockets: as they don't
+	 * need current_key/rnext_key maintaining, we don't need to check
+	 * them and we can just free all resources in RCU fashion.
+	 */
+	if (del_async) {
+		atomic_sub(tcp_ao_sizeof_key(key), &sk->sk_omem_alloc);
+		call_rcu(&key->rcu, tcp_ao_key_free_rcu);
+		return 0;
+	}
+
 	/* At this moment another CPU could have looked this key up
 	 * while it was unlinked from the list. Wait for RCU grace period,
 	 * after which the key is off-list and can't be looked up again;
 	 * the rx path [just before RCU came] might have used it and set it
 	 * as current_key (very unlikely).
+	 * Free the key with next RCU grace period (in case it was
+	 * current_key before tcp_ao_current_rnext() might have
+	 * changed it in forced-delete).
 	 */
 	synchronize_rcu();
 	if (new_current)
@@ -1689,6 +1702,8 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 		if (!new_rnext)
 			return -ENOENT;
 	}
+	if (cmd.del_async && sk->sk_state != TCP_LISTEN)
+		return -EINVAL;
 
 	if (family == AF_INET) {
 		struct sockaddr_in *sin = (struct sockaddr_in *)&cmd.addr;
@@ -1733,8 +1748,8 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 		if (key == new_current || key == new_rnext)
 			continue;
 
-		return tcp_ao_delete_key(sk, ao_info, key,
-					  new_current, new_rnext);
+		return tcp_ao_delete_key(sk, ao_info, cmd.del_async, key,
+					 new_current, new_rnext);
 	}
 	return -ENOENT;
 }
-- 
2.41.0

