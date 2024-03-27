Return-Path: <linux-kernel+bounces-120360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7441A88D642
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3490329FFD7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468C61BF31;
	Wed, 27 Mar 2024 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fxABGrYa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x8VgCAB2"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BAC14A85
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711520040; cv=none; b=jrNlVuL0/ZvDr38j3YFcd8Wi9Y50ZJv9Mu3WgDq47pJldKyZdY5sl35dsHrmWD3r0dHc4oC7z8TzUkSLZFwAnW9uhRtVcxsPfedxzQZYfbRDnDb5tSJPmPjKPSgcAPe+dYUpM6/PeRUtXLaGle/kC0HqYAfJW8CUQWtmgwO1lKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711520040; c=relaxed/simple;
	bh=Z/t6oJU1Jq9ue+NRMzPbPR6p5EXRueXM4V3RRGGWG7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZeS8XG57adCnCRIKJGHhwE0QP4rfMo0tv6QdXEi4yikRxIzQKwIkcpab0cqkPCrQ70TuEka9LGavBZ3tE4NMX3tUT+v7GyG5stLWYurNYD3oP01txxUstem8f1Q9/aQjCfOMQx/2R1QnwFhhEJVvN33au7bgF3YrnQwr8CcRaDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fxABGrYa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x8VgCAB2; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C98CF11400EC;
	Wed, 27 Mar 2024 02:13:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 27 Mar 2024 02:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1711520037; x=1711606437; bh=L8pGfRNbp7RCkrkxlFARY
	zS97IZ7JZRhum3Xf3Y6QJk=; b=fxABGrYah/lfTugzx6Z0ngEyOKWRtWYzw2pW/
	oDhWOX9QSMk2VfcidduJHKIyV01zJ73f1uRLCql5WsrJwSSkQFWm7drJk3tIngiL
	0mfL8EuvOafXILend5O0FzOnhhFBFo/r1nIwroaV4MtTS5lGPzaUi22mPFmrOpq4
	w9ICMO9Ey00G91i2LJW2sAJOQobTVAnlbaULScXaO1XsmhfgUXf7PVtDHnLZFX0/
	SraxSI+JgiiE0ZrX1dSpCjkG8AFtmcEv+u6GbFo/uGcB+maFKO91mbirP+67xBTr
	7nYSgrRJ47+ONmUUPnQ18Tz9RcmmNjFV/F/6uVMpqrLinfFNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711520037; x=1711606437; bh=L8pGfRNbp7RCkrkxlFARYzS97IZ7
	JZRhum3Xf3Y6QJk=; b=x8VgCAB2jgsbdijfdu2/B8BeuIbsrgzrgafUkHpBWgGa
	sXNVQ8vwBNYs9It0J8tAytS2ywlAkPO2Nvzz4ke5U3x+5KZtSDyXsHaemLZPkoNB
	uETABOwVA8CUCQoeAmwMM2/TB1Sy5kO/gRS4A0IPhgeNf4+uCCgUGeC14XrLz55T
	DRRP1xbL1jcIwwO7MvTbLR+uA2wDr3sjAyzbNYTLlrEs+rufyxA64rWGx2cfhXFn
	d82QmU0htYWo2whOIF9KvS85/mtNxVjPE3ECREBK9XPhB7C5CIPxja7yQuOvbN68
	xpCLhRlkrqncv7TveFY5mWD0dlH0XUczsEkkBQF3/w==
X-ME-Sender: <xms:JbkDZkBfzVTCzSz-lWnTM4Itqz6xcaKQ3to1oXWe7GdqBHA4y7W-pg>
    <xme:JbkDZmgq-zUCZK2qa-GpsCUEwEMowO2lseSBGJdaSvIgf5jbiUbMEcwyNyOeKegVk
    ReZyI5tY9TuyK1ZEg>
X-ME-Received: <xmr:JbkDZnnWSuM6nXKX4dZ0EdL5WiLliAApS1jIiHM456CdigZQZCksd5NbMSgEOHJt6xzKvcQ8GQsm73jCJeoBSdicU2HkKYA1alh7Y_Zn2-CVRZpOwt6boISQncbqK4RcPMYqUlJADxqZP15bprHGR9e9GrJk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghfrghn
    ucfqkdftvggrrhcuoehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeugfejveekgffhgfegvdetgfegvdekieffvefhiedugeefuedvieekieev
    heeuheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:JbkDZqxz_e3wCKes9-l1u4PG3Vx2RquD0rfWhIXZ62qBKZ-4ENtDCg>
    <xmx:JbkDZpSMqhFc16QHy-_nvwkTJ7xb_zNfQztKdUh8y5p2fj47FUaDdQ>
    <xmx:JbkDZlZvQTFE8y2OrdIlfWloQl1N1IQ0_kt5pb00JIgDPDlYobfIDQ>
    <xmx:JbkDZiQ9yWyacMXn2Q6znyG0gYQL8IUdmHdwwOm4HmQD8TtK8g1exA>
    <xmx:JbkDZqQepNRMyDqizcPVXFSTwJCPeQvf9lETa9XS9MGKbf6cZXLCAw>
Feedback-ID: i84414492:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 02:13:57 -0400 (EDT)
From: Stefan O'Rear <sorear@fastmail.com>
To: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-kernel@vger.kernel.org
Cc: Stefan O'Rear <sorear@fastmail.com>
Subject: [PATCH] riscv: process: Fix kernel gp leakage
Date: Wed, 27 Mar 2024 02:12:58 -0400
Message-Id: <20240327061258.2370291-1-sorear@fastmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

childregs represents the registers which are active for the new thread
in user context. For a kernel thread, childregs->gp is never used since
the kernel gp is not touched by switch_to. For a user mode helper, the
gp value can be observed in user space after execve or possibly by other
means.

Fixes: 7db91e57a0ac ("RISC-V: Task implementation")
Signed-off-by: Stefan O'Rear <sorear@fastmail.com>
---
 arch/riscv/kernel/process.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 92922dbd5b5c..51042f48da17 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -27,8 +27,6 @@
 #include <asm/vector.h>
 #include <asm/cpufeature.h>
 
-register unsigned long gp_in_global __asm__("gp");
-
 #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
 #include <linux/stackprotector.h>
 unsigned long __stack_chk_guard __read_mostly;
@@ -207,7 +205,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	if (unlikely(args->fn)) {
 		/* Kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
-		childregs->gp = gp_in_global;
 		/* Supervisor/Machine, irqs on: */
 		childregs->status = SR_PP | SR_PIE;
 
-- 
2.40.1


