Return-Path: <linux-kernel+bounces-126584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5918939E9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37AF9281DDB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77228168AB;
	Mon,  1 Apr 2024 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="o2zjf41l"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B44B14002;
	Mon,  1 Apr 2024 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711965746; cv=none; b=p73V4pYVVhMmSSOk+R5YAbFzKzIK9HzV+kfsKcPC24qwgmbqUDbg4tW/54Uvt4zzzxMK5P+2mEjEj7sxhXFYRDcc8YY9TWWMT6fUUVsixn72MyXlFr2AxuFf6c49Q2u8c6/o1CNv2+IUUILmwCCUG7od/odd9FckMCZkprqb77k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711965746; c=relaxed/simple;
	bh=ytbdk9ATzNhhptJAmaMI5iRZMHBSQ9fDPjieda0njLI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o3GeS6IZ1bQV1OMWCiyZ4iNNFPXVdC4cbhJim0G2fhMHO8wplxojlZV2jgyK/CPc1xA9Xe67jEodQC0FsLk8TyFLXkmAvmHzgA9fZAbL2bSetrkskQYruhVEm4HX9Ng24a1BrWszrlb5DJ92U8q4/xXCcScuvj5vgAwRaFGHS6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=o2zjf41l; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4315mEb1029960;
	Mon, 1 Apr 2024 05:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=x
	mumbNjNL9Qc9iJkPT+r1AH89MXCDyiepBXJF4K8ti8=; b=o2zjf41l+aGw7EYV0
	4IrKW9iF/eROtep8mj4l8XHO4n0soMbiXmH+zEOLwERRQkJrXnDfpEmIIVVpcOY/
	X5jCN+San3zn4IuX0lvS0raKEOfLsnxOz+XlR7F1zb2d8u/9GcGrevmJfawtm9+C
	xn94iGoYDZ8nhAJfWqAZX8ok+k5t1MMt+sBnpjGQSaaeTycr1u8j7HuKTraz2/xj
	wR4Qw1oxyz+vaKRmYBBSo/WfDqZaLeSBYv0x3O9MAAPCnLL0GJ+dDSnwhSrKmhg4
	tp2e+AbiUm6IQhADbaGExzcPseZH08TA/S81wftn8MsI0jDfiHAEaZQ6IHPXBhqy
	bmSQQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x6g4xhtw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 05:02:12 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Apr 2024
 11:02:10 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Mon, 1 Apr 2024 11:02:10 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 2BA06820243;
	Mon,  1 Apr 2024 10:02:10 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v2 0/3] ASoC: Use snd_ctl_find_id_mixer() instead of open-coding
Date: Mon, 1 Apr 2024 10:02:07 +0000
Message-ID: <20240401100210.61277-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XbtUwJK1_38cS2DG-I7g7nom_euyCzv2
X-Proofpoint-GUID: XbtUwJK1_38cS2DG-I7g7nom_euyCzv2
X-Proofpoint-Spam-Reason: safe

The first two patches change snd_soc_card_get_kcontrol() to use the
core snd_ctl_find_id_mixer() functionality instead of open-coding its
own list walk.

The last patch adds a KUnit test for this, which was tested on the
original and modified code.

Changes in V2:
Only change is in the KUnit test (patch #3) to make the const strings
more consty.

Richard Fitzgerald (3):
  ALSA: control: Introduce snd_ctl_find_id_mixer_locked()
  ASoC: soc-card: Use snd_ctl_find_id_mixer() instead of open-coding
  ASoC: soc-card: Add KUnit test case for snd_soc_card_get_kcontrol

 include/sound/control.h   |  23 +++++
 sound/soc/Kconfig         |   8 ++
 sound/soc/Makefile        |   4 +
 sound/soc/soc-card-test.c | 184 ++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-card.c      |  21 +----
 5 files changed, 223 insertions(+), 17 deletions(-)
 create mode 100644 sound/soc/soc-card-test.c

-- 
2.39.2


