Return-Path: <linux-kernel+bounces-135217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 438A189BCDB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36DB2854BA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2D85339B;
	Mon,  8 Apr 2024 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qT3I7ohe"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9836352F87;
	Mon,  8 Apr 2024 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571508; cv=none; b=P088X65gfrJGZXgbgVGpaKUCvakvF3Go1PGLm/bwsdUnL7cNIke7qM6eExo3waGa3B6Bi//uo0LiRYP1WJHz21rCzxAJakP2pA8+QxacGJ0ha7FJ4Nvop/EXO7kPoMdoVp3wkFvPnCj6v6mam7INgakWiXndwq9/fz9CZRTk5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571508; c=relaxed/simple;
	bh=Jk5AfXpYJl/Ul0uWQBPecZhjRr/Z7t8CO1bBtCb5+qA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfCLPcbnCPWEifKTqFPz1Cmg0gvhsAg1xNa540nvfL7B93rG4XANhuAVDC/ueQASO4TDbqgPJDeWRudstOe3lb5E7guv3PZaogfinEyVYbxWHjCkJXaHtLf16a84YbMxc0MyGhhV+erkfXp9tLzAfPrlKXW4ABWEZD7EKFYYQYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=qT3I7ohe; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43850rVA005178;
	Mon, 8 Apr 2024 05:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=U6m2cDC0lG4V+OJfs4nMI2Z6AhEq3DduAGPDmmbhl9U=; b=
	qT3I7oheSuZKbXg4rSLcHWQsxyUGPavhCJwPShLxQVPLJt+hEicygncqgnLaIu0x
	kKiBhbC01AB0pqaMd8e4BTbQ7vXCZqnG3nzGvfKWXUnTLS+nD1BpKKwXirAsYXZj
	0bw0tpecsh1K1GXfMV3neAjadBtkN4seGHT0svMZPGcOgWcCsXINCbdKFEeCnYsM
	YN3Oosi22Hm0jZs/9tcNfmLtFh4v56mY/4mU1lEl8iDTkeOr6UF/efG1pQWXnMtU
	qhjM4HP4TinWzamCerpKzviCgvR9zOU3XaF+GX2Gtt4vQ/EnFg4R74egIXuRA2Pc
	PBhrsjihm/sHbFym9sQTqw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxhbbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 05:18:05 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 11:18:03 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Mon, 8 Apr 2024 11:18:03 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 36BE582024B;
	Mon,  8 Apr 2024 10:18:03 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 2/4] ALSA: hda: cs35l56: Exit cache-only after cs35l56_wait_for_firmware_boot()
Date: Mon, 8 Apr 2024 11:18:01 +0100
Message-ID: <20240408101803.43183-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240408101803.43183-1-rf@opensource.cirrus.com>
References: <20240408101803.43183-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 50B025tE5E7-lELiV888TYU8ZXrSmWhG
X-Proofpoint-GUID: 50B025tE5E7-lELiV888TYU8ZXrSmWhG
X-Proofpoint-Spam-Reason: safe

Adds calls to disable regmap cache-only after a successful return from
cs35l56_wait_for_firmware_boot().

This is to prepare for a change in the shared ASoC module that will
leave regmap in cache-only mode after cs35l56_system_reset(). This is
to prevent register accesses going to the hardware while it is
rebooting.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
This will have to go through Mark's tree because it's necessary
to make this change to the HDA driver before applying patch #3 in
this series.
---
 sound/pci/hda/cs35l56_hda.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 1a3f84599cb5..558c1f38fe97 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -644,6 +644,8 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 		ret = cs35l56_wait_for_firmware_boot(&cs35l56->base);
 		if (ret)
 			goto err_powered_up;
+
+		regcache_cache_only(cs35l56->base.regmap, false);
 	}
 
 	/* Disable auto-hibernate so that runtime_pm has control */
@@ -1002,6 +1004,8 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
 	if (ret)
 		goto err;
 
+	regcache_cache_only(cs35l56->base.regmap, false);
+
 	ret = cs35l56_set_patch(&cs35l56->base);
 	if (ret)
 		goto err;
-- 
2.39.2


