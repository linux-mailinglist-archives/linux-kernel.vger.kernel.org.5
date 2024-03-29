Return-Path: <linux-kernel+bounces-124713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 432D9891BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F1E1F220BA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B84144D32;
	Fri, 29 Mar 2024 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqNzNCqN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701A3137765;
	Fri, 29 Mar 2024 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715968; cv=none; b=dE27jU/qpoTbvwppzTQt6GksQYONW69Uzl7zT2wy1xALvnuFUGJl6+IddRk7rgt8NfEWMgVZKzUMpgJ1biGH0somVZC3HAE3CSxmgRC4HhygPD9oUWkZO3UTefTBKN6tlJOb00tOfiOOLcp4z4FI8QXhOGKpjLo/4LB5HKofYcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715968; c=relaxed/simple;
	bh=V6Qx7IEjDNjanIBYd/aF19fx1kAFtwWrPFkYM5xzcCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Is67bdZvcCV35G5YKYoofY8Bw0t0LvhNu7ZGMJ0Gk956A1X0eFZrJZQ46YTY/hJLWk2m0i2peCpB+8dLrUBx2GrjvEw3g2mmZA5uEAQpAUHvf2To/vnaZKlHR0DY0T4f2cQIUfZ0wXUp3pAGflNeknZF78d3wtbecVuqNjMJ1Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqNzNCqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46513C43390;
	Fri, 29 Mar 2024 12:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715968;
	bh=V6Qx7IEjDNjanIBYd/aF19fx1kAFtwWrPFkYM5xzcCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OqNzNCqN/vsZUyd1TvTQHzrB7kQ5G9j/v5rCCF9XM8Cg0bLpPrvtAiW6BKvff1grw
	 btmh2htK+Wfl7ign9g+9+6i+i+ZafYBNCKRYKWXuzbGnVfQx5RtSw01cpwdR6LYs5G
	 0eC3uJYcoWiUndxnCSOBz3I8CwgoKraxzYCBGXfj4MF6102irbEE6tyGCmkE31LXjk
	 mulrRuIQgOqpWIDGozntjy0Al1lmYGtHdKx9g59lOIbEZGFZX+Il2eib+yD1mxXD67
	 ElqOaBy7NzGDiUdqL69V+CaBE8KHbwC1+MLXIyvM/VWrOwgglbiU36tcFVBexBaBj3
	 1gaSYRFRSSYvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	minipli@grsecurity.net,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 04/98] Input: synaptics-rmi4 - fail probing if memory allocation for "phys" fails
Date: Fri, 29 Mar 2024 08:36:35 -0400
Message-ID: <20240329123919.3087149-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index 42eaebb3bf5cc..ef9ea295f9e03 100644
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


