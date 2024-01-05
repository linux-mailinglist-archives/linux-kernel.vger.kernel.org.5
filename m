Return-Path: <linux-kernel+bounces-17648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073DC825096
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F5B1F227D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF85222F0C;
	Fri,  5 Jan 2024 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ii+DeqnH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0A22EE6;
	Fri,  5 Jan 2024 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 405999iH007188;
	Fri, 5 Jan 2024 03:09:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704445749;
	bh=z5vei7JlMzAa/jduUZEH+hGUqRGDx7E6gpd6wWEU6+Y=;
	h=From:Date:Subject:To:CC;
	b=Ii+DeqnHilv1oFkT3oYLRPOf2LzgbQkKXvrbI+LlosQq31Bjzdt3fho0Z87FLCLl4
	 sf9QuEVqQGi6M5b00RqF84Pz9D+TR3YJ1D+Bsq2zSJMs3yh7JjreY9LBO3aAMrkWLG
	 sRGlb2rxqfvx0MdplyHfkre7VScfsjqrSA8JNFcs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4059998I064077
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jan 2024 03:09:09 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jan 2024 03:09:09 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jan 2024 03:09:09 -0600
Received: from localhost ([10.249.131.210])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 405998dW034337;
	Fri, 5 Jan 2024 03:09:08 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Fri, 5 Jan 2024 14:36:54 +0530
Subject: [PATCH] usb: typec: tipd: Separate reset for TPS6598x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240105-next-tps-fix-v1-1-158cabaec168@ti.com>
X-B4-Tracking: v=1; b=H4sIAK3Gl2UC/x2MQQqAIBAAvyJ7bkHFDvaV6FC61V5MVEIQ/550n
 IGZBpkSU4ZFNEj0cuYnDFCTAHfv4SJkPxi01EYqOWOgWrDEjCdXtNKQt/pwyjkYSUw09L9bt94
 /ISpihF4AAAA=
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Javier Carrasco
	<javier.carrasco@wolfvision.net>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@kernel.org>, <r-gunasekaran@ti.com>, <vigneshr@ti.com>,
        <d-gole@ti.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1839; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=Z8O96E6ST2XTkcI+vrlIMRUkybW9YQ0pWHAzEcvC6XU=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBll8cyHksr3aAh4XZyshxl0tzvJE/F/cb8WuPoi
 JRe6uQdsF2JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZZfHMgAKCRBD3pH5JJpx
 RVnMD/9y/zHVem29SzahsNwxmycKd7H9EsUBE7K7DyQXCvI0FqIU2fgoYk61YnTf8ub8jKZgMDs
 1RkuUhbGUue06GinURDRmmk6cuD7db5q4Y85uXwGm/iktSLJlKRQ9BmSSCyn6/pUiHnUg2KXrWy
 TYqfEEGsa9LK7Q5XC2hANHAhuUczWvuVMtF7XHE3yVFZ7gR9ntKV0dtr9hu8UHOxu3/losGyAxn
 nMuCt7jNHaqXZEXpJBhZrjr/Q6H+cel22WukcSybS32emz14yeR+bhLutwZmuApVpvVaAc1S4Ux
 I5oePPJvCX7CwVUQmQ2j6DJa9BaAV4Dm8FJwGH/SVL2cwzFOtd5FC01YuUBR9OkPvU+4bEEEZ9L
 2bz4cQmv2d4HW4ks9HWQFll/3gtAjOGwkPlfL7A/carDjvxvr4hG2IAc+zmzHPJd9QEEefgvV6T
 aEiNKcVH4VTVIANz5f+edG8o4uCs18qRm5P0VbIC8U+eN8uvy4JIVXW9dwV90Kt9ziFOiuEiHn9
 Tl4akC9xJQYBO2ty+vgzsqy+mS0K57dJEulwwePYZ4wr+qTx+Qr3IX9iu+zPPHLZ5+lF3JDgtih
 RqumgHQjK2OngyDx1bQ0hVJKrXHHf1Isr1cE4V+agexA90FPpfDhV0MYg/EXMncdnmJ02LhM4xq
 RV6cUpp02dANuNA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Some platforms like SK-AM62, SK-AM62A cannot boot up to prompt if
TPS6598x is cold-reset during unconditionally on probe failures by
sending "GAID" sequence.

The probe can fail initially because USB0 remote-endpoint may not be
probed yet, which defines the usb-role-switch property.

Fixes: d49f90822015 ("usb: typec: tipd: add init and reset functions to tipd_data")
Closes: https://lore.kernel.org/linux-usb/vmngazj6si7xxss7txenezkcukqje2glhvvs7ipdcx3vjiqvlk@ohmmhhhlryws/
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Boot-logs with this patch applied:
https://gist.github.com/jailuthra/b66d5722090ce1fbc2886986e53640f7
---
 drivers/usb/typec/tipd/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index a956eb976906..8ba2aa05db51 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1223,11 +1223,16 @@ static int cd321x_reset(struct tps6598x *tps)
 	return 0;
 }
 
-static int tps6598x_reset(struct tps6598x *tps)
+static int tps25750_reset(struct tps6598x *tps)
 {
 	return tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
 }
 
+static int tps6598x_reset(struct tps6598x *tps)
+{
+	return 0;
+}
+
 static int
 tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
 {
@@ -1545,7 +1550,7 @@ static const struct tipd_data tps25750_data = {
 	.trace_status = trace_tps25750_status,
 	.apply_patch = tps25750_apply_patch,
 	.init = tps25750_init,
-	.reset = tps6598x_reset,
+	.reset = tps25750_reset,
 };
 
 static const struct of_device_id tps6598x_of_match[] = {

---
base-commit: e2425464bc87159274879ab30f9d4fe624b9fcd2
change-id: 20240105-next-tps-fix-904ed92bc1cc

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>


