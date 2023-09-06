Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD1F793B1C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjIFL1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbjIFL1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:27:43 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAAF19AB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 04:26:59 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-501bef6e0d3so2771904e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693999575; x=1694604375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvAW5HglNzFFKY02dQL2QCkQguw1CPVi9WQHfYQdWVQ=;
        b=F/LmyV5XT3asg5nV83+0hPDnPzGaG4y2A38iHqkIFdMMLv2GM7SAC5L7lLJiKg07oj
         AECMS9OVo9+ssAxtPQWjNtIEZkHcnKBovdf7mwmf/3z7jcEQ7wGA7ZquiYRe2PKNgW1n
         oRpeIrKRAZvlq1ugzSOBJD+1/W+hxsozWh8rIbQCnlVN7WztAo3UC9Jqj81Ovqn+HPuP
         4xx3SyTwoiZGml8tQMUraLfMcAzzP26PSjdNmbpDTgO60EkJmeERafLu7n0bfv/sYsvW
         TuyzKvYd9lYjjHjChpq7wgOKftdFtfI5WItTDurFPee3YX84R0MvoeQpnuhitgSGKpdk
         MTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693999575; x=1694604375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvAW5HglNzFFKY02dQL2QCkQguw1CPVi9WQHfYQdWVQ=;
        b=Hfm2BkRYDBRjm/5pKEU9dDJTdzGEhMbBkQQ8XbEBMVGpNhGSdiepHFT98/cEdKh4nK
         TcDkAEB4zUElssb5RXdlwjw2FTE82LR5CvA9SJsr1N+A7Z9xOMa1V51KSh4HR2Y4n3mr
         uknt5utuBa8a1/umZ4MUlp4254LF94b8Afme9bBuPgB2yPDQLcC7zmNwmoRPy7doBiyc
         x/2eUNMbXaWFeFMEjYsoNY0f93Ne2xhNMUJtWspD3aXQOsnJxP5PoWCDCw+5uzhIMKuX
         fjEry9lYlSib4FnvYoH+5BReO92C/eUZZcDBDQ/43CUXZfaBGmN/9vCRbfgSnOR7OSF8
         W1Kg==
X-Gm-Message-State: AOJu0Yy5BpZjx7Ewr/10on8wLuYL3/8969wvzcnUbYARrif6D7aKhk6O
        vl/2xKijoCiKbNvMsWxBzlG2bw==
X-Google-Smtp-Source: AGHT+IELbss0QLtzg1jVEelmiCJSpw2y8Xgxgu0g1ZmM4E+wM/cWOJ04LOlpRaDfgoONu1e0+ddNrg==
X-Received: by 2002:a2e:701a:0:b0:2b9:4413:864e with SMTP id l26-20020a2e701a000000b002b94413864emr2071899ljc.53.1693999575193;
        Wed, 06 Sep 2023 04:26:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b5c7:0:6dce:31d8:efb1:5d81])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c294900b003feff926fc5sm19517038wmd.17.2023.09.06.04.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 04:26:14 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v4 2/4] memblock: pass memblock_type to memblock_setclr_flag
Date:   Wed,  6 Sep 2023 12:26:03 +0100
Message-Id: <20230906112605.2286994-3-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230906112605.2286994-1-usama.arif@bytedance.com>
References: <20230906112605.2286994-1-usama.arif@bytedance.com>
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

This allows setting flags to both memblock types and is in preparation for
setting flags (for e.g. to not initialize struct pages) on reserved
memory region.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/memblock.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 913b2520a9a0..a49efbaee7e0 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -901,10 +901,9 @@ int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
  *
  * Return: 0 on success, -errno on failure.
  */
-static int __init_memblock memblock_setclr_flag(phys_addr_t base,
-				phys_addr_t size, int set, int flag)
+static int __init_memblock memblock_setclr_flag(struct memblock_type *type,
+				phys_addr_t base, phys_addr_t size, int set, int flag)
 {
-	struct memblock_type *type = &memblock.memory;
 	int i, ret, start_rgn, end_rgn;
 
 	ret = memblock_isolate_range(type, base, size, &start_rgn, &end_rgn);
@@ -933,7 +932,7 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
  */
 int __init_memblock memblock_mark_hotplug(phys_addr_t base, phys_addr_t size)
 {
-	return memblock_setclr_flag(base, size, 1, MEMBLOCK_HOTPLUG);
+	return memblock_setclr_flag(&memblock.memory, base, size, 1, MEMBLOCK_HOTPLUG);
 }
 
 /**
@@ -945,7 +944,7 @@ int __init_memblock memblock_mark_hotplug(phys_addr_t base, phys_addr_t size)
  */
 int __init_memblock memblock_clear_hotplug(phys_addr_t base, phys_addr_t size)
 {
-	return memblock_setclr_flag(base, size, 0, MEMBLOCK_HOTPLUG);
+	return memblock_setclr_flag(&memblock.memory, base, size, 0, MEMBLOCK_HOTPLUG);
 }
 
 /**
@@ -962,7 +961,7 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
 
 	system_has_some_mirror = true;
 
-	return memblock_setclr_flag(base, size, 1, MEMBLOCK_MIRROR);
+	return memblock_setclr_flag(&memblock.memory, base, size, 1, MEMBLOCK_MIRROR);
 }
 
 /**
@@ -982,7 +981,7 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
  */
 int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
 {
-	return memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP);
+	return memblock_setclr_flag(&memblock.memory, base, size, 1, MEMBLOCK_NOMAP);
 }
 
 /**
@@ -994,7 +993,7 @@ int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
  */
 int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
 {
-	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP);
+	return memblock_setclr_flag(&memblock.memory, base, size, 0, MEMBLOCK_NOMAP);
 }
 
 static bool should_skip_region(struct memblock_type *type,
-- 
2.25.1

