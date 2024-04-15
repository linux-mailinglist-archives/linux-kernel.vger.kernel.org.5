Return-Path: <linux-kernel+bounces-145166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04F38A5051
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 627F2B22226
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28D5135A63;
	Mon, 15 Apr 2024 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqMqGd5s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFAC1350C0;
	Mon, 15 Apr 2024 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185470; cv=none; b=IrtC7DA6xnU4LQv3Rpz5U+MasUVRIwpsYwzVJkOb9xVC/cIYI9vcjJpvCp28KkiwoWaExgWFusYipQb7nYJ241hwYpeMcCuBGFlHaXl+YL7HzDqQywtjNQX8O7OGLRkgODj+fQVA5zlWCn3qQYo19vQXGQxMl0Rw+RtrFEjpn1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185470; c=relaxed/simple;
	bh=VUx+Ryq0/DaY8+8lA1oR+IfXPSFo+QmIcDIfSmWWue0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhD25jl1hqi4zafj+MQS93HpXCJkg5DtXa39Wd1G6wHqPdHYpLEx4Wg4npi61BFtH5nVXPCXyDwnUa13EkdJbSLL8FbSRMacgRnn7eFmsjmjJNKPN2VNzM5A/r41stzY9rUadlnV8KudKOzsRluxka7TuT6MI6HsOhO7UuUB+A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqMqGd5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E805C32783;
	Mon, 15 Apr 2024 12:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185469;
	bh=VUx+Ryq0/DaY8+8lA1oR+IfXPSFo+QmIcDIfSmWWue0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kqMqGd5sfjqHyEp/w8uwdpJ/upZiDHgEX6Wc8BRrDy0uoI7uoc6cpYNYdV/xF3iDr
	 /FQbX75DNsC4/HAHQQXPIDPY0oQm/8qRuhaWzhRkm9Yrd8Y/XiS/8IqIdJzFs/4m8h
	 ctaP9ICeoVsVugUImCBwOKievrp9/BvDYp+HHm+1DVpVFSAjr1imMKnh+iFOxSpFF6
	 ga9bYAZIlSmbRbdT+uUxM06wR/DIWDvx0I9OFK2Pqasjji7+RN0gWenSaHmT11Q3mC
	 Gh6hiT0QzNU+ydB47R4JtHX2vyxAgaj4Npn3VgtaxwxLZF5TP1BSBp6ZujVd3QfmXF
	 O+fc6qQ70eT0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linus.walleij@linaro.org,
	cassel@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/4] ata: sata_gemini: Check clk_enable() result
Date: Mon, 15 Apr 2024 06:05:06 -0400
Message-ID: <20240415100510.3127774-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100510.3127774-1-sashal@kernel.org>
References: <20240415100510.3127774-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.274
Content-Transfer-Encoding: 8bit

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit e85006ae7430aef780cc4f0849692e266a102ec0 ]

The call to clk_enable() in gemini_sata_start_bridge() can fail.
Add a check to detect such failure.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/sata_gemini.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index 6fd54e968d10a..1564472fd5d50 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -201,7 +201,10 @@ int gemini_sata_start_bridge(struct sata_gemini *sg, unsigned int bridge)
 		pclk = sg->sata0_pclk;
 	else
 		pclk = sg->sata1_pclk;
-	clk_enable(pclk);
+	ret = clk_enable(pclk);
+	if (ret)
+		return ret;
+
 	msleep(10);
 
 	/* Do not keep clocking a bridge that is not online */
-- 
2.43.0


