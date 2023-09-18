Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5309A7A458A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240958AbjIRJH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240909AbjIRJH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:07:27 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806D311B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:07:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-405082a8c77so9372585e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695028037; x=1695632837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xNWBbowpPNcs9LaK+ptrn/ouCnrMBl4OCrJ6OsS7em4=;
        b=iHsYhatPFE6pQgm4cZGe5DzP0nAt0SkxMu29setdbRmoGwo9nDg12WcAOtkMRri+0O
         xiAVUxh209iwlo4TsvNE+l8U5Hx/TxU9eWCDlZ3tn/Gpjijm2c0y2ASd4pgxlobSAuX4
         UB/qZXiiEHjhsoLh6TE7fnDiHEXbgWfFJUSQgAxfbywaa1Y3MoeQNE6mvacSSoE+pGpr
         Y76oA5NUtTvxoc6uplybhlKmzwiI7gTBUlsN/jBV/JUPqKG0Yd1KfkVf3vn63jQDdTJu
         HLC4xH79NW0IJmwrlURjwphDWhPvTjEOh0twYo0PsjK+1M2Fy6auAeM9QK5yB1oJWJk5
         yuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695028037; x=1695632837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNWBbowpPNcs9LaK+ptrn/ouCnrMBl4OCrJ6OsS7em4=;
        b=G5B3BSiPLX0/XkZEYmsm6K6neMybvXF29vyn/Fngl/A7hSnKVwsrbRApxJC5DF8Ebp
         St3DbYO2XTOnCVm0aouVEDA1J/RUqXE2o4z90nmVGf+nDN5HP6XgWWmu+0l7Efg5PJaM
         bab4b8NkJ8ZIDWvjMzUuuYBvZGhzBLOZADXU3UdzDcAhOdR87j5Hu5kdPArsbfeCtYZ6
         aZSMoLfbXg95InxM38Zz1tx2qhuUl+2jQBtBjJC1xjJ6AG8gBPE0/CDLvAZGr+S4eTod
         nDlclKg97lrfOZHfvBh9KUW5CkzCrgJmJBzjWlrH7CaZhdh29DyCiGg1zsjZuCyVJ5RL
         dl8Q==
X-Gm-Message-State: AOJu0YzLnhJnc1qlru31JDYqWhKxsJrnM5OFvYxEjQhhoRmJJPbFiifi
        FEPQf0rayrkE4RXPcEmVlUlbCA4S3K3U0E8Fif8=
X-Google-Smtp-Source: AGHT+IFBPaGt2yxM9TlXqldEJik1sQouinGGgFcs+s1Jio8shuflUfH9PeXgm7wD4vt2kXOfmxZ3jg==
X-Received: by 2002:adf:fb50:0:b0:31f:d7bb:481e with SMTP id c16-20020adffb50000000b0031fd7bb481emr6688626wrs.63.1695028036929;
        Mon, 18 Sep 2023 02:07:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b5c7:0:92ea:b5cb:b0fc:68a5])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d484b000000b00317ddccb0d1sm11929327wrs.24.2023.09.18.02.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 02:07:16 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
        muchun.song@linux.dev, mike.kravetz@oracle.com, rppt@kernel.org,
        songmuchun@bytedance.com, fam.zheng@bytedance.com,
        liangma@liangbit.com, punit.agrawal@bytedance.com,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH] memblock: add missing argument definition
Date:   Mon, 18 Sep 2023 10:06:57 +0100
Message-Id: <20230918090657.220463-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
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

Description of argument memblock_type was missing in the commit
that introduced it.

Fixes: 70083e1c8ab4 ("memblock: pass memblock_type to memblock_setclr_flag")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 mm/memblock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 8f7a0cb668d4..fd492e5bbdbc 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -892,6 +892,7 @@ int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
 
 /**
  * memblock_setclr_flag - set or clear flag for a memory region
+ * @type: memblock type to set/clear flag for
  * @base: base address of the region
  * @size: size of the region
  * @set: set or clear the flag
-- 
2.25.1

