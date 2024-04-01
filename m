Return-Path: <linux-kernel+bounces-126543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED83F893947
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4861F2132C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7F810A08;
	Mon,  1 Apr 2024 09:11:21 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411D81079D;
	Mon,  1 Apr 2024 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711962680; cv=none; b=SHVKL5KDDsRjDmN7jVxlJFHRUCcldt8KbSwGGbQdICJrtbHtbKSTgIyvAz5cluCFU1x4HH7hrnp0MPBiO1lrSi5+IGfjfMax0KTW+zefv+f3TWX0KnYEi+ZAJXnEDGdWd4WFTziw7eYqyjIsk8B2tASmigxSbwu6ltkKxSz6n9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711962680; c=relaxed/simple;
	bh=L7sjMOJlJ+I03lGiyx1wcFdP3qgdm5PCxICxKzdjito=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsGieWxNo0gs4ea5Vx0IvlpfGyy+othsqPeKYNvP5maLxxyq7UsO7PBq8ChNN7JLpn8Joo6eCnFiA4rPNDPwbnMfGORIB0FMkt2IhMw0XlNaRmnbm9vkzyxgBWweMLK/NTtDGATCiyFaNE4KUe7sNzCB5sAKYFt6vijAB9bH5nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-90-660a7a24c6c4
From: Kwangjin Ko <kwangjin.ko@sk.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com
Subject: [PATCH 2/2] cxl/core: Fix incorrect array index in cxl_clear_event_record()
Date: Mon,  1 Apr 2024 18:10:56 +0900
Message-ID: <20240401091057.1044-2-kwangjin.ko@sk.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <20240401091057.1044-1-kwangjin.ko@sk.com>
References: <20240401091057.1044-1-kwangjin.ko@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsXC9ZZnka5KFVeawdw2K4u7jy+wWUyfeoHR
	4sTNRjaL1TfXMFrsf/qcxWLVwmtsFudnnWKxuLxrDpvFrQnHmBw4PVqOvGX1WLznJZPH1Nn1
	Hp83yQWwRHHZpKTmZJalFunbJXBlLG9dy1qwnKPiYc9WxgbGP2xdjJwcEgImEtumzmWCsTc+
	eckMYrMJqElMunYYqIaLQ0RgJ6PE7WVrwBLMAhESW5r6wRqEBUIkzr7qA4uzCKhK9Bx7Ahbn
	FTCTaDjXxg4xVFPi/azvYDWcAuYSe3cdAasRAqrZda2fBaJeUOLkzCcsEPPlJZq3zmYGWSwh
	MINN4sjUU8wQgyQlDq64wTKBkX8Wkp5ZSHoWMDKtYhTKzCvLTczMMdHLqMzLrNBLzs/dxAgM
	3GW1f6J3MH66EHyIUYCDUYmHNyCOM02INbGsuDL3EKMEB7OSCO9Pb6AQb0piZVVqUX58UWlO
	avEhRmkOFiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGRo4J5rwvPCYE3A3MFt20Yon6H5Ot
	HAcmumgEbuCOOLm9/s2VgKlvmn7e2vD5ktTjNpkjf98z6E5s+C0VPL9QxOCR4p4k/Rsrje3S
	q8otHVsUNnv7hi7ZcXmzi1xOZiyrfrZA88Ld6btLfbSPOPHKxFbJ1Bk9ifBKMzzlYf3XaONf
	gbqmnzpNSizFGYmGWsxFxYkAcCX+HVgCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsXCNUPhia5KFVeawYqlRhZ3H19gs5g+9QKj
	xYmbjWwWq2+uYbTY//Q5i8WqhdfYLA7PPclqcX7WKRaLy7vmsFncmnCMyYHLo+XIW1aPxXte
	MnksfvGByWPq7HqPz5vkAlijuGxSUnMyy1KL9O0SuDKWt65lLVjOUfGwZytjA+Mfti5GTg4J
	AROJjU9eMoPYbAJqEpOuHQaKc3GICOxklLi9bA1YglkgQmJLUz8TiC0sECJx9lUfWJxFQFWi
	59gTsDivgJlEw7k2doihmhLvZ30Hq+EUMJfYu+sIWI0QUM2ua/0sEPWCEidnPmGBmC8v0bx1
	NvMERp5ZSFKzkKQWMDKtYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECAzDZbV/Ju5g/HLZ/RCj
	AAejEg9vQBxnmhBrYllxZe4hRgkOZiUR3p/eQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8XuGp
	CUIC6YklqdmpqQWpRTBZJg5OqQbGsNsqDH9K+WJu+6nsPvnvofL3IsOv//V42pyDrsRzfMy6
	/zrA+SvXOlOD86bPjqlFHtHKD65WE9qbsvvhU/GlRucee/SzmFtdrI7adEPN6fYPrX97pJNL
	j54//11I/fWj5XddcjO71yyRb972de3jZb/UWMX/lc1ZrjTd036Gy/L/Z9WFY/eFKLEUZyQa
	ajEXFScCAO3MWe0/AgAA
X-CFilter-Loop: Reflected

The variable 'i' should be incremented after dev_dbg(), or print
gen->hdr.handle instead. Otherwise, the handle value of the next loop
will be printed. Furthermore, in the final loop, accessing 'handles[i]'
will cause a buffer overflow.

Signed-off-by: Kwangjin Ko <kwangjin.ko@sk.com>
---
 drivers/cxl/core/mbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index a38531a055c8..84014aa01c95 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -913,9 +913,9 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 		struct cxl_event_record_raw *raw = &get_pl->records[cnt];
 		struct cxl_event_generic *gen = &raw->event.generic;
 
-		payload->handles[i++] = gen->hdr.handle;
 		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
-			le16_to_cpu(payload->handles[i]));
+			le16_to_cpu(gen->hdr.handle));
+		payload->handles[i++] = gen->hdr.handle;
 
 		if (i == max_handles) {
 			payload->nr_recs = i;
-- 
2.34.1


