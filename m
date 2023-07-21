Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1023375C77B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjGUNTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjGUNTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:19:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C780930CF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689945496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+qYMYKznWRCQRLs4itQFPGrBm6WN+EZaQC54fSpIxmA=;
        b=FTHaymwQzF2Qk9EwNilR3ERghSd0wsRO2bGEq3Jvwm7TdB7s8prLZYBALLbegbyToWui3o
        DNGwovFA87Gp6FbChE1caTSp3B2C7ewXesG2rR5f8iZPYAREMllz9WqVH/7mKU1UGqgCln
        JlIUSlq8NCIT8XKvdFU9lAOvbZyyhQI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-zn0bPHkSOBi7QroqT667-g-1; Fri, 21 Jul 2023 09:18:13 -0400
X-MC-Unique: zn0bPHkSOBi7QroqT667-g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C24F71C05154;
        Fri, 21 Jul 2023 13:18:12 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0A2C40C2071;
        Fri, 21 Jul 2023 13:18:08 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, mawupeng1@huawei.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/3] mm/percpu.c: remove redundant check
Date:   Fri, 21 Jul 2023 21:17:58 +0800
Message-Id: <20230721131800.20003-2-bhe@redhat.com>
In-Reply-To: <20230721131800.20003-1-bhe@redhat.com>
References: <20230721131800.20003-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conditional check "(ai->dyn_size < PERCPU_DYNAMIC_EARLY_SIZE) has
covered the check '(!ai->dyn_size)'.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/percpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 28e07ede46f6..1480bf283d11 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2615,7 +2615,6 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 	PCPU_SETUP_BUG_ON(ai->unit_size < PCPU_MIN_UNIT_SIZE);
 	PCPU_SETUP_BUG_ON(!IS_ALIGNED(ai->unit_size, PCPU_BITMAP_BLOCK_SIZE));
 	PCPU_SETUP_BUG_ON(ai->dyn_size < PERCPU_DYNAMIC_EARLY_SIZE);
-	PCPU_SETUP_BUG_ON(!ai->dyn_size);
 	PCPU_SETUP_BUG_ON(!IS_ALIGNED(ai->reserved_size, PCPU_MIN_ALLOC_SIZE));
 	PCPU_SETUP_BUG_ON(!(IS_ALIGNED(PCPU_BITMAP_BLOCK_SIZE, PAGE_SIZE) ||
 			    IS_ALIGNED(PAGE_SIZE, PCPU_BITMAP_BLOCK_SIZE)));
-- 
2.34.1

