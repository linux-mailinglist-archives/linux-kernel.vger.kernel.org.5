Return-Path: <linux-kernel+bounces-49452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B85846A87
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E69286B50
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC52C48CF2;
	Fri,  2 Feb 2024 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f1/0Pp6F"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED4D48CC6;
	Fri,  2 Feb 2024 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861704; cv=none; b=tAgEcQjExuOobNuQokVL4bEgpcez0sgxsIpqVQQOrtIgmpIXYsjiHYeAUkPlw1+aFS+G3/XR2IvT4zAUHdA48Sf9CugMqsK6S9lybAM+jEWetQq8b0qNwpuGK8LwlR653DyA4NKe8lUcRdIZPgKVPseDhgg+0iKhbhjuFIKkp70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861704; c=relaxed/simple;
	bh=MKELfN/liQILzbsoAJhhsGuJidlhOwTtBA1W19GP9to=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sLIlUj4vcQDEVTQMEcPOl9ze7iJ2ehnQms03HSVgIrArEmrmUXJzo8El9+000Xxcoo9TIF+MILYfD4UWHb8+02rz1YOgjsFJCKg5EApVB7WhTQgcX3WEHaSuzy3EIR/xeW/E8kTdGlmfp6SVqiNkmM3Uw1P+edvD+ZC3A2rJktw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f1/0Pp6F; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706861693; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UDm1iREhmWJkprQXJzTP/PsdWlr/hSrAJos2XAwg6I0=;
	b=f1/0Pp6FwqaAphCFb+oGKMGJ7WZx0T9VaFwmgyIU10N3blbn+caxDSJ3s1wKHCBthfrj5RdlQy26oZnvAnrm11C7WNxZcwp0dkC4rgZ7DfZPGbu03jgr1aWpgSZKPveswA7vnWruIOAP4J/OOwcYQdMhP1F1LHyJKpHJbyphubU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W.wPoio_1706861684;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W.wPoio_1706861684)
          by smtp.aliyun-inc.com;
          Fri, 02 Feb 2024 16:14:53 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: robert.moore@intel.com
Cc: rafael.j.wysocki@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] ACPICA: Use swap() instead of open coding it
Date: Fri,  2 Feb 2024 16:14:43 +0800
Message-Id: <20240202081443.1099-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Swap is a function interface that provides exchange function. To avoid
code duplication, we can use swap function.

/drivers/acpi/acpica/nsrepair2.c:896:33-34: WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8168
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/acpi/acpica/nsrepair2.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 1bb7b71f07f1..ccd89a82a4e6 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -875,7 +875,6 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
 {
 	union acpi_operand_object *obj_desc1;
 	union acpi_operand_object *obj_desc2;
-	union acpi_operand_object *temp_obj;
 	u32 i;
 	u32 j;
 
@@ -892,9 +891,7 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
 			    || ((sort_direction == ACPI_SORT_DESCENDING)
 				&& (obj_desc1->integer.value <
 				    obj_desc2->integer.value))) {
-				temp_obj = elements[j - 1];
-				elements[j - 1] = elements[j];
-				elements[j] = temp_obj;
+				swap(elements[j], elements[j - 1]);
 			}
 		}
 	}
-- 
2.20.1.7.g153144c


