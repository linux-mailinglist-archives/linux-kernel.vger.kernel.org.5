Return-Path: <linux-kernel+bounces-63424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D42CA852F10
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 611F3B26041
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ED646551;
	Tue, 13 Feb 2024 11:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+eoeyo8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE46A4207F;
	Tue, 13 Feb 2024 11:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823277; cv=none; b=khCTZW20Jx/2Wv76gZBGp/bSnwlciV4P4IjggELIm958+9KyXpGq2MM9ltjWSe2J3FQIl/QErpzP3yrEcvmCa3DVULAQcJvTESQfPl2RGl/lSUQnaIidjn2nuXhA+sBrFSX5vXMwKSZop3GOKVU7BARuc9t0678pHr6ZOQ9oN1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823277; c=relaxed/simple;
	bh=7rlQVPPK7OWucwtWFQVrtA/YfOz50z1TLi70ClXddQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAZx+N8ZByHEF877C9+p9j0WMkBM26SrUbnh1RgRDPXenyDXxWP7MGaGYrV7lE/7T+C5QKbUcr/eJtC96RneV4TvUwRvPyLVBbVKwI6un5vPxo8/+Qos8DzyOoS+8nQG0ToC8bIEmPtx03d4+UhILjLGZN73bZFl96QFgkYAsLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+eoeyo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7090C433F1;
	Tue, 13 Feb 2024 11:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707823277;
	bh=7rlQVPPK7OWucwtWFQVrtA/YfOz50z1TLi70ClXddQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P+eoeyo8+EWkWQ8iVcrW/PdgpU6Ow3aBa+JsUCKn0gcW5uNeJcysOzrcwj/qPBcn8
	 4YpLbDsrtiRPGHm9ajOlVLtl3K2W2gQ3zQsPPqhK6X8DCDt99GXc7pObMpMo1KfAi0
	 5Ptglt8ppj9ZvePTpK5EddOq5P3D3HNnWyqe5U+MPWIkAmmDXgwFlJ2+bd9kEfWMGU
	 eEO8Hlms9K/ODkjyPfT07pmWtQG67c3BtyPXJdoev4JWEG1VwdnEyyfxdfWpBFydoX
	 Jyu3LZtcl1Osc33O8UM8njyihlYAClFsCaxweBOgNVdW1N2jn8mWB/GzjiChUKJI38
	 LdPvpGysTzU/w==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: bp@alien8.de
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org
Subject: [PATCH 7/7] EDAC: Remove edac_device_ctl_info::removal_complete
Date: Tue, 13 Feb 2024 12:20:51 +0100
Message-ID: <20240213112051.27715-8-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213112051.27715-1-jirislaby@kernel.org>
References: <20240213112051.27715-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

edac_device_ctl_info::removal_complete is not used since commit
458e5ff13e1b (edac: core: remove completion-wait for complete with
rcu_barrier). Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Robert Richter <rric@kernel.org>
Cc: linux-edac@vger.kernel.org
---
 drivers/edac/edac_device.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index 55be019c12ca..034711d71ebf 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -22,7 +22,6 @@
 #ifndef _EDAC_DEVICE_H_
 #define _EDAC_DEVICE_H_
 
-#include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/edac.h>
 #include <linux/kobject.h>
@@ -191,8 +190,6 @@ struct edac_device_ctl_info {
 
 	unsigned long start_time;	/* edac_device load start time (jiffies) */
 
-	struct completion removal_complete;
-
 	/* sysfs top name under 'edac' directory
 	 * and instance name:
 	 *      cpu/cpu0/...
-- 
2.43.1


