Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4967D765458
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjG0Mv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjG0Mvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:51:54 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAD81BC1;
        Thu, 27 Jul 2023 05:51:53 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-686b91c2744so728845b3a.0;
        Thu, 27 Jul 2023 05:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690462313; x=1691067113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xv0faR8qn1Zj+OjUn+kfjlxGEdmNSeFnyT9mw1cYmU=;
        b=XxuM3J9vD9/FwSGMeuln3H92KmlfmkZ/SdpBGsMO31FUAQhD1OipNCu5wf6CU+AAN3
         YJaNAsRqqQijQ9b18NMNwMj05Y9RQnrLY50iZFZJq6kqosPfZhIJzzm00FaNHOpuP89j
         /tgNmzpeOFqQyRXBdP6a1hu85Oa7RCW+bs1SmkPXem5liVcx8DbEpSJIwztO9+Ax3OUA
         71IJ/SlhTbUVbtLc4v4gT5SW2GzXGIAdNQQDPu8ywhmOaxTtjgyGBwTY27ybDKEV+leO
         ctbGxjwTEhoCkPbwF3Y4jHr+0JzWD5A6FZXWGWBxaJheMcaJkpmOINCUD1Zb6w2xXOPI
         puXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690462313; x=1691067113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xv0faR8qn1Zj+OjUn+kfjlxGEdmNSeFnyT9mw1cYmU=;
        b=jR+GAq8SsRfbQ450A9EVcLM21IJnIbASNnLUUiQ9WY03UP9eNrmo1acZfvA+WDTxql
         uMAtCseMjrE6UhMbBrgerhjWo0HkwTlIjAV5hcmDmq95H0t0w/cGCDnPmHZeZzGMVI69
         XzE8PMSSCl2oA5yBR3NH7TwCR4Gxn4h9tAZEOQ5hlaAJOMySScEYfmdqr9nWt/YjD4fz
         /WE5sEltHa6mQhzU0uLkG6Aar5MzNAEDwhht541QM8fxWprRId+HqtyWtPsVwImr02B4
         mwZaSx+XIb4BjK9PmZIOKXZuXW5gl0S0c4aCpX2VrlvmQ4Is08mlq4oTghpP35zxLXBa
         NX+A==
X-Gm-Message-State: ABy/qLaithrqg01wegpRvIn2OAMF2nDL3RQUp0EE0czc+eDi/8ZiTiKw
        nXQd/TrsGT3kN9VZx+1PlbM=
X-Google-Smtp-Source: APBJJlG3tK3earJosgCNZih7eD+7O3/4mh8se6jIgdNLuIfAFvARP4j3OueUINSQd9JM8+ovEbyBdA==
X-Received: by 2002:a05:6a21:3298:b0:13a:52ce:13cc with SMTP id yt24-20020a056a21329800b0013a52ce13ccmr5111694pzb.51.1690462312932;
        Thu, 27 Jul 2023 05:51:52 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.115])
        by smtp.gmail.com with ESMTPSA id l4-20020a63be04000000b0055386b1415dsm1315048pgf.51.2023.07.27.05.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 05:51:52 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     edumazet@google.com
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next 2/3] net: tcp: allow zero-window ACK update the window
Date:   Thu, 27 Jul 2023 20:51:24 +0800
Message-Id: <20230727125125.1194376-3-imagedong@tencent.com>
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

Fow now, an ACK can update the window in following case, according to
the tcp_may_update_window():

1. the ACK acknowledged new data
2. the ACK has new data
3. the ACK expand the window and the seq of it is valid

Now, we allow the ACK update the window if the window is 0, and the
seq/ack of it is valid. This is for the case that the receiver replies
an zero-window ACK when it is under memory stress and can't queue the new
data.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 net/ipv4/tcp_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 03111af6115d..d13b89370f76 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3526,7 +3526,7 @@ static inline bool tcp_may_update_window(const struct tcp_sock *tp,
 {
 	return	after(ack, tp->snd_una) ||
 		after(ack_seq, tp->snd_wl1) ||
-		(ack_seq == tp->snd_wl1 && nwin > tp->snd_wnd);
+		(ack_seq == tp->snd_wl1 && (nwin > tp->snd_wnd || !nwin));
 }
 
 /* If we update tp->snd_una, also update tp->bytes_acked */
-- 
2.40.1

