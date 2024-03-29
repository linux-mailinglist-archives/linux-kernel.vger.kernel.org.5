Return-Path: <linux-kernel+bounces-125026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E272891EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AAA828BDAE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABF61BC135;
	Fri, 29 Mar 2024 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AL9Uy+e7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A741BC129;
	Fri, 29 Mar 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716661; cv=none; b=Xr3U6ajTLupJ6AKeGr9602H2IJkPMzSUXFePAWUoeWnk98phZoVNF7uz88IEBZ3T92D0ZGGaLjRNDgj8L+T8Wwt83/0Ok2LqafMWQJUHlejoubLePsaYayvu2kq+dOuZ0rJzp6CeYxJyQBEHq/N8Xwxjq6KaiSKhusrr6YoxMHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716661; c=relaxed/simple;
	bh=quuCrbXcoNe9I9NvAbZy32FgefH0NZXt1foNau7zeL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fCsidaHguFrdwFPm4HWQZhIaM0gVrGZWqhaTV2EyCjZISzzuNNeOsvTYQl0FhisnUSUhOuc+Z8/tyDik0q6AGGn+9zfA9E/6NAhY5ioD6JpmelKp/pWakjsUVGnrnUpHX7xnLzqiE1Y8Sx0p2KNLsq2FbajltnDDgSzzcb+h3lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AL9Uy+e7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F6AC43390;
	Fri, 29 Mar 2024 12:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716661;
	bh=quuCrbXcoNe9I9NvAbZy32FgefH0NZXt1foNau7zeL8=;
	h=From:To:Cc:Subject:Date:From;
	b=AL9Uy+e7YukX1lyrAkCEz1khf5Ir5j4YzgC09/NNZ91os10vf607vpZG4TzmgOkjv
	 0b8iWtHO1jcTZFBVz0zxSNYwWGltbZbJ33FLhfdPa4l81uWQ/vSZZsGCvvoZssRrR3
	 ghHd7tZ845G+oz9pyJRC2J9yoaldXou9hAE2ca2Tb+LHSU8xgvV32NZpUyrQIcVaNX
	 Pwn5uoC2avCPFEMmUPbs8n4JWNs3VarMWC4JXahUkUSpfUqNXTXSEWxfqZXWvnou+w
	 LcOCypMvKWHPI8L5/fc5nnvA04d1+vlRvKNNFH5jw0EjJM+h5nnqBiu6G4wCwjkZ0D
	 sdi5xHFFo0svA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	minipli@grsecurity.net,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 01/19] Input: synaptics-rmi4 - fail probing if memory allocation for "phys" fails
Date: Fri, 29 Mar 2024 08:50:33 -0400
Message-ID: <20240329125100.3094358-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
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
index ac6a20f7afdfa..0da814b41e72b 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -1199,7 +1199,11 @@ static int rmi_driver_probe(struct device *dev)
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


