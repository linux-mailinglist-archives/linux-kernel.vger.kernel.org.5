Return-Path: <linux-kernel+bounces-74333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBE385D2EB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA819B20F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E603D0D9;
	Wed, 21 Feb 2024 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mC66qtBP"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A787E3D0A8;
	Wed, 21 Feb 2024 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505955; cv=none; b=qKU5LU4xcs787nqg6r4LQszA54Jl5rrhNFCX3T3ldZIvtt03F9l0RV9BQEPFDVgSpO6rp2B/aBwwICm39GLeLiXimY2NcQX6PLWKmzRUHEdeY/wXhzKapjyXdGJRUi5Bu1t8wdDF9eAdqKUXPttLRaVm3/WvV9CbRgPqS5lqIP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505955; c=relaxed/simple;
	bh=d3jM1See6GNvV3zMltfzhT+UZvh6ylF9ft68eX0CikY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i13hnp7K8/cmLw6KsWTrpYGSKhKtelNgEti9V5jKlDIvLaQ3dDlqHsg7GykKraDjiPduUNznhs67e0BEOWodPtMtPbRo7/aYI5lIWAB9d83kXsrl9d3Pg9ERAM9D7zg7jsYEIp5KF1dseOTKtL0lDq0v18l5KU/SU309NCEG1NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mC66qtBP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L6hBVq030354;
	Wed, 21 Feb 2024 03:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=DKIM; bh=jmvv8BdlP4Ef
	MWvH6myTB5u41s/m86pGC7nOg4+WO/k=; b=mC66qtBP0LrK/hXkuovfHKvTw/uR
	KawN0DcUuciUqohLUGyoddpI2je/sfntY4y2UcmXjB5KpX3zk4iPB0ogjQkd6lCk
	V23hNd4p8jf85zn1DipYKu1yp2sPMPbWiBVM8w4jAQqolrPuZegLQnhb8Fxk8i9/
	Iv19YZod6k3kOBWqTUZsLUtq4O6k+jE/vREwbW90UB3Z5CZN4cQw8IOLspt7t2Xj
	cuhN7Gqhbhy6aOqRr8qT2JlihJoEQi8iHcxp2GsGeTC76S8lRFnmYAPgmpF+zTMB
	MCtEQYNhFpdzt9TNUlS7ldfEKpX4Lv523M/JvZO71FQiX9CVm91e64ePrg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3wd21gartj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 03:59:05 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 41L8x3XX041505
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Feb 2024 03:59:03 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 21 Feb 2024 03:59:03 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 21 Feb 2024 03:59:02 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 21 Feb 2024 03:59:02 -0500
Received: from rbolboac.ad.analog.com ([10.48.65.135])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41L8wqJ9004732;
	Wed, 21 Feb 2024 03:58:54 -0500
From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>
CC: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH v5 0/3] adis16475 driver documentation
Date: Wed, 21 Feb 2024 10:58:45 +0200
Message-ID: <20240221085848.991413-1-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 9i7f1al4LocBAGLJVBwlxC3BsxnEXIg2
X-Proofpoint-ORIG-GUID: 9i7f1al4LocBAGLJVBwlxC3BsxnEXIg2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 mlxlogscore=734 mlxscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210069

Add documentation for:
- iio device buffers describing buffer attributes and how data is structured in
buffers using scan elements.
- adis16475 driver which describes the driver device files and shows how the
user may use the ABI for various scenarios (configuration, measurement, etc.).

This kind of documentation describes how the user can interract with the drivers
device files, showing the driver's particularities and we think all IIO drivers
need such a documentation and will benefit from it.
Having this documentation in the Linux Kernel will make it more accessible to
the user, seeing how it is in the same location as the code.
Analog Devices is prepared to add similar documentation for all new drivers (for
ADI components), and in time to also add documentation for existing drivers,
following the adis16475 documentation template.

Ramona Gradinariu (3):
  docs: iio: Refactor index.rst
  docs: iio: add documentation for device buffers
  docs: iio: add documentation for adis16475 driver

 Documentation/iio/adis16475.rst  | 406 +++++++++++++++++++++++++++++++
 Documentation/iio/iio_devbuf.rst | 152 ++++++++++++
 Documentation/iio/index.rst      |   9 +-
 3 files changed, 566 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/iio/adis16475.rst
 create mode 100644 Documentation/iio/iio_devbuf.rst

--
2.34.1


