Return-Path: <linux-kernel+bounces-115038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239EF888CB2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0EB1F24CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E651C1BEE;
	Mon, 25 Mar 2024 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuyElFY7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837F517DC01;
	Sun, 24 Mar 2024 23:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323839; cv=none; b=CCchdfzIaquP8xDb+xQpx0up0uk6YwirUOucTp04hpPPRh/Hf/jS1KbmEU6wcasJ21QHXiKFkA8SLp1lo/7d6yzWGchJ4BRROn/mS31UMkakzGsBSDyY4mGToFXbIv1i9sU+suCiRU8thofCejj+e4km21ZtTzfb/SrbrOSWZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323839; c=relaxed/simple;
	bh=FTe4ZX7VYZ8SrJmSCLv4eDtXVTPqOYrMW0q9tjbwYoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0Jl3sjOUIkio0mlqMxrIbaP92Y7DtfT+0Oj1VXtcXiliE34qfCicJefwNWKjQSRU9luIECFVZQj5oule6yh+hpaLgSux+5MxNQKQVYzqDl16lWDqKlqZ2TmT7SgT/YOyGreA0mKiOtyE6F9k2503RLd0AVnnIrIDsst1Wd9KOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuyElFY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971DCC433F1;
	Sun, 24 Mar 2024 23:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323838;
	bh=FTe4ZX7VYZ8SrJmSCLv4eDtXVTPqOYrMW0q9tjbwYoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LuyElFY7GPGKussnd7uTuw/nokc3k4V7rKWNFXpFLkBi0SLHodf3GWVnv0l1TV3Sb
	 VDXv4zWkqi8YSjyDCdyhEvtx+SGtNLJlZCrlEsh1XOp/bM5LgToa8dErvsBfA6rqdk
	 5MPr20cBZo/BBEHhPSYThD96D98hqcBb4ChTs2C8HYmvS5w7/uXimmOi0jURjD0Gvd
	 vISNSn/WQTAnuseudRUN7i6UBV3G0QfgrglI5AxSd/e2CUWjjyQ+BO8aaIQXKXAKkE
	 hNybGPFzgegwN3ktUj0uIWgZhjSIFI4cfsiOKjGjML5vRV53llxT7j725pWAVrSCkj
	 eZYTYI5Ih4eSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 216/238] staging: greybus: fix get_channel_from_mode() failure path
Date: Sun, 24 Mar 2024 19:40:04 -0400
Message-ID: <20240324234027.1354210-217-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 34164202a5827f60a203ca9acaf2d9f7d432aac8 ]

The get_channel_from_mode() function is supposed to return the channel
which matches the mode.  But it has a bug where if it doesn't find a
matching channel then it returns the last channel.  It should return
NULL instead.

Also remove an unnecessary NULL check on "channel".

Fixes: 2870b52bae4c ("greybus: lights: add lights implementation")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com>
Reviewed-by: Alex Elder <elder@linaro.org>
Link: https://lore.kernel.org/r/379c0cb4-39e0-4293-8a18-c7b1298e5420@moroto.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/greybus/light.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
index d2672b65c3f49..e59bb27236b9f 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -100,15 +100,15 @@ static struct led_classdev *get_channel_cdev(struct gb_channel *channel)
 static struct gb_channel *get_channel_from_mode(struct gb_light *light,
 						u32 mode)
 {
-	struct gb_channel *channel = NULL;
+	struct gb_channel *channel;
 	int i;
 
 	for (i = 0; i < light->channels_count; i++) {
 		channel = &light->channels[i];
-		if (channel && channel->mode == mode)
-			break;
+		if (channel->mode == mode)
+			return channel;
 	}
-	return channel;
+	return NULL;
 }
 
 static int __gb_lights_flash_intensity_set(struct gb_channel *channel,
-- 
2.43.0


