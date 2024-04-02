Return-Path: <linux-kernel+bounces-127531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 506A2894D3D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D426AB2269D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3785F3D996;
	Tue,  2 Apr 2024 08:14:17 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497693D962;
	Tue,  2 Apr 2024 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712045656; cv=none; b=psehWybz7Thgs3t+tKbAA/w++bC72O9moqL8UqWjFPXwIPLtklB/uzy36D6r+mLTfg3o93iJTBhtegjYQnOcNakNxJre5Iz597YCaoxN0oSCOeqfdAKSVtfSkmys/Zv1TLPG7N++m/CcJf5QHsmktJSogGAYwUfKb6TVQY5+7ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712045656; c=relaxed/simple;
	bh=eoISY2c2v/B1FMGOYohgcM1KuO0ti6gHETRwlcwUqEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i/6MMTB2d5vknPHq5uw+srOxCw3nvcAmkxh7TJSWV0GtasuFbJinMCI6jEoBbJW+AtKHeiPQCcLsQphXfk68/b9IWGI8va0+0Qxc/qifHbOA/lKau00oYHaOMg/qdhazQg3m0je5cxF+FKrQTJsYHOvElVqJ4QurkDEXM9wDGX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-5e-660bbe4fa232
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
Subject: [PATCH v2 0/1] cxl/core: Fix initialization of mbox_cmd.size_out in get event
Date: Tue,  2 Apr 2024 17:14:02 +0900
Message-ID: <20240402081404.1106-1-kwangjin.ko@sk.com>
X-Mailer: git-send-email 2.44.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsXC9ZZnka7/Pu40g69fxCzuPr7AZjF96gVG
	ixM3G9ksVt9cw2ix/+lzFotVC6+xWZyfdYrF4vKuOWwWtyYcY3Lg9Gg58pbVY/Gel0weU2fX
	e3zeJBfAEsVlk5Kak1mWWqRvl8CV8btnHmtBC1vFrPsN7A2MT1i6GDk5JARMJFZuaGeGsb+t
	2wNmswmoSUy6dpiti5GLQ0RgJ6PE7WVrwBLMAhESW5r6mUBsYYEwiSer77GD2CwCqhITfm4D
	G8orYCZxduM+doihmhLvZ31nhogLSpycCbGYWUBeonnrbGaQBRICjWwS/zb/YYJokJQ4uOIG
	ywRG3llIemYh6VnAyLSKUSgzryw3MTPHRC+jMi+zQi85P3cTIzAQl9X+id7B+OlC8CFGAQ5G
	JR7eG9u40oRYE8uKK3MPMUpwMCuJ8P705kwT4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmv0rTxF
	SCA9sSQ1OzW1ILUIJsvEwSnVwJgiVuhVfH+SWMLedydX1O52Ydvm49RoepzRWa7t78449rz5
	1zyf37dMKRLpW5MbPWnV3WePuYxOLKyOv7dF4dTjq67ms6ZXrpG4NHNqlktFtU3A5MqWO3NV
	3iopxz5/Ks8b7134PDlIZ5nkm/zyuzbSCj3T3gRNMJPszT1W/fgx+zRO64untimxFGckGmox
	FxUnAgAySN3eQAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCLMWRmVeSWpSXmKPExsXCNUPhia7/Pu40g6N7eC3uPr7AZjF96gVG
	ixM3G9ksVt9cw2ix/+lzFotVC6+xWRyee5LV4vysUywWl3fNYbO4NeEYkwOXR8uRt6wei/e8
	ZPJY/OIDk8fU2fUenzfJBbBGcdmkpOZklqUW6dslcGX87pnHWtDCVjHrfgN7A+MTli5GTg4J
	AROJb+v2MIPYbAJqEpOuHWbrYuTiEBHYyShxe9kasASzQITElqZ+JhBbWCBM4snqe+wgNouA
	qsSEn9vABvEKmEmc3biPHWKopsT7Wd+ZIeKCEidnQixjFpCXaN46m3kCI9csJKlZSFILGJlW
	MYpk5pXlJmbmmOoVZ2dU5mVW6CXn525iBIbVsto/E3cwfrnsfohRgINRiYf3wnquNCHWxLLi
	ytxDjBIczEoivD+9OdOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ83qFpyYICaQnlqRmp6YWpBbB
	ZJk4OKUaGJMk6myZpFc3XcsLXjBjjtOTf1OqZwveiPBTUs29KjmxVvzFGp7Qx2U3GRp/HT4T
	xv9XjK/xVdmOCa2aFQ//L78sKPKjymq/vahEwwnJuaZzN0isF5YM7FpbucdOoGrD/mPnrqt/
	/9V4+07gDOmdakkXvn7gazqa3SLjtzCTO58tdN/asKXz+ZRYijMSDbWYi4oTAS1wtlonAgAA
X-CFilter-Loop: Reflected

This patch fixes the issue of accessing incorrect values when getting
multiple event records in cxl_mem_get_records_log().

Changes from v1:
	1. Rewrite the commit message to indicate that it can read an
	   incorrect value, rather than causing a buffer overflow.
	   (feedbacked by Ira Weiny)
	2. Remove the following commit that has already been added into
	   the 'fixes' branch of the CXL repository.
	   (feedbacked by Alison Schofield)
	   
	   cxl/core: Fix incorrect array index in cxl_clear_event_record()

Kwangjin Ko (1):
  cxl/core: Fix initialization of mbox_cmd.size_out in get event

 drivers/cxl/core/mbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
-- 
2.34.1


