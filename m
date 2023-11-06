Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDDD7E2EBD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjKFVOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjKFVOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:14:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6BDAF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:14:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6639CC433C8;
        Mon,  6 Nov 2023 21:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699305269;
        bh=yOk149MnqQ38qeZeV/4etw3iKo3CYD5n8FeZGzh/eFc=;
        h=From:Date:Subject:To:Cc:From;
        b=F74yB8bJbDjRxQPrWVBp0rcIBA/1CoKPsUPx+XDnqKASkuUkdBYoh37c6UvH0cKhX
         wIxHDWgXtlPaGXOi2W+s/3s/ethyy+T8dEhuh+3qTBw41Ih6QVQRtAjnj2XKSjEY3v
         28EGdOEvc/f2W/zne9ZsmlPve6sIp/pDj7j79xv0CgxoQMQekl7+fUewO2yBJ0EmnJ
         qmShe+edLqsf1VPBmi7+UaDKjkj8NT+By+yBgfSQYVbL/ksvsb97pYZRYyDbtZWlyz
         DtLWQV/7wgITaX6YSQPJVjbAOFvL1oYPinGSTkqfFCxqBKYm3mkcWEKo42hx2iKgGv
         BS/6AeS9E4u9Q==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Mon, 06 Nov 2023 14:14:16 -0700
Subject: [PATCH net v3] tcp: Fix -Wc23-extensions in tcp_options_write()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-tcp-ao-fix-label-in-compound-statement-warning-v3-1-b54a64602a85@kernel.org>
X-B4-Tracking: v=1; b=H4sIACdXSWUC/52OQQ6CMBBFr2K6dgwDCNSV9zAuShmgEaakragh3
 N2GjXGpyz8/895fhCdnyIvTbhGOZuON5Riy/U7oXnFHYJqYRZqkGSYZQtATKAutecKgahrAMGg
 7TvbODfigAo3EAR7KseEOqG4KLWVZ5bISETo5iq+b8CKYgrjGY298sO61jZhxq/71zQgIWpYZN
 ojHFsvzjRzTcLCu21xz+uFjUvzMTyNfIrVtQVjklf7ir+v6BkvB94tSAQAA
To:     edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com
Cc:     ndesaulniers@google.com, trix@redhat.com, 0x7f454c46@gmail.com,
        noureddine@arista.com, hch@infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4778; i=nathan@kernel.org;
 h=from:subject:message-id; bh=yOk149MnqQ38qeZeV/4etw3iKo3CYD5n8FeZGzh/eFc=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDKme4SaXfJoX3r0VsrR01445f1buSnbn39V4u66r97CQ1
 Z/WybukOkpZGMQ4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEXhoyMrRMdQr09N8oPO8f
 j/P1DmaWLyskL7e/VMz67PNJdY7P/LsM/2wEWY5F8B9kWFs2qVvhvo/T68KqtuoNuzdnub/7lHO
 sgxUA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
replaced with a return statement. Do so to resolve the warning.

Closes: https://github.com/ClangBuiltLinux/linux/issues/1953
Fixes: 1e03d32bea8e ("net/tcp: Add TCP-AO sign to outgoing packets")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Changes in v3:
- Don't use a pointer to a pointer for ptr parameter to avoid the extra
  indirection in process_tcp_ao_options(), just return the modified ptr
  value back to the caller (Eric)
- Link to v2: https://lore.kernel.org/r/20231106-tcp-ao-fix-label-in-compound-statement-warning-v2-1-91eff6e1648c@kernel.org

Changes in v2:
- Break out problematic block into its own function so that goto can be
  replaced with a simple return, instead of the simple semicolon
  approach of v1 (Christoph)
- Link to v1: https://lore.kernel.org/r/20231031-tcp-ao-fix-label-in-compound-statement-warning-v1-1-c9731d115f17@kernel.org
---
 net/ipv4/tcp_output.c | 70 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0d8dd5b7e2e5..eb13a55d660c 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -601,6 +601,44 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
 }
 #endif
 
+static __be32 *process_tcp_ao_options(struct tcp_sock *tp,
+				      const struct tcp_request_sock *tcprsk,
+				      struct tcp_out_options *opts,
+				      struct tcp_key *key, __be32 *ptr)
+{
+#ifdef CONFIG_TCP_AO
+	u8 maclen = tcp_ao_maclen(key->ao_key);
+
+	if (tcprsk) {
+		u8 aolen = maclen + sizeof(struct tcp_ao_hdr);
+
+		*ptr++ = htonl((TCPOPT_AO << 24) | (aolen << 16) |
+			       (tcprsk->ao_keyid << 8) |
+			       (tcprsk->ao_rcv_next));
+	} else {
+		struct tcp_ao_key *rnext_key;
+		struct tcp_ao_info *ao_info;
+
+		ao_info = rcu_dereference_check(tp->ao_info,
+			lockdep_sock_is_held(&tp->inet_conn.icsk_inet.sk));
+		rnext_key = READ_ONCE(ao_info->rnext_key);
+		if (WARN_ON_ONCE(!rnext_key))
+			return ptr;
+		*ptr++ = htonl((TCPOPT_AO << 24) |
+			       (tcp_ao_len(key->ao_key) << 16) |
+			       (key->ao_key->sndid << 8) |
+			       (rnext_key->rcvid));
+	}
+	opts->hash_location = (__u8 *)ptr;
+	ptr += maclen / sizeof(*ptr);
+	if (unlikely(maclen % sizeof(*ptr))) {
+		memset(ptr, TCPOPT_NOP, sizeof(*ptr));
+		ptr++;
+	}
+#endif
+	return ptr;
+}
+
 /* Write previously computed TCP options to the packet.
  *
  * Beware: Something in the Internet is very sensitive to the ordering of
@@ -629,37 +667,7 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
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
+		ptr = process_tcp_ao_options(tp, tcprsk, opts, key, ptr);
 	}
 	if (unlikely(opts->mss)) {
 		*ptr++ = htonl((TCPOPT_MSS << 24) |

---
base-commit: c1ed833e0b3b7b9edc82b97b73b2a8a10ceab241
change-id: 20231031-tcp-ao-fix-label-in-compound-statement-warning-ebd6c9978498

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

