Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C02762755
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 01:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjGYX3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 19:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjGYX3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 19:29:34 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC971BF8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:29:32 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-78363cc070aso316961539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690327770; x=1690932570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6faQrb3vVDF+1ZA3HcLro9nEgsaXGn2RtvbxbNNEvc=;
        b=dOKqCkxitVYH7c0pdupRnZpK5/l2nGavKWDlS+ALoRAPtAH4m3BstqX7xtaGRRb1Wf
         d3seuANAUNcBh2wORYzQfdJRgZyYXkIXgQWow/2GUL1DlZMFSx0ijE0bHqYlnFjrE4P5
         mHXFGWUEOy2hIGqzMfbeyqOFGR7zJNac5++X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690327770; x=1690932570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6faQrb3vVDF+1ZA3HcLro9nEgsaXGn2RtvbxbNNEvc=;
        b=YN6xrwjxb5s2Sviu/cB5IHl0EKDzY64EshVVsmgQr01PN5p1r2QHkENBJE8f+k2JLw
         gEZNfa7mlvt4o3dnVOmwKKtgCUrtRKdtNDcFfJP2Py+ipm4/r/X6xML1yvExqTm1oxkv
         7S4WjlmWAVUssznpA1Hg2WowlxSQWZ11WfZNeg0zFPYse5G4Kg0QsLNdBoh69tEbUSSg
         puePU9mfRyiK1BkWBbOSGBRWVFpGIkfZC2eETNmF5mnmjVQPvuBydqpIjExN9FKgXwT/
         +qnLjTGIy0UI3N0t6fKMCC2tmiggk0dLnNlaAlLbbEQV8AY8BQPMEm8jjs+tDzDUbK9W
         Ne3Q==
X-Gm-Message-State: ABy/qLaEo+J2fMkvAB0qaPwEHCL/ke1A4O78im/UAXcEpNg3ZQ2IY0M8
        EZEEjwCJLdXgHwyJVHxACi9MuuZtyj1Qbq5WsBo=
X-Google-Smtp-Source: APBJJlEZFnEQQK9J1v8M71kPDaqQ8ZTeYcDEjV+OUIXcmUtYKVYoXTApZUTw4E9efh8aj3vI2iBVkA==
X-Received: by 2002:a6b:e80e:0:b0:786:7100:72de with SMTP id f14-20020a6be80e000000b00786710072demr346606ioh.16.1690327770577;
        Tue, 25 Jul 2023 16:29:30 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id m18-20020a02c892000000b0041d859c5721sm3932053jao.64.2023.07.25.16.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 16:29:29 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        rcu@vger.kernel.org (open list:READ-COPY UPDATE (RCU))
Cc:     rcu@vger.kernel.org
Subject: [PATCH 3/5] tree/nocb: Adjust RCU_NOCB_WAKE_* macros from weaker to stronger
Date:   Tue, 25 Jul 2023 23:29:08 +0000
Message-ID: <20230725232913.2981357-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230725232913.2981357-1-joel@joelfernandes.org>
References: <20230725232913.2981357-1-joel@joelfernandes.org>
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

