Return-Path: <linux-kernel+bounces-114257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C38F2888970
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D941F2FD29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC7B259983;
	Sun, 24 Mar 2024 23:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCRdg7Oy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2AC14884F;
	Sun, 24 Mar 2024 23:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321610; cv=none; b=esRq6yYMX0HluopLlDhWckRPcYYmLp7ySH7Ff9lqMTfk/y9J0IJLbpog4an7S9xH99mma/ulsOfsWDAq18/rcSvdJOh7JJXIZyTgyVJjAseSUm8IReYwXIqUIwqfWjbE7gYlbhaf/2U9KXfRqCyEyyOyQCzykyB8Hgnm0Q9Jhhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321610; c=relaxed/simple;
	bh=W2AvlN3/e6oPQY6FDGVLyCBTM427dEQ9vt1/kJm6QD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUkkrTbCMVbGgDXcO2f0z1xsaLEkeCLctjP8OLvVi9nkFD3nwp2Y751Bv7yNhY+ohsAxBRVNxGt5pQZWMRQTqT6FgmaMA3vjEscnohtVUyDsTzXnupFsHKtZND7cN7van5bwzmb11QVmBRfOfWnppHvN3qRQB5vr5aIQmsFGR58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCRdg7Oy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04B9C433F1;
	Sun, 24 Mar 2024 23:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321609;
	bh=W2AvlN3/e6oPQY6FDGVLyCBTM427dEQ9vt1/kJm6QD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QCRdg7OySexwj+BjkwAbDHqy7mDBSvaifvPdyY+N7/Vs3n/4kG4rFpjiXHkHQM4ip
	 of7SrqUoyPFcmmQxFIVqWyTUYIbF7HULTXZruxwwuVRnuOgLh9h7ItQ4bY7KSTFhUS
	 221BC/Pt/10E1vzeu1pe4fVLEybcEuySUt1NxE14h0VopAnDjV3+iIl0A3Hky+n+VC
	 I62jFT0yMHmiy8k/zh1XyQYqViTD36GG98iHUHRGNjDrgZ92tUjvjaoYA3LJKg8Xsi
	 q8C+BDoFqa/Z9VsSr42s5wUxFRRBkrX41+/SD0Kb2NvDn2ghW89h9GU5NJ268wJtMx
	 j82ymfgLwZJBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 339/638] nfp: flower: handle acti_netdevs allocation failure
Date: Sun, 24 Mar 2024 18:56:16 -0400
Message-ID: <20240324230116.1348576-340-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 88d6d992e7d07..86db8e8141407 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
@@ -338,6 +338,11 @@ static void nfp_fl_lag_do_work(struct work_struct *work)
 
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


