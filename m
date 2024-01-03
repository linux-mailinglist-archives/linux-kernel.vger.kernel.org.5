Return-Path: <linux-kernel+bounces-15871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF4182348C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451DE28705F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06281C698;
	Wed,  3 Jan 2024 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3/Pk1um"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072111CF9C;
	Wed,  3 Jan 2024 18:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B266BC433C9;
	Wed,  3 Jan 2024 18:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704306869;
	bh=dDDot4LPRcgoDYuhIQlX528kffOfH+AmewxKynD5EdI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D3/Pk1umSny2A8IZwjZfAIKV5pHBczxBvTftsMewDZ+JzbCSb0VDHB/gvc/LTW8n4
	 Ux0Fyoxb4Stqm3xpZeW1bdtWWWjflUUKpTe3FsQ3sO05BXat6QzYnOyWh83JOv3mrH
	 uegVKZiyU0HBnJ31gbYPdjrQoc+F1trLh86eeoVGPyKUXcu+CHwPxqD9+Mt1PWBJX2
	 sEsjivyiK8bTyNYSYc9XqeTcZ6+9Qv9Q7+FXqjB9dM3VpUhmvcIIMANPG/cALnCq33
	 pt0b0pOWxVnYpdGRmch3ijPkF7xt8DnfScdRSOfN5ik2WtkyOL+2oSd5N8cfPISpR4
	 /SQV8J3hWJKOg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 03 Jan 2024 18:34:03 +0000
Subject: [PATCH 3/4] ASoC: meson: g12a-toacodec: Fix event generation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-meson-enum-val-v1-3-424af7a8fb91@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=996; i=broonie@kernel.org;
 h=from:subject:message-id; bh=dDDot4LPRcgoDYuhIQlX528kffOfH+AmewxKynD5EdI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBllainucttS7OoBLV5md2JR3xlj2GVea5XjFl06
 dLgG8hp3R+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZZWopwAKCRAk1otyXVSH
 0P6YB/4jzW3f4QaPPP68INJXXLHuXZAFWMvx6FTQuOqj8wqVrOLFFdLieqJQcNa01wBLV0QgR+p
 0giUSm4S4Y8D7/QASlWUBaKhSiOsGRSEHQnp8vqA9QeMCvN6gtvZWzfm/4IAhHOugTh7FOUYrbE
 U+t8zCxvfXyvxARb6Jvh6mFM6XtxykTKKmaGD3gETbU1jvzTUV1igKFRZ7rg57RT4URS03zygeo
 gRzawACQtEfB3AIUaQ198HNe0cF959n2z2OjoqPfKLzVXpVEaQyzh/ZGdPo9QkNU3IQahnnDpO7
 aDdjoagBml0WpiHz044OI2k4kL49tXmDGx/Huftxb6cbG03f
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When a control changes value the return value from _put() should be 1 so
we get events generated to userspace notifying applications of the change.
We are checking if there has been a change and exiting early if not but we
are not providing the correct return value in the latter case, fix this.

Fixes: af2618a2eee8 ("ASoC: meson: g12a: add internal DAC glue driver")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/g12a-toacodec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/g12a-toacodec.c b/sound/soc/meson/g12a-toacodec.c
index dd7f07de2685..531bb8707a3e 100644
--- a/sound/soc/meson/g12a-toacodec.c
+++ b/sound/soc/meson/g12a-toacodec.c
@@ -104,7 +104,7 @@ static int g12a_toacodec_mux_put_enum(struct snd_kcontrol *kcontrol,
 
 	snd_soc_dapm_mux_update_power(dapm, kcontrol, mux, e, NULL);
 
-	return 0;
+	return 1;
 }
 
 static SOC_ENUM_SINGLE_DECL(g12a_toacodec_mux_enum, TOACODEC_CTRL0,

-- 
2.39.2


