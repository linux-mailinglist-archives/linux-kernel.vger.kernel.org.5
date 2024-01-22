Return-Path: <linux-kernel+bounces-33428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DB9836997
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A8DB288B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7B486ACD;
	Mon, 22 Jan 2024 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBUXY32b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF2F8615E;
	Mon, 22 Jan 2024 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936261; cv=none; b=L4RV2x7Cjch5twbijPgc4rqhvQ69HfyjhUcbR5K1DTmPdUTCw8mbru89zBNR2xkkl1TdS8vJjHFkrMYaFjst9tJXQ2VY7NeGbC7yhY+iRDxltviDONA778UW1IRULIn85LGizf/VuLdkHVF+1CUyyVaRrlPPQysNo9lX4Tv3MoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936261; c=relaxed/simple;
	bh=q1gUvMaiNccD6iinqYA1zWgxswaOwb0HYsFemnlGBms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/5udcNnZLYCCYPeGFDbSTwpSArKHH+gyQT+Z6fqPAPsYL2dolktxvp0LDGKpU4CY945yHgS0W86/WJb54N4m3ZE7e2QwLofPAVHlXnn3cmVOnoLzSSxON6KLzB5xueYonT8LNeDPdul6znBQKQg7g51UeuPY+ZUb8WtFePjajw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBUXY32b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C7DC433F1;
	Mon, 22 Jan 2024 15:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936261;
	bh=q1gUvMaiNccD6iinqYA1zWgxswaOwb0HYsFemnlGBms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MBUXY32bJXGSg8oq7G5EzVjmy4f0DtIzGDpjxljR/d1KFOjtG/L6rElYtPSpacJ+f
	 Lw8+UrRY8OF4KZIu8e//c8fsuV3/og2cw6fjYeJHg6O9bijMdT0zglRzaPcfKFQk2J
	 FQuknSKB5SxQe6NDHsTXRGQZSJbHKrsCotVK8ULM6arImGXYGnAU8XGhNarbvfYup1
	 nVw8Y5UAvXrcs/NXARNzC+DpBUppxvwLbDfUxGWKMm9xVGf1077lkKWkaiww08o7rk
	 3uhMfWEQer2rYEPoA59fqj1EVST7jOIybO8fAptgItSqpIucQ3VY8/lW2HDcnYlt9L
	 nwS4M5UtVfWZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Jim Cromie <jim.cromie@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 28/53] hwmon: (pc87360) Bounds check data->innr usage
Date: Mon, 22 Jan 2024 10:08:29 -0500
Message-ID: <20240122150949.994249-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 4265eb062a7303e537ab3792ade31f424c3c5189 ]

Without visibility into the initializers for data->innr, GCC suspects
using it as an index could walk off the end of the various 14-element
arrays in data. Perform an explicit clamp to the array size. Silences
the following warning with GCC 12+:

./drivers/hwmon/pc87360.c: In function 'pc87360_update_device':
./drivers/hwmon/pc87360.c:341:49: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
  341 |                                 data->in_max[i] = pc87360_read_value(data,
      |                                 ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
  342 |                                                   LD_IN, i,
      |                                                   ~~~~~~~~~
  343 |                                                   PC87365_REG_IN_MAX);
      |                                                   ~~~~~~~~~~~~~~~~~~~
./drivers/hwmon/pc87360.c:209:12: note: at offset 255 into destination object 'in_max' of size 14
  209 |         u8 in_max[14];          /* Register value */
      |            ^~~~~~

Cc: Jim Cromie <jim.cromie@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/r/20231130200207.work.679-kees@kernel.org
[groeck: Added comment into code clarifying context]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pc87360.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index a4adc8bd531f..534a6072036c 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -323,7 +323,11 @@ static struct pc87360_data *pc87360_update_device(struct device *dev)
 		}
 
 		/* Voltages */
-		for (i = 0; i < data->innr; i++) {
+		/*
+		 * The min() below does not have any practical meaning and is
+		 * only needed to silence a warning observed with gcc 12+.
+		 */
+		for (i = 0; i < min(data->innr, ARRAY_SIZE(data->in)); i++) {
 			data->in_status[i] = pc87360_read_value(data, LD_IN, i,
 					     PC87365_REG_IN_STATUS);
 			/* Clear bits */
-- 
2.43.0


