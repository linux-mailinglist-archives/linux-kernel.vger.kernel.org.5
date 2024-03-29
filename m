Return-Path: <linux-kernel+bounces-125003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD74A891EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61BEC1F25DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976D17FBB0;
	Fri, 29 Mar 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAAZiASc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59AB16DEDA;
	Fri, 29 Mar 2024 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716610; cv=none; b=nFqeYwhkQ1hiGLSOn5hhbrr9+zUE83kvQscVocp6PxbUlHxi9FYiNp1V4i0TRNr36z+csyE8mzvkL8tf1FCyvvl9M24BkJn/hdV6AC4gTmUSTmsRafBa2yU6EA1dzbQjYU/IWXQpoKLhMnaHqwVONyDX5gGvi+6rjLPD7iYwdOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716610; c=relaxed/simple;
	bh=KrtLP2+xQcj9c07YWsMGvUeNakHzSGnJr64CquHleek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZO/XBCqFczgUTwJCBpS5eFhg5S4cWj2+rTp7bOYo1dA9qoNH2sOBG2GK4V9Qh52q/Rr1jEVv/ZLAeRPu3PWDJCDkL6FYnh3g5EE+a3YUYv8eWeVef0kzjsxcUxZ97aZtCyAV7+xORSg85RelA7SvtLopedU4/kIIyelbpzHq0wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAAZiASc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE419C43390;
	Fri, 29 Mar 2024 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716610;
	bh=KrtLP2+xQcj9c07YWsMGvUeNakHzSGnJr64CquHleek=;
	h=From:To:Cc:Subject:Date:From;
	b=DAAZiAScVtpf4YjI7RG5/5K89VTh2FwEZIXvZpae2fo96TwC2G9cqv4IYUSq6uu/8
	 2cNxYl2XKLm3bPkvXLZvmijRbXNDvCGQNuMT30c9B22Db+Z2rHoJ/3K832it7EIliN
	 FyWevyPsTtwbPVvfizX/jOW+mhLulA/TCLdb9nphg2UE0CUh+fF0PM3zk5tKG7yUyR
	 qI9XaLd2FSW/ixzIMZSa8MpS+1ZLvgbbclj0np86xLGo/3NxA4IfHYpsI/sEnw8X/R
	 zyt4eVzQ80oxC6wiEMB+qoUH6qCPhmzXUnVUAG/I2whiWBsFxK1uVOYufR0C+vXaM0
	 /RROMKktFYGJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	minipli@grsecurity.net,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 01/23] Input: synaptics-rmi4 - fail probing if memory allocation for "phys" fails
Date: Fri, 29 Mar 2024 08:49:34 -0400
Message-ID: <20240329125009.3093845-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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


