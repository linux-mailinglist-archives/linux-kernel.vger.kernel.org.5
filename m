Return-Path: <linux-kernel+bounces-123511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B73D890A07
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30041F245F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE28E13B5B9;
	Thu, 28 Mar 2024 19:50:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD8013A243;
	Thu, 28 Mar 2024 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655452; cv=none; b=tF2t1ToyIjJL6Dxvg8uQ3sQjgG3HKvHHq+36pCk1/zeki54DYRVmrJnkYuqpTDygHJbgGMhwMPzdbAh8vPezCSR2XbNiuhoUQUoNu1JvtBkDQEIpc5dKdjIpCDdScIfSJTGNPv7sBstHB00UZBMNRgD0g/JS9Zb0lni7o6M/kaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655452; c=relaxed/simple;
	bh=XOZ7b2+NpxOkPS+HwrZwBhnuRE/Lnltd3XE6kNzmoJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ucXYd/KKuOrkS+DjBTYobW5n8Jjz+f5ppe+gtKmyOY/kjs3s4D/Rt6cujrgIqXa5RZX2poQRf/flMuLDfR6toaXvjnmjyZTG47yg835bPx3Q8KDOp3Q50f9KJ2vkcgRZf2z2H36UpJcJvwazhi6pAr+kfzIjIgrnuoPCcg5c3+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF074C433F1;
	Thu, 28 Mar 2024 19:50:44 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 20:49:17 +0100
Subject: [PATCH v2 07/19] platform/x86/dell: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-acpi-v2-7-1e5552c2c69f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=726;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=XOZ7b2+NpxOkPS+HwrZwBhnuRE/Lnltd3XE6kNzmoJA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBcnEPUFidAyM14BR9uBDWbObaUACpku/k4Jnq
 7+wCKxEvkSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXJxAAKCRDBN2bmhouD
 1z8+D/sFF0P28AfEDqvRJk8Mb+XkWGdIzlTk0Y0IORkLICrSmqoa1DcdNqg9k74qfXJUaUFgQsb
 Q6ullkfB+IFp8rzecWWXmYod6QyJkGdpoKqEWClmHK89iJTktFOqInMMpDaPbf415esEG01uHdP
 cyMzDJ1MRDPG+tH+APwj7RZGVdnfFNO3HMexkwf3Aoh2rag2EG7/4/pXJ2S/qgqUJOvuKkaNVR9
 xi6QRLn4m5SFe4JcVYzD2jHMUMKCl6Lhy6Gli36IljRMju9DzAUTuDC85PP+K3hGOQ+g0grD1Lv
 wRxyx+2ACHQt07EsZz2nimYFvlrysoUYpaliuoMO2eTWh2A+Mpzv3kUIIxQK/x9w2471klDbPcE
 /NwGZBQN47IxDOPKV/QTdQnJTL7uK4dDed9L5qzs0DLc0X90aIAPcvxvvEZ/hIV5G9zkG8a+E/O
 l0dCgxBWEV6DXfO1Hs3e6l+LB0eplSP8hkzvvXccjyVOKSs8xSeNm+f5spZxj4MDiRVQicizNbt
 lZmerRh3eA7iN54JcVwnYXwikxEKv63aRahcHtNU1qZlL6LZnvavIF3x49xPJU2iU0AuHctHhvi
 Xd1VmLaXGVOypun6/teSyw5F6KZc7le0NzW2D0jqunx8wEnKkFe7JrscCuWms7i9ViAyrxerWgj
 XnFLIldAytgAjqg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/dell/dell-rbtn.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
index c8fcb537fd65..a415c432d4c3 100644
--- a/drivers/platform/x86/dell/dell-rbtn.c
+++ b/drivers/platform/x86/dell/dell-rbtn.c
@@ -295,7 +295,6 @@ static struct acpi_driver rbtn_driver = {
 		.remove = rbtn_remove,
 		.notify = rbtn_notify,
 	},
-	.owner = THIS_MODULE,
 };
 
 

-- 
2.34.1


