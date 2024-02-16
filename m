Return-Path: <linux-kernel+bounces-68173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D692E8576D0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506422833BB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8CF168DA;
	Fri, 16 Feb 2024 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YxaKVr5v"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561C14AB0
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708068552; cv=none; b=oPRgdVZvTC5x22iflKoiWULMb9JN2xcL/OQrA2NH8mnf0F8S6WodrsX1xNIJxdhgWeaDBzpLnw9rQs2tCoWAGyprTxJ+rYEfsE5Pw64LzinEHXsqdfjVZ4/UjRiCdbLLVXMnETMu3iMaUoJzoGGI2Khjijn7WWpMK1y199RkJFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708068552; c=relaxed/simple;
	bh=Gyfbx0vJDrJRctepHsWeG3nVg/PbK0xYzWTC8y15jck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=Dum6vlkaTUrS9/f0z+jsG2hQUpUXG/yr/Sqh7PXxQ1egHRvWy2P1yZu2Lo0iPy0tokT5oAEGY3g0Js/Z5N+7ChbbtZ3+pAf2oNQBncYZoz8894FA7adJmM+BwiNNCGL+VOr7KCZUbrEPAzcZPDnGLecsRiS7SEm5dcUzuM7HSxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YxaKVr5v; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240216072907epoutp0240a84b11a96b98c888f6ebaed3c784cb~0R0tJdH-e0347003470epoutp02Z
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:29:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240216072907epoutp0240a84b11a96b98c888f6ebaed3c784cb~0R0tJdH-e0347003470epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708068547;
	bh=MbuHav9JQYc5yrQ5w1uGOfUVsUIb3wto/dHFe133xdQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=YxaKVr5vYi3pPUiFD7yLab6Lycgg6ySv6Lwi73F36fR7JJsBX1Pf0+qcLGNcSQss/
	 APvcPpdZhPZPD/nuIjB7WZm8t9YuDoLspJTTEZfpfporDaW1o0ebeEjBeT9AtkcEE+
	 nHAUjY6+irysdaNJ4z+RDCovvA1d7k4HOD5af6+w=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240216072906epcas2p429351aecb79c103108615d3f94162507~0R0sodnx92576025760epcas2p4A;
	Fri, 16 Feb 2024 07:29:06 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.92]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Tbk823Rmkz4x9QD; Fri, 16 Feb
	2024 07:29:06 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C4.64.18994.2CE0FC56; Fri, 16 Feb 2024 16:29:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240216072906epcas2p407a2f85aca1b9b8677fb8aa458c53aa6~0R0r40ub23018130181epcas2p4N;
	Fri, 16 Feb 2024 07:29:06 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240216072905epsmtrp22bafd0f9a0fbdd9e9cb97213c5c090b7~0R0r37XOZ2723827238epsmtrp2f;
	Fri, 16 Feb 2024 07:29:05 +0000 (GMT)
X-AuditID: b6c32a4d-00bd8a8000004a32-3e-65cf0ec2f91b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	80.5C.08817.1CE0FC56; Fri, 16 Feb 2024 16:29:05 +0900 (KST)
Received: from calab-Precision-7920-Tower.dsn.sec.samsung.com (unknown
	[10.229.83.132]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240216072905epsmtip29f0e68ea65f5f8ccb9dd8a9b7d119bf4~0R0rrUuSq2728527285epsmtip25;
	Fri, 16 Feb 2024 07:29:05 +0000 (GMT)
From: hj96.nam@samsung.com
To: Robert Moore <robert.moore@intel.com>, "Rafael J . Wysocki"
	<rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, ks0204.kim@samsung.com, wj28.lee@samsung.com,
	alison.schofield@intel.com, Hojin Nam <hj96.nam@samsung.com>
Subject: [PATCH] ACPI: Fix CXL 3.0 structure (RDPAS) in the CEDT table
Date: Fri, 16 Feb 2024 16:29:31 +0900
Message-Id: <20240216072931.34305-1-hj96.nam@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdljTTPcQ3/lUgy2/JSyezX3HYnH38QU2
	iw9v/rFYHN3DYbHz4Vs2i+X7+hktLu+aw2bxeMVbdouVn6awWGy8/47Ngctj8Z6XTB6bVnWy
	ebzYPJPRo2/LKkaPz5vkAlijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTy
	EnNTbZVcfAJ03TJzgI5SUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YW
	l+al6+WlllgZGhgYmQIVJmRn9L11LbjFWrFzwkLGBsa7LF2MnBwSAiYSZ/8/Y+xi5OIQEtjD
	KLFg1xtmCOcTo8TqT4eZIJxvjBIth7YDZTjAWr4cqoGI72WUuDz/AVRRD5PEr0n32EDmsglI
	SUz+cogdxBYRqJZYvvUWC0gRs8ApRokJt9cygySEBdwkWpqb2UCmsgioSrzqZAIxeQUsJZrm
	6kCcJy+x/+BZsGpeAUGJkzOfgJ3NDBRv3job7FIJgZfsEoduX2KEaHCROLG7lQnCFpZ4dXwL
	O4QtJfH53V42iAfyJT7thHq/QGJWz1qocmOJdzefs4KUMAtoSqzfpQ9RrSxx5BbUVj6JjsN/
	2SHCvBIdbUIQjUoS+ztamSFsCYk7Jy5D3eIhceDPUbD9QgKxEvtWdTBNYJSfheSXWUh+mYWw
	dwEj8ypGqdSC4tz01GSjAkPdvNRyeKQm5+duYgSnSy3fHYyv1//VO8TIxMF4iFGCg1lJhHdS
	75lUId6UxMqq1KL8+KLSnNTiQ4ymwPCdyCwlmpwPTNh5JfGGJpYGJmZmhuZGpgbmSuK891rn
	pggJpCeWpGanphakFsH0MXFwSjUwiTA+r7q7946Qm/WEjXGRrArXI0Kt1Q9mKLPO+dPmVN2i
	8aboyNMb8imm04/0THp2rv2ASthihqvM9V7Hgtj1Vu/dfU5x6cVpd2YHLrvh7Lng55KoDd4d
	5Zknnad9n9+0itNBuyvaU2eP1mvt8+vMHb+dfi3dq3r7c/qHAy+W/X/2NCB6bYSV50K/X5M3
	Pt7L+G7z3rNHfyra7jd1sC9skNHWNWLgK3uw++jTgEyud9b3XsXI+J9/I9XzfMvvv/EpuzWF
	dW6/1g08mXoye39O5cy55/9n6Oz8vj4oKPona692kXXY5fQrN+ZpZG4y0OKc4anzVbSpwP31
	n0v7n9/vf7VEu0jl1wmJJf4ZF9n765VYijMSDbWYi4oTAUYSq0kgBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWy7bCSvO5BvvOpBodPW1g8m/uOxeLu4wts
	Fh/e/GOxOLqHw2Lnw7dsFsv39TNaXN41h83i8Yq37BYrP01hsdh4/x2bA5fH4j0vmTw2repk
	83ixeSajR9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGX0vXUtuMVasXPCQsYGxrssXYwcHBIC
	JhJfDtV0MXJxCAnsZpTYvaGTqYuREyguIbH48U4oW1jifssRVoiiLiaJU4d+MIMk2ASkJCZ/
	OcQOYosI1Eo8WdjACFLELHCJUeLvr8tsIAlhATeJluZmNpBtLAKqEq9AFnBw8ApYSjTN1YGY
	Ly+x/+BZsJG8AoISJ2c+YQGxmYHizVtnM09g5JuFJDULSWoBI9MqRsnUguLc9NxiwwKjvNRy
	veLE3OLSvHS95PzcTYzg4NXS2sG4Z9UHvUOMTByMhxglOJiVRHgn9Z5JFeJNSaysSi3Kjy8q
	zUktPsQozcGiJM777XVvipBAemJJanZqakFqEUyWiYNTqoEpz+dCbVXmicP8Vz9sPt1Qd2qV
	2/TXPxJqlW2r3tr++5P+vebo0cAExTeiARxbp36eX5B6nNVLV0bPMbR74+rDOzh+s/xMFjgf
	+TOd8/MlAwNhd0NX7fnLuLQlPwUkCJ14KXm+YMm5oqzwMLGsP2VLpWr0Mq4FXp/ykuvrrtwJ
	TFvsj2xk3Pd6S8OjhUdfRGiaeO6I+d5aIemjzTR7t66IhvTvo3IL9L36GpP2xvcXmPFvDSq4
	xrWkccG3WyqMLZUXF6+TydHMO7qruefBsZSqnWr/e86d9ekr2cahf1qNs8Ys/pnIgc33vHu+
	vy9K3apw1Cmpa9e2BQ+/mF1/k9wl+Gb1GRn/lA9BdieeXe5UYinOSDTUYi4qTgQA3K79xc0C
	AAA=
X-CMS-MailID: 20240216072906epcas2p407a2f85aca1b9b8677fb8aa458c53aa6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240216072906epcas2p407a2f85aca1b9b8677fb8aa458c53aa6
References: <CGME20240216072906epcas2p407a2f85aca1b9b8677fb8aa458c53aa6@epcas2p4.samsung.com>

From: Hojin Nam <hj96.nam@samsung.com>

struct acpi_cedt_rdpas does not match with CXL r3.0 9.17.1.5
Table 9-24. reserved1 and length fields are already added by
struct acpi_cedt_header.

Signed-off-by: Hojin Nam <hj96.nam@samsung.com>
---
 include/acpi/actbl1.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index a33375e055ad..7aff8c39dbd6 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -571,8 +571,6 @@ struct acpi_cedt_cxims {
 
 struct acpi_cedt_rdpas {
 	struct acpi_cedt_header header;
-	u8 reserved1;
-	u16 length;
 	u16 segment;
 	u16 bdf;
 	u8 protocol;

base-commit: d37e1e4c52bc60578969f391fb81f947c3e83118
-- 
2.34.1

