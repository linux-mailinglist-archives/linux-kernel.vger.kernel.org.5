Return-Path: <linux-kernel+bounces-92550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01959872210
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF431F23D34
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8E5126F21;
	Tue,  5 Mar 2024 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="VCxbptHS"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490BE8595C;
	Tue,  5 Mar 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650508; cv=none; b=bMdct3j65Y7EMSxEoNN8YpA+N0zfBs2KStMSZpvsBk7c6/j/IMyK6CvyfTiO2LVCoC94/o1xyRTX/Nvmz9rJNYwIIib5trwlx9ftlYdJj9dUKza2oBFQj2I5raGdY3jEhXuxUXBh5QegqJDPee0bqebkhcLUdF34e1dlpHfDs1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650508; c=relaxed/simple;
	bh=0qX6BUcKSD/m80wV0OqOMy5T5kt64bceTHF5BMHCdPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e6Bv81SP64fmLokPLlTZiQHZKjHxzzQF3MNk303h322KuwlAWYH1voIGtfI1ISBU0s6Zc+Bj3loumJuAafgbLfoI+dbbfzxReje1SrizVO2RDTTLh8vawXJRm1s9lxU/nxwwrbOH1ZfXmPOZleo2TEZKdr/ubhgW26pIsjRE1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=VCxbptHS; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 640066030D;
	Tue,  5 Mar 2024 14:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1709650007;
	bh=0qX6BUcKSD/m80wV0OqOMy5T5kt64bceTHF5BMHCdPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VCxbptHSM/IYfV92bRifT6E1x/LO21IwCQNO16G1cy5qhqHPzMgpTKu6Aa3YBbid4
	 0DDcoqQmamoXfKXso9H3cl46JsmTapQ6JH/owMmGPWyYcZy0WGnb6EoN5cLY0wiMFe
	 3g1OELQUuTYFzwvtV/bbhefpcd6bSKcSeuoPhxdL8ILFT+0bN4IwEiabeCT6aXgcmv
	 ORuaNI72aTJIHmb/QgBmOrMmMbtkBGUESjZgWopRwWOfcOTpW6aVm6UDkQ7PAY3TQt
	 2vaCoQL3wh6Iq+RMbNo2dTeSZGQVvlGRbJ9BaOSUeozFZV4QRhSrylHf2S+1CS8Jx6
	 kYmsthpAK+xAg==
Received: by x201s (Postfix, from userid 1000)
	id D0F0D200D88; Tue,  5 Mar 2024 14:44:54 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Vlad Buslov <vladbu@nvidia.com>,
	Marcelo Ricardo Leitner <mleitner@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llu@fiberby.dk,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next v2 1/3] net: sched: cls_api: add skip_sw counter
Date: Tue,  5 Mar 2024 14:43:54 +0000
Message-ID: <20240305144404.569632-2-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305144404.569632-1-ast@fiberby.net>
References: <20240305144404.569632-1-ast@fiberby.net>
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
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
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


