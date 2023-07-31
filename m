Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B667691FD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjGaJn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjGaJnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:43:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F23E57
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:43:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5227e5d9d96so5709183a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1690796597; x=1691401397;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d2tUAJrF65AeK49T7z3MGxwD+iewuRRJjV8qTsLq50Y=;
        b=Mcb0LXJruy1wGXNY4jIYXeoqWAtFgeXRv9/nmoNCieEMlmQf8E7HwRGC3pUmp/JB1B
         8+JIBXjhmA/tMrWXYxkHyxqLbjktz+iJ+b0HdCCAA01AjhDOaJOkuvvGPTrl+XVHZsFl
         5nyqz7j5qeoPW9lYLUxr8VrKWDFGawtUpfk6gpQEerO5hagB1mivFCOmN+TQvBXq/ICV
         McFlQptuYNUgdmc19/uH38HUapDFzfjjBWvAycX8+SRN/qeUkYgmMVtSIxVZji7gHell
         Vl4ZkfdYKv08I72pMDxFqxUNrN5O/LJ/GYaVCtLnvhgrtwgSsbswfFyOL5pL//G/oijx
         vgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796597; x=1691401397;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2tUAJrF65AeK49T7z3MGxwD+iewuRRJjV8qTsLq50Y=;
        b=ACSL3IFfL+megnNpXIXl3abNIhBgloYB0SH0HMQ1BvGHkf+RmiD0gTKPqVEOODkqp+
         uPlNLz6GaKkxewMRu0W++ucucB+4YxsHjlUNEIdKVuyckR5tQgjSu+dQeMk+CRpGhTqP
         rCStovx+A8NHf2LYFbp1HZZ6goPOU1WBVv6ZMvPC15fXTvsejsuj/h7YvCP+vWk+mzLi
         PZcg/IoB+AWfO8ioeYQUAl8vBTf2uzjlH+OQBS2LOWgXvJOETtW2Z4/dqxdF94Q4xodz
         GWiGcYW7t1wot09DkObCyFAIdzx9nCupvYmyV7SnB2b7+f03Cnv+exSWzG+jIt3FUuaX
         CfmA==
X-Gm-Message-State: ABy/qLYLeW9omB0mMgfPAdI1F9P9wYEP9nv7A3u8a5GbOIBtIPhRuFtB
        aL9H0Y9m0Pmz8qdn3tLZW1LwWw==
X-Google-Smtp-Source: APBJJlHb4NbFnFfkMbmuFAREGUpoRUhYrnF47VS1ICTx927ThkBLFtauVXrOMlQAMg2iSIdABTbFTQ==
X-Received: by 2002:a50:fe91:0:b0:522:1956:a291 with SMTP id d17-20020a50fe91000000b005221956a291mr7222481edt.8.1690796597084;
        Mon, 31 Jul 2023 02:43:17 -0700 (PDT)
Received: from [192.168.188.151] (p200300c1c7194400087db22560e9f14e.dip0.t-ipconnect.de. [2003:c1:c719:4400:87d:b225:60e9:f14e])
        by smtp.gmail.com with ESMTPSA id by30-20020a0564021b1e00b00522d53bff56sm363024edb.65.2023.07.31.02.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:43:16 -0700 (PDT)
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Mon, 31 Jul 2023 11:42:53 +0200
Subject: [PATCH bpf-next] net: remove duplicate INDIRECT_CALLABLE_DECLARE
 of udp[6]_ehashfn
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-indir-call-v1-1-4cd0aeaee64f@isovalent.com>
X-B4-Tracking: v=1; b=H4sIAByCx2QC/x3MQQqAIBBA0avErBtoUii6SrQoHWtATDQikO6et
 HyL/wtkTsIZpqZA4luynKGC2gbMsYadUWw19F2vukERSrCS0KzeoyM9aFakadRQg5jYyfPPZti
 iw8DPBcv7fqU/LUBmAAAA
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Lau <martin.lau@linux.dev>,
        Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are already INDIRECT_CALLABLE_DECLARE in the hashtable
headers, no need to declare them again.

Fixes: 0f495f761722 ("net: remove duplicate reuseport_lookup functions")
Suggested-by: Martin Lau <martin.lau@linux.dev>
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
As pointed out by Martin there are some duplicate macro invocations
in my recent SO_REUSEPORT support for sk_assign patchset.

Remove the declarations in the .c files.
---
 net/ipv4/inet_hashtables.c  | 2 --
 net/ipv6/inet6_hashtables.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 6a872b8fb0d3..7876b7d703cb 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -333,8 +333,6 @@ static inline int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
-INDIRECT_CALLABLE_DECLARE(inet_ehashfn_t udp_ehashfn);
-
 /**
  * inet_lookup_reuseport() - execute reuseport logic on AF_INET socket if necessary.
  * @net: network namespace.
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 7c9700c7c9c8..b0e8d278e8a9 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -112,8 +112,6 @@ static inline int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
-INDIRECT_CALLABLE_DECLARE(inet6_ehashfn_t udp6_ehashfn);
-
 /**
  * inet6_lookup_reuseport() - execute reuseport logic on AF_INET6 socket if necessary.
  * @net: network namespace.

---
base-commit: fb213ecbb8ac56b2d5569737f59126e91f87829a
change-id: 20230731-indir-call-f1474e314184

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>

