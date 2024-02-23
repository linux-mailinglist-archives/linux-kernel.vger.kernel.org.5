Return-Path: <linux-kernel+bounces-77921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1760860C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F044C1C24815
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0975E18E3F;
	Fri, 23 Feb 2024 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q9qWpI5H"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C140718E0E;
	Fri, 23 Feb 2024 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676618; cv=none; b=MpLjVrbGTDkkjMYlpGNcIAVwhHZjanx4zaqS6W1/tx7BZsZmkUeAe9U20T7HW8Qp7Xxl0KtKiJX/Fn8HE0UMEYRYZQi7BXSn+ZYvdouSk5cZhQSRcRa8c55ywiYRJh83NlgAbsbpVdA0OiDv2WlrEiz5W5CwlUovzbmrtrfLl14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676618; c=relaxed/simple;
	bh=3OxgDd9cbkEjYVNolmPaiSfI2EX9hJKQ7iCEXmwarFw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=OTElnbQAkMew9wNT7XNCC66udZJidCGyNpb3ATOJnc24AoaN7+YJ6gapaKabtIOYlaPHR70wbQkrvbueE6DFQO7DtkqsZuSRE7P/DMDnMS9y92HUv2nvTTJ6j01e5fj2harnB0E3qRrZk3h5SnP16vFBmgs23VPi9zraaJYSq/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=q9qWpI5H; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41N8NBSk119092;
	Fri, 23 Feb 2024 02:23:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708676591;
	bh=jGkKLoODd8kkmh8k8NNJQd7ECjuwCflIUSryq6pNBTU=;
	h=From:Subject:Date:To:CC;
	b=q9qWpI5HstvUQoW/yzMLS8zvxpPBDA33Cx3NGNHWX1/ZT80CtG6hrMQoKW0cgoBZh
	 zKbALsn3f1HyHQohEyzcCc33kyMbzncd5XzDjnY9NTkVRx+r/RSPLH4etJpUGAfXbM
	 1mp15Y1lIvVCJLnNyV94JguIO/JexfUbpte7tKOQ=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41N8NBu2032260
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Feb 2024 02:23:11 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Feb 2024 02:23:11 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Feb 2024 02:23:11 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41N8NA5R023178;
	Fri, 23 Feb 2024 02:23:10 -0600
From: Jai Luthra <j-luthra@ti.com>
Subject: [PATCH 0/2] media: ti,cadence: Fixes for CSI2RX
Date: Fri, 23 Feb 2024 13:53:00 +0530
Message-ID: <20240223-csi_fixes-v1-0-c7eda7a4a852@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAORV2GUC/x3KQQqAIBBA0avIrBPUiqSrREToWLOxcCAC8e4NL
 R//V2AshAyzqlDwIaYrC2ynIJx7PlBTFIMzbjDO9TowbYleZD3ZGNNovY3Jg/x3wT/IvqytfQk
 aYyJbAAAA
To: Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jack Zhu
	<jack.zhu@starfivetech.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Julien
 Massot" <julien.massot@collabora.com>,
        Changhuang Liang
	<Changhuang.liang@starfivetech.com>,
        Jai Luthra <j-luthra@ti.com>, "Pratyush
 Yadav" <p.yadav@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=3OxgDd9cbkEjYVNolmPaiSfI2EX9hJKQ7iCEXmwarFw=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl2FXrA0gW2mAiuq61kVbNeLhxIKM/SguNr3ZJh
 Guc0QaDTyeJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdhV6wAKCRBD3pH5JJpx
 RSHfEACDNTzRaUYLwLWhh6HN/CsHUoLH5tFKb2vuIzD60BlP2+XIWlFB5bMcSdOlaEgW1EPtWrl
 8rRE93Ic3xZuQfnRHNaPj/KnC++R5g+fGRYU4jjU+45b7GPLNfHGqX3imP+zt+jRv1IiQnlmGdi
 vlSVmV+4RyNxw3dpK276g6aE1Zkmk+QwIDPtJduDU73WjkbU9DcQYLcgTJq++hF5dzRS/wQXmOT
 p50s+DbJizBe0zLjb4Px35f9SI/CGym/RJMhJwj+VMvf7FjeBpKhNedoIBbSk3jBzpWM2joxVUK
 HpyC43Nqy4MooyLLKjwU8xNTWgg3ytFzlbSaiTzB4DcDD03I9n8kYJIXP+/7LO24EGSkc4T64CP
 XTg5Y6HK15SMHnKbQxB0u4I7SIVCWEOqL1BtMj/RGGh3J5SJEtZSyWat3O447Pm3hzCF7pDSTi3
 siLnCok1Y7Zj5Vzev+sZPi5OhvQeQIXktz+QH0jDRlkJsRmU1wCeRzLm5lG8NkuNN1Bjwevxu10
 TKFqKpY4jQk3Vc6Rz6zSkdnb1YnKl18DpMNAnTek70JdcEB7XxKkdahlqmEQvliATTgElDDaLSb
 EnTUyymP4j2Anqq7GbIDbXzhWbktRjCqrIksaXnGlVFSVX3CdWgGA9sOfKamq28zmi9vRjuYtVf
 Ux6U8aqc+dTX/Vw==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This series fixes two bugs:
1. When Cadence CSI2RX is used with an external DPHY controller, fix the
   programming sequence to configure the DPHY controller before starting
   streaming on the source
2. Fix a possible race condition in TI CSI2RX Shim driver when
   restarting DMA after stalling due to lack of buffers

These fixes were originally posted in the multi-stream RFC series [1],
but as these are unrelated and urgent, posting them separately now so
they can get picked independently.

Test logs with SK-AM62A + OV5640 https://0x0.st/H5pN.txt

[1]: https://lore.kernel.org/all/20240222-multistream-v1-0-1837ed916eeb@ti.com/

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Jai Luthra (1):
      media: ti: j721e-csi2rx: Fix races while restarting DMA

Pratyush Yadav (1):
      media: cadence: csi2rx: configure DPHY before starting source stream

 drivers/media/platform/cadence/cdns-csi2rx.c       | 26 ++++++++++++----------
 .../media/platform/ti/j721e-csi2rx/j721e-csi2rx.c  |  5 ++---
 2 files changed, 16 insertions(+), 15 deletions(-)
---
base-commit: 33e1d31873f87d119e5120b88cd350efa68ef276
change-id: 20240223-csi_fixes-71ddf5181df8

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>


