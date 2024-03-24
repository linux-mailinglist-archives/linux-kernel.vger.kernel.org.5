Return-Path: <linux-kernel+bounces-113188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D1A888229
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB821C22455
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DB7178CF1;
	Sun, 24 Mar 2024 22:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxsHbRC0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8AA178CCF;
	Sun, 24 Mar 2024 22:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319991; cv=none; b=d4E3gEKCAko/PiXTHqY+UluoQAykzqYvWC6oT5HnMLzrMUilCkiyx3TLwMLoP7kADKbmT6dP8YHXUcFVvl1rp8+FRQ5JqVE+IuwP5zfPwFqmYYTBxjBGK3Chuf2rF+OUyQjgnTWsZq/qI2s7JXsa1EXdRBU/G2hqQKabtmSX4Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319991; c=relaxed/simple;
	bh=3IZlNOzBqHQHY4gQvWgHcGXr5SgHDQHzF++1kUXuWEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRaOSAITMB+6asD63D1qe8Qf0MIXjGJkRh80UhsYgcKBCljm6qLaAUCzp08hxWAPRNQDFFRjugb9UOuPm7n9YYQmi7EQq5NpNFFKFkG0COsgXUwSCTXnuddtTeYcl2NQbB8/VvXPvzps4plq9xBj/uXQARpJMwNvq2Tyb6QgE4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxsHbRC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8419EC433F1;
	Sun, 24 Mar 2024 22:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319991;
	bh=3IZlNOzBqHQHY4gQvWgHcGXr5SgHDQHzF++1kUXuWEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GxsHbRC0ORk50Gr5c1nJyJvSwmVTZNOXwdmuRSL5uuhmY4JL4Sy7DnTupEAaFu+P0
	 823zcy0pI54mtBp2YZyabgPhW2bbykILbDkbdDVF8n7PZ/K0hJ1mTITpSZQvF9192H
	 WN4lKwGvmXwOB/nMRGuhvFLMFMh/96k9/TxPyeQ/pEfuIZycVU0THCq79R01k90V9Q
	 /Pg7NKhoR1tsdKYBMqzdQQeoU/kigDdDF7488Fjo0lsPsTdsxXG7a5ywc/Ry8OtWwc
	 1C9Kghq3cBF9V1GzwVZeOc7oBpTVZ3Q2d5jFS0AwbVqFuSfcDfuJytN2JOIAUZZqGT
	 tytkB9wB0nHKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 297/715] iommu: Add static iommu_ops->release_domain
Date: Sun, 24 Mar 2024 18:27:56 -0400
Message-ID: <20240324223455.1342824-298-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 0061ffe289e19caabeea8103e69cb0f1896e34d8 ]

The current device_release callback for individual iommu drivers does the
following:

1) Silent IOMMU DMA translation: It detaches any existing domain from the
   device and puts it into a blocking state (some drivers might use the
   identity state).
2) Resource release: It releases resources allocated during the
   device_probe callback and restores the device to its pre-probe state.

Step 1 is challenging for individual iommu drivers because each must check
if a domain is already attached to the device. Additionally, if a deferred
attach never occurred, the device_release should avoid modifying hardware
configuration regardless of the reason for its call.

To simplify this process, introduce a static release_domain within the
iommu_ops structure. It can be either a blocking or identity domain
depending on the iommu hardware. The iommu core will decide whether to
attach this domain before the device_release callback, eliminating the
need for repetitive code in various drivers.

Consequently, the device_release callback can focus solely on the opposite
operations of device_probe, including releasing all resources allocated
during that callback.

Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240305013305.204605-2-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Stable-dep-of: 81e921fd3216 ("iommu/vt-d: Fix NULL domain on device release")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommu.c | 19 +++++++++++++++----
 include/linux/iommu.h |  1 +
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d14413916f93a..cd1210026ac53 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -463,13 +463,24 @@ static void iommu_deinit_device(struct device *dev)
 
 	/*
 	 * release_device() must stop using any attached domain on the device.
-	 * If there are still other devices in the group they are not effected
+	 * If there are still other devices in the group, they are not affected
 	 * by this callback.
 	 *
-	 * The IOMMU driver must set the device to either an identity or
-	 * blocking translation and stop using any domain pointer, as it is
-	 * going to be freed.
+	 * If the iommu driver provides release_domain, the core code ensures
+	 * that domain is attached prior to calling release_device. Drivers can
+	 * use this to enforce a translation on the idle iommu. Typically, the
+	 * global static blocked_domain is a good choice.
+	 *
+	 * Otherwise, the iommu driver must set the device to either an identity
+	 * or a blocking translation in release_device() and stop using any
+	 * domain pointer, as it is going to be freed.
+	 *
+	 * Regardless, if a delayed attach never occurred, then the release
+	 * should still avoid touching any hardware configuration either.
 	 */
+	if (!dev->iommu->attach_deferred && ops->release_domain)
+		ops->release_domain->ops->attach_dev(ops->release_domain, dev);
+
 	if (ops->release_device)
 		ops->release_device(dev);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e27cb3a3be99..c948289f64d08 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -487,6 +487,7 @@ struct iommu_ops {
 	struct module *owner;
 	struct iommu_domain *identity_domain;
 	struct iommu_domain *blocked_domain;
+	struct iommu_domain *release_domain;
 	struct iommu_domain *default_domain;
 };
 
-- 
2.43.0


