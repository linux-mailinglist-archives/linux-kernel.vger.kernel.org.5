Return-Path: <linux-kernel+bounces-97399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06588769FE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29673B21A60
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43E45A10F;
	Fri,  8 Mar 2024 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+sp2PHx"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E5F5675B;
	Fri,  8 Mar 2024 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919261; cv=none; b=d9ZQuVmeYTbGbBKkEOX3IK8Ep86mZ8R3p5GsIGQFNyXr6TDfRsxnDtetyI3ENhA7FAFGaN5A5kL5FVq5AwNZAGTBeJdviPbdXwtgDzGcSZ2hQkY03nU7BDWqWEotAdU8D4zO8eblfbwTEhtNWaQeZw3mtmwBbL3ehPXs7bhLOqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919261; c=relaxed/simple;
	bh=LbObmE6sW1VI50NF8hBx5GYZYD1ZL7EHGJyWwt2uywI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DYRtt9RSums5L3gvhlvNvj22mkSNxds75vNHj/w06ewyVEyLZqUkkRHAsv0+mavWVe4T+n4CuT0X05mef1Fmgu1LiiszTfVRxMZMjXkekXYC40xODsxYDelLKFNS+nP39nfYOyIGLQ8ZwepvvbOIUThuu5rLgzE4k/JWycMAL3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+sp2PHx; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51323dfce59so1231041e87.3;
        Fri, 08 Mar 2024 09:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709919258; x=1710524058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ar3ui94sCfHSHLOMDUIl3IQJOAbXBJ+xjHyVr1i8Qfs=;
        b=U+sp2PHx/IWH3GC8IDZfyxNfJRHx7cs7KoUvZLY942S9DFnXNC8MWsAo8YTb9LpltS
         xaqBrifAGTEgdhQtcHbc024PBwLDS/gfdSXiipq+9gIEJ2Mu6GFTEDCgM7htPcPF1nn8
         pvdCyMk946xmTsJ/4y84dUTOt/NvhvNyi6ZZMqq1RkUxu6B3khCs6UNTWw4Vq6jqomjJ
         6JzBMqTdgaDOXAAG8dbKFMVNB8jawXdaCuY9KBx4RNHXCAb3Cgh7SI3lKfLEt0r1Q9tx
         BbAqT12D1K2fEbekJR94AY8KDFskT/2VYMuJkMSeR1D2Ps6qihvqubW4z9WqWrv75bt9
         Ellw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709919258; x=1710524058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ar3ui94sCfHSHLOMDUIl3IQJOAbXBJ+xjHyVr1i8Qfs=;
        b=oTPnuYV6DXjoSwgo3QYr4xfZziEASm84iwzL6ufvpPOadMxS+okxmJaS8DBP/S9pL+
         3lVHCdO4PFMPeu9KLlnWoQJHFFVgNyQudC84kW4jY54TZ/1Xk+XxuMMEYdtBh6bAhmzl
         gIW52+dCzb4EttmC6uRhmD7I6O57v6i1BM2T61c9/+/NwAP7IbZJT9iCnhDixO8tXx70
         SU3NXulchx4ZcS1pXIHFWMLcakLg5SpdEVcC0+GHOmGMMXLtbTsIwEFMm8WhP2Sls7wu
         NxindzEpIkyox3ZP4vMQsUIoR3wjU3s74uFx6vYuyFRaV1ScAkw2/sR61Egscw+mNDZt
         bPdA==
X-Forwarded-Encrypted: i=1; AJvYcCU3utwdRKx3S2ELMjJ4X6OYm8RMNYHx+h7f16jXMBgy79Ued3VCvqVNSTHGTW9rD2pD2ZYxwiOaf6cA0Ef2Cf+oDOHG3Cct+rWUvDAW
X-Gm-Message-State: AOJu0YyOkgt3xYz1Z8S8vtKxVKzN9Amg3xTDQuVssva+qMip/gjGMtrN
	t84pjfNMOUltk6/6RHBnenCvO7AXP7zBL8eBby42L0XPWq6gBFKd
X-Google-Smtp-Source: AGHT+IFOuH6v/8Kdjsj0UKr8zhImUNwpyXkZeVqhGT0QyG0KNUHE1/rN+3yvUn5TpNmkm7Teuy1aow==
X-Received: by 2002:ac2:4113:0:b0:513:19df:4eb6 with SMTP id b19-20020ac24113000000b0051319df4eb6mr3653497lfi.12.1709919257852;
        Fri, 08 Mar 2024 09:34:17 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id a23-20020a195f57000000b0051333e2f55dsm3150504lfj.159.2024.03.08.09.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:34:17 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v6 6/6] rcu: Allocate WQ with WQ_MEM_RECLAIM bit set
Date: Fri,  8 Mar 2024 18:34:09 +0100
Message-Id: <20240308173409.335345-7-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308173409.335345-1-urezki@gmail.com>
References: <20240308173409.335345-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

synchronize_rcu() users have to be processed regardless
of memory pressure so our private WQ needs to have at least
one execution context what WQ_MEM_RECLAIM flag guarantees.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org)
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d854115ff11f..fe2e15c320dd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1609,6 +1609,7 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
 /* Disabled by default. */
 static int rcu_normal_wake_from_gp;
 module_param(rcu_normal_wake_from_gp, int, 0644);
+static struct workqueue_struct *sync_wq;
 
 static void rcu_sr_normal_complete(struct llist_node *node)
 {
@@ -1707,7 +1708,7 @@ static void rcu_sr_normal_gp_cleanup(void)
 	 * of outstanding users(if still left) and releasing wait-heads
 	 * added by rcu_sr_normal_gp_init() call.
 	 */
-	schedule_work(&rcu_state.srs_cleanup_work);
+	queue_work(sync_wq, &rcu_state.srs_cleanup_work);
 }
 
 /*
@@ -5609,6 +5610,9 @@ void __init rcu_init(void)
 	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_gp_wq);
 
+	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
+	WARN_ON(!sync_wq);
+
 	/* Fill in default value for rcutree.qovld boot parameter. */
 	/* -After- the rcu_node ->lock fields are initialized! */
 	if (qovld < 0)
-- 
2.39.2


