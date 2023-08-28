Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BADC78BAE1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 00:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjH1WO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 18:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjH1WNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 18:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C792129
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693260787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UxpDpPAMPR581hkKTSpjHx5QGnh304423RA3WXpTtQw=;
        b=PDlUU9ew3Exc2SKTetzdvVhaO5hha5iWrpa1sBeiDkJAwp/GQgoQXlwaEpyyvVB82Q/ipd
        /8Nfdphmu0abi6vmincN+clpNt+QJjSA3YntpV42zKTJdjGLakGRaGB1LGDMf7SIIGf4em
        /2BzPvB+XNwDvLKHT+gYSPLkIkWw5zo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446--bkHvolmNvWFZKT8dRxZ0Q-1; Mon, 28 Aug 2023 18:13:03 -0400
X-MC-Unique: -bkHvolmNvWFZKT8dRxZ0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97018101A52E;
        Mon, 28 Aug 2023 22:13:02 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14AD86B2B6;
        Mon, 28 Aug 2023 22:12:58 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Harald Welte <laforge@netfilter.org>,
        netfilter-devel@vger.kernel.org (open list:NETFILTER),
        coreteam@netfilter.org (open list:NETFILTER),
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-kernel@vger.kernel.org (open list)
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Lucas Leong <wmliang@infosec.exchange>, stable@kernel.org
Subject: [PATCH nf] netfilter/xt_sctp: validate the flag_info count
Date:   Mon, 28 Aug 2023 19:12:55 -0300
Message-ID: <20230828221255.124812-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sctp_mt_check doesn't validate the flag_count field. An attacker can
take advantage of that to trigger a OOB read and leak memory
information.

Add the field validation in the checkentry function.

Fixes: 2e4e6a17af35 ("[NETFILTER] x_tables: Abstraction layer for {ip,ip6,arp}_tables")
Reported-by: Lucas Leong <wmliang@infosec.exchange>
Cc: stable@kernel.org
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 net/netfilter/xt_sctp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/xt_sctp.c b/net/netfilter/xt_sctp.c
index e8961094a282..b46a6a512058 100644
--- a/net/netfilter/xt_sctp.c
+++ b/net/netfilter/xt_sctp.c
@@ -149,6 +149,8 @@ static int sctp_mt_check(const struct xt_mtchk_param *par)
 {
 	const struct xt_sctp_info *info = par->matchinfo;
 
+	if (info->flag_count > ARRAY_SIZE(info->flag_info))
+		return -EINVAL;
 	if (info->flags & ~XT_SCTP_VALID_FLAGS)
 		return -EINVAL;
 	if (info->invflags & ~XT_SCTP_VALID_FLAGS)
-- 
2.41.0

