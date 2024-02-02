Return-Path: <linux-kernel+bounces-50507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E523F847A05
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846561F24070
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF91480625;
	Fri,  2 Feb 2024 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="hDqww7k1"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEEE15E5A3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903889; cv=none; b=rzoiBW2GHh6nMxxGORnLRu7jfrd78e2PgPxQue8vDqho4Wj5bg4Dse0SiliaGs1eaXfiJDecwLDGBlbmKwrpUePv+KSTm05ncpoRIknQUrsXeTEzR96u3qu8+DT60OFrBpZUXuo5iOlmtiQa4qjj+dKLYAV89KYXfrF3zdjIfr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903889; c=relaxed/simple;
	bh=ZjzdVNfrMUY9UbVAc1VBiqKQvpy3NY8jNomBSoF8YQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O4snPKcRS0VMXBujyVXSCeIM0OT/PFz8tKeTxEXAuWxmkLisk4w21UCzIIMHg+wqGYs6+uhkHn3iFq4XKbpf6bQWA/ENXn/D7/+0i14CjnnioapdgAEZdkxMG8ovoSi/cH+53yF3Nm/+CISw6290kCvwFzLjOMFYGTeGFzxmsEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=hDqww7k1; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 37FC0240103
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 20:57:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1706903879; bh=ZjzdVNfrMUY9UbVAc1VBiqKQvpy3NY8jNomBSoF8YQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=hDqww7k1xSH3YS9NyU1U28mv8gyk1ry5awu7xlodsYIIk4O2fLsbBE9+M1IFr/WQM
	 EUCeqAHXHalRpQx4KBL+zKeqTy2FsguPk6FfbeycHb8qTOfZ1PolxAbmmodMGoF189
	 3CGyLU/yOj5WNm/1fw9MAg3AOZUfuo3wnXWRIotznjP91oZFPA7TdKrvbi2WzVt9X9
	 vsWYrR7ys9VbaeQd+aK+P9LvRFC/EOoZ7sDSxdiCTUtOyzbu8batzONrJK4N+6DNPP
	 cSmpXl6FyfNcrapy2G0aQk1q3TkmznRJIJssQsrV9bkLaYtbZyYqpGzN8bBKHYQbDL
	 NqKkz9q4IxgMw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TRRQW0V8Zz9rxG;
	Fri,  2 Feb 2024 20:57:54 +0100 (CET)
From: Yueh-Shun Li <shamrocklee@posteo.net>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Yueh-Shun Li <shamrocklee@posteo.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] um: Makefile: use bash from the environment
Date: Fri,  2 Feb 2024 19:56:33 +0000
Message-ID: <20240202195645.3224648-1-shamrocklee@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set Makefile SHELL to bash instead of /bin/bash for better portability.

Some systems do not install binaries to /bin, and therefore do not
provide /bin/bash. OS distributions such as NixOS and Guix System
intentionally avoid implementing the Filesystem Hierarchy Standard (FHS).

The recipies inside arch/um/Makefile don't require top-level Bash to
build, and setting "SHELL" to "bash" makes Make pick the Bash executable
from the environment[2], hence this patch.

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 arch/um/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 82f05f250634..904e2b990963 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -20,7 +20,7 @@ endif
 ARCH_DIR := arch/um
 # We require bash because the vmlinux link and loader script cpp use bash
 # features.
-SHELL := /bin/bash
+SHELL := bash
 
 MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/shared/skas
 
-- 
2.42.0


