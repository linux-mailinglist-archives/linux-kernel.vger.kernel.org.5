Return-Path: <linux-kernel+bounces-117297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F0588A9C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0CA31C366D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1710116ABC9;
	Mon, 25 Mar 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="UA6FZVGf"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBECA157A6E;
	Mon, 25 Mar 2024 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378520; cv=none; b=ZlNhJB0dZwbURtU3NcxAcFi40UfseaTZQhqWwV17XpLRmbLC48ho6wYqkNegi5z3HtXrsz2hFa66Ox+av2aPsyV3bJ3zXl+pznMFpWqnj8SyslUm81Isht0sVQAYjdolO3x9DPMQjBILybR3BQxzBZWFWRH7XxShi14JrgqKG3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378520; c=relaxed/simple;
	bh=OUTG06nJDlO6TyRUnO74rozzjf6s+aA5Hb3q1CX7FjU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PTek0qUlwh9tVRQPltvtzRWaMQcQMDkZZ6nMCrxmFwBOmtUiYHPkmXwYdQ8PS8QrmLOstJOiOjvoY6yey5g8bzRzeqeHj5T/y0NbgHaja7iXrXGwrdP5cZmQDQP/hkAkbp8ekObcmLSjD4e2Gs+qCs0uIzNMMUNNRVxGGNzGO9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=UA6FZVGf; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P3P0eY021761;
	Mon, 25 Mar 2024 09:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=W
	iglk1r0cdxZ5D6UfXZHUlMlHakoY8HthLuTK4xjf0k=; b=UA6FZVGfwAyKfRlaD
	L4L8q2mSseLEdZFSrCj4C811itT4Nnraulv3reSfs2WweNpX6I6rigQT9K1qibYQ
	wGUj3kxdKkVx7d/V4F6hljpO6luHX+zZAOScrs9YUA21ibGr7Wx3C7VITJfkzqwE
	Zv30KrEsV8WX8+XXbCkJTBb7jTrS3YPMy+yJEp0pmZigIGGeAZOzbO+4ahnVDihX
	zrE/09DPZ7rA/1OmIeasmBo1LSt4wVeBchPbT6YdVzTbJ/0vXIE7s1fzbxQ3jHdK
	DpStjGZG0RJyiB0skkq9RgZY6QuwZjM3RRWBGYkZZvru3JV8v8pIG4L4nsb6J+sO
	GXA+g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x1vfybjc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 09:55:13 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 25 Mar
 2024 14:55:11 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Mon, 25 Mar 2024 14:55:11 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id EEEE2820244;
	Mon, 25 Mar 2024 14:55:10 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda: cs35l56: Set the init_done flag before component_add()
Date: Mon, 25 Mar 2024 14:55:10 +0000
Message-ID: <20240325145510.328378-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xYezW5GbRV6U63GUk9w_nk9e9zLQz_H-
X-Proofpoint-GUID: xYezW5GbRV6U63GUk9w_nk9e9zLQz_H-
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

Initialization is completed before adding the component as that can
start the process of the device binding and trigger actions that check
init_done.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier")
---
 sound/pci/hda/cs35l56_hda.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index f3c5715f5e02..1a3f84599cb5 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -1045,14 +1045,14 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
 	pm_runtime_mark_last_busy(cs35l56->base.dev);
 	pm_runtime_enable(cs35l56->base.dev);
 
+	cs35l56->base.init_done = true;
+
 	ret = component_add(cs35l56->base.dev, &cs35l56_hda_comp_ops);
 	if (ret) {
 		dev_err(cs35l56->base.dev, "Register component failed: %d\n", ret);
 		goto pm_err;
 	}
 
-	cs35l56->base.init_done = true;
-
 	return 0;
 
 pm_err:
-- 
2.39.2


