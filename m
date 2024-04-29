Return-Path: <linux-kernel+bounces-162615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E018B5E18
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D189B24E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A1284A27;
	Mon, 29 Apr 2024 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="nxHjhMN+"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D421482C6B;
	Mon, 29 Apr 2024 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405758; cv=none; b=Od9G6ULL0UwXCC1mWZ6olhw7NDGVgB9vWbmE7nAuQKnqP8WpiAiT1GLf9Lig8GLNi5R7nk+VhK+Dzeye38ZiC2tY+1GQ56bFvBJo5zC1apBsXGuj784EBNvmUIoFAI7srGsi01sGoI7eG2/XU3vV/CMUruETFiiX9W9ZJpCS62g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405758; c=relaxed/simple;
	bh=3mw6rtABDCZZ+y8mq0TqU78G9uRbAoqq1Ix7EHzSQT0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqbnleTarMwwrVdFHE9gzQUv+ZmdjhqQSXhOUYuNWm1iBIik/43ZML8gnVGaIJEkiPEBpaCjiw/BScNvymPhl5XOaNix+KXGdRbIKUhmszYAiDHct+rvR1BYwVRgUzKnBIMYV1d0Y06ufMqRnfA58CUa8ZZ4AOa+lrXKsl0T6os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=nxHjhMN+; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T6vDHR000342;
	Mon, 29 Apr 2024 10:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=Xot4qV+EwjLjF2ltygsOgaGZdZnQADQAtNMb0oSFwo4=; b=
	nxHjhMN+eqtpnZqB3EJkceqYil1wTKeWZVzPkut1SwSaYFLL3Es7s8+lh8EhPlvz
	PWxKEj9WIK13vreK8SdYdcX0O5DJt5vK4geXXpbBdauuBgzt4pfyBBTlLQ8lmJ2l
	kkPYMDRL2x+3G7rWsCkcWypTxGyk1TWuCb9ptPix4VvtJne5HNW8HN7HpyDJayQQ
	TNNIdNVzSybWCbvx7sATyRvM/u9hRkSshj3Io3Hml8hKZ44ZDZKuaaRA3hX6DADK
	7IVqhUtQ3zDpHebDQoczeCo27fMSjcQGJSbvoCBCpPQCKhtAqQh5akpTiDMJaF8N
	1NHyXQiY1jzgzDGWteWEJw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xrxry21tq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 10:48:59 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Apr
 2024 16:48:56 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 29 Apr 2024 16:48:56 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.61.65.105])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3C65082024A;
	Mon, 29 Apr 2024 15:48:56 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 2/2] ALSA: hda: cs35l41: Add support for ASUS ROG 2024 Laptops
Date: Mon, 29 Apr 2024 16:48:53 +0100
Message-ID: <20240429154853.9393-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429154853.9393-1-sbinding@opensource.cirrus.com>
References: <20240429154853.9393-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UO_VahBEfXpKyROk5vZ0g2k_jZWlAJE8
X-Proofpoint-GUID: UO_VahBEfXpKyROk5vZ0g2k_jZWlAJE8
X-Proofpoint-Spam-Reason: safe

All of these laptops do not have _DSD, so need to be added to the
configuration table.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index be97e973accb..ad9b6abdf269 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -97,6 +97,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431863", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "104318D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "10431A83", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431B93", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10431C9F", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10431CAF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10431CCF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
@@ -110,6 +111,10 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431F12", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
 	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "10433A20", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10433A30", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10433A40", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10433A50", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10433A60", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "17AA3865", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
 	{ "17AA3866", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
@@ -492,6 +497,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431863", generic_dsd_config },
 	{ "CSC3551", "104318D3", generic_dsd_config },
 	{ "CSC3551", "10431A83", generic_dsd_config },
+	{ "CSC3551", "10431B93", generic_dsd_config },
 	{ "CSC3551", "10431C9F", generic_dsd_config },
 	{ "CSC3551", "10431CAF", generic_dsd_config },
 	{ "CSC3551", "10431CCF", generic_dsd_config },
@@ -505,6 +511,10 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431F12", generic_dsd_config },
 	{ "CSC3551", "10431F1F", generic_dsd_config },
 	{ "CSC3551", "10431F62", generic_dsd_config },
+	{ "CSC3551", "10433A20", generic_dsd_config },
+	{ "CSC3551", "10433A30", generic_dsd_config },
+	{ "CSC3551", "10433A40", generic_dsd_config },
+	{ "CSC3551", "10433A50", generic_dsd_config },
 	{ "CSC3551", "10433A60", generic_dsd_config },
 	{ "CSC3551", "17AA3865", generic_dsd_config },
 	{ "CSC3551", "17AA3866", generic_dsd_config },
-- 
2.34.1


