Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C267D6F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344818AbjJYOJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344639AbjJYOJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:09:25 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD73018A;
        Wed, 25 Oct 2023 07:09:22 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-508126afb9bso1752334e87.0;
        Wed, 25 Oct 2023 07:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698242961; x=1698847761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kH2SzlXV0J1R/rkJlHdBb1iPR68EpEWsCPbBxpCRKIE=;
        b=UGT24DF9t1jtKOXD0m5KmLlMjjZUlmZips6OnNlV92AHhVo1AOSVOkM0hqNfhQydA7
         ELwTZDFuk6rqzn7hPFrRoc5QZxkinpqGwk8l+Gm9kTlV+1E3WTEZFFGNmXJiAMdeRhB1
         O6ABhSjbf/1uHSw3FCr4y8Ag2BzvZNxlbVEY0h/H4GJATkxz1NNq1hiBUu4zKxIK06EM
         OYmc33Kv1ydUwEYuURaVVHAPPKhFYjyO9hF8koLWcDACqK4wHHmkzQdbTPjgYlRPvzuI
         dx6flrz3wnPS6owNsuY3Tio+LQ3Bj8slxKc+JkAulpSUAiUKYFsqRMS045LFiI+hju8j
         PaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698242961; x=1698847761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kH2SzlXV0J1R/rkJlHdBb1iPR68EpEWsCPbBxpCRKIE=;
        b=BlBYS1cPagxjdBG/lMQH2hHrjEN9K5vwDyY7OMVm0ySk1F/wMXBD0L8Vo1OpuX0bHd
         1FrthcormjGgVA38a83jS7MJoj2EWoXYo3lKWS6MOswOpbViWswbrNdt0GFQFHt645w6
         +IBNYW/gWW+nVN9JGYtl+PX+ZnXMEsRmpRpBxybq01533iv3eMtxdCl2drDW1vNMUw6g
         UVvKVkl40/DX5QuxlLe8udxzfKTB4N/a8QCmDW2d0fsaKWV/hRfLPAa4LhuBksef/ljZ
         tnKA0jaCDxxRI41QSqwO6GTWODQtPa4P8Mrp8lBUjQgIKRilb+YP8OCoPRaim+7NDdkL
         +G2A==
X-Gm-Message-State: AOJu0YzaZADzrekP5DR8b2Dwj+v/jvDlb7HezlnBO5PFUwlnFd6vEKgB
        6NA46G53ABrKgg7req6BYo8=
X-Google-Smtp-Source: AGHT+IHtWhixjxd3botPQRUSPXV7+ye/LXBTFEOtp2WtgclhoHYWWN9GsBN9QDiB3ZqFOoFKuiyAgA==
X-Received: by 2002:a05:6512:314e:b0:507:9702:c11d with SMTP id s14-20020a056512314e00b005079702c11dmr9580249lfi.64.1698242960848;
        Wed, 25 Oct 2023 07:09:20 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id o8-20020ac24e88000000b00507977e9a38sm2555680lfr.35.2023.10.25.07.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:09:20 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 3/3] doc: Add rcutree.rcu_normal_wake_from_gp to kernel-parameters.txt
Date:   Wed, 25 Oct 2023 16:09:15 +0200
Message-Id: <20231025140915.590390-4-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025140915.590390-1-urezki@gmail.com>
References: <20231025140915.590390-1-urezki@gmail.com>
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

This commit adds rcutree.rcu_normal_wake_from_gp description
to the kernel-parameters.txt file.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 03a4bdb7512b..f41bcf17ff58 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5009,6 +5009,18 @@
 			this kernel boot parameter, forcibly setting it
 			to zero.
 
+	rcutree.rcu_normal_wake_from_gp= [KNL]
+			Reduces a latency of synchronize_rcu() call. This approach
+			maintains its own track of synchronize_rcu() callers, so it
+			does not interact with regular callbacks because it does not
+			use a call_rcu[_hurry]() path.
+
+			Please note, the rcu_normal_wake_from_gp parameter takes effect
+			if the rcupdate.rcu_normal is active also.
+
+			Faster version is preferred set to 1.
+			Default is 0.
+
 	rcuscale.gp_async= [KNL]
 			Measure performance of asynchronous
 			grace-period primitives such as call_rcu().
-- 
2.30.2

