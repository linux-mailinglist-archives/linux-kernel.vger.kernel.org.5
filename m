Return-Path: <linux-kernel+bounces-141365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296128A1D51
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36DB1F21972
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E654F897;
	Thu, 11 Apr 2024 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="OgwAeWSB"
Received: from smtpdh18-1.aruba.it (smtpdh18-1.aruba.it [62.149.155.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DF94F605
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854874; cv=none; b=l1kYOET0ueDngK4Wvm/7Xg1WFm33woJzKfWslm0cMpFZFGwoCIkv225Z3ioOZTAiNZBIEtRD1MiunCacHm3TA1Se7w4sCxATIBHweQm7U6d/TjtIp2R3Bk+GdCA56uQ4LnypKxR0mv6EpbkvxIegYceNPzGtsJWVUdgL+rM0ciI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854874; c=relaxed/simple;
	bh=Hr8kCrNCfpdzIOQGV4xnnmTsIZA8QPh4fh5vhToJ2Ug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MVUMXjjpJyskhv5kC0niNjFE0bKmS3xu9aXMUCwN2MaueyyszTxVRLeVH1sP9m4IphD2jXOl48g2M+UEemsjaqf9ZSG3KGiIqv7fsfLzNSyJhRT8WIHL2nejA98geSpAMUuIHIFqKeaLg2LOjoyiqaS6LjxF7g0flmCm5ApTvUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=OgwAeWSB; arc=none smtp.client-ip=62.149.155.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([77.32.15.153])
	by Aruba Outgoing Smtp  with ESMTPSA
	id uxkPr7ow7wcFeuxkPrcye5; Thu, 11 Apr 2024 18:58:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1712854682; bh=Hr8kCrNCfpdzIOQGV4xnnmTsIZA8QPh4fh5vhToJ2Ug=;
	h=From:To:Subject:Date:MIME-Version;
	b=OgwAeWSBnp3BmYZccHzgTkr2u5pTRb6y0DzxgNxtrstWNrtcQUGV9hRzr4vc/Y5DB
	 7oAhtwg3W8DGjd1aKoovYxSjuKTLNKZqonjWFdTdmLGfpuIvyER/xKU4GkOREZ2r2O
	 An3ndQvyEMSDBgSZ2Cbd5VL9AxnUkf03JMIq2PUqtUgoydkoV/6tarnXs10SKFyGhU
	 OzakIDSbLkmQrlvxXkyD53XSNIdUKjCOJlHHsrWjOoHv8Ql0RIHX6enA22Zwp3HcSA
	 tV4l8AGoQEv4mc89whpRkwyxdk1VYiRbnNtcq8ctbwklJ7Ss1l/4h8kfKHAbGDs7Yp
	 kgBzceRUlqwyw==
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Robin Gong <yibin.gong@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] regulator: pca9450: make warm reset on PMIC_RST_B assertion
Date: Thu, 11 Apr 2024 18:57:59 +0200
Message-Id: <20240411165801.143160-1-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJYRY/5Ve08dc1q/JaUZVbtbk14aNWluJ7DfA7lGePbtos/ErNjMJzXXPKUbX/pIHdlzqbCgyaHmVkWKnqfO//WkXh9vAdXvAySzk82jYhykv1eSISF4
 9qn8lRVbuQFqiA7kfJrNNsjVx6j/maTpAGjuN+eBKtGrIR9odAQdgC9qDCsxQ1OVDLQwROM/scQWq1UfGF8tuugFJqWc5Ovn2VpKCQLrt/aWATMbokq1oh+8
 bUXK9LUoBqG7cboiEJHQSjihzAKvcfZAzxsejKn/vXAMMFSgDl5jqKALkcYctcPR+q0fIbq8ppHTMqsAeYm69nNlfLpPfWKZNZixJmlkzZq2bkCApMUjH2ax
 /3cverUreuw+DZA7K4WTlqaqxmgs63m2vlAsgUNh2Vx9ut5E6N3SgyUwBKg2pf/JBsuWobE7

Hello all,

the following two patches add a property in devicetree
to enable warm reset on PMIC_RST_B pin assertion.

kr

---
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


