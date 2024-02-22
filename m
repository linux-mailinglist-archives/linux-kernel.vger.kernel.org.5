Return-Path: <linux-kernel+bounces-76796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F1085FCC2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B36289CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6617014E2F5;
	Thu, 22 Feb 2024 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTvQ8XMW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81B714D42B;
	Thu, 22 Feb 2024 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616489; cv=none; b=deonoUnCBWS8w0R0SFtklVNyBoEHyiyyl6CmGtI/8iIpDGMn1szGpOucP6Ahz+GcN/6Ij0P5iLYhY+qpOdxQgyBZE6ofaht2rXeUnLkoJHI75tWCxvu134naoVae/PdJPhLM53w1nJufxp5iadzm95UHH1XXgwnHIollSh/lBl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616489; c=relaxed/simple;
	bh=pjixf3oXo63dg7qf7lXjwZCTLnX0p47lkDin0H4I8LU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m6P7IxdMrSQMXfZWrp9XCdPETUmhLSVlO9cZqZviiNd9YG9ovxA/zvexOREPU+b8vwjrCkW0q/ANFdzgongn8MYiW3OVU4e6CFsahzNBxI4/hHP39P9WxoQ+NU6i9Th8mV+vYliUHPZJkVFUQ5B2W8qfGJCDULWJjnAt/cXcXX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTvQ8XMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35792C433F1;
	Thu, 22 Feb 2024 15:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708616489;
	bh=pjixf3oXo63dg7qf7lXjwZCTLnX0p47lkDin0H4I8LU=;
	h=From:To:Cc:Subject:Date:From;
	b=jTvQ8XMWDulUTguO1lrSEX+LInOIjmnQhNbrGk7y8o2w699XXvhWZcAgJYmiY2KON
	 0sUvlq7/4FDFHEw8Lvn78gWeubpi7fVJjcaZjgo/G4hGOoROEwq2pdFXbSkyvp2ae+
	 did0penN8Xd26Y30/5mxSFS6CecVq7wdM3tmRn/SWunNkeqziWhj4ifCN6MH8kQSn2
	 D577EuZiKtmQf4eXSgqWqV8AbzBJILrLIX+L9/RF5T//HavbM3WEHnEOhSczsLy9Ax
	 xunLJqrFaYar7GJrBEGLTpu0AFUnbHdGp7c40xhoWAqs9NGuOM4uh6NgCL2fudjoPQ
	 2fi/Mp1krDFVA==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Moudy Ho <moudy.ho@mediatek.com>,
	"Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH v2 00/12] Remove cl in struct cmdq_pkt
Date: Thu, 22 Feb 2024 15:41:08 +0000
Message-Id: <20240222154120.16959-1-chunkuang.hu@kernel.org>
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

Changes in v2:
1. Fix typo of CMDQ_JUMP_RELATIVE
2. Refine cmdq_pkt_create() and cmdq_pkt_destroy()
3. Rename cmdq_pkt_jump() to cmdq_pkt_jump_abs()
4. Add cmdq_pkt_jump_rel() helper function
5. drm/mediatek: Use cmdq_pkt_create() and cmdq_pkt_destroy()
6. mtk-mdp3: Get fine-grain control of cmdq_pkt_finalize()
7. mtk-mdp3: Use cmdq_pkt_create() and cmdq_pkt_destroy()

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/commit/?h=mediatek-cmdq8&id=a1b2f7a7488285975c1f439086f1c4cc51a13bb9

Chun-Kuang Hu (12):
  soc: mediatek: cmdq: Fix typo of CMDQ_JUMP_RELATIVE
  soc: mediatek: cmdq: Add parameter shift_pa to cmdq_pkt_jump()
  soc: mediatek: cmdq: Rename cmdq_pkt_jump() to cmdq_pkt_jump_abs()
  soc: mediatek: cmdq: Add cmdq_pkt_jump_rel() helper function
  soc: mediatek: cmdq: Add cmdq_pkt_eoc() helper function
  soc: mediatek: cmdq: Remove cmdq_pkt_flush_async() helper function
  soc: mediatek: cmdq: Refine cmdq_pkt_create() and cmdq_pkt_destroy()
  drm/mediatek: Use cmdq_pkt_eoc() instead of cmdq_pkt_finalize()
  drm/mediatek: Use cmdq_pkt_create() and cmdq_pkt_destroy()
  media: platform: mtk-mdp3: Get fine-grain control of
    cmdq_pkt_finalize()
  media: platform: mtk-mdp3: Use cmdq_pkt_create() and
    cmdq_pkt_destroy()
  soc: mediatek: cmdq: Remove cmdq_pkt_finalize() helper function

 drivers/gpu/drm/mediatek/mtk_drm_crtc.c       | 48 ++----------
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 48 ++----------
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    |  2 +
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |  1 +
 drivers/soc/mediatek/mtk-cmdq-helper.c        | 73 ++++++-------------
 include/linux/soc/mediatek/mtk-cmdq.h         | 60 +++++++++------
 6 files changed, 73 insertions(+), 159 deletions(-)

-- 
2.34.1


