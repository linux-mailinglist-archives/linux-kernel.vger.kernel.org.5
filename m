Return-Path: <linux-kernel+bounces-152426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7908ABE45
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 03:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45371F2188B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 01:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1234437;
	Sun, 21 Apr 2024 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gS2923b5"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C660C17E9;
	Sun, 21 Apr 2024 01:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713662228; cv=none; b=PmicV1S0xPyD5DY24sfg9fA7Y1QOqG18/EeHfZ5mU9+jFpSMc59orX3cFmB0xaYVDzSjjSVqUPJ/GMUxco+BIlp6VLsVsupYti+UtaoUQMDH7Wn9NrxqIpO4FCAWZ4UabIPIoH9C78dqdZfHo8bv8ZHkNJW2M+Z8Jo7hIcSIpWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713662228; c=relaxed/simple;
	bh=bf87LTTfzpmwA9Io9J4bIwl/FQzv77/RTk/Waflp9xM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Foh911q+xyp1VMMJahZiyTm3oKz886BTdz++bBoHV97gNtC1f9yM/Lqi/4UAOIfXnFO497zGn+7v4yr4FZqJU3SA3P0AtJHUvTBkyELcQpB3wC3LU3pCwJy9cqkwvKoWwmy96cBctPqT5nncEEh9Jsgr5o5l06hmaUTwVtRFHQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gS2923b5; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5e4f79007ffso2106329a12.2;
        Sat, 20 Apr 2024 18:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713662226; x=1714267026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2kfxX0gAblsNTcir2Fbcwrw/oNkxvMTFC1t5qDh73Yw=;
        b=gS2923b51nyZtzBhPpUw5g3can21oVGkswiYt84KLM1kEbZe3ZclQC4qu0RZW99DOU
         zEZbq2Itf9gnpuhAvQtgSaS2+uXXxB27ZJlpgKZnIGmRAQl4O+Gc1Dhvjd53xDgjXLAf
         j+RsgCvHZR48IWD0PwE5D+a0VM04Jr/2p1qeTKMkJubnPOnbVYxCWfdP5MdpUWeytDwl
         WcHVrELCoZyq9NFBhmp+FNCnRT6C43oHVAvSB2ght8C8UUWdYO/N/vYMqXspG8Nbw7ta
         4qS6g3ycZh3eVKS9v4vB+RW0MxZN9bzsQRy/ksZgywhyc9rShxDrz2/quKDoCCd3nJ3G
         +A1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713662226; x=1714267026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kfxX0gAblsNTcir2Fbcwrw/oNkxvMTFC1t5qDh73Yw=;
        b=UjlSPS/IoSLqou5t2/qO690rAzAKIdSJ9RVFR2Gv89nUkmVmem01Y8EcxyKnf8mYQN
         tmh6EOLzGAPkCvqR6ixmtod9OMk2MIu1DXeCeFHG8xYy6MMakAamr0Mqz/494snt4HpH
         U43ALbWTjQ9mRTL6b0XDTsVDEIuMp8LTKZahkMuUQSfmhwLqFZ+uUcPN5KKmNqIELqWt
         OPQ+UgDKJRMGiI2hjUad/l7d1DV7XuWBYZFT4DpvE0pGgtbQAsN1bFhbFnTYaDqR+Hbx
         dkLmvRV/OcepXybvtge71s2Q8DdXEOzbQJt6K1qSPk3vr4dC6/1KSYezs+PflpjKEwOq
         wf0A==
X-Forwarded-Encrypted: i=1; AJvYcCWvuMOrWd0YYfTc1Xf+68dkmbg3UXF6O2yYJjSZ2q+J9m6Bgt0+H6zeaFsV+D+GTQuKQBB/nUBknUcmbSDictCq2iUmEG3kxkzo3SKT
X-Gm-Message-State: AOJu0Ywwi6xIuRCOLnzect2mlhSm2zF13OOdMkanGWtsoej2NOpFVabS
	lTPR0JnUJvPeSUcP2ABP3B6afPmvkM66O220mBiBjWbU2Ue6Bft2
X-Google-Smtp-Source: AGHT+IG3vHCUVwo/lxVBJMFijFA+8ZG4hmmvuU9hInLpvKUPnmf3PYj/8zFKnOrw2ks9E/8V1l2bhA==
X-Received: by 2002:a17:902:f542:b0:1e4:3386:349f with SMTP id h2-20020a170902f54200b001e43386349fmr8668141plf.51.1713662226013;
        Sat, 20 Apr 2024 18:17:06 -0700 (PDT)
Received: from kernel.. ([2402:e280:214c:86:9255:6017:dc77:4c93])
        by smtp.gmail.com with ESMTPSA id mq8-20020a170902fd4800b001e23fcdebe9sm5608583plb.98.2024.04.20.18.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 18:17:05 -0700 (PDT)
From: sundar <prosunofficial@gmail.com>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	neil.armstrong@linaro.org,
	dmitry.baryshkov@linaro.org,
	u.kleine-koenig@pengutronix.de,
	christophe.jaillet@wanadoo.fr
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	sundar <prosunofficial@gmail.com>
Subject: [PATCH v3] usb: typec: mux: remove indentation for common path [linux-next]
Date: Sun, 21 Apr 2024 06:46:47 +0530
Message-Id: <20240421011647.3027-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added check if pointer is null and removed indentation for common path

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: sundar <prosunofficial@gmail.com>
---

Fixed nitpicks in code according to comments received on other patch.

https://lore.kernel.org/all/2024041103-doornail-professor-7c1e@gregkh/

Goal is to get rid of of_node_put,but sending this patch first to do one
thing at a time.

Changes since v1 - fixed the typo error for spell from identation to
indentation

Changes since v2 - Shifted the indentation to one level left for the
switch cases as per coding style.

v1 patch link - https://lore.kernel.org/all/20240420145522.15018-1-prosunofficial@gmail.com/
v2 patch link - https://lore.kernel.org/linux-usb/20240420164927.15290-1-prosunofficial@gmail.com/

 drivers/usb/typec/mux/nb7vpq904m.c | 68 +++++++++++++++---------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
index b17826713753..f7a00b388876 100644
--- a/drivers/usb/typec/mux/nb7vpq904m.c
+++ b/drivers/usb/typec/mux/nb7vpq904m.c
@@ -320,47 +320,47 @@ static int nb7vpq904m_parse_data_lanes_mapping(struct nb7vpq904m *nb7)
 	int ret, i, j;
 
 	ep = of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);
+	if (!ep)
+		return 0;
 
-	if (ep) {
-		ret = of_property_count_u32_elems(ep, "data-lanes");
-		if (ret == -EINVAL)
-			/* Property isn't here, consider default mapping */
-			goto out_done;
-		if (ret < 0)
-			goto out_error;
-
-		if (ret != DATA_LANES_COUNT) {
-			dev_err(&nb7->client->dev, "expected 4 data lanes\n");
-			ret = -EINVAL;
-			goto out_error;
-		}
-
-		ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
-		if (ret)
-			goto out_error;
+	ret = of_property_count_u32_elems(ep, "data-lanes");
+	if (ret == -EINVAL)
+		/* Property isn't here, consider default mapping */
+		goto out_done;
+	if (ret < 0)
+		goto out_error;
+
+	if (ret != DATA_LANES_COUNT) {
+		dev_err(&nb7->client->dev, "expected 4 data lanes\n");
+		ret = -EINVAL;
+		goto out_error;
+	}
 
-		for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
-			for (j = 0; j < DATA_LANES_COUNT; j++) {
-				if (data_lanes[j] != supported_data_lane_mapping[i][j])
-					break;
-			}
+	ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
+	if (ret)
+		goto out_error;
 
-			if (j == DATA_LANES_COUNT)
+	for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
+		for (j = 0; j < DATA_LANES_COUNT; j++) {
+			if (data_lanes[j] != supported_data_lane_mapping[i][j])
 				break;
 		}
 
-		switch (i) {
-		case NORMAL_LANE_MAPPING:
-			break;
-		case INVERT_LANE_MAPPING:
-			nb7->swap_data_lanes = true;
-			dev_info(&nb7->client->dev, "using inverted data lanes mapping\n");
+		if (j == DATA_LANES_COUNT)
 			break;
-		default:
-			dev_err(&nb7->client->dev, "invalid data lanes mapping\n");
-			ret = -EINVAL;
-			goto out_error;
-		}
+	}
+
+	switch (i) {
+	case NORMAL_LANE_MAPPING:
+		break;
+	case INVERT_LANE_MAPPING:
+		nb7->swap_data_lanes = true;
+		dev_info(&nb7->client->dev, "using inverted data lanes mapping\n");
+		break;
+	default:
+		dev_err(&nb7->client->dev, "invalid data lanes mapping\n");
+		ret = -EINVAL;
+		goto out_error;
 	}
 
 out_done:
-- 
2.34.1


