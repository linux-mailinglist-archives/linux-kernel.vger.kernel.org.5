Return-Path: <linux-kernel+bounces-93749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DDF87341C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF4E2913BA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B52360868;
	Wed,  6 Mar 2024 10:25:13 +0000 (UTC)
Received: from out187-16.us.a.mail.aliyun.com (out187-16.us.a.mail.aliyun.com [47.90.187.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1605FDBD
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720713; cv=none; b=ZCpGSUPv0AOewwKyWxlBv7uwLgEDBmqnujU10uzpffp+HY78/40znbAdYRo8R45QKj4PiKeVAE3ThBzrj6NhnQqj/9+YWXOk962CeCXf//8JXOkImvKHHz0/u6YzH/YUCIyAxlp98qmRbNmBYVdOu2XDRhwiMXrj2cD7p7fWIDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720713; c=relaxed/simple;
	bh=e5W/30uahPxnnobqPEw5qPDCHBhsj0fyCzs0F+PD/V8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LBvylGeu84ih/eyzK4H8R9nuHA2MDl6YdeIK3aNS9iPOwyt4oTctFx+P6Yo2d6ZbLy4DhlHp/bZjjK0/HLlqbjuhbkBR3ZIrORzHeac10WgWC53YyiBdNeJLDJrAXe+ddyzbAJsOKpa2w1KtjTlO7eJ9Kl1CQteSW+CGGSD6kqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=47.90.187.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047211;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.Wgbn-Jk_1709720382;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Wgbn-Jk_1709720382)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 18:19:42 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <jani.nikula@intel.com>,
   <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <intel-xe@lists.freedesktop.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 4/9] um: Fix the return type of __switch_to
Date: Wed, 06 Mar 2024 18:19:20 +0800
Message-Id: <20240306101925.1088870-5-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
References: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
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


