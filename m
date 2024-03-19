Return-Path: <linux-kernel+bounces-107221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCDD87F97D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6351C21978
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CD456441;
	Tue, 19 Mar 2024 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SlVttPhl"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4D65381D;
	Tue, 19 Mar 2024 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836586; cv=none; b=JJpVScUAscojGmW03TQhHf2go9txlrqeZvidS6KnRC2ZIXreDVqDmU250vkTgYZL3VOSrfluABB1lhRRkOdHuYeiy+WVtktYprFVvB7tivXzn21UTgeco5mYll+rw+9gn5e+R4g8hNrdkfdlr+1lF9I8+cWWvhMsGHOcr7U0xoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836586; c=relaxed/simple;
	bh=3uEgcL14/KgOuyUT7DBq5tefLQ6t4ehjg3mzEL3+jfo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cX6tpwNtkff5dVlst8K0hhaFVmicZftR00jD0clu4mVaqq6vIl5iWuOCpYXvccpJrT/jrc2FbxHs0ic3LfwXQD4RlaYN/mU98OsTUulEg/CLkJeNkIKMJlLgoGjK/kfxA1nxFv8oQk2mNkMQJyeG+s9Y5OmvsT2jIh58aoBM5yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=SlVttPhl; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4C0F9480;
	Tue, 19 Mar 2024 09:22:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710836555;
	bh=3uEgcL14/KgOuyUT7DBq5tefLQ6t4ehjg3mzEL3+jfo=;
	h=From:Subject:Date:To:Cc:From;
	b=SlVttPhlZmdAZ8gccAq6wQTegHctamRKMdfu9Po5XhbEqiXORQDbrQ8XDmJS3IARs
	 kDy7ymBgWr8EDqEJnJhQfnlWaXDMsLhDy1EmH8hnuokuPF8pey+sThBfYv1ALduMgD
	 358wyAXc1YStlLyTWSJ9cVzyIDpsdUviGMdfNxuU=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v2 0/4] drm: xlnx: zynqmp: Add DP audio support
Date: Tue, 19 Mar 2024 10:22:35 +0200
Message-Id: <20240319-xilinx-dp-audio-v2-0-92d6d3a7ca7e@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAExL+WUC/3WNywrCMBBFf6XM2pEmhmhc9T+kizztgCYl0VIp+
 Xdj9y7PgXvuBsVn8gWu3QbZL1QoxQb80IGddLx7JNcYeM9Ff2IcV3pQXNHNqN+OEgp50Y7xoII
 U0FZz9oHWvXgbG09UXil/9oOF/ez/1sKwR6mkPaugrTFqIOd1SdEknd3RpieMtdYvddEXYLUAA
 AA=
To: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2328;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=3uEgcL14/KgOuyUT7DBq5tefLQ6t4ehjg3mzEL3+jfo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBl+UteszrAX3VCstAgTvoLpu8isthstgM8lQo14
 ZRi8mNeUreJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZflLXgAKCRD6PaqMvJYe
 9VWGEACTMaOmmgN7gTLqZ+nMj1xJZzveP7DfyJPSYOOzO00onkaLVb6oBLFhnr33FFybYk1hOGi
 KhYv3zigVDzM73PmV8hEZgCsmBBdU8eYihGctjn8PIkwi2+EQ8MEzlUIkE/zkzMF5t3Z1ttywbu
 Vc7cSTcAZIGnvYjtqkOLrK34sHGPFJUN5f7pNbS6qwV3zz1zDVGkTFubmRJC6/g07WUxcz/JiMw
 URydx9qINppM5/CbIOvEG/Q2wOsiDR8ac/KPx/I8Qd/jLKiyIY51SAcrG2k/aPYG6Zni0M52Dy6
 Nwt83wdvPC5Vt3BPD3kRMOaseGUCKud+yy8YNHsGb9AkaJzY5cipxLq3YV5DPtwFl1oypmV7tR1
 KblwN7cfFezCFtLL7oMq0TZXLeNemll01fISlNjUTvaRo3qA123VdJ9gRhnUCa9N6YVvX3H8xI+
 gKy0pCKmSIHRxxrm52ABFe5D0hJa2zbuJzamo+CXRfhB4Ct5QKLmjl57MYCUH/fUm+90Hyyx5ox
 vapDAMEPx0PZiYknT5y0bK0pqTTH4+TacjnmlxnH04X9JMcw2slKGThvRw6Qi5pbqHo8Sr8BBQJ
 cwThUb40B/0QNUrGB9PHfDoHX+GLniYBAck9RMt9ZionewHu2qt7WEhSvNMCaCtm9Xwlnd0PhPp
 tZojWuEVv3/r0Sw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add DisplayPort audio support for Xilinx ZynqMP platforms.

This depends on patch adding cyclic DMA mode for DPDMA driver:

https://lore.kernel.org/all/20240228042124.3074044-3-vishal.sagar@amd.com/

If that patch is missing, starting an audio playback will fail with an
ASoC error.

The current DT is, for some reason, missing the DMA channels for the
audio. This series adds that to the bindings and the dts file, but to
support older dtb files without the audio DMA, the driver will not fail
if the audio DMA is missing, but will just mark the audio support as
disabled.

The series also includes an improvement to the
soc-generic-dmaengine-pcm.c, required to support two dmaengine_pcms.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v2:
- Fix a missing double-quote in the DT binding
- Link to v1: https://lore.kernel.org/r/20240312-xilinx-dp-audio-v1-0-696c79facbb9@ideasonboard.com

---
Tomi Valkeinen (4):
      ASoC: dmaengine_pcm: Allow passing component name via config
      dt-bindings: display/xlnx/zynqmp-dpsub: Add audio DMAs
      arm64: dts: zynqmp: Add DMA for DP audio
      drm: xlnx: zynqmp_dpsub: Add DP audio support

 .../bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml   |  10 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   7 +-
 drivers/gpu/drm/xlnx/Kconfig                       |   9 +
 drivers/gpu/drm/xlnx/Makefile                      |   1 +
 drivers/gpu/drm/xlnx/zynqmp_disp.c                 |  50 ---
 drivers/gpu/drm/xlnx/zynqmp_disp_regs.h            |   7 +-
 drivers/gpu/drm/xlnx/zynqmp_dp.c                   |  54 ++-
 drivers/gpu/drm/xlnx/zynqmp_dp.h                   |   7 +
 drivers/gpu/drm/xlnx/zynqmp_dp_audio.c             | 461 +++++++++++++++++++++
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c                |  39 +-
 drivers/gpu/drm/xlnx/zynqmp_dpsub.h                |  15 +-
 include/sound/dmaengine_pcm.h                      |   2 +
 sound/soc/soc-core.c                               |   8 +-
 sound/soc/soc-generic-dmaengine-pcm.c              |   3 +
 14 files changed, 563 insertions(+), 110 deletions(-)
---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240312-xilinx-dp-audio-468ad12f9f64

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


