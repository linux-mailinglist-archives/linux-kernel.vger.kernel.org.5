Return-Path: <linux-kernel+bounces-35723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C17898395DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C0CEB271A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1607F7FD;
	Tue, 23 Jan 2024 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LGTP6V3f"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11587F7ED
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028985; cv=none; b=AdhLCgHmc2k3deo5r/CBlHPE/8MuSYw432uTWmwuuP90MFjDiSaNMSfgH38XByGDdmNpoKaar8mwUggE1z+lzoMjSCzsYQSAvgtM0dBroM4k5HMnqJFJGFQd7HsFugMfz0JF+LFqm6Vmw1waZqN/qQS5Qt6iNCDBIsVyu466USQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028985; c=relaxed/simple;
	bh=NpWVul+0kJHPkFkDMQv/ztRnm6Ag7wfkANj8KnoCCSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E/kjXpPJldc5rqVdvjkmrZ2J32ZCwav+QcoUwQIdY4Km1oDw3FSYpneJu+esRFneQtvqdTGuB9WeJiBwQxWpscUOo2UQQeiNpx95MoL/FqdkuO3NwtmMLwPI9u70KzNhpzOqFZlz4V+YNkPeTOfLBRPLgSY1tZdZZkQD6loU4BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LGTP6V3f; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 1BC9F1C000B;
	Tue, 23 Jan 2024 16:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706028980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y6zKOydFE4YNS4qWuRmXdt0aeAzHKR+ZP0mVpRlo5LQ=;
	b=LGTP6V3fmTY22gfMaEsa+k1HpmooZzFOlniOvPPRxw3CfReSZ6dtn0D3jn0MGbW/VRusmW
	cTxZLkolgUyq2mhVAPzoqPvI0pCuYXZqywGt3DB4+V9L/P1R312nRpPrgxOa+0BtMrN3ue
	R9gqHlYRVm2243FMF+jIjs8HIU7eT0DExDLyfrfDpR6pICuJ1o4sIcoXrXntN94Z7bXg1s
	unpHHqpA+7iDKe532C2a5OaRKyT2dxPyfeguysRHmfGl95URWiQd27rWu37HJ+6J+0LUgj
	yDbdFSC8oFhzvAplmF/0XXwqyyoDwREF3fyIwXVNDclKVtv7iyAhCUNn2dAEGw==
From: Herve Codina <herve.codina@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Herve Codina <herve.codina@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/1] Add support for the framer codec
Date: Tue, 23 Jan 2024 17:56:12 +0100
Message-ID: <20240123165615.250303-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

This patch introduces the framer codec support.

The patch was previously sent as part of a full feature series and
was previously reviewed in that context:
"Add support for QMC HDLC, framer infrastructure and PEF2256 framer" [1]

In order to ease the merge, the full feature series has been split and
needed parts were merged in v6.8-rc1:
 - "Prepare the PowerQUICC QMC and TSA for the HDLC QMC driver" [2]
 - "Add support for framer infrastructure and PEF2256 framer" [3]

The part related to QMC HDLC was sent upstream recently and is under
review [4].

This patch is the last one of the full feature series that was not
merged nor re-sent recently.

Best regards,
Hervé

[1]: https://lore.kernel.org/linux-kernel/20231115144007.478111-1-herve.codina@bootlin.com/
[2]: https://lore.kernel.org/linux-kernel/20231205152116.122512-1-herve.codina@bootlin.com/
[3]: https://lore.kernel.org/linux-kernel/20231128132534.258459-1-herve.codina@bootlin.com/
[4]: https://lore.kernel.org/linux-kernel/20240123164912.249540-1-herve.codina@bootlin.com/

Patch extracted:
  - Patch 1 : full feature series patch 26

Herve Codina (1):
  ASoC: codecs: Add support for the framer codec

 sound/soc/codecs/Kconfig        |  15 ++
 sound/soc/codecs/Makefile       |   2 +
 sound/soc/codecs/framer-codec.c | 413 ++++++++++++++++++++++++++++++++
 3 files changed, 430 insertions(+)
 create mode 100644 sound/soc/codecs/framer-codec.c

-- 
2.43.0


