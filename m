Return-Path: <linux-kernel+bounces-44222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109A6841F06
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E29328AF44
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403DD58AB6;
	Tue, 30 Jan 2024 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUQuAKQr"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC8C6088E;
	Tue, 30 Jan 2024 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605990; cv=none; b=sQKv7Zd+KMM46utH8yWFXfke8EJjOlRu+rQ4CBfVXVLyXb5odjIaO/KF4qw118t8aiZ0u0Q3LDB5MqVQcvTfdIcLYK1jidY9RlA4pizBVkk9hsJslfp0dLNkHl6jT0y2mRu1puL3dtowWTzbqWEZtDizcEujyolzk6N6WBxv00A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605990; c=relaxed/simple;
	bh=bRdnyNKa81dUnoj0MB6Zg9a2NEYVmN96xNxLaxLYnG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfPUMhP0wB4omolydO3Nd2MF021CwvaMOXijhe11qVzNuZQW2On+15DjJeLxvOzqE25MGN3qNkzNJlDk97ma2Kd2jcGmsTXPeheVFHPOcAOO6S/njcQgYnv/CGqnEAYPq8GBg5omaJDdnSv01VzAsec2GSwh5obYyx9Kel7Y090=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUQuAKQr; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bbb4806f67so2807830b6e.3;
        Tue, 30 Jan 2024 01:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706605988; x=1707210788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xblJk8GY6hKfGdpNUu6EAuoAaIEFTkAgpkYfucVU564=;
        b=nUQuAKQri2ncvxDBmJ8O2hA6JJ2q97SfxSSh8H/pXPn/DKebymZrlHC7bRrIplJpHK
         nhVzEa1XLwndEaFc4JycOC8zy9VshfcUFgKarF1meREJGVaqud7UlpfH4iYpdlpdHHLe
         jSkU6iNsxxzJl0dXXNBeaxn1nHMTJtgheTJ/fbiS5ft+XngxLXP5jE9U9ai7JfDDJ4aY
         yJDD6wFq8vDxN6yu6lfZ35QQ4MKqzswEo+OKnkmShsFaHqtaF4zhPtA4PMYEIXRLavmd
         sHSNIHiOSETiWHXAV3/nyIua2WpB3HqM2qMdzFNdwF3t7e0cHNF4rJLMQo6FZHT4qsEi
         X70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706605988; x=1707210788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xblJk8GY6hKfGdpNUu6EAuoAaIEFTkAgpkYfucVU564=;
        b=VHr/GQP8xLVSNQ9ZPGYNmJMUoQlXN21h8ehhhg2sqGB2a2EluF57VUXy4PzmIY4mNi
         24t+qjBsUtw2r+cAJ2znLYBjRWzqMgcpQSZn7xAXNcRH1/0z0HBVPXKm7azcMTazabBx
         yE62I2qlsH3cJyF3vdB5fDh+gUeP35NNaTH/WZy8gj//4AQ0wZR4AcRTytBPg+WJa/Ls
         Dtgy14utrftvnx2ox+WC586//ijb6rClux45pJdW4pJcKyURHOXTJAOQ2L1Kzovh+M0M
         Ru8hX2Shsu0NSOXrRCfJNpgBKawSoIlTQx+aCGvc+3K/BGOKS0BEyohJDZXvD0R5Oyu1
         76AQ==
X-Gm-Message-State: AOJu0YyqULLTC6OImOhhsR4OdF+OVPuChAATTmTmsyOCtk8noZaiWS4f
	dq38bZoH1tvt9DkG44k7RUVT+rypyVczaODCzX3yyvAxSLEMGGy4
X-Google-Smtp-Source: AGHT+IF74Pvxoh28vY90uV/ZCd6iFVdXKTZ6HNiXo3qs/SUNVF0CwPkYPi5FBG9VCztGQlre04bl1g==
X-Received: by 2002:a05:6808:23ca:b0:3be:453d:e061 with SMTP id bq10-20020a05680823ca00b003be453de061mr6090110oib.6.1706605987791;
        Tue, 30 Jan 2024 01:13:07 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id s184-20020a632cc1000000b005cd835182c5sm6780257pgs.79.2024.01.30.01.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:13:07 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mpatocka@redhat.com
Cc: linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	msnitzer@redhat.com,
	ignat@cloudflare.com,
	damien.lemoal@wdc.com,
	bob.liu@oracle.com,
	houtao1@huawei.com,
	peterz@infradead.org,
	mingo@kernel.org,
	netdev@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/8] workqueue: Factor out init_cpu_worker_pool()
Date: Mon, 29 Jan 2024 23:11:49 -1000
Message-ID: <20240130091300.2968534-3-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130091300.2968534-1-tj@kernel.org>
References: <20240130091300.2968534-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out init_cpu_worker_pool() from workqueue_init_early(). This is pure
reorganization in preparation of BH workqueue support.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3f2081bd05a4..f93554e479c4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7135,6 +7135,22 @@ static void __init restrict_unbound_cpumask(const char *name, const struct cpuma
 	cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, mask);
 }
 
+static void __init init_cpu_worker_pool(struct worker_pool *pool, int cpu, int nice)
+{
+	BUG_ON(init_worker_pool(pool));
+	pool->cpu = cpu;
+	cpumask_copy(pool->attrs->cpumask, cpumask_of(cpu));
+	cpumask_copy(pool->attrs->__pod_cpumask, cpumask_of(cpu));
+	pool->attrs->nice = nice;
+	pool->attrs->affn_strict = true;
+	pool->node = cpu_to_node(cpu);
+
+	/* alloc pool ID */
+	mutex_lock(&wq_pool_mutex);
+	BUG_ON(worker_pool_assign_id(pool));
+	mutex_unlock(&wq_pool_mutex);
+}
+
 /**
  * workqueue_init_early - early init for workqueue subsystem
  *
@@ -7195,20 +7211,8 @@ void __init workqueue_init_early(void)
 		struct worker_pool *pool;
 
 		i = 0;
-		for_each_cpu_worker_pool(pool, cpu) {
-			BUG_ON(init_worker_pool(pool));
-			pool->cpu = cpu;
-			cpumask_copy(pool->attrs->cpumask, cpumask_of(cpu));
-			cpumask_copy(pool->attrs->__pod_cpumask, cpumask_of(cpu));
-			pool->attrs->nice = std_nice[i++];
-			pool->attrs->affn_strict = true;
-			pool->node = cpu_to_node(cpu);
-
-			/* alloc pool ID */
-			mutex_lock(&wq_pool_mutex);
-			BUG_ON(worker_pool_assign_id(pool));
-			mutex_unlock(&wq_pool_mutex);
-		}
+		for_each_cpu_worker_pool(pool, cpu)
+			init_cpu_worker_pool(pool, cpu, std_nice[i++]);
 	}
 
 	/* create default unbound and ordered wq attrs */
-- 
2.43.0


