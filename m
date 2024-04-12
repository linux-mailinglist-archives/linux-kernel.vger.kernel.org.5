Return-Path: <linux-kernel+bounces-142306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866128A2A01
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A2BB261E7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C4412FF84;
	Fri, 12 Apr 2024 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="MEjKgYAK"
Received: from smtpdh20-2.aruba.it (smtpdh20-2.aruba.it [62.149.155.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E560212C53B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911481; cv=none; b=kumvcQojZbcfheEyZnFNTe1scWx9o9OuMD92UJo2d4gosrY1KVyERWMF0jo2dXoSR5//+x5PCZLrdjE4KHriqC5pqVVrDFhM7hT2t5l0nOP2MPpubQdTThr1V8qD/+tv5/1l9kIQfSf+i0+9iW6vkh/q0/6myYzZbFEViL3CRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911481; c=relaxed/simple;
	bh=Mgr+tcoexBfovBQOO3B95Y4QR6G4XpjRCQIUweFdVIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OO2noShfLYBWeACEtLHLYGL99TbbgrxNe3g03/FFJUXzEDrkrJ1kf0tbH20oNPWi0/70Q+/YFJniy+ZIZCXzkcDvSK7jPyXN++S+PZiCg95kUCqrJRW0mCwcLdlSPIvog/H+IWiofPQqtF59sZdtkrQXXGHuzCt3EEKkBT318nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=MEjKgYAK; arc=none smtp.client-ip=62.149.155.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([77.32.11.127])
	by Aruba Outgoing Smtp  with ESMTPSA
	id vCWKrIsVvwWj2vCWKr0hwx; Fri, 12 Apr 2024 10:44:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1712911469; bh=Mgr+tcoexBfovBQOO3B95Y4QR6G4XpjRCQIUweFdVIw=;
	h=From:To:Subject:Date:MIME-Version;
	b=MEjKgYAKmFjQSqeBr5ShLbaxTGn/9E3P0BZfYddiE+TAqX7fm2aoKracx/SMP6X+A
	 Xw5qha3tFB6SDHqqfwXcj1Zc+Tko8erc/7h/bHE5tca8EThwhj/684jHAtm4yxXSuU
	 xVYs8hExqB2y602jpbVh/fY0iJE5DgX6OZOhYRCcr7x7XgTLsYM7opjLu/WDO8mTSW
	 KDJMUQj7WkR1Tg5qrdryZEPAsp08U2Vtn/y1b61a4h6Ay7P6Dd8DDgevt5w/uwtteh
	 NWVNJmraoahaMMV9SoalbZyd783peqn7PTqwBMgGH2+IHnJqOMYYPNoyCMOWJC4qQC
	 Bs/cqw/r30Mtw==
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] regulator: pca9450: make warm reset on PMIC_RST_B assertion
Date: Fri, 12 Apr 2024 10:44:26 +0200
Message-Id: <20240412084428.400607-1-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfK4oHPsPdScFzaYXVXev1tdi4Txm6ETsUGH2jspVbqAutHrXEIWcUrjnGZ9ffT8sz70SQGyAJhqLj1JpS2icoNVbYd+jE0GQMAhMTewqK0tdlAFaWc4P
 aSAA1Ufl4kz6ZP4xFnS7Sy7NYRMytfGLu7CgxhKkJNTXPeOQ1L0EsyRwe5NjwTacHBOCQa7kuFSIEDkhiXf0VSzQG0/m6+vmia/X5w/kSRlJzKobvwyWX2Jv
 QhY99dSEFUylkncXTyoN0iRqH5Yese7timUEFhx4b+yp37PcBLdPC+lCN7qdaVMKK/y6A79Tf8un+EC7i8J1MdAvNhptJEOx7R2qs8DJw/VH98Oqjw7XvNhl
 kTTnYH57MbS2wZhJ8f1pSU5+z9UmBw==

Hello all,

the following two patches add a property in devicetree
to mark a board which needs warm reset on PMIC_RST_B pin
assertion.

kr

---
v3 ---> v4:
	- improve "dt-bindings" patch commit log
	- drop yibin.gong@nxp.com email for failure report

v2 ---> v3:
	- split patch in two: bindings patch comes first
	- add missing mailing lists and maintainers
	- remove underscore in property name

v1 ---> v2:
	- Fix email addresses

Fabio Aiuto (2):
  regulator: dt-bindings: pca9450: add PMIC_RST_B warm reset property
  regulator: pca9450: make warm reset on PMIC_RST_B assertion

 .../bindings/regulator/nxp,pca9450-regulator.yaml     |  6 ++++++
 drivers/regulator/pca9450-regulator.c                 | 11 ++++++++---
 include/linux/regulator/pca9450.h                     |  6 ++++++
 3 files changed, 20 insertions(+), 3 deletions(-)

-- 
2.34.1


