Return-Path: <linux-kernel+bounces-5337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BC3818986
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5188E2838A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CE91C281;
	Tue, 19 Dec 2023 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqxu7Cvf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6268B1C6BB;
	Tue, 19 Dec 2023 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c69403b3eso45764205e9.3;
        Tue, 19 Dec 2023 06:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702995186; x=1703599986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eLbYqKVXpKfZkItp604TBY/NArF8Wh1bP5WaaocHCRs=;
        b=gqxu7CvfLqC3EEXKAgUJ0rSHaSDcK2wba2jafKBgZ9c/U7MvzR2+lN81VTL0au4o8p
         cqatqO80WHjVFrq0QPryqXKUh8Bdow/AVV9bdDALlMq2IN/482zX0sZdn9132MdzROKd
         YcNNnpmNz/N4CZQrtFn9jE2yaIdwiZRBGsb4tP31QDmD9Mbt4NnDY9qiytdmAhjiJoNd
         RAbISMpDNf+2Yq9EC09pvdQgLy+xqo1M7smRzdasIW6UactL6nGq3SHTgnZgD1xHTbbf
         yaJw9+ek1M+VwbP6QpdmwpHGu/kflQ8OdxWeG+eQoVO4W+LF8D1VxXdWgwCqkoUSta/k
         VNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702995186; x=1703599986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLbYqKVXpKfZkItp604TBY/NArF8Wh1bP5WaaocHCRs=;
        b=uc43w929aKGZYvOzwwW2OHQDtbla4vTt4Qz5xInzEqiEk7h2dBsvkHTcI73CpcHATk
         +J1xAoWJCYHb+rsdPUB7N1MaHTgSnkeEHzLzDTRO2VyEANwY7SYpFd/P4MhmKZncg/0y
         FSN4n73v/tXZBXSIaH0vzmQtOgEQ50dkjUW/Z/vCiGl7B94dcyXzCu5kN1GmpFirIJnt
         kuBkAjqiKZuQCZrahK23PIKbT8Zs0CZIEgg/qpttJhWT5TjR0ibaslQ8WByr01aGz5EI
         iPVHjlhGGYKLo2lWJFZEr0YeZrZ8BHzS/xeMp1VhnUPBiIrUcnBPM5reRJViU7+90iyg
         yu0A==
X-Gm-Message-State: AOJu0YxhzQgMn2RJ7ZBTzO5AcP1TK9cKEYv+Zt4EtneZfpOCmBAoNJPE
	dcPW2TuVqUXHT4X4EBSfUao=
X-Google-Smtp-Source: AGHT+IGiZvpq8seznrPK6I15r0/2QKiYfqoD1ONyXzlANJSzcDpwpJSuJIe+/qbSX0lhNqenhmQf+w==
X-Received: by 2002:a05:600c:b41:b0:40c:2a41:4a35 with SMTP id k1-20020a05600c0b4100b0040c2a414a35mr9337746wmr.130.1702995186239;
        Tue, 19 Dec 2023 06:13:06 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t18-20020adfa2d2000000b003364aa5cc13sm59375wra.1.2023.12.19.06.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 06:13:05 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/boot: remove redundant initialization of variable delta
Date: Tue, 19 Dec 2023 14:13:04 +0000
Message-Id: <20231219141304.367200-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable delta is being initialized with a value that is never
read. The assignment is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/x86/boot/string.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 1c8541ae3b3a..c23f3b9c84fe 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -49,7 +49,7 @@ int strcmp(const char *str1, const char *str2)
 {
 	const unsigned char *s1 = (const unsigned char *)str1;
 	const unsigned char *s2 = (const unsigned char *)str2;
-	int delta = 0;
+	int delta;
 
 	while (*s1 || *s2) {
 		delta = *s1 - *s2;
-- 
2.39.2


