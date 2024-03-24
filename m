Return-Path: <linux-kernel+bounces-114950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C178892BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3DE51F2F1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAE51BEDD5;
	Mon, 25 Mar 2024 00:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLrUItxU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9564A179FCF;
	Sun, 24 Mar 2024 23:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323665; cv=none; b=tVYOna4ldydOQBhTgHaoaf9z4lQvXZliUt67X0JxZtNbaYhVW3eAMTXa8Rc8pkDTh8eGa/54JHF6cE1GOzCr3VLkv22bQ9crYwqO5Th0A2uIS/t7rxl5SmC3kFleQd1T/z/agoYnJSDVerRJ2j6Ayj8bD4oFOdf53BcJjSqPF1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323665; c=relaxed/simple;
	bh=r5p49GZRFmtuKgVaabBtNqYpK5s4aOtan8S6DcAYzIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1QbYXgR05cNzEDZBSwFrE4MvJydu/zyfz6ZBlUH1X+oFDT0qj3tmg+2b2+jycYVhwb+qqAUcUSQ/kOSYLQacr55BnxVw56dhjpdC2eDrUpJQez4FKS5hMIxQfmqKjmL+hOSC5OOTMzIOR56xjTw/95Jw2yRa6oqussZjTGm7Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLrUItxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE92C433F1;
	Sun, 24 Mar 2024 23:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323664;
	bh=r5p49GZRFmtuKgVaabBtNqYpK5s4aOtan8S6DcAYzIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uLrUItxUMo2C8kbAaL1jlnYCyupJ6CMqnHgjG1Zrxg07gRtCLRHTgVaoxGgGyZsZl
	 dVDZAWuyhLXgpPkNpre8FsY58mE4KMTt8lRLyeoOlkHT/YEux1wP+B+aCxC5O+AHNp
	 NLHwxI7+cpsJrZgJS6ZpY/rLzrxrgBvEOtBhuavQvBvyGDn+hv/rF88ejXxYotMydE
	 5iSSXOLJaXwdhRrMEGKfhqP1yK/5JVn5qG0NDZXnaKEzHd11JDGbvDmpNPS4kVJPB4
	 aXYBfg4p6iFpY+MUp2FdAQPhkg7tOrprl2GXfZwKEmQNfBTjYGFWtpJgQ0f9w2gCSp
	 GyBmhl6w/IqjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 036/238] timekeeping: Fix cross-timestamp interpolation on counter wrap
Date: Sun, 24 Mar 2024 19:37:04 -0400
Message-ID: <20240324234027.1354210-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Peter Hilber <peter.hilber@opensynergy.com>

[ Upstream commit 84dccadd3e2a3f1a373826ad71e5ced5e76b0c00 ]

cycle_between() decides whether get_device_system_crosststamp() will
interpolate for older counter readings.

cycle_between() yields wrong results for a counter wrap-around where after
< before < test, and for the case after < test < before.

Fix the comparison logic.

Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supporting slower devices")
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/r/20231218073849.35294-2-peter.hilber@opensynergy.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d9b48f7a35e0d..6a8a610b19717 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1173,7 +1173,7 @@ static bool cycle_between(u64 before, u64 test, u64 after)
 {
 	if (test > before && test < after)
 		return true;
-	if (test < before && before > after)
+	if (before > after && (test > before || test < after))
 		return true;
 	return false;
 }
-- 
2.43.0


