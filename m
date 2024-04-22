Return-Path: <linux-kernel+bounces-154224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20DF8AD98F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 510EEB256BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9C64654D;
	Mon, 22 Apr 2024 23:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s43yrgOp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C481553A3;
	Mon, 22 Apr 2024 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830052; cv=none; b=TEXqGGNjV5C1YWDqqi2qIA5sLB1ZbBzx2uTZ/qmyRqbPGDqeLQNdPxOD14X0hhxFqKIVZ+8bTEtoIEZS5zfVyR+MfrqzlejiHALmlcdiY5+6iz2w5MxqHqzSN7RHhHKeIdsxVdpBqMEkyO2x5eKZ4ec4hIicWdaiRdz377DLp+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830052; c=relaxed/simple;
	bh=gXgp2lGvFKHntFiLrPuMEcMIb0avW1xA5azjw0DeRrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOfPxAJSE0OSGBccR2XYqp2uHGiBXdtmqo4jhNRDC1ihuUHazf2JZLbS3Y51ozbj2nNjzMNPA3Ure3lUqlsXcA8P8UdyUVNUNSnkzZUTcek3bcBnR/2FN0jkb24q2nyX9f5pbIIDz+Yw9UPj9XWBWwhN9vC9s6I2AlqjwZR2JuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s43yrgOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369F5C2BD11;
	Mon, 22 Apr 2024 23:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830051;
	bh=gXgp2lGvFKHntFiLrPuMEcMIb0avW1xA5azjw0DeRrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s43yrgOpgMTRYdxzvPUdOL/PBFrnYKnhW3HkV6W9cAL02w8JDYJtffCU9tr+gUHIP
	 7uJNF1YIm3zBTfjrdSQ3RZnUTJW/uNo1+QXIMB5FNczlgdOTXJfwXgfkbAwVNnUOqk
	 90o7yZcQb7oiiZc8uC2omg8BAfE+/M8Mx0xURt9QQBbrfS1KeclAKjrpyyyla2kqLr
	 V9qFjmnLDO8eZigU1vi4XWXL/eKQrBs0oE38SpVeqNkfmEmf9xVoRDNmSTft9+sCcS
	 CSuQiFvbvc5QYsCF+h8dT0lGMQNWRJuQT8xUFxpXzaT63I+SkuHG/XrO28BTaqTNX4
	 mhs9nDofHMHQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 07/43] tools/power turbostat: Fix warning upon failed /dev/cpu_dma_latency read
Date: Mon, 22 Apr 2024 19:13:53 -0400
Message-ID: <20240422231521.1592991-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

[ Upstream commit b6fe938317eed58e8c687bd5965a956e15fb5828 ]

Previously a failed read of /dev/cpu_dma_latency erroneously complained
turbostat: capget(CAP_SYS_ADMIN) failed, try "# setcap cap_sys_admin=ep ./turbostat

This went unnoticed because this file is typically visible to root,
and turbostat was typically run as root.

Going forward, when a non-root user can run turbostat...
Complain about failed read access to this file only if --debug is used.

Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a4a40a6e1b957..3438ad938d7e4 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5545,7 +5545,8 @@ void print_dev_latency(void)
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		warnx("capget(CAP_SYS_ADMIN) failed, try \"# setcap cap_sys_admin=ep %s\"", progname);
+		if (debug)
+			warnx("Read %s failed", path);
 		return;
 	}
 
-- 
2.43.0


