Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9967574E3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjGRHD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjGRHD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:03:56 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FAA1AC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:03:55 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso48836515e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689663834; x=1692255834;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKhUip0PnDfA0irAdbFiKaOHVjUbRVp4s07pXzgNeRM=;
        b=IdoKdKMiMvD6TslkQXBIJ08QGkKo/w8prfMGKneCYH+NO5ZXbZ9ksBMV4URFvkdQS+
         kUR+OZhnupRenFbuOMkbfcMOPFQzhLG/k5dFSSj6VrfHI4p1neG9eyNDHvwJpQrxemMy
         jpz/C4bNm0aOFT/i5paPxrMP//mFdgXpkOYOX+dBb4/9f9TpFtEbJ/iSqyN2nxhAFqvW
         SRk6LPJJlXsIU3TcyNja5lnOqwN/pAUP7DSr0RzztuzRZpdway2LVhUbyLmVcu4u/q+J
         wdVsgu3YA0AeEy0XA+7gNZcZynRwqzkLdJkXZ/9FeeOhPNFg+eLg3jh1iPrL+FfEPMaz
         SL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689663834; x=1692255834;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKhUip0PnDfA0irAdbFiKaOHVjUbRVp4s07pXzgNeRM=;
        b=AGLZJsSlZUsmYgWA30M3nUHISg+TQVNnLVx2PrA5XtIBxBElVrkW5ztS6a8LbJa+YD
         RIBExY1AA93nFpxWQY4VB6o4cdgeU+a48NrDnA2xlDTP+IgwxtaxHs2hCQLKfgCrVLTl
         TKhzzYuQ7aJ99mgxetKAO5ddYcUp7Fc3q7//JkxlkkYRQvAICf45BrPR/VPFluqqvLrV
         /yTisTH6LFa92EY1IRc9Mrkc2EDkGdiA6TKrb0w0MXizp5ESk7UELOOHE110n1su6mbh
         tCb3FTO5Sm+4kKwhLbGJHHfbAuKY5R9uzgS3dPdKdvWa0Z39uijuPp5mZgIApyFOhhJr
         yrJg==
X-Gm-Message-State: ABy/qLZNsPFxOLMpCQqEZ7VRbqsPfnsa/7vBh2hyx3lhMwqvCUvOlCPn
        ozzGXDuykavB1jiA4qmJZV8Fkw==
X-Google-Smtp-Source: APBJJlHfvHNEoZg8IkGxubThfVC+Ptja0xZZWZ7+R5eOiDUWfpCkd0ddPHNKcaxISr0g0kVD+rRX+A==
X-Received: by 2002:a7b:c846:0:b0:3f8:fc2a:c7eb with SMTP id c6-20020a7bc846000000b003f8fc2ac7ebmr1014417wml.5.1689663833802;
        Tue, 18 Jul 2023 00:03:53 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c22d400b003fbc9d178a8sm9513810wmg.4.2023.07.18.00.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:03:52 -0700 (PDT)
Date:   Tue, 18 Jul 2023 10:03:49 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] driver core: test_async: fix an error code
Message-ID: <1e11ed19-e1f6-43d8-b352-474134b7c008@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test_platform_device_register_node() function should return error
pointers instead of NULL.  That is what the callers are expecting.

Fixes: 57ea974fb871 ("driver core: Rewrite test_async_driver_probe to cover serialization and NUMA affinity")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/base/test/test_async_driver_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/test/test_async_driver_probe.c b/drivers/base/test/test_async_driver_probe.c
index 929410d0dd6f..3465800baa6c 100644
--- a/drivers/base/test/test_async_driver_probe.c
+++ b/drivers/base/test/test_async_driver_probe.c
@@ -84,7 +84,7 @@ test_platform_device_register_node(char *name, int id, int nid)
 
 	pdev = platform_device_alloc(name, id);
 	if (!pdev)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	if (nid != NUMA_NO_NODE)
 		set_dev_node(&pdev->dev, nid);
-- 
2.39.2

