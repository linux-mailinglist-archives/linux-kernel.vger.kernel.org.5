Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECA57F2370
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjKUCBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjKUCB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:01:28 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DB5F9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:01:24 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40806e4106dso14669625e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700532083; x=1701136883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZExWn2HUbFMStGLP1W6Y7/MeyCrX5kAskFZ5sfppJnI=;
        b=BwUvv7uKuMsQtrhs3/FuJhn+wgU99uTqAWBF9cI3uv67Y7zmJPNmxPKi0Giq7eqrl7
         hHgfWQVdS5+TfbbOp67ladHgt2VJilm8JUNvdl7bySl1/vwNLEeXWvUkExdvZBg0a+kg
         yfBAOqxIuybZsz1YwMBnNIiaiISOg5ybONGvxnXwpBryWNXVsEso+ghQcqECwJPlxdkZ
         UofSjY6mqd+BImvkYXQtGO0MeBMrsSiuKCRUrP4fZzA2UfOo74W+9Henlp3dSLvUKTPW
         LqaH2vBRakc4d5ZyigWcX7cNwk4FAuna3w8MYSN4a79ym3jdqs1ON6EXnqg3lyeJOS4I
         mc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532083; x=1701136883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZExWn2HUbFMStGLP1W6Y7/MeyCrX5kAskFZ5sfppJnI=;
        b=jlGSuOir/9CvJsAMUcjQkF/TKTQwNGV/csYecwal6dpE0UPnmyA9kPqgsVrkIWsXrS
         ovdI18Vl8EvfGH7cGUq85TfQ+F6seOxGhRC/qhMw+lnLwBN6IUakJLwzvsV+mbhbobZi
         zMeN91PQ5NJHeTM4p7O+aWcZaliJfK8Ts7guATYsjAgeJja9jrzbDO7lyjSO71urE++p
         tilFLxJBbqlC+x0z4e38aAoOO/qUP8Xd8MvRylFoAVE4zTtEigRsVtwxlJafXAL8EGZl
         OLor2PwXFXL2w9G+SC04nDb+tmlcg5G4C50tI/tuMtrz7p7Tvclw5TM2Lx9P+7JqtAcG
         7lBQ==
X-Gm-Message-State: AOJu0YzUPQwx1Roqkv5UrRQlttZk9e31/wqI6W6M1SUVtFUCJs60lcWO
        WlDvLzGO/T2cUUkI0c3KjpLXTA==
X-Google-Smtp-Source: AGHT+IGwH+Jm3fhAA2Y4A+PtIJ/Xkb9mBkTjQwrh6HTcGOyrbjlcqDCPoP+VO0DQh3tKq4GMTPx0eg==
X-Received: by 2002:a1c:4c09:0:b0:407:73fc:6818 with SMTP id z9-20020a1c4c09000000b0040773fc6818mr893800wmf.2.1700532082945;
        Mon, 20 Nov 2023 18:01:22 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c13-20020a056000184d00b00332cb846f21sm2617105wri.27.2023.11.20.18.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:01:22 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH 3/7] net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
Date:   Tue, 21 Nov 2023 02:01:07 +0000
Message-ID: <20231121020111.1143180-4-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121020111.1143180-1-dima@arista.com>
References: <20231121020111.1143180-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Listen socket is not an established TCP connection, so
setsockopt(TCP_AO_REPAIR) doesn't have any impact.

Restrict this uAPI for listen sockets.

Fixes: faadfaba5e01 ("net/tcp: Add TCP_AO_REPAIR")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/tcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 53bcc17c91e4..2836515ab3d7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3594,6 +3594,10 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case TCP_AO_REPAIR:
+		if (sk->sk_state == TCP_LISTEN) {
+			err = -ENOSTR;
+			break;
+		}
 		err = tcp_ao_set_repair(sk, optval, optlen);
 		break;
 #ifdef CONFIG_TCP_AO
@@ -4293,6 +4297,8 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	}
 #endif
 	case TCP_AO_REPAIR:
+		if (sk->sk_state == TCP_LISTEN)
+			return -ENOSTR;
 		return tcp_ao_get_repair(sk, optval, optlen);
 	case TCP_AO_GET_KEYS:
 	case TCP_AO_INFO: {
-- 
2.42.0

