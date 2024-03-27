Return-Path: <linux-kernel+bounces-121714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FFE88ECDB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 710E4B24A97
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D705714E2CA;
	Wed, 27 Mar 2024 17:45:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E90C14C5BF;
	Wed, 27 Mar 2024 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561505; cv=none; b=ItSP9l9WsyK0FvYUpIAS/m7ESzVwl4b+Dv7NEHLl8bFRcdxBeCI+9fVtrCKhhbEs9iufX5T7IWIQ4o3lojMnzHsdfrX3+fLCSJ72H9VTgIzO8LFg29Nq0Vx7ex1eSN8gIpQNsSJcel0exL7rcEoFFKX9sLRxI6OxG406fsqKEJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561505; c=relaxed/simple;
	bh=1CwmmlxmKVLscRdfmcfA4/+KluARtfajri1QKyfGJWo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qPxQuVw/D578pIiVVyljLbUa4mZrVIBOQGLVuRoptMJjxeb06iXC+K0F4gb9FE67JeTjKxtHHJdde+LNroxDNVq00dhM19jQJQvo8jh26RVE9J+8sSnZwUPFaU3CASO5z+qa15BbiQ9Q1TctNacc4yci8TuN0ZzUgT1CB5lBHa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3759DC43390;
	Wed, 27 Mar 2024 17:45:01 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/18] ASoC: drop driver owner assignment
Date: Wed, 27 Mar 2024 18:44:35 +0100
Message-Id: <20240327-module-owner-var-v1-0-86d5002ba6dc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAANbBGYC/x3MTQqAIBBA4avErBswE4SuEi0ixxoojZF+QLx70
 vJbvJchkTAlGJoMQjcnjqGiaxtYtjmshOyqQSttVK8tHtFdO2F8Agnes6C2xrjOKL84DzU7hTy
 //3KcSvkApyabnGIAAAA=
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2285;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=1CwmmlxmKVLscRdfmcfA4/+KluARtfajri1QKyfGJWo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsJlGaQcNPUZgt7MK4j6bYQifF9US18lvokx
 ApAlXs0TUGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbCQAKCRDBN2bmhouD
 15VlD/9UzH+3nbglyOWWstuJFqB3SUJSfDjJ26GUTOCV8G63AxSPq3ZM/HMtUtEZ/K79Y8a2NQu
 YW9LDFpxo/ANM6BXldJKYLI8vzjHcDedLKdsKLpMLGoBTaXYv4TVu6gI340BgG6cUUchggrbWJX
 ea5r8i/wc0WBk/lBtkHcph/cct59eLWo6U1lsH/ne6yvxVQCZFSvr2A9fpsUxAUt4UhAQNHXbG9
 ZIdFPJeRFBBVn6GBP2pXbx5Sy7/gR/sd9gTwmzEEDfadICLRJh6MmxQ8b5/pICCTNbkZ2gnak0g
 f1pTDOWgYrLx6i9aA/XOP8+6If5n00tLIeyliMaX3kbmpediVVYKOIgAGxmNfNg9fYMZrveedU5
 mgLOzcDueM1aJQG9LCBFAjFR1d5Vg/UFRnBsQCMSDF4o07UZdsP+/SG/ahsilNcizEa1/SFCPRQ
 dq6oXFL7voLW9/X6OFCFqvXDW9yYjhuY+gpIr62oVGnIRyYDlddZYh+F/CUhZKQVmxKOKzF3tbx
 XOiGAEg2KDcSiIY8pC91ZhDXDHXyRnkggHcJ3Azzno5y4hFUFZn4jajaDSxdg7hJHPzCZd3+5K/
 jo5w+QznMmhyUhmn99j36LcsubCbsEHacozDhUnLSo7OV1Gb8Giz1rsXnX5mQ0J5TLSzvTHXERO
 YgJK63R7sBgb+/A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core for several drivers already sets the driver.owner, so driver does
not need to.  Simplify the drivers.

Patches are independent, no dependencies.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (18):
      ASoC: loongson: i2s/pci: drop driver owner assignment
      ASoC: tlv320aic32x4-spi: drop driver owner assignment
      ASoC: tlv320aic3x-spi: drop driver owner assignment
      ASoC: max98373-sdw: drop driver owner assignment
      ASoC: rt1017-sdca-sdw: drop driver owner assignment
      ASoC: rt1308-sdw: drop driver owner assignment
      ASoC: rt1316-sdw: drop driver owner assignment
      ASoC: rt1318-sdw: drop driver owner assignment
      ASoC: rt5682-sdw: drop driver owner assignment
      ASoC: rt700-sdw: drop driver owner assignment
      ASoC: rt711-sdca-sdw: drop driver owner assignment
      ASoC: rt711-sdw: drop driver owner assignment
      ASoC: rt712-sdca-dmic: drop driver owner assignment
      ASoC: rt712-sdca-sdw: drop driver owner assignment
      ASoC: rt715-sdca-sdw: drop driver owner assignment
      ASoC: rt715-sdw: drop driver owner assignment
      ASoC: rt722-sdca-sdw: drop driver owner assignment
      ASoC: sdw-mockup: drop driver owner assignment

 sound/soc/codecs/max98373-sdw.c       | 1 -
 sound/soc/codecs/rt1017-sdca-sdw.c    | 1 -
 sound/soc/codecs/rt1308-sdw.c         | 1 -
 sound/soc/codecs/rt1316-sdw.c         | 1 -
 sound/soc/codecs/rt1318-sdw.c         | 1 -
 sound/soc/codecs/rt5682-sdw.c         | 1 -
 sound/soc/codecs/rt700-sdw.c          | 1 -
 sound/soc/codecs/rt711-sdca-sdw.c     | 1 -
 sound/soc/codecs/rt711-sdw.c          | 1 -
 sound/soc/codecs/rt712-sdca-dmic.c    | 1 -
 sound/soc/codecs/rt712-sdca-sdw.c     | 1 -
 sound/soc/codecs/rt715-sdca-sdw.c     | 1 -
 sound/soc/codecs/rt715-sdw.c          | 1 -
 sound/soc/codecs/rt722-sdca-sdw.c     | 1 -
 sound/soc/codecs/sdw-mockup.c         | 1 -
 sound/soc/codecs/tlv320aic32x4-spi.c  | 1 -
 sound/soc/codecs/tlv320aic3x-spi.c    | 1 -
 sound/soc/loongson/loongson_i2s_pci.c | 1 -
 18 files changed, 18 deletions(-)
---
base-commit: 1cadb9c1269d4e90ec23f3dc3e5373ee405462d1
change-id: 20240327-module-owner-var-2744d140fcdf

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


