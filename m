Return-Path: <linux-kernel+bounces-113240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A063D888292
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406731F21D1D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A350184F16;
	Sun, 24 Mar 2024 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVvEUP4H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E025D8E8;
	Sun, 24 Mar 2024 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320041; cv=none; b=ttZt65F8QHZBS1XHq89WECHTmMHIzsj3xm6ArxyBRYrT0Ymr4TRVQta5EoFgkoDa7AV9Q1UG1jOqo5vW54vpV3s2vJLprShpY3d63ZJ3pGHRrctSDbs2SeSyPDtmCuUKY7T1MVQI8E1UvrCdMawhJHf6m/vqxq3/Rf6hT1Q/RLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320041; c=relaxed/simple;
	bh=CmHz6jWUtmUH5j71hEdoZCyHHv5OIGWwqJJyu0uZFJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LR5B5V+YQSvuaTJuf6ycaTc++OHmZeRY/CsO3kXcr/0FaC0w1xEfJKuj6LvPIKtM8mjHTsZ1mlJv5IyYe/zSZNtFvp1jVIz01jB3zN5Bre18YKYOC8UHICPAP+zCBrkXBZr0B59PY2qTbGvfMuriw7hMQIQqDe8lpKQMqL1H8gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVvEUP4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E9AC43330;
	Sun, 24 Mar 2024 22:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320041;
	bh=CmHz6jWUtmUH5j71hEdoZCyHHv5OIGWwqJJyu0uZFJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qVvEUP4HdZnrVewsmg3JKk8IzmhD0pjd7kCCsdq/SPUm7NG2RN3wk5CF9qzOWBxlV
	 rNqrJngKWXzsHCTQ1wYZMuij24lLbXP+T4H2VNekvZEozfmFPdSI6JKC+KrIn3jvZx
	 6AI3yqNFJqgmJlnm43pWCalC5faRTfiVPJ67Et+p7Q0qWMEm6wT5pQLfS5Cq9Ajvl/
	 /lRXVOLyzSW+c6ROd5UrmclxPXyq7oIFJlX8IvDLKcYEDEbeafFKkK9bo70JnIJEYi
	 EqCOiM2e8O/NMktkg0A+Hq8eMwXLfUq63lc8a8Lo6E9hMdVbNfanZ2ov9PB8unu+0I
	 xSPE60NRT0DNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brian Masney <bmasney@redhat.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thierry Reding <treding@nvidia.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 349/715] fbdev/simplefb: change loglevel when the power domains cannot be parsed
Date: Sun, 24 Mar 2024 18:28:48 -0400
Message-ID: <20240324223455.1342824-350-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Brian Masney <bmasney@redhat.com>

[ Upstream commit 4350aa21cca48a5d951ba108290bad703fbc0630 ]

When the power domains cannot be parsed, the message is incorrectly
logged as an info message. Let's change this to an error since an error
is returned.

Fixes: 92a511a568e4 ("fbdev/simplefb: Add support for generic power-domains")
Signed-off-by: Brian Masney <bmasney@redhat.com>
Acked-by: Andrew Halaney <ahalaney@redhat.com>
Acked-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231212195754.232303-1-bmasney@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/simplefb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 6f58ee276ad1b..028a565250476 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -470,7 +470,7 @@ static int simplefb_attach_genpds(struct simplefb_par *par,
 		if (err == -ENOENT)
 			return 0;
 
-		dev_info(dev, "failed to parse power-domains: %d\n", err);
+		dev_err(dev, "failed to parse power-domains: %d\n", err);
 		return err;
 	}
 
-- 
2.43.0


