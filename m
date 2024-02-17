Return-Path: <linux-kernel+bounces-69923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4397285905C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8066B22293
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED567CF16;
	Sat, 17 Feb 2024 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sk6Bj7qn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6007C08E;
	Sat, 17 Feb 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708182183; cv=none; b=JU57P2otv88wpG0anqGD98QrMYy4L/dnPH8HFcT/QJH/X5sK2X4P31+JHOgz0C+zi6Jf4RASftAFDkYMpZcq1IhpdU4zTzdCyUu8MEtNHXTvnqPABHv/t494jykRq/dTVqJ738cIHHapHUmqP/dKUd+psHKGwaonXOX0K95VNAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708182183; c=relaxed/simple;
	bh=RYGrgArfEQO1hz4ZDJrYc151D2jwcPj4HsJMgduGqdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mYv9kfB8L01xHeU3zwudfIoqbxqUbp2tt1h1kS8CickFQ2XLX/eEe7VD27/sz39tRTujZNEy4HoaasQnBB8VBZD/ZsE/5nktswTLusHFt7iRWPlYd4D7prNcZnT+6UP57ltIJC4iSKDXMjFpsCKmgzFluzd+DOr6AH6onp8kgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sk6Bj7qn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF3FC43399;
	Sat, 17 Feb 2024 15:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708182183;
	bh=RYGrgArfEQO1hz4ZDJrYc151D2jwcPj4HsJMgduGqdg=;
	h=From:To:Cc:Subject:Date:From;
	b=Sk6Bj7qnkUtxpPu7r0OWOEKX33/NEitQ5TtRnYdKJx+5sZ2r+IdHyM4505BXrMdz7
	 GQebIt2mgAB3H+iuiVvivn25osbNIPGGdUUA6Sy7we/HmOoNHmvZ29aY/D1v/3OXKD
	 P0bwBYQVv0Ddw4ZaTUT+gKpRcQrYUqIJMifT/Fi8HGaiNqwKjJbCouYHnoGUUkhJwI
	 Bbf7tsUiicb0WSQafeUfOO4SvhcBn4jAy7CpR1tGSBqOarXQ+/gZF8xYjmsOgZNnzD
	 AqUCkvJtcEa+vQ7aB1sdYH+ZhJa3h5ARzbrw4zE8XlUbS07GjIwzvSopeuJnp/v7Nw
	 PeCQwYiphYhEw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rbMDW-000000001Vm-1iMa;
	Sat, 17 Feb 2024 16:03:02 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/6] soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free
Date: Sat, 17 Feb 2024 16:02:22 +0100
Message-ID: <20240217150228.5788-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting with 6.8-rc1 the internal display sometimes fails to come up on
machines like the Lenovo ThinkPad X13s and the logs indicate that this
is due to a regression in the DRM subsystem [1].

This series fixes a race in the pmic_glink_altmode driver which was
exposed / triggered by the transparent DRM bridges rework that went into
6.8-rc1 and that manifested itself as a bridge failing to attach and
sometimes triggering a NULL-pointer dereference.

The intermittent hard resets that have also been reported since 6.8-rc1
unfortunately still remains and suggests that we are dealing with two
separate regressions. There is some indication that also the hard resets
(e.g. due to register accesses to unclocked hardware) are also due to
changes in the DRM subsystem as it happens around the time that the eDP
panel and display controller would be initialised during boot (the
runtime PM rework?). This remains to be verified, however.

Included is also a fix for a related OF node reference leak in the
aux-hpd driver found through inspection when reworking the driver.

The use-after-free bug is triggered by a probe deferral and highlighted
some further bugs in the involved drivers, which were registering child
devices before deferring probe. This behaviour is not correct and can
both trigger probe deferral loops and potentially also further issues
with the DRM bridge implementation.

This series can either go through the Qualcomm SoC tree (pmic_glink) or
the DRM tree. The PHY patches do not depend on the rest of the series
and could possibly be merged separately through the PHY tree.

Whichever gets this to mainline the fastest.

Johan


[1] https://lore.kernel.org/lkml/ZctVmLK4zTwcpW3A@hovoldconsulting.com/


Johan Hovold (5):
  drm/bridge: aux-hpd: fix OF node leaks
  drm/bridge: aux-hpd: separate allocation and registration
  soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free
  phy: qcom-qmp-combo: fix drm bridge registration
  phy: qcom-qmp-combo: fix type-c switch registration

Rob Clark (1):
  soc: qcom: pmic_glink: Fix boot when QRTR=m

 drivers/gpu/drm/bridge/aux-hpd-bridge.c   | 70 ++++++++++++++++++-----
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 16 +++---
 drivers/soc/qcom/pmic_glink.c             | 21 +++----
 drivers/soc/qcom/pmic_glink_altmode.c     | 16 +++++-
 include/drm/bridge/aux-bridge.h           | 15 +++++
 5 files changed, 102 insertions(+), 36 deletions(-)

-- 
2.43.0


