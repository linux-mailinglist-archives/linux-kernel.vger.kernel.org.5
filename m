Return-Path: <linux-kernel+bounces-93746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD8F873424
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD555B2AC94
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2D25FBBA;
	Wed,  6 Mar 2024 10:25:04 +0000 (UTC)
Received: from out0-209.mail.aliyun.com (out0-209.mail.aliyun.com [140.205.0.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057CC5F566
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720703; cv=none; b=kXkOaXKfOxYWmkcdJFeEifZInCFeS33F3VBCXzF6hlBFSTke65ss4FyPtF76pLyAv0vImixOjkLpDthe0uiNRygWU3eTUFxPqjDnT34L0VdhSrwFjlvkOwNQs/0yAwTNg6rYJsFPECBG8aU2/8pzJFwqX2GfSyEpXE45TAbavhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720703; c=relaxed/simple;
	bh=IPelaOlLNzUGstOhPXdkzDn7BzmoqqeZFdhJ5KOY6+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WMPHn+u9UvgI1X58zrmJNKgrQ7gTN7QI0t4QAMtEVYWCnrw1mYQmI8fc11dhIHodknn3RZekX6L79k7RPy2rLai7g7dSlJ3K/f/ObWt5ksBi50LdLO8cg6ip5I+aiUJTJvv5GRMWto+OzuxLAqskfDIA1OZ3dLIKR/6igZySN5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=140.205.0.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047204;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.Wgbn-JZ_1709720381;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Wgbn-JZ_1709720381)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 18:19:41 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <jani.nikula@intel.com>,
   <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <intel-xe@lists.freedesktop.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 2/9] um: Fix the declaration of vfree
Date: Wed, 06 Mar 2024 18:19:18 +0800
Message-Id: <20240306101925.1088870-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
References: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
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


