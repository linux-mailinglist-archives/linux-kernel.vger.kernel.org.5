Return-Path: <linux-kernel+bounces-97021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C105876480
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001E51F22758
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421EF1AACA;
	Fri,  8 Mar 2024 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="azXs8ocm"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5347C18049
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709901852; cv=none; b=rLIZzY/HwDYHAIYWdhz4NMJxU5WDgJ9gHplf8DrgukWDAqdpI16f/+FLwu1CBHZ/IvI6/stwwEzMq9n0VA0+s/Xu3TW/vMhu3WzzTxG4rF9t75z8HBe9OQIrqGnlPcFhjqWeEGnOuYgLPNTVQe+Ffhc1aLk+HfsiGuZdFfAExFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709901852; c=relaxed/simple;
	bh=XxREvmxu2/O06ne/haRu+k1mj44Mw/ZDyIv8QLpzO9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KhBUq8FJV1BRXJkiNSI+ctyG3D/epGTrlWtC1yB0X2mMkZFK2YkZYwAo5u8fXOS5lM37BlKFqKSGnBKK0XdFvkkStjhoHxByxwO7L4mzL8YaoHb20/EEYqETXqlRnNyEczpzcAUtl4ZywSugK8khdweIAwV4Tu6fQzOnGmvNCtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=azXs8ocm; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5131316693cso2622924e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 04:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1709901847; x=1710506647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4zJhkPuIst6RukagPbbrxvpBERTFo5SNybbWJgx3wQA=;
        b=azXs8ocmIOf5UB1/BOajxKuv9bEnkBoy3ZoXKsQfytVlli4P6PNoY0Eobrd7BEdeTX
         tYtp+JTqaUdXS/IF25FaLy8/LQ5JR5/h4XV1Jv7viZu+urXmPbTWz/8jSgbvaeLoV3JE
         KSpNEfo4geqFTtmgyP8VCdpLTm0Ss5Bd11HtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709901847; x=1710506647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4zJhkPuIst6RukagPbbrxvpBERTFo5SNybbWJgx3wQA=;
        b=coB8Kcd1pEFBXAC7d0dEOpaDPCOH9iuLtaFxgMlC8P+EwpqDQ8y688/3NEE8JfhPNu
         CUoGT9UV85LbiGGwmXj1s9ydqbPraZZoR8RZu5oKEPXe6kjWtZp+B5htXH/ur+TFW2MC
         H7BB36AEHi0wx89dJBqfKLqhURUeujssUZF5OSjYIi9Pw52Ad2+CO4AQtcTCKcoV6ezv
         LWqXjxmVCRAXSlHXPOD6xI1yj+fIADJOajOYPfJWIPVGW7qMmpl8oKHzRPZxSFUCsFdc
         wLO7oTBePAUkUGpVzrJWTlbb2T1xiSOyCRNR9uLL+3XNuHZDxGGhhOFiSsCvRSlMw05q
         jgaw==
X-Forwarded-Encrypted: i=1; AJvYcCWKXfAQISBK+OzO9uIZVhj+aJE/f6XUjn9pFs0F8KHRsWydvHdyDptDAjMukGkERIs30Q4Q+qaG9jFdVgOzSCmpZtj5UF9PAMzVmCkD
X-Gm-Message-State: AOJu0YyvmDM+mDcnZ3Cz/Igsir/vzDVZ3ExFZFdMZmZQPODjbpk0RaNA
	XbLtHGkG4sGPuiHA/PiMTt7F8wmmLDW2jzHh47osE7vduPhFkqCX8lYYF7Li4zv9t7cOEOEqpGR
	KUxs=
X-Google-Smtp-Source: AGHT+IEM8rYyxUnvGiXEkg84+s5MR6KBxxnN+zs+tM29uikuP70f9HwzXpAeA2hvX8BkgZGu162gWw==
X-Received: by 2002:a19:5f53:0:b0:513:4847:2c0b with SMTP id a19-20020a195f53000000b0051348472c0bmr3777440lfj.7.1709901847481;
        Fri, 08 Mar 2024 04:44:07 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q14-20020ac246ee000000b00513210d5b83sm3474858lfo.195.2024.03.08.04.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 04:44:05 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] bootconfig: do not put quotes on cmdline items unless necessary
Date: Fri,  8 Mar 2024 13:44:01 +0100
Message-Id: <20240308124401.1702046-1-linux@rasmusvillemoes.dk>
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

v2: use strpbrk(, " \t\r\n") instead of a loop doing isspace().
Technically not quite equivalent, but much more readable, and it's
quite unlikely anybody has \f or \v or 0xa0 bytes in kernel command
line arguments. Perhaps \r and \n, and maybe even \t, could also be
dropped from that list, but those at least have some chance of
appearing in the wild.

 init/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index e24b0780fdff..3dd630132209 100644
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
@@ -342,8 +342,9 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
 			continue;
 		}
 		xbc_array_for_each_value(vnode, val) {
-			ret = snprintf(buf, rest(buf, end), "%s=\"%s\" ",
-				       xbc_namebuf, val);
+			q = strpbrk(val, " \t\r\n") ? "\"" : "";
+			ret = snprintf(buf, rest(buf, end), "%s=%s%s%s ",
+				       xbc_namebuf, q, val, q);
 			if (ret < 0)
 				return ret;
 			buf += ret;
-- 
2.40.1.1.g1c60b9335d


