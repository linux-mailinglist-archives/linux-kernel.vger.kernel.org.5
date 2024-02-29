Return-Path: <linux-kernel+bounces-87020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A56986CE52
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3E11C2187E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CA615C7B7;
	Thu, 29 Feb 2024 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOgOSQ20"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75915C7A9;
	Thu, 29 Feb 2024 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221882; cv=none; b=RBndr4tq97upw4kcawKAX0/bnocmr6SssCw3BG/euO4eqiZaXv7Z6EY2wfMlX4DMhn/C6M00WJ2zV7r7wVAOHbCJFhW0r0ba7yQl7LXV8hlzgROieSA7H+hu6swhhA9KleNmGhplEjR10zXKrIeIwIPKdfM61jUXQ7U0C+ipGnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221882; c=relaxed/simple;
	bh=tfnOGd7pf3A5f59RWHth3GLkpWlXj5gee4oTcfvY3k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ax6w7BfcdD+KndYnXoFZrlD90R9rLxhbFVtwIYv+m/C1OijM+wK4v2R+I4rovYeCJ+aZQxS8+8Y2/SdeUlRICk4HMvo/QO58IpAncoZETj8aR6IsBCE+5v2TcwSlrTJM/ON1mqpdZmb2ekXnmw7f+5zdXQDjN9K3G2G8cJfLXR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOgOSQ20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052B4C43390;
	Thu, 29 Feb 2024 15:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221881;
	bh=tfnOGd7pf3A5f59RWHth3GLkpWlXj5gee4oTcfvY3k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bOgOSQ20yGDwcXZBG3YJZt+xnT8NnNSr8JUqWMyqJjmECLBHZNMmLKL5UH9B4jtkq
	 wzb4uX1e0wUXe6CRNj/KxHI+IA/FPPSoidZmJfYA5ON6ZtVwY6KuIMkmR1HaMhmjl4
	 bSPR+B+OY6HVJUnsKawPk4lOVjXolksZbeFB51T66d7rtTH98cqn7JdIE4UPvwmbTU
	 HpOtlbv1g6XuuIHCiKACteRuV1bR8s1gowNGByLb9Q1FMisFQgpYEH6KXX90MKQH5G
	 gtqUpbycdvoSqcjn08M/SZyYUnwbfJ1wuG9Unm2BVpBRzWSUX2fHtROc2n/N6Qk6Cf
	 wcAw7AQMHX/TQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>,
	oleg@redhat.com,
	linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 5/7] MIPS: Clear Cause.BD in instruction_pointer_set
Date: Thu, 29 Feb 2024 10:51:09 -0500
Message-ID: <20240229155112.2851155-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229155112.2851155-1-sashal@kernel.org>
References: <20240229155112.2851155-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.210
Content-Transfer-Encoding: 8bit

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

[ Upstream commit 9d6e21ddf20293b3880ae55b9d14de91c5891c59 ]

Clear Cause.BD after we use instruction_pointer_set to override
EPC.

This can prevent exception_epc check against instruction code at
new return address.
It won't be considered as "in delay slot" after epc being overridden
anyway.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/ptrace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 1e76774b36ddf..2849a9b65a055 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -60,6 +60,7 @@ static inline void instruction_pointer_set(struct pt_regs *regs,
                                            unsigned long val)
 {
 	regs->cp0_epc = val;
+	regs->cp0_cause &= ~CAUSEF_BD;
 }
 
 /* Query offset/name of register from its name/offset */
-- 
2.43.0


