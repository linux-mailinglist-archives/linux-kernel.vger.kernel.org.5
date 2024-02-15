Return-Path: <linux-kernel+bounces-67280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5850885691E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D4F1F27110
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C161353EE;
	Thu, 15 Feb 2024 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="q+DVNN2Q"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFD91350F0;
	Thu, 15 Feb 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013202; cv=none; b=Yt1g1QdaAdZt+tzW/qHQRnkMXVJSE81wb11aM4juZOdfLgi6BRZhiCeehIf1tlK9KqeyTLSJ8nEx8noJXLzGRz1Do6ul2DLoC2gEst/6sK5y4LcclQseJSca2XxJSnPu9j7TbIiXQhSKSuwcR40eQoYpiGIfbn6drr96adsxlmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013202; c=relaxed/simple;
	bh=akjpUr+ZYSjEQ/296swH0R+gJmt5trZjoLKfmLO+NZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6cmz3/Oo016awz1fZcC2MbXZFD7PGBxR27dUKPwq8IaHTXUsQgLczsY91WXgyBHcP6OSuOqWyo4eaksIo/LN5aVqsOwyhzmqMcVdRBv1qUKPpAY2EITjgmRDfHbpyOIRuZ5SEpwBauq6VGeHgG5PPRzaVBAPcDKF7ilJfcG5Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=q+DVNN2Q; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 0E11F600D4;
	Thu, 15 Feb 2024 16:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1708013196;
	bh=akjpUr+ZYSjEQ/296swH0R+gJmt5trZjoLKfmLO+NZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q+DVNN2QORy7bWZJmmlebtJiMPJDFrwsJrv5EHEWHCk5oEuNzyP+UCunwTvFR9dvu
	 dn+LZ7CSwcrQPShycKPCZ+Aqc9IRXWZaYmAjCg+Nb3X0OcUmkhfpZZBHN4/7jbxvvq
	 w5ymk2v4y9F7HIk3xnvFAEnyb+dJWAnnvapHXPdE6BiMHtRksemd7laYjg4THKBLMo
	 Rqogm2f+2zKhVl9QNSfHdJdZmEFPkJL+owLTCUu9yL/k3qR3jmr4fe8mmZkfLShX5J
	 qbMvemeeVmmU79S/8Ptf1LyGOngQ3KAHnEv/NWvAmwG40/CVZFhnohOTiKDvuNTXHX
	 HNOXDs+ShwJYA==
Received: by x201s (Postfix, from userid 1000)
	id 42E0D202FB6; Thu, 15 Feb 2024 16:05:44 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llu@fiberby.dk
Subject: [PATCH net-next 1/3] net: sched: cls_api: add skip_sw counter
Date: Thu, 15 Feb 2024 16:04:42 +0000
Message-ID: <20240215160458.1727237-2-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215160458.1727237-1-ast@fiberby.net>
References: <20240215160458.1727237-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Maintain a count of skip_sw filters.

This counter is protected by the cb_lock, and is updated
at the same time as offloadcnt.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/net/sch_generic.h | 1 +
 net/sched/cls_api.c       | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 934fdb977551..46a63d1818a0 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -476,6 +476,7 @@ struct tcf_block {
 	struct flow_block flow_block;
 	struct list_head owner_list;
 	bool keep_dst;
+	atomic_t skipswcnt; /* Number of skip_sw filters */
 	atomic_t offloadcnt; /* Number of oddloaded filters */
 	unsigned int nooffloaddevcnt; /* Number of devs unable to do offload */
 	unsigned int lockeddevcnt; /* Number of devs that require rtnl lock. */
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index ca5676b2668e..397c3d29659c 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -3483,6 +3483,8 @@ static void tcf_block_offload_inc(struct tcf_block *block, u32 *flags)
 	if (*flags & TCA_CLS_FLAGS_IN_HW)
 		return;
 	*flags |= TCA_CLS_FLAGS_IN_HW;
+	if (tc_skip_sw(*flags))
+		atomic_inc(&block->skipswcnt);
 	atomic_inc(&block->offloadcnt);
 }
 
@@ -3491,6 +3493,8 @@ static void tcf_block_offload_dec(struct tcf_block *block, u32 *flags)
 	if (!(*flags & TCA_CLS_FLAGS_IN_HW))
 		return;
 	*flags &= ~TCA_CLS_FLAGS_IN_HW;
+	if (tc_skip_sw(*flags))
+		atomic_dec(&block->skipswcnt);
 	atomic_dec(&block->offloadcnt);
 }
 
-- 
2.43.0


