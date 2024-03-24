Return-Path: <linux-kernel+bounces-116245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A0F8895CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25758298A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8B63C4232;
	Mon, 25 Mar 2024 03:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smqdlmND"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F70717EB69;
	Sun, 24 Mar 2024 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324005; cv=none; b=Vy/6/LFWKMrJ5DW2EoOwh6bZOgRzzsSYR6wyV0ICOcj1t6pfputDyFcUofmD/oZQlMyl4WD7Upftpny9/IwUPjxMqwTovuXiQJqc5QV4U/+KBe1neJ9utAcqNmPEmJmUIkN7Fq3c9VrVFymsaQcK71zXf3iPoLrEX58sDiJmSmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324005; c=relaxed/simple;
	bh=5gEzrD119tj6hsJgRdf2pITbVhppAiihu13s8fHpiOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEPckGPbRJgfGNwl0JOsdekyeYuE95z0ezfIBz75bSY+s/HLDzsxOurp35Dp+miFNZlGlIYRGMGHmSz9j3NJ7sWM6/sw3Q7K8UFp0Vo7PNoRL22/H03cRGclmMgXBGmWSPu/s9AhzBSoBl37jAiIvtm8sykIq/YjOBOgkfB0qOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smqdlmND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9D2C433F1;
	Sun, 24 Mar 2024 23:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324003;
	bh=5gEzrD119tj6hsJgRdf2pITbVhppAiihu13s8fHpiOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=smqdlmND9yOY6Q+ZWfP/8CVZfxIQnhMv+X3a/RrUirphSvg2OnO5JwRBOsSJzsEKv
	 bcFLNqi1u73M2ZdyayVr3bhVZ0EyC3HE4CSCrT8635UHs6niS9MnrGIci74wHI9VNg
	 QiRV5ZyjE4IOEVOUsCizRJM4mbdecnzhaVAyC2bh0mUvfArPAaqlDiU8Kge2OvHVto
	 Nkbb+jfJtTYqaOIADq5n9D1aMH2PBI6HhJUPzC8j+hzYY0XhGwOyMwHWo1UPKD8yX5
	 rWcJmr4NI8uH7aVeEAU0GpXlqHal+ctBu5SdxXTQiosHS4jOx/O256FpPa5Xp2qzAk
	 pp0clYG0TXKJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 004/183] ASoC: rt5645: Make LattePanda board DMI match more precise
Date: Sun, 24 Mar 2024 19:43:37 -0400
Message-ID: <20240324234638.1355609-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 551539a8606e28cb2a130f8ef3e9834235b456c4 ]

The DMI strings used for the LattePanda board DMI quirks are very generic.

Using the dmidecode database from https://linux-hardware.org/ shows
that the chosen DMI strings also match the following 2 laptops
which also have a rt5645 codec:

Insignia NS-P11W7100 https://linux-hardware.org/?computer=E092FFF8BA04
Insignia NS-P10W8100 https://linux-hardware.org/?computer=AFB6C0BF7934

All 4 hw revisions of the LattePanda board have "S70CR" in their BIOS
version DMI strings:

DF-BI-7-S70CR100-*
DF-BI-7-S70CR110-*
DF-BI-7-S70CR200-*
LP-BS-7-S70CR700-*

See e.g. https://linux-hardware.org/?computer=D98250A817C0

Add a partial (non exact) DMI match on this string to make the LattePanda
board DMI match more precise to avoid false-positive matches.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://msgid.link/r/20240211212736.179605-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5645.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 88093e58dd845..c78d5833c9cd9 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3766,6 +3766,16 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
 		  DMI_EXACT_MATCH(DMI_BOARD_VERSION, "Default string"),
+		  /*
+		   * Above strings are too generic, LattePanda BIOS versions for
+		   * all 4 hw revisions are:
+		   * DF-BI-7-S70CR100-*
+		   * DF-BI-7-S70CR110-*
+		   * DF-BI-7-S70CR200-*
+		   * LP-BS-7-S70CR700-*
+		   * Do a partial match for S70CR to avoid false positive matches.
+		   */
+		  DMI_MATCH(DMI_BIOS_VERSION, "S70CR"),
 		},
 		.driver_data = (void *)&lattepanda_board_platform_data,
 	},
-- 
2.43.0


