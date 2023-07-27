Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C264765457
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjG0Mvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjG0Mvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:51:51 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04DF1BC1;
        Thu, 27 Jul 2023 05:51:50 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 5614622812f47-3a3c78ede4bso760178b6e.2;
        Thu, 27 Jul 2023 05:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690462310; x=1691067110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1M9X9cFhRpVGts4/6dZs2oXMtLocqBd/PjGY4NYMgE=;
        b=I9eJSV426qImFidD8Ebfo6fX+GXG4523bJDNxkEit+0Jw2KPB30aL3zQJda2cLHSUL
         X4jAVkwILnOBwkkhkT8JBhmr3pbLfR11cTE2FNyaVhgCWsPQmboy+ySiD4l7TdPyu3on
         TO7PB34zf+DrG8ITeUU8rMME2pIRTsQNGx9khnmSbRazAiUdngsASFL37+VIxS41X5cx
         RSmivjBMsmYTi2muveCrTHGEMlWu8UnzECrvbOgUCIjs6FOh+VHgaItghZkkW6T+/CQ7
         m+Eeiu8lGkgNs9TUAE/jg1K03KFJRDB8EbnTxFepkejJt6/gBPWk3YhAl5ksXNofHzES
         iFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690462310; x=1691067110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1M9X9cFhRpVGts4/6dZs2oXMtLocqBd/PjGY4NYMgE=;
        b=F+No8HYoYxgiE7W8ICFiif5thY75oAqcHWlNUM0Zf0CBKDVtdJIjlgg5wEZ6hGFBQA
         1Pny3D5vR7QbF594CxkC+erIuKNqkN5TlC5zN5qQrRC3kgBEPtMkKwHwg1+4RCZG6zgL
         NiDIfMUy/1LUodiaJjdZPt54VAjpaHv37tJQXdjiSyHI7Gztwv9YhEtnY5wHh2yqrcwo
         lBiU4SBl7tLhkcN/h23QiwIoBNIwG4fNpZGOz8fcgmPMuEAv5MwwSCptQPY7VKx7ej5A
         W1FeF49e0BV+92Xmx9K5QYPlWOG8w8nRpx3VOvj08wvyJqsd9a/y1AmdFQc6dm6kWWyQ
         pBDQ==
X-Gm-Message-State: ABy/qLaEYokv07QXnvizjlOCD2CP34YMBaofFi0RmiBnieHHBo0a9hYf
        O22I04si0huvA6AwKaDlFTs=
X-Google-Smtp-Source: APBJJlFgSvwYdtnkiqvDYoA0Wj1j+2pza/e2UDGV2p8H8od6WPeyjYLOJiRBIrk8OdrMtnpfyPCbFg==
X-Received: by 2002:a05:6808:1b12:b0:3a3:7612:28c7 with SMTP id bx18-20020a0568081b1200b003a3761228c7mr3678694oib.23.1690462309938;
        Thu, 27 Jul 2023 05:51:49 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.115])
        by smtp.gmail.com with ESMTPSA id l4-20020a63be04000000b0055386b1415dsm1315048pgf.51.2023.07.27.05.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 05:51:48 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     edumazet@google.com
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next 1/3] net: tcp: send zero-window ACK when no memory
Date:   Thu, 27 Jul 2023 20:51:23 +0800
Message-Id: <20230727125125.1194376-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230727125125.1194376-1-imagedong@tencent.com>
References: <20230727125125.1194376-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

For now, skb will be dropped when no memory, which makes client keep
retrans util timeout and it's not friendly to the users.

In this patch, we reply an ACK with zero-window in this case to update
the snd_wnd of the sender to 0. Therefore, the sender won't timeout the
connection and will probe the zero-window with the retransmits.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 include/net/inet_connection_sock.h |  3 ++-
 net/ipv4/tcp_input.c               |  4 ++--
 net/ipv4/tcp_output.c              | 14 +++++++++++---
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index c2b15f7e5516..be3c858a2ebb 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -164,7 +164,8 @@ enum inet_csk_ack_state_t {
 	ICSK_ACK_TIMER  = 2,
 	ICSK_ACK_PUSHED = 4,
 	ICSK_ACK_PUSHED2 = 8,
-	ICSK_ACK_NOW = 16	/* Send the next ACK immediately (once) */
+	ICSK_ACK_NOW = 16,	/* Send the next ACK immediately (once) */
+	ICSK_ACK_NOMEM = 32,
 };
 
 void inet_csk_init_xmit_timers(struct sock *sk,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 3cd92035e090..03111af6115d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5061,7 +5061,8 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 			reason = SKB_DROP_REASON_PROTO_MEM;
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
 			sk->sk_data_ready(sk);
-			goto drop;
+			inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOMEM;
+			goto out_of_window;
 		}
 
 		eaten = tcp_queue_rcv(sk, skb, &fragstolen);
@@ -5102,7 +5103,6 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 out_of_window:
 		tcp_enter_quickack_mode(sk, TCP_MAX_QUICKACKS);
 		inet_csk_schedule_ack(sk);
-drop:
 		tcp_drop_reason(sk, skb, reason);
 		return;
 	}
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 2cb39b6dad02..81aa2c615924 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -257,11 +257,19 @@ EXPORT_SYMBOL(tcp_select_initial_window);
 static u16 tcp_select_window(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 old_win = tp->rcv_wnd;
-	u32 cur_win = tcp_receive_window(tp);
-	u32 new_win = __tcp_select_window(sk);
 	struct net *net = sock_net(sk);
+	u32 old_win = tp->rcv_wnd;
+	u32 cur_win, new_win;
+
+	/* Make the window 0 if we failed to queue the data because we
+	 * are out of memory. The window is temporary, so we don't store
+	 * it on the socket.
+	 */
+	if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM))
+		return 0;
 
+	cur_win = tcp_receive_window(tp);
+	new_win = __tcp_select_window(sk);
 	if (new_win < cur_win) {
 		/* Danger Will Robinson!
 		 * Don't update rcv_wup/rcv_wnd here or else
-- 
2.40.1

