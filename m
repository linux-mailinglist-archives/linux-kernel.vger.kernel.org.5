Return-Path: <linux-kernel+bounces-39587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4B383D33C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 05:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F251C20E29
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E3E14000;
	Fri, 26 Jan 2024 03:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKiEPHr3"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330C9134B4;
	Fri, 26 Jan 2024 03:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706241571; cv=none; b=jzehRphXthRQM9FKuLa/87ueZxoM8yoiHjBeOvmmBFdEQVHDdB3ltxqwkwpV9KnDhjhCp2JJrJYbgmmr+A1sfqHH3qrfeA2j6sMohV14X2L1ygW2L3t6+BEPGO1xOvw1LSGdtuB9oMlepDq0F8wR447SgDWJSUMQTauAcxZUoF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706241571; c=relaxed/simple;
	bh=ylOIlHqOJG6E0x00v/MZNcyHg+iK/0JNIf3jGtejI1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/o8YsuRFR0AMqHQ1eCgpV9MUv5pye9Al7voqnUeleOius53Gnvrxc3Ml/amqKD1UGpa2lwPW9fcPzGsNaGRXVkKpLTIK0qk9YoCSuaRu+sDZEU1LNawATXLLjCFfhayjaxxFq376Bp33+Oi05Sj8siiR3SKTp/8W/7orTrM6m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKiEPHr3; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-783caa65596so15144985a.0;
        Thu, 25 Jan 2024 19:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706241569; x=1706846369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B3NtesrpF60wKxTb83nmzWJ1QcpAFUdRd/o+SUR0tUI=;
        b=RKiEPHr3feBgKF/8ElSJlNo47gCZ8P2PPo9HLkmcJudzdKg3saLBgW/aT3mWt1af9L
         sXr0YJRW4SSF3RnnFK7B6nZOIQaHMbrR3Ofi1LndrUbZJx225TRszy/8ihSCsY8qQqK0
         En3HIozjIQmbpqpxoB1IIBqWTBcmTSfVP3mHXutdSVHG0sWy/BdQt2bxGemrYWc2Qa3f
         EI9+LhNKO3PJdrbc4GMhZc+Rg9wGswzb2RkzELMPKheYbXSG3pS7t9enKPraezYHDpaT
         eu1XcFdNLvYc23+pIY/wfHrBRJmUg9RzhqQW+Q2AFNPFMWzNyDchfPn3RY8bHEo6p+Iy
         u/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706241569; x=1706846369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B3NtesrpF60wKxTb83nmzWJ1QcpAFUdRd/o+SUR0tUI=;
        b=jNn1zYboZx/S//lVS9veEh70ze6OLxPGuTrbanTktkPz9n4JXw+FVg6pTZyMPT112G
         JLahYzJLpwYKb0tHa1WbmKfPB4XJy4sH30uAm7RqrIB//TNcl6ZhVvA5pM+22cEnyP+A
         TwIU3nk1avi0jcRAuy0V8mdocvj+EoQ/Kv+ONzEoafn2TEnojFU9NmHQhQWIDhq/w0zo
         uqzXcZgzWblP6C95ba2SFriR4ZIDetOPt3bGB2GRL116qXN2mayRiWCZUIj7ZDx9zpK2
         6VgMOagBDHYc/N4ew0L1VyzoSG+sSbK94IiBOVm2lmhcdDazn+lfSMC1AVfPlLH3LZ9t
         3y0Q==
X-Gm-Message-State: AOJu0Yy1qyio7Rv97PuTustENlKT1TeMFw6ioP8dloyrmWarzwgRj/ld
	k6blAS654V8NRBUEUKwMbYIOzk9wRloumfCm94EKZejKT2AgkEdKJXG8YMRc
X-Google-Smtp-Source: AGHT+IElRErJwV2ljvL8tPbOSZeIk8+4q1ywGFWbxwSc1uufyLTvMsR/x2BDC1ySPssFgq8LF3evCA==
X-Received: by 2002:a05:620a:4885:b0:783:cdc6:6624 with SMTP id ea5-20020a05620a488500b00783cdc66624mr585545qkb.65.1706241569077;
        Thu, 25 Jan 2024 19:59:29 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id s12-20020a05620a16ac00b00783949e7817sm208651qkj.92.2024.01.25.19.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 19:59:28 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id 6F9B027C005B;
	Thu, 25 Jan 2024 22:59:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 25 Jan 2024 22:59:28 -0500
X-ME-Sender: <xms:Hy6zZfQuu9GO7_sl_0dWr6wT4vxmjmaUCnHo1bsyC6QlFPYxDMkeIg>
    <xme:Hy6zZQxSyKEanuCPovWZCjDldZwqv5RiAahdGGnkSURhU578mxaanuqx-KzhDroEB
    numWzec1t-OSYpR5Q>
X-ME-Received: <xmr:Hy6zZU0Pct6XUduBNvCVNmY3e7qTF89jZQADtqMgRx5uELgegCqo6q_sTIM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeliedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Hy6zZfAdL1Y9srhvC7_g49BB8dSM4xPQyv340c655SdF54fKOh1ing>
    <xmx:Hy6zZYgjefzyNxiVLQLaNa5CmYQ30cJ06BktDRmWY5akM2aZ0Vz6XA>
    <xmx:Hy6zZTrtxof_bbk5ZTbS_7ZZjLN8Sf9P9mS9oKjtM4Yl0q9U22Gv2g>
    <xmx:IC6zZZbtABUv6v6Hz4Yv9F986kaEuyiUEQPuKiiQMl6kF-v3WP0pZw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jan 2024 22:59:27 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 8/8] doc: Update checklist.rst discussion of callback execution
Date: Thu, 25 Jan 2024 19:58:11 -0800
Message-ID: <20240126035816.3129296-9-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126035816.3129296-1-boqun.feng@gmail.com>
References: <20240126035816.3129296-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit completes the list of call_rcu*() functions that are not
guaranteed to have their callbacks executing on the same CPU.  While in
the area, fix an unrelated typo.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/checklist.rst | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index addd5c1547a4..3e6407de231c 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -383,16 +383,17 @@ over a rather long period of time, but improvements are always welcome!
 	must use whatever locking or other synchronization is required
 	to safely access and/or modify that data structure.
 
-	Do not assume that RCU callbacks will be executed on the same
-	CPU that executed the corresponding call_rcu() or call_srcu().
-	For example, if a given CPU goes offline while having an RCU
-	callback pending, then that RCU callback will execute on some
-	surviving CPU.	(If this was not the case, a self-spawning RCU
-	callback would prevent the victim CPU from ever going offline.)
-	Furthermore, CPUs designated by rcu_nocbs= might well *always*
-	have their RCU callbacks executed on some other CPUs, in fact,
-	for some  real-time workloads, this is the whole point of using
-	the rcu_nocbs= kernel boot parameter.
+	Do not assume that RCU callbacks will be executed on
+	the same CPU that executed the corresponding call_rcu(),
+	call_srcu(), call_rcu_tasks(), call_rcu_tasks_rude(), or
+	call_rcu_tasks_trace().  For example, if a given CPU goes offline
+	while having an RCU callback pending, then that RCU callback
+	will execute on some surviving CPU.  (If this was not the case,
+	a self-spawning RCU callback would prevent the victim CPU from
+	ever going offline.)  Furthermore, CPUs designated by rcu_nocbs=
+	might well *always* have their RCU callbacks executed on some
+	other CPUs, in fact, for some  real-time workloads, this is the
+	whole point of using the rcu_nocbs= kernel boot parameter.
 
 	In addition, do not assume that callbacks queued in a given order
 	will be invoked in that order, even if they all are queued on the
-- 
2.43.0


