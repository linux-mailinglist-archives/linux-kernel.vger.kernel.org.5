Return-Path: <linux-kernel+bounces-63423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD3C852F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51826B2319B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F06D42075;
	Tue, 13 Feb 2024 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2PzkbqT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B0241A8D;
	Tue, 13 Feb 2024 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823275; cv=none; b=ghrILomsBCtAzwp478HgwupW1rviUJRtXtHYW053+H+yl9gySQ8rgZUHS1ne9BpKKCbYVNrvHqC5MInZjvEK1x9M9h7KPEEJMOx7BDhK+OjxmNQKp6heWqCDEKhP+zSPRtjm59WNJ9+lwiyaX7LCzNcbpo/mlSVyhN5sfVplAGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823275; c=relaxed/simple;
	bh=aIolLqLqC/bcDMHyNhQznYMvDY5tSLws2Dm32ULRu6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVNaot8kyjfzDUGAVyX3XRxeYxuTeMSfHFqL/PZnD/uZuSKo9/UNj46ZeX1fIVe7NvT6cef/X4A2T29O2l582cV7gkJy6xNfnGEFJk2fXycPeHMAcEKiSOJ1/IfK7cuZYNFHcB2kD8BD2PbFLqVFwCbOdhhpYVv3O6jKOQ/NqpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2PzkbqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6C6C43330;
	Tue, 13 Feb 2024 11:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707823275;
	bh=aIolLqLqC/bcDMHyNhQznYMvDY5tSLws2Dm32ULRu6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2PzkbqTLskgujKP0PKcKdywI/RCRDveMxFtuISmptb634zEmqNFJ8ouOuMVCTndN
	 x0mXPvlw+RtzkSzm5OWagRFZPlqFd2YZipn6VbFzmfWFEzv5gZ0dM7QJF17rks3BWs
	 DzGnC2bE3D4R13fwZ2CQqrmRNJwrCNCsp0NlIMlaIZ5dtp+vLl8XSniAMAO94Stdcu
	 U/IWDJecQvUdpPKSGPB7IeYaAWTcuISEjoFjVMotzHcAwiAv3Hzhthw5SImQo/X4gI
	 CQZx6tYQgkmH+GIduJJ/c4btxEPxvhg+Kf1hZFmTQg9b/LbuGotV5xkaFeXkveeD76
	 9gd6L39Hg4K8Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: bp@alien8.de
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org
Subject: [PATCH 6/7] EDAC: Remove edac_pci_ctl_info::complete
Date: Tue, 13 Feb 2024 12:20:50 +0100
Message-ID: <20240213112051.27715-7-jirislaby@kernel.org>
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

edac_pci_ctl_info::complete is not used since commit 458e5ff13e1b (edac:
core: remove completion-wait for complete with rcu_barrier). Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Robert Richter <rric@kernel.org>
Cc: linux-edac@vger.kernel.org
---
 drivers/edac/edac_pci.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/edac/edac_pci.h b/drivers/edac/edac_pci.h
index 4159a3ef0dbf..3f47cd9b2b03 100644
--- a/drivers/edac/edac_pci.h
+++ b/drivers/edac/edac_pci.h
@@ -22,7 +22,6 @@
 #ifndef _EDAC_PCI_H_
 #define _EDAC_PCI_H_
 
-#include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/edac.h>
 #include <linux/kobject.h>
@@ -70,8 +69,6 @@ struct edac_pci_ctl_info {
 
 	unsigned long start_time;	/* edac_pci load start time (jiffies) */
 
-	struct completion complete;
-
 	/* sysfs top name under 'edac' directory
 	 * and instance name:
 	 *      cpu/cpu0/...
-- 
2.43.1


