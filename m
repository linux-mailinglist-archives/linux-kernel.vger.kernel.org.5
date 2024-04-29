Return-Path: <linux-kernel+bounces-162614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E398B5E14
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8DB1C2162B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B252282D66;
	Mon, 29 Apr 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cDOcxxid"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6596B82C76;
	Mon, 29 Apr 2024 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405758; cv=none; b=UI+D1nHJ1Qfx9Ic5Wfm70fjg2kfUcbHXP4HAFGmytlE0oQpCOF9gipsb58wxU/dkNiZF+kFukZjghrndgDZGhJFNJgLCehxkFr7UQInBdOkKQruuZ5t+fpR0S+nvNtW3EUBBMom34F+XRpSXER4AWSCehpQBHMWWiZVjYjcjGZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405758; c=relaxed/simple;
	bh=R25+vm62+Ne8uiOdiOfEZlbX4DfhAhHpc4l0dOcBfxY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kQXHIof7RsH25WjylrdjOYhkiwK88J5PKawlXhP28ALVHmR9HQ2nEI3ERJSrsM52qlbUHWfzTiXioHU6y7XGVG/hzJrOnA1LyuCKc7BUEGmt03iBf75IToGEDPT3vGqC0a77vk5c0DvCp0Ms5g1HerkUqTbklU0BbgbHb+WlKsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cDOcxxid; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T6w4ko002816;
	Mon, 29 Apr 2024 10:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=9
	Z+InM3fGAIBxOq1qrvLElfhG+iCwLb2LgUarZtzndg=; b=cDOcxxidzkxxjOt5M
	11bdj7m5rDHIVLMxFkB8THi62G5cbFL8edirJQ3WCNfYaeWz2V1+kRbL/ZDQj7w/
	l3P5w1cvABbQlqMWhSS/uryoYvCIH/zTGpTQbuQZK95b78T4flBRA58rgH6PsMJe
	tW/bpXiuoHmzGzn6cIZvBOakzEDh3ZqZpefuDOyd9Eq5U3x3aclWg48ZYuPLd1Bv
	g7cSblqrBjHI1wgnQOhp1R8BvtLFdSQ+BAHJW5TVWrZu6JSYQSrU6pVI+Rj5N1mX
	/OEa6NChESpErmE2x1dvV+N/sS23clr5ZrfzbLGlipKTt3Ft950VjdPB0L3W7myL
	yTUaw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xrwsjj2yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 10:48:57 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Apr
 2024 16:48:56 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 29 Apr 2024 16:48:55 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.61.65.105])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id AB8D282024A;
	Mon, 29 Apr 2024 15:48:55 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/2] ALSA: hda: cs35l41: Ignore errors when configuring interrupts to allow laptops with bad ACPI to play audio
Date: Mon, 29 Apr 2024 16:48:51 +0100
Message-ID: <20240429154853.9393-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WkX4U-jiJGlRsx0YqXNZ_OE5832k4UuM
X-Proofpoint-GUID: WkX4U-jiJGlRsx0YqXNZ_OE5832k4UuM
X-Proofpoint-Spam-Reason: safe

Some laptops have a bad _CRS defined for its interrupt.
This errors out inside the driver probe for CS35L41 HDA.
However, there is no fix in software for this bad configuration,
and it is unlikely to get a new BIOS, therefore it is better to
allow the laptop to continue probe, instead of erroring out inside
the probe. The interrupt is only used for Error Detection and
recovery, without the interrupt the driver will continue to function,
but errors will not be detected, and recovery will require a reboot.

Also add support for ASUS ROG 2024 laptops.
These laptops were released without _DSD, so need to be added into
the CS35L41 config table. Quirks for these laptops already exist.

Stefan Binding (2):
  ALSA: hda: cs35l41: Ignore errors when configuring IRQs
  ALSA: hda: cs35l41: Add support for ASUS ROG 2024 Laptops

 sound/pci/hda/cs35l41_hda.c          | 69 +++++++++++++++++++---------
 sound/pci/hda/cs35l41_hda_property.c | 10 ++++
 2 files changed, 57 insertions(+), 22 deletions(-)

-- 
2.34.1


