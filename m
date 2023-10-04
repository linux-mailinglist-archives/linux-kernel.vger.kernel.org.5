Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00A57B765A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 03:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbjJDBo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 21:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjJDBo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 21:44:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5547BAB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 18:44:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-27763c2c22eso1139635a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 18:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696383893; x=1696988693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6m+ltiUxBgyP6O6NGVJRhv6n+IMmSQtxpfXHOcBL8MI=;
        b=cxbpQhcllg9aTHbTy6a3vGKZq5DMQujQscQ01G285jPDoIIoOdHUr3WWFzyyJzvd3d
         KI+VNTG/FSdBUPyYQ3XVZ94EpOo2eOwBG2/yG7rEVFrJ33oiDlQOSWqMPafrHk0QUCrK
         T8Sy7zuVGoRHdu72VNg5Sv31yZiQ9K9VKdldw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696383893; x=1696988693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6m+ltiUxBgyP6O6NGVJRhv6n+IMmSQtxpfXHOcBL8MI=;
        b=xDWNYnQGNGZZ0e/stNUC3sHcgSIAl4EMSjexQv7ZE6hMgp3tCX62i4lPLYWm4Y1f1X
         jhHtRl0DF7WbnTWTSynHrPlFDJlN3vWbv18K456zBos5Rqw0IJNH0bv2qE48b/2EMY+e
         cNZ95cMBQL+xEX7vMGA2JB2kxzyFpq4EAaGrhweq1D8KBAKDITz5fwQ6xxRDKEedisur
         Pf6NHZQ0mBf92s1GqX6AeGpH+fgLenV3me1kQwHI/SpjpK0ZYrJ7zibIZjXEo33lsP6c
         mWFRrSfUKB8pp0h+j96LSimaEAUhoJ3Y5t2+2W0X19aCkdAyJ0z+XLPudelkLO25VtGU
         4jXQ==
X-Gm-Message-State: AOJu0YzdVHybZzDdZjB/tBXls8mOxHDqnkTlYCSOpWRUJBemJE42iCI2
        WRsuj0DwKWDkylSclP1gK38XVw==
X-Google-Smtp-Source: AGHT+IHoFcFaJCYuiM/XpPveaXoTnc32bdzwR7t511qo6mo1UVxZdSWNTi7fDNbl77FYtG6vuNalPQ==
X-Received: by 2002:a17:90b:164f:b0:274:735c:e2d3 with SMTP id il15-20020a17090b164f00b00274735ce2d3mr999366pjb.8.1696383892759;
        Tue, 03 Oct 2023 18:44:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090a030d00b0026971450601sm287996pje.7.2023.10.03.18.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 18:44:52 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     David Ahern <dsahern@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] nexthop: Annotate struct nh_group with __counted_by
Date:   Tue,  3 Oct 2023 18:44:49 -0700
Message-Id: <20231004014445.work.587-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1227; i=keescook@chromium.org;
 h=from:subject:message-id; bh=cMswho+iyVCS84W5fjbN8jRy801YZPgydXwTL+hQ8kc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHMOR/Qnr9xsjz+RFrB//RUqkmhmuWuLMRFIHY
 H/zRm5APC2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRzDkQAKCRCJcvTf3G3A
 JuubD/4pBLzIK8LRipBfuGiuOfRseLiRbFNh1J5EeR0aFUlyz21VWo/ONGuXtGXOxgktDliVWxQ
 pv0tg3RLvxJNCOGY0pFJOG7j7tgN8w7Tn1Eomvh7IHQ5UyysY1/txn95G/iwzma9N0e7cspWjOk
 i71eVTwBrYMFx/XI4JIGT/Y9Zt1Z7uXKyqTlkZXE6kTi3ZsMUE37k9g0yX58iiGmmdLols1ocL0
 rqjyPdN/KncryQkGHLsjMD3SXftQJUoKrZK61q7t0of7ZLGX8o4I0yTevYIk1imAMduLhWTqEYR
 n5BRvPG5JvAE5d8L3VsggU36WF5pidU5c5RPVzoOeztl69WWEB9ecpndC9ok0Z2xCh48x36HD/G
 G8235S8ONP14DbGP/eVc/1yqdWpS4vrLruFiJ1HySU5pHPtGQ2rcuJbbPDQx35xXPl6D7okwBw5
 6MMdORrwX7unzOIOhGIWeKBICZes22QAxOctpG8/+dcQkEIty1JY7KSivhZUA1pxzAp73DIoOtr
 hNj60Fetls5Hcp93vQjT0Ls91cpLL/i80y2sZmrX6m/CIEexZMYuGUrLdBMlDJrEb/v487rDH+P
 CEGyWn17nSifdO3/K+Cm1GoILthQET2DXe6j2wjQk5tbiB+Rs+XVL9eXb9mtQUGsB5NdyB+aJU3
 MmGRBkZ wCCDJXzA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct nh_group.

Cc: David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/nexthop.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index 8f5a2ab45920..d92046a4a078 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -126,7 +126,7 @@ struct nh_group {
 	bool			has_v4;
 
 	struct nh_res_table __rcu *res_table;
-	struct nh_grp_entry	nh_entries[];
+	struct nh_grp_entry	nh_entries[] __counted_by(num_nh);
 };
 
 struct nexthop {
-- 
2.34.1

