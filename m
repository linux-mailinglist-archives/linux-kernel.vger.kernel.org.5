Return-Path: <linux-kernel+bounces-126024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EFA89310F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 11:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9301F21A8E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D806878B49;
	Sun, 31 Mar 2024 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQkVLCGO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279E377F2F;
	Sun, 31 Mar 2024 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711876672; cv=none; b=UKWHf/PufJyRS56SA5QJzE95Qm6bTlpfa3ov/aWNi1jKvghVHwA6+ImySzMOP4ioNhucWLHIXPrm+TBwubjDLet37rWwh49KpsELPtMj3Ij4UodjsIZH+xOKXDtbW22EJ7d1ESSdq3MJsUDiqQvoj6ITG4Uzp1ejdtSUtLZGzHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711876672; c=relaxed/simple;
	bh=ZvMc1elPVJhE6Ny4UYVuUqULOUmKNl8y6zwFM7uGIh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WiCHBUXinBNUvNFhpLvpEOk4DOQpqxwq4qaqUURGm/WDRERp3PyMoM3zYZz53779gyPuLmdT4/IjElKfJHeWJu8Z0vmAiC/9sT4plQLGhhzNVN4+G07yCEUH9AFOh8vUQ84OoWEodzKCVHmM6KA5mcC6CUu7QUEV1jHFHPdt3js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQkVLCGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE181C433F1;
	Sun, 31 Mar 2024 09:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711876671;
	bh=ZvMc1elPVJhE6Ny4UYVuUqULOUmKNl8y6zwFM7uGIh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQkVLCGOR+WxOkbH46DMO6r6z5ar9wO2q1mTyCjAVRjUUH3IpKiL4Lc4RF3kMDTM3
	 horj/O3zCC8wl442itIeiUgeHhDXDJGaOwZ45aB/2DsPZTAhGcTOK4K88TtC9Dvk82
	 aint35VjVXD1MKD3mCSTrZGRQzaug7otAAHHjWDt6awFgQbyUttuZGFCfUF+7Kmtwf
	 TFjHYnnUfE4DcTR0oHMAvQHUH4ePtBwzBD7Q3ov6uKNcfkLTwCwPIM+i18Ku8CuTGV
	 S18hiZYYbYemuMJw+vWK1dYdtBR0v6VPCGlT9V3j4sIi6gqwpcxdXvmECdAt5JIYXs
	 8IYYAsz55DVwg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ran Wang <ran.wang_1@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 3/3] usb: typec: displayport: drop driver owner assignment
Date: Sun, 31 Mar 2024 11:17:37 +0200
Message-Id: <20240331091737.19836-3-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240331091737.19836-1-krzk@kernel.org>
References: <20240331091737.19836-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in typec_altmode_register_driver() already sets the .owner, so
driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes in v2:
1. New patch
---
 drivers/usb/typec/altmodes/displayport.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 038dc51f429d..596cd4806018 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -802,7 +802,6 @@ static struct typec_altmode_driver dp_altmode_driver = {
 	.remove = dp_altmode_remove,
 	.driver = {
 		.name = "typec_displayport",
-		.owner = THIS_MODULE,
 		.dev_groups = displayport_groups,
 	},
 };
-- 
2.34.1


