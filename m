Return-Path: <linux-kernel+bounces-90129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE88F86FAC5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01A41C21447
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B0913AF3;
	Mon,  4 Mar 2024 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="GMJy/Frx"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F8A134AE;
	Mon,  4 Mar 2024 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537413; cv=none; b=R5VOj/81ahYlC6IdedJxL4SKdz6T5xf4mVoieRWHv3ZRKnA6s6OVPrhTdXf98MXGLfCPGCwWYcjQMhAYm2DC/ZfcV9qz79w+gEZvmJwhtyqEjm9xrVwJeaLm7bPciifPBpazN5X1k3oI9dLuEYTyFFDc+1xamCjRXQMz0UnYy0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537413; c=relaxed/simple;
	bh=Gjmx1LoCeFmH3HZQN2zSbyKOB5bSkpnKc14O2QudTyc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XUUGDBpM2vD3OLD7YgfLBojEZKLWqeAYqtEbcOlMLSBkMp+zXcQl3+iXMOlntsL+c0JWgMOqAdICQKbx6TCOe/FSv2xjABpVTvY2tsBE4tQbw6crsSR2nu4GsC07h61QmjDwjgJkTE0hCazK1lLOu4eYBztqTJkCZcJtb3W1yDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev; spf=pass smtp.mailfrom=oltmanns.dev; dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b=GMJy/Frx; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Tp9MD5Wltz9sp7;
	Mon,  4 Mar 2024 08:30:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1709537400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NoCsY0uVPieE3Bki0yClO1kq6+DglOQe3SGQtQLnjtI=;
	b=GMJy/FrxoUhe66dmuSip7yLhn85T8/o5Pw4MZOhYaDRt4ckcRkuULKweChYZaDXWdhgr6I
	4O4PnCij30/5YG9dfZOrjrM0fRaJcwH8MzZQOStZtmUi5+p8V/Q6Ej94Gzg3cEVOw7HD43
	NrTBoWAVzbFhXlOm9EiElTj9Jyilj9WqnhImvbYxcRxTiRWlBbekJ3xdknOio5IvDB1Ugb
	61WmDNptyR0lsWVIQuLDEnpHHPjSNd4OToqrfY2m4Plg2z6wRVzH66HE54qps5JNCE3xkk
	O10pyaI3h4yANsmY7yeqrFcQEzBnnwnMUIo9965KXqmUr10WxIE8qFKtsAbdbQ==
From: Frank Oltmanns <frank@oltmanns.dev>
Subject: [PATCH v3 0/5] Pinephone video out fixes (flipping between two
 frames)
Date: Mon, 04 Mar 2024 08:29:16 +0100
Message-Id: <20240304-pinephone-pll-fixes-v3-0-94ab828f269a@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEx45WUC/33NQQ7CIBAF0Ks0rMXAULHtynsYFxSmlqQCgYZom
 t5d2sSNMS7/n/w3C0kYLSbSVQuJmG2y3pUgDhXRo3J3pNaUTICB4MAbGqzDMHqHNEwTHewTE2V
 am8EgnAXWpCxDxP1QhtdbyaNNs4+v/UnmW/vfy5wyiiCaXqKRRvOLn+aHci4dDWaykRk+TM2An
 X4zUJhWqloqMI1u+y9mXdc3KDivswABAAA=
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 Frank Oltmanns <frank@oltmanns.dev>, stable@vger.kernel.org, 
 Diego Roversi <diegor@tiscali.it>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3360; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=Gjmx1LoCeFmH3HZQN2zSbyKOB5bSkpnKc14O2QudTyc=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBl5XhwsffaJUTjKesrQMFXm9SL0rmYfvGrVtp+e
 o8WbpVFG1iJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZeV4cAAKCRCaaaIIlErT
 xw1JC/4s83wVFPqgCyLwlwxOrDIhPUUecHpIS8lGXewEMxp/h32L7wyzeW+UxwBCskTIPbbSgZk
 PYfNUZpk7IOalDYXZMfQeR1HW0oMPQBTS7/YbjMmwz5NB1KpK/WMQ/FJRBI/Xpts4eLjCtPFWAm
 IyaKjK3f+niwlnuRdV5pVlgkxg+jhj+TueaP1b+DAJOYFWdMzIk+V/hKwPi680FEqLvIwdK9+Ut
 ByYnzM1BZlYBgy2jUc8b44dTZ5/OvVkRwX1ZAQGBLZwLwPCTjR3tejhmmNBtx8XxioAAVzBU4b2
 9xbRYfAyPxfqToJx0nshopXEPRsotlDyVJxORuZE1fJkT/wTvKk8JlOWZhnmeAqBxBw4Dh6id3P
 vmIQAGU95RWoj6PUm5IcZcMQp70f9RZSMD35KLwXRtpG/y4jWWzQqaRHzsRXvSwJwKp7c9k+EjJ
 W5CwokuXlcyh+nHidpUSJK9Sck0/D8Rji7HxtSXhDkQ3RkQDPwJn+CaEjgqqchZP5qaTI=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7

On some pinephones the video output sometimes freezes (flips between two
frames) [1]. It seems to be that the reason for this behaviour is that
PLL-MIPI is outside its limits, and the GPU is not running at a fixed
rate.

In this patch series I propose the following changes:
  1. sunxi-ng: Adhere to the following constraints given in the
     Allwinner A64 Manual regarding PLL-MIPI:
      * M/N <= 3
      * (PLL_VIDEO0)/M >= 24MHz
      * 500MHz <= clockrate <= 1400MHz

  2. Remove two operating points from the A64 DTS OPPs, so that the GPU
     runs at a fixed rate of 432 MHz.

Note, that when pinning the GPU to 432 MHz the issue [1] completely
disappears for me. I've searched the BSP and could not find any
indication that supports the idea of having the three OPPs. The only
frequency I found in the BPSs for A64 is 432 MHz, which has also proven
stable for me.

Another bigger change compared to the previous version is that I've
removed the patch to adapt the XBD599 panel's timings to Allwinner A64's
PLL-MIPI new constraints from this series. Mainly, because I'm currently
evaluationg other options that may or may not work. (It may work at
least until HDMI support is upstreamed.) I'll probably resend the patch
at a later point in time.

I very much appreciate your feedback!

[1] https://gitlab.com/postmarketOS/pmaports/-/issues/805

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
Changes in v3:
- dts: Pin GPU to 432 MHz.
- nkm and a64: Move minimum and maximum rate handling to the common part
  of the sunxi-ng driver.
- Removed st7703 patch from series.
- Link to v2: https://lore.kernel.org/r/20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev

Changes in v2:
- dts: Increase minimum GPU frequency to 192 MHz.
- nkm and a64: Add minimum and maximum rate for PLL-MIPI.
- nkm: Use the same approach for skipping invalid rates in
  ccu_nkm_find_best() as in ccu_nkm_find_best_with_parent_adj().
- nkm: Improve names for ratio struct members and hence get rid of
  describing comments.
- nkm and a64: Correct description in the commit messages: M/N <= 3
- Remove patches for nm as they were not needed.
- st7703: Rework the commit message to cover more background for the
  change.
- Link to v1: https://lore.kernel.org/r/20231218-pinephone-pll-fixes-v1-0-e238b6ed6dc1@oltmanns.dev

---
Frank Oltmanns (5):
      clk: sunxi-ng: common: Support minimum and maximum rate
      clk: sunxi-ng: a64: Set minimum and maximum rate for PLL-MIPI
      clk: sunxi-ng: nkm: Support constraints on m/n ratio and parent rate
      clk: sunxi-ng: a64: Add constraints on PLL-MIPI's n/m ratio and parent rate
      arm64: dts: allwinner: a64: Run GPU at 432 MHz

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  8 --------
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c         | 14 +++++++++-----
 drivers/clk/sunxi-ng/ccu_common.c             | 15 +++++++++++++++
 drivers/clk/sunxi-ng/ccu_common.h             |  3 +++
 drivers/clk/sunxi-ng/ccu_nkm.c                | 21 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_nkm.h                |  2 ++
 6 files changed, 50 insertions(+), 13 deletions(-)
---
base-commit: 216c1282dde38ca87ebdf1ccacee5a0682901574
change-id: 20231218-pinephone-pll-fixes-0ccdfde273e4

Best regards,
-- 
Frank Oltmanns <frank@oltmanns.dev>


