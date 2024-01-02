Return-Path: <linux-kernel+bounces-14666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CB882207B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C20283512
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986F6156CB;
	Tue,  2 Jan 2024 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MoVk4T9P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0E2156C1;
	Tue,  2 Jan 2024 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jNvpvta8GOOXzK79HPGCC2uzyjG2iqLPj19fEAMpJlk=; b=MoVk4T9PPX+/W6v4NNlFrShtnY
	t++vAxX/BomhcaoZRJx5+MCX+sjrzAC4iY1e/7jSs5ncKzONUP4/Eb2g1XE/G0ZHndL3mtf6pNbyv
	rYKvSqFfy9FArD5JbAIfbCwY49pEp977qTqhStvOr0OPmJ3QTL1L2o+1OdZ9WfnrR0SXYrTHVcCtP
	Qt5B6WM1wMfq/sBmzQynfFMcdKpEn2MBS0IW3FInuwHjRtP5+O/SC4GiwRzp1LuC3Lewio7RtGkac
	wHHE7ltWngAO5atrT3j6awSIrk741fTiBMuFEk/tqKhrOVJPb3HtuhCgykzMP2UjvlV0foVzTKy4N
	FWXnqRPA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rKijV-008caA-2i;
	Tue, 02 Jan 2024 17:39:18 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Fan Ni <fan.ni@samsung.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/region: use %pap format to print resource_size_t
Date: Tue,  2 Jan 2024 09:39:17 -0800
Message-ID: <20240102173917.19718-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use "%pap" to print a resource_size_t (phys_addr_t derived type)
to prevent build warnings on 32-bit arches (seen on i386 and
riscv-32).

../drivers/cxl/core/region.c: In function 'alloc_hpa':
../drivers/cxl/core/region.c:556:25: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
  556 |                         "HPA allocation error (%ld) for size:%#llx in %s %pr\n",

Fixes: 7984d22f1315 ("cxl/region: Add dev_dbg() detail on failure to allocate HPA space")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Fan Ni <fan.ni@samsung.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
---
 drivers/cxl/core/region.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -553,8 +553,8 @@ static int alloc_hpa(struct cxl_region *
 				    dev_name(&cxlr->dev));
 	if (IS_ERR(res)) {
 		dev_dbg(&cxlr->dev,
-			"HPA allocation error (%ld) for size:%#llx in %s %pr\n",
-			PTR_ERR(res), size, cxlrd->res->name, cxlrd->res);
+			"HPA allocation error (%ld) for size:%pap in %s %pr\n",
+			PTR_ERR(res), &size, cxlrd->res->name, cxlrd->res);
 		return PTR_ERR(res);
 	}
 

