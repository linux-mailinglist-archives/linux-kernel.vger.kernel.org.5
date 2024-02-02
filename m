Return-Path: <linux-kernel+bounces-50602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAD5847B76
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82251F26A7A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA0981752;
	Fri,  2 Feb 2024 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="YgoAR4A5"
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE518175D;
	Fri,  2 Feb 2024 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706909016; cv=none; b=A5ieWwspg45mNM5PFWnjlo03uMX6c36v0JFN56KVK+Tr2k1MPUzDRqzCvLHtpTmhkXsr1vizVaGmUCINMFcMlSQ80PTmRxQiGTmNa/NPlD64nLIQknCFlk1LjLdv8CE5ulHc+ykjNqf0yNmBL01Uppw50kjCRWIgvKPEMV6Y9jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706909016; c=relaxed/simple;
	bh=PN0rt/SrGrPLEv+QxTAiD8tWU7CCMMQCJvdKyV+MpKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QVq4oWPga+sqJ+6K0vZZ4Nyhdtq0lzKfqJZbMLGT52NaFJCn3N+jMBA/6/lljQcHtOAsiIYS+T1VIg8CF/dadwGqLx25uPYkjIBUOpRMHvr8d+OEnziKXnIYIVCDeYetN+3ieOhPPrCOiBpzbTin0AUYAa2l6oLogg80Hf8l1G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=YgoAR4A5; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id W10NrnAvE0k1mW10Ornqsa; Fri, 02 Feb 2024 22:23:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1706909004;
	bh=gknkBxJEzqhmHTYPDuPbdM6rcQN2TQdAIGaoD5ZyO4w=;
	h=From:To:Cc:Subject:Date;
	b=YgoAR4A5THvusTgAiNg8KwY8Etnc1ncfqrO25s6RTtGo6epSz+oLTQA7rbUYQZsFt
	 m6fXmOTJwj70w8j3JZ2dj3nCgtr2stskPQFrmZ+esPcZjx1ppIiGbNT+lI174WX6IL
	 41tlYVyiI2pTIpBcA4SRyVk9NH4xMjMowq8rfQ9QiRYhyhLt6UUgxYEdtgACe0Xy5X
	 98cCkSIaTp6eeItapQpmpFbawDyDQuTsg8LiKDwr58u/TTpm5Yq4eUJ0AubvZKU87t
	 6D48uWyMpkJEDGnByXqPCInHuOIkmLvTXrodOQhxnw3jSlhXIB8e6Z5VOGM96Zmxy8
	 ibym9c28XQnqQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 02 Feb 2024 22:23:24 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mm: Reduce dependencies on <linux/kernel.h>
Date: Fri,  2 Feb 2024 22:23:18 +0100
Message-ID: <adfdbe21c4d06400d7bd802868762deb85cae8b6.1706908921.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"page_counter.h" does not need <linux/kernel.h>. <linux/limits.h> is enough
to get LONG_MAX.

Files that include page_counter.h are limited. They have been compile
tested or checked.

$ git grep page_counter\.h
include/linux/hugetlb_cgroup.h: struct page_counter hugepage[HUGE_MAX_HSTATE];
	--> all files that include it have been compile tested

include/linux/memcontrol.h:#include <linux/page_counter.h>
	--> <linux/kernel.h> has been added, to be safe

include/net/sock.h:#include <linux/page_counter.h>
	--> already include <linux/kernel.h>

mm/hugetlb_cgroup.c:#include <linux/page_counter.h>
mm/memcontrol.c:#include <linux/page_counter.h>
mm/page_counter.c:#include <linux/page_counter.h>
	--> compile tested

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Let see if build-bots agree with me.
---
 include/linux/memcontrol.h   | 1 +
 include/linux/page_counter.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 20ff87f8e001..4e4caeaea404 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -14,6 +14,7 @@
 #include <linux/vm_event_item.h>
 #include <linux/hardirq.h>
 #include <linux/jump_label.h>
+#include <linux/kernel.h>
 #include <linux/page_counter.h>
 #include <linux/vmpressure.h>
 #include <linux/eventfd.h>
diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index c141ea9a95ef..8cd858d912c4 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -4,7 +4,7 @@
 
 #include <linux/atomic.h>
 #include <linux/cache.h>
-#include <linux/kernel.h>
+#include <linux/limits.h>
 #include <asm/page.h>
 
 struct page_counter {
-- 
2.43.0


