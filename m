Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05CC7C6938
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbjJLJPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbjJLJPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:15:16 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F17D6D;
        Thu, 12 Oct 2023 02:14:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-406650da82bso7411795e9.3;
        Thu, 12 Oct 2023 02:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697102082; x=1697706882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xp3NeHp2th35KpL6HLgaJLB+RFFyCoVhK7zf77fPzNY=;
        b=i3Ke+CI5VaKjcbrcYQAOGwIkhakrcTyK9iQk5YcQa+IYnAfxjF2aCHBedVhaCEt9En
         I1iVaXGq23fcxWs4mK7KQ8BpCdpXg7tXlCVz+8Sv+sXtE7z9XnktM+yERghwKAqG0f4K
         d9ZzLfR3NP3yMCevyFxlvK8yxDCbyz8VR6QtxwzjNG7OhKRVxA5dXw85TPlM3blo3GRH
         Ic7EaS6WNii+TATrj1oYzjXCVJf20Syud1nhfl494DHufexTEZKuZSAGR/8GaXu4rPDG
         LVbIGmRSgLEQ19OnRUayBUqo70J3WeaVBHPch/rHcgGPI0KG8C50fvL5cY3z9X0JQoY8
         rxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697102082; x=1697706882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xp3NeHp2th35KpL6HLgaJLB+RFFyCoVhK7zf77fPzNY=;
        b=v/BVnSrZOEzwbBNo0PNT/4oYPsuVGU7fTI/5h9TGObo2B0dMyVDpiTXoISWojsXyxp
         OgU24u1/mwMZA46dzqCSK0OBcW7i7R7H+4BeMiUDLlr83kdsMREXYdUmquV49zZP9zfk
         LkvWhtiLHXJTI9mLmpPW8LroZExKjJxOm8ffO2aXrJRVhpcMFj6wT5qT7QFnslgSJkOM
         tpxs3JJzvkO1PNleDsEO8M+LnbmKIWPHzTlJoXAu3J/1Z6bL37pM59IJYi9yU+xf2ncO
         BH1JXxe5I1y6I4LI36qy7AAjy8R4WPe+0RRiukqFaDTTz2xjCDZgdxfrij0GypjIn8Q1
         1+DQ==
X-Gm-Message-State: AOJu0YwITAWQWsySGGhP2BGkNkjAvU78LCG2viGDHhzP8YBwX7V6CJNH
        EdYj9bxsEmHrf51jna7xcsw=
X-Google-Smtp-Source: AGHT+IHWB24cgRbdI1egHQYjLE+HRRaj5b6rXxJM9izmu2YahBKwJCcmvl9ojqNSAGCBVmjKkwY/TQ==
X-Received: by 2002:a5d:664a:0:b0:31f:f91c:d872 with SMTP id f10-20020a5d664a000000b0031ff91cd872mr22652902wrw.19.1697102081883;
        Thu, 12 Oct 2023 02:14:41 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id dh13-20020a0560000a8d00b00327cd5e5ac1sm3257700wrb.1.2023.10.12.02.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 02:14:41 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH] net: cxgb3: simplify logic for rspq_check_napi
Date:   Thu, 12 Oct 2023 11:14:29 +0200
Message-Id: <20231012091429.2048-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify logic for rspq_check_napi.
Drop redundant and wrong napi_is_scheduled call as it's not race free
and directly use the output of napi_schedule to understand if a napi is
pending or not.

rspq_check_napi main logic is to check if is_new_response is true and
check if a napi is not scheduled. The result of this function is then
used to detect if we are missing some interrupt and act on top of
this... With this knowing, we can rework and simplify the logic and make
it less problematic with testing an internal bit for napi.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/chelsio/cxgb3/sge.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c b/drivers/net/ethernet/chelsio/cxgb3/sge.c
index 2e9a74fe0970..dfe4e0102960 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
@@ -2674,12 +2674,7 @@ static int rspq_check_napi(struct sge_qset *qs)
 {
 	struct sge_rspq *q = &qs->rspq;
 
-	if (!napi_is_scheduled(&qs->napi) &&
-	    is_new_response(&q->desc[q->cidx], q)) {
-		napi_schedule(&qs->napi);
-		return 1;
-	}
-	return 0;
+	return is_new_response(&q->desc[q->cidx], q) && napi_schedule(&qs->napi);
 }
 
 /*
-- 
2.40.1

