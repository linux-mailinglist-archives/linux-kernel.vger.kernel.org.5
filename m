Return-Path: <linux-kernel+bounces-100179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18713879315
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF38B2206C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F7F79B84;
	Tue, 12 Mar 2024 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmeYNJEG"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3663069D0A;
	Tue, 12 Mar 2024 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710243334; cv=none; b=sxn2pyqahLdzf4juxRQy0yPGeZEmw3kSoaJUPbD9Tdb+eWUCHFKUBJZvB9XHhjjK9SxnK3Tr/zoeKsNO5/yJDXLUjF4aN4JRBdnK2/G/r/nXTF+oRz2uWBL6rESlzwD7j01Mg5PQ6jXR0A2W3pqz74ixOerKRCOq3Q3QgTTOvVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710243334; c=relaxed/simple;
	bh=O9SDTjN4m4+ACDZlbjWHiqnW6+aHwqWTMkM+PP87lSE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=beytL5CLh+eH3VfOGwDOb3xOGTs9Mwk9zpPccViX7MwBwpsz8c0wW7ZW4/pwmoyVBL6CeXrXUeLCdbyF3zXB+qjDkxsj6kLRFrMy5MwePWLSHMSBCZHqipGsx+qnuCUpuwGTaa25xdlctdGoWpdEiM7Ia5zA1oI+P5b6Qeb1NKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmeYNJEG; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29bd0669781so2052452a91.1;
        Tue, 12 Mar 2024 04:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710243332; x=1710848132; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTp9zNusEHYNa4JuUgat9/OWqEmIx9Z3+sIRQXRqG48=;
        b=UmeYNJEGfaRsZaVUuK+eIH+I533aKipoAx9Xi871HyaIMNpjxRZm6DeMt9iUhnY2Ee
         RYZWHDK4BOooYTQpaJVYOrQMGQfaA7Ti8mesQtKXmIPyJxpSFW/6x0pJVAb20vGE+c5D
         EVaCon9NeROArqE9cX1UF87l/eFiAkWkoMtg7xCzVKr7iXgKc6c6LE6aqbmWlIInIklh
         nqfnatxAjfcET420+ZSvtXEO3tE0SbHMHvFfZ2KmXYGDaPeh2PUqPIWaEzyfe8/kHJC5
         s1MvCAulWoE7I0kGx0LamhbAJ/T11MbwuXEqGoHFSX+5sS5ORGL7nfrCjZW+lGJjvtZL
         tMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710243332; x=1710848132;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTp9zNusEHYNa4JuUgat9/OWqEmIx9Z3+sIRQXRqG48=;
        b=BSEYJnkzfC/ahamFF6GXsFCQbMUMcSsADxmFPC4n9bGZ4MtJL5EvJziRdvo94Lfnj+
         8w2nztdExkDOMXYp9bi4QW/ghZDivXcrhJxghTB3dAD53TJCXF2fVOhStsXaUoj3RQt3
         VL817qz7iSIbPOE0jNa0ulkbBPpvusxoJcgrM5aQnv10RSrvuH0WulSbggSXHiwZbvE/
         tK86fjmQAQaoM2VAMtPfWuBAuMBQXeJ/8PhHd81dXqFsjNhnOYH+ERQzVLdsFbCqzKGY
         1eVYzwqopD9xJNJ6VVumd4BM8Q37qTtk1vkLIEPZ+dmDet8PatyxlRKDxCqBV+gy0oCF
         2KCg==
X-Forwarded-Encrypted: i=1; AJvYcCVnvAFc4mApGHm4VENNCeIJ2rBF8OR+4kwAeckumWUh0e5PDsZT3dqesS+XQ2yBl0Ew16402QE8NPRorvOBko051QsK+Lv74p3/hjlkh+JLPkXhIgTV9MC7noXzd3GBdEjR
X-Gm-Message-State: AOJu0Yw+rAsrwEpVcjmjUxehY4c2ouvEWFjsXGaErf77yzbl61V/bAFS
	lvObIMiPoRxQPdAgtzbCG0wKKcTVmZC6AMXAgoKYzwl3ztPD02YgKNv9Iw5s
X-Google-Smtp-Source: AGHT+IED26I8/64mXLsxuC7CSlYxSuV8S6W1vv/N52uGphSfMXZGRXioHOND8IQSdjGjlRAkdm7n8g==
X-Received: by 2002:a17:90a:4096:b0:29b:7a28:a795 with SMTP id l22-20020a17090a409600b0029b7a28a795mr7240463pjg.12.1710243332481;
        Tue, 12 Mar 2024 04:35:32 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090a654c00b0029ba4d9b128sm5472286pjs.57.2024.03.12.04.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 04:35:32 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcu-tasks: Remove unnecessary lazy_jiffies in call_rcu_tasks_generic_timer()
Date: Tue, 12 Mar 2024 19:35:24 +0800
Message-Id: <20240312113524.7654-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The rcu_tasks_percpu structure's->lazy_timer is queued only when
the rcu_tasks structure's->lazy_jiffies is not equal to zero in
call_rcu_tasks_generic(), if the lazy_timer callback is invoked,
that means the lazy_jiffes is not equal to zero, this commit
therefore remove lazy_jiffies check in call_rcu_tasks_generic_timer().

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index b1254cf3c210..439e0b9a2656 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -299,7 +299,7 @@ static void call_rcu_tasks_generic_timer(struct timer_list *tlp)
 
 	rtp = rtpcp->rtpp;
 	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
-	if (!rcu_segcblist_empty(&rtpcp->cblist) && rtp->lazy_jiffies) {
+	if (!rcu_segcblist_empty(&rtpcp->cblist)) {
 		if (!rtpcp->urgent_gp)
 			rtpcp->urgent_gp = 1;
 		needwake = true;
-- 
2.17.1


