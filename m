Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E40765459
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbjG0MwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjG0MwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:52:01 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F151FFC;
        Thu, 27 Jul 2023 05:51:57 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-6862842a028so703424b3a.0;
        Thu, 27 Jul 2023 05:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690462316; x=1691067116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQgiv4sJ/sPXZQ43kqJjA4dVyOkNO7+7aA6t8NxmmyQ=;
        b=eeAxrZ9WGMH+9s61002Q5SSLdR+MJFvTd8G6/NopLVnL0r1bII1ps7l8+oMzhkp+kL
         kZaAYdAfe3mtCx+d1slojmacDu+nxXnWfw583PDuZuLw1Od8BHkdudH6qSY0Q7+ECbOH
         YEWhahHNGq9D6sOmmzi/hB6RccvolWbHXR446NXVtmg5DidBUjIFxB4rX6AdSGthSdZk
         YSIxJib58yoVjAaqciB5yPuSJ/fztyiGTT8tEM2TIlYmVfoydbwQbwU2kMzPye2FtwTD
         YSQ5vlTKfanGOKjqkvIGsLVwxKseitHw6wNRb0LlUL1NsfQ2aT/vCU014i8LKaD8irMI
         AJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690462316; x=1691067116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQgiv4sJ/sPXZQ43kqJjA4dVyOkNO7+7aA6t8NxmmyQ=;
        b=EuBbfjPZQ8/czO7SJS4QsPlkOJ2XhJ9sdvzv5X1cY/0Z5qctRYUbwMX6qC3uonpJ/U
         9Mye3nX4FK3TrdiwQP+NHXpEc+4gJ9lAni61QjIfmV5F5v0U+2ROkDPtpmotYPPocWwm
         sACAhrlV0n9p8iqNjtw1jCUZot15nVSApZi/AHps70L9AplYOMM2JNL8CrAPEsBYBv6I
         YwXpt04hBNdxYGDUouNl3n2XpWnQw51nFlP8Sr6HvuvkeEZCfM0/VCd8PqQYdSdR+yK+
         RnI+Um7vHX6qSOudBneNiafrf3KWfSaTBbRVvchQ863Zf+mo4f303sIUwSR+FaAaFAqb
         Pviw==
X-Gm-Message-State: ABy/qLYR1fdAbsh0bU8iDUmH27h/vytUgFa2FqkWF7eQB/oDuTxu9E+R
        gmRodj8/q6oSGBr1mMprqOE=
X-Google-Smtp-Source: APBJJlHllk/EfWReDH/gTBZwq8drWBpvIcz+juGTJqtySXhf8ugKpuJXBtt6QmLu8Ama9Un2i/xakA==
X-Received: by 2002:a05:6a20:a109:b0:133:e3e3:dc07 with SMTP id q9-20020a056a20a10900b00133e3e3dc07mr5363445pzk.49.1690462316347;
        Thu, 27 Jul 2023 05:51:56 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.115])
        by smtp.gmail.com with ESMTPSA id l4-20020a63be04000000b0055386b1415dsm1315048pgf.51.2023.07.27.05.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 05:51:55 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     edumazet@google.com
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next 3/3] net: tcp: check timeout by icsk->icsk_timeout in tcp_retransmit_timer()
Date:   Thu, 27 Jul 2023 20:51:25 +0800
Message-Id: <20230727125125.1194376-4-imagedong@tencent.com>
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
once the RTO come up to TCP_RTO_MAX.

Fix this by replacing the 'tcp_jiffies32' with '(u32)icsk->icsk_timeout',
which is exact the timestamp of the timeout.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 net/ipv4/tcp_timer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 470f581eedd4..3a20db15a186 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -511,7 +511,11 @@ void tcp_retransmit_timer(struct sock *sk)
 					    tp->snd_una, tp->snd_nxt);
 		}
 #endif
-		if (tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX) {
+		/* It's a little rough here, we regard any valid packet that
+		 * update tp->rcv_tstamp as the reply of the retransmitted
+		 * packet.
+		 */
+		if ((u32)icsk->icsk_timeout - tp->rcv_tstamp > TCP_RTO_MAX) {
 			tcp_write_err(sk);
 			goto out;
 		}
-- 
2.40.1

