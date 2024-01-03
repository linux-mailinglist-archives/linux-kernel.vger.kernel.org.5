Return-Path: <linux-kernel+bounces-15868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCA0823488
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1961F1F248A4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3481C6A3;
	Wed,  3 Jan 2024 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQsLBdo8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6752B1CA84;
	Wed,  3 Jan 2024 18:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681D9C433C8;
	Wed,  3 Jan 2024 18:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704306859;
	bh=19xiBjnOuBFzrb7XkNEoHVBbObJYxv6N5hhdXATD5LU=;
	h=From:Subject:Date:To:Cc:From;
	b=vQsLBdo8BtAsq1n5IX+yib8qFGJuLIFgTus6TNIWgj4tyZAbfvEIhpoqS4vdDGre1
	 dKuygPY8gUiJm4AQufwvDU1XJJGTJG9WtT/X985ykOPMy6bC+CgJjmvegKIhjx07j1
	 ANugczvuZShC3ng3SY9Aa/1Qnv6ewAZsG+TmnOoOK4oFzeIAPIM3qLhQcf3Z8xMVxD
	 XIDwYs4kuc232r4N03YyLk4VSuATLlWK0DTaX1SzBx+JqzxilQIE0vksLanvVP1sIm
	 7MRDUScdHREVi0Ly8DF9oD/I1NBMhPs1y0wDk9LAT/UuG9rHxt10kOwUBzOWr/dckO
	 MTb2IfxIyh/Tg==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/4] ASoC: meson: Fix issues with LibreTech Saphire
Date: Wed, 03 Jan 2024 18:34:00 +0000
Message-Id: <20240103-meson-enum-val-v1-0-424af7a8fb91@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJiolWUC/x2MQQqAMAzAvjJ6tjCnoPgV8TC1asFVWVEE2d8dH
 kNIXlCKTAqdeSHSzcqHZCgLA9PmZSXkOTM462pb2goD6SFIcgW8/Y5TS/XolqyaBnJ0Rlr4+Yf
 9kNIHj/SYs2AAAAA=
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=742; i=broonie@kernel.org;
 h=from:subject:message-id; bh=19xiBjnOuBFzrb7XkNEoHVBbObJYxv6N5hhdXATD5LU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBllailFWG6K0996ZkK+zsEgZm8WQikj/dXR+gw2
 ektleLtk7eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZZWopQAKCRAk1otyXVSH
 0GTPB/9hsdHS+SkXa8zW3gUdRI2CV4zmlUtRxP5/jDP12prISMr7i0w9Pjjvxphlj4Z3ogk80lC
 B8sujoQpPNgUNDDB4xutZQuVH7QSuGbVIUVAgc1plOJLW4vHh9HXsarzcKVPRBNWq3l/+/N7wlG
 Ml+E0Z1jKt/ZXyUbJu3lQ3kkDp2KtOFCOvAeNZtC+NoxCta264AkTr9DHRKjJg4hI84lOz6WdCL
 mER8E98+5OEBPcdcXEjUxdutKLbUzmFkW71NrlL3Cq56FiM4Ne/4HgII0NroukIkTJCvKt0ftLP
 vo1C+T5sfTHGOJwgNBSGYuj+EtX2hDsav0NjOAorYoh/DjrI
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This fixes a few issues I identified when integrating a LibreTech
Saphire (based on S905D3) into my CI.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (4):
      ASoC: meson: g12a-toacodec: Validate written enum values
      ASoC: meson: g12a-tohdmitx: Validate written enum values
      ASoC: meson: g12a-toacodec: Fix event generation
      ASoC: meson: g12a-tohdmitx: Fix event generation for S/PDIF mux

 sound/soc/meson/g12a-toacodec.c | 5 ++++-
 sound/soc/meson/g12a-tohdmitx.c | 8 +++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)
---
base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
change-id: 20240103-meson-enum-val-c8e4b2f01077

Best regards,
-- 
Mark Brown <broonie@kernel.org>


