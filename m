Return-Path: <linux-kernel+bounces-113619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C638885BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023D41C250AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DE81D2AAF;
	Sun, 24 Mar 2024 22:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruebdpPE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F32B763FF;
	Sun, 24 Mar 2024 22:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320454; cv=none; b=lqZPHbVikXxFhFjyjrU+xujCpj/ql2Q7ngCKruBrHjmo1j934SzilBvry8RumS0y8GDAHiTwIAykFoQ1dClrh3M2O2ejQPK421hCOSPnzOdcl1Vm12trV76xS6YA4SgPRfulEl3Tngf6IwBCS2aioz6ac8hJkrNKaBtauAIMYxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320454; c=relaxed/simple;
	bh=3W6dR8PdnATH3wLhgXePo6qAuvBQwrdOzzSzsfx9tTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Haal0qxDFl+svp9TlRuYZiSnq0P03knyTbHMEK066hLTKGmGAkfsxHO3xX7stv6N20hHlyvkbFE+RfbPUVIOAbqRfJGuJMBaMkemwDYgZakemp6ZRL12QFPZ3hvSfp7NY/WJwKETAFJQPtZbJDHwthxwdLoqJPzSn9PIfqlZyv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruebdpPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D4CC433F1;
	Sun, 24 Mar 2024 22:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320453;
	bh=3W6dR8PdnATH3wLhgXePo6qAuvBQwrdOzzSzsfx9tTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ruebdpPEXLyp17TN5P0ohiKq3+LgvMN5VJZR0bpcyzZBO9sJt/c0QHpkjVLbvIsof
	 K4rYiEwqXr2p0A3sqrK7flgqP1es2gpeWb5vUndaUFeR/fx3OOBdYRO00NNWoFt5t6
	 FrrHH3h4VVDTPL2SmM5O+O9ihXvbnBqzX4Gk+eMNSOtJKL0JpwUGaeMMQBCadNBFpc
	 gENRDwgis+8pL10bKoqCD7Lv+IHLohbyVYawAFXLqH+fdiWDPZ75L9GOgXs3HQyY1u
	 JyRKG9CWYAg1Lk9Ab9GYp/l2n+ewT/5wlJR5wXQ7bRz8UfFUGY90XTJJLaAu23LBqN
	 cetA1/Od82Lzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 012/713] ASoC: rt5645: Make LattePanda board DMI match more precise
Date: Sun, 24 Mar 2024 18:35:38 -0400
Message-ID: <20240324224720.1345309-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index ea08b7cfc31da..e0da151508309 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3829,6 +3829,16 @@ static const struct dmi_system_id dmi_platform_data[] = {
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


