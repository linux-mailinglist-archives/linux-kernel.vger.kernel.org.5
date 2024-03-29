Return-Path: <linux-kernel+bounces-125034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFDD891EFF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EBD71C2875F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E561BE61B;
	Fri, 29 Mar 2024 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKAJnW+Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0271BE60D;
	Fri, 29 Mar 2024 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716679; cv=none; b=XAzoOd6kqILAh+etVLI/TVFd5tlESTCSM+VlzE4zfLUBwWPZcjnh5AYeeAXtE5yxES//LyWliK67vnZlp5AEfPMHk3aOWYfFT6pReYwQ11rYVslF2UobdMmUtMQU5tKwgQo7t8ksMMu3/32ed/uKSAQEJ0TixEfe13SYw5/upLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716679; c=relaxed/simple;
	bh=+uHwfZ62RMXerS0nEStQgHY8Yp6ppGe+Mm9EyPS2VnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geGse+DScjrWOb1hbPfnAncfV90N2XpaWiXUhZgqiWcIXl3ewncnDOPFE9+7NYCuAFfLZdAufh0MV8QGfflF1KnoMc0q4tUCUKMZ+zOvuq9f8IdzjoLYce5wBsR9t77psnS7YUJIWTr41MxZsg6iWkrc3s1GNny79oV3acL4DcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKAJnW+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41561C43390;
	Fri, 29 Mar 2024 12:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716678;
	bh=+uHwfZ62RMXerS0nEStQgHY8Yp6ppGe+Mm9EyPS2VnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kKAJnW+ZGpwYfEw/2+7oT1ldNpYyAzraW7c+JX3D5BW/VqO+j3Y/b/GmedbzWaQSQ
	 lSbsDO7o8O6t4vjmkqyhQ3NiCthiTW2GTmdfp4F57wnmJB/XFnIRYb94d10CCEy/o8
	 6A32wz8F+gxR3TUefzFmIaCeQQ5t2UerhyKMczNO3/3YaOVgsdJ8CN5KiBOZPyyBE8
	 2yiMSBji2pZd7RnqmI92i15eZlPhVCq+0LCjdvbdTl9WYfe5vJ9jetq2Z3kDjAdN/w
	 QPzKH9gOqbDT5WIXBG6XMtq0SVCdrC0E64M4R0M2wVW+JzMGy+c4fsaUNALVlYygd0
	 CribMm6p6qAzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 09/19] tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()
Date: Fri, 29 Mar 2024 08:50:41 -0400
Message-ID: <20240329125100.3094358-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125100.3094358-1-sashal@kernel.org>
References: <20240329125100.3094358-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
Content-Transfer-Encoding: 8bit

From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>

[ Upstream commit f85450f134f0b4ca7e042dc3dc89155656a2299d ]

In function get_pkg_num() if fopen_or_die() succeeds it returns a file
pointer to be used. But fclose() is never called before returning from
the function.

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 2aba622d1c5aa..470d03e143422 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -1112,6 +1112,7 @@ unsigned int get_pkg_num(int cpu)
 	retval = fscanf(fp, "%d\n", &pkg);
 	if (retval != 1)
 		errx(1, "%s: failed to parse", pathname);
+	fclose(fp);
 	return pkg;
 }
 
-- 
2.43.0


