Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3507C7A84
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjJLXlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjJLXlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:41:18 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC32DD
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:41:17 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7a2cc9ee64cso60848539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1697154076; x=1697758876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lPotT7caJ2i4rnfmOn5KsESAOXBOrfHJSZKahlwL+g=;
        b=P4uS1OVAhhol/x5j9dfFaJZXBZAXoZyPEY4vGo1aH2YNwyG/8LORaaKOa6FXc/pdVM
         IWVVoy7gOpYDXLGZtyh12nuKINDOOnT1kNTtj1tXdOBFPl8iX+D8NOv+elRuyF5jpl4+
         AF0pjlkicHLO5bX5Ba/zUaFxzNF40KYAJBzh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697154076; x=1697758876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lPotT7caJ2i4rnfmOn5KsESAOXBOrfHJSZKahlwL+g=;
        b=PFsjwZhggp0U1D3IsKVI5eMIs6VmnTSrCiuRdvwSgymGsp3UPTzmoTp6tbJ8LXYRXZ
         ZqC4inE5SNi2WqYkemnsFYKB0qcSysLGvXZVElzbLicdaWJcsTtiQ2vJsAdqiRQWJXjV
         UptAF9B2XRAXCoWnQtRD7H4mzQJio63kHV7i1wbJJDhr8KBu+aV9/zqikEc5iosAeqSO
         1dk7D8mGFN85zZGgm2Ghm80Z6+Ed1KA1CzqI2w4v/FT8eef965mMCOk85EP0QbmBVUvt
         V1KbJj7Iroo6KQSHTbjWeQQu040laZofcFrL9yU/YWldZv2JvBzrYOX3Re6FfRvSMMuI
         WRtA==
X-Gm-Message-State: AOJu0YyPmEXGHOBh+WeM7sCCiAT++bE3USU1Zmak27iHCA+UpgncwqZb
        2kWiIrFJlRJsVnOz06HojZSwhg==
X-Google-Smtp-Source: AGHT+IHVcCcrRF23qP1MJVBs2OIkv1QitZZk132Zae4UHLUIu2aj2KVqpLdgi6v/dJwUgreFF9xBIA==
X-Received: by 2002:a6b:f319:0:b0:783:63d6:4c5 with SMTP id m25-20020a6bf319000000b0078363d604c5mr29820716ioh.12.1697154076350;
        Thu, 12 Oct 2023 16:41:16 -0700 (PDT)
Received: from localhost.localdomain (d14-69-55-117.try.wideopenwest.com. [69.14.117.55])
        by smtp.gmail.com with ESMTPSA id c6-20020a5ea806000000b0078702f4894asm4480238ioa.9.2023.10.12.16.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 16:41:15 -0700 (PDT)
From:   "Nabil S. Alramli" <nalramli@fastly.com>
To:     sbhogavilli@fastly.com, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     srao@fastly.com, dev@nalramli.com
Subject: [net] ipv4: Fix broken PMTUD when using L4 multipath hash
Date:   Thu, 12 Oct 2023 19:40:25 -0400
Message-Id: <20231012234025.4025-1-nalramli@fastly.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20231012005721.2742-2-nalramli@fastly.com>
References: <20231012005721.2742-2-nalramli@fastly.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suresh Bhogavilli <sbhogavilli@fastly.com>

On a node with multiple network interfaces, if we enable layer 4 hash
policy with net.ipv4.fib_multipath_hash_policy=1, path MTU discovery is
broken and TCP connection does not make progress unless the incoming
ICMP Fragmentation Needed (type 3, code 4) message is received on the
egress interface of selected nexthop of the socket.

This is because build_sk_flow_key() does not provide the sport and dport
from the socket when calling flowi4_init_output(). This appears to be a
copy/paste error of build_skb_flow_key() -> __build_flow_key() ->
flowi4_init_output() call used for packet forwarding where an skb is
present, is passed later to fib_multipath_hash() call, and can scrape
out both sport and dport from the skb if L4 hash policy is in use.

In the socket write case, fib_multipath_hash() does not get an skb so
it expects the fl4 to have sport and dport populated when L4 hashing is
in use. Not populating them results in creating a nexthop exception
entry against a nexthop that may not be the one used by the socket.
Hence it is not later matched when inet_csk_rebuild_route is called to
update the cached dst entry in the socket, so TCP does not lower its MSS
and the connection does not make progress.

Fix this by providing the source port and destination ports to
flowi4_init_output() call in build_sk_flow_key().

Fixes: 4895c771c7f0 ("ipv4: Add FIB nexthop exceptions.")
Signed-off-by: Suresh Bhogavilli <sbhogavilli@fastly.com>
---
 net/ipv4/route.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index e2bf4602b559..2517eb12b7ef 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -557,7 +557,8 @@ static void build_sk_flow_key(struct flowi4 *fl4, const struct sock *sk)
 			   inet_test_bit(HDRINCL, sk) ?
 				IPPROTO_RAW : sk->sk_protocol,
 			   inet_sk_flowi_flags(sk),
-			   daddr, inet->inet_saddr, 0, 0, sk->sk_uid);
+			   daddr, inet->inet_saddr, inet->inet_dport, inet->inet_sport,
+			   sk->sk_uid);
 	rcu_read_unlock();
 }
 
-- 
2.31.1

