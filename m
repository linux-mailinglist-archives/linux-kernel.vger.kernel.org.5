Return-Path: <linux-kernel+bounces-71942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EF985ACD7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48F2287DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2861F52F8A;
	Mon, 19 Feb 2024 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pqrs.dk header.i=@pqrs.dk header.b="1v/SkDNa"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCEC374DD
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373593; cv=none; b=IyPctfC5rzUYz9w2oVQ1CEu8qJHn6uZseVqVI92shf14ufsaMaXZ+qwpzEI36Obh0YhV/hIyWJKWqg3dnxoRwSPXjL2NBhAArrhHxt7Q/nwxywpQUJByIYKOlAUtdi352oLSt/an8lAWsnMZTDHCmunR6Ht/DqtWqae8MLAZfds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373593; c=relaxed/simple;
	bh=GiZmlgeKTMCkZ8D5oBlu3UrTyPPfMRdiZij9U/zUGGw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YF82Fp6TnMfCY2I0NFVAojtUh1k4kWGCJcBY4dD91YinN1b3NVdcl+G0L7kFTwNIi8t3GDNe4SQkLwyPsCeMGAMlsnyM2Ku5kFFKHR0r3Qeu6k/hSB3LoeEpuaV1kovuAxP1iGMk6Htu0Idm95pXv7D7A37QqPwEdm/91SEky3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pqrs.dk; spf=pass smtp.mailfrom=pqrs.dk; dkim=pass (2048-bit key) header.d=pqrs.dk header.i=@pqrs.dk header.b=1v/SkDNa; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pqrs.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pqrs.dk
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqrs.dk; s=key1;
	t=1708373586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mguEP1Gv9Bi8kebx8E+Cy9id6Us4gzQ3hJk5w5gRw5A=;
	b=1v/SkDNaRggd3fhA6WuwSDFAXz2yqhhxP+RTeyhMfS32xGBW49Y+SICHJmMpMws41ocvO3
	wizWAyQxKKIpy7A16tNchfnITb7cgnoWufGqWtuyW/gvUKXL+gbUdEqs4S4eQNG6ED6t7f
	WmF3R3Ae2WhdlrgEDCU0CZ8ytfT830+a49eFMRF69LO33GFILL8AXvOEVWGPx+PJ8RAwbp
	80V5h55xysVvMr5NxY4nigRB+h16xDcAtIH+7TB9usSOAvE/0mx0ilMC2GaPYBRc6WgBSR
	2bIx/dL3R2xkNiHev9T3GadTCg1Wzexf7mfxi0MDSG/2j5+L8FKjMqJkdeoeSg==
From: =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Subject: [PATCH v3 0/2] drm/bridge: adv7511: get edid in hpd_work to update
 CEC phys address
Date: Mon, 19 Feb 2024 21:12:57 +0100
Message-Id: <20240219-adv7511-cec-edid-v3-0-445aed2f1cd7@bang-olufsen.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEq202UC/33OwQrCMAyA4VcZORtpOsvUk+8hHro2cUXZpNWij
 L273S4eFI9/IF8yQuIYOMG+GiFyDikMfYl6VYHrbH9mDL40aKVrUrRB63NjiNCxQ/bBo0hjWl9
 bt9M7KGu3yBKeC3k8le5Cug/xtVzINE//YJmQ0JqtY8uqNQ0f2vIEDteHJO7X/gIzmfWHIf2L0
 ahQFBtmK16c/mamaXoDUMpTf/0AAAA=
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
X-Migadu-Flow: FLOW_OUT

This series fixes a small bug where the CEC adapter could have an
invalid CEC address even though we got a hotplug connect and could have
read it.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
Changes in v3:
- rebase on latest drm-misc-fixes
- remove redundant NULL check before kfree()
- collect Robert's Reviewed-by
- Link to v2: https://lore.kernel.org/r/20231124-adv7511-cec-edid-v2-0-f0e5eeafdfc2@bang-olufsen.dk

Changes in v2:
- Rearrange driver code to avoid the previous prototype of
  adv7511_get_edid(), per Laurent's feedback
- Free the returned EDID to prevent a memory leak, per Jani's comment
- Link to v1: https://lore.kernel.org/r/20231014-adv7511-cec-edid-v1-1-a58ceae0b57e@bang-olufsen.dk

---
Alvin Šipraga (2):
      drm/bridge: adv7511: rearrange hotplug work code
      drm/bridge: adv7511: get edid in hpd_work to update CEC phys address

 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 153 ++++++++++++++++-----------
 1 file changed, 89 insertions(+), 64 deletions(-)
---
base-commit: 335126937753844d36036984e96a8f343538a778
change-id: 20231014-adv7511-cec-edid-ff75bd3ac929


