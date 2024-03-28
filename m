Return-Path: <linux-kernel+bounces-123753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A3E890D59
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00E01F2651D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29861494A1;
	Thu, 28 Mar 2024 22:08:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31835149011;
	Thu, 28 Mar 2024 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663689; cv=none; b=DzLzT2Hmw79NPn0TaHLz9Uw3aa1nwGDD0tZg1zOAxx/1L0JWH6XU52daRkUtVYfYxph3VPMnc5osVxLofxSoIqn93D64DATl1xmgW4GOC15sXUR3tspLls1uEhdltl+UYhW7uzy7HFbtnKZZ+6rqJyLS6LybvLcW85ZbskwyH5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663689; c=relaxed/simple;
	bh=jCHLS1grwy5B/3f3d7OmLHBejgY18R0io1By2MJbtTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mDC9PkDLGUwjB9GqBA+cN3QLuyXhVUl+0VaBFfb77xFTx76VxKO7a+i5jsG4Db8Le4e7B8DspJXop523rqiOihIqFCHrWJA1C1KHVV1to2gdBAOIRhwyAbvr38+SsTLKg6/uZQXNvy+zBXfV8PD9CID6N8n5lWCE0akCMfXrHbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CF5C43394;
	Thu, 28 Mar 2024 22:08:07 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:25 +0100
Subject: [PATCH 47/52] USB: serial: debug: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-47-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=900;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=jCHLS1grwy5B/3f3d7OmLHBejgY18R0io1By2MJbtTQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenjAHGJTSBsNuKFy/HgWPlQi1nkiT+RpdZQA
 yoruoCpHfGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp4wAKCRDBN2bmhouD
 1/zuEACMNBVVyIreJn3a4TICTwz9l+fpIjAmn0H2HHQl08VgolNfmJiffMhC/4Seh5fUagf9YzO
 7UOt1uVPzj5zp2bq+0D5waDWRqwkAHCVVWW422tdu0u49Nxb6RcVf3/ig4wMu60zq3hLIih9UpW
 JzLXmWtzD2WhxgVT51VhG0Ip1JOKLFOF/MAO4mCrX5Cb+GyWBApn8AetA5hgnVgW3HFAn5PXUeV
 EMYJJ4CAwkcgaCuB7ixzb10ZljAWmkABYPjuvOePKy+1uruSSZXf+UdMnsmNrjzD1ndY1cetDDJ
 6VJS2utKZF93CZoa8owaKYet8F+7TysXbw/bncXPgxCMQqXonheVCnckbfblRPXCKWW5rvEJDic
 qr5Bj6h8g6CDFMVzexrT1zoEwKXONMaKMqTW6FiUUNt20UGia79u60u2ImBVz4inMgTNiu8WIRV
 Bm8NNkq2ktuT559qgfSX7eEBfpbdMwT7x8yk10FT+EuqSX7+tdJTHeWG2sO1/dHg8ZeRT7R3VXS
 D8Z4TCPDd/0bdIgp2KCvgRFDOqfkweWD+xmcW+L9wdQnP5SjHatsR5iek/9yH8JsGKDZ8jr/ZzH
 Wdr8uAaR/yrfbcJB2izoAv409M6t93vQr9lVrZmwo+dXV7FXpNkjBII2pz6ycjT1+mb+kxQqvbQ
 ptZwGn/2KEIEoNg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/usb_debug.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/serial/usb_debug.c b/drivers/usb/serial/usb_debug.c
index 6934970f180d..840373b965fc 100644
--- a/drivers/usb/serial/usb_debug.c
+++ b/drivers/usb/serial/usb_debug.c
@@ -78,7 +78,6 @@ static void usb_debug_process_read_urb(struct urb *urb)
 
 static struct usb_serial_driver debug_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"debug",
 	},
 	.id_table =		id_table,
@@ -90,7 +89,6 @@ static struct usb_serial_driver debug_device = {
 
 static struct usb_serial_driver dbc_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"xhci_dbc",
 	},
 	.id_table =		dbc_id_table,

-- 
2.34.1


