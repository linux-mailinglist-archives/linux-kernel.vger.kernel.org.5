Return-Path: <linux-kernel+bounces-127775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC248950C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B753D2847A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E733B5FDDC;
	Tue,  2 Apr 2024 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qD4nTD1W"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E402E5FB98
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055007; cv=none; b=X6C/nm3b4/p/zVcpnYQddEMPgenNp2YggVQ48JFgaXFJjq/9XVz4i5wjng4uTWRslAcx5egKIgvg/8mt5K9UJhgmPajZFbkvTlTlvi7DCeVNOFFjrBRByhfAVCqfhbg4at8jQLarTA47bYlosYgD03WLHKHVMXMW6KBT9Y4hKIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055007; c=relaxed/simple;
	bh=skrlb+udmHJr6YwUZrY1WRcr/O427a2JM9RLbFAS99I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=JxnMSvWQUOWpdghisMCsPKF1+uGAmpAPswDJzzrKnFdimePoh0vly/gC0Lotn9iVN8LCmdTebN+uMvSuWeOtgGab+9CTs7oLP8iKnkYFA2RIUV7owdq1dCZX3/vA9Qf4blmpw3JPS2tJl8FGvaagE4Zx1YntrRetiCxvcznoWiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qD4nTD1W; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240402104956epoutp031dbc90ab935794ea1900a08a881539eb~CcPLqHYQG0112701127epoutp03I
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:49:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240402104956epoutp031dbc90ab935794ea1900a08a881539eb~CcPLqHYQG0112701127epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712054997;
	bh=9yxYze5dfhmoUzXm3YYn4+4ta1glAp8N1hUv35EAiy8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=qD4nTD1WhDjjkuqNYRC23DzipMCKVSsYbbnTQxZlJAjvFabLI/OBaGcVUYp3EKZGv
	 sSqby0wvgu/5wrF95HRLI+2FtepYTj+VwylurfUDy7oG5cq/d5aplSoYG+BTIEgTbD
	 hZffugVR/wpV5SfgRMEBZU9vB6C3aEetnEHc9jCw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240402104956epcas1p4e4d19ab17c55ed789ce042916e6fc34e~CcPLOvk0P0407704077epcas1p4C;
	Tue,  2 Apr 2024 10:49:56 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.225]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4V84QX2x8nz4x9Pw; Tue,  2 Apr
	2024 10:49:56 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	9C.96.09663.4D2EB066; Tue,  2 Apr 2024 19:49:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240402104955epcas1p3dd15334a1305b99f3e1b82000e3c7c42~CcPKkm5qS1277012770epcas1p3x;
	Tue,  2 Apr 2024 10:49:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240402104955epsmtrp22943788078e38fea8b1f9ea6c3e5fa98~CcPKj4ufE2469524695epsmtrp2n;
	Tue,  2 Apr 2024 10:49:55 +0000 (GMT)
X-AuditID: b6c32a37-557fa700000025bf-87-660be2d49e4d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F4.03.08924.3D2EB066; Tue,  2 Apr 2024 19:49:55 +0900 (KST)
Received: from parkseongsu-desktop.. (unknown [10.252.69.73]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240402104955epsmtip1658dffd28266f504c9c63b794f6c22ff~CcPKV7KAx1514115141epsmtip1Z;
	Tue,  2 Apr 2024 10:49:55 +0000 (GMT)
From: Seongsu Park <sgsu.park@samsung.com>
To: catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	sgsu.park@samsung.com, Leem ChaeHoon <infinite.run@gmail.com>, Gyeonggeon
	Choi <gychoi@student.42seoul.kr>, Soomin Cho <to.soomin@gmail.com>, DaeRo
	Lee <skseofh@gmail.com>, kmasta <kmasta.study@gmail.com>
Subject: [PATCH] arm64: Fix double TCR_T0SZ_OFFSET shift
Date: Tue,  2 Apr 2024 19:49:50 +0900
Message-Id: <20240402104950.170632-1-sgsu.park@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmnu6VR9xpBqsXi1j8/PKe0eL9sh5G
	i01t9xkt/mzczWTx5e9SZotNj6+xWlzeNYfNYun1i0wW7xu6WC0m/djCaNH++QWrRcsdUwce
	jzXz1jB67Jx1l91j06pONo/NS+o9+rasYvQ4dHYBq8fnTXIB7FHZNhmpiSmpRQqpecn5KZl5
	6bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAdyoplCXmlAKFAhKLi5X07WyK8ktL
	UhUy8otLbJVSC1JyCswK9IoTc4tL89L18lJLrAwNDIxMgQoTsjP2Xn/GVPCGs+Lgx8vMDYxH
	OboYOTkkBEwkpndNZ+ti5OIQEtjBKLF04m4WCOcTo8TaFc+gMt8YJe53HmGHaTmzdy8zRGIv
	o8SXyYuZ4VoeHZ/AAlLFJqAlsfpfL1iHiECoxOsZ68FGMQvMYpJYcHQvWJGwgIXEonXPwGwW
	AVWJG3fugNm8AtYSB1YcZIJYJy+x/+BZZoi4oMTJmU/AapiB4s1bZzND1LRySEzd7gphu0gc
	P3gAqldY4tXxLVBnS0l8freXDcIultj3ZQ1Ub43Eg3l7oGx7iY5nbUDzOYDma0qs36UPsYpP
	4t3XHlaQsIQAr0RHmxCEqSxxbqsjhCkp8WeBHsQMD4mO/RAzhARiJVasr5rAKDcLyfWzkFw/
	C2HTAkbmVYxiqQXFuempxYYFxvBoTM7P3cQITpxa5jsYp739oHeIkYmD8RCjBAezkgjvT2/O
	NCHelMTKqtSi/Pii0pzU4kOMpsDwnMgsJZqcD0zdeSXxhiaWBiZmRiYWxpbGZkrivGeulKUK
	CaQnlqRmp6YWpBbB9DFxcEo1MO3KtEwoF36aERG3/NTdW/zKDy4/2vnOK/b//QS3x8ZvZ+84
	0uqdus6bo/vF5szJia+vmT/d8XXN3Ls/Z6ftvCVYJxO0wjnspdVZycKtN1TXOH04GJtVecyD
	U//3TvP2k4zMV8p/PTwV/P/aHLu5Mds1P5dYH8z4LvXmod3UjG+NSVJBFptPRbhEbw+NEK6L
	f8DYH2LB936SVwv7r+93FeNd+uJnOide7klqPWE8t2db9bmeD9H8uff/x2o1lalflMrOmXlt
	67v3E5c5iN6/eXDCXjlTaZueWIW+Desf3eKO2NTv9sy58KXjyaUazgcOzzjlb71sgdejWVer
	5u57p3jmd69k7qmF+3n51F48YPijxFKckWioxVxUnAgAeL81vyUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSnO7lR9xpBm/ea1n8/PKe0eL9sh5G
	i01t9xkt/mzczWTx5e9SZotNj6+xWlzeNYfNYun1i0wW7xu6WC0m/djCaNH++QWrRcsdUwce
	jzXz1jB67Jx1l91j06pONo/NS+o9+rasYvQ4dHYBq8fnTXIB7FFcNimpOZllqUX6dglcGXuv
	P2MqeMNZcfDjZeYGxqMcXYycHBICJhJn9u5l7mLk4hAS2M0osXvWDVaIhKRE+7vLLF2MHEC2
	sMThw8UQNR8YJd58uMQEUsMmoCWx+l8vO4gtIhApcfbZRSaQImaBRUwSX9Y2MoMkhAUsJBat
	e8YCYrMIqErcuHMHzOYVsJY4sOIgE8QyeYn9B88yQ8QFJU7OfAJWwwwUb946m3kCI98sJKlZ
	SFILGJlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEB7qW5g7G7as+6B1iZOJgPMQo
	wcGsJML705szTYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv+IveFCGB9MSS1OzU1ILUIpgsEwen
	VAPT4fkMLQ89tyVcmXfsjst+pWddxqLXtBkauc9HX1MwWzXbcF613I/UJSfKtrzVfr8w/hWr
	cK6esXScZLJxzpbPOUzu1ddLVgrrehyfrv/N/k2SZxKHKYcCT/GH7aGPm991yXfVaFx+c0yr
	Zfkdr6QPjxYlRokErZ8l2tkpra68LPAuF9dxVoOSIv0fOlJattM53E5yrZs+3cLhSPbK4wU6
	88K4O2ouPLvI/8kx0PpqY+CEjbemT/JKKxKpf2me+f7x8beW6XHp33UWWN85+kpjAWtri5ZD
	4vq4WxIuOrJxEd/LbRX3tisLatUkXD5TbNfjecW5dz3PxN/WbPn7593+vG/+zLKf2w9GaPU+
	O6LEUpyRaKjFXFScCADu8mnD4wIAAA==
X-CMS-MailID: 20240402104955epcas1p3dd15334a1305b99f3e1b82000e3c7c42
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240402104955epcas1p3dd15334a1305b99f3e1b82000e3c7c42
References: <CGME20240402104955epcas1p3dd15334a1305b99f3e1b82000e3c7c42@epcas1p3.samsung.com>

We have already shifted the value of t0sz in TCR_T0SZ by TCR_T0SZ_OFFSET.
So, the TCR_T0SZ_OFFSET shift here should be removed.

Co-developed-by: Leem ChaeHoon <infinite.run@gmail.com>
Signed-off-by: Leem ChaeHoon <infinite.run@gmail.com>
Co-developed-by: Gyeonggeon Choi <gychoi@student.42seoul.kr>
Signed-off-by: Gyeonggeon Choi <gychoi@student.42seoul.kr>
Co-developed-by: Soomin Cho <to.soomin@gmail.com>
Signed-off-by: Soomin Cho <to.soomin@gmail.com>
Co-developed-by: DaeRo Lee <skseofh@gmail.com>
Signed-off-by: DaeRo Lee <skseofh@gmail.com>
Co-developed-by: kmasta <kmasta.study@gmail.com>
Signed-off-by: kmasta <kmasta.study@gmail.com>
Signed-off-by: Seongsu Park <sgsu.park@samsung.com>
---
 arch/arm64/include/asm/mmu_context.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index c768d16b81a4..58de99836d2e 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -76,7 +76,7 @@ static inline void __cpu_set_tcr_t0sz(unsigned long t0sz)
 		return;
 
 	tcr &= ~TCR_T0SZ_MASK;
-	tcr |= t0sz << TCR_T0SZ_OFFSET;
+	tcr |= t0sz;
 	write_sysreg(tcr, tcr_el1);
 	isb();
 }
-- 
2.34.1


