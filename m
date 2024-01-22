Return-Path: <linux-kernel+bounces-33540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E0A836AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E45284A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F5214A4FF;
	Mon, 22 Jan 2024 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p512BaoR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3113A14A4EA;
	Mon, 22 Jan 2024 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936660; cv=none; b=HdRqNSftBvgHkcYd3yj6CLo3A3oGx9f/LuWVFYofQgwJFFihie9bqF/ctvj/cdQ/98lyXDG56f9cpfcEl8u6Kji49zbHQZr+choAFoXkbRR8PKEZbD+E6TCk8XyZ3ODAgFj8ihmins7cJ8rxDEgrCYR8gd0P4ie9Udfr7+yJZ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936660; c=relaxed/simple;
	bh=FWNWh8dLcOM4LpimapOwOnyzLuG2MZo3Uy6g263H8G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRgCVHqOJDYnHUvIu9/plldP6HtIITsf0V/aclefqgi3/D+/qeHFZ8ubSrzjj8fsK+vlvOtD5pjkhjCvJ9/ss56XyM1Yb5whYcsgJ4sBjUWbIrWwabkQEObSwzyZ8MPzdeqzD4ihDreX0QQB8y+zrFdplGqS2K2S69d8kAblOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p512BaoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382A0C433F1;
	Mon, 22 Jan 2024 15:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936660;
	bh=FWNWh8dLcOM4LpimapOwOnyzLuG2MZo3Uy6g263H8G0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p512BaoRlkfOxdvv1JyfOKASjAr5Ns4iJ5CgGZHBVZ/N/7El7284Ti0Ff2eZCvxfv
	 Ww90mza9b/m2heBwhGbW27a3DhhwVCQtg65pVd2yzPDQlkNsgKjVTnGIziCfMoGKDd
	 QmDHYp+xMlMzhghFP1AAxpGMtfPvz2G8pU1AGi3XHAz72LBOax3Y0LWGlc8FXu6nCf
	 oxoM6vNZrxjV3Hte3ZKZFanPEKZkn1+G6XbBFob1qOi3mpmhokLN2hb/O08GpAbUnM
	 vwKZ0WQC0zVctEnD1YsS1o8DME7k60zYXpOAfbvnZMx2zY5WkA8CxDiDMyfukfHi3F
	 DOZKHcqDLZ59A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>,
	mchehab@kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 17/24] media: ddbridge: fix an error code problem in ddb_probe
Date: Mon, 22 Jan 2024 10:16:31 -0500
Message-ID: <20240122151659.997085-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151659.997085-1-sashal@kernel.org>
References: <20240122151659.997085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Su Hui <suhui@nfschina.com>

[ Upstream commit 09b4195021be69af1e1936cca995712a6d0f2562 ]

Error code is assigned to 'stat', return 'stat' rather than '-1'.

Signed-off-by: Su Hui <suhui@nfschina.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/ddbridge/ddbridge-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/ddbridge/ddbridge-main.c b/drivers/media/pci/ddbridge/ddbridge-main.c
index 03dc9924fa2c..bb7fb6402d6e 100644
--- a/drivers/media/pci/ddbridge/ddbridge-main.c
+++ b/drivers/media/pci/ddbridge/ddbridge-main.c
@@ -247,7 +247,7 @@ static int ddb_probe(struct pci_dev *pdev,
 	ddb_unmap(dev);
 	pci_set_drvdata(pdev, NULL);
 	pci_disable_device(pdev);
-	return -1;
+	return stat;
 }
 
 /****************************************************************************/
-- 
2.43.0


