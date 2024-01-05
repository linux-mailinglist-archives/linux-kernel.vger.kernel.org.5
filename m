Return-Path: <linux-kernel+bounces-17841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0521D825378
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8ED286CDD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F3E2D05B;
	Fri,  5 Jan 2024 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E93C7Ybv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9BD2D602;
	Fri,  5 Jan 2024 12:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B481AC433C7;
	Fri,  5 Jan 2024 12:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704459086;
	bh=Z1D8rD3/nRzA4kc+dux1HvFymw8yFf5r7zYbbSNB8vU=;
	h=From:To:Cc:Subject:Date:From;
	b=E93C7YbvTXPqnqBX8lLOXPOsswyYuuh3RpwOTs9I8ScFvWdSSpMKQy+yPx3dlx7V2
	 0VH7Kitbx14G+asiFGXW5jVQMp+m86pG1AYG3ntIH9t11hCxO/SGzXDQOn1etcriFo
	 sX7K4y+oDhVgBExMg/OxR+rDCDB9c2t6j5u3ClQA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] PNP: make pnp_bus_type const
Date: Fri,  5 Jan 2024 13:51:21 +0100
Message-ID: <2024010520-joyfully-cosigner-c2a9@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 40
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=Z1D8rD3/nRzA4kc+dux1HvFymw8yFf5r7zYbbSNB8vU=; b=owGbwMvMwCRo6H6F97bub03G02pJDKnTf3voeGhLb/G84dB0Zcc8tYhlpa9mrbjotijt494+U xElvqSSjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIc0uGBZePK0Ub3b7cIRGc V5znF2jyY/mDdIY53GdaX0fHK7qwnhIXtCx+kZ3UsPUwAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
move the pnp_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pnp/driver.c | 2 +-
 include/linux/pnp.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index 46c534f6b1c9..0a5d0d8befa8 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -256,7 +256,7 @@ static const struct dev_pm_ops pnp_bus_dev_pm_ops = {
 	.restore = pnp_bus_resume,
 };
 
-struct bus_type pnp_bus_type = {
+const struct bus_type pnp_bus_type = {
 	.name    = "pnp",
 	.match   = pnp_bus_match,
 	.probe   = pnp_device_probe,
diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index 267fb8a4fb6e..ddbe7c3ca4ce 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -435,7 +435,7 @@ struct pnp_protocol {
 #define protocol_for_each_dev(protocol, dev)	\
 	list_for_each_entry(dev, &(protocol)->devices, protocol_list)
 
-extern struct bus_type pnp_bus_type;
+extern const struct bus_type pnp_bus_type;
 
 #if defined(CONFIG_PNP)
 
-- 
2.43.0


