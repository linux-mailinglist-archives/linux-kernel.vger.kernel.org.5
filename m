Return-Path: <linux-kernel+bounces-168324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECB68BB678
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8010F1C23F81
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46284CDE0;
	Fri,  3 May 2024 21:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BUWeOsA0"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC3017C66
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714773282; cv=none; b=rT5cHFdz96gcEO0RDjC6jk9OaZcaXdTIg/+hA6QVA9oSl7uBvP/NIXz+fvCZ4EIKNR+B7+O7OKt9O+I6E1Hjjs3xFyRFY0SNODuo+mA4oJvinIMxF6XEHWS75Mn/fEs6qtlupeyK8Red4g4cShBHVfEnIr9GuX9A+EB0foK9lzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714773282; c=relaxed/simple;
	bh=WKkRuMTSq13sPwyQOo7e49ZWHD/lAImaNbzn+u9HJVw=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=WGU1RlZEuZgTmKqspIOM5O+G2XjRuUslPRkvAGtjbJq+wlKouP7boexRyXas0M1w8pCp+GXrhM7Q9FnFu+aUMskhWTNVy1F96FzZEfd1eEYJ94zZ/rh2mOJJf3flBowJa/fn2yVAvADb1LMgnc+CRYDLDuYMDUHEScgZcnhaxCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BUWeOsA0; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4d8f4c9b-2efb-4774-9a37-2f257f79b2c9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714773279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y2853ucShxPVH0hhzsUqBU7LM1cSh77nnSWLF2uYAqA=;
	b=BUWeOsA0/2P3mrUoipdI59mfx6Z9ZUqxsBff025rLQpEMITgxHTVZ9dS4dduZnDjzKTEro
	XU4Ed7K+d42hYYAzzakJTGxl8KrH96WgPonVvNjx5kzSPgPWWM0bKgWSWMzhu0Jz8EPgHO
	QY6+6RvZNTzEX4zO2GBvJ6cb93DDs5M=
Date: Fri, 3 May 2024 17:54:32 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Michal Simek <michal.simek@amd.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [BUG] drm: zynqmp_dp: Lockup in zynqmp_dp_bridge_detect when device
 is unbound
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

I have discovered a bug in the displayport driver on drm-misc-next. To
trigger it, run

echo fd4a0000.display > /sys/bus/platform/drivers/zynqmp-dpsub/unbind

The system will become unresponsive and (after a bit) splat with a hard
LOCKUP. One core will be unresponsive at the first zynqmp_dp_read in
zynqmp_dp_bridge_detect.

I believe the issue is due the registers being unmapped and the block
put into reset in zynqmp_dp_remove instead of zynqmp_dpsub_release. This
could be resolved by deferring things until zynqmp_dpsub_release
(requiring us to skip devm_*), or by adding a flag to struct zynqmp_dp
and checking it before each callback. A subsystem-level implementation
might be better for the latter.

For a better traceback, try applying the below patch and running the
following commands before triggering the lockup:

echo 4 > /sys/module/drm/parameters/debug
echo 8 > /proc/sys/kernel/printk

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 9df068a413f3..17b477b14ab5 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -296,6 +296,7 @@ struct zynqmp_dp_config {
  * @train_set: set of training data
  */
 struct zynqmp_dp {
+       unsigned long long magic;
        struct device *dev;
        struct zynqmp_dpsub *dpsub;
        void __iomem *iomem;
@@ -1533,6 +1534,8 @@ static enum drm_connector_status zynqmp_dp_bridge_detect(struct drm_bridge *brid
        u32 state, i;
        int ret;
 
+       WARN_ON(dp->magic != 0x0123456789abcdefULL);
+
        /*
         * This is from heuristic. It takes some delay (ex, 100 ~ 500 msec) to
         * get the HPD signal with some monitors.
@@ -1723,6 +1726,7 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
        if (!dp)
                return -ENOMEM;
 
+       dp->magic = 0x0123456789abcdefULL;
        dp->dev = &pdev->dev;
        dp->dpsub = dpsub;
        dp->status = connector_status_disconnected;
@@ -1839,4 +1843,5 @@ void zynqmp_dp_remove(struct zynqmp_dpsub *dpsub)
 
        zynqmp_dp_phy_exit(dp);
        zynqmp_dp_reset(dp, true);
+       dp->magic = 0xdeadbeefdeadbeefULL;
 }

