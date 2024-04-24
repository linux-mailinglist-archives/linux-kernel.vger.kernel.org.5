Return-Path: <linux-kernel+bounces-156110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EB38AFE10
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C47B1C22F72
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1900C125C9;
	Wed, 24 Apr 2024 01:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAU/aA/F"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E824101F2;
	Wed, 24 Apr 2024 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713923589; cv=none; b=qjRSpMdaRiaRPv3xfsOg6MBJQiaOS9j1jwvztf0KcSba7SPVfERZEDoFLtshl/MgkYmOBGlUxPosN8/e/naCJ5OhkDP5s37acwNk9KAPsSN8y1CcHYOfQhtscxL0re0JsHCZr/gFH0+bx03Eneo01AI8Edp1Qa+B1uL+gLHDaAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713923589; c=relaxed/simple;
	bh=PThITv7YBA7tYPbMYW9Vhx8MShzInnPREyhu+swHDo0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G7fWWd+OwZzp7sC9xbc18a8CBy86SFUocYcM2v0uE2TwZQHclUKh82BEMbmn9VOZf8mcG6Tj3x17MrP7c885FhtTK3wOoDNbKZgzjt5HGjAj/ddUs4i7lgqmBHJ5pMGwN0aHzKu9vqSbGK1LZJTGUdZE2XcMLJ/N9zYoCAFZwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAU/aA/F; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-22ed075a629so2542290fac.3;
        Tue, 23 Apr 2024 18:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713923587; x=1714528387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+boyDLjblvWwLLkrJLcGOfn00OcpsPMnSVwVZAPX45M=;
        b=aAU/aA/FtBvxN0uzuNAsnvB6YKxqPX5fAegN/QOVsPR4QahTndQ0NK0YZVadDorV3C
         bv2Gx2buUf9UYB7IwSfoh3HoI97EaQ0mM7SE4wdSCFL7Zp/jmW7XU92wxMQv6J/4Biiu
         XYnF4eE0Exs3ikxfwTU8kaLTLIZ7IqyyMifbNvxbyYe5hp8bKxulsupPgSCHXwWBlrSO
         3qcty1NpyoshGk/q7Xt3nUpOz2GJMCy0eBS2ndvIfP0PqqVFno7j1tXkOC8DSGA/Tu2B
         KR9NZ565ePP8zgOAnDxFyMI6ahidILAyNqlQmHGYM+mOcQ7YPL9qbNmBkK+tgeUk4PH5
         fQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713923587; x=1714528387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+boyDLjblvWwLLkrJLcGOfn00OcpsPMnSVwVZAPX45M=;
        b=hU9hO5synsMavBMa13HDo5kq4501TwthYwMZXrg8Oo4cGjSCBj4CgTnBASGgEJE1Jz
         f+SAsY+VoVwRFghBIZFhI0neTvgj/zSeKMNPxPN/grM/3ikz48kHwU1hBT6FXS1hUeC3
         ZKDQwjgV0FMS/JsdQi6jd5f2XQevzz3I/z0p/7slyAuFIgpLN9HEBCLmtmZv/J4Q3GCA
         nFgePy0tZJHIrXXlXfr1xTC6MdPDLwqS0v6nachfrKgLn6Y+xJxFQzzO0FWBwQtboe7Q
         Igg8UJcPaTg+onOzutmP47rEoMFEmqg5jvo9Zu2yxXG1oU6oHKDMjktQWutPPt34JL7n
         b3ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWEdW9MGYfpRcQElhYVmzXnKljfSWSip02ug0jkXVnqgRO6uzjR99YYfStyiRJ7wwG64FKBN0DPE8kXFtM47a92hZ6AD2A4TZrljTcHukXAwPIAiktr1FwkB0VY553wCnMZP61rWtyOzHM=
X-Gm-Message-State: AOJu0YwvWMnyyT0WawmPFK8oy2nXB73457KeH0n+VFfngguxNxu/WlEC
	4cA83wfLiODh8f8dEnquR4OJ1E1qgh+sFBZNf5RJ/h3K9DnUQcfp
X-Google-Smtp-Source: AGHT+IFWYc9hWRZOugTElp/4rhqr5aMbNkJE8+hQKtCwCpTLGfdCSwOigY0tmnjVvWdPGFRZsVa2Gg==
X-Received: by 2002:a05:6870:a345:b0:238:b140:1ab with SMTP id y5-20020a056870a34500b00238b14001abmr1132265oak.48.1713923586779;
        Tue, 23 Apr 2024 18:53:06 -0700 (PDT)
Received: from localhost ([2806:103e:22:49d9:6aef:e478:d2bd:bbe])
        by smtp.gmail.com with ESMTPSA id bm43-20020a0568081aab00b003c4f39fb9e7sm1899925oib.36.2024.04.23.18.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 18:53:06 -0700 (PDT)
From: Miguel Miranda <mmikernel@gmail.com>
To: thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr
Subject: [PATCH] drivers/soc/tegra: Replace dev_node refcount management
Date: Tue, 23 Apr 2024 19:53:06 -0600
Message-Id: <20240424015306.1796838-1-mmikernel@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the manual refcount management of device_node
and instead, use scope-based resource management.

While the pointer never gets out of scope it reduces
somehow the risk of missing the of_node_put() call.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Miguel Miranda <mmikernel@gmail.com>
---
I only have a deprecated jetson nano dev-kit, but need
to test this on hardware. I am exploring options to
build a rootfs to test this using qemu-system-aarch64.
---
 drivers/soc/tegra/common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index dff6d5ef4e46..94d11102d90f 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -28,14 +28,12 @@ static const struct of_device_id tegra_machine_match[] = {
 bool soc_is_tegra(void)
 {
 	const struct of_device_id *match;
-	struct device_node *root;
+	struct device_node *root __free(device_node) = of_find_node_by_path("/");
 
-	root = of_find_node_by_path("/");
 	if (!root)
 		return false;
 
 	match = of_match_node(tegra_machine_match, root);
-	of_node_put(root);
 
 	return match != NULL;
 }
-- 
2.25.1


