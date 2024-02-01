Return-Path: <linux-kernel+bounces-48951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B85846384
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA5BFB24B00
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220344120F;
	Thu,  1 Feb 2024 22:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zUrQV2Up"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEF23FB1D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827023; cv=none; b=epv29azH9CG58p0d6iCKfE1Ka/qmwQBOgVmFA/3J4Yy4lsxt2C5olrmsrjX+rx8Zrbs+70GWDz/URbkYy5K0/VgboTyRXRzw3kay8vuxESAqKP6G5r0NROR931MsbDH0mbumcXQ6ic5gCmesNMaRYgxUz32UvKeOxITgP1c24Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827023; c=relaxed/simple;
	bh=C1Td7LS6mQYWKcz4HPRMpRrQao7T6kT+I564bAgKsBU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pmZb8wSnC4kazbLHEoRgjgValAzKYAaThQH/qg6tCfwFFqVo7BlPhILOn/+blyGO1oxQiNVciYnDOibD8N/dcYi4+umci/W3FL4Lekh30Yp/rd0kbCBNDCjC+nEuSVSpM4FV+n+sfuojNkMupTCel8ALZsHZ+TJfygL5bSS8zKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maskray.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zUrQV2Up; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maskray.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso2114982276.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 14:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706827021; x=1707431821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3B3tF1HYvRY1UkQ2K7cnSqpuGaSyeDgjRqaJd9RSiXg=;
        b=zUrQV2Upjx8/DfFBOJflmwchTh9DcgyYDnSJXqn3q5/OwLg5BLdy8Ah8HZfKJYtlJS
         28Nc+A+2y8rrdqcetumgwLd1QBqm2nzHrV/AHX6rTWyaP93zmLl6z1GqX8oEoChaaEjp
         tcQmn2OakN+SUmpSU6B6Cn59B3bCyFcssKyH2Sn30EGoFbSBoosWgHezncRzeq71YmnM
         H3MmsplIjTHtElydFCsQTSc1BvIicbnl1+DdWFDlRFkaMFxrzD4qUHqV68xys0prd3Q6
         4wqmRhDfPyC/yYA4H+gBqMA27L1EJryhphVVPS2Il/nZDyeOZFR4r6+khYwKz5Pzet8a
         XCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706827021; x=1707431821;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3B3tF1HYvRY1UkQ2K7cnSqpuGaSyeDgjRqaJd9RSiXg=;
        b=Uk5r86SfktO1MfavuKIp/ZlXLLeKV8HmMjJI27F98bbQs67w/Uj1gmeUVFKvYSMhMu
         bEXznZtZLo3WvTqXlCFalnxfuYoQLWgRVf+lTFTVXeq9s+mGSb2b1w5jWT+Ae1oMepy2
         Ydmc189IJnUWoa8BlKXItM8oU6dT3CKxFbciFEScYIR0QKJCv3pi+D2la+s+kgX0SZEQ
         RX1YWQJQ+N7P0N6ZoZRAyd7qTdoExN9lvRcvOBk4BMqQaEBVQJTUe10nVPiu7renA5Zp
         0HN0Ri6lr4UQLeyMM20D++e+97Ow69xsbgqVN25Aoxeoz+iAaMfa0lQJRCsLQUePsRRt
         J2zw==
X-Gm-Message-State: AOJu0YxSM4u98CZpzX2nkbKOmzsJMBA/sm81uCdsaYdegabSLHbE9uQO
	TxY+PpMVzqtREgALOfFOqJrlwHD3jVgEFibUb0xtYzDr9YMM5wY1aoZVfSdrg8SmchXn8uYlICt
	epdHR9Q==
X-Google-Smtp-Source: AGHT+IEtIsVPxgDfG98U8Bbl2kwE3MvRjxByJZVySc1k/DECQFUpeiwq33gwZ/XYHnQ4uktoKoW718gMTm1N
X-Received: from maskray.svl.corp.google.com ([2620:15c:2d3:205:7de7:721a:241f:7455])
 (user=maskray job=sendgmr) by 2002:a05:6902:cc9:b0:dc2:57c9:b44d with SMTP id
 cq9-20020a0569020cc900b00dc257c9b44dmr149539ybb.8.1706827021012; Thu, 01 Feb
 2024 14:37:01 -0800 (PST)
Date: Thu,  1 Feb 2024 14:35:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <20240201223545.728028-1-maskray@google.com>
Subject: [PATCH] arm64: jump_label: use constraints "Si" instead of "i"
From: Fangrui Song <maskray@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Cc: Jisheng Zhang <jszhang@kernel.org>, Dave Martin <Dave.Martin@arm.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Peter Smith <peter.smith@arm.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"

The generic constraint "i" seems to be copied from x86 or arm (and with
a redundant generic operand modifier "c"). It works with -fno-PIE but
not with -fPIE/-fPIC in GCC's aarch64 port.

The machine constraint "S", which denotes a symbol or label reference
with a constant offset, supports PIC and has been available in GCC since
2012 and in Clang since 7.0. However, Clang before 19 does not support
"S" on a symbol with a constant offset [1] (e.g.
`static_key_false(&nf_hooks_needed[pf][hook])` in
include/linux/netfilter.h), so we use "i" as a fallback.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Fangrui Song <maskray@google.com>
Link: https://github.com/llvm/llvm-project/pull/80255 [1]

---
Changes from
arm64: jump_label: use constraint "S" instead of "i" (https://lore.kernel.org/all/20240131065322.1126831-1-maskray@google.com/)

* Use "Si" as Ard suggested to support Clang<19
* Make branch a separate operand
---
 arch/arm64/include/asm/jump_label.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
index 48ddc0f45d22..1f7d529be608 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -15,6 +15,10 @@
 
 #define JUMP_LABEL_NOP_SIZE		AARCH64_INSN_SIZE
 
+/*
+ * Prefer the constraint "S" to support PIC with GCC. Clang before 19 does not
+ * support "S" on a symbol with a constant offset, so we use "i" as a fallback.
+ */
 static __always_inline bool arch_static_branch(struct static_key * const key,
 					       const bool branch)
 {
@@ -23,9 +27,9 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
 		 "	.pushsection	__jump_table, \"aw\"	\n\t"
 		 "	.align		3			\n\t"
 		 "	.long		1b - ., %l[l_yes] - .	\n\t"
-		 "	.quad		%c0 - .			\n\t"
+		 "	.quad		%0 + %1 - .		\n\t"
 		 "	.popsection				\n\t"
-		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
+		 :  :  "Si"(key), "i"(branch) :  : l_yes);
 
 	return false;
 l_yes:
@@ -40,9 +44,9 @@ static __always_inline bool arch_static_branch_jump(struct static_key * const ke
 		 "	.pushsection	__jump_table, \"aw\"	\n\t"
 		 "	.align		3			\n\t"
 		 "	.long		1b - ., %l[l_yes] - .	\n\t"
-		 "	.quad		%c0 - .			\n\t"
+		 "	.quad		%0 + %1 - .		\n\t"
 		 "	.popsection				\n\t"
-		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
+		 :  :  "Si"(key), "i"(branch) :  : l_yes);
 
 	return false;
 l_yes:
-- 
2.43.0.594.gd9cf4e227d-goog


