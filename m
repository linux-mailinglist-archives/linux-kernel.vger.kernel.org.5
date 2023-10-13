Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7417C80B1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjJMItS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjJMItM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:49:12 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDF9FA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:49:06 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5859a7d6556so1390216a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697186945; x=1697791745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9got1lZdwQorf5bG+rweB7SynI8yY1C0vhKZAmzQ80=;
        b=ITqoL4tejHHpgZHgD17QhB1xcEKmaQd4HB2FolgB5dTOnahgzgpBEiTaupow0WEenR
         yM6myTuRSOCKYV4eWjCxdnGfPp0FnklpgFKVmKjIldbk8uPWeGh8Qq3ucE4Qn5KWej4D
         XSJsraA8bZmEFyMMGkAY+f0nC/1B/y7kkj9Nw8sK6TZCyYqoDenQmw9DWUyMvjbr97h5
         dgsyB6A2VW1PW+2RGg/F/hkMIlg6AwOr/Ev8U6iPOdQclQzm/XL1Z7JUp6TcvoHEq7Nn
         rT2+jyxZFUxCUpvBXBjtalXnzrYIGUt0kGkUla8zdNPi4QjB70fLKojKedlnTmZFn/r3
         USaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697186945; x=1697791745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9got1lZdwQorf5bG+rweB7SynI8yY1C0vhKZAmzQ80=;
        b=dWA85QJmPjFTaGsyiK9K95H7tag8DV9w8QssSSfCS9tS+MhAhJDoKjpFROLy2JK2Tt
         hOzL8W7aoB1IQV/vrZzeVrK1rD/FVtAIOtXkF5go0/i7lB1qEW5Kq1W62fPe3M3numkr
         U1euTQQG/6eMD7M3o9cWOP4C/rvzMX05gufJd3incJ+Y2jXg889Cpx3rHfnlZ0a5Ua1B
         6HbJfhWF8VZR6JIDrriu+JQJAE92BVW1qfl/aFUwR2bw0PcfoS0VU1xe/P+A5wGYmCM0
         klCqii+a5KQ8OIkvItcosyvdTYA65lrZ4pAXD+sOKeh6jq4nZwLczjtLp2UFNhm5QuDn
         +DuA==
X-Gm-Message-State: AOJu0YyzdP7JxpDvE+0zoh3lV6Hb4qPP4KET1bSyJLMmdnTXiuNngytJ
        +XdbIx6JdUK9B+5LYid1ZyYIHg==
X-Google-Smtp-Source: AGHT+IHR1Di5iTPJd4PZUXhJsWb4CbLa2qxXMmaVLrmyC8aci7p8IM2IzqlTvIcoLKJ+eTLd5hjsqg==
X-Received: by 2002:a17:90a:195e:b0:27d:1cf4:500e with SMTP id 30-20020a17090a195e00b0027d1cf4500emr4491505pjh.7.1697186945589;
        Fri, 13 Oct 2023 01:49:05 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id nr20-20020a17090b241400b0027d1366d113sm3127687pjb.43.2023.10.13.01.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:49:05 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] OPP: No need to defer probe from _opp_attach_genpd()
Date:   Fri, 13 Oct 2023 14:18:41 +0530
Message-Id: <4cd8fe2135128168c1cd80482359dc7a46550085.1697186772.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1697186772.git.viresh.kumar@linaro.org>
References: <cover.1697186772.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the new interface for attaching genpd's via the OPP core was added,
it was possible for required_opp_count to be zero, but not anymore.

Remove the unused check.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index befe46036ad5..c069aabefa00 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2430,14 +2430,6 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 	if (opp_table->genpd_virt_devs)
 		return 0;
 
-	/*
-	 * If the genpd's OPP table isn't already initialized, parsing of the
-	 * required-opps fail for dev. We should retry this after genpd's OPP
-	 * table is added.
-	 */
-	if (!opp_table->required_opp_count)
-		return -EPROBE_DEFER;
-
 	opp_table->genpd_virt_devs = kcalloc(opp_table->required_opp_count,
 					     sizeof(*opp_table->genpd_virt_devs),
 					     GFP_KERNEL);
-- 
2.31.1.272.g89b43f80a514

