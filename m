Return-Path: <linux-kernel+bounces-73634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FEA85C55B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29C51C21BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D48314A4F4;
	Tue, 20 Feb 2024 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C7kEVR8O"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212A114A0B6;
	Tue, 20 Feb 2024 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459283; cv=none; b=a5f1iTEN396BNaupO8FqS/QWKXAl/VIctgsL+jRpfYeb5q83zdb+moxGQqp1+mySVkLtLAWwfuxbo9n/T713QMdEsuiS1QXtHBE3fIBmraOoBXgW9tGVrEjNsWWZJRB3h7cPD5hEfbixG3dlQ5wT2uNxuPFa4bu0lpgEMOKdu14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459283; c=relaxed/simple;
	bh=efXH4kgB0+sZe9Hm8jwVVGCVLunac9SDojIroTAhm6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0aHNjzXflosjtZQuIXG5oot7J5P7ewgdPskl/xCEf1XegJeC4zl+YLhQSBXsg+AEoINi+xSBw3s87eBxgP1wRTZmLWIP1IJ4tlsDmSmLSNBZsMySEkwZaTvIDOHxUWBrPLx9lDvAkcgGjQm+4+xfF9C15mFDO/ALkJmN9XtyQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C7kEVR8O; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708459280;
	bh=efXH4kgB0+sZe9Hm8jwVVGCVLunac9SDojIroTAhm6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7kEVR8Oc4McmDfFfP6L869p2sB8j9yfBynin9mAw6upMOTWmPp0jX9/4VU6E6SWD
	 UOae58pMawBTswIT/FRBrXVKKcgJIc8ik8EhCcsdv8nWKU6IgD1+Sg1B3bNUSsqYua
	 GSL+PfTggSTXmA8BrOnaLpVgHROgWS1CE8rgKcOQK6C/6B3ick1E996m7lkm34C3tJ
	 m4Guh9Sj7LuR1MD3cLcB08nVYu3akEug2pKjIttHvEXxhP8blhR2mmcmTcZkVO9Kll
	 xYKeY7l6e/BkqGdfmvyGNYoTsQ75J+ZKV3ijolqrJ7iUdze8eONHdEFACqB1362+Qe
	 B+grGYj+v8hLg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 219D137820C8;
	Tue, 20 Feb 2024 20:01:20 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v2 0/2] ASoC: SOF: amd: Skip IRAM/DRAM size modification for Steam Deck OLED
Date: Tue, 20 Feb 2024 22:01:13 +0200
Message-ID: <20240220200116.438346-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220200116.438346-1-cristian.ciocaltea@collabora.com>
References: <20240220200116.438346-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series restores audio support on Valve's Steam Deck OLED model, which
broke after the recent introduction of ACP/PSP communication for IRAM/DRAM fence
register programming.

Changes in v2:
- Rebased onto next-20240219
- Added new patch introducing struct acp_quirk_entry
- Reworked v1 patch to make use of a dedicated quirk
- Link to v1:
  https://lore.kernel.org/lkml/20240209122810.2258042-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (2):
  ASoC: SOF: amd: Move signed_fw_image to struct acp_quirk_entry
  ASoC: SOF: amd: Skip IRAM/DRAM size modification for Steam Deck OLED

 sound/soc/sof/amd/acp-loader.c |  2 +-
 sound/soc/sof/amd/acp.c        | 50 ++++++++++++++++++----------------
 sound/soc/sof/amd/acp.h        |  7 ++++-
 sound/soc/sof/amd/vangogh.c    |  9 ++++--
 4 files changed, 41 insertions(+), 27 deletions(-)

-- 
2.43.2


