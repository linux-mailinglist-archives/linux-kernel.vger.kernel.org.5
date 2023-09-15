Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03977A1CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjIOK7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjIOK7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:59:46 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71461D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:59:41 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-993d7ca4607so152492866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694775580; x=1695380380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3DxUvEg+3g6OhCwS+K/sONLa3J3FFOGvmkB4cPhPPQ=;
        b=jM9yoZmgXs7EqL1Jxcr3PrzkI1HmyIq50nPIQf1AQTR91kFWFnSUVKrUGXF8bBgwRR
         QIiURFlFD7QW0CC4frsPrl/cyYAWHx0CavTt9lVVRlHu8W00lI8Q2WhfmHckiL/1J6Hg
         jUzkDkBXS5H2AMd/p9DUpbGnVDvPwYexmUhygIICOwLPuuJWxE6MOGyENv60pcvZucst
         ZuINFfczGmlxBLbuKE2+GsvqgkhxQQEdllr0T5j+j86+rQGPtOqxUAUeQidd6OI31sW9
         eFzjjVNQA8lic2JJHFFxQPpTYB1TiMPdym0mE/VDtK4ClVamHDnE8cXBCofN/I3MdPSA
         D/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775580; x=1695380380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3DxUvEg+3g6OhCwS+K/sONLa3J3FFOGvmkB4cPhPPQ=;
        b=GD5dF8yJE2EwpJQNw0meEv4FL+OZGel/+M5rIf1xj2tzlHBeufkDSsxNJMJxzMnepu
         PsJ8oIJarxXPI6UXHDYwf79G/aEAVVse3+0VW+6mbSQtYw3UambqwlyVE84YSDGIOj8O
         CnbPZTDe7/nrjfCSh8aByIpmrFJXQZlHkO46hkxvsa6PSy9RALuAx0jICdJs632/JjwU
         oFuvbIBlKwUPCw64uvnhQ4wcSH4scJqkBBO4K42mhMMjXQRMmd+eq2FDXiij+7fTMR/t
         i+aHhwwuiNOWzKMI2INsOYl19Ln4PLGUrT6oyifEYdLTxj7cnQmKh9AMeBdId5hJnMnO
         oASQ==
X-Gm-Message-State: AOJu0YwpTKOWPdX4a03OHmzkF1YCM6sBLH7U4LuyW3kUK1Tr2qbg5Sce
        MVdi2pla1FkQIlK89QAn/dk3+3Ci+yAOojZrwg==
X-Google-Smtp-Source: AGHT+IFQRtSOFovuH5GEqReIKr5W2Ia+jznFnJVU0a2nrbLVpMe5HKKOvwnQcx9qn1Ns4cZ4yXwA2xDWIO7cNyXrLQ==
X-Received: from mr-cloudtop2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:2a6])
 (user=matteorizzo job=sendgmr) by 2002:a17:907:cb13:b0:9a1:cac8:6448 with
 SMTP id um19-20020a170907cb1300b009a1cac86448mr7245ejc.2.1694775579655; Fri,
 15 Sep 2023 03:59:39 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:59:20 +0000
In-Reply-To: <20230915105933.495735-1-matteorizzo@google.com>
Mime-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915105933.495735-2-matteorizzo@google.com>
Subject: [RFC PATCH 01/14] mm/slub: don't try to dereference invalid freepointers
From:   Matteo Rizzo <matteorizzo@google.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org
Cc:     jannh@google.com, matteorizzo@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

slab_free_freelist_hook tries to read a freelist pointer from the
current object even when freeing a single object. This is invalid
because single objects don't actually contain a freelist pointer when
they're freed and the memory contains other data. This causes problems
for checking the integrity of freelist in get_freepointer.

Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
---
 mm/slub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index f7940048138c..a7dae207c2d2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1820,7 +1820,9 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
 
 	do {
 		object = next;
-		next = get_freepointer(s, object);
+		/* Single objects don't actually contain a freepointer */
+		if (object != old_tail)
+			next = get_freepointer(s, object);
 
 		/* If object's reuse doesn't have to be delayed */
 		if (!slab_free_hook(s, object, slab_want_init_on_free(s))) {
-- 
2.42.0.459.ge4e396fd5e-goog

