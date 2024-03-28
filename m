Return-Path: <linux-kernel+bounces-122533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D4188F91F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E442940C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADEF548F8;
	Thu, 28 Mar 2024 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jD84ydRz"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5691548F6;
	Thu, 28 Mar 2024 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612264; cv=none; b=I0MEAsjXgJkwRd83ZQPfhSg4iEq8OqS/wW9VnInIGBvMzHQPGVgvhBhR00EM0OXMffAPWLsWS8JCJ5KPg2KaMFcUcN3Pw/Zyf/LzI5uvFYCF713oY7yoEV9ad17tO+he/C8/9YnZ3hKfbfj2Bz5jZmQPM8EkfBByDmj05h+u0gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612264; c=relaxed/simple;
	bh=uCa14RngRsTw3+urcwtpjUnYiPtvWY8aUi5khb1j6Fs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y99wfsqryINyEMLMHUrph5MKQlJVrwLuBPoq3LyW43IM9kDHRfkqPU+SaLOFSdJHhWJOHifNNAtohv1wU6GWYGvJBTXnW5flSkNiHdcHOoDtiKGLL7yqYS+kcqcNxLaLkdLyHXJ5PUNWoVvDODGoyOQF71F18qo7+Dl/xywM2Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jD84ydRz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6b5432439so633741b3a.1;
        Thu, 28 Mar 2024 00:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711612261; x=1712217061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDpaTJnygn2mT7ZJwVjsDsx1RmElkSFOnj98O9h9iX0=;
        b=jD84ydRzcSzvNlnO5JYGJqkPL1p6ZZbzei0M64btZFyg1Ze5Mee7PO8srA7Tf+UEuE
         /uP1Ul+BQcmTACVEkyJ6+DjRGkjUBXSLL9cZTA57Uchornrsr5Rxj3N7Mu+2YbnjHU3J
         +8rLua3n6uBlWijpTfpFqXtm4Kiu/FWH/u7aFLUjQb29y3VXYxSd07ovTsoKh5k8iMY/
         KShKDtkpVHci/flcJEdieckqYT2e9cUD6eg1PUXpzR1mhGQIVlbRzqnU6RbGzT5qdZBh
         XlhOyEDeCQBuW2/3FpvsbDSPOuDBOHZw8Sehd7Ijot5iscNJPxkzsjta5vHwwMahj5KM
         z2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612261; x=1712217061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDpaTJnygn2mT7ZJwVjsDsx1RmElkSFOnj98O9h9iX0=;
        b=vykGMLs9DL7/KxKrw/bdyjdnKyJVD9jWFk71BZgz+bubULfx85zweKWB7FMNNljOXl
         bsO7OggL70Rz+tiTCbnncPMgk+S6M216KpiODLUAqavXDZneAuy4/gSP18VbIzaLUi89
         mxTqq1SZtnZgWZeJTKXU2URP4l6PXPCN5sX2Ovp1yPiuGkTvrNTB8tsz3ckiAD6IlbcJ
         iAfVt4Eka6LnZY7dlR7ZaFYwg+e5GoSEGSepyeEAEGSD0wEGMdIp+mdqwy23k8YZ9aon
         81EUWvMpMUFj4aPGxhn5E8gH8zS7amnVb7gYIeDdk/zyQsWEKy9WzNe9jvK/FMTP+TCW
         hs9g==
X-Gm-Message-State: AOJu0YwmSflwyVGG6zb3xrzkAEdijshfS0zyGtD7476JkOgUmo0JfTSk
	DHbeqaEmFZ2UiGmOXHPwbinkAEm4yONhBYCXlO1BQduSVqAlaj/g6df1admd
X-Google-Smtp-Source: AGHT+IEOWHdubp7SV6rJhw98PJPgudXwwlcJgNX1Z010cKJ0fZZCbxS25WjWE/yFh6IYdrFt6kUesA==
X-Received: by 2002:a05:6a21:164e:b0:19f:f059:c190 with SMTP id no14-20020a056a21164e00b0019ff059c190mr2137232pzb.24.1711612261598;
        Thu, 28 Mar 2024 00:51:01 -0700 (PDT)
Received: from localhost ([47.254.32.37])
        by smtp.gmail.com with ESMTPSA id kx13-20020a170902f94d00b001dddeb10d83sm855667plb.223.2024.03.28.00.51.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2024 00:51:01 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	x86@kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 03/10] rcu: Reorder tree_exp.h after tree_plugin.h
Date: Thu, 28 Mar 2024 15:53:11 +0800
Message-Id: <20240328075318.83039-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240328075318.83039-1-jiangshanlai@gmail.com>
References: <20240328075318.83039-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Enable tree_exp.h using some rcu_preempt macros introduced in
the next patch. The new macros touch core rcu_preempt fields
and are better to be implemented in tree_plugin.h.

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/rcu/tree.c        | 2 +-
 kernel/rcu/tree_plugin.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d9642dd06c25..57d1ae26861f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -5245,6 +5245,6 @@ void __init rcu_init(void)
 }
 
 #include "tree_stall.h"
-#include "tree_exp.h"
 #include "tree_nocb.h"
 #include "tree_plugin.h"
+#include "tree_exp.h"
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b1264096d03a..d899b4afc21c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -103,6 +103,7 @@ static void __init rcu_bootup_announce_oddness(void)
 #ifdef CONFIG_PREEMPT_RCU
 
 static void rcu_report_exp_rnp(struct rcu_node *rnp, bool wake);
+static bool sync_rcu_exp_done(struct rcu_node *rnp);
 static void rcu_read_unlock_special(struct task_struct *t);
 
 /*
-- 
2.19.1.6.gb485710b


