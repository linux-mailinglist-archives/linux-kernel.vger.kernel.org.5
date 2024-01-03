Return-Path: <linux-kernel+bounces-15869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EAB823489
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9717A1F25043
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154DD1CA93;
	Wed,  3 Jan 2024 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScqQ1wbJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6409D1CA89;
	Wed,  3 Jan 2024 18:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F4AC433C9;
	Wed,  3 Jan 2024 18:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704306862;
	bh=B8zEDu24iYdp1D2IrkF5R6n4WctFQW7jsiGp+pgfOHU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ScqQ1wbJ3FvcTR5o42OpxWXCzjmH8WNSCarXDvdJtHKsM2z3W0Meg+6j2KZYv2hm7
	 qAaKXIZWc9I3+xeQidVnuVuUdmjFvmFlh9f/IRVmdK9wcnFnW0ArT1ugku+A7UHYg/
	 Z6RWW87M/tqjkXVmHT6P3O6YHsMElKIIv8/A6yPjZ11VKFQ3MBkpLkr5jTXCkwmDiw
	 mX+B/iy/Vkr2QNaMzBTq3e1gD5e867Wj/OmEz6hsZ0ufvDNxw51t4IF+70S48yOeEW
	 WZHqFKWCp2CRYCdO89AEo4U1SRSzD2Nig4kDQr1SYxDUor7lNrkV6K6k0ySy+v+01J
	 vX9kPK2uDnVPw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 03 Jan 2024 18:34:01 +0000
Subject: [PATCH 1/4] ASoC: meson: g12a-toacodec: Validate written enum
 values
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-meson-enum-val-v1-1-424af7a8fb91@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; i=broonie@kernel.org;
 h=from:subject:message-id; bh=B8zEDu24iYdp1D2IrkF5R6n4WctFQW7jsiGp+pgfOHU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBllailRF53dP8BdcNiiucMBNUWe0Bfoinwza+iA
 k98eb/reiGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZZWopQAKCRAk1otyXVSH
 0J+sB/95RlpkPTF9f6yzkpbHjBnF6rgqjyIkO2/GedEUoAPrGm0/781noJTYbc7sQG5WpiIxj9e
 E4B+MYv4ymaHspYZAVcllMJNkQlWoxVjlbYiiqGjmxRUffo6ZgnpFx4HJN4U9tSlE1sqZRQzvve
 V51inkIIr+SN/3fenEt3m+oll5VDH1teYdTpVvOtQtqDg6XGaVjnsuddjVf7ftLTzJUq0jO6Ylt
 xCHAz8NV8eA2+bgm2opWls1lXCerybpxAVwIPme9Pgl5NIs6uQBsb9b4+Jm3U6HDi4yUVLwPMKG
 EaK4IcbPFDe02qyInmnJPfvPRqJUsRbmTh6cfiDHXxNe90Ng
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When writing to an enum we need to verify that the value written is valid
for the enumeration, the helper function snd_soc_item_enum_to_val() doesn't
do it since it needs to return an unsigned (and in any case we'd need to
check the return value).

Fixes: af2618a2eee8 ("ASoC: meson: g12a: add internal DAC glue driver")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/g12a-toacodec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/meson/g12a-toacodec.c b/sound/soc/meson/g12a-toacodec.c
index 6c4503766fdc..dd7f07de2685 100644
--- a/sound/soc/meson/g12a-toacodec.c
+++ b/sound/soc/meson/g12a-toacodec.c
@@ -71,6 +71,9 @@ static int g12a_toacodec_mux_put_enum(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int mux, reg;
 
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
 	mux = snd_soc_enum_item_to_val(e, ucontrol->value.enumerated.item[0]);
 	regmap_field_read(priv->field_dat_sel, &reg);
 

-- 
2.39.2


