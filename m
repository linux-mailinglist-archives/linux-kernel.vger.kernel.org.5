Return-Path: <linux-kernel+bounces-114827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECDC889262
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AFB1C2E0CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E282C1D60;
	Mon, 25 Mar 2024 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bja/JeR1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA8127899C;
	Sun, 24 Mar 2024 23:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323451; cv=none; b=I0wzEoQZ2k5qYQEUMbbCfmoGxzepb7knj0MnX1I5eDsH6E1ijzQ6QkldiYn6YwFiw7bxkJh0XtInojmO5ABibYREPdz1Im9HTXIYGTANR15PvXVb5EZVOfursnzfayo3r4EjUAiPV1+ecMfAuyGJIFaEI5wVJteDbcBpUe2vT9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323451; c=relaxed/simple;
	bh=ir/H48WBd9iJTs/xTH8Oz5/Qn+uxWcc9t3DZeEZ5L6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOUcU6aAv5fu35Htx4s/2xByFyzl6auaAEEFafRZUjl0u+qEDfFfNTZeiK1ALnNidclMzpl2W3M1TwT1js0qN8V5z+UtM95MXQFaSJxvLZ1mHE+LezPOx5RRRtNEgsR6axq2ABEOchpI6Zg8vRERCw2X0v9jXN3Ix2A0yzKDvCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bja/JeR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74547C43390;
	Sun, 24 Mar 2024 23:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323450;
	bh=ir/H48WBd9iJTs/xTH8Oz5/Qn+uxWcc9t3DZeEZ5L6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bja/JeR1mX9mc0OLtcqk7sM7qTNty+lGyyNRg+Bhvs4AKAG+QNzAl9rqGS+ONZWw0
	 WUuLEUKAMkC6Rp3PgXJro/dzPc/Z9b7KytVgsLVW3u+ik6HvrnQBE4ZyaDA7enlNzN
	 vZiJWMJuBe62z3tMHwhIZECp2qgpwihx2OvnzmN5deuIi/dLXOIEi6K691qJS7Mr/K
	 t4r5iSyNRQ8Lne5NMFMicg2LMJo1gZSrkIy9udzUohYYGOOW289DY7qHzxDWqd5xBv
	 WbyYNlHkV1PaIHUduuGvkII03RFiiiPxDiyOjStucMhpLA7S0tlB/MuLVg0b8QWyAb
	 y5VWvHI8H86uw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 153/317] nfp: flower: handle acti_netdevs allocation failure
Date: Sun, 24 Mar 2024 19:32:13 -0400
Message-ID: <20240324233458.1352854-154-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit 84e95149bd341705f0eca6a7fcb955c548805002 ]

The kmalloc_array() in nfp_fl_lag_do_work() will return null, if
the physical memory has run out. As a result, if we dereference
the acti_netdevs, the null pointer dereference bugs will happen.

This patch adds a check to judge whether allocation failure occurs.
If it happens, the delayed work will be rescheduled and try again.

Fixes: bb9a8d031140 ("nfp: flower: monitor and offload LAG groups")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Reviewed-by: Louis Peens <louis.peens@corigine.com>
Link: https://lore.kernel.org/r/20240308142540.9674-1-duoming@zju.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/netronome/nfp/flower/lag_conf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
index 63907aeb3884e..3167f9675ae0f 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
@@ -308,6 +308,11 @@ static void nfp_fl_lag_do_work(struct work_struct *work)
 
 		acti_netdevs = kmalloc_array(entry->slave_cnt,
 					     sizeof(*acti_netdevs), GFP_KERNEL);
+		if (!acti_netdevs) {
+			schedule_delayed_work(&lag->work,
+					      NFP_FL_LAG_DELAY);
+			continue;
+		}
 
 		/* Include sanity check in the loop. It may be that a bond has
 		 * changed between processing the last notification and the
-- 
2.43.0


