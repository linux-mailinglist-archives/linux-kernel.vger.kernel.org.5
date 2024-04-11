Return-Path: <linux-kernel+bounces-140310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B364D8A1287
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45F51C20E83
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBA91487E6;
	Thu, 11 Apr 2024 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XjEhkZhK"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5ED1474C9;
	Thu, 11 Apr 2024 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833711; cv=none; b=HC7njKpHE55SBsJ27g+EdgYO+A2AVl2+f7zHcH1cWnMQPH9jSk4Xk2BwkzMJVxVgDETIyVx4kqgT2FTIiHP9IsSfQxuaJi/krn2tPMx3ZbhAOF023IOt5CUnS+qPbXke/DIwZXjLbFGY59QuIXWA69sV9hHmgQmnX1PXQojM0/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833711; c=relaxed/simple;
	bh=WE8aywv2td/MvVlWuBGjcgFxzQ9HR5GV4fL9GHl1Cv4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OUZPPi3OnrLkeQAQJMCAJo7DUs2GBCnm54T3q2LuduIWqF9i1zT3I4cIKZpUkXffdcgMuYPOjr5hWxK22KZwdeyxcaKIO0vHxnfhfr94pJBOpyUS3obK4aquTUWQKI4DEOvsU99BBc4sI+toY+0qtBZd0JHJbi06zj5FSB2GTAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XjEhkZhK; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43B5naJw004518;
	Thu, 11 Apr 2024 06:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=D
	79Rez7PJvpW2Si1z9kjEMVDWCn6Rpz4/F1YmXAVE5Y=; b=XjEhkZhKgHMaXOKGr
	4JmoAIVU+K5067DtGmDB1CW45w6yyJbPloZSbfzu34XIN+b3lfw37A0ILiNHBFCS
	6QrIVvCpRIuok7+b3D8oeSbib4JJeZBFyuPYW8fkXhyWzo1NfmhS24mlUSlESI7q
	ftCuDr5q7SwxVMusqBDtIsxPmko/KXM4z2ejcgQdpqwF0DaNSD1+MJwlsDmjvqIQ
	+frhfpzT2Nkhf0LCEJwOWDQDCEM5MJ03Ca4lUfeJJ5xQA5RL5nUi3AxsqwbtJYOn
	iMY5t9nrkyveRfMc1u15L8AOjRjmyZs7Yn4LDNy+ZHLpU+pNb23p86zfEmd0ViH0
	Pc8eg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjq7m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 06:08:17 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 12:08:15 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Thu, 11 Apr 2024 12:08:15 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.61.64.140])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3BC72820243;
	Thu, 11 Apr 2024 11:08:15 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 0/7] Add features, fixes and laptops for CS35L41 HDA
Date: Thu, 11 Apr 2024 12:08:06 +0100
Message-ID: <20240411110813.330483-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: a7_A5NFC7fRfi96eSrHxvNddiHitxgPP
X-Proofpoint-GUID: a7_A5NFC7fRfi96eSrHxvNddiHitxgPP
X-Proofpoint-Spam-Reason: safe

This chain adds a number of improvements for CS35L41, including a new
firmware loading feature, as well as some additional cleanup.

Patch 1 adds support for a new firmware tuning file which is used to set
special tuning parameters used by the firmware. The HP Omen laptop added
in patches 2 and 3 use such a feature.

Patch 4 changes the DSP1RX5/6 Source used by the firmware to depend on
the boost type. A similar change in the ASoC driver will be needed later.

Patches 5 and 6 are cleanup patches, with the first of those re-using
cs-amp-lib for calibration which as added for CS35L56 drivers, ensuring
that all laptops are using the correct calibration values.

Patch 7 fixes a small error in the CS35L41 Property table for the
Lenovo Legion slim 7 16ARHA7.

Changes since v1:
- Fixed print statements based on warnings from kernel test robot

Richard Fitzgerald (1):
  ALSA: hda: cs35l41: Remove redundant argument to
    cs35l41_request_firmware_file()

Stefan Binding (6):
  ALSA: hda: cs35l41: Set the max PCM Gain using tuning setting
  ALSA: hda: cs35l41: Support HP Omen models without _DSD
  ALSA: hda/realtek: Add quirks for HP Omen models using CS35L41
  ALSA: hda: cs35l41: Update DSP1RX5/6 Sources for DSP config
  ALSA: hda: cs35l41: Use shared cs-amp-lib to apply calibration
  ALSA: hda: cs35l41: Remove Speaker ID for Lenovo Legion slim 7 16ARHA7

 include/sound/cs35l41.h              |   5 +
 sound/pci/hda/Kconfig                |   2 +
 sound/pci/hda/cs35l41_hda.c          | 347 +++++++++++++++++++--------
 sound/pci/hda/cs35l41_hda.h          |   6 +
 sound/pci/hda/cs35l41_hda_property.c |   8 +-
 sound/pci/hda/patch_realtek.c        |   4 +
 6 files changed, 265 insertions(+), 107 deletions(-)

-- 
2.34.1


