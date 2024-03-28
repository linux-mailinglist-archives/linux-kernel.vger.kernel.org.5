Return-Path: <linux-kernel+bounces-123507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457AC8909D5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007EF2A26F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C51413AD29;
	Thu, 28 Mar 2024 19:50:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF39213AD19;
	Thu, 28 Mar 2024 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655417; cv=none; b=FcWzRVlnUGyQ9wMpay8xYmRhjJ17avb3h3cnTJW21FZSUx6a5ABvfUL7b91b54hYZI/eOJFpIp1WAJK2154gwOOwtWBIFpnhKF7hLkVzKI0WYwGtm0jQrS7iFsiKdmU/Qfmfv3dLAtMzPy6ET+gBOH+ALrl8VOe16kaowvKGJRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655417; c=relaxed/simple;
	bh=MsjVy3pXx6S7JGgK0WAo4NJeUMxth3LTHSIPWMxIYEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ARZN/rMa+R8IwBnHlfRsCt0r0aA30nHABn9x4C+I0QYZY//UIVjRilY6Crg8DQvKvljVvDA0BZohRrIdXmbncpr/x965yMbdrFcUovrYf7iE4ra0JtTLUMpzEPaNlRCcIgJvL0mJNMiiydij0GPnthpFmV7BL01P0EfeEU6I21c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9286AC433C7;
	Thu, 28 Mar 2024 19:50:06 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 20:49:13 +0100
Subject: [PATCH v2 03/19] net: fjes: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-acpi-v2-3-1e5552c2c69f@linaro.org>
References: <20240328-b4-module-owner-acpi-v2-0-1e5552c2c69f@linaro.org>
In-Reply-To: <20240328-b4-module-owner-acpi-v2-0-1e5552c2c69f@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Matan Ziv-Av <matan@svgalib.org>, Mattia Dongili <malattia@linux.it>, 
 Azael Avalos <coproscefalo@gmail.com>, Ajay Kaher <akaher@vmware.com>, 
 Alexey Makhalov <amakhalov@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
 Richard Cochran <richardcochran@gmail.com>, Theodore Ts'o <tytso@mit.edu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-input@vger.kernel.org, 
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
 platform-driver-x86@vger.kernel.org, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=769;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=MsjVy3pXx6S7JGgK0WAo4NJeUMxth3LTHSIPWMxIYEE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBcnBtRWQl6ZYHznmyg2cZvZglj/opzjF7UQL6
 K9ZRGfvUd6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXJwQAKCRDBN2bmhouD
 131MD/9qobODC4LHr0QcwQD1Ek1mT2dadDc/sgVnRogQ6PH+5kWak7NmdJiCwPn0Ds5QN4zb8C4
 tRg4ySY1o+WmBb+eCjyzHe/gUei3Df0ZOE2LxcFel1HseCxb/FIrRB0l0l9me1A6XRSkUSz33wo
 FgGkw70HL7n3CF3IwJnjlu8XYuWMCjCqbvOxp5idfn0keCBA4n3uudB61HswG9ugNRqL2CnTrci
 RZbirFtNkWPuXuUK+j++6SLt9fblN3XUp25iQMZV0mwCkhMVtwY1NMtKi/2cA/zP6/h9h2KGIwQ
 dzjdQartmFGj6CsiFcHdcuqFU/njtVzhRb7RrR6BsD3OLk674hmU0eqkljGzeGqFcXAv9X72kke
 ZsvIvqMwJ0XDtaTxyJJezFWn41HBSCwAmaIB107g9KgUGD5OImeWzzcBPEaOel5o7BH01MJtpk6
 iXVa8czcAVa6R1O7kRTjtZ6OWTMIYN/f5XIZ7D6KZj6eSeqPSkL/9MfZWCLyTZB7OWrzJqh+qGu
 /ki5qUJMgBFQLKIQAEHjqmaiyyu9OE1LESYFd2l12FjO3xnNnPU69iKcA1nKHno+2C8cU2heM4u
 HNIg106PuiaN7/DDJwHNr0eVEv2sYhM1uYJXwR7fQTjMkQSrNEW/mOTQ3t/2gFkS4LBFtuizR4X
 iduA4hS8L3MVOpw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Depends on the first patch.
---
 drivers/net/fjes/fjes_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index 5fbe33a09bb0..324b34f3ac93 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -156,7 +156,6 @@ static void fjes_acpi_remove(struct acpi_device *device)
 static struct acpi_driver fjes_acpi_driver = {
 	.name = DRV_NAME,
 	.class = DRV_NAME,
-	.owner = THIS_MODULE,
 	.ids = fjes_acpi_ids,
 	.ops = {
 		.add = fjes_acpi_add,

-- 
2.34.1


