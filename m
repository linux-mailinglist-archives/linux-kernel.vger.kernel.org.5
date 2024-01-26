Return-Path: <linux-kernel+bounces-40049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82F983D95A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162651C2666C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B9714298;
	Fri, 26 Jan 2024 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="T/rY5rft"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B951AACB;
	Fri, 26 Jan 2024 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706268641; cv=none; b=YOUzRW3FwlhqJ7FNXl8svWqpA+42yLMUd50DFOLcm7G08TVkke3sX+Y8qbzUnHz14aDcXUsPA9QjAqpQBw0XZ0QxtTYcN5O12dhEpZCKSfxt16TvCL5wTS4a78ZgQeQCCCa/gz5f2rsYVHHjIpvY4HbXIQiMRxB0Cfd472A1oVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706268641; c=relaxed/simple;
	bh=TN0XrQV2h/QTnlDKi6o2lGP7iDmvEvgx0po8yYmRfmI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M6M5h9PZYIefCAqjfo7Cf8EgWcSJx/gh7AxmLaY9n7eQFHWbT89cimGRUweEEK/iByoBlTxq5cZ/2qDt7aNGGnaFf/qBrRi7CGiKtmObnq9qLNCo2A80FWTG4B5l+eWDPgmSwbg9AVylXFUfWNmmIDXgSMIWVuA5jLs0VwUFdIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=T/rY5rft; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QAq09q023770;
	Fri, 26 Jan 2024 05:30:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=0
	aT+NkSik14EJ6htlwQSwNMMDFmIeJnn5EUHgh1et3s=; b=T/rY5rftda/ip2nJ1
	+6fKOqYJ0UZ5tLhhXep70xWRo9EyHVjW1FPEUxpj5NCVEkxljTYCtFl6dJ3hs8jc
	YB5DlF9SsISFGM6cmrmiVP1AlUsu8n/DQBQT4duQykNiC2/dLYjNvOTU9isKwkG1
	MginvXXmEv7HAEMazev2NJg05WKaecp4IWIwcMkM8JwE0/rZufkp1HNaVDKxSCqE
	By0+UjL3uzU9te9RZI3cblHR1OQQdBUIl0Kv1p2dCRguvt5sVUk/v+wPAJA8MHjg
	oW5YDoEf2/0WwdCo9JKRPRCsNyKeX0K0nMrmU5zwvZs0sYa5W+zFGu+fKhYPOLw3
	tS0rQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9unnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 05:30:19 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 11:30:17 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 26 Jan 2024 11:30:17 +0000
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (LONNG2L6RQ3.ad.cirrus.com [198.90.238.116])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E6984820243;
	Fri, 26 Jan 2024 11:30:16 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/4] Support HP Models without _DSD
Date: Fri, 26 Jan 2024 11:30:03 +0000
Message-ID: <20240126113007.4084-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: lGKmo7_SMIXhX6X4S-eR_EDqP3JGrQP-
X-Proofpoint-ORIG-GUID: lGKmo7_SMIXhX6X4S-eR_EDqP3JGrQP-
X-Proofpoint-Spam-Reason: safe

Add Quirks and driver properties for Dell models.
Driver properties are required since these models do not have _DSD.
Some models require special handing for Speaker ID and cannot use
the configuration table to add properties.
Also fix an issue for Channel Index property, when set through the
configuration table, to use the same method as when loading _DSD
properties. This is needed for laptops with 4 amps where the
channels do not alternate.

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


