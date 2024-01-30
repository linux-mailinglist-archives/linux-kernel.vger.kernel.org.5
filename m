Return-Path: <linux-kernel+bounces-45382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5994D842F83
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170311F25E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3440414AAA;
	Tue, 30 Jan 2024 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="a8LvVCX5"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F145138DDA;
	Tue, 30 Jan 2024 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653210; cv=none; b=d2oYgY4YeHmuc2GN1ze9uHiACgAF9SAZetQlnay8q+JD94J2cr9lAsQSBfJJ9IlGR38tw6SPqkCBncbHKcJtV8lvDddMB692dJIXZXtk7ThZMUjhtrJiBlHzADMHLonGjBh//1JMWurmlRiZrePdae95ghXogoJKCm64ClO0144=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653210; c=relaxed/simple;
	bh=Ai/F6ftEvXWlQXBk8weCfDnPkKREoC2bED/lhryfJ7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fu6zDBbXyS+1ieXI1zTLEuM/2dBl0eA5gTkvNbLIBYnD3ySgyGe9AtJdtU31rAJ2fDwvvNfpgjUA7xXxAlDmuGL+moegqbgaxcJYROFiA7VWlegXgS94nGc3TG9P293fwXleh+58/rKI8xc4ansTqOUE+e0ryn75ls9PD+U1lAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=a8LvVCX5; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706653196; x=1707257996; i=w_armin@gmx.de;
	bh=Ai/F6ftEvXWlQXBk8weCfDnPkKREoC2bED/lhryfJ7k=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=a8LvVCX5hXAHrMgHjdOKkBKaUG82OTyBOoBxfzzXT8xh2H2Ylupo9taLV4kq1h2n
	 Y83/aPQPuX0wrTMKsIHdn7jt4QPi9I231AMM6spudrXdL3bYaYRj5WK3w8S0teBBg
	 Yas+bymRoJ7kypWC+meaaP1/O2BH26pNjO2Yzsp0XfhJ1LjgEY5mgDsC/clURgHzx
	 bRly9udJjX5xdNYhVuWu07J+ewUBIXD8jvqldGPSNfuuqSAnxU9Sc5tXJ6nj8FIYb
	 n2XHjDcuiUt+/4yMy+5P9U3oc/FQrtfmigE/Py647vYa+ki0Wo4oijpzuA/d0rHug
	 cgCY6PjHFCRx+lOPFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MTiPv-1rcGk23ylp-00U6X1; Tue, 30 Jan 2024 23:19:56 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: wmi: Stop using ACPI device class
Date: Tue, 30 Jan 2024 23:19:42 +0100
Message-Id: <20240130221942.2770-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7XpWIQuxAtEdpGy4JF0mFDM9uvHU5ZdOWhOBBRfU3oM5qJqgtDB
 K8xZU0L+xJtJmh8O2jz6VNhLoMAwsbndRgSGVQCPOznEo/Y00S4WqX0iTNdsDS674R3RCGZ
 WB5kcESVietCwvYLfNMi/E58pDWvqr2MesvF44qPgBY7n8DAH4fJgiHgUwVZ0I3Uw6+RxXH
 FZS3FQzy4kGw325MMOAGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:byHVV0hqOlo=;gkamHTI1BXHLF3DtYphf9ZDRgeZ
 sFNT3TkkJncnTo6jfDGsrCIqzi8psfQHv0wYXpZjKoC6vL+B1II6rmF9VGxeXZ6STWzAENZdz
 1piOC0QgftyFqZdi/2dkWoeIlhKmrDCjasgVfhwuyZSc14iwfQY3Zksf5OI2xhNbkXPBHvFet
 9vbvLwBJv9JEU1CsXhYzmWL6jajfRnLbwjdJWkl9m1J7qJUX0u7Q33bdvKW8KD2zyENs/Hgdf
 Mjb2UpiwPxVGa8coEcxZ1DRLF9UXvSz1CzG7CMXkW1VbBBKP4aYa8zIIy8KQN6WStAT4QZS2M
 VU3REkixMxL3jTfsJAt8pRtCcHLAhqJXclMH0DP/RrH2Bj9dhrD6EYOvk7XLFiJvWTzqyT7Db
 pX9yt11JIx9vrBBPbMfdZkf8VGAPbNzBDd9RBl16FgVKZo6pjkj74b5a6v8RO2vVudjNbWrYX
 P4qsF+SbWpnG/zUhu/F+LJImdyFJnCmPW0PlYJaWHFK77Z0qodAroIpskYBMwcorNeGiDyQnL
 XAEO1PG/xFD2/Ryji47EUGokGisxxWikZn/Q8z3VBB3hAlkX5hqNqsiBSIL2oWjdvupU8VvPu
 2jrSqLYohEDIfDWIqWV5Mi3Mk+G4uLTyzz5N6s5Y0NsHFYRZ5n91Yeq1o72vyNZw5qE57Hsy6
 RsJghPfC+BXQ56SfNFIberWixzLhx74jGPJYaYx+QG87uNqnGGmIZwaKSm+TuoLjz8u8QHtZq
 NW/OtP95cE81LgjWzdkNU9WhKRJsh8TpnYqFiavrciLUrRPM3T1oSmLW1EIr5awQ94X5i5R3p
 7kGV6nI3rNXQXD8kdlLM2SiFLX8YrVt86z7ju9P3whvinbnKTQtvrTI84VcRJfGs24R/OtuP/
 Bc1Kd/RYWKdyWbevgLfWpr+Tf7r0f46DVxgg9WOvTBHHBCtmgerwVJFsdm2TYPMj6lBOWNliW
 Qe4nwR5qCCrHR+0BcmUIT8GyY6Q=

When an ACPI netlink event is received by acpid, the ACPI device
class is passed as its first argument. But since the class string
is not initialized during probe, an empty string is being passed:

	netlink:  PNP0C14:01 000000d0 00000000

Fix this by passing a static string instead.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Note: This patch is based on commit 3f399b5d7189 ("platform/x86: wmi: Use =
ACPI device name in netlink event")
=2D--
 drivers/platform/x86/wmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 7ef1e82dc61c..3335de4e32b2 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1202,8 +1202,7 @@ static int wmi_notify_device(struct device *dev, voi=
d *data)
 		wblock->handler(*event, wblock->handler_data);
 	}

-	acpi_bus_generate_netlink_event(wblock->acpi_device->pnp.device_class,
-					acpi_dev_name(wblock->acpi_device), *event, 0);
+	acpi_bus_generate_netlink_event("wmi", acpi_dev_name(wblock->acpi_device=
), *event, 0);

 	return -EBUSY;
 }
=2D-
2.39.2


