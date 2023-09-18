Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1B97A527E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjIRTAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjIRTAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:00:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EFD112
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:00:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401f68602a8so53723275e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1695063638; x=1695668438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VhhXQh1VSYkWvLPjMcGp3/n9sUT+nXlNQcPt8UlXZY=;
        b=DmHe7CZ45UyrhU1811C1Dr0bUUk34t4pmh1o0ONz5jy/7Ow4xR9C8bI8an0JhXpYq/
         3qvrKKUvxcyw60mLWYMqI2HkFPYiuQia9RCf7egrkGnzOauEcyV/l6iL7f3XXUE5paay
         TSCcdpyqeew2mlUuh28TrET+IKgZq9pu8hpcBCxO3+qz2wK5bXH6sq8UThasFzYe1udp
         ZgBvsa/2gCyaVu/PdFKXIrYiirEgpHezTZaC206LCQQWNn5/bfsayF429TipsKgLFL+0
         oqwEQgNZkIo8C1cta/9VGY2Zb0Vtd8qHMn1uVbpfz5DbXh8IK3S4v9lpZVhTdl8bv2zT
         9ZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695063638; x=1695668438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VhhXQh1VSYkWvLPjMcGp3/n9sUT+nXlNQcPt8UlXZY=;
        b=N8KIw9HhmcQZ190tDVCzqZvZtze3r5QGBf/mW1DwSNmfFYpGt7lNAY8vzD/f0YsVNQ
         iOjQ6Fro6PmKarnyIzvDbRVFTCvLd+Wi0Ebj8rLFgfOpSpXNaAAP+ooNW2Ey6gxFNb8i
         H/wQTOi1Rbw2eV4qYiNWSpJgoV3DcH6GTV3+ZEW6i3UfXCJYyey3dXelme8XfVP8pPMy
         2grHX882smVsXuKZUv1s56seaGDYLVzBdz5M8oJoCs7GXT/Cvf68gJTUCm1QL//OlXLa
         MMihNE8f4wwLuh6414/XeUhOqQBmIVEt1JXBBRY1rJNWnJg1yQl6rlB6wtD+ZTBWNFro
         v9Xw==
X-Gm-Message-State: AOJu0Yx7YkfdOSYLFjuJGkZLp78eZ/Sj+H3kSLy/+9qOzdLVdTEpYlPb
        CZR/onWBtOzXpBWFYO5RC0OJ+Q==
X-Google-Smtp-Source: AGHT+IH7hXWlvkzn79v7gMtqhh7m+iDnodbQ6IXC2HFxwmTztQmTXvN7JCXmxbVGlZDim/e8NelaRw==
X-Received: by 2002:a7b:c4cc:0:b0:402:f8eb:28d8 with SMTP id g12-20020a7bc4cc000000b00402f8eb28d8mr8398760wmk.6.1695063637549;
        Mon, 18 Sep 2023 12:00:37 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c3b8900b004047ac770d1sm10762707wms.8.2023.09.18.12.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 12:00:36 -0700 (PDT)
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
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org,
        Steen Hegelund <Steen.Hegelund@microchip.com>
Subject: [PATCH v12 net-next 01/23] net/tcp: Prepare tcp_md5sig_pool for TCP-AO
Date:   Mon, 18 Sep 2023 19:59:59 +0100
Message-ID: <20230918190027.613430-2-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918190027.613430-1-dima@arista.com>
References: <20230918190027.613430-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCP-AO, similarly to TCP-MD5, needs to allocate tfms on a slow-path,
which is setsockopt() and use crypto ahash requests on fast paths,
which are RX/TX softirqs. Also, it needs a temporary/scratch buffer
for preparing the hash.

Rework tcp_md5sig_pool in order to support other hashing algorithms
than MD5. It will make it possible to share pre-allocated crypto_ahash
descriptors and scratch area between all TCP hash users.

Internally tcp_sigpool calls crypto_clone_ahash() API over pre-allocated
crypto ahash tfm. Kudos to Herbert, who provided this new crypto API.

I was a little concerned over GFP_ATOMIC allocations of ahash and
crypto_request in RX/TX (see tcp_sigpool_start()), so I benchmarked both
"backends" with different algorithms, using patched version of iperf3[2].
On my laptop with i7-7600U @ 2.80GHz:

                         clone-tfm                per-CPU-requests
TCP-MD5                  2.25 Gbits/sec           2.30 Gbits/sec
TCP-AO(hmac(sha1))       2.53 Gbits/sec           2.54 Gbits/sec
TCP-AO(hmac(sha512))     1.67 Gbits/sec           1.64 Gbits/sec
TCP-AO(hmac(sha384))     1.77 Gbits/sec           1.80 Gbits/sec
TCP-AO(hmac(sha224))     1.29 Gbits/sec           1.30 Gbits/sec
TCP-AO(hmac(sha3-512))    481 Mbits/sec            480 Mbits/sec
TCP-AO(hmac(md5))        2.07 Gbits/sec           2.12 Gbits/sec
TCP-AO(hmac(rmd160))     1.01 Gbits/sec            995 Mbits/sec
TCP-AO(cmac(aes128))     [not supporetd yet]      2.11 Gbits/sec

So, it seems that my concerns don't have strong grounds and per-CPU
crypto_request allocation can be dropped/removed from tcp_sigpool once
ciphers get crypto_clone_ahash() support.

[1]: https://lore.kernel.org/all/ZDefxOq6Ax0JeTRH@gondor.apana.org.au/T/#u
[2]: https://github.com/0x7f454c46/iperf/tree/tcp-md5-ao
Signed-off-by: Dmitry Safonov <dima@arista.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/net/tcp.h        |  50 ++++--
 net/ipv4/Kconfig         |   4 +
 net/ipv4/Makefile        |   1 +
 net/ipv4/tcp.c           | 145 +++-------------
 net/ipv4/tcp_ipv4.c      |  97 ++++++-----
 net/ipv4/tcp_minisocks.c |  21 ++-
 net/ipv4/tcp_sigpool.c   | 358 +++++++++++++++++++++++++++++++++++++++
 net/ipv6/tcp_ipv6.c      |  60 +++----
 8 files changed, 525 insertions(+), 211 deletions(-)
 create mode 100644 net/ipv4/tcp_sigpool.c

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 91688d0dadcd..cb8fadde8c5c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1699,12 +1699,39 @@ union tcp_md5sum_block {
 #endif
 };
 
-/* - pool: digest algorithm, hash description and scratch buffer */
-struct tcp_md5sig_pool {
-	struct ahash_request	*md5_req;
-	void			*scratch;
+/*
+ * struct tcp_sigpool - per-CPU pool of ahash_requests
+ * @scratch: per-CPU temporary area, that can be used between
+ *	     tcp_sigpool_start() and tcp_sigpool_end() to perform
+ *	     crypto request
+ * @req: pre-allocated ahash request
+ */
+struct tcp_sigpool {
+	void *scratch;
+	struct ahash_request *req;
 };
 
+int tcp_sigpool_alloc_ahash(const char *alg, size_t scratch_size);
+void tcp_sigpool_get(unsigned int id);
+void tcp_sigpool_release(unsigned int id);
+int tcp_sigpool_hash_skb_data(struct tcp_sigpool *hp,
+			      const struct sk_buff *skb,
+			      unsigned int header_len);
+
+/**
+ * tcp_sigpool_start - disable bh and start using tcp_sigpool_ahash
+ * @id: tcp_sigpool that was previously allocated by tcp_sigpool_alloc_ahash()
+ * @c: returned tcp_sigpool for usage (uninitialized on failure)
+ *
+ * Returns 0 on success, error otherwise.
+ */
+int tcp_sigpool_start(unsigned int id, struct tcp_sigpool *c);
+/**
+ * tcp_sigpool_end - enable bh and stop using tcp_sigpool
+ * @c: tcp_sigpool context that was returned by tcp_sigpool_start()
+ */
+void tcp_sigpool_end(struct tcp_sigpool *c);
+size_t tcp_sigpool_algo(unsigned int id, char *buf, size_t buf_len);
 /* - functions */
 int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
 			const struct sock *sk, const struct sk_buff *skb);
@@ -1760,17 +1787,12 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 #define tcp_twsk_md5_key(twsk)	NULL
 #endif
 
-bool tcp_alloc_md5sig_pool(void);
+int tcp_md5_alloc_sigpool(void);
+void tcp_md5_release_sigpool(void);
+void tcp_md5_add_sigpool(void);
+extern int tcp_md5_sigpool_id;
 
-struct tcp_md5sig_pool *tcp_get_md5sig_pool(void);
-static inline void tcp_put_md5sig_pool(void)
-{
-	local_bh_enable();
-}
-
-int tcp_md5_hash_skb_data(struct tcp_md5sig_pool *, const struct sk_buff *,
-			  unsigned int header_len);
-int tcp_md5_hash_key(struct tcp_md5sig_pool *hp,
+int tcp_md5_hash_key(struct tcp_sigpool *hp,
 		     const struct tcp_md5sig_key *key);
 
 /* From tcp_fastopen.c */
diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 2dfb12230f08..89e2ab023272 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -741,10 +741,14 @@ config DEFAULT_TCP_CONG
 	default "bbr" if DEFAULT_BBR
 	default "cubic"
 
+config TCP_SIGPOOL
+	tristate
+
 config TCP_MD5SIG
 	bool "TCP: MD5 Signature Option support (RFC2385)"
 	select CRYPTO
 	select CRYPTO_MD5
+	select TCP_SIGPOOL
 	help
 	  RFC2385 specifies a method of giving MD5 protection to TCP sessions.
 	  Its main (only?) use is to protect BGP sessions between core routers
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index b18ba8ef93ad..cd760793cfcb 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_TCP_CONG_SCALABLE) += tcp_scalable.o
 obj-$(CONFIG_TCP_CONG_LP) += tcp_lp.o
 obj-$(CONFIG_TCP_CONG_YEAH) += tcp_yeah.o
 obj-$(CONFIG_TCP_CONG_ILLINOIS) += tcp_illinois.o
+obj-$(CONFIG_TCP_SIGPOOL) += tcp_sigpool.o
 obj-$(CONFIG_NET_SOCK_MSG) += tcp_bpf.o
 obj-$(CONFIG_BPF_SYSCALL) += udp_bpf.o
 obj-$(CONFIG_NETLABEL) += cipso_ipv4.o
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 69b8d7073708..a8ece0eb563b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4298,141 +4298,52 @@ int tcp_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
 EXPORT_SYMBOL(tcp_getsockopt);
 
 #ifdef CONFIG_TCP_MD5SIG
-static DEFINE_PER_CPU(struct tcp_md5sig_pool, tcp_md5sig_pool);
-static DEFINE_MUTEX(tcp_md5sig_mutex);
-static bool tcp_md5sig_pool_populated = false;
+int tcp_md5_sigpool_id = -1;
+EXPORT_SYMBOL_GPL(tcp_md5_sigpool_id);
 
-static void __tcp_alloc_md5sig_pool(void)
+int tcp_md5_alloc_sigpool(void)
 {
-	struct crypto_ahash *hash;
-	int cpu;
+	size_t scratch_size;
+	int ret;
 
-	hash = crypto_alloc_ahash("md5", 0, CRYPTO_ALG_ASYNC);
-	if (IS_ERR(hash))
-		return;
-
-	for_each_possible_cpu(cpu) {
-		void *scratch = per_cpu(tcp_md5sig_pool, cpu).scratch;
-		struct ahash_request *req;
-
-		if (!scratch) {
-			scratch = kmalloc_node(sizeof(union tcp_md5sum_block) +
-					       sizeof(struct tcphdr),
-					       GFP_KERNEL,
-					       cpu_to_node(cpu));
-			if (!scratch)
-				return;
-			per_cpu(tcp_md5sig_pool, cpu).scratch = scratch;
-		}
-		if (per_cpu(tcp_md5sig_pool, cpu).md5_req)
-			continue;
-
-		req = ahash_request_alloc(hash, GFP_KERNEL);
-		if (!req)
-			return;
-
-		ahash_request_set_callback(req, 0, NULL, NULL);
-
-		per_cpu(tcp_md5sig_pool, cpu).md5_req = req;
+	scratch_size = sizeof(union tcp_md5sum_block) + sizeof(struct tcphdr);
+	ret = tcp_sigpool_alloc_ahash("md5", scratch_size);
+	if (ret >= 0) {
+		/* As long as any md5 sigpool was allocated, the return
+		 * id would stay the same. Re-write the id only for the case
+		 * when previously all MD5 keys were deleted and this call
+		 * allocates the first MD5 key, which may return a different
+		 * sigpool id than was used previously.
+		 */
+		WRITE_ONCE(tcp_md5_sigpool_id, ret); /* Avoids the compiler potentially being smart here */
+		return 0;
 	}
-	/* before setting tcp_md5sig_pool_populated, we must commit all writes
-	 * to memory. See smp_rmb() in tcp_get_md5sig_pool()
-	 */
-	smp_wmb();
-	/* Paired with READ_ONCE() from tcp_alloc_md5sig_pool()
-	 * and tcp_get_md5sig_pool().
-	*/
-	WRITE_ONCE(tcp_md5sig_pool_populated, true);
+	return ret;
 }
 
-bool tcp_alloc_md5sig_pool(void)
+void tcp_md5_release_sigpool(void)
 {
-	/* Paired with WRITE_ONCE() from __tcp_alloc_md5sig_pool() */
-	if (unlikely(!READ_ONCE(tcp_md5sig_pool_populated))) {
-		mutex_lock(&tcp_md5sig_mutex);
-
-		if (!tcp_md5sig_pool_populated)
-			__tcp_alloc_md5sig_pool();
-
-		mutex_unlock(&tcp_md5sig_mutex);
-	}
-	/* Paired with WRITE_ONCE() from __tcp_alloc_md5sig_pool() */
-	return READ_ONCE(tcp_md5sig_pool_populated);
+	tcp_sigpool_release(READ_ONCE(tcp_md5_sigpool_id));
 }
-EXPORT_SYMBOL(tcp_alloc_md5sig_pool);
 
-
-/**
- *	tcp_get_md5sig_pool - get md5sig_pool for this user
- *
- *	We use percpu structure, so if we succeed, we exit with preemption
- *	and BH disabled, to make sure another thread or softirq handling
- *	wont try to get same context.
- */
-struct tcp_md5sig_pool *tcp_get_md5sig_pool(void)
+void tcp_md5_add_sigpool(void)
 {
-	local_bh_disable();
-
-	/* Paired with WRITE_ONCE() from __tcp_alloc_md5sig_pool() */
-	if (READ_ONCE(tcp_md5sig_pool_populated)) {
-		/* coupled with smp_wmb() in __tcp_alloc_md5sig_pool() */
-		smp_rmb();
-		return this_cpu_ptr(&tcp_md5sig_pool);
-	}
-	local_bh_enable();
-	return NULL;
+	tcp_sigpool_get(READ_ONCE(tcp_md5_sigpool_id));
 }
-EXPORT_SYMBOL(tcp_get_md5sig_pool);
 
-int tcp_md5_hash_skb_data(struct tcp_md5sig_pool *hp,
-			  const struct sk_buff *skb, unsigned int header_len)
-{
-	struct scatterlist sg;
-	const struct tcphdr *tp = tcp_hdr(skb);
-	struct ahash_request *req = hp->md5_req;
-	unsigned int i;
-	const unsigned int head_data_len = skb_headlen(skb) > header_len ?
-					   skb_headlen(skb) - header_len : 0;
-	const struct skb_shared_info *shi = skb_shinfo(skb);
-	struct sk_buff *frag_iter;
-
-	sg_init_table(&sg, 1);
-
-	sg_set_buf(&sg, ((u8 *) tp) + header_len, head_data_len);
-	ahash_request_set_crypt(req, &sg, NULL, head_data_len);
-	if (crypto_ahash_update(req))
-		return 1;
-
-	for (i = 0; i < shi->nr_frags; ++i) {
-		const skb_frag_t *f = &shi->frags[i];
-		unsigned int offset = skb_frag_off(f);
-		struct page *page = skb_frag_page(f) + (offset >> PAGE_SHIFT);
-
-		sg_set_page(&sg, page, skb_frag_size(f),
-			    offset_in_page(offset));
-		ahash_request_set_crypt(req, &sg, NULL, skb_frag_size(f));
-		if (crypto_ahash_update(req))
-			return 1;
-	}
-
-	skb_walk_frags(skb, frag_iter)
-		if (tcp_md5_hash_skb_data(hp, frag_iter, 0))
-			return 1;
-
-	return 0;
-}
-EXPORT_SYMBOL(tcp_md5_hash_skb_data);
-
-int tcp_md5_hash_key(struct tcp_md5sig_pool *hp, const struct tcp_md5sig_key *key)
+int tcp_md5_hash_key(struct tcp_sigpool *hp,
+		     const struct tcp_md5sig_key *key)
 {
 	u8 keylen = READ_ONCE(key->keylen); /* paired with WRITE_ONCE() in tcp_md5_do_add */
 	struct scatterlist sg;
 
 	sg_init_one(&sg, key->key, keylen);
-	ahash_request_set_crypt(hp->md5_req, &sg, NULL, keylen);
+	ahash_request_set_crypt(hp->req, &sg, NULL, keylen);
 
-	/* We use data_race() because tcp_md5_do_add() might change key->key under us */
-	return data_race(crypto_ahash_update(hp->md5_req));
+	/* We use data_race() because tcp_md5_do_add() might change
+	 * key->key under us
+	 */
+	return data_race(crypto_ahash_update(hp->req));
 }
 EXPORT_SYMBOL(tcp_md5_hash_key);
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f13eb7e23d03..6786b963b25f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1219,10 +1219,6 @@ static int __tcp_md5_do_add(struct sock *sk, const union tcp_md5_addr *addr,
 	key = sock_kmalloc(sk, sizeof(*key), gfp | __GFP_ZERO);
 	if (!key)
 		return -ENOMEM;
-	if (!tcp_alloc_md5sig_pool()) {
-		sock_kfree_s(sk, key, sizeof(*key));
-		return -ENOMEM;
-	}
 
 	memcpy(key->key, newkey, newkeylen);
 	key->keylen = newkeylen;
@@ -1244,15 +1240,21 @@ int tcp_md5_do_add(struct sock *sk, const union tcp_md5_addr *addr,
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	if (!rcu_dereference_protected(tp->md5sig_info, lockdep_sock_is_held(sk))) {
-		if (tcp_md5sig_info_add(sk, GFP_KERNEL))
+		if (tcp_md5_alloc_sigpool())
 			return -ENOMEM;
 
+		if (tcp_md5sig_info_add(sk, GFP_KERNEL)) {
+			tcp_md5_release_sigpool();
+			return -ENOMEM;
+		}
+
 		if (!static_branch_inc(&tcp_md5_needed.key)) {
 			struct tcp_md5sig_info *md5sig;
 
 			md5sig = rcu_dereference_protected(tp->md5sig_info, lockdep_sock_is_held(sk));
 			rcu_assign_pointer(tp->md5sig_info, NULL);
 			kfree_rcu(md5sig, rcu);
+			tcp_md5_release_sigpool();
 			return -EUSERS;
 		}
 	}
@@ -1269,8 +1271,12 @@ int tcp_md5_key_copy(struct sock *sk, const union tcp_md5_addr *addr,
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	if (!rcu_dereference_protected(tp->md5sig_info, lockdep_sock_is_held(sk))) {
-		if (tcp_md5sig_info_add(sk, sk_gfp_mask(sk, GFP_ATOMIC)))
+		tcp_md5_add_sigpool();
+
+		if (tcp_md5sig_info_add(sk, sk_gfp_mask(sk, GFP_ATOMIC))) {
+			tcp_md5_release_sigpool();
 			return -ENOMEM;
+		}
 
 		if (!static_key_fast_inc_not_disabled(&tcp_md5_needed.key.key)) {
 			struct tcp_md5sig_info *md5sig;
@@ -1279,6 +1285,7 @@ int tcp_md5_key_copy(struct sock *sk, const union tcp_md5_addr *addr,
 			net_warn_ratelimited("Too many TCP-MD5 keys in the system\n");
 			rcu_assign_pointer(tp->md5sig_info, NULL);
 			kfree_rcu(md5sig, rcu);
+			tcp_md5_release_sigpool();
 			return -EUSERS;
 		}
 	}
@@ -1378,7 +1385,7 @@ static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
 			      cmd.tcpm_key, cmd.tcpm_keylen);
 }
 
-static int tcp_v4_md5_hash_headers(struct tcp_md5sig_pool *hp,
+static int tcp_v4_md5_hash_headers(struct tcp_sigpool *hp,
 				   __be32 daddr, __be32 saddr,
 				   const struct tcphdr *th, int nbytes)
 {
@@ -1398,38 +1405,35 @@ static int tcp_v4_md5_hash_headers(struct tcp_md5sig_pool *hp,
 	_th->check = 0;
 
 	sg_init_one(&sg, bp, sizeof(*bp) + sizeof(*th));
-	ahash_request_set_crypt(hp->md5_req, &sg, NULL,
+	ahash_request_set_crypt(hp->req, &sg, NULL,
 				sizeof(*bp) + sizeof(*th));
-	return crypto_ahash_update(hp->md5_req);
+	return crypto_ahash_update(hp->req);
 }
 
 static int tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_key *key,
 			       __be32 daddr, __be32 saddr, const struct tcphdr *th)
 {
-	struct tcp_md5sig_pool *hp;
-	struct ahash_request *req;
+	struct tcp_sigpool hp;
 
-	hp = tcp_get_md5sig_pool();
-	if (!hp)
-		goto clear_hash_noput;
-	req = hp->md5_req;
+	if (tcp_sigpool_start(tcp_md5_sigpool_id, &hp))
+		goto clear_hash_nostart;
 
-	if (crypto_ahash_init(req))
+	if (crypto_ahash_init(hp.req))
 		goto clear_hash;
-	if (tcp_v4_md5_hash_headers(hp, daddr, saddr, th, th->doff << 2))
+	if (tcp_v4_md5_hash_headers(&hp, daddr, saddr, th, th->doff << 2))
 		goto clear_hash;
-	if (tcp_md5_hash_key(hp, key))
+	if (tcp_md5_hash_key(&hp, key))
 		goto clear_hash;
-	ahash_request_set_crypt(req, NULL, md5_hash, 0);
-	if (crypto_ahash_final(req))
+	ahash_request_set_crypt(hp.req, NULL, md5_hash, 0);
+	if (crypto_ahash_final(hp.req))
 		goto clear_hash;
 
-	tcp_put_md5sig_pool();
+	tcp_sigpool_end(&hp);
 	return 0;
 
 clear_hash:
-	tcp_put_md5sig_pool();
-clear_hash_noput:
+	tcp_sigpool_end(&hp);
+clear_hash_nostart:
 	memset(md5_hash, 0, 16);
 	return 1;
 }
@@ -1438,9 +1442,8 @@ int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
 			const struct sock *sk,
 			const struct sk_buff *skb)
 {
-	struct tcp_md5sig_pool *hp;
-	struct ahash_request *req;
 	const struct tcphdr *th = tcp_hdr(skb);
+	struct tcp_sigpool hp;
 	__be32 saddr, daddr;
 
 	if (sk) { /* valid for establish/request sockets */
@@ -1452,30 +1455,28 @@ int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
 		daddr = iph->daddr;
 	}
 
-	hp = tcp_get_md5sig_pool();
-	if (!hp)
-		goto clear_hash_noput;
-	req = hp->md5_req;
+	if (tcp_sigpool_start(tcp_md5_sigpool_id, &hp))
+		goto clear_hash_nostart;
 
-	if (crypto_ahash_init(req))
+	if (crypto_ahash_init(hp.req))
 		goto clear_hash;
 
-	if (tcp_v4_md5_hash_headers(hp, daddr, saddr, th, skb->len))
+	if (tcp_v4_md5_hash_headers(&hp, daddr, saddr, th, skb->len))
 		goto clear_hash;
-	if (tcp_md5_hash_skb_data(hp, skb, th->doff << 2))
+	if (tcp_sigpool_hash_skb_data(&hp, skb, th->doff << 2))
 		goto clear_hash;
-	if (tcp_md5_hash_key(hp, key))
+	if (tcp_md5_hash_key(&hp, key))
 		goto clear_hash;
-	ahash_request_set_crypt(req, NULL, md5_hash, 0);
-	if (crypto_ahash_final(req))
+	ahash_request_set_crypt(hp.req, NULL, md5_hash, 0);
+	if (crypto_ahash_final(hp.req))
 		goto clear_hash;
 
-	tcp_put_md5sig_pool();
+	tcp_sigpool_end(&hp);
 	return 0;
 
 clear_hash:
-	tcp_put_md5sig_pool();
-clear_hash_noput:
+	tcp_sigpool_end(&hp);
+clear_hash_nostart:
 	memset(md5_hash, 0, 16);
 	return 1;
 }
@@ -2293,6 +2294,18 @@ static int tcp_v4_init_sock(struct sock *sk)
 	return 0;
 }
 
+#ifdef CONFIG_TCP_MD5SIG
+static void tcp_md5sig_info_free_rcu(struct rcu_head *head)
+{
+	struct tcp_md5sig_info *md5sig;
+
+	md5sig = container_of(head, struct tcp_md5sig_info, rcu);
+	kfree(md5sig);
+	static_branch_slow_dec_deferred(&tcp_md5_needed);
+	tcp_md5_release_sigpool();
+}
+#endif
+
 void tcp_v4_destroy_sock(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -2317,10 +2330,12 @@ void tcp_v4_destroy_sock(struct sock *sk)
 #ifdef CONFIG_TCP_MD5SIG
 	/* Clean up the MD5 key list, if any */
 	if (tp->md5sig_info) {
+		struct tcp_md5sig_info *md5sig;
+
+		md5sig = rcu_dereference_protected(tp->md5sig_info, 1);
 		tcp_clear_md5_list(sk);
-		kfree_rcu(rcu_dereference_protected(tp->md5sig_info, 1), rcu);
-		tp->md5sig_info = NULL;
-		static_branch_slow_dec_deferred(&tcp_md5_needed);
+		call_rcu(&md5sig->rcu, tcp_md5sig_info_free_rcu);
+		rcu_assign_pointer(tp->md5sig_info, NULL);
 	}
 #endif
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index eee8ab1bfa0e..764181bef72f 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -261,10 +261,9 @@ static void tcp_time_wait_init(struct sock *sk, struct tcp_timewait_sock *tcptw)
 		tcptw->tw_md5_key = kmemdup(key, sizeof(*key), GFP_ATOMIC);
 		if (!tcptw->tw_md5_key)
 			return;
-		if (!tcp_alloc_md5sig_pool())
-			goto out_free;
 		if (!static_key_fast_inc_not_disabled(&tcp_md5_needed.key.key))
 			goto out_free;
+		tcp_md5_add_sigpool();
 	}
 	return;
 out_free:
@@ -348,16 +347,26 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 }
 EXPORT_SYMBOL(tcp_time_wait);
 
+#ifdef CONFIG_TCP_MD5SIG
+static void tcp_md5_twsk_free_rcu(struct rcu_head *head)
+{
+	struct tcp_md5sig_key *key;
+
+	key = container_of(head, struct tcp_md5sig_key, rcu);
+	kfree(key);
+	static_branch_slow_dec_deferred(&tcp_md5_needed);
+	tcp_md5_release_sigpool();
+}
+#endif
+
 void tcp_twsk_destructor(struct sock *sk)
 {
 #ifdef CONFIG_TCP_MD5SIG
 	if (static_branch_unlikely(&tcp_md5_needed.key)) {
 		struct tcp_timewait_sock *twsk = tcp_twsk(sk);
 
-		if (twsk->tw_md5_key) {
-			kfree_rcu(twsk->tw_md5_key, rcu);
-			static_branch_slow_dec_deferred(&tcp_md5_needed);
-		}
+		if (twsk->tw_md5_key)
+			call_rcu(&twsk->tw_md5_key->rcu, tcp_md5_twsk_free_rcu);
 	}
 #endif
 }
diff --git a/net/ipv4/tcp_sigpool.c b/net/ipv4/tcp_sigpool.c
new file mode 100644
index 000000000000..65a8eaae2fec
--- /dev/null
+++ b/net/ipv4/tcp_sigpool.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <crypto/hash.h>
+#include <linux/cpu.h>
+#include <linux/kref.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/percpu.h>
+#include <linux/workqueue.h>
+#include <net/tcp.h>
+
+static size_t __scratch_size;
+static DEFINE_PER_CPU(void __rcu *, sigpool_scratch);
+
+struct sigpool_entry {
+	struct crypto_ahash	*hash;
+	const char		*alg;
+	struct kref		kref;
+	uint16_t		needs_key:1,
+				reserved:15;
+};
+
+#define CPOOL_SIZE (PAGE_SIZE / sizeof(struct sigpool_entry))
+static struct sigpool_entry cpool[CPOOL_SIZE];
+static unsigned int cpool_populated;
+static DEFINE_MUTEX(cpool_mutex);
+
+/* Slow-path */
+struct scratches_to_free {
+	struct rcu_head rcu;
+	unsigned int cnt;
+	void *scratches[];
+};
+
+static void free_old_scratches(struct rcu_head *head)
+{
+	struct scratches_to_free *stf;
+
+	stf = container_of(head, struct scratches_to_free, rcu);
+	while (stf->cnt--)
+		kfree(stf->scratches[stf->cnt]);
+	kfree(stf);
+}
+
+/**
+ * sigpool_reserve_scratch - re-allocates scratch buffer, slow-path
+ * @size: request size for the scratch/temp buffer
+ */
+static int sigpool_reserve_scratch(size_t size)
+{
+	struct scratches_to_free *stf;
+	size_t stf_sz = struct_size(stf, scratches, num_possible_cpus());
+	int cpu, err = 0;
+
+	lockdep_assert_held(&cpool_mutex);
+	if (__scratch_size >= size)
+		return 0;
+
+	stf = kmalloc(stf_sz, GFP_KERNEL);
+	if (!stf)
+		return -ENOMEM;
+	stf->cnt = 0;
+
+	size = max(size, __scratch_size);
+	cpus_read_lock();
+	for_each_possible_cpu(cpu) {
+		void *scratch, *old_scratch;
+
+		scratch = kmalloc_node(size, GFP_KERNEL, cpu_to_node(cpu));
+		if (!scratch) {
+			err = -ENOMEM;
+			break;
+		}
+
+		old_scratch = rcu_replace_pointer(per_cpu(sigpool_scratch, cpu),
+					scratch, lockdep_is_held(&cpool_mutex));
+		if (!cpu_online(cpu) || !old_scratch) {
+			kfree(old_scratch);
+			continue;
+		}
+		stf->scratches[stf->cnt++] = old_scratch;
+	}
+	cpus_read_unlock();
+	if (!err)
+		__scratch_size = size;
+
+	call_rcu(&stf->rcu, free_old_scratches);
+	return err;
+}
+
+static void sigpool_scratch_free(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		kfree(rcu_replace_pointer(per_cpu(sigpool_scratch, cpu),
+					  NULL, lockdep_is_held(&cpool_mutex)));
+	__scratch_size = 0;
+}
+
+static int __cpool_try_clone(struct crypto_ahash *hash)
+{
+	struct crypto_ahash *tmp;
+
+	tmp = crypto_clone_ahash(hash);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+
+	crypto_free_ahash(tmp);
+	return 0;
+}
+
+static int __cpool_alloc_ahash(struct sigpool_entry *e, const char *alg)
+{
+	struct crypto_ahash *cpu0_hash;
+	int ret;
+
+	e->alg = kstrdup(alg, GFP_KERNEL);
+	if (!e->alg)
+		return -ENOMEM;
+
+	cpu0_hash = crypto_alloc_ahash(alg, 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(cpu0_hash)) {
+		ret = PTR_ERR(cpu0_hash);
+		goto out_free_alg;
+	}
+
+	e->needs_key = crypto_ahash_get_flags(cpu0_hash) & CRYPTO_TFM_NEED_KEY;
+
+	ret = __cpool_try_clone(cpu0_hash);
+	if (ret)
+		goto out_free_cpu0_hash;
+	e->hash = cpu0_hash;
+	kref_init(&e->kref);
+	return 0;
+
+out_free_cpu0_hash:
+	crypto_free_ahash(cpu0_hash);
+out_free_alg:
+	kfree(e->alg);
+	e->alg = NULL;
+	return ret;
+}
+
+/**
+ * tcp_sigpool_alloc_ahash - allocates pool for ahash requests
+ * @alg: name of async hash algorithm
+ * @scratch_size: reserve a tcp_sigpool::scratch buffer of this size
+ */
+int tcp_sigpool_alloc_ahash(const char *alg, size_t scratch_size)
+{
+	int i, ret;
+
+	/* slow-path */
+	mutex_lock(&cpool_mutex);
+	ret = sigpool_reserve_scratch(scratch_size);
+	if (ret)
+		goto out;
+	for (i = 0; i < cpool_populated; i++) {
+		if (!cpool[i].alg)
+			continue;
+		if (strcmp(cpool[i].alg, alg))
+			continue;
+
+		if (kref_read(&cpool[i].kref) > 0)
+			kref_get(&cpool[i].kref);
+		else
+			kref_init(&cpool[i].kref);
+		ret = i;
+		goto out;
+	}
+
+	for (i = 0; i < cpool_populated; i++) {
+		if (!cpool[i].alg)
+			break;
+	}
+	if (i >= CPOOL_SIZE) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	ret = __cpool_alloc_ahash(&cpool[i], alg);
+	if (!ret) {
+		ret = i;
+		if (i == cpool_populated)
+			cpool_populated++;
+	}
+out:
+	mutex_unlock(&cpool_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tcp_sigpool_alloc_ahash);
+
+static void __cpool_free_entry(struct sigpool_entry *e)
+{
+	crypto_free_ahash(e->hash);
+	kfree(e->alg);
+	memset(e, 0, sizeof(*e));
+}
+
+static void cpool_cleanup_work_cb(struct work_struct *work)
+{
+	bool free_scratch = true;
+	unsigned int i;
+
+	mutex_lock(&cpool_mutex);
+	for (i = 0; i < cpool_populated; i++) {
+		if (kref_read(&cpool[i].kref) > 0) {
+			free_scratch = false;
+			continue;
+		}
+		if (!cpool[i].alg)
+			continue;
+		__cpool_free_entry(&cpool[i]);
+	}
+	if (free_scratch)
+		sigpool_scratch_free();
+	mutex_unlock(&cpool_mutex);
+}
+
+static DECLARE_WORK(cpool_cleanup_work, cpool_cleanup_work_cb);
+static void cpool_schedule_cleanup(struct kref *kref)
+{
+	schedule_work(&cpool_cleanup_work);
+}
+
+/**
+ * tcp_sigpool_release - decreases number of users for a pool. If it was
+ * the last user of the pool, releases any memory that was consumed.
+ * @id: tcp_sigpool that was previously allocated by tcp_sigpool_alloc_ahash()
+ */
+void tcp_sigpool_release(unsigned int id)
+{
+	if (WARN_ON_ONCE(id > cpool_populated || !cpool[id].alg))
+		return;
+
+	/* slow-path */
+	kref_put(&cpool[id].kref, cpool_schedule_cleanup);
+}
+EXPORT_SYMBOL_GPL(tcp_sigpool_release);
+
+/**
+ * tcp_sigpool_get - increases number of users (refcounter) for a pool
+ * @id: tcp_sigpool that was previously allocated by tcp_sigpool_alloc_ahash()
+ */
+void tcp_sigpool_get(unsigned int id)
+{
+	if (WARN_ON_ONCE(id > cpool_populated || !cpool[id].alg))
+		return;
+	kref_get(&cpool[id].kref);
+}
+EXPORT_SYMBOL_GPL(tcp_sigpool_get);
+
+int tcp_sigpool_start(unsigned int id, struct tcp_sigpool *c) __cond_acquires(RCU_BH)
+{
+	struct crypto_ahash *hash;
+
+	rcu_read_lock_bh();
+	if (WARN_ON_ONCE(id > cpool_populated || !cpool[id].alg)) {
+		rcu_read_unlock_bh();
+		return -EINVAL;
+	}
+
+	hash = crypto_clone_ahash(cpool[id].hash);
+	if (IS_ERR(hash)) {
+		rcu_read_unlock_bh();
+		return PTR_ERR(hash);
+	}
+
+	c->req = ahash_request_alloc(hash, GFP_ATOMIC);
+	if (!c->req) {
+		crypto_free_ahash(hash);
+		rcu_read_unlock_bh();
+		return -ENOMEM;
+	}
+	ahash_request_set_callback(c->req, 0, NULL, NULL);
+
+	/* Pairs with tcp_sigpool_reserve_scratch(), scratch area is
+	 * valid (allocated) until tcp_sigpool_end().
+	 */
+	c->scratch = rcu_dereference_bh(*this_cpu_ptr(&sigpool_scratch));
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tcp_sigpool_start);
+
+void tcp_sigpool_end(struct tcp_sigpool *c) __releases(RCU_BH)
+{
+	struct crypto_ahash *hash = crypto_ahash_reqtfm(c->req);
+
+	rcu_read_unlock_bh();
+	ahash_request_free(c->req);
+	crypto_free_ahash(hash);
+}
+EXPORT_SYMBOL_GPL(tcp_sigpool_end);
+
+/**
+ * tcp_sigpool_algo - return algorithm of tcp_sigpool
+ * @id: tcp_sigpool that was previously allocated by tcp_sigpool_alloc_ahash()
+ * @buf: buffer to return name of algorithm
+ * @buf_len: size of @buf
+ */
+size_t tcp_sigpool_algo(unsigned int id, char *buf, size_t buf_len)
+{
+	if (WARN_ON_ONCE(id > cpool_populated || !cpool[id].alg))
+		return -EINVAL;
+
+	return strscpy(buf, cpool[id].alg, buf_len);
+}
+EXPORT_SYMBOL_GPL(tcp_sigpool_algo);
+
+/**
+ * tcp_sigpool_hash_skb_data - hash data in skb with initialized tcp_sigpool
+ * @hp: tcp_sigpool pointer
+ * @skb: buffer to add sign for
+ * @header_len: TCP header length for this segment
+ */
+int tcp_sigpool_hash_skb_data(struct tcp_sigpool *hp,
+			      const struct sk_buff *skb,
+			      unsigned int header_len)
+{
+	const unsigned int head_data_len = skb_headlen(skb) > header_len ?
+					   skb_headlen(skb) - header_len : 0;
+	const struct skb_shared_info *shi = skb_shinfo(skb);
+	const struct tcphdr *tp = tcp_hdr(skb);
+	struct ahash_request *req = hp->req;
+	struct sk_buff *frag_iter;
+	struct scatterlist sg;
+	unsigned int i;
+
+	sg_init_table(&sg, 1);
+
+	sg_set_buf(&sg, ((u8 *)tp) + header_len, head_data_len);
+	ahash_request_set_crypt(req, &sg, NULL, head_data_len);
+	if (crypto_ahash_update(req))
+		return 1;
+
+	for (i = 0; i < shi->nr_frags; ++i) {
+		const skb_frag_t *f = &shi->frags[i];
+		unsigned int offset = skb_frag_off(f);
+		struct page *page;
+
+		page = skb_frag_page(f) + (offset >> PAGE_SHIFT);
+		sg_set_page(&sg, page, skb_frag_size(f), offset_in_page(offset));
+		ahash_request_set_crypt(req, &sg, NULL, skb_frag_size(f));
+		if (crypto_ahash_update(req))
+			return 1;
+	}
+
+	skb_walk_frags(skb, frag_iter)
+		if (tcp_sigpool_hash_skb_data(hp, frag_iter, 0))
+			return 1;
+
+	return 0;
+}
+EXPORT_SYMBOL(tcp_sigpool_hash_skb_data);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Per-CPU pool of crypto requests");
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 94afb8d0f2d0..21e2913ece35 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -670,7 +670,7 @@ static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
 			      cmd.tcpm_key, cmd.tcpm_keylen);
 }
 
-static int tcp_v6_md5_hash_headers(struct tcp_md5sig_pool *hp,
+static int tcp_v6_md5_hash_headers(struct tcp_sigpool *hp,
 				   const struct in6_addr *daddr,
 				   const struct in6_addr *saddr,
 				   const struct tcphdr *th, int nbytes)
@@ -691,39 +691,36 @@ static int tcp_v6_md5_hash_headers(struct tcp_md5sig_pool *hp,
 	_th->check = 0;
 
 	sg_init_one(&sg, bp, sizeof(*bp) + sizeof(*th));
-	ahash_request_set_crypt(hp->md5_req, &sg, NULL,
+	ahash_request_set_crypt(hp->req, &sg, NULL,
 				sizeof(*bp) + sizeof(*th));
-	return crypto_ahash_update(hp->md5_req);
+	return crypto_ahash_update(hp->req);
 }
 
 static int tcp_v6_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_key *key,
 			       const struct in6_addr *daddr, struct in6_addr *saddr,
 			       const struct tcphdr *th)
 {
-	struct tcp_md5sig_pool *hp;
-	struct ahash_request *req;
+	struct tcp_sigpool hp;
 
-	hp = tcp_get_md5sig_pool();
-	if (!hp)
-		goto clear_hash_noput;
-	req = hp->md5_req;
+	if (tcp_sigpool_start(tcp_md5_sigpool_id, &hp))
+		goto clear_hash_nostart;
 
-	if (crypto_ahash_init(req))
+	if (crypto_ahash_init(hp.req))
 		goto clear_hash;
-	if (tcp_v6_md5_hash_headers(hp, daddr, saddr, th, th->doff << 2))
+	if (tcp_v6_md5_hash_headers(&hp, daddr, saddr, th, th->doff << 2))
 		goto clear_hash;
-	if (tcp_md5_hash_key(hp, key))
+	if (tcp_md5_hash_key(&hp, key))
 		goto clear_hash;
-	ahash_request_set_crypt(req, NULL, md5_hash, 0);
-	if (crypto_ahash_final(req))
+	ahash_request_set_crypt(hp.req, NULL, md5_hash, 0);
+	if (crypto_ahash_final(hp.req))
 		goto clear_hash;
 
-	tcp_put_md5sig_pool();
+	tcp_sigpool_end(&hp);
 	return 0;
 
 clear_hash:
-	tcp_put_md5sig_pool();
-clear_hash_noput:
+	tcp_sigpool_end(&hp);
+clear_hash_nostart:
 	memset(md5_hash, 0, 16);
 	return 1;
 }
@@ -733,10 +730,9 @@ static int tcp_v6_md5_hash_skb(char *md5_hash,
 			       const struct sock *sk,
 			       const struct sk_buff *skb)
 {
-	const struct in6_addr *saddr, *daddr;
-	struct tcp_md5sig_pool *hp;
-	struct ahash_request *req;
 	const struct tcphdr *th = tcp_hdr(skb);
+	const struct in6_addr *saddr, *daddr;
+	struct tcp_sigpool hp;
 
 	if (sk) { /* valid for establish/request sockets */
 		saddr = &sk->sk_v6_rcv_saddr;
@@ -747,30 +743,28 @@ static int tcp_v6_md5_hash_skb(char *md5_hash,
 		daddr = &ip6h->daddr;
 	}
 
-	hp = tcp_get_md5sig_pool();
-	if (!hp)
-		goto clear_hash_noput;
-	req = hp->md5_req;
+	if (tcp_sigpool_start(tcp_md5_sigpool_id, &hp))
+		goto clear_hash_nostart;
 
-	if (crypto_ahash_init(req))
+	if (crypto_ahash_init(hp.req))
 		goto clear_hash;
 
-	if (tcp_v6_md5_hash_headers(hp, daddr, saddr, th, skb->len))
+	if (tcp_v6_md5_hash_headers(&hp, daddr, saddr, th, skb->len))
 		goto clear_hash;
-	if (tcp_md5_hash_skb_data(hp, skb, th->doff << 2))
+	if (tcp_sigpool_hash_skb_data(&hp, skb, th->doff << 2))
 		goto clear_hash;
-	if (tcp_md5_hash_key(hp, key))
+	if (tcp_md5_hash_key(&hp, key))
 		goto clear_hash;
-	ahash_request_set_crypt(req, NULL, md5_hash, 0);
-	if (crypto_ahash_final(req))
+	ahash_request_set_crypt(hp.req, NULL, md5_hash, 0);
+	if (crypto_ahash_final(hp.req))
 		goto clear_hash;
 
-	tcp_put_md5sig_pool();
+	tcp_sigpool_end(&hp);
 	return 0;
 
 clear_hash:
-	tcp_put_md5sig_pool();
-clear_hash_noput:
+	tcp_sigpool_end(&hp);
+clear_hash_nostart:
 	memset(md5_hash, 0, 16);
 	return 1;
 }
-- 
2.41.0

