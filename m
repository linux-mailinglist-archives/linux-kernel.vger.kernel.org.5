Return-Path: <linux-kernel+bounces-513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6605A81424E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988431C21558
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCE9D2EE;
	Fri, 15 Dec 2023 07:24:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F84710949;
	Fri, 15 Dec 2023 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-28b0a265f92so253245a91.3;
        Thu, 14 Dec 2023 23:24:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702625053; x=1703229853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNpC7NFbJjbEn49G0H7MyhYXJbT+qig1neudpuf1zUA=;
        b=VnqUZCQsBDbypHu0ziEhP63x/u4Fgx8O6ZM0iwOwxw3oN16RXVerqb2/dtaQVKOBxs
         hnrRpBZqtypG9QzpcxY+hLx0JJ1GoY7znmmD5pviwH20qmYrXXujmkL/unLZNcOOrmsw
         N9n6hKRz6Gf/KGaWYveKvSHVGKd6tNpQAcAtfQanjvoSYI0IU2OXdj9gbHudx6t2K3uF
         xKndR33nCw1lQCQecf/Tw5G8Zug/yz+68rNtwycTgPXqKjALMErjEIrP4Ba0t5COEy5A
         Fn+hWc1DyOjaEl2oK9s7cic6BboSOfSgYjSj4acfZHKMr26lUIFtMdSfXrT98QLq9/mX
         kI1Q==
X-Gm-Message-State: AOJu0Yy2nQQtKsJSiFM8LGzLd3atCKGH9zEZXTpxIFUr8qStHQ9FT6m1
	W/Fq7mD3SlWX8TdwOJeTSfRuCUhE1jznlA==
X-Google-Smtp-Source: AGHT+IE2GSUOcnc8CjzGsfrsEfmISwc8i0DZ/GUQE9BbbHhbu2/MUPr4aOlBN2D6ECmKIqOXhn1NQA==
X-Received: by 2002:a17:90a:990f:b0:286:6cc1:3f1b with SMTP id b15-20020a17090a990f00b002866cc13f1bmr8637604pjp.82.1702625052825;
        Thu, 14 Dec 2023 23:24:12 -0800 (PST)
Received: from kylin-ThinkBook-15-G2-ITL.. ([111.48.58.12])
        by smtp.gmail.com with ESMTPSA id in18-20020a17090b439200b0028b041cbef3sm2888719pjb.22.2023.12.14.23.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 23:24:12 -0800 (PST)
From: xueqin Luo <luoxueqin@kylinos.cn>
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH -next] ACPICA: Replace strncpy() with strscpy_pad() for dest
Date: Fri, 15 Dec 2023 15:24:05 +0800
Message-Id: <20231215072405.65887-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While it is safe to use strncpy in this case, the advice is to move to
strscpy_pad[1].

Link: https://www.kernel.org/doc/html/latest/process/deprec:qated.html#strncpy-on-nul-terminated-strings [1]
Signed-off-by: xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/acpi/acpica/utnonansi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnonansi.c
index ff0802ace19b..3a7952be6545 100644
--- a/drivers/acpi/acpica/utnonansi.c
+++ b/drivers/acpi/acpica/utnonansi.c
@@ -168,8 +168,7 @@ void acpi_ut_safe_strncpy(char *dest, char *source, acpi_size dest_size)
 {
 	/* Always terminate destination string */
 
-	strncpy(dest, source, dest_size);
-	dest[dest_size - 1] = 0;
+	strscpy_pad(dest, source, dest_size);
 }
 
 #endif
-- 
2.34.1


