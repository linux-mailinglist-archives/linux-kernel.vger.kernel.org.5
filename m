Return-Path: <linux-kernel+bounces-87026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B06286CE66
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8821F1C20BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D0C15F8A3;
	Thu, 29 Feb 2024 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMLQcpf6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8322C15F88E;
	Thu, 29 Feb 2024 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221894; cv=none; b=GMKzrIyjmc6s8A66Nz8u35djxSwFfidrcun/g3gz5I1qF++qUcAUq9/TXkOwfg+LaH+fDfuRn4VXy4TIsvGQ5kr6/eQwos0/j9xDyDUqicrj1U8kRfZxduu9WMzE6PIRWcFb5D6LxQNfMYfdRNZDd6jdGLiV5opXwmnTRSCtM5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221894; c=relaxed/simple;
	bh=tfnOGd7pf3A5f59RWHth3GLkpWlXj5gee4oTcfvY3k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBzemem77EmmMmNOJKxxwYf4Qon+X/ca7qHTLREu208799qRt7RYoZtOyYE0iBiNfIAfYD6pn0G9ncu5xRfsw0l9OhF0pWu6eTu1lKju5X9Ol9w/icx4DDChEacEl4xcZUFdkkffXNi4kugSY3Xo+TWreYZzzHyqayNqaR0GtQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMLQcpf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D92FC433C7;
	Thu, 29 Feb 2024 15:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221894;
	bh=tfnOGd7pf3A5f59RWHth3GLkpWlXj5gee4oTcfvY3k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vMLQcpf6WvP12tkfHoYKxn30VAgpaItwnSy5Yc4JbEFXwYY6CkoqHQYcP8qKBsofX
	 Y79OaBnp5LucpnJMTjgu1StnSjzgMULTFvj7Be5VROAiwUrM309krmLc7cz6bw/8+U
	 6E+sfeSsWz9iUU8tsD2ECL+nCJAXZEBiJtgWYAraiDAGGdduQ9WF4avYhWVMFP55gP
	 /TTRQVq3pu0LlwfuY15ccG/gtDtK8+ftN6j05gckAuNToSUaY7D1Ew+no1m/aSsrD6
	 MDpzLJ8Ez6elqu8tntoBSls8qJiqb2pFO7BH5PHuviNkiiVOoDRCygBGDsNGEt2s6s
	 0GsNNdGx5y/aQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>,
	oleg@redhat.com,
	linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 4/5] MIPS: Clear Cause.BD in instruction_pointer_set
Date: Thu, 29 Feb 2024 10:51:26 -0500
Message-ID: <20240229155127.2851327-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229155127.2851327-1-sashal@kernel.org>
References: <20240229155127.2851327-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.269
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


