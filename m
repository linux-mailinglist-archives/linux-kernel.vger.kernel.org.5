Return-Path: <linux-kernel+bounces-96886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D4B876294
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004521C20FBE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF18955E5A;
	Fri,  8 Mar 2024 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKMdhW92"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B2E56748
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895562; cv=none; b=L8bKfoeIS25izTfRPydVmwid/j9Aqc/dckqHJOsR8AqQN+QKUAvz2wSA5LF8HQc2qNesHzoLMau2aqGSR54f7/sv6V2ra6DDli7hOfaX81JB1S1rv0LaOrpwd1MvnVdYglmro/RFHaA/d88rw5cBdKYitqzweVt5xzc/i8Lvs2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895562; c=relaxed/simple;
	bh=41nGgChHRVV8YN0N5ipR/hs3W4BH/wXLKrpIYsjfa0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q74GG8URACaHdl4xjTXswgaDzUctCnbnaYSyaVeKUcHEGccQ+ivy/z10m0yIvWsl+6KMx7acK85UqEytm1bOOWpxSUIIzrswz5RGD0RlEtBHwtPBhaYpns9cRJ9/OnOV1mf0hffzgC7UeJTVdwfERj20UF+uAayr0db+qQdCckI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKMdhW92; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41312adc3deso10654555e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709895559; x=1710500359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q17gl107RYT0eMy0dwx+fE6K3UqQeF/uj+kx0/lTA7k=;
        b=MKMdhW92DhaXpmxsGl5QbGf0mkKZCysO6i/y7ORMkJCsWhmbwxgiaTsGk+S9oxXzDZ
         Ym8Nhr53ckIYEgX2BMPZa1sXoImdr90BNDs5JePwilFwCqtpVlQfCaDMay73CzsoNPd3
         4Ov//zm0tzmT8j7m7RDeeercpc9Xiv0FYTNFfxfGiu/raFuINnS98P2DOcX/ZdUDnyVQ
         81pzpFyDt/qN1FdLXivQgsF26o4d21nT4plP2v0xyPc5B7sl2ckCbAnK/lLz92K/vvjn
         w3sPTFy4LLtS4aKYJDZlJufON+0iIXyNaQ5yaIA8PKbMkAXi8zZvVwJ25MJrwAmHZpny
         f4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709895559; x=1710500359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q17gl107RYT0eMy0dwx+fE6K3UqQeF/uj+kx0/lTA7k=;
        b=FlCwQjnFGOOJKPmyyCccqyKIoiZbjHLdg85sWw0KxzeEAOwD8zMZB60iDC5GkV28Ng
         8mWLPWrhUO+uJViBuNWVm58nMf+YzvmJDODPsLOYHD3ZP2UrYczND5i1/AhINXf3YTl6
         1QiHSUafa4pJOSQPp8IUt6CvFofAGAY6ybqHpWdwX7NEw15AyE9wLBmI7KpGhqCoQ8XW
         k/l082Jwx6GWy4SfjU8yxnKAFk99SWl8omQj0sI5UAWWV4agMgq7kLkaxMY47XZqr4q/
         Sw1MUZ96VT1wAO1D3nVxs8px5DsIQOzTtbNbsCgCf9MabmXzEoi6bWCoWFMXHvg2io8Z
         AJnw==
X-Gm-Message-State: AOJu0Yyf3paugQnz/fJDcDW8gxsqqZfsdclCh7xh+0ffy0+fNiogQTpF
	Drg5wunFLYeqNqtEuV3l9RYXcY4ZMvE+5Dx7+nT6K5USI1IxKXZt/7MUPnftgtI=
X-Google-Smtp-Source: AGHT+IFMkLwvoJf4W5rE+HD9jDMPpS1fkiNsKKIjxiXvpMtTxvAb/UxPqR3VPIIQm2NVA6nULhvW2g==
X-Received: by 2002:a05:600c:35d6:b0:412:e70a:7015 with SMTP id r22-20020a05600c35d600b00412e70a7015mr9434039wmq.25.1709895559469;
        Fri, 08 Mar 2024 02:59:19 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b00412f679bae1sm5632382wmq.26.2024.03.08.02.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 02:59:19 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 05/10] sched/debug: Allow CONFIG_SCHEDSTATS even on !KERNEL_DEBUG kernels
Date: Fri,  8 Mar 2024 11:58:56 +0100
Message-Id: <20240308105901.1096078-6-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240308105901.1096078-1-mingo@kernel.org>
References: <20240308105901.1096078-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All major Linux distributions enable CONFIG_SCHEDSTATS,
so make it more widely available.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ef36b829ae1f..0d6700f23ca4 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1250,7 +1250,7 @@ config SCHED_INFO
 
 config SCHEDSTATS
 	bool "Collect scheduler statistics"
-	depends on DEBUG_KERNEL && PROC_FS
+	depends on PROC_FS
 	select SCHED_INFO
 	help
 	  If you say Y here, additional code will be inserted into the
-- 
2.40.1


