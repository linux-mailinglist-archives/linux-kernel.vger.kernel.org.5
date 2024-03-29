Return-Path: <linux-kernel+bounces-124670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C38891B35
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51011C26430
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2595E16F8FF;
	Fri, 29 Mar 2024 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZ+JE5zz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E1116F8ED;
	Fri, 29 Mar 2024 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715665; cv=none; b=j4GwuQdshP1/+cwvPoTeWopS7Hq1fbHUa+54Z5z36f1h6nZd9k+R/Yk7SA2p5wI3UIendfVB0SWQSBTTM1rm8/ua197NA7LL5zPttJ81sfWl+RVyXinodXF2c4pLFzxOWtsikiGSy3zaY8CfXVKesS6vLbLijhaPqxybjo8kIY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715665; c=relaxed/simple;
	bh=g4Gu1PSHzOaDaCAbcb9ElyUcEoTlB/JZhestihutDKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1DnHMwv3lxjC/C9ak2ug+gfWY8TE9D7wDpqYSqjVINHY+zTLc9yKPV57ydHLefg4hNlf7E5Nf95Fs1Kx/qhBRigLSgIvI1obaTX3a5PvFOyEQb4j/sSrT3NWTpyVh1tS2jI5wp6TF7S9zk+z82pF13jUFjwBdqz0fCp3fRsI/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZ+JE5zz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531E0C43394;
	Fri, 29 Mar 2024 12:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715664;
	bh=g4Gu1PSHzOaDaCAbcb9ElyUcEoTlB/JZhestihutDKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SZ+JE5zzZoUrx6pk1O2DL96+ClAJMTv2pJ7a2M1/gFnyiaBbU7CN4bxQW6G34s6eE
	 TRoLh8lg417/ZYn0ssk2DB6P5RGHJNcwicUxNLC8FL8iHc1/ooTRE//BJnfNrxaM9v
	 CullOD6AdKbzDLQdj0IwJULWFsHQOxcvMPRhON0pMGVzWzN8TyZywjha65AgWjPZ1j
	 qL6liJdqPymcYA/iDAA/6dAEJaFRxNdAI2c4xuz3ttjfuPMqYdRqttxYZIEiNrgesi
	 Z3YzsTRX9qbq0pq5s6LHV8Tzo59RvKiCRXCQnfU8Msr3C4cppA4jQ1TbcR1MGRwsWl
	 trk7nES48Ob7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 10/17] tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()
Date: Fri, 29 Mar 2024 08:33:49 -0400
Message-ID: <20240329123405.3086155-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123405.3086155-1-sashal@kernel.org>
References: <20240329123405.3086155-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index ff6c6661f075f..1c80aa498d543 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -1152,6 +1152,7 @@ unsigned int get_pkg_num(int cpu)
 	retval = fscanf(fp, "%d\n", &pkg);
 	if (retval != 1)
 		errx(1, "%s: failed to parse", pathname);
+	fclose(fp);
 	return pkg;
 }
 
-- 
2.43.0


