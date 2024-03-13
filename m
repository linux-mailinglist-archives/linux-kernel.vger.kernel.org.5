Return-Path: <linux-kernel+bounces-101002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B2E87A0AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4262F285102
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CA0DF6C;
	Wed, 13 Mar 2024 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="w0SRTMg6"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD566BA2D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293110; cv=none; b=ASN3kY4rzK5piSEHTJoXt5W1BQluBH2gMvQEigDDqMQmPhTTW44fcjVXLSX8iV/4fSsQWWLDWwwSSjgHinUm/Eg1zkOEWhAO58kA8JJrB12O+ayQzHRcyqYq62lVOOrjZb4pD3pqXpFpvWhESjF8gxH+BhtFqwaWI+67lEEqPcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293110; c=relaxed/simple;
	bh=ZOaTdU6+mkYKcu73jBNLA/JSAJmZHt+8O8zlVTj/AiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Agtm3yqktSlEAoaTH/nyRjQUsfLuo7gxziGCijoYc6tgTeec6Cqm42Xc8KAR4xv6xzA0cXJXEhAofuhwHc/7xwUm+MpqDjXfnkKaIl7Jx/KefY6BIdOMBJS/ZCnrVnveTT86qTGgIdUksC+RbBcHTMQyT8U3y+o8qBs7ts4XVCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=w0SRTMg6; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-690b7ce0f59so29559736d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710293107; x=1710897907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIq/RsKJ+ZDmqaV4DNR53VSSNnL2VAVCUisag/qJ124=;
        b=w0SRTMg66QtBoU7h+Z5j+J5aWX6/gFxCfpQxwqeNuIBHTFJaz7lRwD3JDScgLJj0Ig
         qlB7+LRw0JURaKW62YheWAAL5yAUDD7Ls61oWyNG/8AEq5/kirbuvZjdjK2dagK0Famw
         6ZaYGfSRr3n29cXqyCfFkOdSh/XVB2hnkb+G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710293107; x=1710897907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIq/RsKJ+ZDmqaV4DNR53VSSNnL2VAVCUisag/qJ124=;
        b=iaCuzAtdZVEwsKXypVr6z8lGdJ9nGLMCgoFc054ZllR6Non3wYsBu0syA7dzeABFZN
         bgYPTvHyf3shwjmmQHdkY/ibyGGhPNpCEXk5RpRPLfFG2p7rHVTPdNFQYHnG1BWMnP2U
         MJP3CoLm+i7H4LIdW0xHd8EyTb7hstxmHwvyc2DBQ/wYcJhnz7iAvgbQG11NVWifr/jy
         dQLAs35pSjf9JH1aRhxgn+BNKQEC6ftxrxs/XrpyAw1cPXV5PRUvHiC8pw6AlMl4OnMw
         01XOaicwU/x3xRQOPZ8xm1JRoTqTup4nTzxDo5MCEcrIDbi6QOFrlQ/S4rmhNdGoBaaX
         ps7A==
X-Gm-Message-State: AOJu0Yx/RzQdVLQioPS4eJbrMRrgiD+y/K4Ff/b2OQ2DftGLjS7GSGHo
	+MLtzmihN2hr3iu0kCq+NtJUDoRmDDmE+iyFPCxpCkl1aS9rPQvJgJdK8E5ATZG1ixFIQwXrHO9
	U
X-Google-Smtp-Source: AGHT+IEo3qLwxTzSVUZ92CVnWSt4p1RkIwgvb8H6YC7a+n6trhN/r0aCvm8ypkHWszNoBkdIwgnCBA==
X-Received: by 2002:a05:6214:888:b0:690:e2b5:9219 with SMTP id cz8-20020a056214088800b00690e2b59219mr4643667qvb.22.1710293106976;
        Tue, 12 Mar 2024 18:25:06 -0700 (PDT)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id u9-20020a05621411a900b00690314356a4sm4162132qvv.80.2024.03.12.18.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 18:25:06 -0700 (PDT)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	David Vernet <void@manifault.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	joseph.salisbury@canonical.com,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Phil Auld <pauld@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v2 02/15] sched/core: Clear prev->dl_server in CFS pick fast path
Date: Tue, 12 Mar 2024 21:24:38 -0400
Message-Id: <20240313012451.1693807-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313012451.1693807-1-joel@joelfernandes.org>
References: <20240313012451.1693807-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Youssef Esmat <youssefesmat@google.com>

In case the previous pick was a DL server pick, ->dl_server might be
set. Clear it in the fast path as well.

Signed-off-by: Youssef Esmat <youssefesmat@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7f3a2596c1ed..63f41453b79e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6036,6 +6036,13 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			p = pick_next_task_idle(rq);
 		}
 
+		/*
+		 * This is a normal CFS pick, but the previous could be a DL pick.
+		 * Clear it as previous is no longer picked.
+		 */
+		if (prev->dl_server)
+			prev->dl_server = NULL;
+
 		/*
 		 * This is the fast path; it cannot be a DL server pick;
 		 * therefore even if @p == @prev, ->dl_server must be NULL.
-- 
2.34.1


