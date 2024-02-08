Return-Path: <linux-kernel+bounces-57373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFB184D79D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603721C22CB3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173241172C;
	Thu,  8 Feb 2024 01:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B7OATkgi"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0837E1CD21
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 01:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707356067; cv=none; b=gXCECZ5XRW/n9g2ClIzluYke5kURA2w/0H8lMmo+p9QbNXnEabGZGvm1ROC5FmbXnPnu3zfG1yVmxv3MGRQ6+8dsmdO+If/7U8KsEPAqEiH0hz44+uOXDbTYz4+Fo8n5+Remkx0eRyWwK8O1I6nZIpM1fbrgpx8ZrKjF3i2fS3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707356067; c=relaxed/simple;
	bh=vxTiQpGGb8vn3Fr5ySvGvzPYMt7hsbxXMN2SZEfErjU=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=QA7DETYlbabt+LqAIkKrK64qOcvKOEp+hGStSrI5nsOAeFXythHodoO1TWqcNMaGBkWWmu0aXQJjzyBjq0PiyV85Yzb1BcZrI/6xdSvbKUD2euuHfwN0GzjXWA6Z2seF/2PBVVy7oBlun+QsTp1lXHta1uDNAlQjc1Fx1wnKpCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=B7OATkgi; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240208013417epoutp0326337b525df36b63fa25432dc0f5712a~xv0m_2tlo2412824128epoutp03Y
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 01:34:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240208013417epoutp0326337b525df36b63fa25432dc0f5712a~xv0m_2tlo2412824128epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707356057;
	bh=86gvZtSeCMNrCtsyk+Iz52UnueTtZaTSI0sib+SSIOM=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=B7OATkgi9RlVqG4IS09GIORiRFUhI5bujI9qSkA+WZb9+apvDD6MqQWdYBwoa3IQF
	 VZ1BDJHczpkj3sJjwEieqplF6DjwOx3AQHWgJF4CeotLBd2OWl6ilZCHj6AyLLQ00W
	 ZWILLM5jgC8pMGln4fz29M1Gje9w8xvKNohjEgiI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240208013416epcas2p3098460d3a4f49fec0cd61a62bbb14441~xv0maZaAL1717617176epcas2p39;
	Thu,  8 Feb 2024 01:34:16 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.98]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TVffJ02Xnz4x9QH; Thu,  8 Feb
	2024 01:34:16 +0000 (GMT)
X-AuditID: b6c32a4d-743ff70000004a32-6f-65c42f976809
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	21.B6.18994.79F24C56; Thu,  8 Feb 2024 10:34:15 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v3] perf: CXL: fix mismatched cpmu event opcode
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
Message-ID: <20240208013415epcms2p2904187c8a863f4d0d2adc980fb91a2dc@epcms2p2>
Date: Thu, 08 Feb 2024 10:34:15 +0900
X-CMS-MailID: 20240208013415epcms2p2904187c8a863f4d0d2adc980fb91a2dc
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdljTTHe6/pFUg11HTS1WLbzGZnF0D4fF
	psfXWC3OzzrFYnF51xw2i6XXLzJZtNwxtdh4/x2bA4fHmnlrGD1ajrxl9di0qpPNY/OSeo++
	LasYPT5vkgtgi8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ
	0HXLzAG6RkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1pi
	ZWhgYGQKVJiQnbGi5QRTwV6eivYzx5kbGK9wdjFyckgImEg8ubGBrYuRi0NIYA+jREPzK9Yu
	Rg4OXgFBib87hEFqhAXsJY5ufc0IYgsJyEnsOXGeBSKuIbH2+2F2EJtNQE1i4f1LzCC2iECV
	xPX3T5lAZjILbGOS+PtwKSPEMl6JGe1PWSBsaYnty7dCxTUkfizrZYawRSVurn7LDmO/PzYf
	qkZEovXeWagaQYkHP3dDxaUkPt3dBBUvlpi9fxlUvEBixY9FULv0JRqvv2cDsXkFfCVW3zsL
	Np9FQFWi5eNnRpB/JQRcJHbvDwEJMwvIS2x/O4cZJMwsoCmxfpc+RIWyxJFbLBAVfBIdh/+y
	wzy1Y94TJghbSWJ/RyvUMRISd05chhruIdF5VAUSgIESNx92M09gVJiFCOZZSNbOQli7gJF5
	FaNUakFxbnpqslGBoW5eajk8dpPzczcxglOmlu8Oxtfr/+odYmTiYDzEKMHBrCTCa7bjQKoQ
	b0piZVVqUX58UWlOavEhRlOgnycyS4km5wOTdl5JvKGJpYGJmZmhuZGpgbmSOO+91rkpQgLp
	iSWp2ampBalFMH1MHJxSDUwqG0Ji3Tabfo7s/WRyeNLWt3/POqoyTix0Zt5xeqt3l7RF6bYp
	+T9Vlu3IFUr913n0OI/Cs52zt06cZDq3iK3XOSUix8lJYOIcx9gXZlH/Cw5kbeBMVJ8pyq73
	uWCny9tVp02Tb0rreoYutJ9ToP7iu4CR/bt0/f2/pz2wL3w1/WKmiDq7P88yPcEbu4TWV/rp
	NR3i9Zu0favwfbffRxm9/0uERvda3Xn2mPHZkonVocXP5jg9mc0eLOZkXWVuzvjrIP81WZXf
	sU2zNj84LnDjw+LTDO2qYV+P8x40Ps/07Xy+9/vN5SsWn19nfXjbwecyAsfY9kXXa89wVK91
	zFiutPzrPO2LhTObJh79MumYEktxRqKhFnNRcSIAY/aUkCIEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240208013415epcms2p2904187c8a863f4d0d2adc980fb91a2dc
References: <CGME20240208013415epcms2p2904187c8a863f4d0d2adc980fb91a2dc@epcms2p2>

S2M NDR BI-ConflictAck opcode is described as 4 in the CXL
r3.0 3.3.9 Table 3.43. However, it is defined as 3 in macro definition.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Signed-off-by: Hojin Nam <hj96.nam@samsung.com>
---

Hi Jonathan,
Sorry, I misunderstood your guide. 
I roll-backed to v1 patch keeping fixes tag. Thank you!

Changes since v2:
- Remove s2m_ndr_cmpm attribute and referecne added at v2 (Jonathan)

Changes since v1:
- Add s2m_ndr_cmpm event attribute
- Add fixes tag (Jonathan)


 drivers/perf/cxl_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 365d964b0f6a..bc0d414a6aff 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -419,7 +419,7 @@ static struct attribute *cxl_pmu_event_attrs[] = {
        CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmp,                     CXL_PMU_GID_S2M_NDR, BIT(0)),
        CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmps,                    CXL_PMU_GID_S2M_NDR, BIT(1)),
        CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpe,                    CXL_PMU_GID_S2M_NDR, BIT(2)),
-       CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_biconflictack,           CXL_PMU_GID_S2M_NDR, BIT(3)),
+       CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_biconflictack,           CXL_PMU_GID_S2M_NDR, BIT(4)),
        /* CXL rev 3.0 Table 3-46 S2M DRS opcodes */
        CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdata,                 CXL_PMU_GID_S2M_DRS, BIT(0)),
        CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdatanxm,              CXL_PMU_GID_S2M_DRS, BIT(1)),
--
2.34.1

