Return-Path: <linux-kernel+bounces-108751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B87880F89
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FAB284765
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF913FB3E;
	Wed, 20 Mar 2024 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="F5GKWIk7"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB59F3FB35
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930002; cv=none; b=pZbgWQo+xNwtbbAfFBDRUNR62Nh4ZyxQWOGCeSsmBEB7Zq+Jjm4GeRqt3LiYoedyChv+UJu7/SEleNGvq/tZmnpu1Q8+VjxhwOpEjJVusnV5TALjaqD6uA6k6ujOTkHUQXyrqPxVZioplPKg16Bh6qLhl6IZHWRHMABjgAUnq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930002; c=relaxed/simple;
	bh=UV21p/GrGS9v955JiBiuiJ1PavXJwlV8g5S2FsRKxtk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T0ejE0docXL0SiiDItcAuKq8T48GRHfunXygiU+7tujSmGJlVWa7yzbFV0dFfzhDIAcyuqKuaFOKwCmwXzbn3a0Jgjmp70UqGWqQACy0b3OZD9C0vzFe3Z3mIDaRRyIuRGSkhue0V0aVNhXwaUeQnRAa2LxlVS6uRBDIWhpXc8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=F5GKWIk7; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512b3b04995so5475919e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 03:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1710929999; x=1711534799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMBnso67DKuDswnFo5PzqffLcUZAHJg0j6YQi/mv7fs=;
        b=F5GKWIk7Byxmd1yL/RWhHOqKaQJvF7TWyYc0QWWzGBSPZATCjxCWseYAmZxY15OAjX
         wHbPoQaolWj9mFu5yRLwvfQTP8VvGlIDAvgBgUow2KQrMrZAHBoKhMPA7+rnNMK7PC7R
         aQ8Nuag65vRqw3C1ff21CTc4f7bXsyFKjoyVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710929999; x=1711534799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMBnso67DKuDswnFo5PzqffLcUZAHJg0j6YQi/mv7fs=;
        b=isVJE67uAEGWsez2mb+ptdp2sRF4p3lHSSfgRzcYVrfgdGvadIS9sjQfp8s90Rzp9E
         hqCm9E8yyu3QMTlwpl/DwMYqphodvOLS3a4nMCe/TDfBYJhrurIlueOZenHRr3YzBXy+
         UvZwARi1YWF8nn8jeDYxoo5qpSjdWWkMEpVfwINzY4h76+THkulsALWcWOGVorhVvCZ8
         rxrqA04Is2FJdhivRRSkr0iXjglAHvjneHHqmOZsp/vzgMZI/Dbd0tu7m+tXRy8g0nAY
         zYW12EFWNVfb4sKuL3BJ1b3Wukc5vRqQs+Dgfmq5oPxtxP0/+12D84mABzWEKxiVN4r0
         YVhg==
X-Forwarded-Encrypted: i=1; AJvYcCXnnrvZsCWMTKf2qc83hseEz7GyG1m1Z+ThhTvv4Zf5qTM7a+nf4OgQEN6Imrhtee67HE0hZjttMTLsSAal8UoZqineSG3i6qSljNq2
X-Gm-Message-State: AOJu0Yw4h5WUNsrZX8WoYFnzPZSusAQMB6AFtldUyvnJQeOwgZNBonNW
	/D//bFvLmE/hOjgGPGThWOySXIPZb90Vduib6cbDfF23gTIBlAyPz3pfNI9oWJY=
X-Google-Smtp-Source: AGHT+IHPGYIUL2+SVoUZ5qqKUnyPKltnFWOg+ACAbJ+TxPCrNl0xEn9vKvNX5k1E2MkruDRsR0NzTw==
X-Received: by 2002:a05:6512:3fa:b0:513:cf4e:941b with SMTP id n26-20020a05651203fa00b00513cf4e941bmr1004330lfq.19.1710929998661;
        Wed, 20 Mar 2024 03:19:58 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r17-20020aa7cb91000000b0056bafdda14bsm551297edt.28.2024.03.20.03.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 03:19:58 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] bootconfig: do not put quotes on cmdline items unless necessary
Date: Wed, 20 Mar 2024 11:19:52 +0100
Message-Id: <20240320101952.62135-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When trying to migrate to using bootconfig to embed the kernel's and
PID1's command line with the kernel image itself, and so allowing
changing that without modifying the bootloader, I noticed that
/proc/cmdline changed from e.g.

  console=ttymxc0,115200n8 cma=128M quiet -- --log-level=notice

to

  console="ttymxc0,115200n8" cma="128M" quiet -- --log-level="notice"

The kernel parameters are parsed just fine, and the quotes are indeed
stripped from the actual argv[] given to PID1. However, the quoting
doesn't really serve any purpose and looks excessive, and might
confuse some (naive) userspace tool trying to parse /proc/cmdline. So
do not quote the value unless it contains whitespace.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
v3: Add comment explaining why the quoting is conditional.

v2: use strpbrk(, " \t\r\n") instead of a loop doing isspace().

 init/main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index e24b0780fdff..7a5efe363938 100644
--- a/init/main.c
+++ b/init/main.c
@@ -324,7 +324,7 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
 {
 	struct xbc_node *knode, *vnode;
 	char *end = buf + size;
-	const char *val;
+	const char *val, *q;
 	int ret;
 
 	xbc_node_for_each_key_value(root, knode, val) {
@@ -342,8 +342,14 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
 			continue;
 		}
 		xbc_array_for_each_value(vnode, val) {
-			ret = snprintf(buf, rest(buf, end), "%s=\"%s\" ",
-				       xbc_namebuf, val);
+			/*
+			 * For prettier and more readable /proc/cmdline, only
+			 * quote the value when necessary, i.e. when it contains
+			 * whitespace.
+			 */
+			q = strpbrk(val, " \t\r\n") ? "\"" : "";
+			ret = snprintf(buf, rest(buf, end), "%s=%s%s%s ",
+				       xbc_namebuf, q, val, q);
 			if (ret < 0)
 				return ret;
 			buf += ret;
-- 
2.40.1.1.g1c60b9335d


