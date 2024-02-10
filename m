Return-Path: <linux-kernel+bounces-60598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE933850767
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6352C1F2197B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9DD612D5;
	Sat, 10 Feb 2024 23:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FEuo4wYp"
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70760ED8
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609057; cv=none; b=TX2LhWQ3lZbVgCBPhX88m8ILwAAjVac9oz5x64CHnfAfJ9qGl1cZHxkSAsHLuGPLkVa/Cdyk3qo2VT/8YROZbdUe9jvU+z1PRHlgiP8rcOxQFal5yeZ9/w9TGkYo32Lh2uesW7CcJkJ5/eQLuCdgMeTRk/dB6t9UTcGSu+fz5q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609057; c=relaxed/simple;
	bh=ohE6vU5kodAgmE00a94Fey2CKuwVGGZlFNzAOgDt1Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2OWdD0ymtW0Oecbh65ZvhkuagMFeT/nb1zpVH0ee1+zIUdOVCn2+EAH3u8HEP+zQHWaqVgrYZPqmI9tA18V3IUZYNX0UPFMk89Uy2JISiu4XrUAyy2JRIYqaNF2fW/pYDZaL/4rlU4bYBCCGRxinj0k89il5l93Edckg92BntQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FEuo4wYp; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-51167e470f7so2650927e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609054; x=1708213854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhSJOrwG0vPx3/FWw5xBrBZ2OkHe0Kqn1x7V968tGh8=;
        b=FEuo4wYpS8rla2cWJKPp6UE+l+B9u8gvZxjSDlRiDTuWeW6OgPIn0R4nY3Cb8uHKXz
         UJGlrg8CVeHH3PapjJcDzL0qTss4+4D4I6bxPPLByBAbxRIqgFi38ptVWH2LnFETxvEB
         3xb/g8fZShy9CBDcTSlc5lhB7dWlP6yNF0Gw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609054; x=1708213854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhSJOrwG0vPx3/FWw5xBrBZ2OkHe0Kqn1x7V968tGh8=;
        b=VxK6WyqiGMjIyrT0laExWD/0KJ/plncE43mIyE1A5663flwVbpTV4T4ul2bpgDw7z4
         dyQLP1ngvae6diZMoDhR8npSRKIC/eC8iE938fEL/zoO3VCOxd/BcW0RVuH1bylZAV/s
         wWqczo9vLngQaWarnWnn704aODYyvAkdgAKOxhajT/5ySoaF8ZiaTOfrvEWDHI5ANehU
         4HmCo5Amgjcsc3xOX1/SY8Axo5hBC3/hxpEZMjUHSMbPEs28PpA6y9rk04S7LTDV0o5B
         KJXDUr+GALU9jcP77HrNUF/KTg6gda2uoIG0gnUC5GWGPDt274TKM1jSfw0oAWVa7ATe
         8bQw==
X-Gm-Message-State: AOJu0Yx9Xd7/+jFSzTzhdjRrHJGQhs/3JjTgiofFlyX+4rNzMqm8okEj
	WN5VLr/Nk9jrIwNkCOdySR/8MKZbk99dMY2QHFQD0bEgymkg2S88YNtaMmkm
X-Google-Smtp-Source: AGHT+IGu6Qu/0GalhQgiRzfCPrYXdbSwq+Pd+Xbv4UZUgM2z0+0cmIas7OsRtYtMidkr5bXpoZi+yw==
X-Received: by 2002:a05:6512:3f7:b0:511:8697:c66a with SMTP id n23-20020a05651203f700b005118697c66amr741665lfq.31.1707609054364;
        Sat, 10 Feb 2024 15:50:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWjjmGHSLBbQRDcbxOiGOhju/B6TdFQLxsbySRXM0XJrf6IuBtPEYUoAyCJRsZuLnU7z5N0XkTmoXGNIU8rd1qCHUIICWd36lpwMMMTdFUURd9HXm7PE5jZUE9Wx7I55RAYsBoURRS/W//1kRudDG7P4HM87sWZcAVUd50kYCXRVxZHh2TmhYQR1s9SRAt+/VEAg8bGBj6wwl6GmMKkZTBUTfgjj8L+le0lQ3v819uY5fIUcQnHBK0lT/60BddaYVyZnhtlghfx+Bs4rLDgfi1N88gtJO9Tkx6YIhBVs7sfX3MaEXehzTHyCdOxZ4xXi38lrYwAqKNq8fCGaRbrS6DmSZ7pLr9bKU6PxttxHRJ6j9dcExuPuvxeUKmiQfKly8mzwtUEMOWe2R8dcWuSChVA3jZmP9OmOagWGyab7CzMOD7WfxEoRUa7Lv21gmgM/uqwN12epL/6kvVJ8Avz+0OvQZVqhJKCRUV86Njn3M5eFsj8g08iQaSNcVcOx4A2lyMOWAdeSqI17oJ26LUzWUfXzonfR+V7QR1nrT4ubGCX6jrElNaX9t+SFwcxaHnvgCZ2RzTn6qMigZsvUxZq9lNjqZfMUFrzc8zxZ5ki+G3PjACF2Q==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:50:54 -0800 (PST)
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
Subject: [PATCH v4 15/39] dyndbg: update selection of trace destination
Date: Sun, 11 Feb 2024 00:49:45 +0100
Message-ID: <20240210235009.2405808-16-ukaszb@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240210235009.2405808-1-ukaszb@chromium.org>
References: <20240210235009.2405808-1-ukaszb@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If callsite's current trace destination is '0' and user provided T flag
without trace destination name then set callsite's trace destination to
default trace destination. If a user provided trace destination name
:trace_dest_name with or without T flag then set callsite's trace
destination to the provided name. Otherwise keep callsite's current
trace destination.

The change main purpose is to preserve trace destination names (different
from '0') set previously by a user which can be later enabled with
'label' keyword.

Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 lib/dynamic_debug.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f91c51234456..172497954e00 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -480,6 +480,27 @@ void update_tr_dst(const struct _ddebug *desc, const struct dd_ctrl *nctrl)
 		trc_tbl.buf[ndst].use_cnt++;
 }
 
+
+/*
+ * Selects trace destination. If callsite's current trace destination is '0'
+ * and user provided T flag without trace destination name then set callsite's
+ * trace destination to default trace destination. If a user provided trace
+ * destination name :trace_dest_name with or without T flag then set callsite's
+ * trace destination to the provided name. Otherwise keep callsite's current
+ * trace destination.
+ */
+static int select_tr_dst(struct flag_settings *modifiers, int cur_dst)
+{
+	if (!cur_dst && modifiers->flags & _DPRINTK_FLAGS_TRACE &&
+	    modifiers->trace_dst == DST_NOT_SET)
+		return trc_tbl.default_dst;
+
+	if (modifiers->trace_dst >= 0)
+		return modifiers->trace_dst;
+
+	return cur_dst;
+}
+
 static int ddebug_parse_cmd(char *words[], int nwords)
 {
 	if (nwords != 1)
@@ -590,8 +611,7 @@ static int ddebug_change(const struct ddebug_query *query,
 			nfound++;
 
 			nctrl.flags = (get_flags(dp) & modifiers->mask) | modifiers->flags;
-			nctrl.trace_dst = modifiers->trace_dst == DST_NOT_SET ?
-				get_trace_dst(dp) : modifiers->trace_dst;
+			nctrl.trace_dst = select_tr_dst(modifiers, get_trace_dst(dp));
 			if (!memcmp(&nctrl, get_ctrl(dp), sizeof(nctrl)))
 				continue;
 #ifdef CONFIG_JUMP_LABEL
@@ -881,10 +901,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		break;
 	}
 
-	if (modifiers->flags & _DPRINTK_FLAGS_TRACE &&
-	    modifiers->trace_dst == DST_NOT_SET)
-		modifiers->trace_dst = trc_tbl.default_dst;
-
 	v3pr_info("flags=0x%x mask=0x%x, trace_dest=0x%x\n",
 		  modifiers->flags, modifiers->mask, modifiers->trace_dst);
 
-- 
2.43.0.687.g38aa6559b0-goog


