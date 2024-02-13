Return-Path: <linux-kernel+bounces-63089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234D8852ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F211C21B71
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC28718E2A;
	Tue, 13 Feb 2024 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wUORoW8z"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E8218026;
	Tue, 13 Feb 2024 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812277; cv=none; b=NnFjIb/q9zYl//GF73DuyspW6gExuFqIQGTb8epMOYoo0pywhRFtc/Spl0VTn0OXbPurF5DF19yOn0sIUzvVh4Gcd6o+sVdXUrJsI+zXN5AgGgO8Jhc7/cJmD145aI9VsVnmE3g0Wemz6lDImAnvUs0CL/TNU20gUb8OGtMTMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812277; c=relaxed/simple;
	bh=JylogIJZukuCaWwS/VLftp3ASkKsQ1fIB4T0l/ZJ7Ys=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A7QVgtPlCh1M0peCQLnj6ciiGQQvpUpxBeyuiUNiIAgZ0NBjsQbRiuECkCZP9yTVTLydsMS4Yu9UorUytsSertzo/5SPPiapmXp4z7PDyN37SPhMsmjtCDGwKQZKclTWkvsMdd1Nxn+2/INIJ6+JDjB8xPmGK4tYKXr9hiGz3c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wUORoW8z; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D60Jhq005419;
	Tue, 13 Feb 2024 03:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=DKIM; bh=JYMLQr3GB6iV
	exzsK5eqR6fBUWPghlCTHVFQohd/4+0=; b=wUORoW8zt7BPLaT2aCpUszXSowpB
	SRLYkdnNqrD+uv3gqemOqm5NzzV8owa57QBYjW13Tf0ybNrfNmtDHOQF0Ob7Y63S
	yWaVucbb8bi9DaTGQzSwxcwgqxDbeFCfC1JyonHff90GWFyrvDTVPdvExEGvxDVq
	A1Wv6cJ26DYGxApP/L5XhXlwHVfp4MvGw7jNBgY7cqY7RLE7iHs0LYmGQWFt56uK
	134wPfOdVEHJ/g1j005jo9ir+RIcfqtrFXQGAfOvnCVktRGI6TAeb0ayTZceFpc0
	8WoFVE4iyR3Gsu2cGAnSdoDbsk+Nt1kdn44zqlC6hMTgMXMVH0RfqAK8zw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3w82sbrdn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 03:17:37 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41D8Habb020755
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Feb 2024 03:17:36 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 13 Feb 2024 03:17:35 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 13 Feb 2024 03:17:35 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 13 Feb 2024 03:17:35 -0500
Received: from rbolboac.ad.analog.com ([10.48.65.135])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41D8HPZB025896;
	Tue, 13 Feb 2024 03:17:27 -0500
From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>
CC: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH v4 0/3] adis16475 driver documentation
Date: Tue, 13 Feb 2024 10:17:17 +0200
Message-ID: <20240213081720.17549-1-ramona.gradinariu@analog.com>
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
X-Proofpoint-GUID: bj5Bk7TH-Dgi-ycQmftRV8NVh2F4tIfG
X-Proofpoint-ORIG-GUID: bj5Bk7TH-Dgi-ycQmftRV8NVh2F4tIfG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 mlxlogscore=612 impostorscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402130064

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
 Documentation/iio/iio_devbuf.rst | 125 ++++++++++
 Documentation/iio/index.rst      |   9 +-
 3 files changed, 539 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/iio/adis16475.rst
 create mode 100644 Documentation/iio/iio_devbuf.rst

--
2.34.1


