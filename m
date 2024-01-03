Return-Path: <linux-kernel+bounces-15870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EA382348B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00E71F25143
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5725E1CAB9;
	Wed,  3 Jan 2024 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbzXcl7B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AC51CA89;
	Wed,  3 Jan 2024 18:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1D6C433C7;
	Wed,  3 Jan 2024 18:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704306866;
	bh=ht4f2L9VNRd0Mc59eoD5YHto4h+iXotwSN2zcCeCmUg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gbzXcl7BbbxtSm8Gi1Qyxsl/niVlUDQwNiiEc5sY9rVMtZrwQt5V+HfUcHTM0wYTG
	 k1x+KtfvTL73UBFGoc7AL2u3mwNEoOfZyLrjEL1QqlK93Rad0S9Rh2WfszzNejvDDl
	 5ne7Eztu0D6MMIbo9CJnVEfXV37s0HjDsHd0tJUoMAcR4x4s/1qzP/1BlmFe9QeRry
	 8xDSYJviEHcCfjvIzT+kWLc065GmGQmtQTRD+Z853G+MljPQdC57+2ihRrqy7O2Y27
	 BLLdtcNI1tQ7/iyjvNm9Bjpi/xVZPPoN1OVXSHPu4MX47rPbyJQSH0Vc+lAHIhz9JC
	 rEkCyZZhEb/jQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 03 Jan 2024 18:34:02 +0000
Subject: [PATCH 2/4] ASoC: meson: g12a-tohdmitx: Validate written enum
 values
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-meson-enum-val-v1-2-424af7a8fb91@kernel.org>
References: <20240103-meson-enum-val-v1-0-424af7a8fb91@kernel.org>
In-Reply-To: <20240103-meson-enum-val-v1-0-424af7a8fb91@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1548; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ht4f2L9VNRd0Mc59eoD5YHto4h+iXotwSN2zcCeCmUg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBllaimMWacGtC/oM+FCVutaQUzoegKMoiH8Pk8W
 Wbk4bW3T96JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZZWopgAKCRAk1otyXVSH
 0DSyB/9+01n+37YTh84CduFEZq2Oj/ZWKuKbVubO9Xv9hSbfjLZ6hv+BbHfmTJbr5Hna2XehzGw
 kfhV5m5JcRciYD7N8OTUgKgV36fi+AdE9buDprljnRf7DsyHosNHxmxVRXwZtwMToJmj/V2DV5z
 bmCkAUJD7HZ/r7KOYAWncYQk6YEjFBGAO37eagiVkwBEpcsD4QKdnkcfPUEU7rjXL7JcLJKRMsi
 VGDdgmOlqjnHOJzJkkzupjsFvYhWjZPWXjR3NOxFDwQ5MGLIWmnNy++naYdz687laZc20LzB7EL
 KRlifhoDqlOaXFnwTsGK5ULqE59CrKOJM8v4OQe3GaSuqost
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When writing to an enum we need to verify that the value written is valid
for the enumeration, the helper function snd_soc_item_enum_to_val() doesn't
do it since it needs to return an unsigned (and in any case we'd need to
check the return value).

Fixes: c8609f3870f7 ("ASoC: meson: add g12a tohdmitx control")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/g12a-tohdmitx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/meson/g12a-tohdmitx.c b/sound/soc/meson/g12a-tohdmitx.c
index f7ef9aa1eed8..51b7703e1834 100644
--- a/sound/soc/meson/g12a-tohdmitx.c
+++ b/sound/soc/meson/g12a-tohdmitx.c
@@ -45,6 +45,9 @@ static int g12a_tohdmitx_i2s_mux_put_enum(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int mux, changed;
 
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
 	mux = snd_soc_enum_item_to_val(e, ucontrol->value.enumerated.item[0]);
 	changed = snd_soc_component_test_bits(component, e->reg,
 					      CTRL0_I2S_DAT_SEL,
@@ -93,6 +96,9 @@ static int g12a_tohdmitx_spdif_mux_put_enum(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int mux, changed;
 
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
 	mux = snd_soc_enum_item_to_val(e, ucontrol->value.enumerated.item[0]);
 	changed = snd_soc_component_test_bits(component, TOHDMITX_CTRL0,
 					      CTRL0_SPDIF_SEL,

-- 
2.39.2


