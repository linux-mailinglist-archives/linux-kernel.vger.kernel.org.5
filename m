Return-Path: <linux-kernel+bounces-145148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC2D8A5023
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC091C22676
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45A412E1D3;
	Mon, 15 Apr 2024 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBqq7VHa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F408D12DD9B;
	Mon, 15 Apr 2024 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185438; cv=none; b=dba4dxENCPrs+FwNkBvmVEL4Yp9YAujvlQnp2xD9R5qCQyCVrH4JxgoFUeIh/F5uQuqcfbv7phHaZpPk0YHOKbxYoaGYxkZRG/37kwYtdyuSg4I9N3OKVtpuYoCm5enm3YqKBpImlRRlHzI2w7ZcQdU8nKyAGyOMwQxvFFoSiz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185438; c=relaxed/simple;
	bh=UjhrPhhIxTdzHcb2S0fePs6c139Ez5ih5td+TTQ3hN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bY883dzS4ZOh3wG1ZowhoOZu+Ob6AapUs9094m88s0lFTpgSF3YX8dPPrYCk98p7diJEHJjZBASyZGEuIhn+pFQ1pufPqBiqHFp/7q8FPxUX/q8c3brmX7jEadBnomNK834TKg2AvGzSLW5iEfyxrfd/uqY1/jfwtt9WvW9K+VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBqq7VHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE11C2BD11;
	Mon, 15 Apr 2024 12:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185437;
	bh=UjhrPhhIxTdzHcb2S0fePs6c139Ez5ih5td+TTQ3hN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YBqq7VHaFLcPXMrQhGuwY/pJ4rH3RxKwjY+JknDOzWHU8NwPFSVzS7/oc5gtmKwzc
	 uZ6xyy03q5PePsIihsQrxVWxez8isdfNUg0EYeXiFh9xsDkCeVaw5PU+A1SvEoN1po
	 4bJQy1atC7FUYRkcsw+LW5EdcnVheWEAhLGATZHconl9LooUGPS7HngyHvsIAHR1mc
	 Fx0dc2Y8ZR/Fp3CetCNOHuu7hdxbfaBBWgbZTpfcSkAHhB2lZeQAZDY77TNVm2bEv9
	 eQAI0MmoFClJTeWyK0OV6ah+ZlBg3StfIDl2b5KdmwbgSs8WdG77MrchhVo+3EmzqP
	 Oh3sV/d2Ucj+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linus.walleij@linaro.org,
	cassel@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 5/6] ata: sata_gemini: Check clk_enable() result
Date: Mon, 15 Apr 2024 06:04:26 -0400
Message-ID: <20240415100433.3127434-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100433.3127434-1-sashal@kernel.org>
References: <20240415100433.3127434-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.86
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
index c96fcf9ee3c07..01f050b1bc93b 100644
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


