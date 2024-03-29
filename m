Return-Path: <linux-kernel+bounces-124971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28089891E60
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E42287FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2668B1ACBDD;
	Fri, 29 Mar 2024 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzxCb6dZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3720B1ACBD1;
	Fri, 29 Mar 2024 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716544; cv=none; b=XK6eZsxPXu40s28u59Jf+yflOSHCTObo57MVmZysimTX2CY4ysCCCtIXnvH0g0sUhchTE60GK7wTIYgWVWKmPdP08oQIEL8XWgydmjoOn4ho/HP9RvP0iDd9NMha/ikovilhpxYCDAgAfSJlXA7tgZkpknjlRGLZNnvLJQ/gB6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716544; c=relaxed/simple;
	bh=KrtLP2+xQcj9c07YWsMGvUeNakHzSGnJr64CquHleek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uagmAOPJBFob96JP1skHOq2xcTmHGwV0y9h9xUk30GHf8beoCV4Kppn/ePuI5lSDq9cRvhLAl15/xMJyLxxdppoywZzbuzqyXP1fQYjKNgoXuiqUsbHT98pT4WKBNAXoXztkNiBbDljSrEt+au4OKdLnt4p+BGSIAtZpFpR27u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzxCb6dZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA59EC433F1;
	Fri, 29 Mar 2024 12:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716543;
	bh=KrtLP2+xQcj9c07YWsMGvUeNakHzSGnJr64CquHleek=;
	h=From:To:Cc:Subject:Date:From;
	b=FzxCb6dZb2BYG+x+UtZir83Yud8m3Mb5shMbLdMKmC3rMM/JboUksJhT4oD8JPOpw
	 g3y+g6dOSqOQfAcSJlfzskTD1Quz/SqZZCKC5hL7C9zo5KTJkw9AidPNyh/lTaSpAX
	 ZnJUgr+vQwwo6yp3ziSZDanSFWFhHac3rr8tH0zVgb0jVnyBLJHKsR503jdOSorFms
	 PDhopNz/Bbm6QJnqF+6sDmODcW4XXX+zoabOrOKyOsWdhjXAsAwOhSTtTNNi61E6We
	 iTXb7mlTx6qDc9yNGcILSe+Y2ZxcyVmCAJFbXUF2Lyxm7V4TgRRQ0m9FOFBVaNY99+
	 LXVPtU/VYPpeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	minipli@grsecurity.net,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 01/31] Input: synaptics-rmi4 - fail probing if memory allocation for "phys" fails
Date: Fri, 29 Mar 2024 08:48:18 -0400
Message-ID: <20240329124903.3093161-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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


