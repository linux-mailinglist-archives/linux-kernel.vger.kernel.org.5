Return-Path: <linux-kernel+bounces-151768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 718568AB3A9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128981F23417
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D19813791C;
	Fri, 19 Apr 2024 16:47:52 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362A913AD39;
	Fri, 19 Apr 2024 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545271; cv=none; b=hDOIs3RH6vxxJcCl4OvJ9/F7zMvi4KkvGqpAMWhGcVjBJSQBsizfcMhSElqAH5f0/Kma31kJb9uSPl0AE4mlYhlXVy7+7q88lo1Ks954JHK0Lbxt2e/e7wQtPaAvR2FCTAXiu9DlmBsIS6Pf+aYchjCDnMvEkcR7xhhnYwKq1JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545271; c=relaxed/simple;
	bh=N/KbKABNeanEm1VOOHMlDsmLILPdeTsV4rqskWWMfv8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHqcOdE1zc4inKDTU5ygLpVrEtS4uGYmqTmHpMx1faYCn6RABJT5niTiOniHM8TdgAMUpncFNv03MuD0TCh2+tZ8gjJAG4iAsaTFzy9wjpatvSS9+r3XKChN2AqIkwwdhqEZETDvZCnrsrKi4q65UFkxIJPEJ1ypxD/q0v4qkGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VLgWB0pdKz6JBJF;
	Sat, 20 Apr 2024 00:45:42 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 17014140D1D;
	Sat, 20 Apr 2024 00:47:48 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 17:47:46 +0100
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH v8 06/10] ACPICA: Add __free() based cleanup function for acpi_put_table
Date: Sat, 20 Apr 2024 00:47:15 +0800
Message-ID: <20240419164720.1765-7-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240419164720.1765-1-shiju.jose@huawei.com>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add __free() based cleanup function for acpi_put_table.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 include/acpi/acpixf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 3d90716f9522..fc64d903a703 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -492,6 +492,8 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 					    **out_table))
 ACPI_EXTERNAL_RETURN_VOID(void acpi_put_table(struct acpi_table_header *table))
 
+DEFINE_FREE(acpi_put_table, struct acpi_table_header *, if (!IS_ERR_OR_NULL(_T)) acpi_put_table(_T))
+
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_get_table_by_index(u32 table_index,
 						    struct acpi_table_header
-- 
2.34.1


