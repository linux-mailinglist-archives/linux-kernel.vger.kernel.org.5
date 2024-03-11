Return-Path: <linux-kernel+bounces-99126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1582E8783B9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C65282B35
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B129447F47;
	Mon, 11 Mar 2024 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XMRHjkKD"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5119646425
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170704; cv=none; b=QCBhpAd9V5+mLZ3LWCohDlS99ftH8n3WljjQFMfgfSiR2oPyem2vRya/42uRCgp1nWdTKK2uUa3sF/h5TUJ1nq+WwtHIddO+ynwRSgsEiBFHVep5WunvK35OBPLL/ATT+kltIc6RyRWLHQt7YxbaaRhYwkcQuC8eAql+yERgoyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170704; c=relaxed/simple;
	bh=ov9FoPuE92p/IJ9p6mBetZFJarkOBkrT0lUf5tjuOKU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=PBlFTK0ic94/RiBVDjJ+rOnWuHz18cjhuhzaUh/n47n+dsDKBJAAbQRwCBBdELPLY8d5k1+89DfeE6ypUePltSBi2By/N0+wEt5Nq6jyAaqRj39MDMqX0H5e75w5vdHgbsER8kGnQj56QYJJmBLr8Hh15i/qLlwmHap6DuQG9cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XMRHjkKD; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 155D820009;
	Mon, 11 Mar 2024 15:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710170699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zpuJBvyBodbNFlOONGuik3kvuhMsN2cNPJ4hQPAYmXA=;
	b=XMRHjkKDyGW4z+k/XugToqCSkq0EIszgTqN0KQrbYtXX8UL4UZtlHfiXyQ/SKXi3hVcMx7
	LnMUfDSjQzxhZIVdsYmTu1xO23/SUxGJPJfm48G1nd9gM2H4kl0jZo+8V3k8fSGDPr+eeK
	MTCQjr5+VfPSV0ouXNDuTtBHgdnpQJ3Gap2IoTYeGePv448bizOSlhryxryV5n/hFm/G3n
	2zm7g8MJ4jKQqWtt8wme+pkhpGnaVU8HmeaQ5bno7hcjzKuMKa29fXDg7XqRJdvxVFA8lJ
	3TET2+vLZ5rx0bjutLbD1sjObBpYW3eiMXbOQKbcfQbArlCS2Ap9po4Ljo3wlg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/3] scripts/decode_stacktrace.sh: improve error reporting
 and usability
Date: Mon, 11 Mar 2024 16:24:53 +0100
Message-Id: <20240311-decode_stacktrace-find_module-improvements-v1-0-8bea42b421aa@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEUi72UC/x2NwQrCMBAFf6Xs2UASPYi/IlLW5EUXTVI2sQil/
 27wODDMbNSggkaXaSPFKk1qGeAOE4UnlweMxMHkrT/Zo3MmItSIuXUOr64cYJKUOOcaP+8h50X
 riozSm2HrGfDndOdEI7goknz/s+tt33/XFMZffAAAAA==
To: Konstantin Khlebnikov <koct9i@gmail.com>, 
 Stephen Boyd <swboyd@chromium.org>, Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

This small series improves usability of scripts/decode_stacktrace.sh by
improving the usage text and correctly reporting when modules are built
without debugging symbols.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (3):
      scripts/decode_stacktrace.sh: remove find_module recursion and improve error reporting
      scripts/decode_stacktrace.sh: clarify command line
      scripts/decode_stacktrace.sh: add '-h' flag

 scripts/decode_stacktrace.sh | 49 ++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 22 deletions(-)
---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240311-decode_stacktrace-find_module-improvements-a02aee28fbaf

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


