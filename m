Return-Path: <linux-kernel+bounces-162471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFC48B5BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD531F21102
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADBC81AA5;
	Mon, 29 Apr 2024 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="FVCfwT2p"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B543A7EEF2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401939; cv=none; b=ThKzgorVI5hgSDcY24CgY+XtNuGkhCX59kbihEM6aQL57lRxGysDB0Qs0Df8ub24C84mEpMWxzhD/9TeZw+tvYw7tWcklCPkhpGCNbA4Mbt8gUZKwwcoMhEN3bPzydiFtYJcY2gLe6S5tWEwRPqZSnWFdvuHTyTV4kT0iWVTB/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401939; c=relaxed/simple;
	bh=oAPaEdKRQbl/ibo90AYRSlwVYUinifQpfpKWtnOvN/A=;
	h=Date:Message-Id:In-Reply-To:References:Subject:MIME-Version:
	 Content-Type:From:To:Cc; b=AQu5p4RnIQ7DMjCMjIk5jTexyU9Bg44HKvj2svPPTVqmwij0usTHXe8umITztDvxObFyZrLC06LbbpYJ3ZivQ+XfiM8J6SaJ9Nq7HoJ3WH3wCGrxk1pruMOAvEtkUCSCwN8EZzNUb6YcO3LEgTcG/SYo7dmQS4h+s35W3vwTpR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=FVCfwT2p; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1714401931; bh=oAPaEdKRQbl/ibo90AYRSlwVYUinifQpfpKWtnOvN/A=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
	b=FVCfwT2pcWQbEzQZAKCwef4vL5Hp2sOFYIYwrvf+EHnhMljwfuPLC1XYCTS62fuiP
	 iKmtyjgu0FrWUjNyIDqgb2HWVAt7HhIUGS5xZj5oxK7aPqSLy7pGhd3ZgEYIn0RLrb
	 XG18UynlNtHlgxalBGlyamLWJpUiAucmgsHEpwKFNSGImkvCVMV3IWxnYnE6LkaWQG
	 2c/BlHV82yisJyfFmeteeajWxyN6Me94IT+bikBXLPKSM9EOqmInCgr81A7Xz6MRQ2
	 z27g70IlD5QEyrCs+AzugC1GyCtrCxPCqAkJCek9As/WwELskw8YbB2bNtDmzESQBf
	 QbweTCQCQJAxw==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4VSmMv4mg6zbr;
	Mon, 29 Apr 2024 16:45:31 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.5 at mail
Date: Mon, 29 Apr 2024 16:45:31 +0200
Message-Id: <cb786b54b2a5554693022939b9e34851a7c590f9.1714399603.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
References: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 09/12] regulator/tps68470: use rdev_get_drvdata()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc:	linux-kernel@vger.kernel.org

Replace uses of rdev->reg_data with the official wrapper.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/tps68470-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/tps68470-regulator.c b/drivers/regulator/tps68470-regulator.c
index de7db7690f6b..326a3b942488 100644
--- a/drivers/regulator/tps68470-regulator.c
+++ b/drivers/regulator/tps68470-regulator.c
@@ -56,7 +56,7 @@ static const struct linear_range tps68470_core_ranges[] = {
 
 static int tps68470_regulator_enable(struct regulator_dev *rdev)
 {
-	struct tps68470_regulator_data *data = rdev->reg_data;
+	struct tps68470_regulator_data *data = rdev_get_drvdata(rdev);
 	int ret;
 
 	/* The Core buck regulator needs the PMIC's PLL to be enabled */
@@ -73,7 +73,7 @@ static int tps68470_regulator_enable(struct regulator_dev *rdev)
 
 static int tps68470_regulator_disable(struct regulator_dev *rdev)
 {
-	struct tps68470_regulator_data *data = rdev->reg_data;
+	struct tps68470_regulator_data *data = rdev_get_drvdata(rdev);
 
 	if (rdev->desc->id == TPS68470_CORE)
 		clk_disable_unprepare(data->clk);
-- 
2.39.2


