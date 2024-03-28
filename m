Return-Path: <linux-kernel+bounces-123745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1335F890D49
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44AE91C2E01E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF551474BA;
	Thu, 28 Mar 2024 22:07:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC581474A3;
	Thu, 28 Mar 2024 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663674; cv=none; b=CtuestAtQfWCmvF+KjQRpISVTtyr+YWRLLJDvNGwDp+kSqtZysehKWWvHY2mAs9ivfq2ZfT8INaDRRrpoON3kNvVTa7a/JLHqZ9cbOC8cat3JaZT1INx2UtRGwIgeEC5APfTBJPOWeKka1vVNNgTGjF+650bNB2tyZS+QUrm0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663674; c=relaxed/simple;
	bh=vB95Z71rbz2bnBKSTkgzRLn0DNcNxFHivSw1pbRujc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VOtc4b+OIyJfvUqNA9/GtmOlwuEu8uU58VMUAfFvChZMvm09fgXJ52zrFrpuD22vcKRkVQMmFFzrbruho/RSWz3/89CBsB6tBTN2gio+J7mpssOA7Uk4DtNU7frOS5MjL6AJ8B8IxL/k72x3dyXOhj2aiqWuALVtaT0Cn0VolP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3153C433A6;
	Thu, 28 Mar 2024 22:07:52 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:17 +0100
Subject: [PATCH 39/52] USB: serial: safe_serial: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-39-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=688;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=vB95Z71rbz2bnBKSTkgzRLn0DNcNxFHivSw1pbRujc4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBend2/hXK9jv/hwaLDAKGuyJHKZ7+jteRx4IV
 oWvS5sb3uqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp3QAKCRDBN2bmhouD
 16fiD/4m5maN2BkGeIHT3hkRSRaU2jVGyDidP5N2/QvJ8rKDClOcUnH0Hy8nIz/2R56mI+gGhYd
 TGR2Cc+GPtRU7IFcui9fRfwWmi9DPAS4wIdC4089ZBywJWqXbF1FPiHTsXb2b3/Ot5Pbem5Pagr
 l3bkAXkpwUWWLBkoQJ/cwkQHbfFL0guRDPU/bNFmERJRvJGcOb0cTrIgp9dCV50A3VfCgNofmLt
 ILIMxgdI0KlVxb1Lu1Dif57QV+lVQjBQdTcqIN+9trf8WNr+t1RVY14nekD0lQIsvmwJMeQOKHR
 uE5504RwdsDXGRwoibRAGWQyymRCHULuvcXq2FsYIApzf2yN5EvjJ3byGNLGrQw83CawOl4BQCG
 7ELGIPl4uJcC26BQMynHgpsccv3nLkxrlRTwMzXrmrEIzzSnm9aWqjLSeYaODIRqNB0EyiTPiTv
 xLg1js6Bh8zt6UaadC+fKPcX7gA4Nt9p9ie71qerWu/xj4cZyJSTr+9DHUmTmKth8SZ2YHfIR5g
 CDZ9cpbctUlOLEZlkM7W+oCKSG2dkAvTkLrKFO/C7jqk02IOwt846GGPoQ8XugLkcvy5Rtd4TVX
 pl7zSEw9EeYCbGPNPh57PsTfErgtqAdyOq+Pt8jmyLwOuqLn8bO0Na8ASLtD7sgyW3HQEWinCAT
 fwQEhNvwevvUPLA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/safe_serial.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/safe_serial.c b/drivers/usb/serial/safe_serial.c
index 6accbecb6318..238b54993446 100644
--- a/drivers/usb/serial/safe_serial.c
+++ b/drivers/usb/serial/safe_serial.c
@@ -284,7 +284,6 @@ static int safe_startup(struct usb_serial *serial)
 
 static struct usb_serial_driver safe_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"safe_serial",
 	},
 	.id_table =		id_table,

-- 
2.34.1


