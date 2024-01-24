Return-Path: <linux-kernel+bounces-36855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9600D83A7B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4770728337A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF921B271;
	Wed, 24 Jan 2024 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="mMlvmbJs"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACCD20DFC;
	Wed, 24 Jan 2024 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095603; cv=none; b=HB1q4Gq+Gf956Rg5BuRBLPGKseL3lP0WMo+bDh8YtGyz9iAFKdXMHvfZ/fLU92o681xNem7Kgnr7+T7352OJRI6lU7/VNP3E4R3xA/scLGq8gaRb9lFUK/uZzDB9klet4JD+RowcNhc04CBmGLWM2WFwMW31BvplIETEjflJoC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095603; c=relaxed/simple;
	bh=kV/sxm1U0+3xpgRr2Rkrcgch+1wluHu/zLwXJZP8viE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mfosYgjD6hLOK8J0EjnvYi6S6pNgzNl9WLpHFPcWsCQ2M+puYcWFCYBsqllAA+q7hBiKCdqCHqHcRkcUYWCUYgaLisd6QRs/thrqi4c423ZIc6rgCGGHcCxRSQdH+XHr4Zqs24QpzwKwgmOVTG94JhiXHCWgerJT8DhK8O9e8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=mMlvmbJs; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O5ABQp018377;
	Wed, 24 Jan 2024 05:26:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=n
	5r0vO0PazysdxJ9oNYTV9c+7VMZDjyUxc5PUe3ztBE=; b=mMlvmbJsTn/xyJx+1
	Yh51sHFkK+56IgiIngJDJ/7ZFjU30Borj7BrF5jmEf4nZUV+s9saHkxz6vB6g9AL
	AxkZOhELxBREfMWcMwO4Z2xWtwkXsEXoKceXAKSFgp6Vx7lJeWDt6yE0K+DyJRMm
	IgW+HjJNl1qyvTfu1QGemaL0QaL6Ve0vmXavG7Y59wEq+wVZnFEeGQaiQE/i1l8j
	zzZ4bCeP4MVT57PeZdThPJXNtswrzxdJCz0yJYCn12roYKGKoBmMMRLAc1WDpg0p
	s/UTjdFWq9jnhq2QDKkgwxkt09K2M0ryBOc6b0cdlmQdUsvQZwmm8k9K/bDuztQ0
	cBY8Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmfhgqah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 05:26:19 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 11:26:07 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 24 Jan 2024 11:26:07 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.251.117])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 82E1B820243;
	Wed, 24 Jan 2024 11:26:07 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <tiwai@suse.com>, <soyer@irl.hu>, <shenghao-ding@ti.com>
CC: <perex@perex.cz>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH 0/2] ALSA: hda: Move component binding support into separate library
Date: Wed, 24 Jan 2024 11:26:05 +0000
Message-ID: <20240124112607.77614-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: twIJfo5xVnJV5rQPc3hZTj21K2X2vnK1
X-Proofpoint-GUID: twIJfo5xVnJV5rQPc3hZTj21K2X2vnK1
X-Proofpoint-Spam-Reason: safe

The Cirrus Logic amplifiers are currently paired with Realtek HDA codecs.
But they could be used with other codecs. To prepare for this, these two
patches move the manager side of the component binding out of the Realtek
driver into a library module.

The first patch tweaks the CS35L41 code so that it is not hardcoded to
CS35L41, and changes the TAS2781 handling so that it re-uses that code
instead of having a near-identical copy of it.

Can someone please test that these two patches don't break TAS2781?
I have checked that they should work in theory but I don't have hardware
to test on.

Richard Fitzgerald (2):
  ALSA: hda: realtek: Re-work CS35L41 fixups to re-use for other amps
  ALSA: hda: realtek: Move hda_component implementation to module

 MAINTAINERS                   |   1 +
 sound/pci/hda/Kconfig         |   4 +
 sound/pci/hda/Makefile        |   2 +
 sound/pci/hda/hda_component.c | 169 ++++++++++++++++++++++++++
 sound/pci/hda/hda_component.h |  59 +++++++++
 sound/pci/hda/patch_realtek.c | 217 ++++------------------------------
 6 files changed, 261 insertions(+), 191 deletions(-)
 create mode 100644 sound/pci/hda/hda_component.c

-- 
2.30.2


