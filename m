Return-Path: <linux-kernel+bounces-35168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33773838D05
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C6E288CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BEC5D91C;
	Tue, 23 Jan 2024 11:09:20 +0000 (UTC)
Received: from out0-218.mail.aliyun.com (out0-218.mail.aliyun.com [140.205.0.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5E15D72E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008159; cv=none; b=nwZP9SQmAK68DOdwNdBwjHcjG1R0eYSQ5YoWksnXuOwLrlS2U/IoMI1KXqMVSiSyihHtN9WotE40YylFfCbovqZE0Hkzy4zAj2rOczhPIypU4gs2PpLdI8x4VBSlzbrZ2AJQ9ZJT2Ku17gBYyWvUD2uG6bhjKsp3JainEA4b5JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008159; c=relaxed/simple;
	bh=e5W/30uahPxnnobqPEw5qPDCHBhsj0fyCzs0F+PD/V8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kZFw8QVM0hXZifY1uSSPdpg1i6HbieVrHKSLlvg+ZaGt8hXjB84uVR/R0jpI1k1J2S+WWOGFrDhbuakp7KeR/plTO5vGtiiYiDRsZICUfe3bLVRzDquE8t/WEyg/bjuU8BlxRJQZIPWDL6FnB4k2Kpgi6AD0rM9ThNCLPa0xRic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=140.205.0.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047199;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.WDCKTk8_1706007836;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WDCKTk8_1706007836)
          by smtp.aliyun-inc.com;
          Tue, 23 Jan 2024 19:03:57 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 4/5] um: Fix the return type of __switch_to
Date: Tue, 23 Jan 2024 19:03:46 +0800
Message-Id: <20240123110347.1274217-5-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123110347.1274217-1-tiwei.btw@antgroup.com>
References: <20240123110347.1274217-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make it match the declaration in asm-generic/switch_to.h. And
also include the header to allow the compiler to check it.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/process.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 292c8014aaa6..a7607ef1b02f 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -26,6 +26,7 @@
 #include <linux/resume_user_mode.h>
 #include <asm/current.h>
 #include <asm/mmu_context.h>
+#include <asm/switch_to.h>
 #include <linux/uaccess.h>
 #include <as-layout.h>
 #include <kern_util.h>
@@ -73,7 +74,7 @@ static inline void set_current(struct task_struct *task)
 
 extern void arch_switch_to(struct task_struct *to);
 
-void *__switch_to(struct task_struct *from, struct task_struct *to)
+struct task_struct *__switch_to(struct task_struct *from, struct task_struct *to)
 {
 	to->thread.prev_sched = from;
 	set_current(to);
-- 
2.34.1


