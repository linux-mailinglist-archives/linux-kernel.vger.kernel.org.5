Return-Path: <linux-kernel+bounces-60605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E3085076E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12C32876CB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D706C62813;
	Sat, 10 Feb 2024 23:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F0yf/GS5"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4669E627E7
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609070; cv=none; b=h0wK5FHbEJuwDy7YmegulSgv80yef4STdCE3eiN/YeRepBYAVo/5NgExaoIJX2z5mRw5K+wCEuqL8iC9aovxgUZJpd1ieGZNbOuYhKVm83Lf/S7J0ttaEn0CUI1Tdogj8+c+zUsnzOrA2q1u/l/0hd+sorRbDLcehMl0NxEA9ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609070; c=relaxed/simple;
	bh=e2HkgHzrnxkaozeso9X8OpimgMJwsOA48wio9rSEU5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erG+UoVW7c7v3FiAyAjCnjIhg5Sa31w4rugMFNTSBliAzA/WEXb6GtyxMVvOe6XH1aYqFzjVP1FftickXKUgn1mgWTLMBDfj7EqAej0Hd+M/sbTqQ4PYrlJ/CYckFcNpQ2yXRDM5G06bBBn1a8nZrXFAyVGmE29F9GjQWmRtbos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F0yf/GS5; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5116bf4dcf4so2602396e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609066; x=1708213866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ns2ZlXdsr7Utv/ToBSlS0u0tX/sChblP3BD9+95vrrw=;
        b=F0yf/GS5FIAwigHoSFmBwrq9a76GZT5vN2oWhFmpTJnsnHO+LVXK2pSQmWoaJ6/Uh6
         xZzaL2fqJUTDN4szltM4ruZIkAMNJ65NHc7CQjyMqXP3PM8qqh0GVkBqpVDkvtQFeBw7
         ISuLWsRBeZ5s/PHz6CXHAby7dvdjkWtXr9VwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609066; x=1708213866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ns2ZlXdsr7Utv/ToBSlS0u0tX/sChblP3BD9+95vrrw=;
        b=BLMbA/tT0wJd/PCvunEheVFjEfTsVnNEYurMoEOpVdF+FVajpn4RzXSfaFyznv0hq3
         Gy+den/nRYYY9fNDrGAh8CLzNr1X9kQTlvxqS7xr7Ix0bNsaGl3xggarWznXS472ZdVj
         mzD3Kp0E5DOiC7Lgp5BeVDRonqpj9vCaOBWf9ydzcVvOKxKgzPB0U1eTFOW3pup3gSna
         NM+eKRRV60let9Wj6DsfWKTV2ABfv55tROPPI/5xNiSXHPgtSP3+wisZKT8yjsAVEDMk
         OKCQAc5HBpascViJqWEULVUIIfFMEGd+16g5sfg7AJyvV0PYWTeTSfPR4ptouqStaXlr
         tICQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrPaO4z/xqcg6lWyH9mepWyyvFcZsfXeo57Swh2p2L2JTnlz6HNTTUGHkuXNGzmLvNCQSLzBtHpmJabf5SPLG9Q5YLgt81IVsDgDVv
X-Gm-Message-State: AOJu0YzAlrPmiImDBDR2E8R1eAcG6bwxr4Ghl0lAd4zqnEZea6iVFECT
	Ansrfc3F2v7XkOKRn8vKIFttJpd7pQvicIyQuqCQ2EueAyIpFLHwp2zAmB0l
X-Google-Smtp-Source: AGHT+IH4oO3eCnfauS3SZj6nSiwdZTTJi+hQ1vo+gTka0ULmwyAyWUFi5iYL2vb6DFj/bsPnc7YeRw==
X-Received: by 2002:ac2:5924:0:b0:511:312d:6761 with SMTP id v4-20020ac25924000000b00511312d6761mr1882020lfi.47.1707609066447;
        Sat, 10 Feb 2024 15:51:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWz2FwLx9omz+tWms88s4OYHo/O8PSui851Mih+LNW5OyhYTV3MwgvMWwjdnA96xAXAB2gx7x0KPy/06Kd90Q3zQcy09AzjVPmihWjg6EcM9SMPoWdTxQZz3YrudbSkYPmtG1KzqpRJy3T/wuXP3UaNMPaMBhtkUpPo1hAWmKxdb7vJgKD7quoqRycte4VTZOAmbLseN4WwBNNgQHD1Dsizj7h3Zmc6+CHu81p0eoBgztQ9sbofkspX4g4OTo0h0x2zHyoHHwilz3yPmiiuImi9qYaKl0V/JcEt8z5NJVrPDCOvCuNhwg08svpNp4e1gmVkxtFpq7Jv5xPkc0t8zaNFIlUDfr/ELTBVMZ57fxKg5vNX5h252eXes9r9GeLN47tkfsOTtPwx4dpJrR64+esSytnY4w7ydjHpDKaFe0azEWHxMqYwSdKi0gDoJ2WPufrLTuE87tQTXNsf7OFRiHt9IBYCgL7JBMGLqI9BzP+dprkcQcLU9Eqa4yo/J7KtWhdTSVfZVAob9fMJPvmiyWAomKm3L3lW6se3lCf+hT1uF9vaB7OkpWXsimpK4PCgBHWFqnSoVZ83xb7xqJFu749k7dXzT5MsywJKu+29rmVBh6C2LA==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:06 -0800 (PST)
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
To: Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Guenter Roeck <groeck@google.com>,
	Yaniv Tzoreff <yanivt@google.com>,
	Benson Leung <bleung@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Sean Paul <seanpaul@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Simon Ser <contact@emersion.fr>,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	linux-kernel@vger.kernel.org,
	upstream@semihalf.com
Subject: [PATCH v4 22/39] dyndbg: reduce verbose/debug clutter
Date: Sun, 11 Feb 2024 00:49:52 +0100
Message-ID: <20240210235009.2405808-23-ukaszb@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240210235009.2405808-1-ukaszb@chromium.org>
References: <20240210235009.2405808-1-ukaszb@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jim Cromie <jim.cromie@gmail.com>

currently, for verbose=3, these are logged for each query

 dyndbg: query 0: <class DRM_UT_CORE +p> mod: <*>
 dyndbg: split into words: "class" "DRM_UT_CORE" "+p"
 dyndbg: op='+'
 dyndbg: flags=0x1
 dyndbg: *flagsp=0x1 *maskp=0xffffffff
 dyndbg: parsed: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: no matches for query
 dyndbg: no-match: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: processed 1 queries, with 0 matches, 0 errs

That is excessive, so this patch shrinks it to 4 lines:

 dyndbg: query 0: <class D2_CORE +T:foo > on module: <*>
 dyndbg: split into words: "class" "D2_CORE" "+T:foo"
 dyndbg: op='+' flags=0x40 maskp=0xffffffff trace_dest=0x0
 dyndbg: applied: func="" file="" module="" format="" lineno=0-0 class=...

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a6c6392cde3e..4954d3e5be5b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -871,7 +871,6 @@ static int ddebug_parse_query(char *words[], int nwords,
 		 */
 		query->module = modname;
 
-	vpr_info_dq(query, "parsed");
 	return 0;
 }
 
@@ -896,7 +895,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -916,7 +914,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x, trace_dest=0x%x\n", modifiers->flags, modifiers->trace_dst);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -933,8 +930,8 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		break;
 	}
 
-	v3pr_info("flags=0x%x mask=0x%x, trace_dest=0x%x\n",
-		  modifiers->flags, modifiers->mask, modifiers->trace_dst);
+	v3pr_info("op='%c' flags=0x%x mask=0x%x trace_dest=0x%x\n",
+		  op, modifiers->flags, modifiers->mask, modifiers->trace_dst);
 
 	return 0;
 }
-- 
2.43.0.687.g38aa6559b0-goog


