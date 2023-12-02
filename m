Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EC8801DCF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 17:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjLBQhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 11:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLBQhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 11:37:17 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DC2114
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 08:37:24 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cdf3e99621so510591b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 08:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701535044; x=1702139844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r/5fy0dH2xzqcER0suoHkQQxma1xoWVm6Ksyzy3Xy6A=;
        b=ecfQc3LwBlUzvq3P/+j0euPU5HVDjuPKEaKwf7TNTggezOnaCRom40Qu6l2SDUA7vN
         WKVapiW8WltxwFX1zPT1yFJh0SdyvbMzbAnsJVPV9awBilvw6a3hZKhdX5a+dct4kJ0N
         jOxac69bFNVZexKsKNgQezvXDe/Mq9ebwEc2rp0IIOLCZjaczjn2iiuHGGfcyvW/K1xT
         lV7z9mz0qWidkzycR7coiLPOzB7bCbFY6TrVnkPhAvwLHWxMaQ/xWw2ra4hEdaLcacXq
         LH16CFFBTEHJ2I978J55tZ/j9T/fSfEcTwwDtP8pIkfH6ZfViaD46nCucu94Xwdh0BfK
         fj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701535044; x=1702139844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/5fy0dH2xzqcER0suoHkQQxma1xoWVm6Ksyzy3Xy6A=;
        b=sa7UQzSo0oSzyh07UFQ+K5XeAXoSJOTwpfk9ax281LwfKlDS+BFHJzrJqOttteXR9z
         dQFh/3qC7ClKrkDkmY4bue1/EyXX0iXuiwaN1NZfBEf5n5SeBHRCluISZm9zyL1wxAQv
         PEkgfarY8Tjwir4loH1/wgsNcp+7XXlZ7IfXWZpfDE89kscItzTYp/UFPN2XO84gnV9N
         97wYCz5vnkoyTBrVKa7A6cn4uBgPBVtXsVBB88PBx5r2IH3dv/wFij2eAr9ep13j1jvR
         I9AIZvJhbTXF5u0T9Cs/anmF8bwAYzCdelmkIVQn9p7n0qYXxgDtjgihfJ8IYo+Q6PwD
         s2sA==
X-Gm-Message-State: AOJu0YyKKJRDMlgbf8q8JZ71QYx+d0Hy0CpzN8sPyBCOHc/K3boIaUYJ
        uzdOh3TuzGJtfr9MebnFpoU=
X-Google-Smtp-Source: AGHT+IHoTx7tpZwwL4PhXWWb1kuDPXhYpTG2eZ5lRVjIoBiMm8qb3iWLFfxP9AByjn/JlcnOuy7pGg==
X-Received: by 2002:a17:902:e80b:b0:1cf:a718:384 with SMTP id u11-20020a170902e80b00b001cfa7180384mr29734467plg.6.1701535043733;
        Sat, 02 Dec 2023 08:37:23 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id jc15-20020a17090325cf00b001d07d88a71esm812533plb.73.2023.12.02.08.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 08:37:23 -0800 (PST)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, lkml@sdf.org,
        Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] lib/sort: Optimize number of calls to comparison function
Date:   Sun,  3 Dec 2023 00:37:17 +0800
Message-Id: <20231202163717.687578-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation continues the loop when the comparison
function returns a non-negative value, which includes the case when it
returns 0. However, in scenarios where the comparison function returns
0, further comparisons are unnecessary. By making this adjustment, we
can potentially reduce the number of comparisons by approximately 50%
in extreme cases where all elements in the array are equal, and the
array size is sufficiently large.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 lib/sort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sort.c b/lib/sort.c
index b399bf10d675..1e98a62bb2f3 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -267,7 +267,7 @@ void sort_r(void *base, size_t num, size_t size,
 			b = c;
 
 		/* Now backtrack from "b" to the correct location for "a" */
-		while (b != a && do_cmp(base + a, base + b, cmp_func, priv) >= 0)
+		while (b != a && do_cmp(base + a, base + b, cmp_func, priv) > 0)
 			b = parent(b, lsbit, size);
 		c = b;			/* Where "a" belongs */
 		while (b != a) {	/* Shift it into place */
-- 
2.25.1

