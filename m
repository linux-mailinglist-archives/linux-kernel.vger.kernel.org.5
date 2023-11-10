Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A67F7E801E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjKJSHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjKJSEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:04:49 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D487AAF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:41:54 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1f48ad1700aso734570fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 22:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699598513; x=1700203313; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yghova5iSMKTBA45oZLzkBRYbxARDuNDN2cHtnXgdHM=;
        b=BhoZytx9aGbbpJgQGCHCDSEH2vyQp5dSqvhH59iurVn7upJPZk2q7XE0kX/P76Fw8Y
         axzpyjGwg1IbUMz6CKAUFwKCTHG4zVj/KOONlAtocEBvT29kcwUzb+E/zlDqPH4BWe+t
         Lvw10lRUzHsYVrAvfoelfT2f1K3JruI4Xgs9rOcqsBa8xFatQQKYa8/D7JPniw5lcjUw
         IclYNryONzmXkZABoV2Gq81T5cK1jyJGeqS03ylyuZkuFb+lb5rFqBE+zPyyivkQ9ZMR
         tKYWgi2Kg5IZ3MCCcGBoJzsraTtYRrLwJeWN22rT8xA1LtcPkuHUxmoLpsYvqszcoP+s
         u+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699598513; x=1700203313;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yghova5iSMKTBA45oZLzkBRYbxARDuNDN2cHtnXgdHM=;
        b=PamTJJwL6fj3o9dig20noI7vu1ImgII8CgWP1nGwMSX496xqHSVzqRdov3phHOLmHh
         x67vKRgJekR9LSNvCCL1dOX/6vcOzkNDPSWLeEuXaFl7q6ku6DKvmbv3hcJ4xJQemdkn
         rdS6bYrxw1+sgoG41x6Ud5Dyd5TB2MAKz0Qs5kkhpxudWmjqOZAA6S6+Iz1IJip9o+fg
         HQvOZ0Pj+e5BlDka8oo5xgzFLtfbQ0qpfQP0ngwbZgzhD4wCbzIqanZ8KqpqVKZo3JO8
         sEOiW4o1RKDehdVF/ArQ8yFt37PXK89wdlwh2Jpww3QPttFvrPDuF+snqHiLZCGY63bI
         wDjg==
X-Gm-Message-State: AOJu0YwVFRPpWxyPpaQeXFh0+gxM/AVdlCtaF5U7fcGzVroegH79blZg
        HbpsvmVZLR7eY8kn78xF7Yh4VuXv1mPrCw==
X-Google-Smtp-Source: AGHT+IHX4POyeIQIz3//DRgsH7ndWRxaItYPn9ftalpBFUAuTC2B6xHM8UGp4ejVrIZQm3GdPGG0ig==
X-Received: by 2002:a05:6a00:8cc8:b0:6c3:3cb0:d85 with SMTP id ij8-20020a056a008cc800b006c33cb00d85mr2116768pfb.0.1699594651019;
        Thu, 09 Nov 2023 21:37:31 -0800 (PST)
Received: from localhost.localdomain ([1.237.29.215])
        by smtp.gmail.com with ESMTPSA id 33-20020a631961000000b005b93dee7fa4sm5682522pgz.50.2023.11.09.21.37.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Nov 2023 21:37:30 -0800 (PST)
From:   Hyeongtak Ji <hyeongtak.ji@gmail.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Hyeongtak Ji <hyeongtak.ji@gmail.com>,
        Hyeongtak Ji <hyeongtak.ji@sk.com>
Subject: [PATCH] mm/damon/core.c: avoid unintentional filtering out of schemes
Date:   Fri, 10 Nov 2023 14:37:09 +0900
Message-Id: <1699594629-3816-1-git-send-email-hyeongtak.ji@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function '__damos_filter_out()' causes DAMON to always filter out
schemes whose filter type is anon or memcg if its matching value is set
to false.

This commit addresses the issue by ensuring that '__damos_filter_out()'
no longer applies to filters whose type is 'anon' or 'memcg'.

Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index bcd2bd9d6c10..d5ef8945a343 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -920,7 +920,7 @@ static bool __damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 		matched = true;
 		break;
 	default:
-		break;
+		return false;
 	}
 
 	return matched == filter->matching;
-- 
2.7.4

