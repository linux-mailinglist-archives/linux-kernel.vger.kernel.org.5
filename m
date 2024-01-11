Return-Path: <linux-kernel+bounces-23363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9FC82ABA0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0611F23B27
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B1212E6E;
	Thu, 11 Jan 2024 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="n2PCtOuU"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A6E12E4C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240111100956epoutp031b8c68cb77319a367646577a4d8851f6~pQy13hzFm3269232692epoutp03_
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:09:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240111100956epoutp031b8c68cb77319a367646577a4d8851f6~pQy13hzFm3269232692epoutp03_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704967796;
	bh=rOSaugW4HgwR/OGMwEvr/uequ4lFGLwt4vZNG2atrCg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=n2PCtOuUK8QF8viCYzsbrvoGkTwskW/+SSa74i/ikhTgdOQPCd8+50qJUNZJNPVQR
	 OvKNA29nCU4oqXlnwwgdJgG4dCBdqJ1DgL8Rfry6VNK+1Aec2hLZvrX5V03Lr+U5PQ
	 JBPmhbEzGOOc/R7LnN6TUv4+7uhxx4AkidbClZk8=
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.42.80]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240111100955epcas5p30b39af37a470380276ce5c13fa80f325~pQy1Igb7A1877718777epcas5p37;
	Thu, 11 Jan 2024 10:09:55 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DB.3E.19369.37EBF956; Thu, 11 Jan 2024 19:09:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240111092805epcas5p2ebb993010ae31d039e8f9de1e7818f7c~pQOTew75o2611126111epcas5p27;
	Thu, 11 Jan 2024 09:28:05 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240111092805epsmtrp25a16d740e19af0f0fd4935b028441b9a~pQOTd_HKN0796607966epsmtrp2T;
	Thu, 11 Jan 2024 09:28:05 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-00-659fbe73b83e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	0F.7E.18939.5A4BF956; Thu, 11 Jan 2024 18:28:05 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240111092802epsmtip2a15f88b2710903e6573a3169282f850a~pQOQ9_sXL0381003810epsmtip2_;
	Thu, 11 Jan 2024 09:28:02 +0000 (GMT)
From: Onkarnarth <onkarnath.1@samsung.com>
To: paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
	joel@joelfernandes.org, josh@joshtriplett.org, boqun.feng@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	r.thapliyal@samsung.com, maninder1.s@samsung.com, onkarnath.1@samsung.com
Subject: [PATCH 1/1] rcu/sync: remove un-used rcu_sync_enter_start function
Date: Thu, 11 Jan 2024 14:57:22 +0530
Message-Id: <20240111092722.322454-1-onkarnath.1@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7bCmlm7xvvmpBl9/Klqs2dLIZLGgaS+r
	xdS1u5ksljWoWvxfkG9xedccNovD89tYLDafPcNssaLnA6vFpyXfWCw+zPnHbvHmyi82i433
	si3Ozj7HarGv4wGTA7/H0tNv2Dx2zrrL7tGy7xa7x8JPX1k9br229di0qpPNY+KeOo++LasY
	PT5vkgvgjOKySUnNySxLLdK3S+DKuHPmN1PBR96Kn6dOsDUwXuPuYuTkkBAwkVjUd4yti5GL
	Q0hgD6PEjE3f2EASQgKfGCXeTnWESADZxzYuZYXpWPlgBxNEYiejxIbW71DOF0aJXV2bmECq
	2AS0JGbcOQCWEBH4wSjRPbOXHcRhFmhilJh/fCrYEmEBb4kHV06D2SwCqhKzF28FKuLg4BWw
	lfjfbQ+xTl5i5qXv7CA2r4CgxMmZT1hAbGagePPW2cwgMyUEFnJI9Mz+xwzR4CJxesEZJghb
	WOLV8S3sELaUxOd3e9kg7HyJltmzmEF2SQjUSFx9qgoRtpd4cnEhK0iYWUBTYv0ufYiwrMTU
	U+uYINbySfT+fgI1nVdixzwYW1Xi15SpLBC2tMT933PZIKZ7SPxZbwYJ0ViJyYd6WCcwys9C
	8swsJM/MQli8gJF5FaNUakFxbnpqsmmBoW5earlecWJucWleul5yfu4mRnAa0wrYwbh6w1+9
	Q4xMHIyHGCU4mJVEeBU+z0kV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvu6dW6KkEB6Yklqdmpq
	QWoRTJaJg1OqgWmDlXzzsSmOz6QdRW7z8N6JO/ZCh1HbjyfTZjZrm1vIGWFrL5b0DclX5RPe
	py33OWZ9yKTYqfA0q5jBa1Objqv2KsvqFI+X/dju/fhKm+Saswfu/9teefFPaUbFuch4qYeZ
	xTaLRaNX7Mx+FLfHitHW78tKS51V8reF1/7IuK/4d4Hf0hnbxJQ6gheKdQYunGNivXLO7P5b
	gf0st3KDFly/1vf6osgPPeu/PPs/vk2+td93KXdKkqnXmzPXREP1N+v4/3B8+1I9TOLV6fI4
	k502a2qFYma6mrFu9JW1TT9V6smVeaat7Uesi+KUXQ5e05UWGbL+1JLxv6LkMO2P3yaLrQK6
	cdqnWwKZkvUdlFiKMxINtZiLihMB8mBVetIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSvO7SLfNTDf6sVrZYs6WRyWJB015W
	i6lrdzNZLGtQtfi/IN/i8q45bBaH57exWGw+e4bZYkXPB1aLT0u+sVh8mPOP3eLNlV9sFhvv
	ZVucnX2O1WJfxwMmB36PpaffsHnsnHWX3aNl3y12j4WfvrJ63Hpt67FpVSebx8Q9dR59W1Yx
	enzeJBfAGcVlk5Kak1mWWqRvl8CVcefMb6aCj7wVP0+dYGtgvMbdxcjJISFgIrHywQ6mLkYu
	DiGB7YwSmy61sEMkpCU+XZ4DZQtLrPz3nB2i6BOjxNWrM5hAEmwCWhIz7hwA6xYRaGGSWLr4
	DSuIwyzQwShxe+8lsHZhAW+JB1dOs4HYLAKqErMXbwWKc3DwCthK/O+2h9ggLzHz0newcl4B
	QYmTM5+wgNjMQPHmrbOZJzDyzUKSmoUktYCRaRWjaGpBcW56bnKBoV5xYm5xaV66XnJ+7iZG
	cDxoBe1gXLb+r94hRiYOxkOMEhzMSiK8Cp/npArxpiRWVqUW5ccXleakFh9ilOZgURLnVc7p
	TBESSE8sSc1OTS1ILYLJMnFwSjUwlUX63T+8k+3Amn3Ocret6iJ7eQv1LqQv1bR+c1lsUeBH
	0eXpOsta9touK5m9vmSJzoFJ4sw/X9tITIv6VMuVynvc3qBTMCjvlrNyw/H3N3nb9+6unvSp
	fW6i32z5qP26BlP22mSc1F2+/MZMzuu9V9ZP+fVx2+FFbD0L7NaW1C+/+i0q9XzZOUXZjVHy
	+f9OCB/LOn3gkoHt+3K9L2opK7STnhRc4lghmOcYpe2/61VshsMR69M/H6fUXZ/vela2/NKS
	c+FW3iblWpMkI3f9a1jqOaFJIHDfFtF1S/7MF7hSzM249vtCPfPlarHHI1+sFNh3aUnP0Vf2
	qwI32MS84k39OJVz/rF1GmsZtXjTfiqxFGckGmoxFxUnAgCoLIAF9gIAAA==
X-CMS-MailID: 20240111092805epcas5p2ebb993010ae31d039e8f9de1e7818f7c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20240111092805epcas5p2ebb993010ae31d039e8f9de1e7818f7c
References: <CGME20240111092805epcas5p2ebb993010ae31d039e8f9de1e7818f7c@epcas5p2.samsung.com>

From: Onkarnath <onkarnath.1@samsung.com>

With commit '6a010a49b63a ("cgroup: Make !percpu threadgroup_rwsem
operations optional")' usage of rcu_sync_enter_start is removed.

So this function can also be removed.

Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 include/linux/rcu_sync.h |  1 -
 kernel/rcu/sync.c        | 16 ----------------
 2 files changed, 17 deletions(-)

diff --git a/include/linux/rcu_sync.h b/include/linux/rcu_sync.h
index 0027d4c8087c..3860dbb9107a 100644
--- a/include/linux/rcu_sync.h
+++ b/include/linux/rcu_sync.h
@@ -37,7 +37,6 @@ static inline bool rcu_sync_is_idle(struct rcu_sync *rsp)
 }
 
 extern void rcu_sync_init(struct rcu_sync *);
-extern void rcu_sync_enter_start(struct rcu_sync *);
 extern void rcu_sync_enter(struct rcu_sync *);
 extern void rcu_sync_exit(struct rcu_sync *);
 extern void rcu_sync_dtor(struct rcu_sync *);
diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index e550f97779b8..86df878a2fee 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -24,22 +24,6 @@ void rcu_sync_init(struct rcu_sync *rsp)
 	init_waitqueue_head(&rsp->gp_wait);
 }
 
-/**
- * rcu_sync_enter_start - Force readers onto slow path for multiple updates
- * @rsp: Pointer to rcu_sync structure to use for synchronization
- *
- * Must be called after rcu_sync_init() and before first use.
- *
- * Ensures rcu_sync_is_idle() returns false and rcu_sync_{enter,exit}()
- * pairs turn into NO-OPs.
- */
-void rcu_sync_enter_start(struct rcu_sync *rsp)
-{
-	rsp->gp_count++;
-	rsp->gp_state = GP_PASSED;
-}
-
-
 static void rcu_sync_func(struct rcu_head *rhp);
 
 static void rcu_sync_call(struct rcu_sync *rsp)
-- 
2.25.1


