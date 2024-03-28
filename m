Return-Path: <linux-kernel+bounces-123754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70503890D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBC41C30DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0981494CE;
	Thu, 28 Mar 2024 22:08:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6491494BF;
	Thu, 28 Mar 2024 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663691; cv=none; b=EfkYQSmHUzCpTE3p6FEYLwFOZSunxRZuhBdEdxhEpD4xtium/l07A2I3x8U9OTYz873yx+c2iAkcmtThTosbqhKYTkAiVBwR7+4zg5t6fE5JI+3UeY3mQyydWZ1b57Ie+R+parDSNjlV8lPqxYY7XzeVCcpw2XRfxERaG2ceAWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663691; c=relaxed/simple;
	bh=zQLc857Pt+hekczjRNz9Vs9fdZat2RkxZijifeCJb8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aEJRTqXDu+UI7FvDIWmm7xvk8mT+jXay84T7Iayc9ZTnDyLdN18ruERx12aLnQCzEhRdXsM6+4RKyVGd5ZoZbtcKeJesrO6oueC7rPYNokzZR6L+8YXTzRbLDEGyAbL3pYjsguPjpv2BBJCpC3xMCTeoyjBQieyJWBdZdmqO+fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E818C43399;
	Thu, 28 Mar 2024 22:08:09 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:26 +0100
Subject: [PATCH 48/52] USB: serial: visor: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-48-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=zQLc857Pt+hekczjRNz9Vs9fdZat2RkxZijifeCJb8g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenk21IqmDHoMADZ3m+/AQJF0e8WzAw67s2ch
 uvfix7uJEyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp5AAKCRDBN2bmhouD
 193WD/wPoh+zRHQUVE4NlX10e47eVO0VtpkZ+Mq1yfZYZpBoTRmyQI3FJihfdrBccO8TLAq+Ums
 iGtgoj3Frc5TRQKSLrknglbgWe3tp/nirB6c3c0J1cHqVbb0+frOnwz3QJAn/JLludnzGoYjsvB
 ZdLMfXVci4kw3MnEk639mugXLc5bAOsxRdUAgY6QOmD/2xWSAI1ZR34JWJRuHj6x9KuM1GbwsvO
 kBTb5BrxJDAYDlLzfcdQSEKuJi0pIpPIyE6iFjSxDbO6aaOtfFikyDPSMHF6kObzMvu7SjdsF6y
 aqmoRPTqwckDnahiCnQbYlrhanSicnWygbbZjO6VgmvyBL1cbTm6iofDzp5PnIHTvyh9Ut3D3TV
 +iQH+XDbeTzSt5203aRf5kdTJppoTQ2kJM1s3IVS/CQRT+IFanVjzXyQHV/69O6zZm6ENaqjhJJ
 3jJMnB4sjy/h2bKqTLov1d3Tb5g7LBLbkzqXmnOnPtuJWjYJtTjtJXGaui4SdF/S9Tvc5LAlWCf
 VSrdPW0MUpGIXhTeq8JwrISfsM/Ap6r3AtEz0qgDBMxs54BLG2iT7E9ILKtRG/tnXfXGL41/lhc
 GkFjPKvFO7mQtpAeJYMB/LRubL3L9oXjScRG7yLXjzaMLCsuKo5Hr/72mR7i4EQc4bjdYHn3Ml2
 Dtfgo/Q70aLqqUQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/visor.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/serial/visor.c b/drivers/usb/serial/visor.c
index 4412834db21c..062a38fe0c1c 100644
--- a/drivers/usb/serial/visor.c
+++ b/drivers/usb/serial/visor.c
@@ -161,7 +161,6 @@ MODULE_DEVICE_TABLE(usb, id_table_combined);
    and Palm 4.0 devices */
 static struct usb_serial_driver handspring_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"visor",
 	},
 	.description =		"Handspring Visor / Palm OS",
@@ -180,7 +179,6 @@ static struct usb_serial_driver handspring_device = {
 /* All of the device info needed for the Clie UX50, TH55 Palm 5.0 devices */
 static struct usb_serial_driver clie_5_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"clie_5",
 	},
 	.description =		"Sony Clie 5.0",
@@ -200,7 +198,6 @@ static struct usb_serial_driver clie_5_device = {
 /* device info for the Sony Clie OS version 3.5 */
 static struct usb_serial_driver clie_3_5_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"clie_3.5",
 	},
 	.description =		"Sony Clie 3.5",

-- 
2.34.1


