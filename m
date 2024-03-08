Return-Path: <linux-kernel+bounces-97126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210DC8765D4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF67A284DFA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D60438DF9;
	Fri,  8 Mar 2024 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WkjmJMD9"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B0F3DBBF;
	Fri,  8 Mar 2024 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906363; cv=none; b=OD+Vjp37mICm9MgX6Fo3LjmG3hUXYjKU1cK3XL7mWbjUkGnGTQwkGCNzbUXWkiIARBpXAPswjliVe3sON03QL+cU5kuZ56w6L9mfWQchUQRw4BWnHCfKlWCBkxyzPGwzK9noDUdbNTe/Na/PNSqlsUqMwUJ69WZfVgz8ue/NuIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906363; c=relaxed/simple;
	bh=QXNA9tK+wmD2HHQFcTyFQ7nNugKbTesrK1cHl52yxac=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d7tles/CWsHhTiv+qLfQLELeKazwJvSmZ9fHJjZMDu3FFnLXd+rMMljDNA7ALKjeDWb6IbtYH1rsUAUH3Ga+oKwp7D0Se8rGNDxxFvk4liEg0LFba4aLtIHjWoO4w6m+jb2QPACchsoSMWIvmTGPEMlgFpOZnWETl7fO9Ja2C8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=WkjmJMD9; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4286juhT000826;
	Fri, 8 Mar 2024 07:59:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=d
	yH+H0ET4bfpETq9uSfKDHwS0TiJSVm0/9UjiFrw1Jc=; b=WkjmJMD9A5Sz8dkxo
	FD1JGeB7zDA6cxNieh+CJIwTTkOWEy57p0d+6Ppi2TZeBb1we138EGpnvdmij37z
	Ey2L2NOIEiUKWcwINcG/dbe1QfjGU6ONNnJKKMNAsJU/nHSTpFGiMT09ofXoo5NW
	xaw+NLcIBegx/zgWB4ArskBCQuMs6Awfa9dunQkc/P8Yx6GVO/TP1L16e3yL/uBi
	Ufr004L8mfJ95rcEsMMWNyH1+kaXCrcnMm1q4/GdZmo09RLo/mUiffXsWI3BN/T4
	bJc89x6nR6/BGhg6qGs5x+W2EKqgyMr1+Y1qbybH9Uf6ycpq2ISZ30wqxthBpMD1
	zmzlA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wpn933f32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 07:59:02 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 8 Mar 2024
 13:59:00 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Fri, 8 Mar 2024 13:59:00 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B4D59820242;
	Fri,  8 Mar 2024 13:59:00 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>, <hdegoede@redhat.com>,
        <lenb@kernel.org>, <rafael@kernel.org>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <platform-driver-x86@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 0/3] ALSA: Add support for Cirrus Logic CS35L54 and CS35L57
Date: Fri, 8 Mar 2024 13:58:57 +0000
Message-ID: <20240308135900.603192-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3Pz0AOdoologX1j2pdPnX3OURDvv61KF
X-Proofpoint-ORIG-GUID: 3Pz0AOdoologX1j2pdPnX3OURDvv61KF
X-Proofpoint-Spam-Reason: safe

The CS35L54 and CS35L57 are Boosted Smart Amplifiers. The CS35L54 has
I2C/SPI control and I2S/TDM audio. The CS35L57 also has SoundWire
control and audio.
    
The hardware differences between L54, L56 and L57 do not affect the
driver control interface so they can all be handled by the same driver.

The HDA patch has build dependencies on the ASoC patch.

The final patch updates serial-multi-instantiate and scan.c to trap
the ACPI HID for HDA systems that declare multiple amps all under one
Device() node. This patch does not have any build dependency on the
first two patches so can be taken separately.

Simon Trimmer (3):
  ASoC: cs35l56: Add support for CS35L54 and CS35L57
  ALSA: hda: cs35l56: Add support for CS35L54 and CS35L57
  platform/x86: serial-multi-instantiate: Add support for CS35L54 and
    CS35L57

 drivers/acpi/scan.c                           |  2 ++
 .../platform/x86/serial-multi-instantiate.c   | 28 +++++++++++++++++++
 include/sound/cs35l56.h                       |  1 +
 sound/pci/hda/cs35l56_hda.c                   | 16 +++++++----
 sound/pci/hda/cs35l56_hda.h                   |  2 +-
 sound/pci/hda/cs35l56_hda_i2c.c               |  7 +++--
 sound/pci/hda/cs35l56_hda_spi.c               |  7 +++--
 sound/soc/codecs/cs35l56-sdw.c                |  3 +-
 sound/soc/codecs/cs35l56-shared.c             |  8 ++++--
 sound/soc/codecs/cs35l56.c                    | 14 +++++++++-
 10 files changed, 73 insertions(+), 15 deletions(-)

-- 
2.30.2


