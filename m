Return-Path: <linux-kernel+bounces-112435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC1A8879CC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C14B1F218EA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C7753361;
	Sat, 23 Mar 2024 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="H+9BUtGk"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D2751C2A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711215926; cv=none; b=JOEIMEVEJK/IoKv7qqM1XZqYdMNdniEhrH1k1DW2QQq14tv+oM+AZ5QVRaerGXrfymodr3DlFpT4BKpfe3z8LLFnELUcnKM+RRkuvxV0Kbgda+2ItJj91cYa6RBKpT7oJrRRvdd1F7imTaZ+J/xtkA4HXDbIOWXi92J+N3rISgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711215926; c=relaxed/simple;
	bh=mAKeHSlYlC/WNK86vCepUm6fXPa8vRXSPBcHY+AH2vY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X4o56NtImwXe5Jtra64/X2Tij97QsRT95ErTknDVhGFSMVeeBGkwSYeU73sPwwiqNBi6WFGk+Z9/SEk4OCcckBPsV9pQkeDghdLpRVvT0ffwRqFrrqowy4QL95Tq3XOC7SYOGGLbCWbMz6lhJWllxxIc6q3+qSSBo30kAF90LYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=H+9BUtGk; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 851BC240101
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 18:45:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1711215915; bh=mAKeHSlYlC/WNK86vCepUm6fXPa8vRXSPBcHY+AH2vY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=H+9BUtGkmp4iY3MVqwcV17UUsFPV0Xmb/I74X3EoRIYMrFXXpPsDbICjakUOv+SFg
	 qBT/U5qrgxYId/m5vNljIxp5gsCyYVFRBWodBRQ04o8cGQW1G5cPw5vNHpGQPlnguS
	 FAQKBbesL6p4hkYu/hz6D38zK/O3DhyLbfenigxX1XyoSKykDlIvTht6ecK4IHgmb1
	 I7vucXnyprPnMxkriX7Li6XVTP8BQyHRY4UDRJbg47LUAindU78S7P0+T69SpInoy6
	 NPgEvmes5kHsCL9lQxvr7CEZutI5tIpKkmZ9L8qR3iPTMN+GLxw5w0CfQRKQATv3FP
	 dikMPp8tcDWyA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4V266H52Wwz9rxB;
	Sat, 23 Mar 2024 18:45:11 +0100 (CET)
From: Yueh-Shun Li <shamrocklee@posteo.net>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Yueh-Shun Li <shamrocklee@posteo.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] um: Makefile: use bash from the environment
Date: Sat, 23 Mar 2024 17:44:25 +0000
Message-ID: <20240323174450.18376-1-shamrocklee@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set Makefile SHELL to bash instead of /bin/bash for better portability.

Some systems do not install binaries to /bin, and therefore do not
provide /bin/bash. This includes Linux distros which intentionally avoid
implementing the Filesystem Hierarchy Standard (FHS), such as NixOS and
Guix System.

The recipies inside arch/um/Makefile don't require top-level Bash to
build, and setting "SHELL" to "bash" makes Make pick the Bash executable
from the environment, hence this patch.

Changes since last roll:
- Rebase onto a more recent commit on the master branch.
- Remove a dangling in-text citation from the change log.
- Reword the change log.

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 arch/um/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 34957dcb88b9..00b63bac5eff 100644
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


