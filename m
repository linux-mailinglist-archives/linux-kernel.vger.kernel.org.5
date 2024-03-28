Return-Path: <linux-kernel+bounces-123725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A12890D1B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367D71C29EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131E4142909;
	Thu, 28 Mar 2024 22:07:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9880F1428F2;
	Thu, 28 Mar 2024 22:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663634; cv=none; b=aM2cEtoRpd/93EnYSC3JUPP+DkFybsGsV/2E6IdJjhXU3Nn1OgoAZm3P1vY89GMpwdO9nSkVZDuwf72Tw9VATrNpYtDpDGH3JCv1B9vzQcdzJaQxuEQOUtI19XZE8KjuiijfndBLrQfS/2/i8Mb/JDVtNaxGXPO/Pq53wLFjVpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663634; c=relaxed/simple;
	bh=WP1fYPihaLOAcyC5JyqmHg6KPBQcrWXaCtzzWuOk2Vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SEl4YUaIoEpighsDbf3RxazQPwSWk5ZbqZ9xnnDqOHbB5O1OlEioI/nxYvEai9T4xaA2I/yRsjO0d1WLLgeNciubwAbqH2Vn/tLIaJbOkUuXu1Ea6s4b4tz+Ke/2x+GZcmLirx6HHwtJFJigJeyFv73beo+tA1WnFToYykb4GLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0EFC43394;
	Thu, 28 Mar 2024 22:07:13 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:05:58 +0100
Subject: [PATCH 20/52] USB: serial: iuu: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-20-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=710;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=WP1fYPihaLOAcyC5JyqmHg6KPBQcrWXaCtzzWuOk2Vw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenMJmsVsEK1tHE3Lpjg4yT1WmGhjR3qJKhWO
 CP27HRbcqWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpzAAKCRDBN2bmhouD
 1w9UD/4jvd4vvfI3vBuXwlQcUcJ0XUCsSvaE2kkZFb8YJm8gRQgw2b9VAI24bgOjXYvi3lZ0m5L
 7aM1DYpZOUDJCJMfrBSIym8uyVh7cUr3PMrEQMtHXpT2vUfQEd0B/XndgSLIb6O41lNEoHaRcTH
 cFuE7zTddWL32S19oGywKsnpNo21y+YaLE1CEmjxToaTZqiLjelvCxnatmt+xt9Vbz2NRXMWa41
 9FgZtZO8fR+WyKoM0NCkZJNbHoJMyeVtkH7ZwpKIqhFxZorj/euzmS2gc1MxFC+GTGZ60MGxGgL
 OnBOOjJOVC3w1f9tf0ejAej3zJ7sryrIXTiR8HG/Obb7Y+O9uOm2+zqxBV551rsxfORq/kKaZgK
 EvlqzppzO6DBxiv8Kaz/4w3kNhR9g4ZfQcCL38pFBtLb2zp9ZupQ82thXca0zS/Lo4cFf6onB/X
 dG0PjNh0BpAcOrew0g3nrCqRZMnik3mlHR+Io40GPEfbW4Vb76AUuBzxg6SoZgkPB0oUF7o4wLX
 mHl5xwDhN3pxzzDqcOOFzNAPI9OYD61eg3ioNzpkqgQSoP50dltbMACc2kNMHdl5etVZ8mCxuxs
 n4sMUHx+yQdV46CkUGyyjJFGN9gKRNEc0x+C3teZ/vEU1J9n+15uEMw+xHLuxxJ9Ei+thMu+ibt
 7RzeOCNWmXr6IMA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/iuu_phoenix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/iuu_phoenix.c b/drivers/usb/serial/iuu_phoenix.c
index 77cba71bcccb..c21dcc9b6f05 100644
--- a/drivers/usb/serial/iuu_phoenix.c
+++ b/drivers/usb/serial/iuu_phoenix.c
@@ -1157,7 +1157,6 @@ static int iuu_remove_sysfs_attrs(struct usb_serial_port *port)
 
 static struct usb_serial_driver iuu_device = {
 	.driver = {
-		   .owner = THIS_MODULE,
 		   .name = "iuu_phoenix",
 		   },
 	.id_table = id_table,

-- 
2.34.1


