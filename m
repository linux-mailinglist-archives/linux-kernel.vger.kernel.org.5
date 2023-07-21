Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F6175C33C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjGUJlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjGUJlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:41:31 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F8C358C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:41:26 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b9e9765f2cso10966845ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689932486; x=1690537286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecCZasV/2WenVXDyoE4/W5g65II48G/OFEkNC6yHhK4=;
        b=xPO2cIrcSsEOWHLbJo/1rP2vhKK+JOYOe3Q0ys29Ek26FtDXZUte1VyFagly6pU1c6
         WF0Hc8txjsBW6htA1P6/B3Et9sMJqeMDGtZ9QlhYOAW0k5v/ljmqZ3LlmkBTWsvzLqrc
         By+JpiGtwqO1BB5Ib/lZKA+iK5vc4vKQps36kqmDyRgmkDM7XVZPlmaHMp4SPBq1vZW9
         Ohb/l6AIAQFKjXnSbvcvURLoxKgJJ+vfLtKgnhaxCdFrto/AE8sa0cyu8e0p4uqH3MCP
         PVOKtMgMkP+mweNRC45npmdd3bl6UkU9I1NWOWNYhrP69yPOZi6RTk00uJW2nAJQTAmH
         Mivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689932486; x=1690537286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecCZasV/2WenVXDyoE4/W5g65II48G/OFEkNC6yHhK4=;
        b=FBmwScmJnebSTXofFpV8pvsqa68RnhbDkMnhXn91cu4suj9eXr/v7ZJy9dxb9ogDOM
         tH4MjsTf/oFmdzIx4n8lg496LRxzi15TtHYNUt+V4EjR576Qk0MUZ/VK0i05LdhVmTFy
         GGMIOfevc4EMD0rpkClkhRPVKz+e6BSArFdP7X3U1qrRZo6GfKWykWT+UZAJ3KUGUETc
         AACT1wy7Fk7O1zPYu6fRaAO07qhos3JkUUtRaa7eysZAAfaOIABf8BMIoxlx090NqQWS
         XCbBuRNIjHUB7lVuyHcIE3VkkqpVPXJGYKioMxSSC3TTUnCSJ5/YJtPSIbS6qRK1jrD5
         te+A==
X-Gm-Message-State: ABy/qLYfRWbO60IXeKJ3VD0DaPqVZ038q4FQuLFnxDPrlSlyc0smjr9+
        NAv0LvWt/o4axUNc6fg8aZZ6cg==
X-Google-Smtp-Source: APBJJlHSnvCG5tuyWxpXiUQIgWDsCPS3Y8Nd+m2OqCv6WoSuswjTFEEEnMT3ddbdlQ3vTCzoObeAEw==
X-Received: by 2002:a17:902:ba88:b0:1b8:944a:a932 with SMTP id k8-20020a170902ba8800b001b8944aa932mr1144713pls.2.1689932485880;
        Fri, 21 Jul 2023 02:41:25 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id jg5-20020a17090326c500b001b9fdeead86sm2989244plb.68.2023.07.21.02.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 02:41:25 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] OPP: Update _read_freq() to return the correct frequency
Date:   Fri, 21 Jul 2023 15:10:58 +0530
Message-Id: <13c3657578d0c054cfcfe4496dde560b6a816e3b.1689932341.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1689932341.git.viresh.kumar@linaro.org>
References: <cover.1689932341.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we support finding indexed frequencies, lets update
_read_freq() to return the right one.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 7b1d5724b3d8..95f49fbe431c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -472,7 +472,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
 /* Helpers to read keys */
 static unsigned long _read_freq(struct dev_pm_opp *opp, int index)
 {
-	return opp->rates[0];
+	return opp->rates[index];
 }
 
 static unsigned long _read_level(struct dev_pm_opp *opp, int index)
-- 
2.31.1.272.g89b43f80a514

