Return-Path: <linux-kernel+bounces-94301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08401873CC2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ABF71C22A9A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A5713BAD5;
	Wed,  6 Mar 2024 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="FBGdCd14"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D4313958C;
	Wed,  6 Mar 2024 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744339; cv=none; b=olrFbYrqcSFQcoSH4eTYTZESFRhJj8FtURT6LjapZpFCMF/1mGPRpX4GUABMwuoLgYF1LrWE9TMya5IvQJIkQwB9s0Cbh+4vncuKGyVisC494RHyE9zjbbLAT35i+FWBIyaxPUbeVN4xxB4jpzW7DFO8CVpx2lHb/nigBpSjYi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744339; c=relaxed/simple;
	bh=0qX6BUcKSD/m80wV0OqOMy5T5kt64bceTHF5BMHCdPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vi7dduzMmRSpSsyRiLI2omccQz1V/p5vMg909j/IvpmPzBQ5CtZKSrOTldNyD8QjfuXgE2tRBBnotuqZalRNQgMFSt8GTRzowXes2uASYStfHGGgxn6LTsIcqGmUoAJMGsPBJxTmAJpdF5OjCLkipeuAoj8TZdatsvOdPymk0ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=FBGdCd14; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8CF696030A;
	Wed,  6 Mar 2024 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1709744326;
	bh=0qX6BUcKSD/m80wV0OqOMy5T5kt64bceTHF5BMHCdPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FBGdCd14MTKWxXFYmqJ5+2p9IcCI2AX44huOxLUUquSpAT5M4Fcpw0yQi7hXqsq3g
	 1Ktze2xoBPnhgiIdBb7nl3XVNmLdvuAoRq6se0BqzIxvMTsTHRkSnNtwTlieC6dcrk
	 IUEOxLND3B80OCcFb89zvj95Nym4utts57oPma6mR5GIsLYMRgYmjxIMUOQKIC5X2+
	 bEEqjEPLgX/lRaas13S8v2z/f9clMdhlQDL9s4gTFiAkbN6yNuZD85o6d1vuGdkrgf
	 G4baK3cQC2SaEKbSLCrv2pyEFum1tPfI4c9dfnxmZ8ukdL/6enblnTcY0ob0Tfp+5X
	 HN/tEGg3TlWqA==
Received: by x201s (Postfix, from userid 1000)
	id A37E02022E5; Wed,  6 Mar 2024 16:58:23 +0000 (UTC)
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
Subject: [PATCH net-next v3 1/3] net: sched: cls_api: add skip_sw counter
Date: Wed,  6 Mar 2024 16:58:09 +0000
Message-ID: <20240306165813.656931-2-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306165813.656931-1-ast@fiberby.net>
References: <20240306165813.656931-1-ast@fiberby.net>
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


