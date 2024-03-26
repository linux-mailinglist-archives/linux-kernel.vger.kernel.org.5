Return-Path: <linux-kernel+bounces-119094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8C888C418
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578B22E68AE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2002775806;
	Tue, 26 Mar 2024 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TlcMFjDS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67BE74BF3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460903; cv=none; b=lA/hx3n+dBBKkyFNT3INs5OUjZ/B9wfF6EcXePxcVEOt8V6sS01LtXOWuopaqXF5EebTPq1kck76aL1E6JXrPvW0nSZqhPJM87Utw5abP/YULq+4Sz1J49iC5mHspnmYM2u6e9SA1aXmf9P9CnaCHQeCYDe+Xlt6LAyq0IR1afA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460903; c=relaxed/simple;
	bh=gPfgKHrLxGr1W7vHRNerursGf2x5MRa0hohrvEmjeMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qwLONXVAAtRXftW0BsZN9W3T5/+dGOVGV2EIUDPKVAIfoMRR4EYyLirr8ntWP5l2azkXDtRd4zUmyXPT5xr0q16OZH7oF1yMg+VyObLQojc0PNqhnWe91dkxWhyO7ewjW9uYLONVjcqykVFBxM5p5V/vWzxG3BhlpZLJvBxnnp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TlcMFjDS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711460899;
	bh=gPfgKHrLxGr1W7vHRNerursGf2x5MRa0hohrvEmjeMM=;
	h=From:To:Cc:Subject:Date:From;
	b=TlcMFjDSLP8yhGW+GNHoCFs6ORFRZ6iRq3BRiOmDhY0NSKEPoKFTaSIx0EtzFArx8
	 viQjo4PM0nx6k9qgT3/jCsKY5GCfnq6XESWboh7HsrMAV1mlXs7X9FpzK3ttLohj0X
	 eqJS3dTZP8fUCWVvfbuyUwQ5h91jRv/ioR/g5JTXwSPjSJZn1nH8v0f3Bz31J5jtP2
	 ayfPAQR9vL4SMwPsayUFAIk4fR3Q5rB9gscQr5eXZQ4ZcSUDmAKnAkgmRpwNHwkIGo
	 TJ1vFXx8fX2FrDmd/E56N+SIEzOedG6mNwb3ox2zNdsSctGGCLap4NL5pmGacIHgcj
	 /YYBWVZS1DlGw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6AF1837810C0;
	Tue, 26 Mar 2024 13:48:19 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: kernel@collabora.com,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ABI: sysfs-driver-panfrost-profiling: fix indentation problem
Date: Tue, 26 Mar 2024 13:48:10 +0000
Message-ID: <20240326134812.4008775-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Also add a newline character at the end of the last one.

Fixes: b12f3ea7c188 ("drm/panfrost: Replace fdinfo's profiling debugfs knob with sysfs")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/dri-devel/20240326160110.4c00e1e5@canb.auug.org.au/
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 Documentation/ABI/testing/sysfs-driver-panfrost-profiling | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-panfrost-profiling b/Documentation/ABI/testing/sysfs-driver-panfrost-profiling
index 1d8bb0978920..7597c420e54b 100644
--- a/Documentation/ABI/testing/sysfs-driver-panfrost-profiling
+++ b/Documentation/ABI/testing/sysfs-driver-panfrost-profiling
@@ -7,4 +7,4 @@ Description:
 		Valid values are:
 		0: Don't enable fdinfo job profiling sources.
 		1: Enable fdinfo job profiling sources, this enables both the GPU's
-		   timestamp and cycle counter registers.
\ No newline at end of file
+		timestamp and cycle counter registers.
-- 
2.43.0


