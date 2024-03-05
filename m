Return-Path: <linux-kernel+bounces-93050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE379872A21
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 354E7B2634A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3380C12D20C;
	Tue,  5 Mar 2024 22:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dwLCmJGq"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0726D8F5B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677323; cv=none; b=SVYMklj+ZdQRVPiHlL07C7DzxFsCmapAe/KEIAcVQ9jXzW+DQjHkCCebUdw3Q69RI+xbUZ4YVM0hBnHmfxhOKY5ftYzFcBjOvLsuPdbDPnEXEXIeovhsaf3KGngJfWlOdtk3Iqih9fhh5UsMV0/xEDAUxOL16qizKZ5PGmhLOz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677323; c=relaxed/simple;
	bh=y1/vGn2yIX/dLhzLAE0Ukdc4XMhIZMZnvnOhZTS8K80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NU3LAFssIyxhrpU8JfxJc8+ym1y0L0jv713zcxa5XwTJynmuQ2TBQd0UD9Cg/a8d8ZexcnQpUUqrk0H1POy0bbXtZchB+audJG93LnnPRnkTX9ZLOl8iitycgKapdd6PP6r3ANUIyGpn6NViwjcmHYzmE1gUhUZBZdtet9AlLBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dwLCmJGq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709677320;
	bh=y1/vGn2yIX/dLhzLAE0Ukdc4XMhIZMZnvnOhZTS8K80=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dwLCmJGqky+gKuTBc5IimZaDkvq5zh4OcaQCf9tQUsDNFAhhdQv4WQgXxEdHadiNZ
	 7/ZiGIFTyZ4oC9Htphq3Wb+nOg4LiseJ85kusRxliOyOI9/mz/Pnyqqfl7otiSr2nI
	 3GstyPzmOEWoAJo1EMK74+ABASBfZnE82bnQKntfk3Ox0vuj962p8IWVZbTwfKrbnv
	 NOrQ0U6JsYKPVahMAEcSYPVZ8sldvpuozyYa9go0W79u37nTFTPVNP4jl8l/hWxYmD
	 SAolCGErVwlexMvRi/dSx+OJJmQrEDu72G6CskXfMqpxJNr6Y696iv4DBBxzEGKbVh
	 gUDLlD5X4p+Pw==
Received: from [192.168.1.241] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 17AB23782066;
	Tue,  5 Mar 2024 22:21:58 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 05 Mar 2024 17:21:36 -0500
Subject: [PATCH 1/3] driver: core: Log probe failure as error and with
 device metadata
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240305-device-probe-error-v1-1-a06d8722bf19@collabora.com>
References: <20240305-device-probe-error-v1-0-a06d8722bf19@collabora.com>
In-Reply-To: <20240305-device-probe-error-v1-0-a06d8722bf19@collabora.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Drivers can return -ENODEV or -ENXIO from their probe to reject a device
match, and return -EPROBE_DEFER if probe should be retried. Any other
error code is not expected during normal behavior and indicates an
issue occurred, so it should be logged at the error level.

Also make use of the device variant, dev_err(), so that the device
metadata is attached to the log message.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/base/dd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 85152537dbf1..0b7cf4516796 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -592,8 +592,8 @@ static int call_driver_probe(struct device *dev, struct device_driver *drv)
 		break;
 	default:
 		/* driver matched but the probe failed */
-		pr_warn("%s: probe of %s failed with error %d\n",
-			drv->name, dev_name(dev), ret);
+		dev_err(dev, "probe with driver %s failed with error %d\n",
+			drv->name, ret);
 		break;
 	}
 

-- 
2.44.0


