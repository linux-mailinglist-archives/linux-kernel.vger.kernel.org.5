Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBCB7CE982
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjJRU6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjJRU6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:58:22 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221469B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:58:20 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso7880975e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1697662698; x=1698267498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlzeXDnNAal+R+G9wc2dcomPOnGI8j3YyIKIBD3nk/o=;
        b=c1Yr6CC1TWTkWRfnvJwgEdR7Xq8Qbf0NQaZGW57hyYgMWwV0NgQ5XZLTQMy3CUWq5d
         oJTVORxMwHD0jQzD8fl8j6sQc0e7QUNY/X7C0T6WFzfNoCRQYJmj6ybQSnpjoB63lTlW
         GYjAj2CajOV2gKM06pcAC9s20SEZIfYX+xtKTGw0VEgcGNfSNlTq6DACPr66bkEl3RCY
         kjJje+Oy6jecPkspP6IrPP1vTZ5QZHIQg+22/0xXf0X2A+8Rh1pUTSnemwEcR5YiVAVA
         Kp9otqtP3t+IT09yEUcB+5Nko0na9FbxXiVBW8XcqmT4D7AskDAS0HdojPdlv+2/7EvZ
         1moA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697662698; x=1698267498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlzeXDnNAal+R+G9wc2dcomPOnGI8j3YyIKIBD3nk/o=;
        b=TrL1m6OT5J64d2rQ3HELoQtU50vOY3c8VeHJ0MPb7X0zsVGvP/E3oMKUnbPD8j9MNH
         h0e2OvsydB9Cd8o3/o3G/SNJoRfdl79lo4gvr/DtjQ+ydmpa+8CMCK8iKPavfL7lIgbr
         Nl+2Wx5XnE8UIaUUG9/pv1op7mG9j6A87b+v4/kYGxeeTwjlwBw8jPwx2zW5FiDHDsbX
         LfL4KhAK8jBgqjI43DWrGr1BQFpYN6PQqa4/fzscXX7PxI0jnJr4XK/8rdJoXqr7ob+N
         fgLpWwLQGuiF5KTMHmdLdPuqtSKgLom92iR2J1GBPj4ELSf11iq9xgCtyF3w802b9VHf
         +KUw==
X-Gm-Message-State: AOJu0YzCrVqOaEvYpptev0RVRGQW7ZmXd5ZzAPQJN48jGj9gGqCgF6iI
        7mjaTexfnyFiX9efxiQak+kWnA==
X-Google-Smtp-Source: AGHT+IG5cXsZ1MtJyscScv0ESoKYYZl7PqvJsR6+K/yK7b4wk5vZcfbTMz+INFm+R0UZPF/UHoIHIg==
X-Received: by 2002:a05:600c:4507:b0:3ff:233f:2cfb with SMTP id t7-20020a05600c450700b003ff233f2cfbmr327514wmo.23.1697662698445;
        Wed, 18 Oct 2023 13:58:18 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x19-20020a05600c421300b003fc16ee2864sm2569006wmh.48.2023.10.18.13.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 13:58:17 -0700 (PDT)
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
        Simon Horman <horms@kernel.org>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Subject: [PATCH v15 net-next 02/23] net/tcp: Add TCP-AO config and structures
Date:   Wed, 18 Oct 2023 21:57:16 +0100
Message-ID: <20231018205806.322831-3-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231018205806.322831-1-dima@arista.com>
References: <20231018205806.322831-1-dima@arista.com>
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
index c831e10d2408..6b52fa4fdb9a 100644
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
@@ -1656,12 +1657,7 @@ static inline void tcp_clear_all_retrans_hints(struct tcp_sock *tp)
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
2.42.0

