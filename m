Return-Path: <linux-kernel+bounces-93052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE767872A23
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08421C220C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F082212DD99;
	Tue,  5 Mar 2024 22:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gnupJWDc"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCA712D21C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 22:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677326; cv=none; b=lMoEwYhhRAFmizzufNm5qw1VWFP976hKxt1QId7cqt3ZBj8Ffv7UFOFSHOdnmBgfAXIQoFsxxEj+erb5RgeS8TJWgwm8H8bWzMF1N0Rc5AbVatREhvv2FURFsJpy/TuB4D6GrLjbLbA+psn6LyLWSwHbelrwxg0Vw/E2FvQ9sQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677326; c=relaxed/simple;
	bh=ueJ7QuGdrFeDy9rt+nAOirnh5rRQTBpmmXZN2CyaBvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rVMcI5Nn39eqoyHWeYrSESCb87pc5N19EaJc4+isHwN6eTjrXfQnRCLIYxxfCSa1M1KrMxTDzg+S5VahR/ur04Mzcff6SFpyxffEUbPU/fy2c6ozQwvLq4+ucjlRTC8SZLCcOlbBXxe7BrqnDv76OFRUyCcS+6nqrVyLTCeeYB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gnupJWDc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709677323;
	bh=ueJ7QuGdrFeDy9rt+nAOirnh5rRQTBpmmXZN2CyaBvo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gnupJWDcNFoB36925/ihi/i+LnyCE75fEmpr1Sakh3nLN4R6/mQzcdiCmlYeyrkFz
	 Y7foQZut5Xhz9fByaqxguV8w0ZkMM7zmmWz0RTcYbqQ5ERsFC2o3cEO5C4f7cMQa4T
	 LlR747HjtiY41JP0C50pKaeeSUrufQynfTwcm0TGi7QWpJPrlbtMYqMIaNwElK33Oe
	 SF42KdOm8PmeLgVGIsaJhOL5bz6JKoKVKkarT43h06OPU7MXb/t3RvVJGTnS+PAmip
	 mKMCsLhmeeLQiW19zvkVOn7V8iAM7G3wtwljKG2cLVlS8kc2KNBAztvEVD/gwtI/LE
	 57ubmy3VmKxDg==
Received: from [192.168.1.241] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 427413781FCE;
	Tue,  5 Mar 2024 22:22:02 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 05 Mar 2024 17:21:38 -0500
Subject: [PATCH 3/3] device: core: Log warning for devices pending deferred
 probe on timeout
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240305-device-probe-error-v1-3-a06d8722bf19@collabora.com>
References: <20240305-device-probe-error-v1-0-a06d8722bf19@collabora.com>
In-Reply-To: <20240305-device-probe-error-v1-0-a06d8722bf19@collabora.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Once the deferred probe timeout has elapsed it is very likely that the
devices that are still deferring probe won't ever be probed. Therefore
log the defer probe pending reason at the warning level instead to bring
attention to the issue.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/base/dd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index d6e7933e2521..83d352394fdf 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -313,7 +313,7 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
 
 	mutex_lock(&deferred_probe_mutex);
 	list_for_each_entry(p, &deferred_probe_pending_list, deferred_probe)
-		dev_info(p->device, "deferred probe pending: %s", p->deferred_probe_reason ?: "(reason unknown)\n");
+		dev_warn(p->device, "deferred probe pending: %s", p->deferred_probe_reason ?: "(reason unknown)\n");
 	mutex_unlock(&deferred_probe_mutex);
 
 	fw_devlink_probing_done();

-- 
2.44.0


