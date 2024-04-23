Return-Path: <linux-kernel+bounces-155552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1508AF3D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB7D1C2287E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBD213D61C;
	Tue, 23 Apr 2024 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PECz7F2M"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C3113D52B;
	Tue, 23 Apr 2024 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889416; cv=none; b=NjLAq8gUu6zlpdXq/QAn9sEspEvTSGvkl9GoNFFhNNoVRG8y11x40QrSMoMPwh/OoQ0PSnlfHXx6yY91KzwrHtPwEvR6D0rbYuO9eZd4KA38tZq8iaEdg9wnEa7EOZU6oScSCGN8/9FP6u0kbhFL1KkqfAB1d20ECLdjhF7/OCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889416; c=relaxed/simple;
	bh=/+Ngmq/dET1hRbcDzT+tPPqrN7PjBb3QJe6Y4gicig8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fusssjh4rI4U9BM+Fec4z0Q8kPkwGC4fW3sBnurD5nb34MlQESANOuxQF3LoOAnnaIV9oB8cTbNN0u/P2CeFrmoQ/Hgf4t57jem0tapdq1RHmW5bsKu8OoYOrumhyEwtoQ0qYQFrHpZ/Q0NXFckGfaMIIi7Osl7DYDheR1R6+oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PECz7F2M; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N5gEEP003890;
	Tue, 23 Apr 2024 11:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=G
	JNcEy25j5fMRCp89ONq4zKfqjl5XmVRq/GtbPMf+60=; b=PECz7F2MtzUtpcDpf
	hP3F/a0n679BKHSX0MWAk/JXJJBdcGYCzuAT0iqL9htBoOsVq+3eo8HycVzx9jFc
	eJhMpihuAVd/BCtK0XZ6xQEmPtpVAnq+je9xn31LjEiuhD58OTP4rlYlGkYWULcD
	RteJyO/xNNMS8KUQKb6Wul8N8GfdH0B6hRjHAhUVA03HkSptSLBjMUCpwkDC68B2
	7VIP5xfmopuNRmJL/gIdGIumMY4oT3wJ0gVIBCRYgBOoTu7MNgyTy8x5kg5rX4cc
	jju6UOR83HKjha08Pek6QN3mR55nuQeNcI7X5CZC9E9lWvZfhQrdy01plY/jz/9V
	V0uNw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xmb3xttdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 11:23:09 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 17:23:07 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 23 Apr 2024 17:23:06 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.61.64.201])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 98769820243;
	Tue, 23 Apr 2024 16:23:06 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/2] Add support for Lenovo Thinkbook 13X
Date: Tue, 23 Apr 2024 17:23:01 +0100
Message-ID: <20240423162303.638211-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xkSXrS6qGavWCwbf3HrUTDjbD150W0Od
X-Proofpoint-ORIG-GUID: xkSXrS6qGavWCwbf3HrUTDjbD150W0Od
X-Proofpoint-Spam-Reason: safe

This laptop does not contain _DSD required to support CS35L41 HDA.
To workaround this, add support for this laptop into the configuration
table in cs35l41_hda_property.c.
Also add the required entry into patch_realtek for this SSID.

Stefan Binding (2):
  ALSA: hda: cs35l41: Support Lenovo 13X laptop without _DSD
  ALSA: hda/realtek: Add quirks for Lenovo 13X

 sound/pci/hda/cs35l41_hda_property.c | 4 ++++
 sound/pci/hda/patch_realtek.c        | 2 ++
 2 files changed, 6 insertions(+)

-- 
2.34.1


