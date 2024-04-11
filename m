Return-Path: <linux-kernel+bounces-141441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7868A1E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6671C24BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0640F127E00;
	Thu, 11 Apr 2024 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSq+aVPM"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DEF17742;
	Thu, 11 Apr 2024 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858588; cv=none; b=r7RbEKkjTJPUp8EVn3uLr3hEfVya15AKwp63PQDBkFx/v5jVsdjKqkBG5e9JHzcXI05icxCwqmmByH4d653NXJlw0RjfrG5Kifd+3K+6jbNjzeTpfWjRzyoCqY89y/udWWRtpNDRZYJ6ZljKXyyZ41doj5wfDOnl0sIZv3MJMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858588; c=relaxed/simple;
	bh=fY6ZrtT0wEjM81uJX8k4A11r5G0WTY0AVXLPNubw9eU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FvUPteWGIYmKk/p8Sf1iuTlS2GHsk6mVGeN2L3FkXF+HAzWRUJFsEREs9JLK7Ol9atcEu13iegLGsgkpI24CMbs5MyrDpDNNQ5j+JFYrNkpMZgly77/lLG0N9VhKeoR24DrllfABfhENzGp7Na28oAMlF+kR1HUX1hzmgWjI0hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSq+aVPM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4715991c32so8840166b.1;
        Thu, 11 Apr 2024 11:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712858581; x=1713463381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KeQuB+ybvKFgAhoUjZAJOtNjxZCBfqsemY8EjGJIE+Q=;
        b=NSq+aVPMrdC/ilzTlZj4gwzT9IihPZ2WWiRkDnAYm8qxDf+S0egfyqQKXkpYcIlMhc
         x7cVpzXl88uo7kM7JCmKkKKpr7b8q8gRV8eILNL72bDa33l9ZqzwPeA7d2U/cfs3UiDD
         8B82RfxnezCKyQ9oKsnLeGLhqX5o3xl+Sa+ewS6Jt5CPo+qi1yfOYqwwzTvxutO+e48V
         N8NLkUHU3OHnbCokYjWu4yAHHTe8ncMrvP7/oBLhT9rJjtkEw5KgR3p4bNxpCufQZu4m
         YSc5zNr06zKA+3ECw1f3FMm9m3QkSaL+yxItOya3Ubs7/RPPlxYENRa/nwadwNvB8kOh
         uzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858581; x=1713463381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeQuB+ybvKFgAhoUjZAJOtNjxZCBfqsemY8EjGJIE+Q=;
        b=wDRjKDVf/C+6Fmg/meI2H6tfi5RrUfs4f3LFWaTGcz1YOU3i6k4cg5ZdnRWK9jSDGt
         +SA16sEHF36xtbMkACra+JUGwvlBbcu7JnHL9yTUcqIr7iSIa64ui70i994Bx/WqmOYf
         Z3LBmieh8Aak3mpjgW8bgxDstqytYR2REzXGcfsIP08TwAIkpdU4ClPidtukPXZl0Exm
         qaL4T8w0Xr+agXkSDbhmNlQLbgpOsiQjK48/AaFYhyK+Wlww+r4kCfICe+pCxQ1BUEbs
         Dwo5WRes/+HuijPGThJ13r6ikmgKEQtk3IQjoW3sAf69tfEO7vOYDMH1b/geBzE71+A5
         vK/A==
X-Forwarded-Encrypted: i=1; AJvYcCXwJpXMFP2NOjYLQWEw7X0q55pIQUW8ygu7nNkYpdiHrG7q7H7yhyLcI/ekoiIBMbilQthzWzzAEdtNKSIBX3+rLfHCPxqYP4/zV9hZf5D3alxmNmZLGzBDKL3JCjzuYWKlbMMucJa02Sfx
X-Gm-Message-State: AOJu0Yyph1j5nKxHheEBH0fnRkhuZLKhLWf7VXxnmlK3LcISylR75XLr
	W8jgcwk0zDRphgNEgYl2jd8m/tqM+xhvXVN2GY1eKradJwUBUM8i
X-Google-Smtp-Source: AGHT+IGbeZ3/8FT6qIHPTK7/LfF3+DTGX4Vc+yK237mOH/HtDpe/Hebs0nbm36ZfTKXQTMzEpM+odw==
X-Received: by 2002:a17:906:254c:b0:a51:a06e:afd1 with SMTP id j12-20020a170906254c00b00a51a06eafd1mr297082ejb.23.1712858581048;
        Thu, 11 Apr 2024 11:03:01 -0700 (PDT)
Received: from localhost.localdomain (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id hg18-20020a1709072cd200b00a4df5e48d11sm976011ejc.72.2024.04.11.11.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 11:03:00 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	Julia.Lawall@inria.fr,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Roman Storozhenko <romeusmeister@gmail.com>
Subject: [PATCH] sysrq: Auto release device node using __free attribute
Date: Thu, 11 Apr 2024 20:02:56 +0200
Message-Id: <20240411180256.61001-1-romeusmeister@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a cleanup function attribute '__free(device_node)' to the device node
pointer initialization statement and remove the pairing cleanup function
call of 'of_node_put' at the end of the function.
The '_free()' attrubute is introduced by scope-based resource management
in-kernel framework implemented in 'cleanup.h'. A pointer marked with
'__free()' attribute makes a compiler insert a cleanup function call
to the places where the pointer goes out of the scope. This feature
allows to get rid of manual cleanup function calls.

Suggested-by: Julia.Lawall <Julia.Lawall@inria.fr>
Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
This patch targets the next tree:
tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
tag: next-20240411
---
 drivers/tty/sysrq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 02217e3c916b..1d1261f618c0 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -758,11 +758,12 @@ static void sysrq_detect_reset_sequence(struct sysrq_state *state,
 static void sysrq_of_get_keyreset_config(void)
 {
 	u32 key;
-	struct device_node *np;
 	struct property *prop;
 	const __be32 *p;
 
-	np = of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
+	struct device_node *np __free(device_node) =
+		of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
+
 	if (!np) {
 		pr_debug("No sysrq node found");
 		return;
@@ -781,8 +782,6 @@ static void sysrq_of_get_keyreset_config(void)
 
 	/* Get reset timeout if any. */
 	of_property_read_u32(np, "timeout-ms", &sysrq_reset_downtime_ms);
-
-	of_node_put(np);
 }
 #else
 static void sysrq_of_get_keyreset_config(void)
-- 
2.34.1


