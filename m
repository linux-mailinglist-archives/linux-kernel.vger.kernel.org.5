Return-Path: <linux-kernel+bounces-122336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D52388F55C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7CD9B239C7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BD12C197;
	Thu, 28 Mar 2024 02:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+1iOBbV"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3AA15EA2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592940; cv=none; b=hdQwQbaR+Kza9/ZVDJMNiIDAUtXkIDYZ1yaZdcPOx4fC93P+6OlmagQKk/C0hPLtNHaScNLOAXiOrqKodcfan7onVrPwnHw3v/YIE2Md5e2p6c8d8b8fEzBaCAVJw35GvT/w9Fc8yGLir1SoXwZRJ/3VtM1aPKzy1mCeyLIDbD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592940; c=relaxed/simple;
	bh=h+/LJXjVQOXWB/sKPlFjTW9LNmbWR1Ss72lNfiJiT6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UDdnYsr4cXmhlOgr09HKt1+LgyGAeoThzpQaIk4iS3EodUk7oMMfl9bOq8S+9p118ta/vEyt46K5dIg7F5X38GTeIAKT6TuQzTmJdnrrhl8sw5UxE8ekPzAVdbUjfQOU495133XO0w+1S3h22YeQQm/Dm7pLHi5FOWG5gW//P7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+1iOBbV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4e0a65f37bso61755266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711592937; x=1712197737; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bDAvihxPchw6uPgK2fWjw6QvhPyhverBPPRFPQpzTNk=;
        b=F+1iOBbVpcT4yF1wIEoDDvXYb3jXTsEHOh/XCUbjXwg9R8ffJOsqsr0wGcQIhK6+CK
         z/D4kY1r7lhNNJ656RGYAoR/FUF+wQoAHYIfBQqe6wx3Khynt7IoqC1InlXC9HRcq0w+
         u0DnEwy0cUqEVQzLuuYHQ75FTjOzcf5tcYUP9Z5BX2sA7/+kfkX+88vDt6erUvsOtDkT
         hhq3fiyC9AhY5MFS6jk5pcARC3pHtbuoni54ma6bvvXWwFZ710HcmBuQ6XiZqCyhRsOI
         ahWb6tsbyJd/pZYlAASDA/P+o1CwlodhYWjRJPZMyqkoA84iaCVRRj4L/czpMI2xQyT+
         IokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711592937; x=1712197737;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bDAvihxPchw6uPgK2fWjw6QvhPyhverBPPRFPQpzTNk=;
        b=DIMpJyIHXAO0F4cfDLr83iJG6EYp6tKOgwl8SWXmOL28Fs36AAqkuOQRtD8T1JZ316
         ZIRZnk8EzJlio/7lgBiACxHIXUB/MS+8xkc6VmEgv5HsE3XWcNSOw2/A0d5qZUmPYlE2
         GL+NVlIbaiE6EIHH5q0hZpdjYbPMV005tfyhHWIjSPEzPBQQKcrm9WZHFAvQuTw8zrNu
         Q5pthSbtLp84rkcoRtKX3GIPhwV/3kZg9jayAFdlDVs+uqIyLrCWpZumIrG1PrSt4jpU
         P0MOgWanvN+qECdAPSMMWRdtMcxZg6qW+XrS+TOEjh+INjMC+35EkPPkkUzS6S2tXO/P
         wq1w==
X-Forwarded-Encrypted: i=1; AJvYcCX5ygDyntVwCfRbCIZvGZw0RmHLObJzhe4su0tuBasCcOLg+KlSFOjW94lHacUl1Sh9QBZNPXvnJ9DwLNI1TGcgJQ+McQPJ3ogfw3Ar
X-Gm-Message-State: AOJu0YyLA0hoM4qj2UdKqIISDvux8h8glIZpVHY8Ero6BRV7nHPUq1ge
	G5F0QRPpIiIk+bKGXaBHOeAE0IM4th8rfws1FakR/+JBnMwz/GS5
X-Google-Smtp-Source: AGHT+IFx/cbqzZGVJgBPv/qh22M7obTZPKff4xe8ROsXGaVfkTB4R9HcPfhyxlhq3e+0RE9gCSqNdw==
X-Received: by 2002:a17:906:6a20:b0:a47:30d6:f465 with SMTP id qw32-20020a1709066a2000b00a4730d6f465mr982293ejc.1.1711592936785;
        Wed, 27 Mar 2024 19:28:56 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id wv11-20020a170907080b00b00a4503a78dd5sm197756ejb.17.2024.03.27.19.28.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2024 19:28:55 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/2] x86/boot/e820: a local variable for last_addr is not necessary
Date: Thu, 28 Mar 2024 02:28:30 +0000
Message-Id: <20240328022830.22802-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240328022830.22802-1-richard.weiyang@gmail.com>
References: <20240328022830.22802-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

We only use this to calculate the size of new entry as the start
address, which is already stored in new_entries->addr.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 arch/x86/kernel/e820.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index ecbeb76ed08f..8d431ac3f76e 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -324,7 +324,6 @@ int __init e820__update_table(struct e820_table *table)
 	struct e820_entry *entries = table->entries;
 	u32 max_nr_entries = ARRAY_SIZE(table->entries);
 	enum e820_type current_type, last_type;
-	unsigned long long last_addr;
 	u32 new_nr_entries, overlap_entries;
 	u32 i, chg_idx, chg_nr;
 
@@ -366,7 +365,6 @@ int __init e820__update_table(struct e820_table *table)
 	overlap_entries = 0;	 /* Number of entries in the overlap table */
 	new_nr_entries = 0;	 /* Index for creating new map entries */
 	last_type = 0;		 /* Start with undefined memory type */
-	last_addr = 0;		 /* Start with 0 as last starting address */
 
 	/* Loop through change-points, determining effect on the new map: */
 	for (chg_idx = 0; chg_idx < chg_nr; chg_idx++) {
@@ -397,7 +395,8 @@ int __init e820__update_table(struct e820_table *table)
 		/* Continue building up new map based on this information: */
 		if (current_type != last_type || e820_nomerge(current_type)) {
 			if (last_type) {
-				new_entries[new_nr_entries].size = change_point[chg_idx]->addr - last_addr;
+				new_entries[new_nr_entries].size =
+					change_point[chg_idx]->addr - new_entries[new_nr_entries].addr;
 				/* Move forward only if the new size was non-zero: */
 				if (new_entries[new_nr_entries].size != 0)
 					/* No more space left for new entries? */
@@ -407,7 +406,6 @@ int __init e820__update_table(struct e820_table *table)
 			if (current_type) {
 				new_entries[new_nr_entries].addr = change_point[chg_idx]->addr;
 				new_entries[new_nr_entries].type = current_type;
-				last_addr = change_point[chg_idx]->addr;
 			}
 			last_type = current_type;
 		}
-- 
2.34.1


