Return-Path: <linux-kernel+bounces-124765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61177891C43
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E131F22EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9098618148F;
	Fri, 29 Mar 2024 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oo3zD6/A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD31718146D;
	Fri, 29 Mar 2024 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716104; cv=none; b=k6f4IVo79SAl30FJywv2ArHYYxgWqb0GuMcNRqEl47LKubBWuK6pyWk/TK8servEIvPQSKiiOptiBY7b3EPJpodsyoqkWcUVMFUKwwFk5xgGPDn+uma+W2YgQGzMTtbIzBeJXcUe59ktEsRteTOQ7QW4fQSEliMVtLxb3eHvLgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716104; c=relaxed/simple;
	bh=Kdyszlwq5JIK92eTlec4mtX/vVJlwIS0I5GaYJWP4a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5E3saSDW6vp8oXno4ONohqMeTcRFcbJJnCB0AuGFD96B87k3249jXMQnisiYhBS043UfRXCqgZLVsiEbI7Jg6FiEPOWV5sEJE/a5Xk2J651GEF0QLy43QlQ+TUto+BVE8ENF5RHJMurDFIwgrx0rIwlTxbQGyW4t+LpjCTnsOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oo3zD6/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D299C43390;
	Fri, 29 Mar 2024 12:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716104;
	bh=Kdyszlwq5JIK92eTlec4mtX/vVJlwIS0I5GaYJWP4a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oo3zD6/AEdSYxrlsBHpgRDceozMlGLQtcRC1qM5MG3zupbgsbpTh8pNVP2YexAv3g
	 uKTUogzk/LI4jtOmthdaSk8Y3EpfkDn6aQEc16TfDDFvcQ0KB50Lw6mfMThgnWvDD6
	 XqCBYbGs6XoPrGpc86SW504K0wt+432byGoucf0k8Ej+h80dXsIWMvAE4fzPrz3eZ5
	 CS81X5BaDtPr6EMcF/KKAVUfY4ttQNIYfLzm1RxDKlurpR9SLO9BzEg+euE2apGIP8
	 mnlKH07jqboFtRwm5IfWYMjmXxBfC+JfismmTCCCNc41RtP9dLDzyiLGcSzUL6O7OA
	 Vcv/4yx3ghMjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.8 56/98] tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()
Date: Fri, 29 Mar 2024 08:37:27 -0400
Message-ID: <20240329123919.3087149-56-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index 5fd9e594079cf..ebda9c366b2ba 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -1241,6 +1241,7 @@ unsigned int get_pkg_num(int cpu)
 	retval = fscanf(fp, "%d\n", &pkg);
 	if (retval != 1)
 		errx(1, "%s: failed to parse", pathname);
+	fclose(fp);
 	return pkg;
 }
 
-- 
2.43.0


