Return-Path: <linux-kernel+bounces-64735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FE985421D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FFD928C2C8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F313BE7D;
	Wed, 14 Feb 2024 04:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Nu/CrzEj"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D3710A0F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 04:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707886340; cv=none; b=FEmJp3Ktp3Ya+QWqKS0kVQLoojO4mgj3FZ8JQKQm0msElLry76FyYb+u3dvLbOU95NRelmnhrys0cLoA3lQhmUkqrckZF9cavohrorDusDTOrUOTgPq+jNN+YZron06I1I0jldgodMuZnMYawwA2IvOUln6AvaPNArvmjOynO6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707886340; c=relaxed/simple;
	bh=PFUgXz8ct68KZJ5vFMzy6RkzeKCtmazpm9FVQ9KKOdk=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=c8ItOinif+imDhTtmaYvtuZKzk5tsucCr24vi4pVNdbTZ+DJI8YMyAUnch5T5unsEwaa8RakEH9ZC/0Pe47QFDb3Gxi0wZxLtStP9hA+OdL6Gw7sCudBpTj/gwF8APXQf65ot4WQHu7yF3QlLGRp/tV2DHY4jMlm0tfHzJk6Z14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Nu/CrzEj; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240214045215epoutp022d0250dd80ee487f3d19417a7d86fff0~zoZLRDaul1362713627epoutp02W
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 04:52:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240214045215epoutp022d0250dd80ee487f3d19417a7d86fff0~zoZLRDaul1362713627epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707886335;
	bh=nSvBImm0z35kzVe3ZgLeWjkV2Pt4Ri5HJ6q+F34gkW8=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=Nu/CrzEjQBSsP5ngoHzw41z2OH2uuAgsty4ZnhK2YXBfVGJMC/622/gQ+O+vBEohf
	 vP/p/sNIKgvR2IgSolzdBUZTtQS6Lo50SN3FGxCDuner6r0fcrLet2D6vVu0ux7+6G
	 RgBCU2wtL3XZWt2xfrzbz4iZFh6vqkExCwNMAO38=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240214045215epcas2p422724170d640ab4e1676ee1b485ae724~zoZKtilBu0418904189epcas2p4U;
	Wed, 14 Feb 2024 04:52:15 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TZQly3JKQz4x9Px; Wed, 14 Feb
	2024 04:52:14 +0000 (GMT)
X-AuditID: b6c32a48-963ff70000002587-71-65cc46feebea
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	24.FF.09607.EF64CC56; Wed, 14 Feb 2024 13:52:14 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH] perf: CXL: fix CPMU filter value mask length
Reply-To: hj96.nam@samsung.com
Sender: Hojin Nam <hj96.nam@samsung.com>
From: Hojin Nam <hj96.nam@samsung.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
CC: Wonjae Lee <wj28.lee@samsung.com>, KyungSan Kim
	<ks0204.kim@samsung.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "will@kernel.org" <will@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240214045214epcms2p81d2ea826483fb4aecf19930f2755d55b@epcms2p8>
Date: Wed, 14 Feb 2024 13:52:14 +0900
X-CMS-MailID: 20240214045214epcms2p81d2ea826483fb4aecf19930f2755d55b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdljTQvef25lUg3mNwharFl5jszi6h8Ni
	0+NrrBbnZ51isbi8aw6bxdLrF5ksWu6YWmy8/47NgcNjzbw1jB4tR96yemxa1cnmsXlJvUff
	llWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE
	6Lpl5gBdo6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2x
	MjQwMDIFKkzIzpiwybrgEl/FtJVTWBsYv3N1MXJwSAiYSOx7otLFyMUhJLCDUeJl51wWkDiv
	gKDE3x3CXYycHMICthI7Ds5nBrGFBOQk9pw4zwIR15BY+/0wO4jNJqAmsfD+JbAaEYEqievv
	nzKBzGQW2MYk8ffhUkaQhIQAr8SM9qcsELa0xPblW6HiGhI/lvUyQ9iiEjdXv2WHsd8fmw9V
	IyLReu8sVI2gxIOfu6HiUhKf7m6CihdLzN6/DCpeILHixyKoXfoSjdffs0H85Stx7bI/SJhF
	QFViyYtOVogSF4lvM9aB2cwC8hLb385hBilnFtCUWL9LHxJSyhJHbrFAVPBJdBz+yw7z1I55
	T5ggbCWJ/R2tUMdISNw5cRnqGA+Jm20rWCAhGCjx8Nh7xgmMCrMQ4TwLyd5ZCHsXMDKvYhRL
	LSjOTU8tNiowgUdscn7uJkZwotTy2ME4++0HvUOMTByMhxglOJiVRHgvzTiRKsSbklhZlVqU
	H19UmpNafIjRFOjjicxSosn5wFSdVxJvaGJpYGJmZmhuZGpgriTOe691boqQQHpiSWp2ampB
	ahFMHxMHp1QD04QjF7lnLg8V93XNMfIW70xiytO4dCfBt6b82dd7d7MqQnuiQx5Olt41ReLY
	Rm2dly+KBKW72nfcOnuvXW7WZ6v/heoJrPVHtX63rHKyvH1/1g/WU6Icko+TPv1zU9+rMKfj
	g46A9iS+TSvLu365f+HYuT9rZVNgjfJKrQ2+RXNldkVpC98TqSzlZ9+VeOL1rtcVmW88WPb/
	2vpcVrPWc6bunJzO1cdbvSKcf/Nk3c2oqssMv27pNHPu5/2LFpiunxDy6tG//PLoKhapsNi5
	YYKlShyuTYJCRmp/bln08/z1t1fnNbtg+PF4u0bOtGk/ispiWk8Jr1tUNmuHnXrpLM/rB07H
	iS32n3NvdWGAEktxRqKhFnNRcSIAgqannR0EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240214045214epcms2p81d2ea826483fb4aecf19930f2755d55b
References: <CGME20240214045214epcms2p81d2ea826483fb4aecf19930f2755d55b@epcms2p8>

CPMU filter value is described as 4B length in CXL r3.0 8.2.7.2.2.
However, it is used as 2B length in code and comments.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Signed-off-by: Hojin Nam
---
 drivers/perf/cxl_pmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 365d964b0f6a..ca5e92f28b4a 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -59,7 +59,7 @@
 #define   CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK     GENMASK_ULL(63, 59)

 #define CXL_PMU_FILTER_CFG_REG(n, f)   (0x400 + 4 * ((f) + (n) * 8))
-#define   CXL_PMU_FILTER_CFG_VALUE_MSK                 GENMASK(15, 0)
+#define   CXL_PMU_FILTER_CFG_VALUE_MSK                 GENMASK(31, 0)

 #define CXL_PMU_COUNTER_REG(n)         (0xc00 + 8 * (n))

@@ -314,9 +314,9 @@ static bool cxl_pmu_config1_get_edge(struct perf_event *event)
 }

 /*
- * CPMU specification allows for 8 filters, each with a 16 bit value...
- * So we need to find 8x16bits to store it in.
- * As the value used for disable is 0xffff, a separate enable switch
+ * CPMU specification allows for 8 filters, each with a 32 bit value...
+ * So we need to find 8x32bits to store it in.
+ * As the value used for disable is 0xffff_ffff, a separate enable switch
  * is needed.
  */

@@ -642,7 +642,7 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
                if (cxl_pmu_config1_hdm_filter_en(event))
                        cfg = cxl_pmu_config2_get_hdm_decoder(event);
                else
-                       cfg = GENMASK(15, 0); /* No filtering if 0xFFFF_FFFF */
+                       cfg = GENMASK(31, 0); /* No filtering if 0xFFFF_FFFF */
                writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
        }

--
2.34.1

