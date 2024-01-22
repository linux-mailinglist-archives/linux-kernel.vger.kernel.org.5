Return-Path: <linux-kernel+bounces-33516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBD0836A93
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83311F22621
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6131420AE;
	Mon, 22 Jan 2024 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czvBO/nA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DE71419BB;
	Mon, 22 Jan 2024 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936575; cv=none; b=YVoxvdWRaSi6RjPidCUjvOGNmgx00VdhMEG5x4j2dOmhsYze5U/563Cvv4VIEn3cvVYY5Cr7XMCxDT2fdSJBT6UVLO3ays9UdFq2jE2mw56blpZB5lIKWtWxlL9Ad3d++3bbRGx+T+S1iek+NjQmmIbkNVoZAYvOWeoKdRurwcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936575; c=relaxed/simple;
	bh=FWNWh8dLcOM4LpimapOwOnyzLuG2MZo3Uy6g263H8G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpSVbniXUhn8rB8htO3gi2fCiYYTLisi/u+VhqjFtlXAMy62vyGFwWwmTnWqq6WEDM1pOSNHd59mmtvVdcCscCh1NzYNpgySE6JkUNKDPfREpT8YgTFJYut2aC0SArBGGA6M4EBh7BEGVakJkwvo+cdxQUeDr/mgVP8QhO5NH+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czvBO/nA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECE8C433F1;
	Mon, 22 Jan 2024 15:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936575;
	bh=FWNWh8dLcOM4LpimapOwOnyzLuG2MZo3Uy6g263H8G0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=czvBO/nAp+No5NOYM/cTMCrcY7bojLPcM8Jg/MjmCF1T8pONxx7/9QqHZ18Ep698Z
	 iDwNPNz+SDdjzhi3Gq8Vcu7WqWPH9zSrCNDZ+I/LkEXgMjQMYGeKq2MajggUeb58f9
	 BJKebt0nSJk4zdIWBFA1mvTZJgHZ9BTmMJxGcqX62mdDqurDjklxgxrbgfkQzK50wo
	 nfxKlSpU4/X/uDJFCfz6u9E1XFzUh5hlNHS6/FpX3bn6hQacbtLTJDyR3vyrDh9SSk
	 utZCR5FESrA7vN6/oO8euwADm55JO6PdPCCXJMyssutaErbJgdOqtLc2LjAUan8Pkw
	 EvAVDZkYS3lOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>,
	mchehab@kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 21/28] media: ddbridge: fix an error code problem in ddb_probe
Date: Mon, 22 Jan 2024 10:14:47 -0500
Message-ID: <20240122151521.996443-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151521.996443-1-sashal@kernel.org>
References: <20240122151521.996443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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


