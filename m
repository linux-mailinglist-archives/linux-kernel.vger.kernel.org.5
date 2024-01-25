Return-Path: <linux-kernel+bounces-38482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3A583C081
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906A51C23708
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901F74F8AC;
	Thu, 25 Jan 2024 11:07:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CB11CAAC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180837; cv=none; b=LMh/jx+sCBAkwE4xvNWL4zApiXaq0h2XgVbiLf6Po4vJJYxZ/1BmMHsVCmcXdVDz1RKSytgKH2TNNpEBR+xaKzdahkCl9qTOiqunk4U931x9f5HQv1WvquvquylSn9gqMvCHOCGsvZ9Cqnq7UpBkNBvY/CP73OLK2srI9C/tick=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180837; c=relaxed/simple;
	bh=XBUrk0vc50ELhpBaLW1nBQ+56giWXVaGarHPJ6OLU2M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZG66za8KZ4SL0vGHEvbmoMcGEKPozPy9dLWQ7dtJVjSSdURBOyecwx+BGKLfcEGd9+q4Z27/qBqyJspTNp6KStrTRyb6IzBaSNnM8I8aiECialuYTFz5G00kOlLiLeEduGzDqbnFmJvW5rFfkmUL0cOjr1qUX+SZkru7Yh/AUlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rSxZg-0000EJ-9m; Thu, 25 Jan 2024 12:07:12 +0100
From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 0/3] drm/etnaviv: Disable SH_EU clock gating on the
 i.MX8MP NPU
Date: Thu, 25 Jan 2024 12:07:05 +0100
Message-Id: <20240125-etnaviv-npu-v2-0-ba23c9a32be1@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANlAsmUC/23MMQ6DMAyF4asgz02VuJCiTtyjYrDAgJcEJSGiQ
 ty9KXPH/0nvOyByEI7wqg4InCWKdyXwVsGwkJtZyVgaUGOtDdaKk6MsWbl1Uxafk21b80AcoDz
 WwJPsl/buSy8Skw+fC8/mt/53slFaUUM02Zp4sE23spu3FLyT/T4y9Od5fgEdARq+qwAAAA==
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.13-dev-f0463
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The vendor kernel sets a previously unknown clock gating bit in the
VIVS_PM_MODULE_CONTROLS register to disable SH_EU clock gating.

Import new headers from rnndb for the definition and set the bit
for the VIPNano-Si+ NPU on i.MX8MP and other affected cores.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes in v2:
- Add patch to turn etnaviv_is_model_rev() into a function.
- Use model numbers instead of made up GCxxxx model names.
- Also disable SH_EU clock gating on other models/revisions listed in the
  vendor kernel.
- Link to v1: https://lore.kernel.org/r/20240124-etnaviv-npu-v1-0-a5aaf64aec65@pengutronix.de

---
Philipp Zabel (3):
      drm/etnaviv: Update hardware headers from rnndb
      drm/etnaviv: Turn etnaviv_is_model_rev() into a function
      drm/etnaviv: Disable SH_EU clock gating on VIPNano-Si+

 drivers/gpu/drm/etnaviv/cmdstream.xml.h |  52 ++++++++++++++--
 drivers/gpu/drm/etnaviv/common.xml.h    |  12 ++--
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c   |  72 +++++++++++++----------
 drivers/gpu/drm/etnaviv/state.xml.h     | 101 +++++++++++++++++++++++++++-----
 drivers/gpu/drm/etnaviv/state_blt.xml.h |  20 +++----
 drivers/gpu/drm/etnaviv/state_hi.xml.h  |  28 +++++----
 6 files changed, 210 insertions(+), 75 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240124-etnaviv-npu-627f6881322c

Best regards,
-- 
Philipp Zabel <p.zabel@pengutronix.de>


