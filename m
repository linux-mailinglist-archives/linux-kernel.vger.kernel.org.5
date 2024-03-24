Return-Path: <linux-kernel+bounces-113802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C61B0888E94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E029289F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98D31FA823;
	Sun, 24 Mar 2024 23:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHmgPZH7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85080146D79;
	Sun, 24 Mar 2024 22:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320821; cv=none; b=i+AKbdL+qwmkio6Jmcx5M3ZVCr8w+3K/EPT+CQKbt8NIN2vvq47Flfs2EWB9lSv04M3rbYR1M8LN5nZt4yVx/Ewut7lbzcz3BQY5k+76EdHaput8DKNvOiQEoAWD3Wnz5xvpkjHYpwfape18NXqgT2200aM3aOcTcB2yVnu5v58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320821; c=relaxed/simple;
	bh=W2AvlN3/e6oPQY6FDGVLyCBTM427dEQ9vt1/kJm6QD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmMdQwbigaqc1zAtGydZOZJo3MHsXvGLx1L4BjvvlcbCcC5PiXURfEZVF2c6v7GjInkgTVTyITF1z96KRH+Yge9PydFGfvmkESy7/BPF7huG7GE/YTR6aZjCMmp6TAwGryn5KWpv/hgzJVEwfFAlsTKIGhtmsSX83S0KsE9NAX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHmgPZH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4C5C433B1;
	Sun, 24 Mar 2024 22:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320820;
	bh=W2AvlN3/e6oPQY6FDGVLyCBTM427dEQ9vt1/kJm6QD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WHmgPZH7HDBeVhuDoeL+07wLaziVv3N9cBTj3B+k4W8XolQYNt2CVjXk00F0UaGA5
	 NO2+Cy+PU34G0LX5Eu2FjzQiCtJyS6nQa3V135SSb1erw74kwbxL97MSWA2QhyfiNB
	 ioh1vwSyGt2R5KndoIvDXAcZPPzMVHjPag/n8fjtHMkJ+nT1lItNjuMR8NdBuSJpQJ
	 Q8Xl2q7nJeFEeLEHA448ag5nUyH60izrHOYl6GUHoktb4EhZXgQ65I0nQA/N3XsvmS
	 MlfAgPTjtbM2pjeR93Mb0hxeVaA+5LWokYXzkUQvP1Bz3GkkercMqJ001Adu2S7b4G
	 jRhTmGIBvXFHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 385/713] nfp: flower: handle acti_netdevs allocation failure
Date: Sun, 24 Mar 2024 18:41:51 -0400
Message-ID: <20240324224720.1345309-386-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


