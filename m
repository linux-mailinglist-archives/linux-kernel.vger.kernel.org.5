Return-Path: <linux-kernel+bounces-116942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241E688A559
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C122E39BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836D81C5AAC;
	Mon, 25 Mar 2024 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BvWMcMW0"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792021C5AB0;
	Mon, 25 Mar 2024 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366311; cv=none; b=mEbLfXVZHgrDbef5LFMmYarNh64gx423lCzjChWr1FwcfmNfZq2x8a9NJ74n1QTSiPd5LD7Mp4jzbjPE6tcpI6o2unHLKn2D+5xpOir3/A+ny4BA1Qivi6LkH+ux21mDl9kJEYAOENIz6uiyd6xq3J+Rhbm5+jptjW7A4r+YVzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366311; c=relaxed/simple;
	bh=MJQZPFsYuoWMOOKpqEWdDBSguutaxNezVILCQTDO434=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V7gp4sDYsFKRMlPzNZLxrcdgcQ5P+BI+pxTDeWgThZXFnhCcHYw+04D7n/BXsCIsM2FQc/3HXDiV5WZiTsEr/FMZ+SKWLsHfaxwAlrfWynE0XpVnZp3AD46otjdn7EUhoWP8wNNIjvFW+3vUBsNi+OTBsa5FgCUPoGCDy/ZmUJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BvWMcMW0; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P4qkf3007553;
	Mon, 25 Mar 2024 06:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=B
	GcWn7Vy3IP2SJ0lUTxgCUyOMlOORhPAToSh6yl/wik=; b=BvWMcMW0AFEJbcVpl
	N/H3iWdtmnkhlCD4K2IRAP4UwGO8uJQoagQlEmJIVyhs6yaIAeWRH4LtmhHSo/Sh
	x9HdataaQPk8HITz0EOvgZf9jwd/gluc+ewVc1kWkOAmf2u6HUoGDKC35l7EAlLe
	NPkRCV492Ylcl4BRzWRUgmxMRcIUTvHCaPcaNsjsPgIR44E/4BixNZLkKNF/XlL7
	5lzpoFtjhtatZVDmFQf9SHCamPD/k4HMQ+xE3ncl6PnMVlDb7Uej6SlK4eyjxuS5
	A78XYmMZFUnBimhddr1nseKug06ZneLBeZHTkoQB9HuCAkutqVs3CFHilqWyeZLL
	ptorA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x1vfyb6v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 06:31:29 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 25 Mar
 2024 11:31:27 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Mon, 25 Mar 2024 11:31:27 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 2DEC7820241;
	Mon, 25 Mar 2024 11:31:27 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 0/5] ALSA: cirrus: Tidy up of firmware control read/write
Date: Mon, 25 Mar 2024 11:31:22 +0000
Message-ID: <20240325113127.112783-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eEuzHHeve88IErOHMGl7VLKzH3MtdUFP
X-Proofpoint-GUID: eEuzHHeve88IErOHMGl7VLKzH3MtdUFP
X-Proofpoint-Spam-Reason: safe

This set of patches factors out some repeated code to clean up
firmware control read/write functions, and removes some redundant
control notification code.

Simon Trimmer (5):
  firmware: cs_dsp: Add locked wrappers for coeff read and write
  ASoC: wm_adsp: Use cs_dsp_coeff_lock_and_[read|write]_ctrl()
  ALSA: hda: hda_cs_dsp_ctl: Use
    cs_dsp_coeff_lock_and_[read|write]_ctrl()
  ASoC: wm_adsp: Remove notification of driver write
  ALSA: hda: hda_cs_dsp_ctl: Remove notification of driver write

 drivers/firmware/cirrus/cs_dsp.c       | 54 ++++++++++++++++++++++++++
 include/linux/firmware/cirrus/cs_dsp.h |  4 ++
 sound/pci/hda/hda_cs_dsp_ctl.c         | 22 +----------
 sound/soc/codecs/wm_adsp.c             | 32 ++++-----------
 4 files changed, 67 insertions(+), 45 deletions(-)

-- 
2.39.2


