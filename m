Return-Path: <linux-kernel+bounces-75170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0492785E413
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837B1285417
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4145E83CBA;
	Wed, 21 Feb 2024 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="DKg9z21F"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2100.outbound.protection.outlook.com [40.107.21.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEDE83CA0
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535452; cv=fail; b=jcIJndZGYr8oO3BUUkI6/Oz8bg+Ac7xLRfTb34AX5T6B2Jqc6/0fpiQtwKxFNgDYn7zlpr/ki0TLwFe6xbch/U3rBkRrhX/yZKAwJyMNcoTyPbNp9B5vXF2YViFkDE8pFhYM/a6J8bXRTEvY5z1Y2UA8f436vNgAHdFnbCNQWFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535452; c=relaxed/simple;
	bh=LCxoHJKlvCzkg+gCcy6lxRcFLxAI3D2/dSRbrSLftd4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dd9K9fRdp3UKLZuwHA3QYrsdm8Sy6kmYPzz7hdZzec7KdG7kpvRMYlCNBfNVuAV9+GOMwjRodCmcfRSW9cYkqt3REuiHif3Qt6N6ZwaD7cMnSDNRGu8qvJSCLrQsqn//8igHzIoGgwabc0OPmLCjRxSz4Cf57fbGFZuz+vdnsp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kontron.com; spf=pass smtp.mailfrom=kontron.com; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=DKg9z21F; arc=fail smtp.client-ip=40.107.21.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kontron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSvmnflAz0lMqeGNaWGklVWSpcAaOi1FT9jIeh2SrPiJ0ekZM59ZMykAEc2XEd3tBGupxdVD9rPWxGUQn4cMoWnyqiRzB13108uQnJ0kFtw6Ni6dzEAxSCywz36/RiSkShgpOR/ZXmcaLWIwWyHC/veI3ntEZx/BBp1bGGNOyeVJzO7VysN4g0g9Uw2NrYq5ONmc18Dhu87tB2m2sSi29BPGxXEap0ECqSzD0uS1DzIK+COPntBuZ96EzA2611aA4sToBC74q3KYMubVZFUmuLVQdq+mgAp3roNkOmRfh8xXg/KBqHuSv0hM4BFHqrUILSpoUQg5VIN5lubWqrRfhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcXygmdCL1kMhs5XlsdmhMDfG+iyNyYT/HLrcPNSL4U=;
 b=PhPV1/MktiXuZRCUfw5swnQjvN6K+60m8u/UVvV9ucB89reOvRfa8IWTdRuAsHxJWAyX35O+RUnQtYS3wY6YzYHOOdQyVybILhr0Yv/SrOk4prVJkXIYvzZ1ZJHhi2O4hhf/e8ZYbkgGGq5blke+jAFeSJtDgXz/VK7yRHdqkWWzu9Rd229/+pWaG3QqZclKVmuwHtpJkSWyAYoVI7N3ZTSqMihAbxa9Nl5q3ZIQebEDFBcDYF0Bs8urAdUFWmerWGFhooKBYoyXo6QbnJHXybsIfpXoHi5QkUdNCySDgS6hato/dW/0EDuVWczvztH6o3t3is9DVwFLDS/6FU+DAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcXygmdCL1kMhs5XlsdmhMDfG+iyNyYT/HLrcPNSL4U=;
 b=DKg9z21F/+WT+gPhszFcT+YOYqAh1QnWqZvDjEXmKppLO3DIgPj4E+EsvpYyXjggpcau15c6G0t135BT3AzWpi98QZTo9fcFevCcc2cuILPLW0CaxkEEQcIcwoxWKWz/mNrOk0lTaFbFTIAy8PMgo+PMB4kMRYiRPtn4YxlFsI8=
Received: from AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:591::19)
 by GV1PR10MB5842.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:51::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Wed, 21 Feb
 2024 17:10:44 +0000
Received: from AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5208:477d:77da:84f8]) by AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5208:477d:77da:84f8%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 17:10:44 +0000
From: Michael Brunner <michael.brunner@kontron.com>
To: "lee.jones@linaro.org" <lee.jones@linaro.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>, "mibru@gmx.de" <mibru@gmx.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] mfd: kempld-core: don't replace resources provided by ACPI
Thread-Topic: [PATCH] mfd: kempld-core: don't replace resources provided by
 ACPI
Thread-Index: AQHaZOjnqjSdKUSjjUiE5C/QNxRHxA==
Date: Wed, 21 Feb 2024 17:10:44 +0000
Message-ID: <09855448430a5f090dbe09cbb269959a08881ee7.camel@kontron.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB7551:EE_|GV1PR10MB5842:EE_
x-ms-office365-filtering-correlation-id: de5f6482-278e-44b4-a019-08dc33000a2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RoeUgac9jm0GTRAiY+4p0XeJumm7/bv8NIWdnH8EASyWbmfA5oDaOP1yKMBKZiYw8XPK+g4ZjyrUurLBfnIucDDAI3uyVvnta+66A+0yq8kYBiSQ9pvvDU3tLMKlMkp8EP/mx15AI751k9lmhOyD1wviuXqfvmqWqLUVzN12A7nZIVVFXE9sIiFxV5kQTpVQV4ufP+SDBJzNSW8o0Y8rntprad2p/8fC0Kl3aOREmGse0eAaeQfJc8p+L8yw8FIVxKDoaEml0Q7POWMrs9t5sVOfPgj7XKTPvX2wQXnQBktVrlLXMCPGTYG0PrSuf+fPPtJFCYGGKsGgZp/ZK9oUpxRy3KQ7N2yMZB1of4knIsyJFrnKhwcDnB1QhmThXsW4p1J0NZwSeXysgJ/cHJjmZps1wX7OzTSngmU4t3lz/duAUkiUW/IFYZR/f0CBBO7RonsXMO2DXn0FrJfLmPcW1rHLUDb9JGYCjvfK6AnDBRSrx0faw2ABvvNvX/6Gr5Ei1kOKzAmcIIZcIK3rNwNJXyHfVXk2HBvBvXPHmr2/LA7fqf4q9JWlg2G1rwGOspymfmHl3tP/ARiZWD5KOZup3LEEeoawQxBFcx22EfUGErHT1QdFwkLHJ0WY9gSt5ZPm
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-15?Q?WIaCDyn598zJz5tLFojEiGjIzFfkRKTCLRKQhSrTEs/zr5NRrZyNA4TOc?=
 =?iso-8859-15?Q?KgEw44aOfOxsa451O4gCv9xsW/lnh8OD58JDfY0Pu7zLMFPN7q7aSX12N?=
 =?iso-8859-15?Q?zdHPJ5OjwJuxqO2zPBujnXiHPSX4/eYzySMW3Xm+npwsbtiI4RNqkHawL?=
 =?iso-8859-15?Q?gnQwYTjdHb7aeW4S9M+WsXIVWQmy0lXjNbEDNUNx17rotWUTysbVmpb2x?=
 =?iso-8859-15?Q?od/DCTxbWc63WCVMUqicLgynjLL3gxhyjEeDMPv8zXDTLw9t5hK1A8DaB?=
 =?iso-8859-15?Q?g0NLsNylVA1BoCHi7GWNF5yJf0VmjKP1W/9xtsUKg3eYrXKNriTa3Mqjg?=
 =?iso-8859-15?Q?2nFR/4oaalyDdqW2JhKiEi0UAmRgsYLmufwjGPm/MxpShOqu88xw52PcG?=
 =?iso-8859-15?Q?zPxEKN1OgCcfcrWwHrLz4ILV4w55tfFY0u9A5JSqppktqsyWMGip8z82g?=
 =?iso-8859-15?Q?7PIZ5N9Q+m28R+suSNnoPSt67xd1bSGNWOCBkdA4YghSr0JXZk/cNGalM?=
 =?iso-8859-15?Q?avvkoiu3sbfhCPxQiPE+qVtziyUlJ/BqEDzSpUymjXdhDaCwd3xYMoGO5?=
 =?iso-8859-15?Q?nPIFZBWQbgE1k/YObgwbQco3eWZ99HRI9+wIG5i9Q3ekOKvRYhlGQMumM?=
 =?iso-8859-15?Q?xvWDrlfEygqWR6W2lLg88Tp+d4vNQvjqaObsLylESlk/u2Vxon+uMpMFp?=
 =?iso-8859-15?Q?aoU1bvUWq52gxVMIKTEHuyntIkSUjzV0O7cgaLnN9hDp9/9M0GIXp6JvA?=
 =?iso-8859-15?Q?mjuGZbQ5sH5/hzqlZjSre5IJnMD8ZKGo4UiCoBLb50xz8YRWEWilVb8tp?=
 =?iso-8859-15?Q?3D4p/6fxUYwRywa96zZH7NikO7PmbtSaJ/U/vCOGlwaRPy8M/Xm5EB6Hv?=
 =?iso-8859-15?Q?IzMOtixVg2L7yHWGyn3+n+6MasBsvArx/Ge91A6d/dElOHhup+FaUxHIB?=
 =?iso-8859-15?Q?uBDDSv8gCOoztjjqj+lhkqg2w37mI2wS4fzM6rOXEfC2CJRBY4k2r+RWt?=
 =?iso-8859-15?Q?lSTzpwHUKdWN1dlyk67nF+pR98PXHlJxkOTb+lelNAZBUrAtuyuS2RRLH?=
 =?iso-8859-15?Q?SoIzSaLPNuo6zR3Y+PmLq4VhP1TbXtEgIFF0Q/FUNAPWqTVPLMQiVXWAl?=
 =?iso-8859-15?Q?C6clsQLRaAH2L8yP8CtXKzMtWDxoDTiXriDsYgNxyxYpLsyoZODIzmSJD?=
 =?iso-8859-15?Q?Hic6xD6gcmeO9+NpOj2lyphNI+KViqmmTi/j+LC8AmNa3ha0+N0xZiYCR?=
 =?iso-8859-15?Q?itP5hAzrHoiy26m55NzVyy1TOIY2a2GuciXAQjy+ZWNfhhpOfV6m/Uc9t?=
 =?iso-8859-15?Q?4SXdCEXE8vZiMswBq8rVQRomv7rF8FRwEqigJ/5o+HXWb4fN3kAS7oIAI?=
 =?iso-8859-15?Q?e62CoB0aot9apeigTeYeKmyqGqownafyIOga09+FVs7OYDP4OH0pwN2BW?=
 =?iso-8859-15?Q?UVPQWWnW59NOo0df/cGQoxH608j3sCcViU8EcSZwsENvbE8xR6uyY3wQ9?=
 =?iso-8859-15?Q?mSn2pA/cH6djVHpCgCFOw9VfBsfCjcIxFA3qGAn7Rp1jYKAb0QNTye5ua?=
 =?iso-8859-15?Q?1dQIQZjx5TD8ygc3loJELUSoxP9El3gCnG/VlCHClHdIZXCCKtV0wp5bP?=
 =?iso-8859-15?Q?6rzBma1r60Bdic7mrIM1ZF3AHk1bOU365DK07PnRa7rIEuGeyxnP0DkCq?=
 =?iso-8859-15?Q?DbyzD2+pvSCLlTzm2FVdM3d+HShNk1+NB3GWV1Ant9SJsJc=3D?=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <1CD61F589FD32F4BA1D650EDB7C5F110@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: de5f6482-278e-44b4-a019-08dc33000a2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 17:10:44.2915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fvIm5ywXNH9DeOHGHdYtFl+1aG9ww7E9oreOX9PjCF6h9ZTAV9v/+SfXr9WykbbquRPOqgOaHdVdbwAZllGVxmZnRlxbxA/+zTyPn1vKzmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5842

The current implementation to retrieve ACPI resources is faulty
and may cause issues that even can lead to non-booting systems.

When adding data from an ACPI device, the resources are already
assigned to the platform device. Therefore there is no need to
retrieve the resource list from ACPI and manually assign it to
the platform device. Also there shouldn't be any BIOS in the wild
anymore, that does not have resources added to the KEMPLD ACPI
data.

In particular this fixes an issue where the retrieval of the
resource list using /proc/ioports is disturbed and does not list
the assigned resource for the kempld device or even no resources
at all.
On some distributions this also leads to problems during system
initialization (e.g. with udev) and causes the system to not
boot at all.

I have reproduced the issue with the following kernel versions:
    5.10.209
    5.15.148
    6.1.25
    6.6.17
    6.7.5
    6.8-rc5

The patch applies to all of those versions and seems to resolve
the issue.

Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
---
 drivers/mfd/kempld-core.c | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index 67af36a38913..5557f023a173 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -428,50 +428,13 @@ static int kempld_detect_device(struct kempld_device_=
data *pld)
 #ifdef CONFIG_ACPI
 static int kempld_get_acpi_data(struct platform_device *pdev)
 {
-	struct list_head resource_list;
-	struct resource *resources;
-	struct resource_entry *rentry;
 	struct device *dev =3D &pdev->dev;
-	struct acpi_device *acpi_dev =3D ACPI_COMPANION(dev);
 	const struct kempld_platform_data *pdata;
 	int ret;
-	int count;
=20
 	pdata =3D acpi_device_get_match_data(dev);
 	ret =3D platform_device_add_data(pdev, pdata,
 				       sizeof(struct kempld_platform_data));
-	if (ret)
-		return ret;
-
-	INIT_LIST_HEAD(&resource_list);
-	ret =3D acpi_dev_get_resources(acpi_dev, &resource_list, NULL, NULL);
-	if (ret < 0)
-		goto out;
-
-	count =3D ret;
-
-	if (count =3D=3D 0) {
-		ret =3D platform_device_add_resources(pdev, pdata->ioresource, 1);
-		goto out;
-	}
-
-	resources =3D devm_kcalloc(&acpi_dev->dev, count, sizeof(*resources),
-				 GFP_KERNEL);
-	if (!resources) {
-		ret =3D -ENOMEM;
-		goto out;
-	}
-
-	count =3D 0;
-	list_for_each_entry(rentry, &resource_list, node) {
-		memcpy(&resources[count], rentry->res,
-		       sizeof(*resources));
-		count++;
-	}
-	ret =3D platform_device_add_resources(pdev, resources, count);
-
-out:
-	acpi_dev_free_resource_list(&resource_list);
=20
 	return ret;
 }
--=20
2.25.1


