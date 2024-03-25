Return-Path: <linux-kernel+bounces-117994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4674188B231
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C986EC648FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1014271738;
	Mon, 25 Mar 2024 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="EiEFkAC9"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2F55D723;
	Mon, 25 Mar 2024 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400052; cv=none; b=Zp0s4N7P99Q14FT93ocxWEZWi8Vfkvr9R7E2IgyFZtZJmUeohM5TMvk/8buJfdj5bp31RcLV8B6OObHpVK9GVBkQ0fucFBSQVgc32FC2oIaDlvbcfFZvJFPbrB9/umY8PDvcONSbrWkdXekvxlTOzSCYNi2qw/x2fUsAgOe2QN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400052; c=relaxed/simple;
	bh=hZuTiHOZSNOnV/RnssrMjJTe2eOUX3VXDysAnQilAAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmNiGdMX1UT1FtEmEUIQnnTtC7+OTTKcTQORt9NID7Z/mb3DecAHvxB/VdSPAjoTiJhG+ldd6Z6zuc5falI9qnLGSe1PffJUlHj7cVkQcp3odcXjQVczNG9ebEzHZQpPzTMtbQvMP6bDmbwf2BJUGBDqxMbOJLqSUWsCYGXFfo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=EiEFkAC9; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 5EF666030B;
	Mon, 25 Mar 2024 20:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1711399726;
	bh=hZuTiHOZSNOnV/RnssrMjJTe2eOUX3VXDysAnQilAAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EiEFkAC9JMQRewKe1gebFBf1DFr8ZhxyPvG9Gla/eJebzEFSKItg2mhOIO/y9FDOr
	 emuoZL3RaN8zuI1wmZWMO+TRK+LJpQzTEj2GucbRf2k0ghT4rNAaCrplPj6eYEIQRJ
	 8q89Jq+OdSM+3rWswmtDGa8ChcZiu7oH9Htpd9ZUlbNU8ETTE39hFAQ2hlt8KpWlCz
	 zQg5fn86y/+tZ6ekGEaoWJs2jlf/sfzAdA2ibLNX//jhuW1C3uoe6ZlCkUO57j8phZ
	 XJcmtjXbPt8ohByShadkmcnXmn3ZzgB7+wM4utfEv7fgt9Cp0m0Z97pgdlUVcnpPIH
	 S5tUv7AzEJttQ==
Received: by x201s (Postfix, from userid 1000)
	id 6DD8F204AFD; Mon, 25 Mar 2024 20:47:50 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vlad Buslov <vladbu@nvidia.com>,
	Marcelo Ricardo Leitner <mleitner@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llu@fiberby.dk,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next v4 1/3] net: sched: cls_api: add skip_sw counter
Date: Mon, 25 Mar 2024 20:47:34 +0000
Message-ID: <20240325204740.1393349-2-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325204740.1393349-1-ast@fiberby.net>
References: <20240325204740.1393349-1-ast@fiberby.net>
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
index cefe0c4bdae3..120a4ca6ec9b 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -471,6 +471,7 @@ struct tcf_block {
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


