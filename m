Return-Path: <linux-kernel+bounces-93878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CDC87363A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068AE1F2506E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAEF8002A;
	Wed,  6 Mar 2024 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Z/kbMr8T"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663187FBB4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709727901; cv=none; b=UDcVdluVFDpkgQVF4g3w2/keHerbUB9P1bHoBMJqkI1PqRPIppu22SiA8JIptO+y2QocS9AHkRhyUU+GVEC2L7LO5CoAJiIzEtgmzodG52cDdYOAjaxPDxxrWxlXOOQl+9DyXk3DnBjTsZnDWbavXvcqYK2GmHWWGlg2UDVFRic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709727901; c=relaxed/simple;
	bh=8Okp8JRxkiMV0YH6KA8qSv/58IcamZ6z7suvOrup3fk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oq8t5ELnk/Ls/T4Dot7KUgviUhahZpAYpfvH8dvqFag0IVHri1hTw72xwI7KUbXpYnEVSPnfFeQf9DAGUOvxrDNbZmy7VMUn+ReyrQh2ObOjjD2TBEZUqeE5jXEXYZvO2EwDQIE2bzHXfK40TsE89k6swV3ugiuSsbEx3++w3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=Z/kbMr8T; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56454c695e6so1415858a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 04:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1709727897; x=1710332697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TnhgomKEb2hCIMvadWXGuCkjrFe6c2aqwtVVtmkSCVQ=;
        b=Z/kbMr8TjakO8P/RO4YsBcm3AWTqDZCEJGe+Z9ecNvfd8DfTFVTA6bR52fs0GKTsFF
         LBt5AGr6IAhTmZi+mNgaAZJ478Ibxyp2gFsrHkfs6hppfCSYbNMAVcm3MKdFhTYC5swP
         60umqC9WTBwU5c7j29Ew8sum26YNRmAmHs5Sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709727897; x=1710332697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TnhgomKEb2hCIMvadWXGuCkjrFe6c2aqwtVVtmkSCVQ=;
        b=pxPiU16yM8WGMkfRKdrxk1Q92UNL4S8cVCACWSLE3hFrfZgu1ycp0DCE2n+EpWtg6V
         L6EPisg134YOli3aIGA+5diLEc0e2CouO79TPoLX89aJ4SeIKIh9XEz4qotjI5uENV0k
         DbsGHwfJwa0vpGzs4IGVmUnXgHdcEcc7YvCwwJr19UlZahMS7jgsSFlqHitRUBgyC9et
         BsCwRnsyyhVdAi00piuZxLrAMf6dM+eth6dOX0BfdoBvyQ3/oQL7xktwUpxmLVq42HWl
         GriXIt2AHDb4X/xxuhXjazBrbkwUxDbFBsJUIAW84OCF4aWTHiRFyTkwwabwjPLIJwQf
         2OFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjnTmlsJhbAUm68FXAUzaueFfOf52H16OCzd5fWqLOWrdoDueFvRxCZB0sYnsOLAxCXCcuJtSmcMoAd6XDQp1HOhbNWdu+atMQD20n
X-Gm-Message-State: AOJu0YzRQOrfhToFw6vzd40AnlYFRmlXOUjTbVZspPzXHcHdm0x1G9Sm
	zmIu8COdUxV/F43WD4jrGUkErtiuCRJ0urKW5e3LO8E+SarcL/8oLZZi5KniP8qtDE1C83TzFyG
	ej3I=
X-Google-Smtp-Source: AGHT+IEYQOE8fNX1fwnNFoGDCQMUs8PYmUaptl57ojeAbHTGvvGb+3Y3BwKHP7t2ucH+oHLofH/jAQ==
X-Received: by 2002:aa7:db4a:0:b0:565:6b76:3140 with SMTP id n10-20020aa7db4a000000b005656b763140mr5542386edt.18.1709727897279;
        Wed, 06 Mar 2024 04:24:57 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u17-20020a056402111100b0056729e902f7sm4160471edv.56.2024.03.06.04.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 04:24:56 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bootconfig: do not put quotes on cmdline items unless necessary
Date: Wed,  6 Mar 2024 13:24:52 +0100
Message-Id: <20240306122452.1664709-1-linux@rasmusvillemoes.dk>
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
 init/main.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index e24b0780fdff..a658c00a0208 100644
--- a/init/main.c
+++ b/init/main.c
@@ -319,12 +319,20 @@ static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
 
 #define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
 
+static int has_space(const char *v)
+{
+	for (; *v; v++)
+		if (isspace(*v))
+			return 1;
+	return 0;
+}
+
 static int __init xbc_snprint_cmdline(char *buf, size_t size,
 				      struct xbc_node *root)
 {
 	struct xbc_node *knode, *vnode;
 	char *end = buf + size;
-	const char *val;
+	const char *val, *q;
 	int ret;
 
 	xbc_node_for_each_key_value(root, knode, val) {
@@ -342,8 +350,9 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
 			continue;
 		}
 		xbc_array_for_each_value(vnode, val) {
-			ret = snprintf(buf, rest(buf, end), "%s=\"%s\" ",
-				       xbc_namebuf, val);
+			q = has_space(val) ? "\"" : "";
+			ret = snprintf(buf, rest(buf, end), "%s=%s%s%s ",
+				       xbc_namebuf, q, val, q);
 			if (ret < 0)
 				return ret;
 			buf += ret;
-- 
2.40.1.1.g1c60b9335d


