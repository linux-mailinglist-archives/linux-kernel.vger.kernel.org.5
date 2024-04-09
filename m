Return-Path: <linux-kernel+bounces-136315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4611489D292
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776B61C21A2A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823CD7BAE4;
	Tue,  9 Apr 2024 06:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Lxe0W+ue"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A5C74435;
	Tue,  9 Apr 2024 06:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712644898; cv=none; b=MJ2AJ6nXjNhNhLybmzq9OdYz+GPVlACpwG6X2PG+8LoTdx6ZQkT8dZAhD2bCdw1sWUc93FEG78QqongPT0NC5E12T1QeKZ3FAj7z8QZNMcKhI5dAXDPy3ZFv6NMFf9wridk9cVIGyucctZ3kzFh1Ajbajwo37p3oUQRT1bZ0n80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712644898; c=relaxed/simple;
	bh=Ypa096u1rxKyRP+T+Cgia169tt3nEpsKn06F40LBBzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oZutkxGTq0Ta0rELRRQvoftejTMMBBW2MJTV7To69VR+/T/lZ/DI9oPPOa2Xn5YmSygQY/cyQjUvV/VPyDqqUlIOdr8105YdixDCLIkOGraP/5V/S592uo5Y9Q2obqS6BJOUXsRKnxnJaY8Ln7ki6ACctcHzW59h9Q4Fgtv1WJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Lxe0W+ue; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D81EE20008;
	Tue,  9 Apr 2024 06:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712644894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Krd0BAesKO2iMVNygzUAooa8aMl2YxIa+szFLm86h3M=;
	b=Lxe0W+ueNHMvhA4jruFrl5RfQzBTaAwiNuT2BRmIhCvleayAKis6628tUeRLpLuLs3r7Rx
	ZlMwOSDISL8uK9+eochy5Ix8u78E+Q6SYOzhaGpT6SQ3Wmpmdifyf/9r4Vkmi+SVECGX0M
	lhTVStGd4M9m2T+v+6zziB6kRayBkJa419CfYNXVKcdtSTasmAzVR/qwcw1tXRje+xmDVO
	OskZtnTc+AEaLPCTUej8AbTQOR6BJHiKhAvEo0NjcoIMsqeRdUEieqCp6GqFj551UTORz3
	QGLEJJcoc5nXrlkFDb3FznjhmWttxwaVsx3HGg5YEA9RstzZJm/HDgCpAXePlw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v4] mtd: rawnand: qcom: Fix broken OP_RESET_DEVICE command in qcom_misc_cmd_type_exec()
Date: Tue,  9 Apr 2024 08:41:33 +0200
Message-Id: <20240409064133.91927-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240404083157.940-1-ansuelsmth@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'b61bb5bc2c1cd00bb53db42f705735db6e8700f0'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 2024-04-04 at 08:31:55 UTC, Christian Marangi wrote:
> While migrating to exec_ops in commit a82990c8a409 ("mtd: rawnand: qcom:
> Add read/read_start ops in exec_op path"), OP_RESET_DEVICE command handling
> got broken unintentionally. Right now for the OP_RESET_DEVICE command,
> qcom_misc_cmd_type_exec() will simply return 0 without handling it. Even,
> if that gets fixed, an unnecessary FLASH_STATUS read descriptor command is
> being added in the middle and that seems to be causing the command to fail
> on IPQ806x devices.
> 
> So let's fix the above two issues to make OP_RESET_DEVICE command working
> again.
> 
> Fixes: a82990c8a409 ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path")
> Cc: stable@vger.kernel.org
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel

