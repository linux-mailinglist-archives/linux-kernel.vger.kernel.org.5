Return-Path: <linux-kernel+bounces-124987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42199891E86
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7420E1C2773A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACDE1AFC69;
	Fri, 29 Mar 2024 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmxkN88c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2EC1AF59B;
	Fri, 29 Mar 2024 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716572; cv=none; b=tjoIAFwo0A6ZcFnMHP+bZn3P+Y75ppU5fcjy5O9q4QGG0N+PuGKLc2+d4366KgAL1cZxH+LhB1LfmqNSLNXELPEdkvpNNjyOIDvlRQJafIrb6AxqC4d0DV0wW2seVLHol6kXxeIgRf38moatgS4lFIe7vZTJCyuV3XGrM6czw0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716572; c=relaxed/simple;
	bh=g4Gu1PSHzOaDaCAbcb9ElyUcEoTlB/JZhestihutDKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+OtJE1YGuGAzojPoKPRh9+sWGApXqfEdcU+9PBTdxRHfcsARVFxg/4wzJ2N7PobNmQjurO+8Pl01oTOtYlfiVACcvmcWakakGHrJ+/wKxo7ZqTdVaPCsd/DIqDo8hNqVy6h0/I1Dkylug+MCQo76/MUuzPeeR7UgVjY/g4GFiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmxkN88c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488D7C433C7;
	Fri, 29 Mar 2024 12:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716571;
	bh=g4Gu1PSHzOaDaCAbcb9ElyUcEoTlB/JZhestihutDKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UmxkN88cRzhEdVT+CGtFSmJPn8S59OHYiF46joxjp7hZHiqRItDjsiQsdropFtK+4
	 BVLSagjMWKO8w19oc0XICHGQDlcYr9grbOUgBJv+guQTWrMCkxQbbk0lF7wzyD76Ie
	 kH7kNdGPs2KHaYE/ehKfLVlvAkrZqGeWxp86Uh/jz5DipJjCJZ2D5n/E1E4cA6jDYJ
	 9gir4zdOgZE9aa1H93irWl/bO+85MHJeijZB5O1pVWaxgdBxjrQuTSxQ2LTS6XdiCD
	 Tr6Q9mzN8qm/KTZ5ThdgaKZewHV8x01KHlmcUd8Cm8ff82CJmzr7AWsHmh6fnoABF6
	 tIqhZ9ROrkk+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 16/31] tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()
Date: Fri, 29 Mar 2024 08:48:33 -0400
Message-ID: <20240329124903.3093161-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
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


