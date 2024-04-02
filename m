Return-Path: <linux-kernel+bounces-128046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0998189555B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269131C214F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D5283CD8;
	Tue,  2 Apr 2024 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCUsq5we"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271C585287
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064443; cv=none; b=Har6gf8ALHKuBhehdJofqwfQeoj6CmolmSA42iHtbZmxMJzoT2IzQw8rg8R+9xpFUhoVijbZea4Aa/26p2QfV/ExVVOrkGFXkTwRuinlXVHetJjL2nCu6EQkO88+0AyQ335Kws67/2KYZd0M9YCsznnKnW6ChM9fgYKvtJ2duQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064443; c=relaxed/simple;
	bh=6dR3J0upXNj+1tYs1ts63PbosqZuz2MTKGiOBpIl+K4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PG8ljtn+Kopzb8S74eOC3NacmDgSKrc2sMPCo4Ff/wWv7UiQmgitd6NbYPavspYy8tTltYJLY4upSMm6+KclYFcQbVF5tprJtDnYHV97Hg0ZMWa4khhAfysrA5I/GBZ1qB2gXitwEK4AzHUQL8wHym990Ws9fHpYKbrPYETNRJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCUsq5we; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4702457ccbso643648866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 06:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712064440; x=1712669240; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6plq+jc/VvBXS+aNpltaWsMql6tEJfjJ+CETBOykAR0=;
        b=WCUsq5we3oU1fuxwA7iPLrwHQYjEqLzCa5TskvzfQ/oENr8+Es1TCi8l0Gtxf/Jt4Q
         ICg7rNH9jbuE9jlMDQT4wHsweE//m0lacd9xj+ucBxSLC8Vz0wEElcdmncDJzSWHklNt
         9ofc4VnlVsL4r1C2by6dg2qy9NP5UNkWUc4wmbe1PHT9NxzjhaTTLXwQcbOZoM33D6LF
         aR5xNfJ+boh4qhmKwKNk6/NIkoB07RHt/OaAgvvXwQJ5xESMQdtaUkn92TwgSkdl/bWU
         Ui2iJY9o/yGvv+w0cerOztoNZ5lvcpOgu5Lfz7FYv3xaFZfBTvsQHlyhri9Et6nCYtF9
         wEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712064440; x=1712669240;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6plq+jc/VvBXS+aNpltaWsMql6tEJfjJ+CETBOykAR0=;
        b=XNZXNbYOtsjleFPUxKAu8WOzKHx06GQczScQsadQi2xJ/H/EtNImkpDCUaG1qLUNe6
         3uHbcqaRNFZKbVGkOAK9GguaHPXlm34kKykEljkobYwUINyuoJULqSSDXbdfnBCxeVh1
         yYuIMzBR4S+6YLnZa40oOaExY1jRLdhPccnvXLF0vnyyEPUMUDtT4lHdzV6+hVbWXxAT
         Q0mVBlzomN950x5RCfBo74qwV5+hT95qndfsXYUYfJArpMXJMAATCRXqHvm7EIbpPPRH
         kdHBW0OaxOS1CMkWi4Pp/1UFBrHo1GOVGsl23b/qKH30gsFnhWM5FZFF7341fAKEqRM6
         pS2A==
X-Gm-Message-State: AOJu0YxcphQPsaoXPgEjaRyyAWC0kBXoG1fA2zh1CvSvDVIXYGUB4vmr
	MV57MkSbu4GZYI0kHk6yU3vKyIsuFjLfEtk4E+UhKs89pe70Xna2
X-Google-Smtp-Source: AGHT+IFh6Iw2TrL0kjEkoE4UmamEPUEI6XGozO1yFO9A91flOMzrYblCqI4/31CIdw8aKkhQg2lR8g==
X-Received: by 2002:a17:906:b1c5:b0:a46:cee9:e412 with SMTP id bv5-20020a170906b1c500b00a46cee9e412mr7005460ejb.15.1712064440404;
        Tue, 02 Apr 2024 06:27:20 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id q27-20020a17090622db00b00a46a9425fe5sm6499992eja.212.2024.04.02.06.27.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2024 06:27:19 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	rppt@kernel.org,
	rongtao@cestc.cn
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH 2/3] memblock tests: fix undefined reference to `panic'
Date: Tue,  2 Apr 2024 13:27:00 +0000
Message-Id: <20240402132701.29744-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240402132701.29744-1-richard.weiyang@gmail.com>
References: <20240402132701.29744-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

commit e96c6b8f212a ("memblock: report failures when memblock_can_resize
is not set") introduced the usage of panic, which is not defined in
memblock test.

Let's define it directly in panic.h to fix it.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Song Shuai <songshuaishuai@tinylab.org>
CC: Mike Rapoport <rppt@kernel.org>
---
 tools/include/linux/kernel.h |  1 +
 tools/include/linux/panic.h  | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 tools/include/linux/panic.h

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 4b0673bf52c2..07cfad817d53 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -8,6 +8,7 @@
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
 #include <linux/math.h>
+#include <linux/panic.h>
 #include <endian.h>
 #include <byteswap.h>
 
diff --git a/tools/include/linux/panic.h b/tools/include/linux/panic.h
new file mode 100644
index 000000000000..9c8f17a41ce8
--- /dev/null
+++ b/tools/include/linux/panic.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_LINUX_PANIC_H
+#define _TOOLS_LINUX_PANIC_H
+
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+static inline void panic(const char *fmt, ...)
+{
+	va_list argp;
+
+	va_start(argp, fmt);
+	vfprintf(stderr, fmt, argp);
+	va_end(argp);
+	exit(-1);
+}
+
+#endif
-- 
2.34.1


