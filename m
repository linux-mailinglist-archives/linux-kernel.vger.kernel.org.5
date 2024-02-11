Return-Path: <linux-kernel+bounces-60639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FA78507DE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 06:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 901E7B2415F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 05:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF08617548;
	Sun, 11 Feb 2024 05:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vGOWWNwR"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC6C12E59;
	Sun, 11 Feb 2024 05:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707629292; cv=none; b=OYQRvK39qHMMAxLViEPOFtHKGX7Zag0JMFBoGwJBZ+G7SM8ZUnUhlOyvXzPbd+xJXd5xN0C3LTiPWRFmQI8wf+P1xP/ja4vcsBacEwBXrW7jAcuYEdl+1VekyyznJQfOrMmhApq4IuJg8v5F0A4CcthjKwoc7jIZY30w9h4oewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707629292; c=relaxed/simple;
	bh=mAZEulojYIR6tmfvP6+XGG8ArY0BK8jF6DxxlJ/nlYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kEM6AqgQnRkkJ2MJ6iWrnq9skeMoPKdTzc21VBgs9HsJscnq6vZa8gDJyv3dbU6Rjlk2BCC4cNQIRW3sISXOBnpsdn1Svn9cra/z4Lc8WuurB9aeeR1NL/5kxlhhEzDPqgXAR7Lf0RbdXXKcdpLrBuivX9TZYlTMdG3NDnt+TGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vGOWWNwR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ZbGAi9XelCY7QexlvxqZcifEK3+YdqIlzW8v8T7xhO8=; b=vGOWWNwREyr+Z6OHIRexqEUzxS
	eb2rHKPOxjqc/OGGq5L18QhyZG76MtClXkc596cmFrawAqck5KYO6fuJ1K8+P+dcEZOqGQuVFzUmt
	FgnxIhBJA/CVWKOhipfG4L21GxE+qmOrGd6/RKaGtWoNF5+J2UutXkAFAlk0aloZToqK/STwht0DQ
	GKOEJvqCz3tJjY7LiGRPmgJdlhDgkF64d+tStnykfuvHApMNicjgCMKnUbMZRZ093R6QIvwFyZfDv
	KIfea6OMciGosT1OqjHHb+YbLDTxU65sElFABWXPjV6dDwNLP67AB4C/IIz4sIvKnA3tMm6ylldJb
	EJPe76ig==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZ2Nt-00000002My9-1Fad;
	Sun, 11 Feb 2024 05:28:09 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Igor Zhbanov <izh1979@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Nick Alcock <nick.alcock@oracle.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH v5] sparc: vDSO: fix return value of __setup handler
Date: Sat, 10 Feb 2024 21:28:08 -0800
Message-ID: <20240211052808.22635-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__setup() handlers should return 1 to obsolete_checksetup() in
init/main.c to indicate that the boot option has been handled.
A return of 0 causes the boot option/value to be listed as an Unknown
kernel parameter and added to init's (limited) argument or environment
strings. Also, error return codes don't mean anything to
obsolete_checksetup() -- only non-zero (usually 1) or zero.
So return 1 from vdso_setup().

Fixes: 9a08862a5d2e ("vDSO for sparc")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <izh1979@gmail.com>
Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Nick Alcock <nick.alcock@oracle.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andreas Larsson <andreas@gaisler.com>
---
v2: correct the Fixes: tag (Dan Carpenter)
v3: add more Cc's;
    correct Igor's email address;
    change From: Igor to Reported-by: Igor;
v4: add Arnd to Cc: list
v5: add Andreas to Cc: list

 arch/sparc/vdso/vma.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff -- a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -449,9 +449,8 @@ static __init int vdso_setup(char *s)
 	unsigned long val;
 
 	err = kstrtoul(s, 10, &val);
-	if (err)
-		return err;
-	vdso_enabled = val;
-	return 0;
+	if (!err)
+		vdso_enabled = val;
+	return 1;
 }
 __setup("vdso=", vdso_setup);

