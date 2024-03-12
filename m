Return-Path: <linux-kernel+bounces-100486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2603487987C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67461F24345
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7DA7D3E1;
	Tue, 12 Mar 2024 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6BsOMGo"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD507BB08;
	Tue, 12 Mar 2024 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259236; cv=none; b=GFpJ/r/83WW700mi4a5WQ3COow68TUeuU/ZSzqV7ltmXS30efcM1N/tmDjpnisUH6M3Sic4QAekY4ibMKE+PEwDitmAj79/EavguwtHwHC2lJBFrUfbKTsLA+wkhw4SAEqMBTvjvmjyv/Vowm38dzNJt1scL7khdlADY1WlQI+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259236; c=relaxed/simple;
	bh=kSaCTYJwLy187cV9f/oHCT6J7jWDnNWrBPC9wyby4yU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+E0CVQaUUqlJiYa019yR4hoDasXkPKixk7SEhCtm+LqilU3HE8yNDMXeEgPj1Z9acRCujEmmHUQnouJpmaOzyGUYoHsPfbWjGxAnUuBVjMpHEgFJvjX3gL8zTpqV2ed3lc2tlYYMbTtQIftZ6aTL8YhDhMVvsUaQQT+qaxk49o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6BsOMGo; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-69107859bedso588956d6.2;
        Tue, 12 Mar 2024 09:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710259234; x=1710864034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1BtyRPL2RK9hoZHhxRN4BFuS2lRzybcWfo5FHNeAlTI=;
        b=H6BsOMGovmymXViqMkHU1CRhyjVWHN1oBH1r7NV9rPTP9zG9U+aQ5/IpN7mf74K+qx
         6dTL2IGxkK8Ss27eNA//v2ptNyxURW1dfp5GQNIB9bTNaNlpJeD9rRaFxEG8YX2Hrt85
         TZ7oMEX7PzTt0bh4hYtSUXPqrTYhFLLqvqm3QuLHKVDRTciZO1uoGj2fp/NxEgaqjyKb
         iExdNWHjH8FMVd/9483QWaqfwGesGKApG8EefGNzuCSAhxzwshYqP8RSUMxFNKZkmQaG
         muxwQnDfDpsD1RiAIhSTj9MYDR+Jkoz6h+TSH//NVTpq3Xfx4FxSV4Uf8pVZvQT12gHh
         VFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710259234; x=1710864034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BtyRPL2RK9hoZHhxRN4BFuS2lRzybcWfo5FHNeAlTI=;
        b=tZ8uNlO1YvYCk39nEurPBkCsvQkkuywyRg1QzTeZFZw09pvEGSbyvZqvK7tcv9RVjw
         kzujat7Fv0GFk3xgUtM3K4Kl5rkT9t2Apz/epHt6L+OY6hAW21cSo+SWdXHGWGLoUTTL
         fOMuvIgvNpWF6BBs6K03LEKBIsj5tq3XWj/GxA+RD3fkUjgILHHq9QqSjD5cJhZzYAIQ
         Z2oTFJgMMcEcVeIDKappnThUCltjTz3KMeeNY/N3bhRm6pIaPVMaVRLtCesDMNWd3tUw
         ghXohNyfkuGVfkEdIF7d6p5tviP+pMtY9kKKYKSjI7quf488+FO3ow1B1XCt6AcGB7lD
         ETRg==
X-Forwarded-Encrypted: i=1; AJvYcCXWrIMiMyRKzE6mJWTvGSm5RiE+dKG5VtPPDlSl5OIbwvWrDL6ZKM18MDTECQGNgHnWouEpIF6407kKb9JzWNOEkvu19CBY2yoa0uLl
X-Gm-Message-State: AOJu0YwOxulH9WAtlMn+k/ex2ZqGqpam27ED2/frkhW9PA7hkNqiDu4g
	DWbJR2NLJhunoNv2cg+9IUJhmUpWy2nfA58XRb/rFBFZK1ID0kz8
X-Google-Smtp-Source: AGHT+IFtW9QMD7SiQG3j94RZGz2Jcgsjp2NHcVyfeQ4To9PTvKu3QDvcwK5FtD6zUTxDQ7FBNW8ItQ==
X-Received: by 2002:a05:6214:2a7:b0:690:b27f:1b24 with SMTP id m7-20020a05621402a700b00690b27f1b24mr3511923qvv.12.1710259234036;
        Tue, 12 Mar 2024 09:00:34 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-15-174-88-88-13.dsl.bell.ca. [174.88.88.13])
        by smtp.gmail.com with ESMTPSA id kl30-20020a056214519e00b00690f9ea30aesm431702qvb.26.2024.03.12.09.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 09:00:33 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Daniel Bristot de Oliveria <bristot@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Cc: linux-trace-devel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH] rtla: Remove tarfile functionality
Date: Tue, 12 Mar 2024 12:00:09 -0400
Message-ID: <20240312160009.15679-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linux distributions have been installing directly from kernel source, so
simplify the Makefile by removing the unneeded tarfile functionality.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tools/tracing/rtla/Makefile | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index afd18c678ff5..0bf182cda0b0 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -45,23 +45,13 @@ OBJ	:=	$(SRC:.c=.o)
 DIRS	:=	src
 FILES	:=	Makefile README.txt
 CEXT	:=	bz2
-TARBALL	:=	$(NAME)-$(VERSION).tar.$(CEXT)
-TAROPTS	:=	-cvjf $(TARBALL)
 BINDIR	:=	/usr/bin
 DATADIR	:=	/usr/share
 DOCDIR	:=	$(DATADIR)/doc
 MANDIR	:=	$(DATADIR)/man
 LICDIR	:=	$(DATADIR)/licenses
 SRCTREE	:=	$(or $(BUILD_SRC),$(CURDIR))
-
-# If running from the tarball, man pages are stored in the Documentation
-# dir. If running from the kernel source, man pages are stored in
-# Documentation/tools/rtla/.
-ifneq ($(wildcard Documentation/.*),)
-DOCSRC	=	Documentation/
-else
 DOCSRC	=	$(SRCTREE)/../../../Documentation/tools/rtla/
-endif
 
 LIBTRACEEVENT_MIN_VERSION = 1.5
 LIBTRACEFS_MIN_VERSION = 1.3
@@ -129,22 +119,12 @@ install: doc_install
 	@test ! -f $(DESTDIR)$(BINDIR)/timerlat || rm $(DESTDIR)$(BINDIR)/timerlat
 	ln -s rtla $(DESTDIR)$(BINDIR)/timerlat
 
-.PHONY: clean tarball
+.PHONY: clean
 clean: doc_clean
 	@test ! -f rtla || rm rtla
 	@test ! -f rtla-static || rm rtla-static
 	@test ! -f src/rtla.o || rm src/rtla.o
-	@test ! -f $(TARBALL) || rm -f $(TARBALL)
-	@rm -rf *~ $(OBJ) *.tar.$(CEXT)
-
-tarball: clean
-	rm -rf $(NAME)-$(VERSION) && mkdir $(NAME)-$(VERSION)
-	echo $(VERSION) > $(NAME)-$(VERSION)/VERSION
-	cp -r $(DIRS) $(FILES) $(NAME)-$(VERSION)
-	mkdir $(NAME)-$(VERSION)/Documentation/
-	cp -rp $(SRCTREE)/../../../Documentation/tools/rtla/* $(NAME)-$(VERSION)/Documentation/
-	tar $(TAROPTS) --exclude='*~' $(NAME)-$(VERSION)
-	rm -rf $(NAME)-$(VERSION)
+	@rm -rf *~ $(OBJ)
 
 .PHONY: doc doc_clean doc_install
 doc:
-- 
2.44.0


