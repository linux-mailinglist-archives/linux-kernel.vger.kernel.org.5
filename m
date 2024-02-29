Return-Path: <linux-kernel+bounces-87255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5FE86D1C6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66BBE286B49
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A250A7D3F2;
	Thu, 29 Feb 2024 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBwWb12H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74497BAEB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230390; cv=none; b=bFy9w/x6qaKAr2IWyP65EBVJ5xVS8fm/DuCxqXuNWcJxg31z/h96M0Xpp+Z4fk4HiZr549t0olNiF8jYBqVe7VfCP87HmV8zxT+c+VZZDBojscj+TDDL7nHQKAXFnB5B8vU/y06pEBc9EDISiGfkim/A5mDBXItjUeReXKdUf9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230390; c=relaxed/simple;
	bh=4UHafzd9xCDmrdK5pv4Mx3tzDTPiSQz7ubBe9sEoTrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=okDQ6HNJm31d9LRXs4RvR5hhxQUH2MVSUYZ9W1jIizSBXqELVzJAoJNJTcD6qzA2zbZjxxPN5ckwzQFGDH+bf7intwrcgUKbg7rJa/HSHy9zxEiB/92LCwU22BklNEjeA4B3Za6lUKICQDsDYnMJ2WWbhMIUUrSvNmnv8iUFBW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBwWb12H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4808DC43394;
	Thu, 29 Feb 2024 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709230389;
	bh=4UHafzd9xCDmrdK5pv4Mx3tzDTPiSQz7ubBe9sEoTrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fBwWb12HgkQEskAVKOOBPEXt6nrLTrqw8Vd9Z2e4IAmTl+AOC334G04LrqPPrNzUc
	 c1605660oH8KtAZrOUCpdQge9+aGYC2RshjZK7x4mY+GrGBgI6mkUT+VB7OGw6VwnA
	 hvTopz55/OBEtnP7l4LqGR4iWi9pJKkk6XI9JcF6HOyONJ0F4v5viUDvSrYh9cyuvH
	 aZhQH61Wb/mLIBC9wvhymlsX+A/bc+QPCK2ekASfSeP1voKiD0x+vlypvjRUVKadL9
	 xHSS66qT/CsHQkK3xxY2DryONRBfwI8+kZYvNWa+3LaNqVm/mMviBtUwy7cVMZ+Nld
	 YR0xHviTS9Q8g==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomas Winkler <tomas.winkler@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/3] mei: gsc: remove unnecessary NULL pointer checks
Date: Thu, 29 Feb 2024 12:12:58 -0600
Message-Id: <20240229181300.352077-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229181300.352077-1-helgaas@kernel.org>
References: <20240229181300.352077-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

The .remove() and power management callbacks are never called unless
probe() has already returned success, which means it has set drvdata to a
non-NULL pointer, so "dev" can never be NULL in the other callbacks.

Remove the unnecessary checks.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/misc/mei/gsc-me.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
index 6be8f1cc052c..45c10974b12b 100644
--- a/drivers/misc/mei/gsc-me.c
+++ b/drivers/misc/mei/gsc-me.c
@@ -144,9 +144,6 @@ static void mei_gsc_remove(struct auxiliary_device *aux_dev)
 	struct mei_me_hw *hw;
 
 	dev = dev_get_drvdata(&aux_dev->dev);
-	if (!dev)
-		return;
-
 	hw = to_me_hw(dev);
 
 	mei_stop(dev);
@@ -168,9 +165,6 @@ static int __maybe_unused mei_gsc_pm_suspend(struct device *device)
 {
 	struct mei_device *dev = dev_get_drvdata(device);
 
-	if (!dev)
-		return -ENODEV;
-
 	mei_stop(dev);
 
 	mei_disable_interrupts(dev);
@@ -186,9 +180,6 @@ static int __maybe_unused mei_gsc_pm_resume(struct device *device)
 	int err;
 	struct mei_me_hw *hw;
 
-	if (!dev)
-		return -ENODEV;
-
 	hw = to_me_hw(dev);
 	aux_dev = to_auxiliary_dev(device);
 	adev = auxiliary_dev_to_mei_aux_dev(aux_dev);
@@ -211,8 +202,6 @@ static int __maybe_unused mei_gsc_pm_runtime_idle(struct device *device)
 {
 	struct mei_device *dev = dev_get_drvdata(device);
 
-	if (!dev)
-		return -ENODEV;
 	if (mei_write_is_idle(dev))
 		pm_runtime_autosuspend(device);
 
@@ -225,9 +214,6 @@ static int  __maybe_unused mei_gsc_pm_runtime_suspend(struct device *device)
 	struct mei_me_hw *hw;
 	int ret;
 
-	if (!dev)
-		return -ENODEV;
-
 	mutex_lock(&dev->device_lock);
 
 	if (mei_write_is_idle(dev)) {
@@ -252,9 +238,6 @@ static int __maybe_unused mei_gsc_pm_runtime_resume(struct device *device)
 	struct mei_me_hw *hw;
 	irqreturn_t irq_ret;
 
-	if (!dev)
-		return -ENODEV;
-
 	mutex_lock(&dev->device_lock);
 
 	hw = to_me_hw(dev);
-- 
2.34.1


