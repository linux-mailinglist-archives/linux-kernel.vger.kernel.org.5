Return-Path: <linux-kernel+bounces-123513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E050890A11
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5722863E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8070013BAEC;
	Thu, 28 Mar 2024 19:51:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F192E1EA6E;
	Thu, 28 Mar 2024 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655469; cv=none; b=sn29/Yn2DNN6mVqGaG/OF3gxsd4oQnQQS2MfnfJiAC2ryIG9NHbvMYT5c4poo7TD9dJbwyjHt9q8sEGcElNi4od3IVQeBxkkQcl7KtbdRt2AZPyPujbyiMnJLVNgRiK816ealxOtJavaPMxfDxW6KOWTDUIiB4pVV+mD6XolEbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655469; c=relaxed/simple;
	bh=atsGEmkFbuwoMNttwqx1F0yIynHkaEbwFezW18HyMOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tpxK7efh8oS1KJeTZWeMJa2Kv0yL++2vP2eywHZXm2RD8rZFKCnq6UKVMd+WcXM4xv3RzdERemodw7tNKfSxsVtwXzDH2B/WK9gSQtPbcH3MSfpnmEO+LXTjoIZFe5J98qQEp9uryia9h4C76fd/2Lqvm7ec/JN81mC77/emEY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E68C41674;
	Thu, 28 Mar 2024 19:51:00 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 20:49:19 +0100
Subject: [PATCH v2 09/19] platform/x86/intel/rst: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-acpi-v2-9-1e5552c2c69f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=775;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=atsGEmkFbuwoMNttwqx1F0yIynHkaEbwFezW18HyMOc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBcnGszDplYNDMhpIQD/TAYJlN3PuXJLxkuC8f
 Kr76QaTBoaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXJxgAKCRDBN2bmhouD
 16JsEACIEhsEhj/FJvoFNXNZ+0et5BZ1m4uWu5TryaOxRTswqcLf0/eaocjy6PSLWStoWlfe1GH
 vZhiq/VX4knA4nfKcsioR54qbqYs/qHFK3PdHXGMFV+Mv6yk76vjgab8v96ZTHvYUyENtOQwST8
 XtSQsYxLJ7fRvF+/eztvHv8fywWYUO4gdB+o/hMtXW4T2p5XPJl8kfamm0fg+ZiD5ann1iyK7Ya
 O6Fu66xqrPGV0WgduMXfzXAd0lk1gkp5Lkw4HTN/L6MSoOtl7QdI5fWO7PE+J4MAdEkTmAsmzUL
 q+VVSDFbWZW/dESb9yE8RTBk5L2PONC/dPb9YKMY1btZIOa1Yp5DvvIDiGL6v/EpvPQvJu9ytWf
 xSN0yq/Il52tkMvt5Lnyc6I4IUOpMEGNCQF1v5tBlVOa+xCGIMFnw1Vfl5V8eZDtJI8iLOHzfwt
 ToG5DxDpYkau+nWAEoLJ9IJcKSe6pa3bcaaZZdczFyMAv42rX8PB3I07tI9E7pLQALNX2dN0Ta8
 XJJVnOxMaKzGl9ubXY7WABzTIKKWKrBc2uEEeHqbdc/AlYpbQ8hsdCKh7EOCeK8aKSw/460f/AO
 fy3OG/kWgg5daGWpfF1GFs8iogre5Np1H9U2uITsF86vkTfS3DzvwkZVBhe0jMHlfqYWjOMgNza
 JgKy9HlfNDoI3hQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/intel/rst.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/intel/rst.c b/drivers/platform/x86/intel/rst.c
index 35814a7707af..6bc9c4a603e0 100644
--- a/drivers/platform/x86/intel/rst.c
+++ b/drivers/platform/x86/intel/rst.c
@@ -125,7 +125,6 @@ static const struct acpi_device_id irst_ids[] = {
 };
 
 static struct acpi_driver irst_driver = {
-	.owner = THIS_MODULE,
 	.name = "intel_rapid_start",
 	.class = "intel_rapid_start",
 	.ids = irst_ids,

-- 
2.34.1


