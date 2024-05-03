Return-Path: <linux-kernel+bounces-168122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139508BB403
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35C63B23F8F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A71158A3F;
	Fri,  3 May 2024 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MQhgFrjp"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4429163CF
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764574; cv=none; b=iyWBHMiGk7pbARm5mHGbnPHz5jXJKruZpe7OBsov+FE750Ot0AH38GL3uH4cErFRvCIxLkTAXN/XEFlrDJ9ujeKn3KTQJTpP6lJJUqiT/LpKf/ffMpQRwukvJnFGm820aDOFAeUvl0UIcTz5+7FJbneMWIb/dVY+9NXI+Ut5XKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764574; c=relaxed/simple;
	bh=Uewv3sKY6afzrItZD7bE6VQgKvSwhlejog6zAPeUt/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VSstPQ7wdA4AM6iFcBt8JhKx/g+bumKIx8YhqZk1qrf0jsoJQi0LZBUavbEpu93TrWgoTdYKybAYRPhwEkR+15jtzQLLGXQgOftgOLMrbDQq+AHsdcuDnsQv30WQ3Nws1LeH1FSFQwltJs1KZNdQrp4Susno3U1wHpcvZECxOXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MQhgFrjp; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714764569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iUCfelyDQR7NwCOZaWX8ASl/1Ini/iPPBj8R9Vt6ybs=;
	b=MQhgFrjpk+EZ3O9deS9HezRuXkIATCAD7VU0drh/fheHoLEiEFrtdpTedu7h68oIDZiVOL
	ius4U2eUybf7aUGKtdcm/FOqMk1nIbEUaFQKUD5I18d/NNB5aj+I9euYQm5bBLlUCnzccT
	mvXqG2C9wZraGXfRKEzGFjfSk1o3azg=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org,
	David Airlie <airlied@gmail.com>,
	linux-kernel@vger.kernel.org,
	Daniel Vetter <daniel@ffwll.ch>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v5 00/10] drm: zynqmp_dp: IRQ cleanups and debugfs support
Date: Fri,  3 May 2024 15:29:12 -0400
Message-Id: <20240503192922.2172314-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series cleans up the zyqnmp_dp IRQ and locking situation. Once
that's done, it adds debugfs support. The intent is to enable compliance
testing or to help debug signal-integrity issues.

Last time I discussed converting the HPD work(s) to a threaded IRQ. I
did not end up doing that for this series since the steps would be

- Add locking
- Move link retraining to a work function
- Harden the IRQ
- Merge the works into a threaded IRQ (omitted)

Which with the exception of the final step is the same as leaving those
works as-is. Conversion to a threaded IRQ can be done as a follow-up.

Changes in v5:
- Fix AUX bus not getting unregistered
- Rebase onto drm-misc/drm-misc-next

Changes in v4:
- Rebase onto drm/drm-next

Changes in v3:
- Don't delay work
- Convert to a hard IRQ
- Use AUX IRQs instead of polling
- Take dp->lock in zynqmp_dp_hpd_work_func

Changes in v2:
- Rearrange zynqmp_dp for better padding
- Split off the HPD IRQ work into another commit
- Expand the commit message
- Document hpd_irq_work
- Document debugfs files
- Add ignore_aux_errors and ignore_hpd debugfs files to replace earlier
  implicit functionality
- Attempt to fix unreproducable, spurious build warning
- Drop "Optionally ignore DPCD errors" in favor of a debugfs file
  directly affecting zynqmp_dp_aux_transfer.

Sean Anderson (10):
  drm: zynqmp_kms: Fix AUX bus not getting unregistered
  drm: zynqmp_dp: Rearrange zynqmp_dp for better padding
  drm: zynqmp_dp: Don't delay work
  drm: zynqmp_dp: Add locking
  drm: zynqmp_dp: Don't retrain the link in our IRQ
  drm: zynqmp_dp: Convert to a hard IRQ
  drm: zynqmp_dp: Use AUX IRQs instead of polling
  drm: zynqmp_dp: Split off several helper functions
  drm: zynqmp_dp: Take dp->lock in zynqmp_dp_hpd_work_func
  drm: zynqmp_dp: Add debugfs interface for compliance testing

 Documentation/gpu/drivers.rst     |   1 +
 Documentation/gpu/zynqmp.rst      | 149 +++++
 MAINTAINERS                       |   1 +
 drivers/gpu/drm/xlnx/zynqmp_dp.c  | 883 +++++++++++++++++++++++++++---
 drivers/gpu/drm/xlnx/zynqmp_kms.c |  12 +-
 5 files changed, 977 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/gpu/zynqmp.rst

-- 
2.35.1.1320.gc452695387.dirty


