Return-Path: <linux-kernel+bounces-162915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A62DA8B6220
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473E11F249A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F47613BC0E;
	Mon, 29 Apr 2024 19:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsqEGyAD"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547EC13B292;
	Mon, 29 Apr 2024 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419135; cv=none; b=byCWpEi/iXqHeEWsuBF2Gqz8JPRlWAJc8utlWIVoT6rsHXjlvBI1M2IT/MWaa7LTpSmGnN9kosqQBdOjUHpgRIvRe5ZCX7xY0B7IaW+XdIFYghtVBI/EBcSNgEyGpvFrdSiMOYzAYAa8J1JlHshvrine9Od50xjZ6uD/7uwEpGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419135; c=relaxed/simple;
	bh=YqlF2Rr+ZngeS8l0LwLex8RBKU1L+Yl8do7R588Xg+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oikFlp1Rc6U30qRyLt1W3/20yWuEzap16FuxhTOu3gvSO6EKfujvPe4UxDI4glq4D01BaoIBs6g3C5nAQha3+655oYDUq3Bpeo2HuX7DVbMphDFhJdGmGpWAjRmXRU1lsDmxoLZ3nzwjB/HKstLm41g7EdV/yUzQG8o/nIqOuws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsqEGyAD; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d9480d96bdso272017539f.1;
        Mon, 29 Apr 2024 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419133; x=1715023933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldBVxIs3YWVEtrUSZaATkHa5+P4x6yD8OeAnS3nVM/g=;
        b=HsqEGyADAqNXJRPJx0V+grnIQz8O+fl1s5DAimpqL88CW6kg94bykzR9BJpGN5Oqm/
         w2/PQCcJkWK34MYhz6EfQbHCnB8WjsXKDyPA0W86iqofeIIW07sB11HR5/ya2XirYSms
         1ecqJG2RzN9TxV0jWM3BeX/jhN8tNoswXf9YUn5oFdWhSz+08JEN4LPIlhqjCf7pYdSO
         GZHCyuYZ9tQBWCZwY10GPnrggUduj1uOFjASNJW8X3D8tUx56AjPpiLlyekEB4+HF7vm
         SHSkhS6WZ0BsGkd+4rWm9frcsr0vJClSvpppyege3aE0Cj3kN3M9kqCXS0vq4dxl2Zzq
         EoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419133; x=1715023933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldBVxIs3YWVEtrUSZaATkHa5+P4x6yD8OeAnS3nVM/g=;
        b=M/qLEUiLp+7/Hs/+tL9vXR685j6qQT5O9ulAsuGwkS6jiUTbdmjtFOweMBZOiS7BFQ
         RlDBmH4sbY6232bWLu/0TMp4HOlAUKTI08Ku43Ovu9FogkNOytoDZXGwXM4jGSf3QBXy
         8J9zgrAhLuVBNhlbzV2niP4BoSoimk04N40i9ibrPPdO2xkrRjRToCe8oCiMnEV6fHEM
         ByA/HmXQJ+GhgQUSo++Eu3WdoERSyGx/1aHSTGUXqqTJ/HVMKMUr47ijEF817gjlqTBe
         brqD3/CaX4pP+oL/zNbP/mSDb5IZNgIlsypkqOCLhULtutdPF0paTRKy/Uas/wLqQbjJ
         t7kw==
X-Forwarded-Encrypted: i=1; AJvYcCUrBI1L9u0i69EYN0PmXUrb8RQLOQTvxCAcRCAWexBaSSsr8MipsQAfqAxrVXlni7uDrFZ7DbheY2eylRO4t3Ah9n+erNWejIdSxxoSKB3hKuKz5+V9U63rdzPSeUqtzeUvz5HeWRX9
X-Gm-Message-State: AOJu0YxRWe7xD9VSofMipc9yxOUIBuGuhdbJg/6Fplz7rUvKxvH797Ui
	1EBpV7LZTe+nPKGGsYatr+ZDFfrXI6ScV+PsZcYNGi+JLUwVdr4F
X-Google-Smtp-Source: AGHT+IGHW0PLwjFCn9/rpWdn4NiBooWfUd2DZN1lnB0NLUJaPWaAn9sXEpa4tjxTrKvayL0PZexs5w==
X-Received: by 2002:a5e:c74b:0:b0:7de:c608:15aa with SMTP id g11-20020a5ec74b000000b007dec60815aamr6340037iop.11.1714419133409;
        Mon, 29 Apr 2024 12:32:13 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id dq18-20020a0566021b9200b007d5ec9b77aesm5988402iob.51.2024.04.29.12.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:32:12 -0700 (PDT)
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
Subject: [PATCH v8 02/35] docs/dyndbg: update examples \012 to \n
Date: Mon, 29 Apr 2024 13:31:12 -0600
Message-ID: <20240429193145.66543-3-jim.cromie@gmail.com>
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

commit 47ea6f99d06e ("dyndbg: use ESCAPE_SPACE for cat control")

changed the control-file to display format strings with "\n" rather
than "\012".  Update the docs to match the new reality.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 0e9b48daf690..6a8ce5a34382 100644
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
2.44.0


