Return-Path: <linux-kernel+bounces-123522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E428890A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5998B2950E5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8678713E6C8;
	Thu, 28 Mar 2024 19:52:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3768139CF6;
	Thu, 28 Mar 2024 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655547; cv=none; b=uJX3ZFO2JN0gu/OL58SgOEF0rOBC0PQepsPUEoBVuXdJpQdL/GM2QNpXzf6u61mAuh0iAyZH5yzJBZbJFN1SnBkx2enNNIFcRBBChahUGgRNouHS5BCWx60aahhSOZYMuxyScKzaRohJwSXo/GRNACjB7gnXj0sIYkSNjeCOLks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655547; c=relaxed/simple;
	bh=8K0Tk05vHjsLv5OTTjcqwFzqs0iqpDP0i+VNxkkswqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OL3Ul2G/BA+PrCwWEEuf5uCYDsKsnSfcLyRxxFGwfenU4Y+0J/xNrldY4V1Ib78Ml1JQC/MbzlNcRkgWS2EMA2dgoK94XJJgT+/kilUBxoVpIthmhzjE/tbKtTHBYIicOS+gKID4MYWhC3jMCWxxYqeKauUWtVju0TyaDEM59AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFE4C43143;
	Thu, 28 Mar 2024 19:52:19 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 20:49:28 +0100
Subject: [PATCH v2 18/19] virt: vmgenid: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-acpi-v2-18-1e5552c2c69f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=699;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=8K0Tk05vHjsLv5OTTjcqwFzqs0iqpDP0i+VNxkkswqE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBcnOKPbyS0IIixjJbv3BHHEXsQ31pkxjywnsN
 oLTz8EQY6yJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXJzgAKCRDBN2bmhouD
 1/VJEACV1noeShYwrbEDeG27Ox+LOhb/t7QcqwWoqvCvJcYr3KuJuZFMHuvWggNnjE8XqFH4zqC
 68XxMKErTMJUYzvTHZgN71HE9OA1yQN8WRW+yPqwVSH300CH96NrzTLwmIiPvfYddVF9++/Txzq
 H5HAAMj299gtGHD9nNE25M47a+ZyUt8XamKVVNu1JwdulmZeOJtthLl8VjHHq9YWCV+IApmVxyx
 E+3TNsuzBxOWeGouGNrj2T1O8XHeLt7nRdFQAG9G4oazWpUyFLmKGeT5DvphkRyBdvzSNg2SsxR
 SKRNzLdlu0ZXJ9QQmB1PXX9tzlydL0TJ1si1Y1bGL7X8lFdI5i+o2fkaXLO57i8RHvUQ4j6ewNI
 P7qkeS8dn1XhDg4h2IeLQkrPLu0KCRF/xCGWbv+GQkyri4HAneaSAQKyRXs5NLCMVc6ecYu3h8w
 Wy2yGHn042oTE6Ps0XMIJMr/xIAeAfG+MITJy/eJ0/opwvPRIdjt1MjqGiMGcRjRl3nonH3jd24
 D+e9aLJmEsjjtzCktB7AYZu/mLN518ejcnOHvTh/JxRPa4Gb+r7GJS1jiwSwSUSHMrwnAimqyLn
 hsp9Rkiu5dib3YH5LlbJaPnW+jltO54q8PBlYbB8Egvb0TJObpOnDbdDvlVxFWL99Rr7OundGL9
 OfvGFCpb6qChajA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/virt/vmgenid.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index b67a28da4702..8f6880c3a87f 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -88,7 +88,6 @@ static const struct acpi_device_id vmgenid_ids[] = {
 static struct acpi_driver vmgenid_driver = {
 	.name = "vmgenid",
 	.ids = vmgenid_ids,
-	.owner = THIS_MODULE,
 	.ops = {
 		.add = vmgenid_add,
 		.notify = vmgenid_notify

-- 
2.34.1


