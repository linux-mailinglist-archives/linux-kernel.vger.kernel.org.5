Return-Path: <linux-kernel+bounces-40356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE68083DEEE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE3C1F247CD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80921DFCF;
	Fri, 26 Jan 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hvZCoJXV"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5091D699;
	Fri, 26 Jan 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287233; cv=none; b=UKRaqvDKi5hEdzgaLT/gvKasCjO0sRN3xC+Mu/QXVpLDIcpx3k6DnkvPgxBHKnaXgsn12nCoLwJi+r0x+O7GcyXGN7u9m9wl7X8oLHdEZpM4l6GRQk2YB5yzi4L6XSlleEHuRTkgMm1+IoqOp9ZtlXqXQRFgoy4aBsSpSkDi9Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287233; c=relaxed/simple;
	bh=XZQHuTD5FIDvTNUrjY9LUKe33xlKgiI+9IzhlBCtJaw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X4ZwXJEsPNLPP8x2ONMuxKSIx/qqUyZp+rIMWMApMH34jL3qAg6bskEFuSk5/uuH6nYHGY97Sw3yIUQER2twtPCkKnoiuINKotD1v2aZc30tmQEGmNsaQTKpTlPkl+/9y1oVd5YS89BlY12y4fyJpg4t/8SQWGy7c/xFz1pzrgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hvZCoJXV; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QCpqG1002494;
	Fri, 26 Jan 2024 10:40:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=x
	+rYn+fBJ09p1znIq7mpKSHdq0YyMyl0BRtl4npcArQ=; b=hvZCoJXVt7ThopNOe
	Sp2lucdOaQay7chiQneS17GpIJBYrlJXb5SnAUgzUG1LahhM/SgPGZ8NvAh55Y8K
	kVqwgV2jB8c+zqPKQBpc6MemSLWm+xjFQT79P/njVo8mR5k5Stf1b9+Lia5jn9NH
	1ouwcDPVb5krc3Gh9BFHc3/0rHXj6Mwemg+DF2YCzl4+Wxbb3H1BZENvSABdDI2X
	XxDWDqat1qmbM24fYKR1aRRcPHGA7XNyFR2dd94WmdJlV4MzrqAZrdfF7AwNvhNW
	0bJ+DQxC3npHrS/Sn6QAbQ5h1qU7v1L9fXbu//sDjfd6dWr/AzJngSVjqMgX6GbU
	Vr2NA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9v1u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 10:40:16 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 16:40:14 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Fri, 26 Jan 2024 16:40:14 +0000
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (LONNG2L6RQ3.ad.cirrus.com [198.90.238.116])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 17FEF820246;
	Fri, 26 Jan 2024 16:40:14 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 0/4] Support HP Models without _DSD
Date: Fri, 26 Jan 2024 16:40:01 +0000
Message-ID: <20240126164005.367021-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3OGu4jccl7KovPSq68Yii0fAih0q1Dy9
X-Proofpoint-ORIG-GUID: 3OGu4jccl7KovPSq68Yii0fAih0q1Dy9
X-Proofpoint-Spam-Reason: safe

Add Quirks and driver properties for Dell models.
Driver properties are required since these models do not have _DSD.
Some models require special handing for Speaker ID and cannot use
the configuration table to add properties.
Also fix an issue for Channel Index property, when set through the
configuration table, to use the same method as when loading _DSD
properties. This is needed for laptops with 4 amps where the
channels do not alternate.

Changes from v1:
- Rebase on latest for-next

Stefan Binding (4):
  ALSA: hda: cs35l41: Set Channel Index correctly when system is missing
    _DSD
  ALSA: hda: cs35l41: Support additional HP Envy Models
  ALSA: hda: cs35l41: Support HP models without _DSD using dual Speaker
    ID
  ALSA: hda/realtek: Add quirks for various HP ENVY models

 sound/pci/hda/cs35l41_hda_property.c | 90 +++++++++++++++++++++++-----
 sound/pci/hda/patch_realtek.c        | 40 +++++++++++++
 2 files changed, 114 insertions(+), 16 deletions(-)

-- 
2.34.1


