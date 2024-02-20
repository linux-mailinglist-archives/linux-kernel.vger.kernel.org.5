Return-Path: <linux-kernel+bounces-73662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D3785C59C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F9E2835D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADEB14C588;
	Tue, 20 Feb 2024 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gHZD6gtM"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2B514A4DF;
	Tue, 20 Feb 2024 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460190; cv=none; b=FtalZ/U1quih/ZPnozP0GaXZ0Qp2KO2uccCieCR8G7vu0ZW206c2YwjqWTtlN8F7oQZWUX19z4bP9NCOD2dvdDjdk8uwT66xSCc0NQ0SQSbnvBE5gbXk/WBlKSDmhX0BxFUv5kP6070DqDShMQeHITwjwEUJV5+jpjsSjo6tNcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460190; c=relaxed/simple;
	bh=Znjg83HoW5XDBfAzmJOMOFbJH44wbIxWWhyrjHD9XdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLLQSBdJWKWnhiPxkwXTtoAijMXjUXkHkgZIav8NwKqa/O9f2FvaGJNNM9pzxlCH8E2s5LeXRZv2WU3BwEK87eTHr/Hl/cTxkgYysjs3CabFuU1yyOEHqELMnb90zVZujDTatU34YbaExAgey/Z1CaZaRVEGmTzb8Im6+0w3Yiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gHZD6gtM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708460187;
	bh=Znjg83HoW5XDBfAzmJOMOFbJH44wbIxWWhyrjHD9XdM=;
	h=From:To:Cc:Subject:Date:From;
	b=gHZD6gtMfYbgkkkSsnQUxmp0/hcyCDqbIhlMfiKFDGIQhAMWvOAU9Af8gkcS8Od2Q
	 ioJWSwestf5RFYeyvwn9ohDyQMn/45Moil7ee7VFymdwMNn1TrpRHq3+QwQyNyETcS
	 Ck+loFk8sLDNMPezAscc7uH0kFGKBekFhW8SMO1ggDK709KlTOfGVGtoqft6Yses+s
	 68TDg1nczNDDrTOkSA09M9LC3JxFbCeFftUr6ehlvWocn+5+DKBYEJ1u0HtX7eugTV
	 URkCMQbIvQbaz80MnWTRtzbg07zRJwSOhaIvBh456SbBMgBWVovd7LAMXf7TIbRyMU
	 rgW7PTRQSMjzQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E29C537820C8;
	Tue, 20 Feb 2024 20:16:26 +0000 (UTC)
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
Subject: [PATCH v3 0/2] ASoC: SOF: amd: Skip IRAM/DRAM size modification for Steam Deck OLED
Date: Tue, 20 Feb 2024 22:16:02 +0200
Message-ID: <20240220201623.438944-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.2
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

Changes in v3:
- Drop a patch file that was sent by mistake in v2

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


