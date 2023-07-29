Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085317681D0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 22:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjG2Uhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 16:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjG2Uhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 16:37:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512B918B;
        Sat, 29 Jul 2023 13:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF9A260765;
        Sat, 29 Jul 2023 20:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF87C433CA;
        Sat, 29 Jul 2023 20:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690663058;
        bh=obtSlnvy07n5RqMkT9ft+YWwsEmXSmZYdkX6jt7/ZH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sdAWiTrM5jLNvyEBr96k2bMsZpKhmFnONlHBuxh9ggS6iOcSUvJwgxLYzbHzBg9wS
         Ru1MQ8gRyCCNabq0iEEj553U3cF/LPfy0Z0RP1lLlqIranr3CxrK7kwMlydMcHIEt2
         mSWUspQMNOceTsGydjYASOP5JF4GQDXRDt5LbRC1/bnb+Qf5GF270paW1Empm5JTfE
         pms39T+3hsMPHK1s1xJXi3Qz6XelHOE+8iQjtuS/sHfhyIDLjibfxH9NuWXDhb97Ui
         CwFQtevzKuW9qy+wLJDw5htGv071KBVoNdVp8kywCJ2s4wKeX4TOrviMNnxZTvwnyQ
         9TIBw3B3hZQIQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm/damon/core: initialize damo_filter->list from damos_new_filter()
Date:   Sat, 29 Jul 2023 20:37:32 +0000
Message-Id: <20230729203733.38949-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230729203733.38949-1-sj@kernel.org>
References: <20230729203733.38949-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

damos_new_filter() is not initializing the list field of newly allocated
filter object.  However, DAMON sysfs interface and DAMON_RECLAIM are not
initializing it after calling damos_new_filter().  As a result,
accessing uninitialized memory is possible.  Actually, adding multiple
DAMOS filters via DAMON sysfs interface caused NULL pointer
dereferencing.  Initialize the field just after the allocation from
damos_new_filter().

Fixes: 98def236f63c ("mm/damon/core: implement damos filter")
Cc: stable@vger.kernel.org # 6.3.x-
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 91cff7f2997e..eb9580942a5c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -273,6 +273,7 @@ struct damos_filter *damos_new_filter(enum damos_filter_type type,
 		return NULL;
 	filter->type = type;
 	filter->matching = matching;
+	INIT_LIST_HEAD(&filter->list);
 	return filter;
 }
 
-- 
2.25.1

