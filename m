Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1EE7E28D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjKFPgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjKFPgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:36:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5A2100
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:36:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC4DC433C7;
        Mon,  6 Nov 2023 15:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699285000;
        bh=41GPekPzS1l/B/L0Wph3EEtN8ju8TJlotN/m7ed36wA=;
        h=From:Date:Subject:To:Cc:From;
        b=E1kwXDyWj51NgF8PJXSRF0dnJ5JaSdAp9uTDanVEigIU4T2oA23267Ec4zlRCMLe8
         eHRocL7tUq3+McgZc58rLwo1hMd4zPaOxC76mnY0IhZbO8gSoU5tzGbxCjwJXjmiEj
         0UCGsyqB/gdUGl8/zYpXgE/mfvBG4cj6XXHeomGHa5pEc0wykoS/XwKm0ljNSS8rSa
         wjD47Y7bBonf6iDrknDGFEGROupXL/u3ZvDZOvPltQXXGuRxvAwnz/I1Icy1S2jc7M
         1e6uBGcsgVWgAAHgFx/D8pfs9QKIG2JXtiu79YmH1YAfeVNrlzl2KjDCHx9OKDtjKY
         m+eIjjGmxTjuA==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Mon, 06 Nov 2023 08:36:07 -0700
Subject: [PATCH net v2] tcp: Fix -Wc23-extensions in tcp_options_write()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-tcp-ao-fix-label-in-compound-statement-warning-v2-1-91eff6e1648c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOYHSWUC/52OwQ6CMBBEf8Xs2TUsqIAn/8NwKO0CjbAlbUUN4
 d9t+ASPM5OZNysE9pYD3A4reF5ssE6SyI8H0IOSntGapCHP8oKygjDqGZXDzn5wVC2PaAW1m2b
 3EoMhqsgTS8S38mKlR27NVdd1WZ3rCtLo7DlVd+ADhCM0yRxsiM5/9xML7dG/vIWQUNdlQYbo0
 lF5f7IXHk/O99Bs2/YD74jdb/IAAAA=
To:     edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com
Cc:     ndesaulniers@google.com, trix@redhat.com, 0x7f454c46@gmail.com,
        noureddine@arista.com, hch@infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4584; i=nathan@kernel.org;
 h=from:subject:message-id; bh=41GPekPzS1l/B/L0Wph3EEtN8ju8TJlotN/m7ed36wA=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDKmeHOxGBjpBT+fOFl5w9VNg+osVZc9j1C+zuq3/9UlE3
 Jf93WK/jlIWBjEOBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjAR/mxGhqa9jhlfH3rd6Yt8
 eO8Co4/ky47vPEoGn85ypUbO2cq/k5nhf9rMufvveIieZj6oXHW24rGI3aElB37NsNA7lql4e2m
 SOzMA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns (or errors with CONFIG_WERROR=y) when CONFIG_TCP_AO is set:

  net/ipv4/tcp_output.c:663:2: error: label at end of compound statement is a C23 extension [-Werror,-Wc23-extensions]
    663 |         }
        |         ^
  1 error generated.

On earlier releases (such as clang-11, the current minimum supported
version for building the kernel) that do not support C23, this was a
hard error unconditionally:

  net/ipv4/tcp_output.c:663:2: error: expected statement
          }
          ^
  1 error generated.

While adding a semicolon after the label would resolve this, it is more
in line with the kernel as a whole to refactor this block into a
standalone function, which means the goto a label construct can just be
replaced with a simple return. Do so to resolve the warning.

Closes: https://github.com/ClangBuiltLinux/linux/issues/1953
Fixes: 1e03d32bea8e ("net/tcp: Add TCP-AO sign to outgoing packets")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Please let me know if this function should have a different name. I
think I got all the changes of the function shuffle correct but some
testing would be appreciated.

Changes in v2:
- Break out problematic block into its own function so that goto can be
  replaced with a simple return, instead of the simple semicolon
  approach of v1 (Christoph)
- Link to v1: https://lore.kernel.org/r/20231031-tcp-ao-fix-label-in-compound-statement-warning-v1-1-c9731d115f17@kernel.org
---
 net/ipv4/tcp_output.c | 69 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0d8dd5b7e2e5..3f8dc74fbf40 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -601,6 +601,43 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
 }
 #endif
 
+static void process_tcp_ao_options(struct tcp_sock *tp,
+				   const struct tcp_request_sock *tcprsk,
+				   struct tcp_out_options *opts,
+				   struct tcp_key *key, __be32 **ptr)
+{
+#ifdef CONFIG_TCP_AO
+	u8 maclen = tcp_ao_maclen(key->ao_key);
+
+	if (tcprsk) {
+		u8 aolen = maclen + sizeof(struct tcp_ao_hdr);
+
+		*(*ptr)++ = htonl((TCPOPT_AO << 24) | (aolen << 16) |
+				  (tcprsk->ao_keyid << 8) |
+				  (tcprsk->ao_rcv_next));
+	} else {
+		struct tcp_ao_key *rnext_key;
+		struct tcp_ao_info *ao_info;
+
+		ao_info = rcu_dereference_check(tp->ao_info,
+			lockdep_sock_is_held(&tp->inet_conn.icsk_inet.sk));
+		rnext_key = READ_ONCE(ao_info->rnext_key);
+		if (WARN_ON_ONCE(!rnext_key))
+			return;
+		*(*ptr)++ = htonl((TCPOPT_AO << 24) |
+				  (tcp_ao_len(key->ao_key) << 16) |
+				  (key->ao_key->sndid << 8) |
+				  (rnext_key->rcvid));
+	}
+	opts->hash_location = (__u8 *)(*ptr);
+	*ptr += maclen / sizeof(**ptr);
+	if (unlikely(maclen % sizeof(**ptr))) {
+		memset(*ptr, TCPOPT_NOP, sizeof(**ptr));
+		(*ptr)++;
+	}
+#endif
+}
+
 /* Write previously computed TCP options to the packet.
  *
  * Beware: Something in the Internet is very sensitive to the ordering of
@@ -629,37 +666,7 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 		opts->hash_location = (__u8 *)ptr;
 		ptr += 4;
 	} else if (tcp_key_is_ao(key)) {
-#ifdef CONFIG_TCP_AO
-		u8 maclen = tcp_ao_maclen(key->ao_key);
-
-		if (tcprsk) {
-			u8 aolen = maclen + sizeof(struct tcp_ao_hdr);
-
-			*ptr++ = htonl((TCPOPT_AO << 24) | (aolen << 16) |
-				       (tcprsk->ao_keyid << 8) |
-				       (tcprsk->ao_rcv_next));
-		} else {
-			struct tcp_ao_key *rnext_key;
-			struct tcp_ao_info *ao_info;
-
-			ao_info = rcu_dereference_check(tp->ao_info,
-				lockdep_sock_is_held(&tp->inet_conn.icsk_inet.sk));
-			rnext_key = READ_ONCE(ao_info->rnext_key);
-			if (WARN_ON_ONCE(!rnext_key))
-				goto out_ao;
-			*ptr++ = htonl((TCPOPT_AO << 24) |
-				       (tcp_ao_len(key->ao_key) << 16) |
-				       (key->ao_key->sndid << 8) |
-				       (rnext_key->rcvid));
-		}
-		opts->hash_location = (__u8 *)ptr;
-		ptr += maclen / sizeof(*ptr);
-		if (unlikely(maclen % sizeof(*ptr))) {
-			memset(ptr, TCPOPT_NOP, sizeof(*ptr));
-			ptr++;
-		}
-out_ao:
-#endif
+		process_tcp_ao_options(tp, tcprsk, opts, key, &ptr);
 	}
 	if (unlikely(opts->mss)) {
 		*ptr++ = htonl((TCPOPT_MSS << 24) |

---
base-commit: c1ed833e0b3b7b9edc82b97b73b2a8a10ceab241
change-id: 20231031-tcp-ao-fix-label-in-compound-statement-warning-ebd6c9978498

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

