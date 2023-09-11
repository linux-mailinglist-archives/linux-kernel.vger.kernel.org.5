Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA10979C1BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbjILBis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbjILBic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:38:32 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29412485C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:30:44 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-401f68602a8so54449455e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1694471082; x=1695075882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ayM+GqClHSZi3YYuQv7vb2e3VKIXVHqsyFGh4ddchE=;
        b=jMDajqAvs4yWCbwTg6nNgPLCFrJabFtA3mp6L0ieew26xYPYWbu3Rn4uJfmO6zDu0F
         f7VYVaaanMtA1GwUR4rhXNdbbPoQPGPt8NhJ+NbntGSUSlz9uWnzR1ZgGXpptSJKBflA
         EmreduxGROIe1WCHx3XEyrW4a4yIRy2xAEYBLJFNPbRpnQ+Z8v/JvgKw43XQSyhmG/mx
         RUMOfpske+BIdp54coQMT0h2yuVXsXj3rhmx8GYbR5jGnJD4wuyjNCM9tB7uornwgLzF
         lW5NY/wM02P7WS1lmqDXGn9v5pWB2Q+DAdAxTv6RHrqBdV5whn1yfmfxS6KbWhQDQ2Gy
         yRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694471082; x=1695075882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ayM+GqClHSZi3YYuQv7vb2e3VKIXVHqsyFGh4ddchE=;
        b=tFKbqKVy35J9LcDnqDAK7O8EyMe5c8p1uc4qIVYEkiP6LYzkhMGAlul/pW0vgbtyy5
         +bFVvvDuLMjPiS2len21rowv3+Z3mkUU1Yq2BY7HN3oobx2nF3iswLLtHhOsVI9/k+fU
         ITrTCKaLC7VJmUKB+RBATm9RRh013EcMvjW//dNrWVHnQuKzz2Y3QKtusNA/buyNNGkL
         Xw22cp+OsuR5fSwk5Pk3J89nBrIVDKJRrnjXWhXb1oLPfE91Up44vQexWamfKuvGrGOh
         o+nJYYgk44ySjhVXxxSr6VMaqvPcJ7B9HIxpYf8izKHdp7srAALMSF4a/rq9J75bkH6U
         79QQ==
X-Gm-Message-State: AOJu0Yw9TlR37rItixN6AdJfN0tvVqFJ9LKo1YW/d/qHmwGC8dulukwW
        Ew3D2wGnO8QRghcYW22r6M3N3YBGGrsPDhuWqGI=
X-Google-Smtp-Source: AGHT+IHdGtKrZwS1C7NjCMTBaiAn9HXSj4fCbs0QdNYYSW0+AHlKkQpFVnHWL1U3KPhdbA11Bkb8hg==
X-Received: by 2002:a05:600c:290a:b0:402:e6a2:c8c7 with SMTP id i10-20020a05600c290a00b00402e6a2c8c7mr9718979wmd.7.1694466270134;
        Mon, 11 Sep 2023 14:04:30 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z20-20020a1c4c14000000b00402e942561fsm14261699wmf.38.2023.09.11.14.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 14:04:29 -0700 (PDT)
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
        "Nassiri, Mohammad" <mnassiri@ciena.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <simon.horman@corigine.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Subject: [PATCH v11 net-next 19/23] net/tcp: Allow asynchronous delete for TCP-AO keys (MKTs)
Date:   Mon, 11 Sep 2023 22:03:39 +0100
Message-ID: <20230911210346.301750-20-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911210346.301750-1-dima@arista.com>
References: <20230911210346.301750-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FORGED_SPF_HELO,HTML_MESSAGE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS autolearn=no autolearn_force=no
        version=3.4.6
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
Acked-by: David Ahern <dsahern@kernel.org>
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
index edb881f90075..c5bde089916d 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1577,7 +1577,7 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 }
 
 static int tcp_ao_delete_key(struct sock *sk, struct tcp_ao_info *ao_info,
-			     struct tcp_ao_key *key,
+			     bool del_async, struct tcp_ao_key *key,
 			     struct tcp_ao_key *new_current,
 			     struct tcp_ao_key *new_rnext)
 {
@@ -1585,11 +1585,24 @@ static int tcp_ao_delete_key(struct sock *sk, struct tcp_ao_info *ao_info,
 
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
@@ -1660,6 +1673,8 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 		if (!new_rnext)
 			return -ENOENT;
 	}
+	if (cmd.del_async && sk->sk_state != TCP_LISTEN)
+		return -EINVAL;
 
 	if (family == AF_INET) {
 		struct sockaddr_in *sin = (struct sockaddr_in *)&cmd.addr;
@@ -1707,8 +1722,8 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
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

