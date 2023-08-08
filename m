Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB641773EE1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjHHQi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjHHQhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:37:35 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB9235DD2;
        Tue,  8 Aug 2023 08:53:33 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d75a77b69052e-409ae93bbd0so45243531cf.0;
        Tue, 08 Aug 2023 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510010; x=1692114810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJWy+tJMk/yVxxPHZgp8luxcV72VDkPKoVCNkbs0Mm4=;
        b=QqyBIsoGfHcI2+n7JORCPEeAd6pcqG+RXncLfJlBtyFMrqZNdxdLdG4+0snGfHzkxz
         GbncN4Oyv9AhSlpymx5tMpUGioIJqr37aZAztroaI5AAXiguKElnqcxy/9riD+xrEjeU
         fW91nw/1q80rY/43sowkNmkYOS12F3WtOI+1+gmxzBpQu7ojovAl/f34I40N9gYBFMVu
         trrcwAnB/2Sh1SiHmv2vniFYOAU7btMb5EO9XHudsRkheXb4EroKdcouHO+7R4hncvtF
         JqHuEac8CsjGks6SiML1UP07k5pkcuZGFAYKc55y6pR/N5fG/a8apZYTSKVeQBSbsIq/
         u7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510010; x=1692114810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJWy+tJMk/yVxxPHZgp8luxcV72VDkPKoVCNkbs0Mm4=;
        b=aw9sa0Maotppyf14W1PHL0oqesYYD9NNErkfwK57eV+nXFVw0AYrK566dfpDxWrlMw
         mS/QAg6dO8ZfT8OCkSygUdXAt0JiLVRZ0eDV+iTijWcx9AUZt8xTI9qShlzBHAEHj59q
         u7QkzU/SmLCJpBj2wDjHS4kuAf4HZM3YptyUVUpN1L4wdpk+62BJFRCTHU6d6ZoF+D1v
         TSXtgTY60SFOZyNrZO3ayQIEF6hLHvRlVTTGx9FJ8OokRjetvSjvq91XaTpKDEPLASD8
         XxSwW/UwYW5qGDqdcuoyg2lIxkj9n1Qni3jT/p/nKpNY9ZC5j/ZirZ7P4CEL7okGCEvy
         KPbA==
X-Gm-Message-State: AOJu0YzsDLJq72lzAZuETcuSvW1f3RH/ZHKTh3dVWYIiw5tCA0Fh5W1V
        owEqbFgeU8G1vRMBULsjYqjHu6obzSVQxkzFeqQ=
X-Google-Smtp-Source: AGHT+IH2PEPPJhTYnufeBrdq+vFubKxaYk2WH1aj/WI60sCiidy3AczfPWpvvzGx5zpLmHTLgrsiLg==
X-Received: by 2002:a05:6a00:80a:b0:668:711a:7d93 with SMTP id m10-20020a056a00080a00b00668711a7d93mr11559484pfk.19.1691495956858;
        Tue, 08 Aug 2023 04:59:16 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.11])
        by smtp.gmail.com with ESMTPSA id j22-20020a63e756000000b00563b36264besm6484136pgk.85.2023.08.08.04.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 04:59:16 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     edumazet@google.com, ncardwell@google.com
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, flyingpeng@tencent.com,
        Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next v3 3/3] net: tcp: fix unexcepted socket die when snd_wnd is 0
Date:   Tue,  8 Aug 2023 19:58:35 +0800
Message-Id: <20230808115835.2862058-4-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808115835.2862058-1-imagedong@tencent.com>
References: <20230808115835.2862058-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
which is exact the timestamp of the timeout. Meanwhile, using the later
one of tp->retrans_stamp and tp->rcv_tstamp as the last updated timestamp
in the receiving path, as "tp->rcv_tstamp" can restart from idle, then
tp->rcv_tstamp could already be a long time (minutes or hours) in the
past even on the first RTO.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/netdev/CADxym3YyMiO+zMD4zj03YPM3FBi-1LHi6gSD2XT8pyAMM096pg@mail.gmail.com/
Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
v3:
- use after() instead of max() in tcp_rtx_probe0_timed_out()
v2:
- consider the case of the connection restart from idle, as Neal comment
---
 net/ipv4/tcp_timer.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index d45c96c7f5a4..f30d1467771c 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -454,6 +454,18 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 			  req->timeout << req->num_timeout, TCP_RTO_MAX);
 }
 
+static bool tcp_rtx_probe0_timed_out(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	u32 timeout_ts, rtx_ts, rcv_ts;
+
+	rtx_ts = tp->retrans_stamp;
+	rcv_ts = tp->rcv_tstamp;
+	timeout_ts = after(rtx_ts, rcv_ts) ? rtx_ts : rcv_ts;
+	timeout_ts += TCP_RTO_MAX;
+
+	return after(inet_csk(sk)->icsk_timeout, timeout_ts);
+}
 
 /**
  *  tcp_retransmit_timer() - The TCP retransmit timeout handler
@@ -519,7 +531,7 @@ void tcp_retransmit_timer(struct sock *sk)
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

