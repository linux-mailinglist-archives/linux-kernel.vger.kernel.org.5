Return-Path: <linux-kernel+bounces-60470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 381D485055A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD58D1F230E6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A189C5CDC5;
	Sat, 10 Feb 2024 16:40:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BDD5C8EB
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707583253; cv=none; b=e6p7FrA2ES9kUyuXYX5+Fr0LuBctgaesn72tutLR6gYU1Afi8hPKB7JQyNpOcfX9kh8sfPUhlKK9sUmcWB73uw831ZnHdhuvOWxxwuvmBezfHB2rzAmgFgW8U3aBWv00gdSPwVgfZ3NhW9SUDnFf0LRS+OOcNAB737H8ug7q/hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707583253; c=relaxed/simple;
	bh=xcmeiAzBnhC61gQ9jGq+45s+p7AxPUPBuJY3eDVFwFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h5rEocYeYNPJfmAFmzPB0lcCsERZX5MkOYnwhIC/e9WaYxK2rzVCuuvHr8fRiFmTLKXEYQvNoyxxd1a3U1/x7NLXWi3GN9nBxLYdaabxNfpWLnOM/ye5gXqrICXKSuGRI/e7GGMAsnpvid7i76QR7UXPL4G86zj2pkM9JwwsM8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYqOs-0001I8-Pj; Sat, 10 Feb 2024 17:40:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYqOq-005i44-F3; Sat, 10 Feb 2024 17:40:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYqOq-002ER3-1D;
	Sat, 10 Feb 2024 17:40:20 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Rob Herring <robh@kernel.org>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] spi: ppc4xx: Various fixes
Date: Sat, 10 Feb 2024 17:40:05 +0100
Message-ID: <20240210164006.208149-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=xcmeiAzBnhC61gQ9jGq+45s+p7AxPUPBuJY3eDVFwFc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlx6bmi3LTWkZCTyS63Wb6ZUUI7B+OBXMjM6Fui I63fSeUVh+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcem5gAKCRCPgPtYfRL+ Tn4YCAC6CLnhQhuuE3Hiwmf75xTPg5jcmlwWnTysgOaTZ5RpqiFwwZX/Te84T7LG2+X2QonRgu5 yHQvKn+jXc815n508FlIFAEzdV3so9WrseABxUoj2oEQXtIbVm4xrbiLpJyJaLhwvDegaaehi+5 n/+Q6LWShdZVvtwmj9TXoc0yAez/BtJAh1dkel56QzS3+PPq+bZKsn32LI0ZJU68k6K0SMfmAcP LXAzMmyhpAFtC2v7AcnQ/FM/Lq+ySH6DHSOEK+4znDsMAvYY10oKFsfDb0vloqOuoU6NK0b6Gn5 IpacftPzvc7S1r7Y5LIrh5p930Y3SOny1VKxgIVS8RWyiGtt
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

this series fixes three problems of the spi-ppc4xx driver. One of them
was introduced by myself, the other two are already older. I guess they
were unhandled before because the driver isn't enabled in any
allmodconfig build.

Now that I have this series, I found the first patch to be a duplicate
of
https://lore.kernel.org/linux-spi/3eb3f9c4407ba99d1cd275662081e46b9e839173.1707490664.git.chunkeey@gmail.com/
 Mark claimed to have applied this patch to his for-next branch, but
it's not included there yet. So I kept my version of it to please the
build bots. (Also my patch has a Fixes: line, which Christian's doesn't.
Up to Mark what to do with that.)

Best regards
Uwe

Uwe Kleine-König (3):
  spi: ppc4xx: Fix fallout from include cleanup
  spi: ppc4xx: Fix fallout from rename in struct spi_bitbang
  spi: ppc4xx: Drop write-only variable

 drivers/spi/spi-ppc4xx.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

base-commit: 65b3e71d024d553764e67e5916a41675afd0d142
-- 
2.43.0


