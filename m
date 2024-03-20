Return-Path: <linux-kernel+bounces-108654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FBE880E10
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0471F2144C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E2239AC1;
	Wed, 20 Mar 2024 08:57:55 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171A033CC4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925075; cv=none; b=CpP3N+YYn98riHL6YKuwCdL9Ox8Mvdi1Qgt+VX0UKmCdlVu93HRVfvkomkf80doddObRoRFSqAFjsWDoOfPyURjhxpg9MRbsepgB3MT+Y89zGoKjQ4oxCLfruoU4ndUW87ozCnksfekf5Vt4G7gMr4mupGCmWa0/3ztLcf4lTLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925075; c=relaxed/simple;
	bh=G33CroK7BnYY/9nq8D2Vt+ZqpECFj3JOwYrCg2AerkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OBgskA1Wy4P20DctCW8yUkdv11vniJwQktJfp3l4HwLHg4v+oqxcqzb1cFuH8p9D1eLwfjptvNl/PzVcfVMJi2jZPr7WOcnYajaYEfbxEjLagkIGNmFGfyoQvSKtNXGEzVTnQaTAKvPgLlrLa5Piql75Qp+MMv1ImD2JpMi9Tvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id RDA00141;
        Wed, 20 Mar 2024 16:57:41 +0800
Received: from localhost.localdomain (10.94.17.92) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.35; Wed, 20 Mar 2024 16:57:42 +0800
From: Bo Liu <liubo03@inspur.com>
To: <support.opensource@diasemi.com>, <lgirdwood@gmail.com>,
	<broonie@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <jagan@amarulasolutions.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH v1 00/13] regulator: convert to use maple tree register cache
Date: Wed, 20 Mar 2024 04:57:27 -0400
Message-ID: <20240320085740.4604-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 20243201657418796298d1f8af4ba8d88157147d862f2
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Bo Liu (13):
  regulator: da9121: convert to use maple tree register cache
  regulator: da9211: convert to use maple tree register cache
  regulator: isl9305: convert to use maple tree register cache
  regulator: max8973: convert to use maple tree register cache
  regulator: mt6311: convert to use maple tree register cache
  regulator: pca9450: convert to use maple tree register cache
  regulator: pf8x00: convert to use maple tree register cache
  regulator: pfuze100: convert to use maple tree register cache
  regulator: rtmv20: convert to use maple tree register cache
  regulator: rtq6752: convert to use maple tree register cache
  regulator: tps51632: convert to use maple tree register cache
  regulator: tps62360: convert to use maple tree register cache
  regulator: rpi-panel-attiny: convert to use maple tree register cache

 drivers/regulator/da9121-regulator.c           | 4 ++--
 drivers/regulator/da9211-regulator.c           | 2 +-
 drivers/regulator/isl9305.c                    | 2 +-
 drivers/regulator/max8973-regulator.c          | 2 +-
 drivers/regulator/mt6311-regulator.c           | 2 +-
 drivers/regulator/pca9450-regulator.c          | 2 +-
 drivers/regulator/pf8x00-regulator.c           | 2 +-
 drivers/regulator/pfuze100-regulator.c         | 2 +-
 drivers/regulator/rpi-panel-attiny-regulator.c | 2 +-
 drivers/regulator/rtmv20-regulator.c           | 2 +-
 drivers/regulator/rtq6752-regulator.c          | 2 +-
 drivers/regulator/tps51632-regulator.c         | 2 +-
 drivers/regulator/tps62360-regulator.c         | 2 +-
 13 files changed, 14 insertions(+), 14 deletions(-)

-- 
2.18.2


