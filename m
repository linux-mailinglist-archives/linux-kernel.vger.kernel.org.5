Return-Path: <linux-kernel+bounces-112936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE43887FE2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E567F1F227CD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC908763EA;
	Sun, 24 Mar 2024 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edZeNxu4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A3B76047;
	Sun, 24 Mar 2024 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319749; cv=none; b=BBOPJqP+qSiBUHRdKWrrzRb5fbPmW6ezT9dIPf+Xarjm5UfbS9edNQcnDmO5kpQKfDgeNoJJw5KKAWz8Ky279B8L7cahQk1YaDL1Xh3BooBR6BsKux2kHc1bMkQbkmS3uJRShkBmKzcWjUwuDaTr3+PlMJzefk3gs+fJNOFkVaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319749; c=relaxed/simple;
	bh=23eHHuh/DV2k7PZWl6XBVkeG9jJGgENpTKhIC6FWxGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXbTpexkdCUVb+p9NXYjFZfKzZNnSLqSfUMHvECJAD56X/lpIkU53MLZ4EbUmP2gpYeEqwhclNHCrOmhrwyZ9TVw8kr+uOBU0qJVLdLcJteQ2nDSbEoIKbUpkJAn3Hj2GbnEvQdRtpOuJOl2y/bX1aaCQ5ZtCBBDhpuOFT3p1JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edZeNxu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDABC433A6;
	Sun, 24 Mar 2024 22:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319748;
	bh=23eHHuh/DV2k7PZWl6XBVkeG9jJGgENpTKhIC6FWxGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=edZeNxu4CtDTK4WDuqSmv4BXYpV61gz1g+gImkcOAEYZWMFflOnOgHq9r+g7cq4aA
	 FV/PRrQc3gQ/fWhY9hoi7ce9BfvJU5BLbUBPVY1EjY69dQLi138BfMH8gdoBqZzuz4
	 PfwXdxsTCujl/jAlIoWniO2qniyr3vVl0LGI6SGHxeTUe1Vuz61IvLPb/ekANbhSf/
	 Xrc357bhJw/HrJGkpA7DXa9EK06tF8wxujJXQmgeTmpCxKMA4Ogk4UtDz7jbhp3grH
	 2M/hFYxM5rotqzJYpSKyJU8jkY1mzKGLNEF8Bbgxm0QzjJmasDiu03vkPa4snTc1aB
	 CuQN8JB973TtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 049/715] timekeeping: Fix cross-timestamp interpolation on counter wrap
Date: Sun, 24 Mar 2024 18:23:48 -0400
Message-ID: <20240324223455.1342824-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 266d02809dbb1..8f35455b62509 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1186,7 +1186,7 @@ static bool cycle_between(u64 before, u64 test, u64 after)
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


