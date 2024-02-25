Return-Path: <linux-kernel+bounces-80208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68308862BDC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3011C20F24
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840FF17BDD;
	Sun, 25 Feb 2024 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="YLQteHG0"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B211171BB
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708879668; cv=none; b=EBrbWZix+CfkL2jI+v2QjRk+ylWG3mLOY8aZFO3tnNmh+TqKUEx6+qFfk78TpnUJQQkLOgly8jbdeYbQO/lI6z03jVKU05fBdrQl19aoOB9ikQqXQv6vCNHexXSuqquV1o9Kpghg/tG47WnnCblsxUiZWeOWGiGZyL+ByGFKDaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708879668; c=relaxed/simple;
	bh=uTtibSg+/UOUYSi3/pGHIPNx4aWXwVo0/s7xh39u2tE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UROYA0mvGU//skzouZ8brtzHIpPU7BKcqBBifjNa+Xsh2tE60Yrj292Ik7yGuHo3jxTcJVQqeoku1ZHwqp6SUcB2wkwiBxNjbX/H2Rg/Kh54mjv1JHoqW+sB9PXPMIes3bJfv9k+XP10/evlOuSvMf3AWTFI1Gg9IHnZfjpaBDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=YLQteHG0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3392b045e0aso1979621f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 08:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1708879665; x=1709484465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rGoTBcfq3mD5k8LlJe1+EFjxT25i6dD9A/SEOvVdQCk=;
        b=YLQteHG0fOn1LrAvv9BYh8ERVKE6iB1VG5maynw9wJIFOWvH7SZheuTEu/oH424wlW
         0tcVfMvb8nTml3wdQzc7HRWe/3Xnh5u3c+eN3zezIBD4haFq+kyHRoSf9ek2pdR4+Rzk
         /VqFadeRau1hsnLUQpPjr2sQrzNHJPBxQaU+a+KyBQqEUv2K/gMmsPdwgNjCwlkzCjzm
         8GYWMDSgUpt5Ud8Gu/x8IwHYpsEPMA5L4ypw8aD9Q+JVaO47VRhtwbFmxDDIxIuUJqxi
         2OHJPH41ynhERkBne98hryocxHOCMO7V1ncbQH50e8mgP8iNMBxAZTJ4kJOke9YPyoLo
         AnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708879665; x=1709484465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rGoTBcfq3mD5k8LlJe1+EFjxT25i6dD9A/SEOvVdQCk=;
        b=uzOFCy6QP4FHZpe3mNTh55YrOKyrd3Xy2v1aHykdrch10bw15RzWx26+f3bHDaOmYm
         QcUHUkgU9MTnXzwrhCQQbFLrLALGw/yuAMQRxFEjrPH9OegC8mep+MMgAJUFBp6gzNdV
         gWbhWIqp9/y2dImtKIt3+fEhNu3A2eFH2MVKJZDaFX5FoJ2XIdJ4r+M/Rj+DXIq+EBOb
         uytxOsLJ6qU/cNWCE2ahDyF22ZYNsQhMPSNwkMRTLHIQiyepczQCkVi/NtSmTg5Wwpkj
         TEeeLdoKXMCRApVP5j6XkgcVOiBC0E2E/r3HAUfxM3f4qf3c9h+YGd2+Zz6QnFy2Lo11
         8+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIjmFp0/E6kFHCfYeK9pxGh/rLcyNoYp9gCrNiqH4o6iS2W8h9VW/dzhRi574oCs4IKEXzJdZKvC524/NYlgrzWWbdEJS9/xzl+331
X-Gm-Message-State: AOJu0Yy2AC/vla9TdNClWFrEffw+94tyMv4Er3pZTkhLXMXWhWQTydQA
	2oxWbyefSCyb8D+oUUKSYq0P5j2yexGjCGdZZtZm013S9cpKPshXXYHjbeuZxCI=
X-Google-Smtp-Source: AGHT+IFgA1Whb2PYYXsBd9pEKUSUnAVNE2baSfg12pvf18xrxp10HzkVrSUU46s9AG7YOQeLZi3KNg==
X-Received: by 2002:adf:e745:0:b0:33d:32de:e7b6 with SMTP id c5-20020adfe745000000b0033d32dee7b6mr3213459wrn.26.1708879665221;
        Sun, 25 Feb 2024 08:47:45 -0800 (PST)
Received: from fedora.fritz.box (aftr-82-135-80-35.dynamic.mnet-online.de. [82.135.80.35])
        by smtp.gmail.com with ESMTPSA id v11-20020adff68b000000b0033b278cf5fesm5463809wrp.102.2024.02.25.08.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:47:44 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] tracing: Use div64_u64() instead of do_div()
Date: Sun, 25 Feb 2024 17:45:08 +0100
Message-ID: <20240225164507.232942-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes Coccinelle/coccicheck warnings reported by do_div.cocci.

Compared to do_div(), div64_u64() does not implicitly cast the divisor and
does not unnecessarily calculate the remainder.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/trace/trace_benchmark.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
index 54d5fa35c90a..811b08439406 100644
--- a/kernel/trace/trace_benchmark.c
+++ b/kernel/trace/trace_benchmark.c
@@ -92,7 +92,6 @@ static void trace_do_benchmark(void)
 	bm_total += delta;
 	bm_totalsq += delta * delta;
 
-
 	if (bm_cnt > 1) {
 		/*
 		 * Apply Welford's method to calculate standard deviation:
@@ -105,7 +104,7 @@ static void trace_do_benchmark(void)
 		stddev = 0;
 
 	delta = bm_total;
-	do_div(delta, bm_cnt);
+	delta = div64_u64(delta, bm_cnt);
 	avg = delta;
 
 	if (stddev > 0) {
@@ -127,7 +126,7 @@ static void trace_do_benchmark(void)
 			seed = stddev;
 			if (!last_seed)
 				break;
-			do_div(seed, last_seed);
+			seed = div64_u64(seed, last_seed);
 			seed += last_seed;
 			do_div(seed, 2);
 		} while (i++ < 10 && last_seed != seed);
-- 
2.43.2


