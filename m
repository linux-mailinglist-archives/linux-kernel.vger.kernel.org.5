Return-Path: <linux-kernel+bounces-33357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA168368BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BA92870E5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B926773C;
	Mon, 22 Jan 2024 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfhmG9ih"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E576772A;
	Mon, 22 Jan 2024 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935965; cv=none; b=Rk6jrTOkdPBBAxMF0CGHewH1nR/qmCRVKUsjIWua6iifMTTka2Ygpr5tXYZWyCPWPKfAR5Tzb9+wzWK6i/q5I7/CpEc0eCiWi7Nk6XbX0v+Z71hr+zIbY0iTlVdsW94pvcLLyhk+GW8gdxPKs2930JD+2K5FaMD1dWVbr+Lka2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935965; c=relaxed/simple;
	bh=q1gUvMaiNccD6iinqYA1zWgxswaOwb0HYsFemnlGBms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVb2uUBCtDoFrNS8vnYyvWA5DJP1Q3NWaV1Cdddu5YctwknodqnzJF9pR4BRp5wveoDkbBhnmIAb/bvG8mbHZBzKUj+iJ00Y1Yj0p9H8VflK9Cume9mey78WpSjpdt6yE4dnRDSuYPBrW9V/aQRvtYk2fdhTlQf8lwXJGYug4vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfhmG9ih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C93C433B1;
	Mon, 22 Jan 2024 15:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935965;
	bh=q1gUvMaiNccD6iinqYA1zWgxswaOwb0HYsFemnlGBms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tfhmG9ihPvbJIjmws7dgNTjnUjU/e08zMLEvzaIVJ/sPHqMyGTh8YsN1ssozv2HlT
	 vlAZktu7ZcbdCZndHvr0M5gUMKs/2+8+i7OVjeyp0BB2H5n0plW9WSD51VlB8DucW6
	 SIYVZZQprwMh2tvxSYia1pwCepXVAr2/olyAdCfdJkWkUtbukIcFfVS/xDAwREwwz5
	 T83wTMa0mq3CUFyJAUM+5qciRBptd86Or/cyAujgTo3NQgnNQ29guIIdEKxXXKxz15
	 2V06IQaBC1xpp0y1X5o0CshZltwSG9isU65hI39SPB35H9E1SWErJifhbM+bTirk2D
	 r31HiLriW0Ipw==
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
Subject: [PATCH AUTOSEL 6.6 35/73] hwmon: (pc87360) Bounds check data->innr usage
Date: Mon, 22 Jan 2024 10:01:49 -0500
Message-ID: <20240122150432.992458-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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


