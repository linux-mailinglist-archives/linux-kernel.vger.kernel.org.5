Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFEC768006
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 16:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjG2O2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 10:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjG2O17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 10:27:59 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA4AE7A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 07:27:58 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34914684b62so353225ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 07:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690640878; x=1691245678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6faQrb3vVDF+1ZA3HcLro9nEgsaXGn2RtvbxbNNEvc=;
        b=plXTHquWdh4bDvLFn2iXXCHJmvv/+MoXo8lRqYopE64G7FgOHv+cnT2c05bBwokNCo
         f2+s+ItwB5Hhqd7VCNCKAVOINhdBw91B9XtHD1TQBm0bxbtcj/QaCeXNKMY+P2vShgB/
         AyVO2DIkMfhumM/yGpIR5gkL7/1244kpfN2Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690640878; x=1691245678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6faQrb3vVDF+1ZA3HcLro9nEgsaXGn2RtvbxbNNEvc=;
        b=Qya9OLad6LWWqBl07H2mxVxYhEwybDTGI+KqTfMcxOhbCdMC3ygr4spgmQbAsmAtiA
         2jrq6ZTQGy2Q1J2cxo7PzjR8J2lK3Uqf8UAAbK1DT5ou+YxEDaIaQiFpHCFAeZwe/TLN
         jPPufDPnBl6U2Lk2LPlkfnqx1RSrjLkfu96NZzB/BJuNNOhhhuuIbH22dEjQCkUxHC5T
         e87m/WYDzwZSHOYfOqD8BKs2o3V915L9df5Np87m69QYNuwnuafJb/FmMDarG6w45/nV
         Lkz7MMdVMMZEBiP7n1vXLX9lFO5XzRFATb1rm8hbwIs5FxkFo9ygSjZN6pwAv4sYnTfO
         8dgw==
X-Gm-Message-State: ABy/qLYYumvClh7ASHJUR/cAnsWEdQH6J7SLfTsVbZWukv30j0YHoFvC
        JMTq/eeRnKu/zCy8vc691TqPOeODkh8ccmlQGJo=
X-Google-Smtp-Source: APBJJlHK/5GmyzQgFG1Ksqn6znBGEhc+zRSHdPwsSlZO5dCGgHvfR+k/CmjuBsoXHLn5orj/tiR73g==
X-Received: by 2002:a05:6e02:1d94:b0:348:f6cb:e585 with SMTP id h20-20020a056e021d9400b00348f6cbe585mr2922758ila.30.1690640877759;
        Sat, 29 Jul 2023 07:27:57 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id q9-20020a0566380ec900b0042b35c7b8c5sm1855362jas.61.2023.07.29.07.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 07:27:57 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     rcu@vger.kernel.org, paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v2 3/5] tree/nocb: Adjust RCU_NOCB_WAKE_* macros from weaker to stronger
Date:   Sat, 29 Jul 2023 14:27:33 +0000
Message-ID: <20230729142738.222208-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230729142738.222208-1-joel@joelfernandes.org>
References: <20230729142738.222208-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed to make the next patch work correctly as we rely on the
strength of the wakeup when comparing deferred-wakeup types across
different CPUs.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 192536916f9a..0f40a9c2b78d 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -288,8 +288,8 @@ struct rcu_data {
 
 /* Values for nocb_defer_wakeup field in struct rcu_data. */
 #define RCU_NOCB_WAKE_NOT	0
-#define RCU_NOCB_WAKE_BYPASS	1
-#define RCU_NOCB_WAKE_LAZY	2
+#define RCU_NOCB_WAKE_LAZY	1
+#define RCU_NOCB_WAKE_BYPASS	2
 #define RCU_NOCB_WAKE		3
 #define RCU_NOCB_WAKE_FORCE	4
 
-- 
2.41.0.487.g6d72f3e995-goog

