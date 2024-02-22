Return-Path: <linux-kernel+bounces-76414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7C485F70B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7BC2822DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BA946B83;
	Thu, 22 Feb 2024 11:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t48+/f5Q"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEA8383BD;
	Thu, 22 Feb 2024 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601607; cv=none; b=GTGm/7ydWKiFcCofvqtY6HJGms3Chz4JouYLXM07URIdXc98xLaWxr23EoGLsLUFzWTuWNCob1Jff8kWDbwVzrEQdeZS5fa1cw6tC/PWdq49viDTi3y3JA3YRP+IC8Jj40hTrturSdLT3BFpLwbKJ19M+0lkH/6IbltSz+pkA9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601607; c=relaxed/simple;
	bh=dE8sWUiPLq0FaWrSd12fT0dLFSxfOZH6t/B1AZQdSaw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=LeTctDtRimHuLMLch3ChswQwhQnGCBzvXelghbbHlCKfSc4Bs3WDShTsmblytGm3zCa+MQHbTKtaLtpNahCiidKlWp/KPd+pgjnlJDd4JnNnf1LIP3nrZMOEwY2bRZDJTbpGFvv9b9N7iO9obwRu+OoqzeDDvAvSakW1qmya5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t48+/f5Q; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MBX53d059115;
	Thu, 22 Feb 2024 05:33:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708601585;
	bh=bj4DBD9JzM1ZhZS2ZLCo1fD79T0JhKNn65e+gvIiMAI=;
	h=From:Subject:Date:To:CC;
	b=t48+/f5QGgNDJk8O8T/IxbEEbfEkgV3Veqg/Hyu58PtBUdxX6cNC3GHhCSmOppJI0
	 8La/aN5t9Oc/twLQcr4Htm2kSWF4erVnL4bnqPd81ziol4WHm9zfL3ygojxsa/rwxM
	 7qoIsEh3Nb77NTesn5/RW/Z/4aWAJ/XZHtjTvfI0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MBX5v4007284
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 05:33:05 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 05:33:04 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 05:33:04 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MBX3U1128346;
	Thu, 22 Feb 2024 05:33:04 -0600
From: Jai Luthra <j-luthra@ti.com>
Subject: [PATCH RFC 00/21] media: cadence,ti: CSI2RX Multistream Support
Date: Thu, 22 Feb 2024 17:01:16 +0530
Message-ID: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIQw12UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyND3dzSnJLM4pKi1MRc3bSkpESztLRUE/NEYyWgjoKi1LTMCrBp0Up
 Bbs5KsbW1AMsf+ZFiAAAA
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans
 Verkuil <hverkuil-cisco@xs4all.nl>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Aradhya
 Bhatia <a-bhatia1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
        Changhuang
 Liang <changhuang.liang@starfivetech.com>,
        Jack Zhu
	<jack.zhu@starfivetech.com>,
        Julien Massot <julien.massot@collabora.com>,
        Jayshri Pawar <jpawar@cadence.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3027; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=dE8sWUiPLq0FaWrSd12fT0dLFSxfOZH6t/B1AZQdSaw=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1zDSRemMopB1oyhk0qqhqMq7jed7QD5MkvQB+
 HQ5MAOBls6JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdcw0gAKCRBD3pH5JJpx
 RZd4D/wKmk5+oJ5+9MHqCQj2Du6+Y4Sw2Z3uehl3kGI/oZqnSTogESbxfsvOEjmnf8N4/eG3BuM
 lq/F3xa1BJLVY6VxYsoyNx1lA7koLinFK90BDsdN+ohE/sLOfkyXkSxtppzsyzdQe6FLJZTLjHn
 MG95f+lUB8szac6peQ4HURinOHy6SZJ5EKb0IJCJOGNLU5e7AcleFDAg5/V8p2jKqUHgHMV/mXZ
 OYoHZpJ5OHN/wcyp0uAVOkp7VpC9KeU+gbxWvQ84jVTYEI8csZDFS6Ui6fNej3PvbTchq9cuqXr
 bPYYEAepIUfPeaM02Hh3lCX22OCLGriIWuyGFuaODZtMerUArBD49VeDj4wMCIpRyLzIp9/LvOY
 y2jJRTezH5OG3XgiV6DETNma0SUEtWMdwOlLbol9vKCAL3eR7+0AtSnMM2r7Amq9uiDu4QxJOET
 fK+Uuteq7cgjAo5AWUYIAYceHSJnjmn9U/e5OviUp0Q+4F3SKpNIwWCtQLwMYL7WTYLdZrJ7nE/
 S0NC0iXk6G0UyQJGU/FjPm+vScORoHyzkLOadbWPhbgm9J79VMUnpeEJ7Dc9VWwFLeWKQBfEc1q
 TUwTKKAE7IIWQVPteAcTgCFEHJqD3M/s+2ziMczZq5SRa/Eqk+nQvkHgO4K8HncqVqirLp5q0di
 Ai2U0GAc7uxwBfA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This series adds multi-stream support for Cadence CSI2RX and TI CSI2RX
Shim drivers, along with minor improvements and bug fixes. It is a
follow up to [1] which added single-camera support for TI CSI2RX.

Posting this as an RFC as it is late in this merge window, will post a
non-RFC v2 fixing any comments after v6.9-rc1 is tagged.

Some of the patches are split to ease review, and are prefixed with
"SQUASH" in the subject. They can be squashed in subsequent revisions,
as they should ideally go as a single commit.

PATCH 1-3:   Misc. fixes and improvements
PATCH 4-10:  Support multiple DMA contexts/video nodes in TI CSI2RX
PATCH 11-12: Use get_frame_desc to propagate virtual channel information
	     across the different subdevs in the media pipeline
PATCH 13-20: Use new multi-stream APIs across the drivers to support
	     multiplexed cameras from sources like UB960 (FPDLink)
PATCH 21:    Optimize stream on by submitting all queued buffers to DMA

[1]: https://lore.kernel.org/all/20231009-upstream_csi-v10-0-330aaed24c5d@ti.com/

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Jai Luthra (15):
      media: ti: j721e-csi2rx: Fix races while restarting DMA
      dt-bindings: media: ti,j721e-csi2rx-shim: Support 32 dma chans
      media: ti: j721e-csi2rx: separate out device and context
      media: ti: j721e-csi2rx: add a subdev for the core device
      SQUASH: media: ti: j721e-csi2rx: Fix link validation for multi-stream
      media: ti: j721e-csi2rx: add support for processing virtual channels
      media: cadence: csi2rx: Use new enable stream APIs
      media: cadence: csi2rx: Enable stream-wise routing
      SQUASH: media: cadence: csi2rx: Enable per-stream controls
      SQUASH: media: cadence: csi2rx: Filter using MIPI virtual channels
      SQUASH: media: cadence: csi2rx: Filter streams in get_frame_desc
      media: ti: j721e-csi2rx: add multistream support
      SQUASH: media: ti: j721e-csi2rx: Enable per-stream controls
      SQUASH: media: ti: j721e-csi2rx: Assert pixel reset before stopping last stream
      media: ti: j721e-csi2rx: Submit all available buffers

Jayshri Pawar (1):
      media: cadence: csi2rx: Support runtime PM

Pratyush Yadav (5):
      media: cadence: csi2rx: configure DPHY before starting source stream
      media: ti: j721e-csi2rx: prepare SHIM code for multiple contexts
      media: ti: j721e-csi2rx: allocate DMA channel based on context index
      media: ti: j721e-csi2rx: get number of contexts from device tree
      media: cadence: csi2rx: add get_frame_desc wrapper

 .../bindings/media/ti,j721e-csi2rx-shim.yaml       |  40 +-
 drivers/media/platform/cadence/cdns-csi2rx.c       | 460 +++++++++--
 .../media/platform/ti/j721e-csi2rx/j721e-csi2rx.c  | 853 +++++++++++++++------
 3 files changed, 1052 insertions(+), 301 deletions(-)
---
base-commit: d894a2a286fccd6e47cd1cac4c2d4ff5d300d7c7
change-id: 20240221-multistream-fbba6ffe47a3

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>


