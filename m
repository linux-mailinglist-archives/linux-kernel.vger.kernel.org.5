Return-Path: <linux-kernel+bounces-33351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C828C8368A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D4A286305
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ECB65BA9;
	Mon, 22 Jan 2024 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaR9gVsg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A4F6519B;
	Mon, 22 Jan 2024 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935954; cv=none; b=W95mwYH5kxApU28Ge+kq21nrRtwFwstVQCv50mx3KC5aAf/L82koogfjKNY9wLlNC991OhZKtvxplfIPGXkTW4DzIj/PiukNVOulpc0YfKfUKEVAyoOujoZ1d/NYL+XJurHjJFDsb/dy/4YdwV5k6KrsWirLl1dSiX8DiFckf30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935954; c=relaxed/simple;
	bh=XcqHZjLopTn4lg1x7pKDpFDeFGze++k5rnwJFqSOoF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ut4pEvvag9v460g5yWZc+UdoJLQdBTAUyfnGt4SAC0FaEiFCjFRKEZsg0AZxVQBLo4DBUhM34oHkND9/scT101Lg2SgIkS6A4ky4sQJqE2+pK9KCCvIGUjboxT7UL46qDAyyZiihCHHvrOczfeOkBc9uDT08aaG9H8tdLm1Apzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaR9gVsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE81C43394;
	Mon, 22 Jan 2024 15:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935954;
	bh=XcqHZjLopTn4lg1x7pKDpFDeFGze++k5rnwJFqSOoF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GaR9gVsgZmxW0aj1HPpI7QBA4dq72GDk6v3WU4Wph7AxWroSNJk3IL7P1QR1lRnGD
	 xxrj0k8CctajBkjTYMF8keM05m4gYRTW7jrG6AP4ilAyvJNDI7I6ORzal94htrY72E
	 Vxt/mGwtPznNZgWF0OHJoUNQ7GVKSJAX3BYV4DbhPlcINpYMDDsgGwwRKhU7RSRCeW
	 GQ8MxLjyVElV1Y2cnx+6RzcqjsYyKjg+hsFUm00bA2gEfQsEK+gdJ+ZjoQuHhIZYJL
	 04Ui4OepkzGGVFRQWFDhZpSMkX0yfow+8tY4PnaDQL+msPgynOkrctZOg0+byDWsEI
	 J1s9PhgT6kMsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Adam Ford <aford173@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dafna@fastmail.com,
	heiko@sntech.de,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 29/73] media: rkisp1: Drop IRQF_SHARED
Date: Mon, 22 Jan 2024 10:01:43 -0500
Message-ID: <20240122150432.992458-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
Content-Transfer-Encoding: 8bit

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 85d2a31fe4d9be1555f621ead7a520d8791e0f74 ]

In all known platforms the ISP has dedicated IRQ lines, but for some
reason the driver uses IRQF_SHARED.

Supporting IRQF_SHARED properly requires handling interrupts even when
our device is disabled, and the driver does not handle this. To avoid
adding such code, and to be sure the driver won't accidentally be used
in a platform with shared interrupts, let's drop the IRQF_SHARED flag.

Link: https://lore.kernel.org/r/20231207-rkisp-irq-fix-v3-1-358a2c871a3c@ideasonboard.com

Tested-by: Adam Ford <aford173@gmail.com>  #imx8mp-beacon
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index c41abd2833f1..4c4514e20673 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -542,7 +542,7 @@ static int rkisp1_probe(struct platform_device *pdev)
 		if (irq < 0)
 			return irq;
 
-		ret = devm_request_irq(dev, irq, info->isrs[i].isr, IRQF_SHARED,
+		ret = devm_request_irq(dev, irq, info->isrs[i].isr, 0,
 				       dev_driver_string(dev), dev);
 		if (ret) {
 			dev_err(dev, "request irq failed: %d\n", ret);
-- 
2.43.0


