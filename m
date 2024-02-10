Return-Path: <linux-kernel+bounces-60585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCB285075A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96CE1F23D65
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEF46025E;
	Sat, 10 Feb 2024 23:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N+15cEnr"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CCA5FF0C
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609036; cv=none; b=R11n0k3igrET7zGAhNBmezplVTFF1HuZB/dGAHZgpxfF2FLHEk36Cqzy4tL5SSpOlQux6y2zYdfDxOhRkg4tV8K51IWm/z9jVXOfoNE4rWPXYYFzZS71lyzndh19Kzi5ptn1eNecUIXFkvMFGYDis5LBVdyxbDInblvXb4q9e/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609036; c=relaxed/simple;
	bh=cQmyob+SZ2xtIRHDID5i37Q2ZrwCWWtVkuImLDQlG8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUvXHbzxsZNzhFxzlGUg0ShckNPjUf6c9MF9fkgKtLLYoxyaojQeJGpOrmL/kRm5Xd7lb8wQND6Uaugr4Xj5TH3X3idsScpNEMMglkIHSpkzS9hLdzYeQPWy4K3olETZ28JQBfiZZSBgVXppu7BOZvXBzZhElVKAVX+duq68g4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N+15cEnr; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5116b540163so3090535e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609033; x=1708213833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiwuT5//sOCIH4TJbmBqDDmgy+L0dj/76G1O/T9yDvA=;
        b=N+15cEnrjnrGkuG/+gzqPPtnfaYDFcsLqv2DRmf14bpgwzKDbU/KgWDw+JT7kJRM8w
         nCLqp9l8BMhJuNrPFQZ8SEnyub5I+nqliOriEANIMhv/vYftT8gry+ZI4S4n4M3CisfB
         wJwPgCi1y/4NomFk6YfqHPov89zstXVcC/bOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609033; x=1708213833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiwuT5//sOCIH4TJbmBqDDmgy+L0dj/76G1O/T9yDvA=;
        b=t0cbvu6f9Th7DLYykTpZD38dFDMWJGaDKcTATwEtKZXDJMu2J+I7I4GP0MKzm/nbB8
         pnCwJU+BD4GynlhrykjDKBOW+c3OPu623BSDgHgRb9qNzxVHoAEI7NKKvG95c8MT6MzY
         tMNNsoh+AYauPPdsD1FetmNHhWY0dwxoGsKs64HTMsmEGnIwKwhEXW+nNvne5N5QOUkz
         7Q0k5YKj7PI6OU49B66ZzYM3giwXt1OOEKXEZYQ43gH9gz3MEWhHYYz98so7ufIk71ic
         7OzHdBNZ3Knx3b/UqdBlvliHFFG6jo6I6piHHU59L4y/0HIK46+eAnkXskSCarhhZYQX
         CegQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYpWE/VDYDFfenvod1SKX5vc7EKDZD+DwdBkr3hlEj5+EGiiB4UNwGeKZANGvnZBzkBVT/SEy8RfPyBvOFED81bcbYkh0ylZaY6GuB
X-Gm-Message-State: AOJu0Yw0V4982hqjIxgUyzE7HTbY1Dr3gJn2DFBLSGt+Sjt/p/8FrbAV
	O74696UDIQswrDLsb4C7l/58TPhVPwYnheyELMf8OWtVW0Kr8nnAZ2/1ZBuy
X-Google-Smtp-Source: AGHT+IExR27JQfVLZEXRwgm4RohEjCzxZpl6UKJLxv7RaVu88vAqkCxD8bF9lapijM40qUXuUfN8Vw==
X-Received: by 2002:a19:7412:0:b0:511:4baa:fda8 with SMTP id v18-20020a197412000000b005114baafda8mr1726910lfe.38.1707609032587;
        Sat, 10 Feb 2024 15:50:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVutNH7wXArtZPi16MtiRS1ZNDSArgZzaxKHiPK6BMvhOO/SUfoVl9yVPeMxchKHlhQVAOPkiT6h0Xwa7V76mi+ZxC/Lf558xBN0UhCJ/1jEy7uhVNblQFYQslaNsH1LT02l4WEDjUKdSP31a+2bPAB7sGzl2FBnyaRAkGZ1Aipc6xssHYAtMCFr7VCXmXCw7ST25ukym5FoEZfuQH1+GbcKpT619MEaWUN7o0GaHHnRVSDuguc/dmRIzYyGJ0NAXhuoMWTr5iV71XdmMk3dxu0C4cXwVv9PteLj4et9ldixULw7Ow7gZPYEdpZoms/71+I+nschx45i8dvlxBbAyATdJdosk0ObRHZK24LI/LM/60fsIL1TbiQd6C1Ac2m5VxdkmXNIiMCYAG6jXeTzWrsVnFTBWNOeIUdUr5TUz+oBokl5Ql6zi3epSu77XA1IGE9gieNxcvB4lQ79PqSDFsjy17YFXk3wdA5vy9S+ZUzpNVxeXbBI6EQLX9uQaJO/nJw7LNBW/hNEio8TB/sD/zUJw5t8xy7Iv2/BCx6Mrir+qq/PrW2POJM1YGx4kGUp8JAV8wx5bRCR0us+XbUPzTg+vdTpEBgK73wY2GBvJ9SOMCh0g==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:50:32 -0800 (PST)
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
Subject: [PATCH v4 02/39] dyndbg: add _DPRINTK_FLAGS_TRACE
Date: Sun, 11 Feb 2024 00:49:32 +0100
Message-ID: <20240210235009.2405808-3-ukaszb@chromium.org>
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

Add new flag, and OR it into _DPRINTK_FLAGS_ENABLED definition

CC: vincent.whitchurch@axis.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 7be791af7cf1..497130816e9c 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -33,6 +33,9 @@ struct _ddebug {
 	 */
 #define _DPRINTK_FLAGS_NONE	0
 #define _DPRINTK_FLAGS_PRINTK	(1 << 0) /* printk() a message using the format */
+#define _DPRINTK_FLAGS_TRACE	(1 << 6)
+#define _DPRINTK_FLAGS_ENABLED	(_DPRINTK_FLAGS_PRINTK | _DPRINTK_FLAGS_TRACE)
+
 #define _DPRINTK_FLAGS_INCL_MODNAME	(1<<1)
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
@@ -44,8 +47,6 @@ struct _ddebug {
 	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID |\
 	 _DPRINTK_FLAGS_INCL_SOURCENAME)
 
-#define _DPRINTK_FLAGS_ENABLED		_DPRINTK_FLAGS_PRINTK
-
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINTK
 #else
-- 
2.43.0.687.g38aa6559b0-goog


