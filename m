Return-Path: <linux-kernel+bounces-83366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E248695BC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C481C21A35
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A664C13EFEC;
	Tue, 27 Feb 2024 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jP7HXWZ1"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B9C13B2BA
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042685; cv=none; b=j7ka0DslwE98/gg5XODrOBAxqiP2EtIePtSRoC80QYAjQ1ZyCC7P1WCnsfCmDBBhbhbDEOqe3Xlb94nMqq2noxDPEyD7tu3rMFj9RSwFkMkMkq8+kctoC1hZbg7I1bdV9vA+SD4x0IwQLxaLqW9DhB41RAGEdLWaU5IXSYRbcYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042685; c=relaxed/simple;
	bh=3Q+lbP9fpfOK+r0+ltKIMrTUg5KwkTJ8OyUxh867q+E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UBkzL82KgyHy3FJYgDend1DhLXw5ZgHeVw/cFgk+juP+QuFQUQ/XQfVA91Sh9MwvvpI8lOd9JqoEUePev5GB4T+NbGu8wEnjTaJ+fH8Lk9FYmHLyCDPQmwO+m9dfw6bBLpUGr0IrSyRTF3UTN2UoUb84vMm7vyM3qwbBVzciPRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jP7HXWZ1; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R7naY0028471;
	Tue, 27 Feb 2024 06:04:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=rojNcnfF
	9kJd7NdnnPnr+a5n3516+iqDUSRCgYKDbiQ=; b=jP7HXWZ1sy174BVMyYAyGyGm
	q+lQX/Z4Rbq/azUjZ9vzz1prFisFR22FsgwQORwxJdzqVWmPJFhxhQyNGNqx9gOJ
	QMEi38RXseHC1kESVzDHOiCVFg0RN4Jdb4umHWlropxP2Rbzh6SyrYq+pQ5Fac3I
	CCPrZpvajHlcotalKZh+sLj+/bgHmozPqh1mTvnV40KAMR2YDdq9Jn2GqNgHKZj1
	8fx5lwBPYZBtTd238D35+ub4uH44PSZnwMe6coGDZQJ+OkdoBLW/bF5ut4+gldxe
	5quMJYjSfEwD/uvt19gSFFA3/14n8/ECtT6WqoIpY//PZb+ssqGgFZVpezOQBg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3whbpe0xgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 06:04:31 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 27 Feb 2024 06:04:30 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 27 Feb 2024 06:04:30 -0800
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id EF4CC3F712E;
	Tue, 27 Feb 2024 06:04:27 -0800 (PST)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <bbhushan2@marvell.com>, <gcherian@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v4 0/3] Marvell Odyssey uncore performance monitor support
Date: Tue, 27 Feb 2024 19:34:22 +0530
Message-ID: <20240227140425.3418814-1-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: hXX9Xp2x5RJu1LtnKdCWpNZvF_UwbOv_
X-Proofpoint-ORIG-GUID: hXX9Xp2x5RJu1LtnKdCWpNZvF_UwbOv_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02

Odyssey is a 64 bit ARM based SoC with multiple performance monitor
units for various blocks.

This series of patches introduces support for uncore performance monitor
units (PMUs) on the Marvell Odyssey platform. The PMUs covered in this
series include the DDR PMU and LLC-TAD PMU.

v3->v4:
- Refactored the existing ddr pmu driver to extract the platform data

Gowthami Thiagarajan (3):
  perf/marvell: Refactor to extract platform data - no functional change
  perf/marvell: perf/marvell: Odyssey DDR Performance monitor support
  perf/marvell : Odyssey LLC-TAD performance monitor support

 drivers/perf/marvell_cn10k_ddr_pmu.c | 528 +++++++++++++++++++++++----
 drivers/perf/marvell_cn10k_tad_pmu.c |  62 +++-
 2 files changed, 515 insertions(+), 75 deletions(-)

-- 
2.25.1


