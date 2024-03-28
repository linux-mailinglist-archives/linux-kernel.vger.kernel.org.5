Return-Path: <linux-kernel+bounces-123521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6238890A39
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826342923B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0486313E414;
	Thu, 28 Mar 2024 19:52:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CD5139D07;
	Thu, 28 Mar 2024 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655539; cv=none; b=Z7+zrPXauWbQBUwnIhKrxcHAicJkJrDRO+SDDbEvQjefkS2g7jT8Tou7uiWkhuHHzwdF1cbdJd77pS6NrJ9YxWRB6LmEaTmokefN2YQvI0H00MU7mBjPGTsjNt4F/a5nPV2XJXyGg/4mzV1hhvlw05sDaT+bZQ+bdtxEx42I/j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655539; c=relaxed/simple;
	bh=khf7terHbtPWIrrbnKNLxPcFHL/7yWbxaISMdJE7KVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o3uk8Y9HIOiQWsMKWJdDLtaVCLvmGy21p+3F2DhmQWL7siWd+DY8/hT/UwsuDSj4u3ZXsHIkt0gdtjI7Tv/osIRvvLZiFW4Y6E/5nnBteU16z6FsBZX30c3hUl1u+4R8Bol7fDxOgjM3Tbeej3Nthok32YV+UVOLNn+xZDnby6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30657C433C7;
	Thu, 28 Mar 2024 19:52:10 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 20:49:27 +0100
Subject: [PATCH v2 17/19] ptp: vmw: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-acpi-v2-17-1e5552c2c69f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=651;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=khf7terHbtPWIrrbnKNLxPcFHL/7yWbxaISMdJE7KVA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBcnNqUS96sjoffNSE8XYoncIwtw82+UO9dqr3
 nWfPOlHjkGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXJzQAKCRDBN2bmhouD
 1z6UD/43DOuPoMrN5aIi+8knUY9cMhfmlOL4x2aCCfKT1JSb6Sea4qOF/kZXQrZ1MPI1gSO3Ky9
 vGqQqubY6/yytl+3WsXzFPckVfKTvUnJkhSf4N9ZdyWvp1i03ROFqOS523Im9mF3AxEuzbjRNXH
 I8NZ/7dhGCqtk9X8qNbaeS0EfgAUPQLFde4yJ0tanJN9z8+AWlGAznd2wOpCYxuI8kSCMsl1yqU
 Ebp55H+2nxRUDoyePPCHuCnqKMFZtTXS3er3N6unkPBVcNQyjTAU0T5XITO3CYCneXSGuR22fCW
 FhM51xJ4B1iuayddPP+YgIQaPQagf/kqajy/mxYc55FCge/Hbx7AaCJ+XwLAh76IM2IMI/Z0Lto
 kbk+vbHKACzbzbmdONyvGxwU3qCX9/oeI/IBLYp/WZBqnMbXNu8Eo9EJ956uX0Mv7mxgrrw9vsK
 asD4q70l8GkBo3je9IhfNFJmQpAquc0rK8Ln3+oMQdyACn8iJSxZIhKAxsA7l6LwQ/C0gFCy7nm
 ScByNSyYFgbefFnSts2UGDNsB0FZXGC6co/uxUe7wKoJIPNL2hcafSGdjduBnZZLUDSd6uO5NB3
 kVDR62mcssJeUgAYgXLc0ZcY+m06C4sqfdQvnenIx7l98mnRHPgEWI6Z65MDtbmE1CB+UrKnPds
 d3lyexL5c0944ow==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/ptp/ptp_vmw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
index 27c5547aa8a9..7ec90359428a 100644
--- a/drivers/ptp/ptp_vmw.c
+++ b/drivers/ptp/ptp_vmw.c
@@ -120,7 +120,6 @@ static struct acpi_driver ptp_vmw_acpi_driver = {
 		.add = ptp_vmw_acpi_add,
 		.remove	= ptp_vmw_acpi_remove
 	},
-	.owner	= THIS_MODULE
 };
 
 static int __init ptp_vmw_init(void)

-- 
2.34.1


