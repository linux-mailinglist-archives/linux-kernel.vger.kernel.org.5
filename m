Return-Path: <linux-kernel+bounces-135539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E8389C754
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838611C21BFF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EF113F00A;
	Mon,  8 Apr 2024 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dxPMnnPa"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817C313E8A5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587569; cv=none; b=cDxe0GdTMJlS6XmXykmZxKXcWYwfRXjC8aFUTKqJuFOTt2Ml1aqPvGexVcFHNhsahlZgFJhGvr1sAkl5J5w39mBGzIC0FZG6puOttN/lZNf9VL5nhJqzdEbi7w6lWPjXmN54y+iWuotECWeXTeV72bckm/JVHDfKyVTSniqyubk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587569; c=relaxed/simple;
	bh=1hW0DaNmTq5J/rKiXdEj/MW96pYC3rOF2yLgxAULt/w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fbr9of/etf66/dUhnu5SMjkKb0xa2TZ7Xl+O07Ljq8tS9ZKhIRybgCiJzGmMz50xo1F7RlPkovmJMzv6b0MP0tcbU18wMdkKdqBh5N+3JzOtK79KidUaAcWCLEPi5Wz1VPJTVTjTBC2c0A5q92Cb9V5ZSD+2PHHgh0VahqGxjJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=dxPMnnPa; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4385hvQl026412;
	Mon, 8 Apr 2024 09:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=x
	bNe7snvY3TI1XSPCm+tgj9SEguAj6+HMlh9McfB8os=; b=dxPMnnPaKNcKhWF35
	RjPwC8tDDt1uiSj3HjGO0i4m3UIopr5/OvHADMiKyiK+zLUHkA9tY1h+CNzm+kGg
	lA9JT7aQwaZTXMbRKQZ8ndfKuVNwLZ7uIFMqeewYCzyH9glJ35aPYm6T80Tzmqw9
	DHACJPw4c4AHMZzTAdFj6MVdk17Yosd/acsATwYgXnl8SPVV3l+PHkSRcVgrsriq
	e+uX5qpkpQLUQ+nABfXX7tz1ST//dwyqyQMgPK9DfspjVNqWL6rhcC6hOBZZikbx
	EErtCR9RfkKUCM4ILQLsjN4Jn9udl49lz3AD7TxO+qbkMw31bDvNbr4gK2rDDY/J
	wNY9w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxhjp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:46:03 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 15:46:01 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 8 Apr 2024 15:46:00 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id A8948820242;
	Mon,  8 Apr 2024 14:46:00 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 00/11] regmap: kunit: Add some test cases and a few small improvements
Date: Mon, 8 Apr 2024 15:45:49 +0100
Message-ID: <20240408144600.230848-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aUFO8PDiNtadGUrtY3VUVcQLi8S8C5aI
X-Proofpoint-GUID: aUFO8PDiNtadGUrtY3VUVcQLi8S8C5aI
X-Proofpoint-Spam-Reason: safe

This series adds some more test cases, mainly for testing:

commit eaa03486d932 ("regmap: maple: Fix uninitialized symbol 'ret' warnings")
commit 00bb549d7d63 ("regmap: maple: Fix cache corruption in regcache_maple_drop()")

And the pending patch ("regmap: Add regmap_read_bypassed()")
https://lore.kernel.org/linux-sound/20240408101803.43183-1-rf@opensource.cirrus.com/T/#m2b99b1e01872bfc3597e89dee57dcdd5dbaf1b55

There are also a few small improvements to the KUnit implementation.

Richard Fitzgerald (11):
  regmap: kunit: Fix warnings of implicit casts to __le16 and __be16
  regmap: kunit: Create a struct device for the regmap
  regmap: kunit: Introduce struct for test case parameters
  regmap: kunit: Run sparse cache tests at non-zero register addresses
  regmap: kunit: Run non-sparse cache tests at non-zero register
    addresses
  regmap: kunit: Add more cache-drop tests
  regmap: kunit: Add more cache-sync tests
  regmap: kunit: Use a KUnit action to call regmap_exit()
  regmap: kunit: Replace a kmalloc/kfree() pair with KUnit-managed alloc
  regmap: kunit: Add cache-drop test with multiple cache blocks
  regmap: kunit: Add test cases for regmap_read_bypassed()

 drivers/base/regmap/internal.h       |  14 +-
 drivers/base/regmap/regmap-kunit.c   | 994 ++++++++++++++++++++-------
 drivers/base/regmap/regmap-ram.c     |   5 +-
 drivers/base/regmap/regmap-raw-ram.c |   5 +-
 4 files changed, 765 insertions(+), 253 deletions(-)

-- 
2.39.2


