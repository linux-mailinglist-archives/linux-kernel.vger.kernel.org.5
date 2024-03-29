Return-Path: <linux-kernel+bounces-124865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC36891D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6BD1C26FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2730B1C9ED9;
	Fri, 29 Mar 2024 12:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEC9M2Wj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC61C9EC5;
	Fri, 29 Mar 2024 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716314; cv=none; b=a6XUs0dbcjQdMg7mpNIbl/6iithT2uIMhig3PaBfMHC7kyk2AgiVjsfba/oenpZdOHwgJnhgiPnMqgqKvtixcKF2zGvTMZO/zrV2Ws5cNnFmCK5QchTkJy03V9d5kA3AfeLB++pvcA/M0+FZrZJ67Gd9U2mXz7ymrEJ1z0Cf0UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716314; c=relaxed/simple;
	bh=nzUqvTnrnZZu0hffpYlA1dzFj49gKFtl/K2Yj1yQ5ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZ1EbU8Abewb3edE+6Rbt+gPBR4CJr4zIrJBw2DJwOKa3mrSVzIg2BHmzUd259B5SQcyRD2U7/cfEZFZXjUZcBpVBLcfcqsFDMEuI9n9WTW1oi1neuP1YvdBvfLwyBEmHywDftWGXgXZwbUyyuovQ7PUZvoremLHJVtm8m85AWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEC9M2Wj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A378C43390;
	Fri, 29 Mar 2024 12:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716314;
	bh=nzUqvTnrnZZu0hffpYlA1dzFj49gKFtl/K2Yj1yQ5ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PEC9M2WjyH95xNbA8RWH/qBn6yGhgy6e+NedVuX6B0oV+ieuNmNdUfeEkfrVdZHqA
	 Ql6mZCNnoVKjO+porwHxVq75okLmYTFCW1UhhIdVxlpxxK8ioqp8pAHjRq/3eeiZPd
	 VzweE0kGirKD9mr1xpInF2RSDvx7sRgWOlpuAPsG+2bmfCMtAYwP/aja1j5qqZKr4X
	 9vtmpSHksh4X4rqtAZhFJrkLz0ymoa28nhw7+FxVuTYg8ad4Tz8eZzou65/d/zm8P5
	 caRlorXCKvv15Cq3SiDc9LoBiMo02YZ6rHNb5dJjYv0zbIl+wBp8aONbCKAfLnu221
	 QfIGWQrhPl2vQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markuss Broks <markuss.broks@gmail.com>,
	Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 56/75] input/touchscreen: imagis: Correct the maximum touch area value
Date: Fri, 29 Mar 2024 08:42:37 -0400
Message-ID: <20240329124330.3089520-56-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Markuss Broks <markuss.broks@gmail.com>

[ Upstream commit 54a62ed17a705ef1ac80ebca2b62136b19243e19 ]

As specified in downstream IST3038B driver and proved by testing,
the correct maximum reported value of touch area is 16.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
Signed-off-by: Karel Balej <balejk@matfyz.cz>
Link: https://lore.kernel.org/r/20240301164659.13240-2-karelb@gimli.ms.mff.cuni.cz
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/imagis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index 07111ca244556..e67fd30110278 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -210,7 +210,7 @@ static int imagis_init_input_dev(struct imagis_ts *ts)
 
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
-	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 16, 0, 0);
 
 	touchscreen_parse_properties(input_dev, true, &ts->prop);
 	if (!ts->prop.max_x || !ts->prop.max_y) {
-- 
2.43.0


