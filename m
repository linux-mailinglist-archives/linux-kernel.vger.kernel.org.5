Return-Path: <linux-kernel+bounces-78354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0845C861252
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFBF28224A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECBA7F465;
	Fri, 23 Feb 2024 13:11:45 +0000 (UTC)
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1271A7EEF0
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693905; cv=none; b=Kr0FCqyVINdF2qpwwfwyDmVvYyPB7/uPoFgvRnTfnq5H5Bu3vlQz39msnx80Oq8TbAzveB+4s65SM27Nhh4KehlS1dLP0jfYx03YckXrcM7Who/9AGgjWPMxfeudqQUXR7N1vfa44f57Ea/1wEJDmDUQQvRKqyCw0MgiCBaoIu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693905; c=relaxed/simple;
	bh=lH5FyfKw2kMUVgT8bT5UHBrJrgC3A6gelAiKsdPdCZQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hWxNXwnLJF/cIVjU7tMv3HX1xVf4TGoGfzueuEuuGlKyzL6uD0iqokLrCp14L1luFIft1CcZPp3a6Gvbc768IkCdsWhMFooSlbLXsvTbzmYLkwdXvDM4IRdQSLN6sVHGtR32y8RQZO/aN2nUW7KTynA+Q7Gr4MH1ABQhtsZGAfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Th9Pz1pWwzMtHT5;
	Fri, 23 Feb 2024 14:11:35 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Th9Py5XBnzXs3;
	Fri, 23 Feb 2024 14:11:34 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH 0/2] regulator: rk808: fix regulator ranges on RK806
Date: Fri, 23 Feb 2024 14:11:21 +0100
Message-Id: <20240223-rk806-regulator-ranges-v1-0-3904ab70d250@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHmZ2GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyNj3aJsCwMz3aLU9NKcxJL8It0ikKJi3ZQ0U8tkM5OU5BSzFCWg5oK
 i1LTMCrDB0bG1tQA5j53eaAAAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 shengfei Xu <xsf@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+kernel@0leil.net>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha

The regulator ranges aren't really matching what they should be for the
buck and ldo regulators on RK806. They are not wrong per-se but they are
a bit misleading.

The only change in behavior expected is that the buck regulators
shouldn't be able to say that 3.65V is possible.

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
Quentin Schulz (2):
      regulator: rk808: fix buck range on RK806
      regulator: rk808: fix LDO range on RK806

 drivers/regulator/rk808-regulator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
---
base-commit: ffd2cb6b718e189e7e2d5d0c19c25611f92e061a
change-id: 20240223-rk806-regulator-ranges-df59c64dcd6d

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>


