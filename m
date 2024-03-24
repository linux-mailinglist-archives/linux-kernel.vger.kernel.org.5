Return-Path: <linux-kernel+bounces-115028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BF1888C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A429F28FC69
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2660D74421;
	Mon, 25 Mar 2024 00:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a53+j1mb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B2317CF42;
	Sun, 24 Mar 2024 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323804; cv=none; b=vAENiqVImNznDP/oZnFqTVwDFWcKp9dW2xYzdM5wvM7QU9IpYc5dPB9+nIk/2g7LSrsm4wfhN4RfhxXxagPFQEMHBdFBjnLIsoNn7pekVDCSRBmPGvtZtzFQ/ERbcTT6i/yUe73t5dpl76p2nSfxhZk/nazcSfau67UBjg8QRB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323804; c=relaxed/simple;
	bh=WcWIkH5q7zZPWwW1JMd5ars6aARZtyMpPCQlr0PEIBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVGd2e9JQHd2XN31c6efWSNakK7yTZrj8KR/JXTlzd1f7/RAjy9nMInq+oQkZ3kSX774WbsIgkmAzalfdb3APCYxBYJ3OVusCSdbiJwo/qExIFPiLGeBWMRcY0AKeHE2261jPbOQztGWSVk8/GHG2V+cf+Kl0q1/fqr7+lR1vJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a53+j1mb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3D7C433C7;
	Sun, 24 Mar 2024 23:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323803;
	bh=WcWIkH5q7zZPWwW1JMd5ars6aARZtyMpPCQlr0PEIBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a53+j1mbcbREPT+ZymrcXBLGiwGKAIqG8MhRCH701AMZ+CPtTq2TZQrHVthR2+CIX
	 6lC87cHq21gOp2o+MiihZT+cSk4A/gPthN7yg6pHSRPgrCbLyB6WCtE9eL6EcCjVtu
	 Tq07ziyQbVvESXZfGKWbumdlFt67zREkKIsGyx86audBrHh4jo/txmnWJoT3mndxXH
	 CHU4/oIJjQPRcF7Ore+dggJE+uRYHtGbnEJHEJWqb8ZxBbDt06oZ4Gdhasb+XjeOf5
	 1uVobJu6FYqHnbQLJbfAM2JDJVibOhOJ2ZpGDDfjXNlVqYrpteTqlb0Rlljo2BcYZt
	 0WQ2djNZvrFLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: George Stark <gnstark@salutedevices.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 181/238] leds: aw2013: Unlock mutex before destroying it
Date: Sun, 24 Mar 2024 19:39:29 -0400
Message-ID: <20240324234027.1354210-182-sashal@kernel.org>
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

From: George Stark <gnstark@salutedevices.com>

[ Upstream commit 6969d0a2ba1adc9ba6a49b9805f24080896c255c ]

In the probe() callback in case of error mutex is destroyed being locked
which is not allowed so unlock the mutex before destroying.

Fixes: 59ea3c9faf32 ("leds: add aw2013 driver")
Signed-off-by: George Stark <gnstark@salutedevices.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20231214173614.2820929-2-gnstark@salutedevices.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-aw2013.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/leds-aw2013.c b/drivers/leds/leds-aw2013.c
index 80d937454aeef..f7d9795ce5e1f 100644
--- a/drivers/leds/leds-aw2013.c
+++ b/drivers/leds/leds-aw2013.c
@@ -397,6 +397,7 @@ static int aw2013_probe(struct i2c_client *client)
 	regulator_disable(chip->vcc_regulator);
 
 error:
+	mutex_unlock(&chip->mutex);
 	mutex_destroy(&chip->mutex);
 	return ret;
 }
-- 
2.43.0


