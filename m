Return-Path: <linux-kernel+bounces-154266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEC48ADA12
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132D928176E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A678915F31D;
	Mon, 22 Apr 2024 23:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGY8g8UB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E335215EFCB;
	Mon, 22 Apr 2024 23:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830179; cv=none; b=fRky5fXgjp1zNg3Kb1gjrPZjFlt8xJXphsNRV3Ueu6tIFirN/RN2pegXirOrhPZSgyBeh84b1Piuu0Llx4nCu4Jee/9A33gM5nFfMAVQGHfGMo3grftSw2b2ONc5+c7npC6AIJlqBXykAOmxNizNoNATUZj1cJqd0u5qNZz5hEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830179; c=relaxed/simple;
	bh=PxHB1mGEVMBptErtg7/qLYILTuvu0iatnLxuz1OJ0Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtLHYRtEPFjBI5CLwfl5NwM7WeZdBX++U/XkwGvEYx6cIe21pJ+KoD5AkU8hnrUasDp/uPVGJhDtdrxm5MmjI0GJ/g5dNhayzg6PrK+dgh6EXYUwR5ihpYUdXh13ON8MGyNItP06jM4zaqAV8nAvn2tgJOy5Zl8Y7b5qvNJvqck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGY8g8UB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9289C2BD11;
	Mon, 22 Apr 2024 23:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830178;
	bh=PxHB1mGEVMBptErtg7/qLYILTuvu0iatnLxuz1OJ0Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fGY8g8UBj9BfPpAFk7kR3ijp/VtbfvCmMAqcEyzZ3zZDxjR3X6/rgdCLiajiJcz65
	 nQp7q095eRVKAfAICmc1RIUg++7WBV3UZMW+GbS6QZSiaal3FxrtHhI2fZeKC6dqKE
	 RVFBNgqN2WHtzrcRQLa/031RHkfavVfgzor0nO+eO+BIVEQrOalSNHGmId53ra2WIt
	 GRPa6Aso1yfHW87c8T3UDYt79HeC2pQvUOi/7O8Qp4OWcXYCZ929WuyB7cVtRXD2em
	 gqoT6/cKJ7+xp5iSWSi8u8JD5Ngf3DXzAmS55JmM23H3qhpF5q4H2A3pHnC3xpHZSD
	 chbfgdclUQEQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/29] tools/power turbostat: Fix warning upon failed /dev/cpu_dma_latency read
Date: Mon, 22 Apr 2024 19:16:46 -0400
Message-ID: <20240422231730.1601976-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231730.1601976-1-sashal@kernel.org>
References: <20240422231730.1601976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
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
index 4dfeda4870f71..0561362301c53 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5479,7 +5479,8 @@ void print_dev_latency(void)
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		warnx("capget(CAP_SYS_ADMIN) failed, try \"# setcap cap_sys_admin=ep %s\"", progname);
+		if (debug)
+			warnx("Read %s failed", path);
 		return;
 	}
 
-- 
2.43.0


