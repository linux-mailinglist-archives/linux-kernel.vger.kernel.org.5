Return-Path: <linux-kernel+bounces-139021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D412D89FD8E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB3B282958
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1217E1552F7;
	Wed, 10 Apr 2024 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IffJcqNA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5244D154BE7;
	Wed, 10 Apr 2024 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768496; cv=none; b=EdeubSzyYwRJL7WpvAhuz+qIZbAhQOL6xMHDveBNd37BoVQL2eGnUvOLzQozbyg6OcHQhXeBHyc5gw4RM6a8p5PN3u35IWIuaKRKeW8XP2v/L+lhlIhV4DYRyVyVD4O+ECxmTl8FRkpgE28dEYXMiZLpjbQwQnSQid726wIJg1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768496; c=relaxed/simple;
	bh=X8O8ZYOPEK1I4odZztBRGcqlUHQFHy0MNOIA0Ihlr0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VHvT32zPwwy0tp7m/mev7fjnw6vlukS5/1f0GP8TpZxulqWAulh0UbUTu+4ucv+uYBKcLwsFYjAH/r6elbLTUYBzrtOjqRXpPBpupIAxHjZ+XaYXf4lARV2C8KC8AyudptLlatus6xQ4qsoGRknNf/dOJ/hchgv6yQ4gfpezG5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IffJcqNA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69955C433F1;
	Wed, 10 Apr 2024 17:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712768495;
	bh=X8O8ZYOPEK1I4odZztBRGcqlUHQFHy0MNOIA0Ihlr0s=;
	h=From:To:Cc:Subject:Date:From;
	b=IffJcqNAhM+kVjSTdplcrBLLNcc8cXZypFxabEQ98E7+rVo20+OCmJaO2cByt8Cmi
	 /nsspM5BMmy9RQ/dzi9I8Nn7cl313DY311YzXNguGoi5MV5/66nXxFBhMCSkit1HUg
	 6Zd4a4wxFzPHnVab4j2ygr2vi7GuLHxIoueg1n06J1TiWbXKQiXIDOQRwWetWf9mxO
	 3EYE5k6sLEkQN2Ozhm27eqKxUxRc3S8NonLGQInAekssn3F7kDMP6KG9lt7qc5XqJQ
	 fcym1pUTVc7IPOSwjrt4pIdBTN5qLr3oBa++HUsEUCs/xOFzdKK7ZGAvxfmnreWqzT
	 eZ3GM4/p0uJ+Q==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] slimbus: qcom-ctrl: fix module autoloading
Date: Wed, 10 Apr 2024 19:01:29 +0200
Message-Id: <20240410170129.248361-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.  Pin controllers are
considered core components, so usually they are built-in, however these

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/slimbus/qcom-ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index 400b7b385a44..f7d04b50c973 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -718,6 +718,7 @@ static const struct of_device_id qcom_slim_dt_match[] = {
 	{ .compatible = "qcom,slim", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, qcom_slim_dt_match);
 
 static struct platform_driver qcom_slim_driver = {
 	.probe = qcom_slim_probe,
-- 
2.34.1


