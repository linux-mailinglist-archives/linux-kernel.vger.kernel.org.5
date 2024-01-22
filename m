Return-Path: <linux-kernel+bounces-33259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BE7836779
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD181C22FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5916355769;
	Mon, 22 Jan 2024 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3DUDupM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F60654BF8;
	Mon, 22 Jan 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935511; cv=none; b=gWdAa7RXrKyqN8FZG6oECxveYkQyrxtGR3yD2JMg0t7IeAUyhZIoz0Zg1hgN+ftpiKmKNhrmOvrkQTBVNSf3jFIkqVDKz6G/cGL51LfTAaO8Ibz8uH6D/2V9ZtFLRET6cj8sTYc7cX3gVt9U32EAKa38a5N1Ktlr+drdmMe42RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935511; c=relaxed/simple;
	bh=rprisNEsC2uRiF1SxBvUy142ekeuxh+v3vglsrsRGUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoPuEUyJA/GkOLefQcbkcjjgMc6kpZmf4ZbDjtnhzWDsVEa320USK3f2J2Za7kXYMaKYS1x9x5zP1UfKWgC31ttaZiKhtcLPEjoL8wffgUzNG6uGaP2rJW+C+Y3k4KPsw0wNdxdUXs8tcPIwbKDD6pyjhBJQPfGQm/QBgs2pHUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3DUDupM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39F1C43390;
	Mon, 22 Jan 2024 14:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935510;
	bh=rprisNEsC2uRiF1SxBvUy142ekeuxh+v3vglsrsRGUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I3DUDupMrM4hnvKBEqmmfDJ+e8ZH0AUdvalBrln5Ypfvv7yddMzrZ51B2YEBaAQcs
	 rjvS00VAOTpXX8Pd1MeaIwSsruBsnVFEs+M7RrBHuwCcp2cfPtrN/oLjA4J7A07/H0
	 pI0ZPs3dxkNSglnoivCuZ8JXGIzYgz9RGOiS5c5S1+QcX8kkUrdy2LDUhqsv/Y5DVI
	 nXc8CBa98ETyoillIPDRpAEQ7ZTTDChYI6s5Jry1lravBB2CjfbSh9bi+pE210v8Rm
	 yVMSTExOEWFzLj5SCPnLH/aQoKNScNaDaRcofJPSAA1k96BKScUffFC1bTRJNZy3Zv
	 MScHyL/y48dKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xing Tong Wu <xingtong.wu@siemens.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 40/88] hwmon: (nct6775) Fix fan speed set failure in automatic mode
Date: Mon, 22 Jan 2024 09:51:13 -0500
Message-ID: <20240122145608.990137-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Xing Tong Wu <xingtong.wu@siemens.com>

[ Upstream commit 8b3800256abad20e91c2698607f9b28591407b19 ]

Setting the fan speed is only valid in manual mode; it is not possible
to set the fan's speed in automatic mode.
Return error when attempting to set the fan speed in automatic mode.

Signed-off-by: Xing Tong Wu <xingtong.wu@siemens.com>
Link: https://lore.kernel.org/r/20231121081604.2499-3-xingtong_wu@163.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index d928eb8ae5a3..92a49fafe2c0 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -2553,6 +2553,13 @@ store_pwm(struct device *dev, struct device_attribute *attr, const char *buf,
 	int err;
 	u16 reg;
 
+	/*
+	 * The fan control mode should be set to manual if the user wants to adjust
+	 * the fan speed. Otherwise, it will fail to set.
+	 */
+	if (index == 0 && data->pwm_enable[nr] > manual)
+		return -EBUSY;
+
 	err = kstrtoul(buf, 10, &val);
 	if (err < 0)
 		return err;
-- 
2.43.0


