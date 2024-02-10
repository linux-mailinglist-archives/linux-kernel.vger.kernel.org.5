Return-Path: <linux-kernel+bounces-60606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E6E85076F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49FC287B72
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7757B629F4;
	Sat, 10 Feb 2024 23:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TKZ+M8l3"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1163162802
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609071; cv=none; b=F7AZS3H3+mL4yjU0MEVf7aBG/AIVFcx9TOkVVeDRuPkUEMttIHfM1D3Q+6H/XPyDIWGQZAMGl/RZlSQ21NDklLwImiyeioN3R918T/ln3iReWqjyiEFKaKU98QOeCKXXTkBu0CLqAlX9yywVhy9DLM+uZm26h8F9kwggSUWF3Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609071; c=relaxed/simple;
	bh=jg05zPtAl9j/yTZ1g89+XrwMdlHjTcXit8rTUQ5mFfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtFC7tGl9NPqNd3fQyK+4LvdEW/xdmlzP5L+jE754942Ky+QONa9csTqaK8KecoTJE9mxZuHc/jD3+tFDWwHi2OUMwL57ENMLc7DZOxfXKrX9hf2l4oYzkV4IMHjNEtlusuXLqzQty/taPxZ6tQmvdg2BMNS28Ey1CRpg6oCPMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TKZ+M8l3; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5116b2dbd16so1948428e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609068; x=1708213868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFBKfV90tnVCKuDzo1hfvS3bOF2HEydpBXLRzyT1NsA=;
        b=TKZ+M8l3jqCFmiJdbMxuoHcGsdAiwIB7s2LTSrhZIrU4tconuaVdwuGI/wpDquyq3P
         zBFpEJdpbWs/41vhTSIkj5TBN5sjjhrzfruSQnJqxfD+YiARueN9cHjkq1xFL4UfpCAj
         pzQ+qK9cZd7vPu1ETaYHLjgizlSOYYtzjw6ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609068; x=1708213868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFBKfV90tnVCKuDzo1hfvS3bOF2HEydpBXLRzyT1NsA=;
        b=ltSVcnUo3gaffu2LxsBqOY2sWk/zQ7TX83/mbKpB/LcQBLl0k8cWVSsCupvkx8pfY2
         K/p1FxNbnGH0HNXzorKxovOz3NDnoYJrNP7wFqjOlI4qV7pRoxf8Up5BwCeMPywJZ6O0
         U/E+x9q0+/skOeJquwxxg5chaNjm5mAN05r3SBAK5MPRZ5/uHZ5WEXpHMEpFCSxVWLJ1
         zq3T+oKZxQ0Pq8jxU5/2Dxb+e0OZcoH/pbQpJJojNGSjw1+RxrcI/dCft0GZQtAY4KF6
         IDNQfl7uoJercBJfLiJGAw1/3N9aWULNlkKUeHv2KDx0JfcFq3IGrKb53xlhDHSithSs
         ZQNA==
X-Gm-Message-State: AOJu0YytFRi69k8Oj7egFI3yQah43S77T1W7wLWnwNqh+9OJh5hp14Hz
	QYIgt7Dr5YkPKUbCpZNUCJs95+vCaf2geS1u3JlMnxgbb4tJWhDw31eptHqT
X-Google-Smtp-Source: AGHT+IGbybOhszlFxiUz0sUlIz9IYqotDM+OaWMZQkllevNo/5BweLOIqCbwhXu2TnfT01LgkZVJAQ==
X-Received: by 2002:a05:6512:282a:b0:511:7b35:9ba2 with SMTP id cf42-20020a056512282a00b005117b359ba2mr1214823lfb.0.1707609068114;
        Sat, 10 Feb 2024 15:51:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4rfk+26klrsWpzhO0rtSX88PTmmTRwQgnnwezWXQ1kVKVHZL4WhA9+WoWu8qabtVcLE7eaa9eti/qXsWKJV300T6z8WTYnEB4CQH0ic2kl/DbndJ5RAuLDn+3QhlQx6Vix2J6LMWqRljM7ZHI3vLvQzi+bzKg6MwwP4Lc9ANt2t13jEUkwq2doCRCM0NdBckpeK2MC7sc7S9lgRFdY0a2pyxBWVSE0YOr3KJzaFNj8kWeWRNPAElz3q/FaQAYVbOmwN/PmnUExx56gLMaySxBD8pduS61FWQ4oSZimX6hnlNSEn9e9L73RxyHTOM8b1mQ8ZWgy1AcGlJxYJql8PrL2eqEdepClkTRblys83EW4zKmDFL6YiCzrFQdPwMKpuwOuqhl6cvwEGhSN9Lna1P1PGUURvne/pFzCGNTsyKKAnXMyHUVppdJedMChac5jbMepkc2lggiRs1oaxBLpMJEdMg4UqatV9vM4xMJuzo3O/rtVeWaqu5QINhBq0HDUlfVKN2mq8OFFxCD78J717o/8EzhsHZGJTvsdZEQzgPlg1OfWZGwnbNLw9msgz4YpU5GhtDQGi2TLM+pv2rVBjZ8/zBtgHsyxDaSDF5c70AvxKjXIw==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:07 -0800 (PST)
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
Subject: [PATCH v4 23/39] dyndbg: display the bad flag-val in parse-flags err msg
Date: Sun, 11 Feb 2024 00:49:53 +0100
Message-ID: <20240210235009.2405808-24-ukaszb@chromium.org>
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

If ddebug_parse_flags() rejects user input, identify that input value
in the error message.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 4954d3e5be5b..089765afc972 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -973,7 +973,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 
 	/* check flags 1st (last arg) so query is pairs of spec,val */
 	if (ddebug_parse_flags(words[nwords-1], &modifiers)) {
-		pr_err("flags parse failed\n");
+		pr_err("flags parse failed on word-%d: %s\n", nwords-1, words[nwords-1]);
 		goto err;
 	}
 
-- 
2.43.0.687.g38aa6559b0-goog


