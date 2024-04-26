Return-Path: <linux-kernel+bounces-159760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D213A8B33A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E23B283472
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC1013F426;
	Fri, 26 Apr 2024 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Kvxscx6g"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EF413D500;
	Fri, 26 Apr 2024 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122804; cv=none; b=BOvXXwmttJuVzR2hQr6OvPqI3EbCvWHealJaTK4pczphPiyVZZzMgnnEIwsy0ccN+oCbwtcnHyC/YfVrBGFJEhy6BcPiYLEtwSuklnhyQW+N0BNNO8RHXrt0A+lPdhCkhzDJ/DFn9e8+Dj3fkafzmv4mFlAoEu6VZLBW5aXZY/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122804; c=relaxed/simple;
	bh=9s0mATnN17jEJYUCW4+yq71pom+Nt3UtcqB4xbXFZ7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6XNJKMbfprP6hQg5++uiw/DZqEE6sy4hZmYQImSu4piGi6zIA66CnjzBPOljPWWkeGULE0GnTE/xyZ03mHGV7bOhp8Du7xRofkT8p6Xc8ZMcJFqVpUJXsp51JxIEgkdC68dhJicvd7MeUuN1SdzZRU629BE/wCNYo4dhSSMV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Kvxscx6g; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id C19BE600B1;
	Fri, 26 Apr 2024 09:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1714122793;
	bh=9s0mATnN17jEJYUCW4+yq71pom+Nt3UtcqB4xbXFZ7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kvxscx6grJ1CTmvgKJiu28JcHEpSuqoYNQdFRTBV8WF18J3Zl6/5AQ6Mj1Oi4/7I/
	 heK+iFloz/yJMJSZ5eeDOkqM7T037XYTuelPpnyruK14B60Czkl4t1N9f1Afc4jBVt
	 2zsCYrBzVO/YV84GQpFhNwOYassMXI/r6n3UsMCMbqFxx933wv95PuFoG+9JZHVvMB
	 YXHm5s1c/ZYn7uh0cwPMr+FFLk0esp+YdzwXiZ1ccI5VUH0E+U+zwCOalCYAfk8g2g
	 +rh3GmzXboHN+3H1VUjHeWAWYlDKqiyumwDC53ajOf6ylNPZR8Vu5JfuBwol/eOw41
	 rQXXq83BuXBPQ==
Received: by x201s (Postfix, from userid 1000)
	id 6C2B821BB44; Fri, 26 Apr 2024 09:12:28 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH net 1/4] net: qede: sanitize 'rc' in qede_add_tc_flower_fltr()
Date: Fri, 26 Apr 2024 09:12:23 +0000
Message-ID: <20240426091227.78060-2-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426091227.78060-1-ast@fiberby.net>
References: <20240426091227.78060-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Explicitly set 'rc' (return code), before jumping to the
unlock and return path.

By not having any code depend on that 'rc' remains at
it's initial value of -EINVAL, then we can re-use 'rc' for
the return code of function calls in subsequent patches.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index a5ac21a0ee33..8ecdfa36a685 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1868,8 +1868,8 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 			    struct flow_cls_offload *f)
 {
 	struct qede_arfs_fltr_node *n;
-	int min_hlen, rc = -EINVAL;
 	struct qede_arfs_tuple t;
+	int min_hlen, rc;
 
 	__qede_lock(edev);
 
@@ -1879,8 +1879,10 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 	}
 
 	/* parse flower attribute and prepare filter */
-	if (qede_parse_flow_attr(edev, proto, f->rule, &t))
+	if (qede_parse_flow_attr(edev, proto, f->rule, &t)) {
+		rc = -EINVAL;
 		goto unlock;
+	}
 
 	/* Validate profile mode and number of filters */
 	if ((edev->arfs->filter_count && edev->arfs->mode != t.mode) ||
@@ -1888,12 +1890,15 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 		DP_NOTICE(edev,
 			  "Filter configuration invalidated, filter mode=0x%x, configured mode=0x%x, filter count=0x%x\n",
 			  t.mode, edev->arfs->mode, edev->arfs->filter_count);
+		rc = -EINVAL;
 		goto unlock;
 	}
 
 	/* parse tc actions and get the vf_id */
-	if (qede_parse_actions(edev, &f->rule->action, f->common.extack))
+	if (qede_parse_actions(edev, &f->rule->action, f->common.extack)) {
+		rc = -EINVAL;
 		goto unlock;
+	}
 
 	if (qede_flow_find_fltr(edev, &t)) {
 		rc = -EEXIST;
-- 
2.43.0


