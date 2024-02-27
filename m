Return-Path: <linux-kernel+bounces-82951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ED2868C28
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A906B2B1E6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF83137C49;
	Tue, 27 Feb 2024 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQvw8YpI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7509C136991;
	Tue, 27 Feb 2024 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025880; cv=none; b=HDLHTxyKejLBjoIbDmHD0a5BM803Uzia5xIEa9ZtZ1J+4rWIdAjXhD2dt4hO8gcMliDsWWhvHEV4sBNzUObdkKsCdg/u8cz3IFgke3pcZPSTHq0TblPvqEp24YswzQz8xhHzfQ1i6ecXN5WW6Ix0t5CBJJNM/C0LOQ9YkwrYDmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025880; c=relaxed/simple;
	bh=508DhFAqXr8/FZ4dv70h/hSD4v7ugc/f9K6ffAa4qs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X+GvWK5y4JiTpgkADDhP+2d6vw7QhTPa/n7UPEz0RWR2ZVO08pCxMshx6Hw9NZbVL756e07kMyOMMex5C+0+rk3/HlND30+e4DuYxN97m17IHigKJkKbqNLNyjQNguLaXNGkK7YWeHTozM1sdGRHyvp9Ev9QQb9Eoft2M9VhBGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQvw8YpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769E2C43390;
	Tue, 27 Feb 2024 09:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709025880;
	bh=508DhFAqXr8/FZ4dv70h/hSD4v7ugc/f9K6ffAa4qs8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nQvw8YpIokRwsNAo+X2jG5eRsQ+mlTqm8/IeSJD2f6W/O3NzWVgaVHMXhavUOKDAs
	 hLy+CHwq97ay9Of6xK5ubZI6Tc7aCg4lwczoyn2gA1P33QiMs2AxqP1mc4uei5ycCs
	 4cUmAXDEDEn8JpZWCzA5v5bvfGyJuhlqU+xUx1U7zBLhTnHq9PaqxJFp4whtejjyYD
	 qFTaodDVMkdOL3qQna1QVl1ztp3kaAnNIJrhriaBCXTnmlIugbq/gzhqE1UcMj+GgU
	 fiVVjc6zrjNKbaiT+AOtG4MRPm7txZwfuz95Sgws0nSAOtgu4TzywayM1wVFdAWbqx
	 l10v48Uma/hVQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 27 Feb 2024 11:23:49 +0200
Subject: [PATCH v4 2/4] usb: dwc3-am62: Disable wakeup at remove
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-for-v6-9-am62-usb-errata-3-0-v4-2-0ada8ddb0767@kernel.org>
References: <20240227-for-v6-9-am62-usb-errata-3-0-v4-0-0ada8ddb0767@kernel.org>
In-Reply-To: <20240227-for-v6-9-am62-usb-errata-3-0-v4-0-0ada8ddb0767@kernel.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: nm@ti.com, r-gunasekaran@ti.com, afd@ti.com, b-liu@ti.com, srk@ti.com, 
 francesco@dolcini.it, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=508DhFAqXr8/FZ4dv70h/hSD4v7ugc/f9K6ffAa4qs8=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl3apLOCYkR3mS3D/aWVbUo8XqBYLz9ubOfkAr3
 VwCTP3jJD2JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZd2qSwAKCRDSWmvTvnYw
 k64QEADCg1dvBEPiw/OX6Y41G0KgglDLO7P8jV8uSE1TODgD86cvL+J71RWxTtxB/u8bmc29mxu
 ZTpHv4h9RagyO3FFdfqn6qkr9F27DPsmW3X+yKwjnfI5AivOH6t2El0V6bxjk8kEUUYlbgsVJmK
 0R8pdwqcm3KcWcnO77GiwjQ4hByZlhp91X1HIrALw1pVZKVpmY/FWYKt7Kyg+r5beBgTQEuCwDS
 Og+0X98VqkiTohYaBODctgH9tq2SPvEADaMSoSRX2zLNm5AoVGqQiY+5ST7dWjTsJ/DpjemxoUl
 1SPUzIL3B7GFoo+Wa3qjeXPbt6W11h6IaB3hFgKfMLOZujVHmUPzl80fYZbdtSW8nr336mmu5Ep
 kmqco0ewtitUxueeKEelLH6N04vHTszwHlJz2WNMIDSYCwiHTp7rmeDzmezypY4hg4aP3eHuuQa
 ev65oZSrAMT5Db+7DJKHgf7pNExD1JMpwrO1KDPj69II4VCxJceexzt1z1h3MqtceZp4aNFT2wB
 BTOzoPsZCsFy9a+tgW6bHlJ8bqFSXyzFVG/zkMv5Dz5NnxJGkahPbn4nzuHI1rsLE0c2Csjaesr
 d8y45gYR/2do6AxtwfLga0oVBWSJUyoI/xRvcWEIs12M1wG+c7eJonhNcVDnv0aTp5FMqc5d7bM
 baDIrrdSE4yZoaA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Disable wakeup at remove.
Fixes the below warnings on module unload and reload.

> dwc3-am62 f900000.dwc3-usb: couldn't enable device as a wakeup source: -17
> dwc3-am62 f910000.dwc3-usb: couldn't enable device as a wakeup source: -17

Fixes: 4e3972b589da ("usb: dwc3-am62: Enable as a wakeup source by default")
Cc:  <stable@vger.kernel.org> # v6.4+
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changelog:
v4 - new patch. split out from v3 patch 2.
---
 drivers/usb/dwc3/dwc3-am62.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index f85603b7f7c5..ea6e29091c0c 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -274,6 +274,7 @@ static void dwc3_ti_remove(struct platform_device *pdev)
 	u32 reg;
 
 	pm_runtime_get_sync(dev);
+	device_init_wakeup(dev, false);
 	of_platform_depopulate(dev);
 
 	/* Clear mode valid bit */

-- 
2.34.1


