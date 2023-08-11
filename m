Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A66B7785B5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjHKDB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjHKDBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:01:51 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3C42D62;
        Thu, 10 Aug 2023 20:01:50 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 5614622812f47-3a3fbfb616dso1216919b6e.3;
        Thu, 10 Aug 2023 20:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691722909; x=1692327709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enVkNJXrJdLf7MzJUPRylvkN1IvdGVVLk/5iI6tM8A4=;
        b=XISWmeUDefkxqNsY0JQpgSjpOyQHTTrNySFbrmrp2L8X8IlgTZnMrNnCRK5mrrOWwW
         nSJcsAAf7sjhaXFeqpY5cSkXeNCdEkQFRwALPDkbHv/0IrBhc6vgdjKTv82spDzKSn3F
         IbjXgc7m1JDDxfMYaelU5r4XjdYvDX13WOT+H8k6LjFOlOh8V5q5vks6HpLMSy1emSPU
         W8500QM18Fw5K6wJtyWkzx8Y5yLen6du5xzq26SAfWhi/dr27lw0Aqg7J3q2Qf0SoikT
         0CkUs35TLxTngXms7MvIaS9dKwZDeDXXob1Mbb4o6sFCiKxmy14nCFQ7gglqvMia6GlM
         gBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691722909; x=1692327709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enVkNJXrJdLf7MzJUPRylvkN1IvdGVVLk/5iI6tM8A4=;
        b=Ky/3TLM2mmflFgj0WSIx4BA/cpkyBCKsZN6E2qQIMN1BXD6ngTCSn4t5J+M/KBY9Xd
         gQ+MpBZZ4o4td7rG1OIjsZ0sPD9aLkK+8fgwbRUH6LaXFrHSSG0cI/BH1RQAPlgK/sIE
         cMZ+qcq3KhO9qQLINdacy77ruO7F10vGT9PY66mvqq4Lnq5Enh0Xsm//mxXPY52G829b
         dEd8Ud3ZQrM1KIcRTj5a1JB4soU5ptgRAeglFDD2swr6TV9EldgKXdHfPdw7Rczhlwc4
         IpzmoFg3rvl3SwL5hm817ukFOky4hf9GO44fVTn8Jsm+EqKPD3ZshiDWHqLMgyuyDm6o
         XJWA==
X-Gm-Message-State: AOJu0YwuxjTV7sP0QhIxZv4w21P2gcCM6e1AtHziY34HfnFszClivzNF
        G4hx2Ia+gX/6esbK5EMJiyc=
X-Google-Smtp-Source: AGHT+IF9pto/XQgcZ5r8VYBj/cCWKdXbbM11P42QEyEQ3GKd6IJDhwcwoWPrfOpxf+w5vkQ5Ryq0ug==
X-Received: by 2002:a05:6808:211d:b0:3a7:44f2:4570 with SMTP id r29-20020a056808211d00b003a744f24570mr928103oiw.42.1691722909532;
        Thu, 10 Aug 2023 20:01:49 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.10])
        by smtp.gmail.com with ESMTPSA id l5-20020a639845000000b005646868da17sm2281197pgo.72.2023.08.10.20.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 20:01:49 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     edumazet@google.com, ncardwell@google.com
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, flyingpeng@tencent.com,
        Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next v4 3/4] net: tcp: fix unexcepted socket die when snd_wnd is 0
Date:   Fri, 11 Aug 2023 10:55:29 +0800
Message-Id: <20230811025530.3510703-4-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811025530.3510703-1-imagedong@tencent.com>
References: <20230811025530.3510703-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

In tcp_retransmit_timer(), a window shrunk connection will be regarded
as timeout if 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX'. This is not
right all the time.

The retransmits will become zero-window probes in tcp_retransmit_timer()
if the 'snd_wnd==0'. Therefore, the icsk->icsk_rto will come up to
TCP_RTO_MAX sooner or later.

However, the timer can be delayed and be triggered after 122877ms, not
TCP_RTO_MAX, as I tested.

Therefore, 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX' is always true
once the RTO come up to TCP_RTO_MAX, and the socket will die.

Fix this by replacing the 'tcp_jiffies32' with '(u32)icsk->icsk_timeout',
which is exact the timestamp of the timeout.

However, "tp->rcv_tstamp" can restart from idle, then tp->rcv_tstamp
could already be a long time (minutes or hours) in the past even on the
first RTO. So we double check the timeout with the duration of the
retransmission.

Meanwhile, making "2 * TCP_RTO_MAX" as the timeout to avoid the socket
dying too soon.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/netdev/CADxym3YyMiO+zMD4zj03YPM3FBi-1LHi6gSD2XT8pyAMM096pg@mail.gmail.com/
Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
v4:
- make the timeout "2 * TCP_RTO_MAX"
- tp->retrans_stamp is not based on jiffies and can't be compared with
  icsk->icsk_timeout. Fix it.
v3:
- use after() instead of max() in tcp_rtx_probe0_timed_out()
v2:
- consider the case of the connection restart from idle, as Neal comment
---
 net/ipv4/tcp_timer.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index d45c96c7f5a4..f2a52c11e044 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -454,6 +454,22 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 			  req->timeout << req->num_timeout, TCP_RTO_MAX);
 }
 
+static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
+				     const struct sk_buff *skb)
+{
+	const struct tcp_sock *tp = tcp_sk(sk);
+	const int timeout = TCP_RTO_MAX * 2;
+	u32 rcv_delta, rtx_delta;
+
+	rcv_delta = inet_csk(sk)->icsk_timeout - tp->rcv_tstamp;
+	if (rcv_delta <= timeout)
+		return false;
+
+	rtx_delta = (u32)msecs_to_jiffies(tcp_time_stamp(tp) -
+			(tp->retrans_stamp ?: tcp_skb_timestamp(skb)));
+
+	return rtx_delta > timeout;
+}
 
 /**
  *  tcp_retransmit_timer() - The TCP retransmit timeout handler
@@ -519,7 +535,7 @@ void tcp_retransmit_timer(struct sock *sk)
 					    tp->snd_una, tp->snd_nxt);
 		}
 #endif
-		if (tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX) {
+		if (tcp_rtx_probe0_timed_out(sk, skb)) {
 			tcp_write_err(sk);
 			goto out;
 		}
-- 
2.40.1

