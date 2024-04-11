Return-Path: <linux-kernel+bounces-140219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B56C8A0D89
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D221F22D83
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AC9145B04;
	Thu, 11 Apr 2024 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="JbuVC4/8"
Received: from smtpcmd04132.aruba.it (smtpcmd04132.aruba.it [62.149.158.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD2A145B1E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829892; cv=none; b=HbLSyOMOl3Wu+8iGmCmXZ/9garET2ieMMzlKBSEcBQQ0XWilustFj4MpdZ2ny0yB2V31fq4RyMkkKuiA1ze/IyEli17mN6pdqujk2Mnf9AVflzOVLdxidZLILt/e0cYmG3aHOkx0ot+14TFTpSM9ET4ZThltD45UUJP2BwONQ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829892; c=relaxed/simple;
	bh=nIpuIakH5OdvyGzpVa3V+NZjXIk3yS3G1+ZnqBAjMo0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=DzmIc10fKXjsrRbcD7xYD3vz1NWLUnc6GIDFvtPu/AWLJ7w28rqZKac4kdMu+sSA1VD6bDoroYao6QbeFNY7BjtSxfZBVNNtId/PtAo+RCENUsWRY2QN/HMOkwr0CfnrnUjKmsFQsMits3pPYcdrkCyJ5FSbpT6/7c16TgRfNxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=JbuVC4/8; arc=none smtp.client-ip=62.149.158.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([77.32.15.153])
	by Aruba Outgoing Smtp  with ESMTPSA
	id urFSrBEe8oq80urFSrClJO; Thu, 11 Apr 2024 12:01:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1712829699; bh=nIpuIakH5OdvyGzpVa3V+NZjXIk3yS3G1+ZnqBAjMo0=;
	h=From:To:Subject:Date:MIME-Version;
	b=JbuVC4/8hlUfmpR+NjlDN4LUKw1xxiIGuepoeoYZxG2WDdj0eIjKL1jWa0mIEdr8U
	 zQQuk4Y8kPy1W51dEB3xGz9UOX78CImR1wsYMugVhA/O8EFxQtKc6FZ57HdTIbhik4
	 bMyhRxX3hLOhucCkek4S0r0R/LFfjKpvlH4IPgrS5BAQ66T21sL6CtxWQrn7Bn9P9u
	 dQAGVBt2y1Xosmwl9EdcjKfKTAKuRhCYsuNy9nk7c+OF2YgJFFRWLv2nyurcHc9S09
	 tmghNdPtot79oIvTZBHk/jVonAxsAeLQ8i0xRan5hdIMOkZrcNEAYiJUpgiK6gmS66
	 msxUksjQRGGtA==
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] regulator: pca9450: make warm reset on PMIC_RST_B assertion
Date: Thu, 11 Apr 2024 12:01:37 +0200
Message-Id: <20240411100138.366292-1-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfALfCiG6/UwoD22vS2fxw8jvM9zOcQ8+jsW//UGYiRrQgfSPAp+g5hff2ljnSOj3anJeb0ZuUA0A9zJO2MiEe2mV8wNcImFMTzxz7atg4GCslWx2GS7e
 3kVJdYJKbSEa+jGme3PmWksmExfi4XDqMiOSladw4y/uDZ7Xjn9bWDaOnC8A47s+VIK4XnCYRJGJSvtb5WvPBp6jkx9sgL8PoVifeKHIeZarngR3rw1UHPIW
 6epLUO9oHyB98XjRZ/EkveRS3oJfjbt/vSq1ABRq1eo=

Hello all,

sorry for spamming, this one have the correct email addresses.
This patch adds a property for to control reset behavior on
PMIC_RST_B assertion.

---
v1 ---> v2:
	- Fix email addresses

Fabio Aiuto (1):
  regulator: pca9450: make warm reset on PMIC_RST_B assertion

 .../bindings/regulator/nxp,pca9450-regulator.yaml     |  6 ++++++
 drivers/regulator/pca9450-regulator.c                 | 11 ++++++++---
 include/linux/regulator/pca9450.h                     |  6 ++++++
 3 files changed, 20 insertions(+), 3 deletions(-)

-- 
2.34.1


