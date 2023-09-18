Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC587A527D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjIRTAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjIRTAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:00:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2278510F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:00:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3ff7d73a6feso54241655e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1695063639; x=1695668439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cM+2inDqyL/oj/+oElx/sgUCocBlmnHUy+sce+ZIcsE=;
        b=ShV8H7w1q3WJ7ikxMGg0NuhxlhRVbIBZG8bNq5dYJZQRkkDWCJP7lKekuk9K1o2atF
         bPNXcpAAcIxrJbM3uoi7CyGnwyXAkfB4A+zcRrG0W5ipbeMPoQwX1dxQ/50a7n1ksbcP
         qtIMyH1jEuxS3p8DI3u3451XOHRiXHxkPEe1SOLMkkklmvfxV+LVlC3+6qO9uMPK/N9Z
         jxG07PON8JxofDV4BDekNbip6jaL2qQ+5uSeYKnKx9Dw/i2XGRQBCQll24XQ+OdzUTIc
         zp2WnDQW81848OlqNPYH2467qmLiJh1wK3Bvm7f2ZyxYN37HLjjryjNCRqt67f9SihEp
         DWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695063639; x=1695668439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cM+2inDqyL/oj/+oElx/sgUCocBlmnHUy+sce+ZIcsE=;
        b=eTCYef12EvulQgdTiujOncM+qvK8AOwS5uCYetIXX8p8EVhuah7+yuFRhTsBCMXMui
         7CAsXwsbtvQwlj6xceuSuOzypQ7PjtA8x5soa89F0s6MdlqsiquvJicue2RfviaN7HBz
         kQqV2O5ZpA+ouLEU9ttulG4s5CBwxbuYdxlgSo0pHeKklaN7LGnUcSaSo1+KHOXNc6v+
         ZbPk4NfYVFpG4aqLRVO/H6D9jdlwWhN1PmMSQ4dUC5yz8eEHAJJFhTt/ewbb03DMAX0v
         xFuUljaKowpE41qqH2VWWAi0mVwdulUYY0zkyvYCwQ2IUWL7hRB1T2eWqR9AIzzOkaOh
         t7lA==
X-Gm-Message-State: AOJu0YwRqcqXkbcJqZsaE5TAl4jhZjWjSTyc22aaAGXLVknhbV+LZTFn
        dreqN+r9VkbU5YkTcOYHOs5bqw==
X-Google-Smtp-Source: AGHT+IHYBu2+YH8DS/+IaM0pr3rIq5YwIjxd5Sr7h7Zox18EDKTZQ6/3/beM9xEpTAdUo1cJ6W7U0Q==
X-Received: by 2002:a7b:c412:0:b0:3fe:207c:1aea with SMTP id k18-20020a7bc412000000b003fe207c1aeamr8260098wmi.23.1695063639478;
        Mon, 18 Sep 2023 12:00:39 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c3b8900b004047ac770d1sm10762707wms.8.2023.09.18.12.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 12:00:39 -0700 (PDT)
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
Subject: [PATCH v12 net-next 02/23] net/tcp: Add TCP-AO config and structures
Date:   Mon, 18 Sep 2023 20:00:00 +0100
Message-ID: <20230918190027.613430-3-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918190027.613430-1-dima@arista.com>
References: <20230918190027.613430-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new kernel config option and common structures as well as
helpers to be used by TCP-AO code.

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/linux/tcp.h      |  9 +++-
 include/net/tcp.h        |  8 +---
 include/net/tcp_ao.h     | 90 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/tcp.h |  2 +
 net/ipv4/Kconfig         | 13 ++++++
 5 files changed, 114 insertions(+), 8 deletions(-)
 create mode 100644 include/net/tcp_ao.h

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index e15452df9804..c38778b0baa0 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -445,13 +445,18 @@ struct tcp_sock {
 	bool	syn_smc;	/* SYN includes SMC */
 #endif
 
-#ifdef CONFIG_TCP_MD5SIG
-/* TCP AF-Specific parts; only used by MD5 Signature support so far */
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
+/* TCP AF-Specific parts; only used by TCP-AO/MD5 Signature support so far */
 	const struct tcp_sock_af_ops	*af_specific;
 
+#ifdef CONFIG_TCP_MD5SIG
 /* TCP MD5 Signature Option information */
 	struct tcp_md5sig_info	__rcu *md5sig_info;
 #endif
+#ifdef CONFIG_TCP_AO
+	struct tcp_ao_info	__rcu *ao_info;
+#endif
+#endif
 
 /* TCP fastopen related information */
 	struct tcp_fastopen_request *fastopen_req;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index cb8fadde8c5c..cd93b2aa88c8 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -37,6 +37,7 @@
 #include <net/snmp.h>
 #include <net/ip.h>
 #include <net/tcp_states.h>
+#include <net/tcp_ao.h>
 #include <net/inet_ecn.h>
 #include <net/dst.h>
 #include <net/mptcp.h>
@@ -1650,12 +1651,7 @@ static inline void tcp_clear_all_retrans_hints(struct tcp_sock *tp)
 	tp->retransmit_skb_hint = NULL;
 }
 
-union tcp_md5_addr {
-	struct in_addr  a4;
-#if IS_ENABLED(CONFIG_IPV6)
-	struct in6_addr	a6;
-#endif
-};
+#define tcp_md5_addr tcp_ao_addr
 
 /* - key database */
 struct tcp_md5sig_key {
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
new file mode 100644
index 000000000000..af76e1c47bea
--- /dev/null
+++ b/include/net/tcp_ao.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _TCP_AO_H
+#define _TCP_AO_H
+
+#define TCP_AO_KEY_ALIGN	1
+#define __tcp_ao_key_align __aligned(TCP_AO_KEY_ALIGN)
+
+union tcp_ao_addr {
+	struct in_addr  a4;
+#if IS_ENABLED(CONFIG_IPV6)
+	struct in6_addr	a6;
+#endif
+};
+
+struct tcp_ao_hdr {
+	u8	kind;
+	u8	length;
+	u8	keyid;
+	u8	rnext_keyid;
+};
+
+struct tcp_ao_key {
+	struct hlist_node	node;
+	union tcp_ao_addr	addr;
+	u8			key[TCP_AO_MAXKEYLEN] __tcp_ao_key_align;
+	unsigned int		tcp_sigpool_id;
+	unsigned int		digest_size;
+	u8			prefixlen;
+	u8			family;
+	u8			keylen;
+	u8			keyflags;
+	u8			sndid;
+	u8			rcvid;
+	u8			maclen;
+	struct rcu_head		rcu;
+	u8			traffic_keys[];
+};
+
+static inline u8 *rcv_other_key(struct tcp_ao_key *key)
+{
+	return key->traffic_keys;
+}
+
+static inline u8 *snd_other_key(struct tcp_ao_key *key)
+{
+	return key->traffic_keys + key->digest_size;
+}
+
+static inline int tcp_ao_maclen(const struct tcp_ao_key *key)
+{
+	return key->maclen;
+}
+
+static inline int tcp_ao_len(const struct tcp_ao_key *key)
+{
+	return tcp_ao_maclen(key) + sizeof(struct tcp_ao_hdr);
+}
+
+static inline unsigned int tcp_ao_digest_size(struct tcp_ao_key *key)
+{
+	return key->digest_size;
+}
+
+static inline int tcp_ao_sizeof_key(const struct tcp_ao_key *key)
+{
+	return sizeof(struct tcp_ao_key) + (key->digest_size << 1);
+}
+
+struct tcp_ao_info {
+	/* List of tcp_ao_key's */
+	struct hlist_head	head;
+	/* current_key and rnext_key aren't maintained on listen sockets.
+	 * Their purpose is to cache keys on established connections,
+	 * saving needless lookups. Never dereference any of them from
+	 * listen sockets.
+	 * ::current_key may change in RX to the key that was requested by
+	 * the peer, please use READ_ONCE()/WRITE_ONCE() in order to avoid
+	 * load/store tearing.
+	 * Do the same for ::rnext_key, if you don't hold socket lock
+	 * (it's changed only by userspace request in setsockopt()).
+	 */
+	struct tcp_ao_key	*current_key;
+	struct tcp_ao_key	*rnext_key;
+	u32			flags;
+	__be32			lisn;
+	__be32			risn;
+	struct rcu_head		rcu;
+};
+
+#endif /* _TCP_AO_H */
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index d1d08da6331a..bf93a80809d6 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -360,6 +360,8 @@ struct tcp_diag_md5sig {
 	__u8	tcpm_key[TCP_MD5SIG_MAXKEYLEN];
 };
 
+#define TCP_AO_MAXKEYLEN	80
+
 /* setsockopt(fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE, ...) */
 
 #define TCP_RECEIVE_ZEROCOPY_FLAG_TLB_CLEAN_HINT 0x1
diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 89e2ab023272..8e94ed7c56a0 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -744,6 +744,19 @@ config DEFAULT_TCP_CONG
 config TCP_SIGPOOL
 	tristate
 
+config TCP_AO
+	bool "TCP: Authentication Option (RFC5925)"
+	select CRYPTO
+	select TCP_SIGPOOL
+	depends on 64BIT && IPV6 != m # seq-number extension needs WRITE_ONCE(u64)
+	help
+	  TCP-AO specifies the use of stronger Message Authentication Codes (MACs),
+	  protects against replays for long-lived TCP connections, and
+	  provides more details on the association of security with TCP
+	  connections than TCP MD5 (See RFC5925)
+
+	  If unsure, say N.
+
 config TCP_MD5SIG
 	bool "TCP: MD5 Signature Option support (RFC2385)"
 	select CRYPTO
-- 
2.41.0

