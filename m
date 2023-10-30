Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9B87DBB0A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjJ3NNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjJ3NND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:13:03 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400C5C2;
        Mon, 30 Oct 2023 06:13:01 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c595f5dc84so61743431fa.0;
        Mon, 30 Oct 2023 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698671579; x=1699276379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxNONTjcbTR5IGf7JU34sfB7ky/8i9fS4GX+806ft28=;
        b=MM3j685o6j72EYnhokLAiokb2UgwhxyZ38xqmPUknazr26XvB3prqGKHPajD9GSKh9
         PO4+QfXV/0Q176xkKR0tUVptlSM/XLIjedETd7LCrKJN0YqtsVCGwaDI16rA6kz/rUsY
         qx7caQcq+pSyxnT4t+Rr9sKb+WmQ5nxq392gCUgxc+XNzT8IxQoq1glxNdAX9htyhjRH
         N5sOZ3QQT6p7Iv0yqIwHWp2KOuyODnQv4ySZIKQCC3f1hc2mywYrS4RRomx6pLSvfvB6
         3ZSR/bAyn2d/X6IqKESWpMz1Gd19+5UddwYwo3Fof6azrd1b1T1TBXTl9Uz+b1IaaKyN
         zt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698671579; x=1699276379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxNONTjcbTR5IGf7JU34sfB7ky/8i9fS4GX+806ft28=;
        b=nP9oVv26wN93wui5n3ewZcHLwo0NhDGo8AnsN52ADKo7Je07ts6zebujkiJAys73RM
         xci6/V1odl6DYKES2keOjrC7n0cwdmc7ny0XknRohAIyFFiWNhIh6n9SNa2K0Y1UOPPl
         3OTnUM++ESEhfmg5hPxGeof2lld7AZL10PK98iAEy9a/8I/qCT5wxbr0Jj8NpdEwM6li
         AbcqHr5GFsTKwQSDaGMdg1C040YQ92DTy+SkfpagSYZUrILcBVh2J4GCSklscGd6eTzl
         vRw4msg8peue9ubPFbrGkgFwmPx7RGymi7UcXf7I5EQEjYdTxFHkDKD6Y8wdRUzBlz4m
         ODHQ==
X-Gm-Message-State: AOJu0Yx1eou0ubCt+IxckJrGN+9GA8F+uCmJs7SLO4lskps9ja38Eoi1
        geTTieNw6po/LKtq+xgPj3w=
X-Google-Smtp-Source: AGHT+IGZIU3+zcqRFcycB/zEZR9+2Pt8egGj4lqIF5eegoShcZC5Ho+G2EIZrrc7iIn7RimDSj+zDg==
X-Received: by 2002:a05:6512:ea5:b0:501:ba04:f352 with SMTP id bi37-20020a0565120ea500b00501ba04f352mr4713662lfb.1.1698671579336;
        Mon, 30 Oct 2023 06:12:59 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id q11-20020ac2510b000000b005079691360csm1431887lfb.49.2023.10.30.06.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 06:12:58 -0700 (PDT)
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
Subject: [PATCH v2 3/3] doc: Add rcutree.rcu_normal_wake_from_gp to kernel-parameters.txt
Date:   Mon, 30 Oct 2023 14:12:54 +0100
Message-Id: <20231030131254.488186-4-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231030131254.488186-1-urezki@gmail.com>
References: <20231030131254.488186-1-urezki@gmail.com>
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

This commit adds rcutree.rcu_normal_wake_from_gp description
to the kernel-parameters.txt file.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 03a4bdb7512b..a9681d2492d3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5009,6 +5009,20 @@
 			this kernel boot parameter, forcibly setting it
 			to zero.
 
+	rcutree.rcu_normal_wake_from_gp= [KNL]
+			Reduces a latency of synchronize_rcu() call. This approach
+			maintains its own track of synchronize_rcu() callers, so it
+			does not interact with regular callbacks because it does not
+			use a call_rcu[_hurry]() path. Please note, this is for a
+			normal grace period.
+
+			How to enable it:
+
+			echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
+			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
+
+			Default is 0.
+
 	rcuscale.gp_async= [KNL]
 			Measure performance of asynchronous
 			grace-period primitives such as call_rcu().
-- 
2.30.2

