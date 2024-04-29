Return-Path: <linux-kernel+bounces-162923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBA78B624A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9041C214F3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D3C13D60E;
	Mon, 29 Apr 2024 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/eFqaCk"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEDB13D25F;
	Mon, 29 Apr 2024 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419146; cv=none; b=Rj7JsnYrd3mtACmRc7uKDyWqNrf58VqCjbuJtY1KxENhfcyaiS7VL2Gvrxk1YtXwY9eldzzNT8j6RqcgXEnPmFTWZQldv9EyHAFRLBUvCOXDbNkCdJxevMYAzT5PwAiNiv+n1ZGMv98gXyH71XtqFZfWtnpyuieI28w0KhwCu/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419146; c=relaxed/simple;
	bh=KYV1o4Fl2vjpH7kTazPcNAEuCJiqPiwXlYmjhO4dm7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZTVj+hk3LawA3Szd1rSqizXQRRGX0zX+yER2a53eE0W6lMLwg5euLjvrcPfMUhaUme6eovmGjXedtkoLgqlzvZNwdHF7i9M3wtVhpAc4vbNuEXM8CTUyGseaXTrVvS/iSUvNICkO4j63UjJ2IALlTEMDr29GKYZSGXhwcJ4f88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/eFqaCk; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7deb424da41so138371339f.1;
        Mon, 29 Apr 2024 12:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419144; x=1715023944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMzYxLrk1uqdLdUeUsWli3XNHzvndTERg2zJwX54xCw=;
        b=K/eFqaCk9JDNKmhv/lG2aERxNHVKotu0fRvcgFLLGRxnGJUkbRYt6fkE9frM0f+vu+
         u0L7dftOCFJ3VYm5Uy50NIQRTiNoamgQgDebAwXwD4O8Vfcj5J/8zvCT/rZ3FSh2n2HY
         d9RGBS2+1dW3nRbmf1CjW6dbAXfPWCqPgUJp6U0DwNmlLQDHhAtmpYATZ9MqtIKK7kCk
         YLFIYIDiahLkSgoK+buH5JqHoyyjlGQxzv6aJQAjrxG/KEpvQ+40wmTIk1mtCjtsiIP+
         3lv6OFqDuVO1FwLqA33IMQJKlD3iIx6IEYS1xe/pfsnKIbNaGvIjgVescCjXaeEydPv3
         9itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419144; x=1715023944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMzYxLrk1uqdLdUeUsWli3XNHzvndTERg2zJwX54xCw=;
        b=orIfOcRt+ipqrXoM1BDdqtGgyeVDjjJZFVn86bdlA2ZVQWyX2aA7W1SSEkLPUasmSE
         gyb2c9z5Bwu241oB3fHXYlcRS2e0+9gEnfVe68QEHo/Sus9yV2pXn3y7Kbii+RawfA5I
         2wfvoIUBpoWADhC6tJ3zfl1pI1giR2I+JKLc3aZtTjVXeQUmy8OXSS+SQK+reUEO+mWU
         p6RyMmwEMDQvZ+ourKOCnkB/omYa6tkAUt+B59uHHpMc7OqdStgky1N8gkJTRYsBVT+J
         j2YJTIO8SZzS4DnoXj0+epE3Rs8YCI/d+Z7IfgRkoOiI6RZ0R5jf/Dw0VNKxE+kmGUTh
         zmdw==
X-Forwarded-Encrypted: i=1; AJvYcCWhl4BTr8B+daqCuXSH8jlU/GEj4bnmlzsw3IxNjecccCm/1rsw8JAL1MD1LB64YKJZIcQP2y037VXLww+M6So1cXI9M/WPOwBkfZiXdirHvlGM0R3/ILInWKr+VSetVLWlAbzl6SlU
X-Gm-Message-State: AOJu0Yzpzw7eCvkfE1BrkTO0EuDWs9S4YKimcrZTM7/8HXisR/6tde4e
	z+eU+DUH5M+WuqRScasiP5DSnPORRfihgz0YAwIFG6nGTm9HZycG
X-Google-Smtp-Source: AGHT+IEM7xw/zU89y+PDQLqPNs+od4nIfUgSCC7WoiOktyCN7c7AVwtLzs+QmgS8y2hAIEBQYnMVNw==
X-Received: by 2002:a05:6602:275a:b0:7de:d935:de0a with SMTP id b26-20020a056602275a00b007ded935de0amr1619647ioe.0.1714419144239;
        Mon, 29 Apr 2024 12:32:24 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id dq18-20020a0566021b9200b007d5ec9b77aesm5988402iob.51.2024.04.29.12.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:32:23 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: ukaszb@chromium.org,
	linux-doc@vger.kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 10/35] dyndbg: reduce verbose/debug clutter
Date: Mon, 29 Apr 2024 13:31:20 -0600
Message-ID: <20240429193145.66543-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429193145.66543-1-jim.cromie@gmail.com>
References: <20240429193145.66543-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

currently, for verbose=3, these are logged (blank lines for clarity):

 dyndbg: query 0: "class DRM_UT_CORE +p" mod:*
 dyndbg: split into words: "class" "DRM_UT_CORE" "+p"

 dyndbg: op='+'
 dyndbg: flags=0x1
 dyndbg: *flagsp=0x1 *maskp=0xffffffff

 dyndbg: parsed: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: no matches for query
 dyndbg: no-match: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: processed 1 queries, with 0 matches, 0 errs

That is excessive, so this patch:
 - shrinks 3 lines of 2nd stanza to single line
 - drops 1st 2 lines of 3rd stanza
   3rd line is like 1st, with result, not procedure.
   2nd line is just status, retold in 4th, with more info.

New output:

 dyndbg: query 0: "class DRM_UT_CORE +p" mod:*
 dyndbg: split into words: "class" "DRM_UT_CORE" "+p"
 dyndbg: op='+' flags=0x1 *flagsp=0x1 *maskp=0xffffffff
 dyndbg: no-match: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: processed 1 queries, with 0 matches, 0 errs

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 4a48f830507f..368381dbd266 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -266,9 +266,6 @@ static int ddebug_change(const struct ddebug_query *query,
 	}
 	mutex_unlock(&ddebug_lock);
 
-	if (!nfound && verbose)
-		pr_info("no matches for query\n");
-
 	return nfound;
 }
 
@@ -501,7 +498,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -515,7 +511,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x\n", modifiers->flags);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -531,7 +526,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	v3pr_info("op='%c' flags=0x%x maskp=0x%x\n", op, modifiers->flags, modifiers->mask);
 
 	return 0;
 }
@@ -541,7 +536,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
 #define MAXWORDS 9
-	int nwords, nfound;
+	int nwords;
 	char *words[MAXWORDS];
 
 	nwords = ddebug_tokenize(query_string, words, MAXWORDS);
@@ -559,10 +554,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, &modifiers);
-	vpr_info_dq(&query, nfound ? "applied" : "no-match");
-
-	return nfound;
+	return ddebug_change(&query, &modifiers);
 }
 
 /* handle multiple queries in query string, continue on error, return
-- 
2.44.0


