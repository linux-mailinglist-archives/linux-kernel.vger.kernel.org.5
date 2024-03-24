Return-Path: <linux-kernel+bounces-116230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6C78895C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DBC1F26D86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55D5291B75;
	Mon, 25 Mar 2024 03:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1ET/F54"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B811717EB77;
	Sun, 24 Mar 2024 23:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324007; cv=none; b=o+pHBhJg4Mk2v/s2i+vvJAYXri2yF3XUdhoe1VP2O/WVcDJFm6G+YowZQtDE/zwZyCf8Cty+aDukgkXyDB+/cF/8RN+FJzZIUA1T3p+SDRS+tQV1BQr5pp+M/DRxlRAq2YH8SNR5cprgs+Et+y+BLU5ueZT568vBs4WAR8orWHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324007; c=relaxed/simple;
	bh=tfnOGd7pf3A5f59RWHth3GLkpWlXj5gee4oTcfvY3k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1zdmETUhGnkiO72LpZcHL8BbP7hLJ8fGM5Q/snxQRj4iA1prIxbeXqTbFgeKLrpE0yZBw9y1nw08OpO5TrHc1cWCpREqu/+mp9w9w9ieC0xH7CVPyP17qcusPIvWAmzMQOoSwNp9uBnpVYx9kFvR4jB3dr/jPVU02PTwxdgxgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1ET/F54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37704C433C7;
	Sun, 24 Mar 2024 23:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324005;
	bh=tfnOGd7pf3A5f59RWHth3GLkpWlXj5gee4oTcfvY3k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1ET/F54SOOdF0LWnukss+kX0eRRzgPIKBC7qgsbh195/gpthK5BB8iKGOq+LmPcW
	 kuvipTxWi60JBgqTzP4sbQVLuGHqeqGGm4LN3RxTZnhHS+OHzrD7gpbYNL1lASyk22
	 cXP4eZUQJ5WiPFWGdv+VnFxzy9J+2604HrTIyquPZeVpsau6HEEX1N/vBh6CNBgE4H
	 EqHds3V2ucnR+7yqXImccaqaNk/jm6jetkzGqOk/kdlnM3b40TFXQaQdiDCSTyO/44
	 TjOJABY8YZ2VO+sxt6H/lgIktN0HK/ofEOZBUUhMZJRQthJJ4RV418ivjRlzWcYxjd
	 dpa0mm6E7fwUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 006/183] MIPS: Clear Cause.BD in instruction_pointer_set
Date: Sun, 24 Mar 2024 19:43:39 -0400
Message-ID: <20240324234638.1355609-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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


