Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C066776CBBF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbjHBLZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjHBLZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:25:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F8426A2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Ms9C/9A0FSfh2mm0WkpMIkoUR7i908GJu9ttwY7f2Do=; b=cIQ2HGS3cP+XZMAtZq1Byn+y8c
        U6DlXjpXUogUNUSsU3Z/1ZMmPDYlKpmMaVpsqTeUfuzKfKAtuEa8fIhvGTCGikB9NwA4+OyMZP0O2
        F1SjnDk9AAd/CZiynZUd/LrY33NGVtR02jhaOeD4VHdmMkUTF5iTCMJSIZTaqabUyV2Idp2V2x2eu
        WOMLrKY0EFewFV2acVGKDuowTdZtXhDvF5Xq+hIMucWL4URCGJ0fxBrUJ9FUby0KkdYUxQtTw9mYe
        dmr/LSi244V/6B2b6X+UyISaTrNIpJX1KZ6WfW0mVLGa9NsttKQ9+45uvDf0XNcOePanj4+Cxcwjx
        13N4T+3w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qR9yx-00FtnU-16;
        Wed, 02 Aug 2023 11:25:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9D59F3001DD;
        Wed,  2 Aug 2023 13:25:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 812F52107C43B; Wed,  2 Aug 2023 13:25:34 +0200 (CEST)
Message-ID: <20230802112525.564928240@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Aug 2023 13:24:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Cc:     peterz@infradead.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, rppt@kernel.org
Subject: [PATCH 1/2] mm: Mark nr_node_ids __ro_after_init
References: <20230802112458.230221601@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like nr_cpu_ids, nr_node_ids covers the side of possible_map and
is thus constant after init.

Mark the variable __ro_after_init to both improve performance and
enhance security, since the variable is exported. A module writing to
it would be 'unfortunate'.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 mm/page_alloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -305,7 +305,7 @@ int movable_zone;
 EXPORT_SYMBOL(movable_zone);
 
 #if MAX_NUMNODES > 1
-unsigned int nr_node_ids __read_mostly = MAX_NUMNODES;
+unsigned int nr_node_ids __ro_after_init = MAX_NUMNODES;
 unsigned int nr_online_nodes __read_mostly = 1;
 EXPORT_SYMBOL(nr_node_ids);
 EXPORT_SYMBOL(nr_online_nodes);


