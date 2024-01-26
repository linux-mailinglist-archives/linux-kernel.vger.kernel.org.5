Return-Path: <linux-kernel+bounces-40399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0789683DF86
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A971F21B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C095200DD;
	Fri, 26 Jan 2024 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c73abWvK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E8C200A6;
	Fri, 26 Jan 2024 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289033; cv=none; b=LJOwKs+yVHR4qx+Y8AHEVOhlEpT4I2wcpZEoyZhNtF82yXglGkImRvwSzNJYWarAQSlYMVKrbgiwva5wzsf+iikrGTW1RKCGymo+ds4gVFLECYX1gKzrZzvc71sFBqlrgWyGyiFFTOgfftAwWZHS76xwlRMOw/R1oo53VYabbhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289033; c=relaxed/simple;
	bh=DEHxLqizhVae7GfdD+IYf2Qhwx8aaBFy0kmp5GGvB3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4Bastt7cVJrUyFIif2UWuoTsugGg8zqIpYg20AboMoDJiuyeme4Zw4GF6MqTTxDbyuGIuQ6tiTErpr3Y+RX8HbDmBMdOivzUF4pe7f9XsvnZGXlhAjYMLYENyBOAYeXztYnnNhj96rURy11mpPk77vqbRlNH2rT4TsrmxvfWsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c73abWvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CB1C433C7;
	Fri, 26 Jan 2024 17:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706289033;
	bh=DEHxLqizhVae7GfdD+IYf2Qhwx8aaBFy0kmp5GGvB3M=;
	h=From:To:Cc:Subject:Date:From;
	b=c73abWvKtRcIGlcqIFirNK8ljnzEEB6kiz37s998Hb9Vw0N9xH+v3zXLmRk3Tqyac
	 W3W+4bLnAhkJiG+rCT00MOouACTON12NsDin4kcvSlu8Cm2mvvtB7q1roMj1etB0SZ
	 urBAu1y1mKHVP+ex3XjuPvy4n5R2kzQgWMnNv4DSgqUnICBvu4EANwrwhfAvksmFyE
	 +bQpw7L0KZNXSyRPEV/62g8MFLt30tdHDWjZDfz+ABIUHx1EFZX3iUNbbEMbk8+7zo
	 4hreBHGf+RMtIKbWcAsf17NBb9lVBjEPQz0xi+29jD1aBMMkk/o2A6uarh2CKlsJqu
	 qi5pR8SDswMAg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rTPj4-000000000YW-0YGh;
	Fri, 26 Jan 2024 18:10:46 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] HID: i2c-hid-of: fix NULL-deref on failed power up
Date: Fri, 26 Jan 2024 18:09:01 +0100
Message-ID: <20240126170901.893-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A while back the I2C HID implementation was split in an ACPI and OF
part, but the new OF driver never initialises the client pointer which
is dereferenced on power-up failures.

Fixes: b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are separate modules")
Cc: stable@vger.kernel.org      # 5.12
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/hid/i2c-hid/i2c-hid-of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-hid-of.c
index c4e1fa0273c8..8be4d576da77 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of.c
@@ -87,6 +87,7 @@ static int i2c_hid_of_probe(struct i2c_client *client)
 	if (!ihid_of)
 		return -ENOMEM;
 
+	ihid_of->client = client;
 	ihid_of->ops.power_up = i2c_hid_of_power_up;
 	ihid_of->ops.power_down = i2c_hid_of_power_down;
 
-- 
2.43.0


