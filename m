Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18C17FB378
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344013AbjK1IBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343945AbjK1IAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:00:38 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3883BCB;
        Tue, 28 Nov 2023 00:00:44 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50abb83866bso6933036e87.3;
        Tue, 28 Nov 2023 00:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701158442; x=1701763242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQVOvwrmfo1nPfUgIyQbOVsMWsIZrJImgM152q/sqUE=;
        b=W/PgcouFN/Z8pHWi5vDSGdOT1N5xbMMpc+cYROJFFgVtTK/TtpHatoK3A8HuGvSaSz
         UHiZCaRUUKegN4wsUoFPGtYo7xXlKolFOtJc0BoQ01aLah0HZCeEyO0Vp+jCcnv8k1Df
         vwOGTSMTVJjEDS8dz8N90ovwdbMdqHckOJnAIeQKjiQzLLJmbfMzPXvVo9tNWAiHY9qr
         ryHVY277Dg7evEmo1KConVX6ew7bmAAezkeG7EGxIDSLtJH4tgA5v5G8KHimunS/wyij
         b0nkPB7WsPFZT+nobrcficgZ/rwcWm7NX+RAqyhzJStnotTOMKS97OT1d/Np9tLafqEZ
         U6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701158442; x=1701763242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQVOvwrmfo1nPfUgIyQbOVsMWsIZrJImgM152q/sqUE=;
        b=Et/VHFtJzCerm5EgrTn05ATQ5LOHhiXd33ql4/YyvleEn2Tbmypp3+mIizrGXdKZLn
         +SQY1WoEAUvt/wGiRwJ7a0oAK5AVssHkU0mImXDsmmJZILhTTYIv6ms7JWBhFK1uzQt6
         MwgV/+o5G7Q3gERQS54EOV9r2CadaRvZOthBTVpN8fnWtE6vhxsnqke+hO/XMXwnh7Sf
         OlfukZ01N7kJ/B+IEEjTzJZxVPLoPyCFvmYtBgHOLtor9NiSHDGebe8aFaEMuOzkBDT8
         TN4sQncb69IOUCGRYrsV0gDpeCTFW8XiUNJv+7OgiPkMKjo+6coo/TN597oPe9YHcYva
         AQNw==
X-Gm-Message-State: AOJu0Yx0KlAT1C4TKMZSGsOn9kLTw+reYOHT9RqOE3wu4/2DxliT0tPC
        nu7QHy2lFZMf/+U0CaisV7s=
X-Google-Smtp-Source: AGHT+IGpGnDLULRUYULHIiEqENx6drVMGcTjDMRTQ69MqVN/chnP9zQSnV1eWsGowYbRCIcIp5MNkQ==
X-Received: by 2002:a19:5506:0:b0:500:b53f:fbc2 with SMTP id n6-20020a195506000000b00500b53ffbc2mr8986246lfe.26.1701158442372;
        Tue, 28 Nov 2023 00:00:42 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id o16-20020ac24bd0000000b004fe202a5c7csm1765501lfq.135.2023.11.28.00.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:00:42 -0800 (PST)
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
Subject: [PATCH v3 7/7] rcu: Add CONFIG_RCU_SR_NORMAL_DEBUG_GP
Date:   Tue, 28 Nov 2023 09:00:33 +0100
Message-Id: <20231128080033.288050-8-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231128080033.288050-1-urezki@gmail.com>
References: <20231128080033.288050-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This option enables additional debugging for detecting a grace
period incompletion for synchronize_rcu() users. If a GP is not
fully passed for any user, the warning message is emitted.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/Kconfig.debug | 12 ++++++++++++
 kernel/rcu/tree.c        |  7 +++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 2984de629f74..3d44106ca1f0 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -143,4 +143,16 @@ config RCU_STRICT_GRACE_PERIOD
 	  when looking for certain types of RCU usage bugs, for example,
 	  too-short RCU read-side critical sections.
 
+config RCU_SR_NORMAL_DEBUG_GP
+	bool "Debug synchronize_rcu() callers for a grace period completion"
+	depends on DEBUG_KERNEL && RCU_EXPERT
+	default n
+	help
+	  This option enables additional debugging for detecting a grace
+	  period incompletion for synchronize_rcu() users. If a GP is not
+	  fully passed for any user, the warning message is emitted.
+
+	  Say Y here if you want to enable such debugging
+	  Say N if you are unsure.
+
 endmenu # "RCU Debugging"
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c0d3e46730e8..421bce4b8dd7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1547,7 +1547,8 @@ static void rcu_sr_normal_complete(struct llist_node *node)
 		(struct rcu_head *) node, struct rcu_synchronize, head);
 	unsigned long oldstate = (unsigned long) rs->head.func;
 
-	WARN_ONCE(!rcu_gp_is_expedited() && !poll_state_synchronize_rcu(oldstate),
+	WARN_ONCE(IS_ENABLED(CONFIG_RCU_SR_NORMAL_DEBUG_GP) &&
+		!poll_state_synchronize_rcu(oldstate),
 		"A full grace period is not passed yet: %lu",
 		rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
 
@@ -3822,7 +3823,9 @@ static void synchronize_rcu_normal(void)
 	 * This code might be preempted, therefore take a GP
 	 * snapshot before adding a request.
 	 */
-	rs.head.func = (void *) get_state_synchronize_rcu();
+	if (IS_ENABLED(CONFIG_RCU_SR_NORMAL_DEBUG_GP))
+		rs.head.func = (void *) get_state_synchronize_rcu();
+
 	rcu_sr_normal_add_req(&rs);
 
 	/* Kick a GP and start waiting. */
-- 
2.39.2

