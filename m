Return-Path: <linux-kernel+bounces-123738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2797F890D37
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598CB1C304E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093E6145FF4;
	Thu, 28 Mar 2024 22:07:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C771145FE0;
	Thu, 28 Mar 2024 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663661; cv=none; b=pUAW1x4SjmBqLg9xrxS0NXU0/z6VMs3macfZZ0+HlvkJ1ZFbrCkKysZj3m6U+tsRWqd+TWUbIMyLOkqFiUA60Z+ayqwjhwuCf2+N4k6ZQB1hK1V5nrN48/LA5VvrIssIQ24LsYJTE9W3cD8RgLKGqblrz9ScDZcjCMN9egFZZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663661; c=relaxed/simple;
	bh=nxoYLEe/N6OE4oKhVnw0IduSefBP5qNPPdhZj4nUgv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cyurSyFZpBkWoVSVQe0lIwmUlGZEufkghoMg6T0FAkXGpiRyOcr+E/4ChD4p+Tdnvhlcjr8iza0aB94HSgBkRu8un3cWEJJHjVaWVnB3x/2YCGkEQ+WJyTcFhDMzcmuNJuj55yqvQcVFd7JbrSyIHsCPiwfwu+y36ziqRkNdmDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5227AC433C7;
	Thu, 28 Mar 2024 22:07:40 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:11 +0100
Subject: [PATCH 33/52] USB: serial: option: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-33-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=676;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=nxoYLEe/N6OE4oKhVnw0IduSefBP5qNPPdhZj4nUgv0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenXDnCwk1t7SRk3Pcojjz0st/2G4JcsH322i
 Xu4NuMLDXiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp1wAKCRDBN2bmhouD
 19nVD/9Id+rT/FIsS2isvGUcHK0fqQ7ShBrwT6dBKQ02Sg46Y/ak5LNcA2wM0FsQwqvqVsyd/IM
 VW6gn3ClR5Gu2V2bn6+PZaKaf5J7TFHCD45hHPlaQRWPmxptCfcOo6KrxHYbZUNidiNyG2wQjuB
 /7Uiao71JxZWyH6HgBgbkPASUk9JD+QnYMlf1E5OdSw3Ux/wARuv1I8XFJt/LTSrmYHA+ICahiA
 Y08Rt/xB+4v3XwuL4OQjA6la69McIcFyQu3+hWapdONQpPg611WnqBwJZXc9vkJJy+ngRveDoXQ
 H4hgzMF8w8bhL73HGOun1gEqRd2TY1K2fXD8c9MjTuFxScCyrw6to3jdX0VbtYeDBoLTS/urrM/
 6/Rl75OhnZU4qEwTvzV3ad+VdjPmKx90P8noa2yeBLJwBz/6AK9ZHUVsy3bXi+4+/XOst/N+lz8
 4MJaoChP9sV7X9uyoPp7gZFekAPKMIX4S7zjV302Qh6gQmZG+n3YlXfucgESPRecrA0O4IVw7z1
 zs2/VC0KxJ2JMvylDTvxuY2LmwTAuzkX9BJQFj5qtxUXHgxWbtASumASfaP8tLzNkwLFJN4EAWr
 7PX7kYcdjhUd804dLgcRCvxAeNThY7/nxlvU2oIoADP3hYHbnsN7AHHw7C1bLGj9rvcjHe84Mjr
 g1maMws1ldUZeDA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/option.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 55a65d941ccb..d1598d665a5c 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2298,7 +2298,6 @@ MODULE_DEVICE_TABLE(usb, option_ids);
 
 static struct usb_serial_driver option_1port_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"option1",
 	},
 	.description       = "GSM modem (1-port)",

-- 
2.34.1


