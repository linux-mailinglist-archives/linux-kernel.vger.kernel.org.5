Return-Path: <linux-kernel+bounces-124811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84011891D85
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 171C4B26F89
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5313F1494A7;
	Fri, 29 Mar 2024 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrRu4yz2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF1E14900E;
	Fri, 29 Mar 2024 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716214; cv=none; b=GWu6IEhPbxHVHCOwNCFY6HCRdaffQrKQ5SPpwuI1Pxv9cX8VeAu46NNDjGhL2nejouwdJxRztjCRMjILSUd34Jbsq7W63as8wlJyNo/h6QxhUbqKbYjbEjl9eBYfUvjCe7wObCDOHO5Zkg2vYoqX/x69Jvxn8Ufj+Wu7Iqgq9JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716214; c=relaxed/simple;
	bh=KrtLP2+xQcj9c07YWsMGvUeNakHzSGnJr64CquHleek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRf1VfYPOlptHsJ/uru941DL8zsd1pwnwwPpNJCI2ZFU8+sSuDIIOv7KzRR2j6RZbxO9kXgH0sZZ5+GYAnw+CwuJKW/0nJdFux63xGXut990TsgVpGrBA+iP5vTOpe7Y2Jop2tsfwTQWOSfXe/ggx21A5s1XFHF76WrWQnWnJzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrRu4yz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D33BC43143;
	Fri, 29 Mar 2024 12:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716214;
	bh=KrtLP2+xQcj9c07YWsMGvUeNakHzSGnJr64CquHleek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QrRu4yz2DL4LPouKx7lvXLPve0qpjA45gG8y/rYlExoDk5HsWiCLOl/CbIul0F+S3
	 PofR+WJlXz2XJry6ZyOyd7U0kgMI8BqPJmyLcMNSvIu0l5fKxq3nlUfJZt3mREpV2a
	 byNJtSSf+Uv1LBTzu3hAlbw4kLTrwQb667VRbg6GZVpsiOQzUj9apc4Q12bTXakaff
	 eMf0p/xf+vXyuflmUKUhgSdhoFBaHOXHZAcgWGq1d04Al1J75Gc8bbj4KPyyfjgnO+
	 PrwxrZZ4LwTEkQjfvMBW20claud+UK/AE/R98mG7NKwkKwo9wIE3mta25j+wsJbtmK
	 k5wLNOKly1JAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	minipli@grsecurity.net,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/75] Input: synaptics-rmi4 - fail probing if memory allocation for "phys" fails
Date: Fri, 29 Mar 2024 08:41:43 -0400
Message-ID: <20240329124330.3089520-2-sashal@kernel.org>
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


