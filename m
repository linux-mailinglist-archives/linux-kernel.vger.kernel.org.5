Return-Path: <linux-kernel+bounces-109811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 141A88855FD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DEE1C20F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DD141C73;
	Thu, 21 Mar 2024 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="G9kLjqC+"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BA3200C8;
	Thu, 21 Mar 2024 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711010796; cv=none; b=JCEe19VyxiwYzgDiK6MARvZpGTMVQq8AO5kmLBixnoQlJH7lwuojOyRh2AT/FNIGy9WezTwhgyg8Wn+oFYQiF/55JYzfPoXC0dGPif3LH5zsEJuehQRAkyu0zfxRtuRBhKsshycNi5UXbsqmZZWl5NOIIE7a5HYPPuQr/Pxk3Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711010796; c=relaxed/simple;
	bh=jle9wMiDny+kxaOKZOmL2FIJ6vWyfkstyQhgaqAXszI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X576TwbYB+Jqg6T4VxFkAV+cVRpIZlP0rznri43nV4Nc21NRYtGvcxe3xdwIfPb6vhDXq/y7nv1b/7S9RJfS18NMJCTKx6S22mY89fLQ4NaFRhOwmcRlJBdJ16KayJfpEW6apSeyH5JRcGLXWxiDkUFf15FVwtPeOpyYUPDWwCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=G9kLjqC+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711010793;
	bh=jle9wMiDny+kxaOKZOmL2FIJ6vWyfkstyQhgaqAXszI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G9kLjqC+Z1Ox2AHUeOc1P1V361SzTc0eAb1d9ikwoX2FSIHLxZM85G3Ic6oBKsIio
	 T0+x8pxeKEE9SqryU9yqj8ELIlJ6GQ8+OJxxQD3O5HFzki7u/e9oGCXCixDxlhqK0e
	 5ajkBPRllQd1cGjJ67F588DWgopV920Ha7qAP0VbOSpJO0VraGOkrbdm3PYj7gZsYT
	 SNv1g63cRleafGYEDABs4AW2fcGKE+rIxRDNYvs5fhcDWlo7Rc1jnRxyExqmLhHxpG
	 s67saseBC/QDK+pcgskH/4o0wRB4vm2VXhwz/TVJPB5+kXQp71a9K+enbqA3qMpWO5
	 LWMy36n0OV56Q==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B34DD3782114;
	Thu, 21 Mar 2024 08:46:32 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: mathieu.poirier@linaro.org
Cc: andersson@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	tzungbi@kernel.org,
	tinghan.shen@mediatek.com,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	wenst@chromium.org,
	kernel@collabora.com
Subject: [PATCH 2/2] remoteproc: mediatek: Don't parse extraneous subnodes for multi-core
Date: Thu, 21 Mar 2024 09:46:14 +0100
Message-ID: <20240321084614.45253-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321084614.45253-1-angelogioacchino.delregno@collabora.com>
References: <20240321084614.45253-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When probing multi-core SCP, this driver is parsing all sub-nodes of
the scp-cluster node, but one of those could be not an actual SCP core
and that would make the entire SCP cluster to fail probing for no good
reason.

To fix that, in scp_add_multi_core() treat a subnode as a SCP Core by
parsing only available subnodes having compatible "mediatek,scp-core".

Fixes: 1fdbf0cdde98 ("remoteproc: mediatek: Probe SCP cluster on multi-core SCP")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/remoteproc/mtk_scp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 67518291a8ad..fbe1c232dae7 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -1096,6 +1096,9 @@ static int scp_add_multi_core(struct platform_device *pdev,
 	cluster_of_data = (const struct mtk_scp_of_data **)of_device_get_match_data(dev);
 
 	for_each_available_child_of_node(np, child) {
+		if (!of_device_is_compatible(child, "mediatek,scp-core"))
+			continue;
+
 		if (!cluster_of_data[core_id]) {
 			ret = -EINVAL;
 			dev_err(dev, "Not support core %d\n", core_id);
-- 
2.44.0


