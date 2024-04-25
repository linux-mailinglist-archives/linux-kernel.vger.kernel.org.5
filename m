Return-Path: <linux-kernel+bounces-158055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECBE8B1ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1219B1F22F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240583EA9B;
	Thu, 25 Apr 2024 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehncrRY8"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB4927473;
	Thu, 25 Apr 2024 06:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025660; cv=none; b=i7kTpgoeKfhO8NGaX+rve9k/jj0peSPIydU0O0afBBgrz0kpMOHNzhpE7emN54x+oC3P77tQuG2n8vhnoqCeeWuJf8bSc7z9UjQvH2UCawdp6k39AXk7dVRJtQ/8UKyy17Iqv8ierBlcy1UVUjlw4gcwUwYBWRd4l41TWPbIRJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025660; c=relaxed/simple;
	bh=CRrjSsRbZZXBe3Zg1o6lhtldh9D/juwsek3Ag08YBpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CuLhyDboeArDaSxSuzKQPQX5gqU+X4GyP8p62u30wnSKuLvwEBhPo3iVNlvsMUtJnsOcO2xAuDEQfBpBjI05fbvUD7BpC769Ngk3EwT0txffL86C4kd/unepNF3+sX1Y13OsKIOJueSM+cgX20wcKya3VwdTpfF/Hb+esO+1HPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehncrRY8; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6082fd3e96eso481777a12.1;
        Wed, 24 Apr 2024 23:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714025658; x=1714630458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P+cnrqP7ROZMYIZmqn7REt8CdXQIz/KakKw0fvi+u8k=;
        b=ehncrRY8cmRafg0ysC+haERsyOjzcUwJmQpLoxvqi6sQR4GB3HOJ3dox8TX3Rrmo4D
         lKQSpSsYiJta6+RA7OVjuNp02j3YE31zRuUQnoXberqwhvraTtyGcGFp8c655GmAf9Is
         0ZsEbqZU2AfCQF/gmIn9RDV7DwjJEQMhWnzcVhbgocq1nxRXIXkvbT1nsRE2h4+WPkrC
         +Lz/Df3DldSfpcBJjoGJXsH/VtO9CsOoi0FZ03oMB5La5qk2xo5uc99YPZ0dp1WxsPTa
         /jvj7RfSfwQtLVhyR0D3gelu22vl6ltAgrJwplSq5cUdQywc5SNol+XcgzBpugtW2zof
         avXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714025658; x=1714630458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+cnrqP7ROZMYIZmqn7REt8CdXQIz/KakKw0fvi+u8k=;
        b=ftT5qiPu3qsGWvAIS298DsK9geOKVp9QgqPt8vbFSJgnl4zrEv3DVYgBW4c/JgASHE
         SnTZ3KB7brL/ky52PwRxViuRwwuy/DlqnpZqBy4zdqHexNlTtFQgAMdSiOhPHuHeztRn
         7z3K13ypmuPj8HvhHArhL/wD0cb9ee7cYa2uIsKAzpo1Br4DYE1fUQbB3WckHoPxenzA
         UN5xPtVqrncwEjtxCSTWSp2rzH7fa/48dAiPKKyQn1EFKSrFNVUS5IMjK/SzlvfynU6D
         5zA/aBAO8ieJdgTd7JpiFK7ODmqgYcP/VDVfolP4Ki8I5CW452OVi8QMgnvO4MU6+8fR
         xu/A==
X-Forwarded-Encrypted: i=1; AJvYcCWnWmaj0mV0/9u5nsQ6LqQf3i8Pdv7/4FesoKqswhTw4mEQPhwmzdSAbpVi3Ovq9DdiWngI+eYKAReC4II+AW+q2qxcqw+z2pS20Zy/HET3Jm22SBRFXLhxr746CiKw5uVS1aQl4qhDpakM
X-Gm-Message-State: AOJu0YzFQQOqzna6Y0oFtUf9o7BEbEdSRDUlE26Qm7LK03WjnxZpflih
	CcPPSjYC0PK+SPgNQqrIqOLpRaC+e4d1B1311OmAhRSVatONkipW2FmKZxYw
X-Google-Smtp-Source: AGHT+IHs42AUj8gwluZCiYM0AKuesrQTubnz7h1dTGYRvbTsCK1ahmnIaAw4hwETEPrlhp7SKP1wKw==
X-Received: by 2002:a05:6a20:7285:b0:1a7:5402:8a92 with SMTP id o5-20020a056a20728500b001a754028a92mr5639944pzk.31.1714025658299;
        Wed, 24 Apr 2024 23:14:18 -0700 (PDT)
Received: from shresth-aspirea71576g.abesec.ac.in ([139.5.197.146])
        by smtp.gmail.com with ESMTPSA id r6-20020a17090a5c8600b002ade3490b4asm6461667pji.22.2024.04.24.23.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 23:14:17 -0700 (PDT)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: davem@davemloft.net,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH][next] tty: sunsu: Simplify device_node cleanup by using __free
Date: Thu, 25 Apr 2024 11:33:04 +0530
Message-ID: <20240425060303.8045-2-shresthprasad7@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add `__free` function attribute to `ap` and `match` pointer
initialisations which ensure that the pointers are freed as soon as they
go out of scope, thus removing the need to manually free them using
`of_node_put`.

This also removes the need for the `goto` statement and the `rc`
variable.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
---
 drivers/tty/serial/sunsu.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 67a5fc70bb4b..0f463da5e7ce 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1382,44 +1382,29 @@ static inline struct console *SUNSU_CONSOLE(void)
 
 static enum su_type su_get_type(struct device_node *dp)
 {
-	struct device_node *ap = of_find_node_by_path("/aliases");
-	enum su_type rc = SU_PORT_PORT;
+	struct device_node *ap __free(device_node) =
+			    of_find_node_by_path("/aliases");
 
 	if (ap) {
 		const char *keyb = of_get_property(ap, "keyboard", NULL);
 		const char *ms = of_get_property(ap, "mouse", NULL);
-		struct device_node *match;
 
 		if (keyb) {
-			match = of_find_node_by_path(keyb);
+			struct device_node *match __free(device_node) =
+					    of_find_node_by_path(keyb);
 
-			/*
-			 * The pointer is used as an identifier not
-			 * as a pointer, we can drop the refcount on
-			 * the of__node immediately after getting it.
-			 */
-			of_node_put(match);
-
-			if (dp == match) {
-				rc = SU_PORT_KBD;
-				goto out;
-			}
+			if (dp == match)
+				return SU_PORT_KBD;
 		}
 		if (ms) {
-			match = of_find_node_by_path(ms);
+			struct device_node *match __free(device_node) =
+					    of_find_node_by_path(ms);
 
-			of_node_put(match);
-
-			if (dp == match) {
-				rc = SU_PORT_MS;
-				goto out;
-			}
+			if (dp == match)
+				return SU_PORT_MS;
 		}
 	}
-
-out:
-	of_node_put(ap);
-	return rc;
+	return SU_PORT_PORT;
 }
 
 static int su_probe(struct platform_device *op)
-- 
2.44.0


