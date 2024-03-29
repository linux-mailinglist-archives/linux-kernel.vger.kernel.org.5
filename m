Return-Path: <linux-kernel+bounces-124886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19417891D73
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E7428640B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D9B21C177;
	Fri, 29 Mar 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pn5aI97U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F2D14AD22;
	Fri, 29 Mar 2024 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716368; cv=none; b=GD3ceJeYucyYgMPX3GgmEqhjSd2kmmV7ud2zhvCuekEk1Pmu5aE9X9veC9FhTeNoluV1uGrCE0Qulb2rFyP/1WYivL/muM4OTk39VQKydOqxVUslB2iy5wYSl36Hy7fEjrDNo2gHxDlQrRZWKReQMfqUvaJF/xg2WyADA77IOAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716368; c=relaxed/simple;
	bh=KrtLP2+xQcj9c07YWsMGvUeNakHzSGnJr64CquHleek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6f3n799c6tkZpP4LcngqNucz4mh+bZiO71pzpzPxQFk8CFkIyEV9+i+yUBkiqDTbW0Jqc0kdK1eynddE6BSKbPAy0LC7LQFhs5Hemdhl1ScxBpAJC6IevVuMja585jMe102RqGMS8ZlIpfg1T33Nku6ufEjun7SYGwp8kFeR/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pn5aI97U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC96DC4166B;
	Fri, 29 Mar 2024 12:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716368;
	bh=KrtLP2+xQcj9c07YWsMGvUeNakHzSGnJr64CquHleek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pn5aI97UgpuTaw03E/mMdtMViJyTVjJrWD0X0Tri5YLbUVG1GHzYZ6Qq06UOsLZS0
	 UdMYxmtJJrddhQxGg5WAtzCF6kFlbb6jv6G4mXIDin7Dbn4BanefvjHSuY9gm5X2w1
	 8F8LSb6F0d+rfmZlPwsTRyeNtybLkhh5SlRMwY0ZtijgTUP0pAn1DxDf7Rr9LWU0JA
	 FMHG+zhcevPMMnLmm+KK1wHT9jhTV/8ZDvEGFxs3D3p7imoCvy80ZerXvLiA9+k/8x
	 AXGVszP2roaL+l97JVOnSmpfKnJzGtjrD567i2Eoq4jnzQYJLLSOpIwL8P6KZZlzql
	 k3o8DgzGLi/PA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	minipli@grsecurity.net,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/52] Input: synaptics-rmi4 - fail probing if memory allocation for "phys" fails
Date: Fri, 29 Mar 2024 08:44:56 -0400
Message-ID: <20240329124605.3091273-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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


