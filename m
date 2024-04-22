Return-Path: <linux-kernel+bounces-153161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E838ACA72
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAE18B21256
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFFE13E40A;
	Mon, 22 Apr 2024 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XhedbwYI"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0B513E3F6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781219; cv=none; b=kpz65ekcL+GzhPdPrzpfLIOY/5gPXW0HBZgZfdsPIDF/BsXG8HvBHKrlxGMUSL5gk//ClLhPCgYCV5j1gpjAuLyyAYVES46/3ARpyZlNKYiAL6/0ArmNQYvtfe4WpyqnuZ/nbiPNNXuIcK4otTT/cKrjPK+kxQzDwLUwhIuMKxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781219; c=relaxed/simple;
	bh=5+rGn6vFhgDlks2UVvl01vucZ3eSZzhL4KNn8cLJidA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DjoC4JPll4PS7N6ljIquBvDEWT7lfPuFUUui3u00f0H0VMSoraTnwan1J18Mmj1wHzV7y+OWV+RDvFytRsVmNmTCyCOqHykPdOYcR4z83Pp31uQI1ppnE9IN6xwsxh2pKjSmTTTYxN9YIGQlumC/Gw93FQ8H3m8k7Do8fTF4LbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XhedbwYI; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=twF0f
	VgcdFbRYd/8dnq/6sOb23kJ0H7GRTQUDCTRWBs=; b=XhedbwYIfrJsCpytTVmBT
	SkUg6r7FCcyJ9FMdWtN6caV/Kl7evm6meMcy8/oktADqbZ0x8dMXHvrAKukQMqsn
	wODY0j/7hUPTieJA1v75vb2jp6MHjppMUbinip34iTpv0yw7th47gygJgAipiIT6
	FXbpeDxdRNrDxEpLV7gXLQ=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wB3fymbOSZmRwO9Bw--.23790S2;
	Mon, 22 Apr 2024 18:19:10 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: tzimmermann@suse.de,
	mripard@kernel.org,
	hjc@rock-chips.com,
	s.hauer@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH 0/1] Fix the port mux of VP2
Date: Mon, 22 Apr 2024 18:19:04 +0800
Message-Id: <20240422101905.32703-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3fymbOSZmRwO9Bw--.23790S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU3FksUUUUU
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMwDIXmXAkyK0RAAAsB

From: Andy Yan <andy.yan@rock-chips.com>


The port mux bits of VP2 should be defined by RK3568_OVL_PORT_SET__PORT2_MUX,
this maybe a copy and paste error when this driver first introduced.
Hi Heiko:
   Maybe thi is the problem you met when you porting the dsi2 driver.
I previously sent you this patch when you ask me about this issue on
email,but I'm not sure if you received it.


Andy Yan (1):
  drm/rockchip: vop2: Fix the port mux of VP2

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1


