Return-Path: <linux-kernel+bounces-114432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8096B888FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB971C282D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E538817823C;
	Sun, 24 Mar 2024 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJNjvzxt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E1D21C997;
	Sun, 24 Mar 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321845; cv=none; b=CNWH/vCtbxDZz0/u1hZoVYGd1dWj4cxYY71P2+KU6sVTfnVy3gFJxdeNUd1eUEa5SmRmF/xsT2uI9oBLg2jzKMisFecj6RACcoq2eGFv7NkMsGokPZQQ2GU3swwpsz1JeT2YRN4NBok3GfclWAY6hTadVud+HgrCNyKWrWuB2aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321845; c=relaxed/simple;
	bh=UC4iSRp+k3B2QXRMpvz/N5o6qCS5pztBlHZU2CKkeCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2G/Fx6VP8pF5zxeIOTE63TEYOcFi/A1e+kKCSGAMQVIZmtkQJ1tNoy5ybO16JDSBioNAVpG2FwJfzASvQ0aOe/Oy40x9N5ChJIjlspIWVASrcleyOZtgPiI3vPUZkIEgWiMMPDegTo9nptQwY6ycZeyHYpkBkzlfL2UAgCpIVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJNjvzxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F679C43394;
	Sun, 24 Mar 2024 23:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321844;
	bh=UC4iSRp+k3B2QXRMpvz/N5o6qCS5pztBlHZU2CKkeCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJNjvzxt7Y9zH7z4QC3Vo2DXARFG72TjdtiM14EVdeq2rFhqP4q6v6P+HnG3knzAs
	 sVmVYxBVZhW7yuF1wYXdKYLSTv8BM+dLa64/6c3FIgSavKNMrTUdesVHH3HB1MX4OQ
	 XKIA/ls+ugwe8LGMn2ycRYqOw/+KFND0mLnjBajqPLr0EwDEzzAJfnexhfCnyuHq7x
	 v0ANtqUy8B6jz6za70dAbx2/omxclj8s4/tr3qr8OQZevLzxY7zob6PenfXVhNxRa2
	 2G60Tec4D/9J0ulyNxdld6wsPVt0/+qQYRfLNbO/UkADfg1mg8Fi6hQwh9lNHTEe1m
	 /0bZIApE5vw7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 572/638] usb: gadget: net2272: Use irqflags in the call to net2272_probe_fin
Date: Sun, 24 Mar 2024 19:00:09 -0400
Message-ID: <20240324230116.1348576-573-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@gmail.com>

[ Upstream commit 600556809f04eb3bbccd05218215dcd7b285a9a9 ]

Currently the variable irqflags is being set but is not being used,
it appears it should be used in the call to net2272_probe_fin
rather than IRQF_TRIGGER_LOW being used. Kudos to Uwe Kleine-König
for suggesting the fix.

Cleans up clang scan build warning:
drivers/usb/gadget/udc/net2272.c:2610:15: warning: variable 'irqflags'
set but not used [-Wunused-but-set-variable]

Fixes: ceb80363b2ec ("USB: net2272: driver for PLX NET2272 USB device controller")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20240307181734.2034407-1-colin.i.king@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/net2272.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index 12e76bb62c209..19bbc38f3d35d 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -2650,7 +2650,7 @@ net2272_plat_probe(struct platform_device *pdev)
 		goto err_req;
 	}
 
-	ret = net2272_probe_fin(dev, IRQF_TRIGGER_LOW);
+	ret = net2272_probe_fin(dev, irqflags);
 	if (ret)
 		goto err_io;
 
-- 
2.43.0


