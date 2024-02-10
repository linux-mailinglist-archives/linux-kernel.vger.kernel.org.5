Return-Path: <linux-kernel+bounces-60620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD78D85077D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 236BBB23325
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830C16169A;
	Sat, 10 Feb 2024 23:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FklFJpU3"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2116604BB
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609094; cv=none; b=Z6Cf8QqAW3dzrNxsyzlirJMuX68xas0HzIoMDFgySyXXTQbftK+oqRVf9RUR3lSEefjY6c0Iikqn3mU/A3ZcrNme752XNU727BKZpC8h1OF9cfZIrzLnLlV1v9NUFvc3QzZ8MrqTV9OONgz6s0vggqatwq9xN9W3aVLduutyuQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609094; c=relaxed/simple;
	bh=2dKMrYi5sXjxmg0BwHpJ1Xry5WL12IvHskjUlAQWeWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eP3YkWaSXac8L+SdKlUxeilNsk5TNFOkmNusRfzWoUumgiwtPEd2AaB1+W9/O/80NRkuJ3RrCiq2O6wsWp0AmKJGIt6OJP3sxBp8aYjv2OnuPilrCAL7DVt9RCef44jdABwBCv0Y2fT4ft9QMMhXhKsvIQs5sq2Cwna/3pmgu28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FklFJpU3; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d0a96bad85so30189131fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609091; x=1708213891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjLak+Dwda0WVoH4If4D1UzfhJc/HxH98/ccLVqTlaI=;
        b=FklFJpU3MH9vjT3/T+zEBQZW7aEiR4dqmAICDBX+YNfsaCOyo2UONMSgmUIkwPGR6B
         17nm0mrKbG1Pi/5nQnDm7UKHMkanCmU9wJthvmU/gCZmtFI0KUS3Z+k79Ayqa2yvPDug
         9Tt+CfUuQ9nlAAtQ/yjXaXUAk+ZSJL+CeKe8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609091; x=1708213891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjLak+Dwda0WVoH4If4D1UzfhJc/HxH98/ccLVqTlaI=;
        b=h8z7rDePYjWeJOr8KDZFPgorvk0jr7rgSx5cB8NyKBPJeNaOL21vYc1SG8t6yTrf73
         1oM6XyITNjHIdrK12MWNzCVOrK12ERRNSxPRq2LsfRiGe3531XWRxBXaYqkHvxlcVZ4q
         jfGW9hssDCIoEESpCgdGU5+9MAlVXyge0GmFMMdLBw15hQ1TLdKP7Lpohne9dJmHWobP
         Bd7+x+IzxkGKEmiYMZ3+A/OxOf7uraT6eoPl/aBWzyk2oSNMRu+Li3bO5eR+FVNkezjZ
         GWl3ucT3BHzlhMxDXD7qOfWLTIdUWAOY0kZjNMUjVme3jOqSkQAfFsEYsKomlxOfrrzT
         zBXg==
X-Gm-Message-State: AOJu0YxvfyeWu9qZU37UCuBsLOufPfEri+WzioPujmj8EYL0IokHMigv
	Uo6h3d4bg6IP8xAeKwqrNCy3b5GYPL7boEPt8e5HXLNrCsE3iXsoXPV/F6OY
X-Google-Smtp-Source: AGHT+IHv0nWMfI6aq0b6eLdPi5BFXUpk1cm504MWLpXBDcdbghuBHDx91yOfrqeoI1etZZXos7SrEw==
X-Received: by 2002:ac2:4288:0:b0:511:720b:fbe8 with SMTP id m8-20020ac24288000000b00511720bfbe8mr1620848lfh.54.1707609091187;
        Sat, 10 Feb 2024 15:51:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5eoCvO8633YPEthka68zBBHuwtTY4XB5QvFoSWLSCEoSn1lEq1mpI+WvkAfsljUv+zdZc6HiVmPJpICHtgcZvK8dfWy3JZ11a40jd8Xn2wPH/jh/dlufaduVEiZJsuZ5N/mL6aCKY/9DbiNo1+J7ahtooGTn44MZOzLkPdiApXIGEjCSGDSnwgnDJRVDnylIOT67OGHlrvGkejlEh5IXB10DigzJiXt9XbvW3nLHonb+DyzEBGmg52zNOFwqXgHHabJodaIJDnPUy9qJe+xEHa4cFdk9XUZs6oNeCdSHVeffbtITXlrnMM0CRnL4EABI0lHKFqHIp5R/i/7mK2xVCRBTyEugheHaH2ynJtau5tO+v74eovtUHueJCrOBKVt3bsXxXjTiCnOvAK3cXVsJ3PCQyAcVSFY+mh8sT4Ocgs9foIEhFx3q2y+f8z8v1TLnStM+0n64RsmyQeEwom2B0+B8wdRop0s75Vy3pfBWty2yC0TIrBlkn7GlmX28FDmSTIC81vauJ9Kgk40zGCn4gF5idznYQzYxlskeD2Uoo4pePpZj+Vw6s1aNb98I97p0H1s5sHtVFjpybLukhwyEuVjKqzO5XpZp3X3MFaY0yWzbExw==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:30 -0800 (PST)
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
Subject: [PATCH v4 37/39] docs/dyndbg: update examples \012 to \n
Date: Sun, 11 Feb 2024 00:50:07 +0100
Message-ID: <20240210235009.2405808-38-ukaszb@chromium.org>
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

commit 47ea6f99d06e ("dyndbg: use ESCAPE_SPACE for cat control")

changed the control-file to display format strings with "\n" rather
than "\012", etc.  Update the docs to match the new reality.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 90449a04946e..4d681c37e074 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -52,12 +52,12 @@ query/commands to the control file.  Example::
   # grease the interface
   :#> alias ddcmd='echo $* > /proc/dynamic_debug/control'
 
-  :#> ddcmd '-p; module main func run* +p'
+  :#> ddcmd '-p; module main func run* +p'	# disable all, then enable main
   :#> grep =p /proc/dynamic_debug/control
-  init/main.c:1424 [main]run_init_process =p "  with arguments:\012"
-  init/main.c:1426 [main]run_init_process =p "    %s\012"
-  init/main.c:1427 [main]run_init_process =p "  with environment:\012"
-  init/main.c:1429 [main]run_init_process =p "    %s\012"
+  init/main.c:1424 [main]run_init_process =p "  with arguments:\n"
+  init/main.c:1426 [main]run_init_process =p "    %s\n"
+  init/main.c:1427 [main]run_init_process =p "  with environment:\n"
+  init/main.c:1429 [main]run_init_process =p "    %s\n"
 
 Error messages go to console/syslog::
 
-- 
2.43.0.687.g38aa6559b0-goog


