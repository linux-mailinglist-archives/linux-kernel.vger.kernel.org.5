Return-Path: <linux-kernel+bounces-105428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E711B87DDBF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1305A1C209A8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658511C694;
	Sun, 17 Mar 2024 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WkP7kOSc"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84071C28F
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710688057; cv=none; b=GgJ2TPemcgnsKFYBXxgFaCuMG+VRn5OOzlMY9tJpLu0bCa/E9n32Dw5MYQLIuwmqnb//kmbN6/PZxGY70aEtunuYG0sM3umnZ2fZnT/l+3PwBas93gPsSSsPwRAwCThd5vYbh7oetPtf2xAaGVHCI9A3TCYOEi2vg2Mz2/48/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710688057; c=relaxed/simple;
	bh=IacdikwGeETM03FPof7cc/AY/6hLvnXxuleazQHPrek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ByH8M0kxocDFC9BGSEVJnMGoDBp7PKGM1X2x9pruuBJCDBVv3VROsTig9LDvZkDoIAbUPf0t3gHqiS0p6OMayXPmX6bIlby40UgjHVNNsdvoS/YvJmVBE5encg8GneR0Uszmfug3tBfvhw0Rn8oEgcPXjkispCCqVV5Y+1AlTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WkP7kOSc; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5e152c757a5so2117353a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 08:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710688055; x=1711292855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hhICYYV1g+oDZFsBzqUaHWt+HsbjmOKz1L+K4AX4MSo=;
        b=WkP7kOScHjvBNLENFHPG5gu08Tqur8WJkPXrh32gHq2lAvVkiQXUK/QrAk0k7grmHy
         neqFxiSIHO5TRr3Nqo1pTiMZCrrZsK/DC4DzXY6Nh1yEaezEfnyI5EY9L513wj1QgVk6
         ntyTcR/H5zM2njrlHTq/RZ15vgYJgMAExe0wMA12Kjpo/gGM0HydbumrzQtAzMbQsI/v
         U+XEmZsWjLYf9q4VPtSMZ+qAqNz8i2Qn6P5lhfVpUJYzrYVkCGz9lc7hfyZxL1gYQm0J
         f0QW2DY0f20YZDrpmVtR9Smt/uHG0U1QMwEaQA3DJvrgr773ZLluCazWC7BAkKiXNq1Z
         YvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710688055; x=1711292855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhICYYV1g+oDZFsBzqUaHWt+HsbjmOKz1L+K4AX4MSo=;
        b=eEXQplTC7LHNb/AWAEofejroDBQqk0fC8OmdCRJsptbaoxhaaJR4m9Ddz1E3aJPhph
         fYBWbrO6crH3PDji7FsCypddpcEsuzTpugAjKfk3/D5QSNfjjz3x5GkvppyVa1JHi38A
         XU1EPkca3CWKsy/xO8ROriDo78noP3yr4ldhnJYJwTMCxfRef31mabeGU1pU2HQ3Qxd7
         L47y4UJArrZFum8balNEiAPnwHN6ydpcPcXJ7bPCFz2uZdiY2GWJUD3bBKLAQG95WbnX
         8HXc3Wo9c/NGgZdavmN/JMANTPpT3ebnllRflLph8p806f0PgwUgn0gfsZWkxCmyuFPw
         1rCA==
X-Forwarded-Encrypted: i=1; AJvYcCVWhhqdXHOq03oazZKQ2YqkxWJiqROqYh0aQgfSWe9zyHkZi1KpZwJDmiKd5zExg9pKp0PEAiTWgRazvioaTyCgbspuVnAKEPNTrAJb
X-Gm-Message-State: AOJu0Ywdd3V6H9MPWtlm6SrJ8IyWqt7GU55IBxGUlTDqlo6xBrhR7/Uz
	w0TL9cbV6yM1lWO4a3wIO9tWgeQ5cIvCxAwEwxwZ0Zdi+uC3NbXHiTKobmVrT2U=
X-Google-Smtp-Source: AGHT+IHxGaa6Pn6062Ac3witWXSLzJOmdl6pedhlmppjiYLrKqco1HzUbQZ8yF7evP2SNB9JcqLheg==
X-Received: by 2002:a17:903:264e:b0:1dd:e13d:6834 with SMTP id je14-20020a170903264e00b001dde13d6834mr6845647plb.41.1710688054845;
        Sun, 17 Mar 2024 08:07:34 -0700 (PDT)
Received: from C02FG0GJMD6V.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001db5ecd115bsm5921296plh.276.2024.03.17.08.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 08:07:34 -0700 (PDT)
From: Guixiong Wei <weiguixiong@bytedance.com>
To: keescook@chromium.org,
	tglx@linutronix.de
Cc: jgross@suse.com,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	gregkh@linuxfoundation.org,
	tony.luck@intel.com,
	adobriyan@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	weiguixiong@bytedance.com
Subject: [PATCH] x86, relocs: Ignore relocations in .notes section on walk_relocs
Date: Sun, 17 Mar 2024 23:05:47 +0800
Message-Id: <20240317150547.24910-1-weiguixiong@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit aaa8736370db ("x86, relocs: Ignore relocations in
notes section") only ignore .note section on print_absolute_relocs,
but it also need to add on walk_relocs to avoid relocations in .note
section.

Fixes: aaa8736370db ("x86, relocs: Ignore relocations in .notes section")
Fixes: 5ead97c84fa7 ("xen: Core Xen implementation")
Fixes: da1a679cde9b ("Add /sys/kernel/notes")
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 arch/x86/tools/relocs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index b029fb81ebee..33844b33b8b9 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -746,6 +746,16 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 		if (!(sec_applies->shdr.sh_flags & SHF_ALLOC)) {
 			continue;
 		}
+
+		/*
+		 * Do not perform relocations in .notes section; any
+		 * values there are meant for pre-boot consumption (e.g.
+		 * startup_xen).
+		 */
+		if (sec_applies->shdr.sh_type == SHT_NOTE) {
+			continue;
+		}
+
 		sh_symtab = sec_symtab->symtab;
 		sym_strtab = sec_symtab->link->strtab;
 		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Rel); j++) {
-- 
2.24.3 (Apple Git-128)


