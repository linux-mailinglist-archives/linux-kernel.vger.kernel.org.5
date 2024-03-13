Return-Path: <linux-kernel+bounces-101901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D360687AC90
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F161F2E10A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C097C811F2;
	Wed, 13 Mar 2024 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhT7OW0M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026FB80C06;
	Wed, 13 Mar 2024 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348038; cv=none; b=DvOA0dwVyWVUEoFwK8uvdh9CEX7Z7o/HOBwgl9oLZ+hSGPpVCvj7rQkeu0w9SCJsNIAb8KSWGoO/gAwLelr5IoXy2ZIrDgRBrYUzg6svIxBL2nnsFdh9+HQrJ73ZWDwlbgjgFgxBHE2mjfZhbSv7wXpnuhvzQXYUUPTphio5HeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348038; c=relaxed/simple;
	bh=kKLF5yeoV8l2p3/UzErTNYsHxzp8zUDX9GKZKW+fYKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFWYW+07QFdNynmsUiLfjqk99J7xGpKRSHBI2IXASM0w2or52sUsvSrhHQe5qNxoIQxWorzK/+1E4sWMxeSuV630d+S1X2NATNncIJuuM1ZwBJOefKrFJbhCloN2VIfpxvsongETnAGCt9gub4l3aBD+KVBU+WqOwgrAIJEp6VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhT7OW0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E295C433F1;
	Wed, 13 Mar 2024 16:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348037;
	bh=kKLF5yeoV8l2p3/UzErTNYsHxzp8zUDX9GKZKW+fYKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YhT7OW0MkXDV1hqWwJU0CMYa+vLnc5MhRppFarPG6rxPvwN9SKZYOZ1mUdQ0vkQBl
	 lMkN0JwyysA3bNdG3LavmK57qdMm3kdfPI4NbOsZD7O2Lo25t6HBkotzpqNq3vywCT
	 lW1ny+LthTo2fC4sUldV4J93kwXFaNbnIeRXav6pVUpg7FvUIsjVgRnOgzQPLkwmL8
	 CsrzHMTYCDKXo3mTudCBiHBDK8NVpIFbLmiLf5TmPDdH7nTHTAymNrQEbOySI9YVKZ
	 rRr7EJ3DHGoMMt1YVRPrQMEczffU9wW2kIW2s2oZloNsI36oJI6+YwM657rIZlbduW
	 k5wcobqZl5wsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 33/71] ASoC: codecs: wcd938x: fix headphones volume controls
Date: Wed, 13 Mar 2024 12:39:19 -0400
Message-ID: <20240313163957.615276-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit 4d0e8bdfa4a57099dc7230952a460903f2e2f8de ]

The lowest headphones volume setting does not mute so the leave the TLV
mute flag unset.

This is specifically needed to let the sound server use the lowest gain
setting.

Fixes: c03226ba15fe ("ASoC: codecs: wcd938x: fix dB range for HPHL and HPHR")
Cc:  <stable@vger.kernel.org>      # 6.5
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://msgid.link/r/20240122091130.27463-1-johan+linaro@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wcd938x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index e80be4e4fa8b4..555b74e7172d8 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -210,7 +210,7 @@ struct wcd938x_priv {
 };
 
 static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(ear_pa_gain, 600, -1800);
-static const DECLARE_TLV_DB_SCALE(line_gain, -3000, 150, -3000);
+static const DECLARE_TLV_DB_SCALE(line_gain, -3000, 150, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(analog_gain, 0, 3000);
 
 struct wcd938x_mbhc_zdet_param {
-- 
2.43.0


