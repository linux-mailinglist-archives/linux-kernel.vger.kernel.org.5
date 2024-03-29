Return-Path: <linux-kernel+bounces-124937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6596891FFD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B019BB33B67
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224541A6480;
	Fri, 29 Mar 2024 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxYyOnKM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A40B1A6463;
	Fri, 29 Mar 2024 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716471; cv=none; b=PFjY7nxPR4Q6fLJfCjlVZdfHKeTPATdDd3ClaswmA1y8Lir/+XoS8+7iDRrfsvufKZM6EgtfiTZi4vMfEuDPwUjCjKzkoDlBWYbTDhwsvQb+51/mXy6OpHEBtseaExUTZW01WTgvqze1eWDo0+KgRgyi1/JzmJ2aXMgdl0L14dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716471; c=relaxed/simple;
	bh=KrtLP2+xQcj9c07YWsMGvUeNakHzSGnJr64CquHleek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZeI+vngTz0nQcKfbOkWRaSpYF9Bvt749ER3akT7elZZQMGYKKkpWiMb+dk5e/4r7PRzOuaHv6I785MpGIpkkA7j4R2x4gZmtrogPlh1SlNJwW5dZ0DISs8uoqzA4VJwI9G85H4MKcctZAKbmParSVfjfYq38HVhlpwwstvpVdpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxYyOnKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649D8C433F1;
	Fri, 29 Mar 2024 12:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716471;
	bh=KrtLP2+xQcj9c07YWsMGvUeNakHzSGnJr64CquHleek=;
	h=From:To:Cc:Subject:Date:From;
	b=bxYyOnKMediWNUcVlJK/bxCisJ+Ii51JZ0YG+JEJrst5PY4vbCTUWsV5FWQGwpCdq
	 gj5adxV68pui6Zytmu2wxgRKCFYeNbx8eXi8Bb5q3dmlXP9VGfosGaDrdNIDCmb1Dp
	 6BQR+wlG8gXyzdPqvnJ53/vdc8f8tUqtXjwet11iTC8ULI9sfhV6W8DUb2+QCmYAwg
	 9j3iZwmwMTnR8/kVjhfp5MWicxH5yE/CyOjMIqc/7mWxQoj37RB6kUefWSuXvS+snq
	 RmdYcZAkaaV+8QFxUj/NKk5Qo6Dq+0L3OrEmyq2fv/ouyHQyEf8N5iSbt5lIZ/ZEFz
	 JwHweG+7v+VEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	minipli@grsecurity.net,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 01/34] Input: synaptics-rmi4 - fail probing if memory allocation for "phys" fails
Date: Fri, 29 Mar 2024 08:47:02 -0400
Message-ID: <20240329124750.3092394-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit bc4996184d56cfaf56d3811ac2680c8a0e2af56e ]

While input core can work with input->phys set to NULL userspace might
depend on it, so better fail probing if allocation fails. The system must
be in a pretty bad shape for it to happen anyway.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Link: https://lore.kernel.org/r/20240117073124.143636-1-chentao@kylinos.cn
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/rmi4/rmi_driver.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 258d5fe3d395c..aa32371f04af6 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -1196,7 +1196,11 @@ static int rmi_driver_probe(struct device *dev)
 		}
 		rmi_driver_set_input_params(rmi_dev, data->input);
 		data->input->phys = devm_kasprintf(dev, GFP_KERNEL,
-						"%s/input0", dev_name(dev));
+						   "%s/input0", dev_name(dev));
+		if (!data->input->phys) {
+			retval = -ENOMEM;
+			goto err;
+		}
 	}
 
 	retval = rmi_init_functions(data);
-- 
2.43.0


