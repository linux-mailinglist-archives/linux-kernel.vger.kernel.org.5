Return-Path: <linux-kernel+bounces-122319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 576F488F525
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB4F1C29A02
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB022561F;
	Thu, 28 Mar 2024 02:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="awpXWp+3"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA78824B2F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711591652; cv=none; b=GjeYW1upM62X0QR96VWrfF/s+bkL9SOKLtz+8CdNJ9yW+Pl1caW58IhacZAqfcwy5D+nhHdqhZdkyorye0QxB8O9lTb3BvciyIi5Ews/3t9e5u8uwmWw9nsU37tzanlDIwQbqPusVVcttWXMfWkjx69f+qvD9PXuLyLUEgZBQ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711591652; c=relaxed/simple;
	bh=HFjG8R+kmOBzPPdi6ipJuusDY05lFaXEQWIAKo/fFQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dUaqxzmzDpY0+GrFsmJyRMbV/Ek5H7edm0CsfmpRARXRlDDLyDZakzObZii3xRz/YdXSxxPSzvzNPxLOQgda0R+8hJ4Z1ihU/O/zaDSKYAswDT7QgOcfkL6FXDm9vgOLluvjNDRmfi+eqb5+NcZ22g6ep5xvCwoVrIbH0L95E1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=awpXWp+3; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711591642; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=pUm4ue8Vi8UQo3ShQ4H5J76PcermzomnRDaL1C/gRhw=;
	b=awpXWp+3S13QMFYoayDQtn7NtsSDH0FcY+xEG8qRKe91vkJB59eWsM+MricKbABSEoFpimTigj5LtCjnAfjJKTqx0EgaxFLnHFmXLeF0v06aQC0ixcPao/1y1SDdV3bWRYnaAkvjl8O+Rrn0XTYYBApYSk2os+IySEoAsWU5oL0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W3QD7w3_1711591632;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W3QD7w3_1711591632)
          by smtp.aliyun-inc.com;
          Thu, 28 Mar 2024 10:07:20 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: cl@linux.com
Cc: penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] mm/slab_common: Modify mismatched function name
Date: Thu, 28 Mar 2024 10:07:11 +0800
Message-Id: <20240328020711.125070-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

mm/slab_common.c:1215: warning: expecting prototype for krealloc(). Prototype was for krealloc_noprof() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8659
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 mm/slab_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 8664da88e843..8af45e9bd2b2 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1199,7 +1199,7 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
 }
 
 /**
- * krealloc - reallocate memory. The contents will remain unchanged.
+ * krealloc_noprof - reallocate memory. The contents will remain unchanged.
  * @p: object to reallocate memory for.
  * @new_size: how many bytes of memory are required.
  * @flags: the type of memory to allocate.
-- 
2.20.1.7.g153144c


