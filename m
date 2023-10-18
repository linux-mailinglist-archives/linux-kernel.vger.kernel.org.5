Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F1C7CE9A2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344901AbjJRVAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjJRU7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:59:31 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C921187
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:58:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40806e4106dso580575e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1697662732; x=1698267532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvDuAooczxx5mXgBpeaWHuz5QzyPAKub23jfuhCVJ9g=;
        b=fsbyejtoau7S92m/PPymHCgML/ar1pcr4mvvXTGV7S+JUbtsLexeaymfrRIcr9Oxtx
         RlFt4Cwob0ARrujExtzDqcuqZtUoLKakmI8wkyvIkfALtIOhlzDnXrLaEQIXLKCzSO+x
         T7DERNuo/2rlLxum8ErIegKqlEx8Mtis/NMpv8fMZ4M1nby+KiciRgcRMdkftVfAb/Lc
         HAwh6cPdh76bQ+YF6SZkxA1+ESXMnbPLa+Thy5tL82i50OUEwWGS3INAeraK8YQ1YiWN
         CRrrNhjtqWvPKc+SOZ7fvipTIALNUq/0epjbTIoD0w3TKvGu8HsydpCz0rKN9uJ5MT+i
         kBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697662732; x=1698267532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvDuAooczxx5mXgBpeaWHuz5QzyPAKub23jfuhCVJ9g=;
        b=CyzYp1T2wnkyGDzoHlCrW9Mes35ODjQ0dmGeBm77O7oyCdm3g81kAhr+gQDI7y5UIC
         ador//wjsWi+9ymdesWj+r2pgRjRnSXwcIns7IfO6pyxq/UiHt8Kfn3S0QdNNhzhkFkd
         sId3I81u4C2SeoVWQD6no/GvOo6K0QUpZvgR7lYIWz42kXKRSmk9qR4xiqGSlGWXwjSO
         4b/qn28qYokrUBEROwBSG/9uhkQyemJZAF75UQFLGMvtKho+nmdSKPZLiEr5DKvO1WkK
         rR6EJ8WQUKHxmNJpOHqRtV7zj4X/wd6ZcQu2EYHpINOUDOMNwf1Sgzpl281kanf+f9N8
         uHtA==
X-Gm-Message-State: AOJu0Yy3QHKItzVrTRDk9025MTschPCLMvoy6HluBvr7ma4DTGdZqzhT
        RVMVNWGDs1MnislmZcjoOskLTQ==
X-Google-Smtp-Source: AGHT+IHztCFXqy5VIhSBmwTgahaNDFKpPhWo30+fJANpujUxq6bE4XS6pTiNTXpgtxp0MDjyrmx9+A==
X-Received: by 2002:a05:600c:4593:b0:401:c8b9:4b86 with SMTP id r19-20020a05600c459300b00401c8b94b86mr417120wmo.9.1697662732729;
        Wed, 18 Oct 2023 13:58:52 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x19-20020a05600c421300b003fc16ee2864sm2569006wmh.48.2023.10.18.13.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 13:58:52 -0700 (PDT)
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
Subject: [PATCH v15 net-next 19/23] net/tcp: Allow asynchronous delete for TCP-AO keys (MKTs)
Date:   Wed, 18 Oct 2023 21:57:33 +0100
Message-ID: <20231018205806.322831-20-dima@arista.com>
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
index a411aef00318..25d62ecb9532 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -395,7 +395,8 @@ struct tcp_ao_del { /* setsockopt(TCP_AO_DEL_KEY) */
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
index cbc1ee0f5b9a..acbeb635fe29 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1628,7 +1628,7 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 }
 
 static int tcp_ao_delete_key(struct sock *sk, struct tcp_ao_info *ao_info,
-			     struct tcp_ao_key *key,
+			     bool del_async, struct tcp_ao_key *key,
 			     struct tcp_ao_key *new_current,
 			     struct tcp_ao_key *new_rnext)
 {
@@ -1636,11 +1636,24 @@ static int tcp_ao_delete_key(struct sock *sk, struct tcp_ao_info *ao_info,
 
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
@@ -1711,6 +1724,8 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 		if (!new_rnext)
 			return -ENOENT;
 	}
+	if (cmd.del_async && sk->sk_state != TCP_LISTEN)
+		return -EINVAL;
 
 	if (family == AF_INET) {
 		struct sockaddr_in *sin = (struct sockaddr_in *)&cmd.addr;
@@ -1758,8 +1773,8 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
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
2.42.0

