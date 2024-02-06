Return-Path: <linux-kernel+bounces-54433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5036E84AF2B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76DB21C225C1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B889128831;
	Tue,  6 Feb 2024 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xC4RB/IN"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A37B7319C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205563; cv=none; b=Yl+VxmusFPt6dl/0rQYIHN3vRIFJI1ka8IsaSTp62TNfrN+shNywQYSXLCAxviTeUXtafcpODU6HDxBbqkCXBc5dDJ85rA8gFcjBnmqd3VKbnj5gj7+2R3vHTX8AGsvhSn2tx5s7ZqNC7zYlsXXQSV/uG0j2Pm2VLtVIrJ+WfgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205563; c=relaxed/simple;
	bh=G3Yx9KOpI21rH8wCQ+sSJXNl51GQyxbA6QuzJtXr0VM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZE6LQIEeovzkEsP9pGXscYDV7qjLulFg+hpZTrQLBjKZWWlKn4Ezqwh/68ZUDaZsK6b7eJt31DlRNI6hLXkAIRtxKKTw/5HMU5HehOxUIJsSaEr7U8/Acz6r7HGBIBa4wpVkC8JYhxP1MxPeMLW5WZ40Wnn2clJDV+xh612dDCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maskray.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xC4RB/IN; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maskray.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6041c633cfaso84758617b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 23:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707205561; x=1707810361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vh0bN2m+L086LhlsbFk+xSPJ48bcUxn6kZUD+9C817M=;
        b=xC4RB/INTcm9BMS8BOIUpc6ndYbd6hQQenojSPnVNRUl9Udir6breQq+O4spJAmJsa
         FcRjsvwGtWYBisHx0i3XEN53HZBoGH5nyvaYBqidzBHLXzD0fkUJ8IT2W+pahn0u4Bvk
         yHYLC4aVWjgMkYJ0eGpR9OmLrLfVKSW2AqxNh9DwjYmlEvR5xduimzEN2qKZ75jf/AYP
         tQCbojXKLVaCZ5tPZOpIN71N+e3mCJl8s5uM/YQjK4Ju9VUsGixxjF6eo6DXMNAzkukv
         nEQsUORemdq35+5AUJErG0GDY3hVUjOZyflxCM7PZgZxyvxkJ5iCV7YZJcCBQ+GJ1NYJ
         3SrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707205561; x=1707810361;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vh0bN2m+L086LhlsbFk+xSPJ48bcUxn6kZUD+9C817M=;
        b=IbtPPxQqqm1aSmzkY1KyLewD2/IjHi3zjiwM06Snm7de/KNWoVbEYVtH/jJBahVfwX
         sDYcFNQ1Hy36Y4UERePXnlHfCIUnac7F9PbOdRn6sh80KmywDGu2KDewFdunBM+rzCaJ
         6AAkQIc3LIXtLNTY4LVsfeTvxONDgH5fVj4FGDAaLD0TXpRrSsmBTp/hOxu2YXLkYmce
         S/tPG3snJ3LrZs+sowVVvQRz7pCpBQZXXYa1YmmgUqOLIl+/2mD//FF8dtG44ph3EfiF
         A1MT3dz0n1H8UbtbaEnWSUPJ+ealgQiHXGQBnxd4QiudG+hT9zgQl0EzoL+aVcPJE+IX
         gZjA==
X-Gm-Message-State: AOJu0YzzWmiFTxj97GEFbiFu0d9VEbTIwnzUtKQa6AnXEP0ZleRax4nS
	UqZAMQkJc7RVoAIIRQunZEAgwKBKlGiS0WtRtKRInxJcFdGXdbOfw5TkFh2WpLGLPMsoYIaPqYe
	R0NqWUg==
X-Google-Smtp-Source: AGHT+IFl4LFYjZ3M6ziPbjx7tz10SMlEpgwo6VsR3nz03CG0qKWnus4NRZtwBV755Vj6TmWAAh6cUW72TLuM
X-Received: from maskray.svl.corp.google.com ([2620:15c:2d3:205:1950:93e0:1305:9a80])
 (user=maskray job=sendgmr) by 2002:a81:574c:0:b0:5ff:5389:526c with SMTP id
 l73-20020a81574c000000b005ff5389526cmr107762ywb.2.1707205561384; Mon, 05 Feb
 2024 23:46:01 -0800 (PST)
Date: Mon,  5 Feb 2024 23:45:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <20240206074552.541154-1-maskray@google.com>
Subject: [PATCH v2] arm64: jump_label: use constraints "Si" instead of "i"
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

Changes from v1:

* Use asmSymbolicName for readability
---
 arch/arm64/include/asm/jump_label.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
index 48ddc0f45d22..b7716b215f91 100644
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
+		 "	.quad		(%[key] - .) + %[bit0]  \n\t"
 		 "	.popsection				\n\t"
-		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
+		 :  :  [key]"Si"(key), [bit0]"i"(branch) :  : l_yes);
 
 	return false;
 l_yes:
@@ -40,9 +44,9 @@ static __always_inline bool arch_static_branch_jump(struct static_key * const ke
 		 "	.pushsection	__jump_table, \"aw\"	\n\t"
 		 "	.align		3			\n\t"
 		 "	.long		1b - ., %l[l_yes] - .	\n\t"
-		 "	.quad		%c0 - .			\n\t"
+		 "	.quad		(%[key] - .) + %[bit0]  \n\t"
 		 "	.popsection				\n\t"
-		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
+		 :  :  [key]"Si"(key), [bit0]"i"(branch) :  : l_yes);
 
 	return false;
 l_yes:
-- 
2.43.0.594.gd9cf4e227d-goog


