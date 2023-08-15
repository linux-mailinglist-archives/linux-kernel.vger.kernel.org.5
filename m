Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F24477D6B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240658AbjHOXhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240624AbjHOXgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:36:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B98B13E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:36:50 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc5acc627dso40009525ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692142609; x=1692747409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VO+SrF+5VgwP9Hr4BPfpf01QUQcSzSGpK+hCjWqxDDI=;
        b=m+YpORYKHBZRy0daTvbNKQ7OxF8whqpiLWwnJp2GH2f4C6O3WUHnm5z6MNSHaPxpdX
         BX7U3CmPSP3YbJuU8mzjJLR3OGCMlkrPLwOTHl74zrub0EiGo/d9K3abHMEdkxtPTZpS
         OZ/QxsYop9BHdgvtgaTWbd3sGlQSiTDVVCwF8C7Ok7EcFLVCrvs/AIc9mC6m9CDtjNy8
         PgegimvAH/05/6QwwCc8a1djO6h15/swKMMU1aAp8VJ5sCO+D6kc+R1u/NAzLCMiTS1f
         TWozFokWkbjzCaxIr2GXfNQhJhcdJjjwzclUDSjTNSQffVEK7+sgJXSMar47uNN84CXz
         4qSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692142609; x=1692747409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VO+SrF+5VgwP9Hr4BPfpf01QUQcSzSGpK+hCjWqxDDI=;
        b=a8ZpjpP95HDlFZFuLAL46YAMPL7RgxtgIX4V6Sj8S7QnPZwX8YI+RObUn2ZzPQDsS5
         tov+4eq7o9QybgPTrODYJP0mjlA8tjocjL/rQ8167gWQvoLI1wp37IWEWl4rwEGttPFz
         S7m+OvNKRrdhKVdgiyfJKSV9wtaNBlsxXrXgBzCvVdLta87JClUuoTHk+ckRIUn3WBcO
         9PBo3Cps5ScNbMkS7T23yqnRXwVBoFDLTjMqTqsKGp1CuVAgZHBJRSK4J0aelQX3OzkS
         nioo47KJUgEBY+LeZWZCgnmt2B+XYi+Aiz5v2r+i1gOEaXDaIYBt4NjMwOtArbSVi8RN
         0zvA==
X-Gm-Message-State: AOJu0Yy7TQ9xOJHMt0eIrMcfAfIEWU48Vl0h8hz/wZPZOtSt5kUqiR72
        OqZdIGUaoNHqoV8nWT4S3ZhT5vBYDog=
X-Google-Smtp-Source: AGHT+IFYoR0BMzpCcKWs/U9BPFs89FaiscuKJLHcnTxEmj/DzeFIqKVD2MuVt7kbvtEIlAUx4aQS3A==
X-Received: by 2002:a17:902:c94a:b0:1bc:6e8c:eeff with SMTP id i10-20020a170902c94a00b001bc6e8ceeffmr359942pla.43.1692142609116;
        Tue, 15 Aug 2023 16:36:49 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902e74500b001b9de2b905asm11582621plf.231.2023.08.15.16.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 16:36:48 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v3 5/8] bitmap: replace _reg_op(REG_OP_RELEASE) with bitmap_clear()
Date:   Tue, 15 Aug 2023 16:36:25 -0700
Message-Id: <20230815233628.45016-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815233628.45016-1-yury.norov@gmail.com>
References: <20230815233628.45016-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_reg_op(REG_OP_RELEASE) duplicates bitmap_clear(). Fix it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index b7ea47b9f09d..2898ec2bdef1 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1337,7 +1337,7 @@ EXPORT_SYMBOL(bitmap_find_free_region);
  */
 void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
 {
-	__reg_op(bitmap, pos, order, REG_OP_RELEASE);
+	bitmap_clear(bitmap, pos, BIT(order));
 }
 EXPORT_SYMBOL(bitmap_release_region);
 
-- 
2.39.2

