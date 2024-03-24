Return-Path: <linux-kernel+bounces-115525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F31798896E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE22129309F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C5B23EF04;
	Mon, 25 Mar 2024 02:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgBmxIDX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B20C1494DE;
	Sun, 24 Mar 2024 22:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320978; cv=none; b=KyBW0sEuUqRS8CTE76X/0hIUvBMFxfbaqikgOthYIqipKAcmD8SYCM87sFAPKxUIMSl+zuRSeUFIVnqLdq93REFnDovTmpGnHg0lXF4kYUs8u4me58lOsRXRKOaqspB2xg7TFx3/4HChXMpW+m2yr+sibw7Pk+FKzCvs8r9cTog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320978; c=relaxed/simple;
	bh=bp1Fpbg0r4rOlDDELyrOjAlejZsZMctkuCGncAfZ4/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUS2xQD7ffaksVSa5lXleCgYTbj93ksmUT+Rq/1grtH7GJMgCvOvpfwGV1Air+ErErW3y3s8ExbnHeB6lmURaRs0lh3qPoVvE9qbccNvjmytpWgTUJlDqRgzpgTzN22kEi6M7slcB9JhXmh4qNOHv1hj734y3Y9WYD8I/Y584dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgBmxIDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47987C43394;
	Sun, 24 Mar 2024 22:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320978;
	bh=bp1Fpbg0r4rOlDDELyrOjAlejZsZMctkuCGncAfZ4/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qgBmxIDX+AC7z+k2w0Z9spqg/6FwpMkhJ6oHu3OwhCNCpeO+32DSXheXxF7mn1Bsf
	 Gj+SCe8IaK772SKGnGFwzdwWHZS1X76P3edOd+QYC5w8Hxjyze5Z72X3Vai0RsDzR9
	 Ywds28DNUIg3JixvsbRI2Bx5zSiPXrroXrcW++AB9Q6gXnvUmKA6CDI0L6GLSl+80c
	 LJiLjQg6GdxPhXIK3gBDAM+373706KysxzK2NX6S9Xs5fnaPRj0U920JOcEgCDsgh9
	 Y2uvfeLqkxJ2jc7cxUX2xMf8Rrlelx0f8Bcu0zP21bt09/afCTnYCLwaqIcFwr310I
	 VyqtapI1ycuIQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jianhua Lu <lujianhua000@gmail.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 541/713] backlight: ktz8866: Correct the check for of_property_read_u32
Date: Sun, 24 Mar 2024 18:44:27 -0400
Message-ID: <20240324224720.1345309-542-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jianhua Lu <lujianhua000@gmail.com>

[ Upstream commit f1ac3c9825f99c93a9833beee6b78aa386e55b0b ]

of_property_read_u32 returns 0 when success, so reverse the
return value to get the true value.

Fixes: f8449c8f7355 ("backlight: ktz8866: Add support for Kinetic KTZ8866 backlight")
Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20240129122829.16248-1-lujianhua000@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/ktz8866.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/ktz8866.c b/drivers/video/backlight/ktz8866.c
index 9c980f2571ee3..014877b5a9848 100644
--- a/drivers/video/backlight/ktz8866.c
+++ b/drivers/video/backlight/ktz8866.c
@@ -97,20 +97,20 @@ static void ktz8866_init(struct ktz8866 *ktz)
 {
 	unsigned int val = 0;
 
-	if (of_property_read_u32(ktz->client->dev.of_node, "current-num-sinks", &val))
+	if (!of_property_read_u32(ktz->client->dev.of_node, "current-num-sinks", &val))
 		ktz8866_write(ktz, BL_EN, BIT(val) - 1);
 	else
 		/* Enable all 6 current sinks if the number of current sinks isn't specified. */
 		ktz8866_write(ktz, BL_EN, BIT(6) - 1);
 
-	if (of_property_read_u32(ktz->client->dev.of_node, "kinetic,current-ramp-delay-ms", &val)) {
+	if (!of_property_read_u32(ktz->client->dev.of_node, "kinetic,current-ramp-delay-ms", &val)) {
 		if (val <= 128)
 			ktz8866_write(ktz, BL_CFG2, BIT(7) | (ilog2(val) << 3) | PWM_HYST);
 		else
 			ktz8866_write(ktz, BL_CFG2, BIT(7) | ((5 + val / 64) << 3) | PWM_HYST);
 	}
 
-	if (of_property_read_u32(ktz->client->dev.of_node, "kinetic,led-enable-ramp-delay-ms", &val)) {
+	if (!of_property_read_u32(ktz->client->dev.of_node, "kinetic,led-enable-ramp-delay-ms", &val)) {
 		if (val == 0)
 			ktz8866_write(ktz, BL_DIMMING, 0);
 		else {
-- 
2.43.0


