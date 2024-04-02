Return-Path: <linux-kernel+bounces-128487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5EB895B79
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDAF7B28392
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F71315ADAF;
	Tue,  2 Apr 2024 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZj3YAuj"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFE315AAC4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081381; cv=none; b=RfDYVpkzsPpSHz3zR0EEVMauYRP2kxX3Oj9EPFLES0oNxIVMHHjFHbHLpv+TBnqEbZIo+pFUCaL/QTvB++yR6KqtoEvcq52cNBO74QNciC640j6tgrUWrTbP8A4dPuhZk8WsQW2+Y4uevLAdDaHeXMc9t8nowx0bwvrDO5EIEA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081381; c=relaxed/simple;
	bh=FX9nOuZ/QPe6ZgAvobm6CWJzVArCcI9Bc4Yi3GSfB1Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mULJIVj3ZwaxEA7txoMfqXgeTx+xMIiu8Mp8rb1YS64zjvIc/f20SdrBjaJR+aIyBA9IX8zNMD99quXB+besTB+Rwza787nFJsMGfp/91GMgqI5u60AKHtWrPNYoN+W24zVxia7Ok7Rh2uY7Y3Oz0XRd4xQjPRCpyBS0qUN2NqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZj3YAuj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cd073522cso87296477b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712081379; x=1712686179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YBttcaCouPTSyNoIM7A1sGbIPGucTd2Wl1RLYnfOXwI=;
        b=AZj3YAujdYw8ImHRl0f+yKY5kVq4ZpICbasg9XYf5dzR2Y2JC0qj9h23TQAn/Tuzw1
         MV+T8YYkgzANlKqNsNvLLJnky4v7bTExPoUaZABFeiqNy6+TFSS4ektBJN+5r6KOsbi1
         4P/St9uiSpzK1SY1GkB6znTV1E51N3vxpiwm0q6MP6EdjqEMkFyyS1zfr3ZqxQ18xAWm
         W46olHmkTcwnjV+2UOOj+Ph23wshNgHGwsFxrJbppNYEvUg1Y9fMLrxOSTgoe4KApxFj
         2KpQ1x1ZBPbhE9sRCkVVTdyJAcHCp5mR73LxqJDQJ/2E/Lq1uSyOM3vIWnI5IHmG6ACL
         c0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712081379; x=1712686179;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YBttcaCouPTSyNoIM7A1sGbIPGucTd2Wl1RLYnfOXwI=;
        b=Ed0OyBnbmpyBZCOK9VhNI7Ha6RAwszgS73uEYhdycHVgasc2Q2FVZ2tMVEHt8enOKh
         60r1dFoXpVaDlIkfXsHKeIrfD0L8zYCifMQ5cOFXV7cU+gLgyv9At4tXv6CwkToYczE5
         O1oeQZ7Vtj2mF+4ND2mmPwsqHMxOqAtayZW8I6l6kRdG4nFAAnphBFQI5Xd4Bj+XxBrE
         KHsFsYvMFJbbxk1v+vFBHIBSxmTxcrQ2nHPuCxN06Szs+zVe5/2OaA2zvZZoZESt49eP
         MTqwaqZwW4MAOj0iu7YGw3MWb51tQ0LQEgJN+K6CesEL0pFIC4+latPUBShZacq4OI2U
         BNbA==
X-Forwarded-Encrypted: i=1; AJvYcCWeaqjHm0XWwQSMCOlFCRJ+IFzouITEbZLIxm7P8w224YD31MfzWCE6CstyMJ+QYXbMcbDFcbT0VIyVXj0+9CEhqf0pc+YXBlRX/jhh
X-Gm-Message-State: AOJu0YwlKqa3zEikDYVUJbTRUGhEVoSDLxnlSPUd1wB/M+H0kRXPnkJe
	j3C7aPkusLeSqn/vOXdQ3hmJ6eRzQrO2trPyMZtSXynQzs/q4SM9KJ3Qvamvn4GQ4zfS2IZYUWo
	DCQ==
X-Google-Smtp-Source: AGHT+IEOJ1hmlUd8ALC1MGIY4dpEHotPBzqE3a3FKCme8xRio3wi7l+PZwBqsMo9h7X6gKfDD1t9bEi6n/k=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:61fa:96f4:c395:2882])
 (user=surenb job=sendgmr) by 2002:a81:fe0e:0:b0:615:439a:dc3b with SMTP id
 j14-20020a81fe0e000000b00615439adc3bmr208514ywn.8.1712081379348; Tue, 02 Apr
 2024 11:09:39 -0700 (PDT)
Date: Tue,  2 Apr 2024 11:09:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240402180933.1663992-1-surenb@google.com>
Subject: [PATCH 1/1] fixup! fix missing vmalloc.h includes
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: sfr@canb.auug.org.au, kent.overstreet@linux.dev, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

vmalloc.h header refactoring missed vmalloc.h inclusion required for
__vmalloc_start_set symbol. Add missing inclusion.

Fixes: 07aecea15cc8 ("fix missing vmalloc.h includes")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403290536.7f9zGl5Q-lkp@intel.com/
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/x86/mm/numa_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/mm/numa_32.c b/arch/x86/mm/numa_32.c
index 104544359d69..e25e08ba4531 100644
--- a/arch/x86/mm/numa_32.c
+++ b/arch/x86/mm/numa_32.c
@@ -24,6 +24,7 @@
 
 #include <linux/memblock.h>
 #include <linux/init.h>
+#include <linux/vmalloc.h>
 
 #include "numa_internal.h"
 

base-commit: d4cd6840d1dc25963aa10ef5e5b1d01876baebf2
-- 
2.44.0.478.gd926399ef9-goog


