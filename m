Return-Path: <linux-kernel+bounces-69120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 242018584D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E8D282F81
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F841350FA;
	Fri, 16 Feb 2024 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HawJlmN2"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE99C1350CD
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106779; cv=none; b=i9Wc8zoKEYYDSVK2xZPf1hBqaCF582QO8dyGufKzG84pb6lu//R6NFSqsDbhNr8gWk6JLlGqMqWJKXaU/xz/JKQX9DploDPnpUpcewcCEF4whsZsQqiFcc98kK25BdwrIbCOoR7+V5BAR2sNraoiLENvHEShgn4+SX/eTApbIDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106779; c=relaxed/simple;
	bh=qzo6BYrcleW4zRxM5K55RwFrekOKOLB8qjWI1ALQZYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m30wm7NmeA/q9CYLIzQvlp0O66IBB2WVc69hvO9dohP1xhhJBlJr2QxILT4rfUgJCOMHyoMKIonv00HBQyPNytM6pBzqpnBTzYdNbUWjiWqnloXwV+XEdl4fJq9a6yIa4jVsH61Fys0a/w2r7PYWgwBxdSTDct1h3Ne867ts0Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HawJlmN2; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e0f5934813so1886683b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708106777; x=1708711577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIltjVUaiFwUeua93wdSXtPQLjPPFRChCUpwRSlDMH8=;
        b=HawJlmN2IwfBdNnChc+iiHUToYKabT/gsQ2w0BC1igkWyNAPNpsINkqEWpSSKiwYJZ
         pETtzMpZCe3XxkhJstCHMKW/K+4Yu0bmopax9sAPhQ3BuH+sFhY/6sKA6omH4voWVOQE
         K75UKnNRMuU2OKX33dpIQEt37nakUOPFySpEVPHYvzN5FuHoS47fKpicjuGcHY+r9MBk
         F9Ajk9Nplhc4/6MgWYl/v31lB9usbRRrojVpBZAx3f/38MlbKEmTtp/jSVOt2XqnrVev
         kE0lE5UNXhQ+0ijX+rUQnYau5Bz6cuhWepfUEr7xzZadEH2D1FqdIkmrcxUBhwrk1gZn
         o8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106777; x=1708711577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pIltjVUaiFwUeua93wdSXtPQLjPPFRChCUpwRSlDMH8=;
        b=fhNvYg1XrGkLTf9MAjuuQfjRdNdaA/gFGYkBhG8HqvAYDo1d/xAqatdL8DSQJyW+x9
         fuUJiIqhWFnVTpjvuVWrHCwA1sr6qsRnYALBya9pPHwprjh6Xtiju4eYlULC+OC5RB8G
         ZkisxOSYqI+TPwd3xgLRAXDK1pbkdyi+jErjByzrMZ/VKj8DbFyVKsoL8xIOJlQ+zlRS
         6Qp30EQH+f8Tmgq+ubidZLFb0kb/sp1YHPs4/z8SgefiOl2Xx7P4wE7FevVS9HZRFo2C
         DqaJZ0b1azkGDeMX6HUzkvqhLfsjLa13VOFQuno7hOgYAvPB4jfLB23x60vOBQuUCz3d
         TIFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHL7FT/hygCv97UQf/ShnnmS0SpNUsXLBbTOFTj0ZaeiSCkWc857MrVSBR+LYTGz1gRmgOFWva4xMLQFEZFdmRWDl4tlJ9+B8QuVeT
X-Gm-Message-State: AOJu0Yw4O6ALJDG5IxksXJAWQX2oePa/HDXFAdrNAXEKaqUcsU2mdLzk
	z5Kz/cmm+PY+I2GcU/6NlWMkk18I9RyYwHNaxGupfrRDxT2CyBz/
X-Google-Smtp-Source: AGHT+IG3g4k/8q4PxGrqRpPIFB6/hGNdt1itN/VQKTsf0uCvvXCIsNwOZRh2vAlhSy2dezeJPgFHhg==
X-Received: by 2002:a05:6a20:d046:b0:19c:ac7f:c3e4 with SMTP id hv6-20020a056a20d04600b0019cac7fc3e4mr5432849pzb.42.1708106776937;
        Fri, 16 Feb 2024 10:06:16 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id x40-20020a056a000be800b006ddcf5d5b0bsm235158pfu.153.2024.02.16.10.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:06:16 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/17] workqueue: Use rcu_read_lock_any_held() instead of rcu_read_lock_held()
Date: Fri, 16 Feb 2024 08:04:43 -1000
Message-ID: <20240216180559.208276-3-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216180559.208276-1-tj@kernel.org>
References: <20240216180559.208276-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The different flavors of RCU read critical sections have been unified. Let's
update the locking assertion macros accordingly to avoid requiring
unnecessary explicit rcu_read_[un]lock() calls.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b280caf81fb2..87750e70b638 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -515,12 +515,12 @@ static void show_one_worker_pool(struct worker_pool *pool);
 #include <trace/events/workqueue.h>
 
 #define assert_rcu_or_pool_mutex()					\
-	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
+	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held() &&			\
 			 !lockdep_is_held(&wq_pool_mutex),		\
 			 "RCU or wq_pool_mutex should be held")
 
 #define assert_rcu_or_wq_mutex_or_pool_mutex(wq)			\
-	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
+	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held() &&			\
 			 !lockdep_is_held(&wq->mutex) &&		\
 			 !lockdep_is_held(&wq_pool_mutex),		\
 			 "RCU, wq->mutex or wq_pool_mutex should be held")
-- 
2.43.2


