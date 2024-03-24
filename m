Return-Path: <linux-kernel+bounces-113538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07577888521
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F50285530
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941E91C1311;
	Sun, 24 Mar 2024 22:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDYz5rOg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E5E1C09DA;
	Sun, 24 Mar 2024 22:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320339; cv=none; b=mJ0okVEBEIHjyeK0IAv3MpBO8p8JAUE92blPCeejU3/VozIU9nYJVMnroKz+lAt5ne94RFWrqgWKjNk2YmNMZg4iumAqJRHHL97R9wIPR4lC2uBWI+fCNJCo2rRrTAT5I/Rd9Ru7xXLwKNxJOSv6HridxB4mXIzH/L1e/5YxOtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320339; c=relaxed/simple;
	bh=pIMAx/5guFWCXZz7a5DmmTIE8rbWEEKno25pg9I15Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSytQ3G4MAO+Cr8ptaFRbXkbpAqzJo2HucU4g5ZUEcKt/zC2BFA4WDXmj4zi6yuYEeQIPoAQqP8yYuwhELOGKVWHbV/soMdsuD5vPoXzmwZniVdQBHOUUbRl2xky5dazTMKwtlxjdwVlne0p6f4L/lkAvsaf7NAEEVuYWwbICBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDYz5rOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E770BC433C7;
	Sun, 24 Mar 2024 22:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320339;
	bh=pIMAx/5guFWCXZz7a5DmmTIE8rbWEEKno25pg9I15Mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EDYz5rOgpHanP2McQkJP9Z4irqkvzMSwQreX12c+B3TL8fmyKnsEHUFLhcPoV5QfC
	 XpA/gLI9eyaPKz/2F+P/oooZCLGOg1/7Jg/RFqi5c41POOdpqJnEGRCAVyM/fkJNq+
	 baLa1EnezaokxVUAzoUw+z3NwaI7nHR6P6yTSdJawUyaNqqTPvnhrhGrHWuuzlLRvf
	 dfb664NgRHEgWq/3Wm7yA9AOUy4aaYU4qtmOANKSXjR0n+fF4+qYTh1kar+3nsY0Hl
	 mwCMwyN8d+M4mp7S/Eq0itrcTdm2gqeGmekWrlIB1cMHAM55azjF6UcFpzbjp67rPG
	 iJdy8tlc7KpQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mete Durlu <meted@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 647/715] s390/vtime: fix average steal time calculation
Date: Sun, 24 Mar 2024 18:33:46 -0400
Message-ID: <20240324223455.1342824-648-sashal@kernel.org>
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

From: Mete Durlu <meted@linux.ibm.com>

[ Upstream commit 367c50f78451d3bd7ad70bc5c89f9ba6dec46ca9 ]

Current average steal timer calculation produces volatile and inflated
values. The only user of this value is KVM so far and it uses that to
decide whether or not to yield the vCPU which is seeing steal time.
KVM compares average steal timer to a threshold and if the threshold
is past then it does not allow CPU polling and yields it to host, else
it keeps the CPU by polling.
Since KVM's steal time threshold is very low by default (%10) it most
likely is not effected much by the bloated average steal timer values
because the operating region is pretty small. However there might be
new users in the future who might rely on this number. Fix average
steal timer calculation by changing the formula from:

	avg_steal_timer = avg_steal_timer / 2 + steal_timer;

to the following:

	avg_steal_timer = (avg_steal_timer + steal_timer) / 2;

This ensures that avg_steal_timer is actually a naive average of steal
timer values. It now closely follows steal timer values but of course
in a smoother manner.

Fixes: 152e9b8676c6 ("s390/vtime: steal time exponential moving average")
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/vtime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index e0a88dcaf5cb7..24a18e5ef6e8e 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -210,13 +210,13 @@ void vtime_flush(struct task_struct *tsk)
 		virt_timer_expire();
 
 	steal = S390_lowcore.steal_timer;
-	avg_steal = S390_lowcore.avg_steal_timer / 2;
+	avg_steal = S390_lowcore.avg_steal_timer;
 	if ((s64) steal > 0) {
 		S390_lowcore.steal_timer = 0;
 		account_steal_time(cputime_to_nsecs(steal));
 		avg_steal += steal;
 	}
-	S390_lowcore.avg_steal_timer = avg_steal;
+	S390_lowcore.avg_steal_timer = avg_steal / 2;
 }
 
 static u64 vtime_delta(void)
-- 
2.43.0


