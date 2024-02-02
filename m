Return-Path: <linux-kernel+bounces-50473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC86884798C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4751C25747
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ED415E5BA;
	Fri,  2 Feb 2024 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWWnRyOf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB85A15E5A0;
	Fri,  2 Feb 2024 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706901601; cv=none; b=ipf2KbB9XuNA1d0d7qefM/AGjwwJv16/UAL5rpwE9IxYWfxlqAm1MNn5FcA7x7Y6LwPTIy3eTowqFGXFHLE+TYhRJtu6WFdTnH5BVcyS2iO24t4FBvbYCy1dFtwjRiYmDz2WicbvVHUeB8vaa2AOIXG0BUjfPaouU0igiY1Y0Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706901601; c=relaxed/simple;
	bh=CbXReCX3ZlwbbZZ2LtMRe+PpRclG31Ljw0m0O0lK4fo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oe0HPkht0TCMdpkHMpWI27bQfSalwAd2CB6cmjKOksRTAW/K1iNnXmNsrMWhXHWS61S0x/dGR3EKlSh6+Xqdd+l0Qh6j+gMy8ftG6nKKpctPlK/aCNFK/EbOYPCYVASrkc4zp0nkrnx0FIq66M4zlLEXPK/51YDwhkv7HLeBJjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWWnRyOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E5EC433F1;
	Fri,  2 Feb 2024 19:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706901600;
	bh=CbXReCX3ZlwbbZZ2LtMRe+PpRclG31Ljw0m0O0lK4fo=;
	h=From:To:Cc:Subject:Date:From;
	b=fWWnRyOfm4mJOX4/eZm+IhaEuLd1JuKdV+JW9Cqe8Z9GKZLpYjLR+5gi8kaWErJYW
	 3K2uTX+OuwDimwPLsJKDLMCcYTyK/9WaPRneECK2oHFpiWGS/psfiQHarTduW11vtq
	 NJcFDB8Uird8U3HpiEpeO5H6m/aTS3hYKe5RoB4a9jLR2IBN27hS+e7QbL6zt8twBD
	 Sxh2/kDFpF9026EJNrEwzxCygItSwYJ46LVz+a3FXjBJeloGejiKvT3ELuY3LSEfoZ
	 VRqeGWicI+QLrMmr76xm0QYXyNbPgmJP8NmrhBMeJkFpZnhdPdnkahKMIR3hcQOn+b
	 vAsjtwJfaQG3A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH ] mm/damon/sysfs-schemes: fix wrong DAMOS tried regions update timeout setup
Date: Fri,  2 Feb 2024 11:19:56 -0800
Message-Id: <20240202191956.88791-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface's update_schemes_tried_regions command has a
timeout of two apply intervals of the DAMOS scheme.  Having zero value
DAMOS scheme apply interval means it will use the aggregation interval
as the value.  However, the timeout setup logic is mistakenly using the
sampling interval insted of the aggregartion interval for the case.
This could cause earlier-than-expected timeout of the command.  Fix it.

Fixes: 7d6fa31a2fd7 ("mm/damon/sysfs-schemes: add timeout for update_schemes_tried_regions")
Cc: <stable@vger.kernel.org> # 6.7.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---

 mm/damon/sysfs-schemes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 8dbaac6e5c2d..dd2fb5127009 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2194,7 +2194,7 @@ static void damos_tried_regions_init_upd_status(
 		sysfs_regions->upd_timeout_jiffies = jiffies +
 			2 * usecs_to_jiffies(scheme->apply_interval_us ?
 					scheme->apply_interval_us :
-					ctx->attrs.sample_interval);
+					ctx->attrs.aggr_interval);
 	}
 }
 
-- 
2.39.2


