Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9694C77266B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjHGNrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbjHGNrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:47:22 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D547910EF;
        Mon,  7 Aug 2023 06:47:20 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1bc0d39b52cso29353785ad.2;
        Mon, 07 Aug 2023 06:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691416040; x=1692020840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hO5ffsMV1x2LeSF6TZmYSUDXcFSKo+pDvUEfomBe2w0=;
        b=m8bkI8THG1kg0LlHLz7Op4k5P/2LGhgnUZNsP4jww5zkGTS5mLQckMwLq5W8uPTkHL
         CJy7/c9Hg1u17DUGPLp1kXQxWSYpk0EWnP/D8ZCzVi0u9ZxbcKaZEbL7YolDWoPIecTH
         pLL4rw8Mp8eAfLlf51k+gQzJuIMVeEE1noTMRlCf34XgI//hv/7WRZ4OvaLVQsk3gALn
         2xKEvSYqOKhTY+vW9mh9z1P3wvkBf3BBmA1SowChXtSMo0HFd757qVwHt7RD7Jn0U+5m
         R87IpLGfLKVCzIpzYyh7f9X8BN/ki4VsrI/62Zm1lt9NVsy/9kOjuFOO0l++vsx1SV9a
         nNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691416040; x=1692020840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hO5ffsMV1x2LeSF6TZmYSUDXcFSKo+pDvUEfomBe2w0=;
        b=QvtWckJ96ogN4dLSui7NooDmbxHBmyQQ2SN1cU/hM7f2MUjbb0rYsxQF7vRQ+PNaT/
         Uv+DaW2l+QHY2uLiZDiNMqC8WIE8bhIHUen61IFbeugaf56tFxuCXDhMrL3A9Cyl68Vo
         PisnvLbLC/fbpcLSzopS7KU32GbkEKLHTl3JfBjUnOXysgPIhEppW8nmJyydnLGrLLsF
         Ap3qFrX9nxRg29xlOYt4WUSyF6yPxAf2z4sbSIa8QGakhlW0tQmo1JgHuG2ZNGDqwYqF
         qc5TKMEwub/QSB5Okb/G7iVOR+rD7l4cDMh+dT0toWJbVDiBt5QfZriTn1UD2l1JXEC1
         jRAA==
X-Gm-Message-State: AOJu0YxB8HWCDllhvmY+OcM4B8AMHfmd+MxvP+n0SJxRYvSnAtRS1hHK
        FSGF9bC3bZKyMh8YJAFp3uGkKAqBtWQvhPNXSrU=
X-Google-Smtp-Source: AGHT+IHsQDpDGnSeuUYdXSPmTGGakiREXwsTWbkp15hPGMNkUKXmL3k+eyzM0T/sSXEjGASLoCJCaA==
X-Received: by 2002:a17:903:2449:b0:1bc:1189:17f with SMTP id l9-20020a170903244900b001bc1189017fmr10891246pls.42.1691416040181;
        Mon, 07 Aug 2023 06:47:20 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.23])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902704200b001b54a88e4a6sm6912097plt.51.2023.08.07.06.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:47:19 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     edumazet@google.com, ncardwell@google.com
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next v2 3/3] net: tcp: fix unexcepted socket die when snd_wnd is 0
Date:   Mon,  7 Aug 2023 21:45:47 +0800
Message-Id: <20230807134547.2782227-4-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807134547.2782227-1-imagedong@tencent.com>
References: <20230807134547.2782227-1-imagedong@tencent.com>
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

However, the timer is not precise enough, as it base on timer wheel.
Sorry that I am not good at timer, but I know the concept of time-wheel.
The longer of the timer, the rougher it will be. So the timeout is not
triggered after TCP_RTO_MAX, but 122877ms as I tested.

Therefore, 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX' is always true
once the RTO come up to TCP_RTO_MAX, and the socket will die.

Fix this by replacing the 'tcp_jiffies32' with '(u32)icsk->icsk_timeout',
which is exact the timestamp of the timeout. Meanwhile, using
"max(tp->retrans_stamp, tp->rcv_tstamp)" as the last updated timestamp in
the receiving path, as "tp->rcv_tstamp" can restart from idle, then
tp->rcv_tstamp could already be a long time (minutes or hours) in the
past even on the first RTO.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/netdev/CADxym3YyMiO+zMD4zj03YPM3FBi-1LHi6gSD2XT8pyAMM096pg@mail.gmail.com/
Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
v2:
- consider the case of the connection restart from idle, as Neal comment
---
 net/ipv4/tcp_timer.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index d45c96c7f5a4..e4b2d8706cae 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -454,6 +454,14 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 			  req->timeout << req->num_timeout, TCP_RTO_MAX);
 }
 
+static bool tcp_rtx_probe0_timed_out(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	u32 last_ts;
+
+	last_ts = max(tp->retrans_stamp, tp->rcv_tstamp);
+	return inet_csk(sk)->icsk_timeout - last_ts > TCP_RTO_MAX;
+}
 
 /**
  *  tcp_retransmit_timer() - The TCP retransmit timeout handler
@@ -519,7 +527,7 @@ void tcp_retransmit_timer(struct sock *sk)
 					    tp->snd_una, tp->snd_nxt);
 		}
 #endif
-		if (tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX) {
+		if (tcp_rtx_probe0_timed_out(sk)) {
 			tcp_write_err(sk);
 			goto out;
 		}
-- 
2.40.1

