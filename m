Return-Path: <linux-kernel+bounces-123505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803B88909B1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8051F2306D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2435913A271;
	Thu, 28 Mar 2024 19:50:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F547EF00;
	Thu, 28 Mar 2024 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655406; cv=none; b=lGe3ZV3PxxYYTdoyESpmGNCYTMuXf5ERko3HdXAOqvQ9G5CUd+ClkaD2PvqQPtUfLbmPoTThwDUdhNcpUG2SfDAm2pti9O0zAKZBAwFF2jAdIVLH6MbdtTruW7sgm9hsPPiW20l8p8U3VgmNvluXr/NeNRFscGR9BV/sf9Znm74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655406; c=relaxed/simple;
	bh=69+80hLz3Wx6y+bqUYfkCRVRC/cWOyQclieDPFYEN9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iAQaKUoGv/RfoIZxJksx3sSOEIHCR+Jau09uA+4/HF5c7eNjtAiKQlzl2snI2XVlshICpltFnw7iewOcssrJOk43koHN/IlNU9ytTy22MgfxVCme6U0Y0Ihm1lYLsb/mjGKZeqj7LL+ebAp2zxBQirV1BxpJACxBtrkGHF4UkCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA1EC43601;
	Thu, 28 Mar 2024 19:49:57 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 20:49:12 +0100
Subject: [PATCH v2 02/19] Input: atlas - drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-acpi-v2-2-1e5552c2c69f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=856;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=69+80hLz3Wx6y+bqUYfkCRVRC/cWOyQclieDPFYEN9Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBcnAx7XrsoWBm3vh56nw5/LChv2E8G75G7P9c
 jusiIE+kU6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXJwAAKCRDBN2bmhouD
 1/SdD/9deyAcM29a6zSRH1dyIrGO1oRwUG5KH/LY76CRVBouqq0VNXz8+b8D6LG3FLXCdb5TjUl
 ZFGcjY3s/r11M6njxehb5HG3maBLFySMoSyiV8qcm1K885e6u27KW3vI7GW9zU+ffsSLzy8DC+G
 q/XU4pegC8A/hWjNqXHH/XQMRCJJKNe1NDrEalZwlscHFzz6M47g6Ns9D1+jq4HWVF7SPk/qLDV
 sPOn1hiNPuLw3Nwm/6ppKh4cQEjiHWRuIKn9VumSHFMZE+Z49Jp5L30SiHN8vIR9ip+NVY5YZUN
 H22pGcW283TvPPN5jso66K/Fi5GmVNqETa2DfPIDI68iR7t9oBS4qB5+j+meVkLXDBfvlgakI6i
 0LbGRaHzsjAdu6rIT+wYXqq6alvDQH6huGt+MhAntWKPwwgUNUJbN7Ak5t/MrFumcZTYBIC/Jod
 VbVJEEs+oFg2LdDjIKVeIxEKDOdFmlafMrfE09zev2JSJngthIZyF/3GlbU+SobZTnB5ty3kYng
 Q+WkeLi3Xp3q0KVZ8/HCScv8+RLqLa8Is0bzpHbfoStRVVlaHJg1H6VBFwCK+czr/MVBv7LDysS
 SU4XuIPpzdQnnbZL+sXpTFfZzq4Pj7r6jGtXujNzoldabhgdBVaKJi5y65RmYcbuq1hZtgGgEjA
 So+avUKp+giVMnQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/input/misc/atlas_btns.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/atlas_btns.c b/drivers/input/misc/atlas_btns.c
index 3c9bbd04e143..5b9be2957746 100644
--- a/drivers/input/misc/atlas_btns.c
+++ b/drivers/input/misc/atlas_btns.c
@@ -127,7 +127,6 @@ MODULE_DEVICE_TABLE(acpi, atlas_device_ids);
 static struct acpi_driver atlas_acpi_driver = {
 	.name	= ACPI_ATLAS_NAME,
 	.class	= ACPI_ATLAS_CLASS,
-	.owner	= THIS_MODULE,
 	.ids	= atlas_device_ids,
 	.ops	= {
 		.add	= atlas_acpi_button_add,

-- 
2.34.1


