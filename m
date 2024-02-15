Return-Path: <linux-kernel+bounces-66195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C883E85586C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0640C1C25F80
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C292110F2;
	Thu, 15 Feb 2024 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8SoANEa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE55A50;
	Thu, 15 Feb 2024 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707958202; cv=none; b=l18ncRTEpWdvXNvkqgalLATtUKQeLyD7Cd2L8/qp98lTDUnwelDumc+iEEZQ7pPzx5CCQcpwXBmEO7/79DeGyXSE7KY6IOLu5a+nR5y8N9M/cdm5Hd2O+U/BTasFQgfNF0/kgp+KgTOwaYmxVwBRvcbqzWPhduDON6EMEqTZeKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707958202; c=relaxed/simple;
	bh=IMXlz+K+vPt7moPsPtyRvbcUlG72JSuixPQZI0qMeLY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UDW5ft1hfC7pXlpLt/JbnoMdyjazkyeItOe9FqE/f3cNzqRLTwgOEtoGUhGvGStLWQISzgRnTuxAJE8nnam1MhSnslWOQkftH29VY/6IV0XC4/Ly5N+rpW/+fWIXTHJkUf7t/utJsjl/fG/hGtZd6deD4MPanavwaUqYZPpIZdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8SoANEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A98C433F1;
	Thu, 15 Feb 2024 00:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707958201;
	bh=IMXlz+K+vPt7moPsPtyRvbcUlG72JSuixPQZI0qMeLY=;
	h=From:To:Cc:Subject:Date:From;
	b=j8SoANEaHx7kyPgIzpO6tg0EZvR3ELnnl4+G7fyU8zcygw98P8pl5Kd/KFvXxZ9NC
	 fs9OxOGNxFsxZY4IckiKG8Cz10UhA00lr5/MpQIg+oNn2SN8TLk3IObpAjsBwErRvu
	 oqFudwiDf75/+NUUQ5QZlW/CVDYxX8wpQWWYvs0soJnf//bnHBpVPpivQCy7jh5Ack
	 4XM4cGxDNKaElSGw51QMD0mFLjdD+yz05CmgGBZeOLL4A7DNJ3K7jXV0jYO53cyuek
	 T96GybEFfgb0ijQADnEDbJWd1oYCwm9iq17jkeR5A5i2Q4depdspDqiJFPWDtDcDce
	 IC5OLPUe8E0xQ==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 0/9] Remove cl in struct cmdq_pkt
Date: Thu, 15 Feb 2024 00:49:22 +0000
Message-Id: <20240215004931.3808-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cl in struct cmdq_pkt is used to store struct cmdq_client, but every client
driver has the struct cmdq_client information, so it's not necessary to
store struct cmdq_client in struct cmdq_pkt. Because mailbox maintainer
do not like to mix mailbox patch with other patches in a series, so
mailbox patch [1] would be sent independently.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/commit/?h=mediatek-cmdq8&id=a1b2f7a7488285975c1f439086f1c4cc51a13bb9

Chun-Kuang Hu (9):
  soc: mediatek: cmdq: Remove unused helper funciton
  soc: mediatek: cmdq: Add parameter shift_pa to cmdq_pkt_jump()
  soc: mediatek: cmdq: Add cmdq_pkt_eoc() helper function
  soc: mediatek: cmdq: Add cmdq_pkt_nop() helper function
  drm/mediatek: Drop calling cmdq_pkt_finalize()
  media: platform: mtk-mdp3: drop calling cmdq_pkt_finalize()
  soc: mediatek: cmdq: Remove cmdq_pkt_finalize() helper function
  drm/mediatek: Do not store struct cmdq_client in struct cmdq_pkt
  media: platform: mtk-mdp3: do not store struct cmdq_client in struct
    cmdq_pkt

 drivers/gpu/drm/mediatek/mtk_drm_crtc.c       |  9 +-
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 14 ++-
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    |  2 +
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |  1 +
 drivers/soc/mediatek/mtk-cmdq-helper.c        | 85 +++----------------
 include/linux/soc/mediatek/mtk-cmdq.h         | 50 ++++-------
 6 files changed, 39 insertions(+), 122 deletions(-)

-- 
2.34.1


