Return-Path: <linux-kernel+bounces-35185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91345838D46
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A356285B83
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A8D5D8FE;
	Tue, 23 Jan 2024 11:19:35 +0000 (UTC)
Received: from out0-218.mail.aliyun.com (out0-218.mail.aliyun.com [140.205.0.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729EF5C8EE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008775; cv=none; b=GBeFsBgz8ZjGcUWW84c+u9kbTlrJqAC7DBmb1JOiM6Ignp0Ve7aW/BG1qiEMr6zQ4HetZtAWWZN/roF0nLiySz07N9iE3wl9MmpvD8RrcHrv5HDoAL9Ef+ePcyslaVZcemz0QHkqsqZHPvJPu023yfjSCV7OI3O8B8RQZhWWkU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008775; c=relaxed/simple;
	bh=IPelaOlLNzUGstOhPXdkzDn7BzmoqqeZFdhJ5KOY6+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ThW3C3S/f5vYDBV3YGzU0z/P2qE/Tn5PhltSReoXDRMDoCd/pMiNvR9GaJRA/uZd9seF0G9QFPEhq0BdGWVHX3uyJg8JQxlDMfoWnzVBnvTVPUxLLTnJX2vYZdA0OX4u/lrxSMaxgtOWVhi+4ij12w3N3Pqqjoag6jzK5k9BszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=140.205.0.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047187;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.WDCKTjv_1706007836;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WDCKTjv_1706007836)
          by smtp.aliyun-inc.com;
          Tue, 23 Jan 2024 19:03:56 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 2/5] um: Fix the declaration of vfree
Date: Tue, 23 Jan 2024 19:03:44 +0800
Message-Id: <20240123110347.1274217-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123110347.1274217-1-tiwei.btw@antgroup.com>
References: <20240123110347.1274217-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The definition of vfree has changed since commit b3bdda02aa54
("vmalloc: add const to void* parameters"). Update the declaration
of vfree in um_malloc.h to match the latest definition.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/um_malloc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/include/shared/um_malloc.h b/arch/um/include/shared/um_malloc.h
index 13da93284c2c..d25084447c69 100644
--- a/arch/um/include/shared/um_malloc.h
+++ b/arch/um/include/shared/um_malloc.h
@@ -12,7 +12,7 @@ extern void *uml_kmalloc(int size, int flags);
 extern void kfree(const void *ptr);
 
 extern void *vmalloc(unsigned long size);
-extern void vfree(void *ptr);
+extern void vfree(const void *ptr);
 
 #endif /* __UM_MALLOC_H__ */
 
-- 
2.34.1


