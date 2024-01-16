Return-Path: <linux-kernel+bounces-28009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EE082F902
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F611F2628E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7D95C20F;
	Tue, 16 Jan 2024 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLxoNuvH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995F413D510;
	Tue, 16 Jan 2024 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434828; cv=none; b=PQajbYUZInNJALh/lzZfKaEylK8vXgE/wJ3sbcxjPP8xV2RbkXfo3ez4d595qwqYxT0f9xYHp4gzKArwtCr5EAYTEJj+Mi0k6Y3M90Tt8vTA8hSuY2rkGy+rl5wXAnFZ44krVmzKvHxdq3dllgSIAGmRewrcWZx+JqIQoSISlPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434828; c=relaxed/simple;
	bh=mcZomUmBofZwrv5P/gxQDWjBxvcbEOUulhgq96eGZ9o=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=tJDCnsTWMDdw8fWbrKcDn5X7SmJ2ARHcsG5YIkV3O7kzfV8ExNS5AeEBzQFcRuUZmW35rXFBoPjpDMNWUX9OA/n5x+OF4KziKzzrsldlvVL/q2MsiiOSGo3+97dssyoZQG1iyaGDzjULaUKuMIMxrcYI3CJemEJxXs3aTk7CJv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLxoNuvH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C055DC43394;
	Tue, 16 Jan 2024 19:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434828;
	bh=mcZomUmBofZwrv5P/gxQDWjBxvcbEOUulhgq96eGZ9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PLxoNuvHFZLVaPYkWHRLGhhPSY8hWPuGBrurANWrqwvLE3j6FHi511G7yFnZhhxwD
	 J5kSmcFvEnXaNOzhRYEH6Oqe1jEqQrGQ3t8mRJI2+SjaX2sJ28TyaAdDrVGGA04Kg5
	 6zh65AsQrltRVXZqe4RB5Wppb/UhSFcNPDWtx3oU7+IXAi8aXvGjmJSnTcLOn+XdRs
	 hP9IW99zrKmCJiW5mboD7H67ldusCKDZtdrEKDTqt/XZ/2sw8IMgWF0ZvlYCQVmOxD
	 Gv5Zb6kKuE3EUeIbRlLv8q8+/zyCFYwNmRB7H1HKf4MbEOCwRZ4vEwnAnW5DtYzBjL
	 x0EaLiqF/8i/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wen Gu <guwen@linux.alibaba.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	jaka@linux.ibm.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 097/104] net/smc: disable SEID on non-s390 archs where virtual ISM may be used
Date: Tue, 16 Jan 2024 14:47:03 -0500
Message-ID: <20240116194908.253437-97-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Wen Gu <guwen@linux.alibaba.com>

[ Upstream commit c6b8b8eb49904018e22e4e4b1fa502e57dc747d9 ]

The system EID (SEID) is an internal EID used by SMC-D to represent the
s390 physical machine that OS is executing on. On s390 architecture, it
predefined by fixed string and part of cpuid and is enabled regardless
of whether underlay device is virtual ISM or platform firmware ISM.

However on non-s390 architectures where SMC-D can be used with virtual
ISM devices, there is no similar information to identify physical
machines, especially in virtualization scenarios. So in such cases, SEID
is forcibly disabled and the user-defined UEID will be used to represent
the communicable space.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-and-tested-by: Wenjia Zhang <wenjia@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_clc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 72f4d81a3f41..1489a8421d78 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -155,10 +155,12 @@ static int smc_clc_ueid_remove(char *ueid)
 			rc = 0;
 		}
 	}
+#if IS_ENABLED(CONFIG_S390)
 	if (!rc && !smc_clc_eid_table.ueid_cnt) {
 		smc_clc_eid_table.seid_enabled = 1;
 		rc = -EAGAIN;	/* indicate success and enabling of seid */
 	}
+#endif
 	write_unlock(&smc_clc_eid_table.lock);
 	return rc;
 }
@@ -273,22 +275,30 @@ int smc_nl_dump_seid(struct sk_buff *skb, struct netlink_callback *cb)
 
 int smc_nl_enable_seid(struct sk_buff *skb, struct genl_info *info)
 {
+#if IS_ENABLED(CONFIG_S390)
 	write_lock(&smc_clc_eid_table.lock);
 	smc_clc_eid_table.seid_enabled = 1;
 	write_unlock(&smc_clc_eid_table.lock);
 	return 0;
+#else
+	return -EOPNOTSUPP;
+#endif
 }
 
 int smc_nl_disable_seid(struct sk_buff *skb, struct genl_info *info)
 {
 	int rc = 0;
 
+#if IS_ENABLED(CONFIG_S390)
 	write_lock(&smc_clc_eid_table.lock);
 	if (!smc_clc_eid_table.ueid_cnt)
 		rc = -ENOENT;
 	else
 		smc_clc_eid_table.seid_enabled = 0;
 	write_unlock(&smc_clc_eid_table.lock);
+#else
+	rc = -EOPNOTSUPP;
+#endif
 	return rc;
 }
 
@@ -1269,7 +1279,11 @@ void __init smc_clc_init(void)
 	INIT_LIST_HEAD(&smc_clc_eid_table.list);
 	rwlock_init(&smc_clc_eid_table.lock);
 	smc_clc_eid_table.ueid_cnt = 0;
+#if IS_ENABLED(CONFIG_S390)
 	smc_clc_eid_table.seid_enabled = 1;
+#else
+	smc_clc_eid_table.seid_enabled = 0;
+#endif
 }
 
 void smc_clc_exit(void)
-- 
2.43.0


