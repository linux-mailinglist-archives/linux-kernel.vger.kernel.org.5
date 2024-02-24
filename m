Return-Path: <linux-kernel+bounces-79687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AE986256C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70001C20EEC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDF1487B0;
	Sat, 24 Feb 2024 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NW9o7oUc"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3726B482DD
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782787; cv=none; b=lMF1BPF7HLYD77a/hOB7hfLuvk3itz0pVArIALqbdTQnPcxmb5IkKTks4MfZEFBbHSJvx7ER5jncrLlCtb2XRDJ0+F4em2RnD+RzC4lyw7ncbAnifB/A4pMiQDpA+li6A/lxYTTkexIM5Sn3yo8CvdmsLdPEMNET1RmZQQxzYLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782787; c=relaxed/simple;
	bh=VWF64JLHhDBS2pWz1T4oErLsPpNC811AcQE+tvREolE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P5dNk3NhI50AHKG0uiATxEtrkMxwoq9zQnvy96XFz1lhNFSf1BuegzZk3dOcAfGBHFeAzmyOfJ/29O9wfchcRQ8eMa9KdVpR/v5ZIc6TGRG4ZRCq9icskPQ3ffHkFyjBF3AyPpS84FOk7aaRM2gh0rLopBy788YFNtAyiuXyCcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NW9o7oUc; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tm1yrXWwpayVhW0izRTuDBy0hwWeAWTE2v2krJfJP6w=;
	b=NW9o7oUcJ1oPsAYqMgb00gRou3FUu3uSSHnH5sYa2qqeMgWisTHbGqpoHn193JC4/gmY68
	Zq+CJvm+QeyYBRlvCxS8urLV2A1DxV8HiaAhTpXxg15OKntYMjYnA0zWxNShpxbf//UNHJ
	7OZQYLU2ZzlItCsW4ilQQ+Dsmjdmr3s=
From: chengming.zhou@linux.dev
To: rui.silva@linaro.org,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] usb: isp1760: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:52:56 +0000
Message-Id: <20240224135256.830413-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
its usage so we can delete it from slab. No functional change.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 drivers/usb/isp1760/isp1760-hcd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/isp1760/isp1760-hcd.c b/drivers/usb/isp1760/isp1760-hcd.c
index 76862ba40f35..0e5e4cb74c87 100644
--- a/drivers/usb/isp1760/isp1760-hcd.c
+++ b/drivers/usb/isp1760/isp1760-hcd.c
@@ -2521,21 +2521,19 @@ static const struct hc_driver isp1760_hc_driver = {
 int __init isp1760_init_kmem_once(void)
 {
 	urb_listitem_cachep = kmem_cache_create("isp1760_urb_listitem",
-			sizeof(struct urb_listitem), 0, SLAB_TEMPORARY |
-			SLAB_MEM_SPREAD, NULL);
+			sizeof(struct urb_listitem), 0, SLAB_TEMPORARY, NULL);
 
 	if (!urb_listitem_cachep)
 		return -ENOMEM;
 
 	qtd_cachep = kmem_cache_create("isp1760_qtd",
-			sizeof(struct isp1760_qtd), 0, SLAB_TEMPORARY |
-			SLAB_MEM_SPREAD, NULL);
+			sizeof(struct isp1760_qtd), 0, SLAB_TEMPORARY, NULL);
 
 	if (!qtd_cachep)
 		goto destroy_urb_listitem;
 
 	qh_cachep = kmem_cache_create("isp1760_qh", sizeof(struct isp1760_qh),
-			0, SLAB_TEMPORARY | SLAB_MEM_SPREAD, NULL);
+			0, SLAB_TEMPORARY, NULL);
 
 	if (!qh_cachep)
 		goto destroy_qtd;
-- 
2.40.1


